


using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.Script;
using System.ComponentModel;
using System.Xml;
using System.IO;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Globalization;
using AjaxControlToolkit;
using System.Text;
using System.Web.Script.Serialization;
using System.Diagnostics;

#region [ Resources ]

[assembly: System.Web.UI.WebResource("Tabs.Tabs.js", "application/x-javascript")]
[assembly: System.Web.UI.WebResource("Tabs.Tabs.debug.js", "application/x-javascript")]
[assembly: WebResource("Tabs.Tabs_resource.css", "text/css", PerformSubstitution = true)]
[assembly: WebResource("Tabs.tab-line.gif", "image/gif")]
// horizontal top (default) images
[assembly: WebResource("Tabs.tab.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-left.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-right.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-hover.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-hover-left.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-hover-right.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-active.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-active-left.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-active-right.gif", "image/gif")]
// horizontal bottom images
[assembly: WebResource("Tabs.tab-bottom.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-bottom-left.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-bottom-right.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-bottom-hover.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-bottom-hover-left.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-bottom-hover-right.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-bottom-active.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-bottom-active-left.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-bottom-active-right.gif", "image/gif")]
// vertical left images
[assembly: WebResource("Tabs.tab-verticalleft.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-left-verticalleft.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-right-verticalleft.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-hover-verticalleft.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-hover-left-verticalleft.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-hover-right-verticalleft.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-active-verticalleft.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-active-left-verticalleft.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-active-right-verticalleft.gif", "image/gif")]
// vertical right images
[assembly: WebResource("Tabs.tab-verticalright.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-left-verticalright.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-right-verticalright.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-hover-verticalright.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-hover-left-verticalright.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-hover-right-verticalright.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-active-verticalright.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-active-left-verticalright.gif", "image/gif")]
[assembly: WebResource("Tabs.tab-active-right-verticalright.gif", "image/gif")]

#endregion

namespace AjaxControlToolkit {
    [Designer("AjaxControlToolkit.TabContainerDesigner, AjaxControlToolkit")]
    [ParseChildren(typeof(TabPanel))]
    [RequiredScript(typeof(CommonToolkitScripts))]
    [ClientCssResource("Tabs.Tabs_resource.css")]
    [ClientScriptResource("Sys.Extended.UI.TabContainer", "Tabs.Tabs.js")]
    [System.Drawing.ToolboxBitmap(typeof(TabContainer), "Tabs.Tabs.ico")]
    public class TabContainer : ScriptControlBase, IPostBackEventHandler {
        #region [ Static Fields ]

        private static readonly object EventActiveTabChanged = new object();

        #endregion

        #region [ Fields ]

        private int _activeTabIndex = -1;
        private int _cachedActiveTabIndex = -1;
        private bool _initialized;
        private bool _autoPostBack;
        private TabStripPlacement _tabStripPlacement;
        private bool _useVerticalStripPlacement;
        private Unit _verticalStripWidth = new Unit(120, UnitType.Pixel);
        private bool _onDemand;

        #endregion

        #region [ Constructors ]

        /// <summary>
        /// Initializes a new TabContainer
        /// </summary>
        public TabContainer()
            : base(true, HtmlTextWriterTag.Div) {
        }

        #endregion

        #region [ Events ]

        [Category("Behavior")]
        public event EventHandler ActiveTabChanged {
            add { Events.AddHandler(EventActiveTabChanged, value); }
            remove { Events.RemoveHandler(EventActiveTabChanged, value); }
        }

        #endregion

        #region [ Properties ]

        [DefaultValue(-1)]
        [Browsable(false)]
        [EditorBrowsable(EditorBrowsableState.Never)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        [Category("Behavior")]
        [ExtenderControlProperty]
        [ClientPropertyName("activeTabIndex")]
        public int ActiveTabIndexForClient {
            get {
                int counter = ActiveTabIndex;
                for (int i = 0; i <= ActiveTabIndex && i < Tabs.Count; i++) {
                    if (!Tabs[i].Visible) counter--;
                }
                if (counter < 0) counter = 0;
                return counter;
            }
        }

        [EditorBrowsable(EditorBrowsableState.Never)]
        public bool ShouldSerializeActiveTabIndexForClient() {
            return IsRenderingScript;
        }

        [DefaultValue(-1)]
        [Category("Behavior")]
        public virtual int ActiveTabIndex {
            get {
                if (_cachedActiveTabIndex > -1) {
                    return _cachedActiveTabIndex;
                }
                if (Tabs.Count == 0) {
                    return -1;
                }
                return _activeTabIndex;
            }
            set {
                if (value < -1) throw new ArgumentOutOfRangeException("value");
                if (Tabs.Count == 0 && !_initialized) {
                    _cachedActiveTabIndex = value;
                } else {
                    if (ActiveTabIndex != value) {
                        if (ActiveTabIndex != -1 && ActiveTabIndex < Tabs.Count) {
                            Tabs[ActiveTabIndex].Active = false;
                        }
                        if (value >= Tabs.Count) {
                            _activeTabIndex = Tabs.Count - 1;
                            _cachedActiveTabIndex = value;
                        } else {
                            _activeTabIndex = value;
                            _cachedActiveTabIndex = -1;
                        }
                        if (ActiveTabIndex != -1 && ActiveTabIndex < Tabs.Count) {
                            Tabs[ActiveTabIndex].Active = true;
                        }
                    }
                }
            }
        }

        [Browsable(false)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public TabPanelCollection Tabs {
            get { return (TabPanelCollection)Controls; }
        }

        [Browsable(false)]
        [DesignerSerializationVisibility(DesignerSerializationVisibility.Hidden)]
        public TabPanel ActiveTab {
            get {
                int i = ActiveTabIndex;
                if (i < 0 || i >= Tabs.Count) {
                    return null;
                }
                EnsureActiveTab();
                return Tabs[i];
            }
            set {
                int i = Tabs.IndexOf(value);
                if (i < 0) {
                    throw new ArgumentOutOfRangeException("value");
                }
                ActiveTabIndex = i;
            }
        }

        [DefaultValue(false)]
        [Category("Behavior")]
        public bool AutoPostBack {
            get {
                return _autoPostBack;
            }
            set {
                _autoPostBack = value;
            }
        }

        [DefaultValue(typeof(Unit), "")]
        [Category("Appearance")]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Globalization", "CA1303:DoNotPassLiteralsAsLocalizedParameters", Justification = "Assembly is not localized")]
        public override Unit Height {
            get { return base.Height; }
            set {
                //if (!value.IsEmpty && value.Type != UnitType.Pixel)
                //{
                //    throw new ArgumentOutOfRangeException("value", "Height must be set in pixels only, or Empty.");
                //}
                base.Height = value;
            }
        }

        [DefaultValue(typeof(Unit), "")]
        [Category("Appearance")]
        public override Unit Width {
            get { return base.Width; }
            set { base.Width = value; }
        }

        [DefaultValue("ajax__tab_xp")]
        [Category("Appearance")]
        public override string CssClass {
            get { return base.CssClass; }
            set { base.CssClass = value; }
        }

        [DefaultValue(ScrollBars.None)]
        [Category("Behavior")]
        [ExtenderControlProperty]
        [ClientPropertyName("scrollBars")]
        public ScrollBars ScrollBars {
            get { return (ScrollBars)(ViewState["ScrollBars"] ?? ScrollBars.None); }
            set { ViewState["ScrollBars"] = value; }
        }

        [DefaultValue(TabStripPlacement.Top)]
        [Category("Appearance")]
        public TabStripPlacement TabStripPlacement {
            get { return _tabStripPlacement; }
            set { _tabStripPlacement = value; }
        }

        [DefaultValue("")]
        [Category("Behavior")]
        [ExtenderControlEvent]
        [ClientPropertyName("activeTabChanged")]
        public string OnClientActiveTabChanged {
            get { return (string)(ViewState["OnClientActiveTabChanged"] ?? string.Empty); }
            set { ViewState["OnClientActiveTabChanged"] = value; }
        }

        /// <summary>
        /// To enable AutoPostBack, we need to call an ASP.NET script method with the UniqueId
        /// on the client side.  To do this, we just use this property as the one to serialize and
        /// alias it's name.
        /// </summary>
        [ExtenderControlProperty]
        [ClientPropertyName("autoPostBackId")]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1706:ShortAcronymsShouldBeUppercase", MessageId = "Member", Justification = "Following ASP.NET naming conventions...")]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA1801:ReviewUnusedParameters", MessageId = "value", Justification = "Required for serialization")]
        public new string UniqueID {
            get {
                return base.UniqueID;
            }
            set {
                // need to add a setter for serialization to work properly.
            }
        }

        // has to be public so reflection can get at it...
        // this method determines if the UniqueID property will
        // be code generated.
        [EditorBrowsable(EditorBrowsableState.Never)]
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Naming", "CA1706:ShortAcronymsShouldBeUppercase", MessageId = "Member", Justification = "Following ASP.NET naming conventions...")]
        public bool ShouldSerializeUniqueID() {
            return IsRenderingScript && AutoPostBack;
        }

        /// <summary>
        /// Change tab header placement verticaly
        /// </summary>
        [Description("Change tab header placement vertically when value set to true")]
        [DefaultValue(false)]
        [Category("Appearance")]
        public bool UseVerticalStripPlacement {
            get { return _useVerticalStripPlacement; }
            set { _useVerticalStripPlacement = value; }
        }

        /// <summary>
        /// Set width of tab strips when UseVerticalStripPlacement is set to true
        /// </summary>
        [Description("Set width of tab strips when UseVerticalStripPlacement is set to true. Size must be in pixel")]
        [DefaultValue(typeof(Unit), "120px")]
        [Category("Appearance")]
        public Unit VerticalStripWidth {
            get { return _verticalStripWidth; }
            set {
                if (!value.IsEmpty && value.Type != UnitType.Pixel) {
                    throw new ArgumentOutOfRangeException("value", "VerticalStripWidth must be set in pixels only, or Empty.");
                }
                _verticalStripWidth = value;
            }
        }

        /// <summary>
        /// Load tab content when it's activated
        /// </summary>
        [DefaultValue(false)]
        [Category("Behavior")]
        public bool OnDemand {
            get {
                return _onDemand;
            }
            set {
                _onDemand = value;
            }
        }
        #endregion

        #region [ Methods ]

        protected override void OnInit(EventArgs e) {
            base.OnInit(e);

            Page.RegisterRequiresControlState(this);

            _initialized = true;
            if (_cachedActiveTabIndex > -1) {
                ActiveTabIndex = _cachedActiveTabIndex;
                if (ActiveTabIndex < Tabs.Count) {
                    Tabs[ActiveTabIndex].Active = true;
                }
            } else if (Tabs.Count > 0) {
                ActiveTabIndex = 0;
            }
        }

        protected virtual void OnActiveTabChanged(EventArgs e) {
            EventHandler eh = Events[EventActiveTabChanged] as EventHandler;
            if (eh != null) {
                eh(this, e);
            }
        }

        protected override void AddParsedSubObject(object obj) {
            TabPanel objTabPanel = obj as TabPanel;
            if (null != objTabPanel) {
                Controls.Add(objTabPanel);
            } else if (!(obj is LiteralControl)) {
                throw new HttpException(string.Format(CultureInfo.CurrentCulture, "TabContainer cannot have children of type '{0}'.", obj.GetType()));
            }
        }

        protected override void AddedControl(Control control, int index) {
            ((TabPanel)control).SetOwner(this);
            base.AddedControl(control, index);
        }

        protected override void RemovedControl(Control control) {
            TabPanel controlTabPanel = control as TabPanel;
            if (control != null && controlTabPanel.Active && ActiveTabIndex < Tabs.Count) {
                EnsureActiveTab();
            }
            controlTabPanel.SetOwner(null);
            base.RemovedControl(control);
        }

        protected override ControlCollection CreateControlCollection() {
            return new TabPanelCollection(this);
        }

        protected override Style CreateControlStyle() {
            TabContainerStyle style = new TabContainerStyle(ViewState);
            style.CssClass = "ajax__tab_xp";
            return style;
        }

        private int getServerActiveTabIndex(int clientActiveTabIndex) {
            int counter = -1;
            int result = clientActiveTabIndex;
            for (int i = 0; i < Tabs.Count; i++) {
                if (Tabs[i].Visible) counter++;
                if (counter == clientActiveTabIndex) {
                    result = i;
                    break;
                }
            }
            return result;
        }

        protected override void LoadClientState(string clientState) {
            Dictionary<string, object> state = (Dictionary<string, object>)new JavaScriptSerializer().DeserializeObject(clientState);
            if (state != null) {
                ActiveTabIndex = (int)state["ActiveTabIndex"];
                ActiveTabIndex = getServerActiveTabIndex(ActiveTabIndex);

                object[] tabState = (object[])state["TabState"];
                for (int i = 0; i < tabState.Length; i++) {
                    int j = getServerActiveTabIndex(i);
                    if (j < Tabs.Count) Tabs[j].Enabled = (bool)tabState[i];
                }
            }
        }

        protected override string SaveClientState() {
            Dictionary<string, object> state = new Dictionary<string, object>();
            state["ActiveTabIndex"] = ActiveTabIndex;

            List<object> tabState = new List<object>();
            foreach (TabPanel panel in Tabs) {
                tabState.Add(panel.Enabled);
            }
            state["TabState"] = tabState;
            return new JavaScriptSerializer().Serialize(state);
        }

        protected override void LoadControlState(object savedState) {
            Pair p = (Pair)savedState;
            if (p != null) {
                base.LoadControlState(p.First);
                ActiveTabIndex = (int)p.Second;
            } else {
                base.LoadControlState(null);
            }
        }

        protected override object SaveControlState() {
            Pair p = new Pair();
            p.First = base.SaveControlState();
            p.Second = ActiveTabIndex;
            if (p.First == null && p.Second == null) {
                return null;
            } else {
                return p;
            }
        }

        protected override void AddAttributesToRender(HtmlTextWriter writer) {
            Style.Remove(HtmlTextWriterStyle.Visibility);
            if (!ControlStyleCreated)
                writer.AddAttribute(HtmlTextWriterAttribute.Class, "ajax__tab_xp");
            if (_useVerticalStripPlacement)
                writer.AddStyleAttribute(HtmlTextWriterStyle.Display, "block");
            if (!Height.IsEmpty && Height.Type == UnitType.Percentage)
                writer.AddStyleAttribute(HtmlTextWriterStyle.Height, Height.ToString());

            base.AddAttributesToRender(writer);
            writer.AddStyleAttribute(HtmlTextWriterStyle.Visibility, "hidden");
        }

        protected override void RenderContents(HtmlTextWriter writer) {
            //base.Render(writer);
            Page.VerifyRenderingInServerForm(this);

            if (_tabStripPlacement == TabStripPlacement.Top
                || _tabStripPlacement == TabStripPlacement.TopRight
                || (_tabStripPlacement == TabStripPlacement.Bottom && _useVerticalStripPlacement)
                || (_tabStripPlacement == TabStripPlacement.BottomRight && _useVerticalStripPlacement)
                )
                RenderHeader(writer);

            if (!Height.IsEmpty)
                writer.AddStyleAttribute(HtmlTextWriterStyle.Height, Height.ToString());
            else
                writer.AddStyleAttribute(HtmlTextWriterStyle.Height, "100%");

            writer.AddAttribute(HtmlTextWriterAttribute.Id, ClientID + "_body");
            writer.AddAttribute(HtmlTextWriterAttribute.Class, "ajax__tab_body" + GetSuffixTabStripPlacementCss());
            writer.AddStyleAttribute(HtmlTextWriterStyle.Display, "block");
            writer.RenderBeginTag(HtmlTextWriterTag.Div);
            RenderChildren(writer);
            writer.RenderEndTag();

            if ((_tabStripPlacement == TabStripPlacement.Bottom && !_useVerticalStripPlacement)
                || _tabStripPlacement == TabStripPlacement.BottomRight && !_useVerticalStripPlacement)
                RenderHeader(writer);
        }

        protected virtual void RenderHeader(HtmlTextWriter writer) {
            writer.AddAttribute(HtmlTextWriterAttribute.Id, ClientID + "_header");
            writer.AddAttribute(HtmlTextWriterAttribute.Class, "ajax__tab_header" + GetSuffixTabStripPlacementCss());
            if (_tabStripPlacement == TabStripPlacement.BottomRight ||
                _tabStripPlacement == TabStripPlacement.TopRight)
                writer.AddStyleAttribute(HtmlTextWriterStyle.Direction, "rtl");

            if (_useVerticalStripPlacement) {
                writer.AddStyleAttribute(HtmlTextWriterStyle.Display, "block");
                if (_tabStripPlacement == TabStripPlacement.Bottom || _tabStripPlacement == TabStripPlacement.Top) {
                    writer.AddAttribute(HtmlTextWriterAttribute.Style, "float:left");
                } else {
                    writer.AddAttribute(HtmlTextWriterAttribute.Style, "float:right");
                }
                writer.AddStyleAttribute(HtmlTextWriterStyle.Width, _verticalStripWidth.ToString());
            }

            writer.RenderBeginTag(HtmlTextWriterTag.Div);

            if (_tabStripPlacement == TabStripPlacement.Bottom || _tabStripPlacement == TabStripPlacement.BottomRight)
                RenderSpannerForVerticalTabs(writer);

            if (!_useVerticalStripPlacement &&
                (_tabStripPlacement == TabStripPlacement.BottomRight
                || _tabStripPlacement == TabStripPlacement.TopRight)) {
                // reverse tab order placement
                var tabs = Tabs.Count;
                for (int i = tabs - 1; i >= 0; i--) {
                    var panel = Tabs[i];
                    if (panel.Visible) {
                        panel.RenderHeader(writer);
                    }
                }
            } else {
                foreach (TabPanel panel in Tabs) {
                    if (panel.Visible) {
                        panel.RenderHeader(writer);
                    }
                }
            }

            if (_tabStripPlacement == TabStripPlacement.Top || _tabStripPlacement == TabStripPlacement.TopRight)
                RenderSpannerForVerticalTabs(writer);

            writer.RenderEndTag();
        }

        private void RenderSpannerForVerticalTabs(HtmlTextWriter writer) {
            if (_useVerticalStripPlacement) {
                writer.AddAttribute(HtmlTextWriterAttribute.Id, ClientID + "_headerSpannerHeight");
                writer.AddStyleAttribute(HtmlTextWriterStyle.Display, "block");
                writer.RenderBeginTag(HtmlTextWriterTag.Div);
                writer.RenderEndTag();
            }
        }

        private string GetSuffixTabStripPlacementCss() {
            var tabStripPlacementCss = "";
            if (_useVerticalStripPlacement) {
                tabStripPlacementCss += "_vertical";
                switch (_tabStripPlacement) {
                    case TabStripPlacement.Top:
                    case TabStripPlacement.Bottom:
                        tabStripPlacementCss += "left";
                        break;
                    case TabStripPlacement.TopRight:
                    case TabStripPlacement.BottomRight:
                        tabStripPlacementCss += "right";
                        break;
                }
            } else {
                switch (_tabStripPlacement) {
                    case TabStripPlacement.Bottom:
                    case TabStripPlacement.BottomRight:
                        tabStripPlacementCss = "_bottom";
                        break;
                }
            }
            return tabStripPlacementCss;
        }

        protected override bool LoadPostData(string postDataKey, NameValueCollection postCollection) {
            int tabIndex = ActiveTabIndex;
            bool result = base.LoadPostData(postDataKey, postCollection);
            if (ActiveTabIndex == 0 || tabIndex != ActiveTabIndex) {
                return true;
            }
            return result;
        }

        protected override void RaisePostDataChangedEvent() {
            OnActiveTabChanged(EventArgs.Empty);
        }

        private void EnsureActiveTab() {
            if (_activeTabIndex < 0 || _activeTabIndex >= Tabs.Count) {
                _activeTabIndex = 0;
            }

            for (int i = 0; i < Tabs.Count; i++) {
                if (i == ActiveTabIndex) {
                    Tabs[i].Active = true;
                } else {
                    Tabs[i].Active = false;
                }
            }
        }

        #endregion

        #region [ TabContainerStyle ]

        private sealed class TabContainerStyle : Style {
            public TabContainerStyle(StateBag state)
                : base(state) {
            }

            protected override void FillStyleAttributes(CssStyleCollection attributes, IUrlResolutionService urlResolver) {
                base.FillStyleAttributes(attributes, urlResolver);

                attributes.Remove(HtmlTextWriterStyle.Height);
                // commented below line to fix the issue #25821
                //attributes.Remove(HtmlTextWriterStyle.BackgroundColor);
                attributes.Remove(HtmlTextWriterStyle.BackgroundImage);
            }
        }

        #endregion

        #region IPostBackEventHandler Members

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Design", "CA1033:InterfaceMethodsShouldBeCallableByChildTypes", Justification = "Called by ASP.NET infrastructure")]
        void IPostBackEventHandler.RaisePostBackEvent(string eventArgument) {
            if (eventArgument.StartsWith("activeTabChanged", StringComparison.Ordinal)) {
                // change the active tab.
                //
                int parseIndex = eventArgument.IndexOf(":", StringComparison.Ordinal);
                Debug.Assert(parseIndex != -1, "Expected new active tab index!");
                if (parseIndex != -1 && Int32.TryParse(eventArgument.Substring(parseIndex + 1), out parseIndex)) {
                    parseIndex = getServerActiveTabIndex(parseIndex);
                    if (parseIndex != ActiveTabIndex) {
                        ActiveTabIndex = parseIndex;
                        OnActiveTabChanged(EventArgs.Empty);
                    }
                }
            }
        }

        #endregion

        protected override void DescribeComponent(ScriptComponentDescriptor descriptor) {
            base.DescribeComponent(descriptor);
            descriptor.AddProperty("tabStripPlacement", this.TabStripPlacement);
            descriptor.AddProperty("useVerticalStripPlacement", this.UseVerticalStripPlacement);
            descriptor.AddProperty("onDemand", this.OnDemand);
        }
    }
}
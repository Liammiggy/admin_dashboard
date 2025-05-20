import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  final Function(String) onSelectModule;
  final bool isSidebarOpen;

  const Sidebar({
    required this.onSelectModule,
    required this.isSidebarOpen,
    super.key,
  });

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String _activeModule = "Dashboard";
  bool _manageUsersExpanded = false;
  bool _membershipExpanded = false;
  bool _pastorExpanded = false;
  bool _churchExpanded = false;
  bool _organizationExpanded = false;
  bool _claimsRequestExpanded = false;
  bool _contributionRequestExpanded = false;

  OverlayEntry? _overlayEntry;
  final GlobalKey _logoKey = GlobalKey();
  final double _collapsedWidth = 70.0;
  final double _expandedWidth = 250.0;
  final double _iconSize = 24.0;

  @override
  void didUpdateWidget(covariant Sidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.isSidebarOpen) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  void _showPopupMenu(BuildContext context, Offset position, Widget menu) {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    _overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            left: position.dx,
            top: position.dy,
            child: Material(
              elevation: 8.0,
              borderRadius: BorderRadius.circular(5),
              color: const Color.fromARGB(255, 30, 30, 45),
              child: menu,
            ),
          ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _handleModuleTap(String module) {
    setState(() {
      _activeModule = module;
    });
    widget.onSelectModule(module);
    if (!widget.isSidebarOpen && _overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  void _handleSubModuleTap(String title, String route) {
    setState(() {
      _activeModule = title;
    });
    widget.onSelectModule(route);
    if (!widget.isSidebarOpen && _overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  Widget _buildPopupSubMenu(List<Widget> subModules) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: subModules,
    );
  }

  Widget _buildModule(String title, IconData icon, [List<Widget>? subModules]) {
    return MouseRegion(
      onEnter: (_) {
        setState(() => _activeModule = title);
        if (!widget.isSidebarOpen &&
            subModules != null &&
            subModules.isNotEmpty &&
            _logoKey.currentContext != null) {
          final RenderBox logoRenderBox =
              _logoKey.currentContext!.findRenderObject() as RenderBox;
          final RenderBox? renderBox =
              _logoKey.currentContext?.findRenderObject() as RenderBox?;
          Offset logoPosition = Offset.zero;
          if (renderBox != null) {
            logoPosition = logoRenderBox.localToGlobal(Offset.zero);
          }
          double topOffset =
              logoPosition.dy + (renderBox?.size.height ?? _iconSize);
          _showPopupMenu(
            context,
            Offset(logoPosition.dx + _collapsedWidth, topOffset - _iconSize),
            _buildPopupSubMenu(subModules),
          );
        }
      },
      onExit: (_) {
        setState(() => _activeModule = "");
        if (!widget.isSidebarOpen && _overlayEntry != null) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (_activeModule == "") {
              if (_overlayEntry != null) {
                // Check if it's still there
                _overlayEntry?.remove();
                _overlayEntry = null;
              }
            }
          });
        }
      },
      child: Material(
        color: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color:
                _activeModule == title
                    ? const Color.fromRGBO(67, 94, 190, 1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: InkWell(
            onTap: () => _handleModuleTap(title),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Icon(icon, color: Colors.white70, size: _iconSize),
                  ),
                  if (widget.isSidebarOpen)
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color:
                              _activeModule == title
                                  ? const Color.fromARGB(255, 220, 220, 220)
                                  : Colors.white,
                          fontWeight:
                              _activeModule == title
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                        ),
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubModuleItem(String title, String route) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () => _handleSubModuleTap(title, route),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white70,
              backgroundColor:
                  _activeModule == title
                      ? const Color.fromRGBO(67, 94, 190, 1)
                      : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildManageUsersModule() {
    List<Widget> subModules = [
      _buildSubModuleItem("User List", "UserList"),
      _buildSubModuleItem("New User", "manage_user"),
      _buildSubModuleItem("Access Role", "access"),
    ];
    return MouseRegion(
      onEnter: (_) {
        setState(() => _activeModule = "Manage Users");
        if (!widget.isSidebarOpen && _logoKey.currentContext != null) {
          final RenderBox logoRenderBox =
              _logoKey.currentContext!.findRenderObject() as RenderBox;
          final RenderBox? renderBox =
              _logoKey.currentContext?.findRenderObject() as RenderBox?;
          Offset logoPosition = Offset.zero;
          if (renderBox != null) {
            logoPosition = logoRenderBox.localToGlobal(Offset.zero);
          }
          double topOffset =
              logoPosition.dy + (renderBox?.size.height ?? _iconSize);
          _showPopupMenu(
            context,
            Offset(logoPosition.dx + _collapsedWidth, topOffset - _iconSize),
            _buildPopupSubMenu(subModules),
          );
        }
      },
      onExit: (_) {
        setState(() => _activeModule = "");
        if (!widget.isSidebarOpen && _overlayEntry != null) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (_activeModule == "") {
              if (_overlayEntry != null) {
                // Check if it's still there
                _overlayEntry?.remove();
                _overlayEntry = null;
              }
            }
          });
        }
      },
      child: Material(
        color:
            _activeModule == "Manage Users"
                ? const Color.fromRGBO(67, 94, 190, 1)
                : Colors.transparent,
        child: ExpansionTile(
          leading: Icon(Icons.person, color: Colors.white70, size: _iconSize),
          title: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: widget.isSidebarOpen ? 1 : 0,
            child: const Text(
              "Manage Users",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          initiallyExpanded: _manageUsersExpanded,
          onExpansionChanged:
              (expanded) => setState(() => _manageUsersExpanded = expanded),
          children: widget.isSidebarOpen ? subModules : [],
        ),
      ),
    );
  }

  Widget _buildManageMembers() {
    List<Widget> subModules = [
      _buildSubModuleItem("Member Lists", "memberlist"),
      _buildSubModuleItem("Add Member", "members"),
      _buildSubModuleItem("Bulk Upload", "bulkfileupload"),
    ];
    return MouseRegion(
      onEnter: (_) {
        setState(() => _activeModule = "Membership");
        if (!widget.isSidebarOpen && _logoKey.currentContext != null) {
          final RenderBox logoRenderBox =
              _logoKey.currentContext!.findRenderObject() as RenderBox;
          final RenderBox? renderBox =
              _logoKey.currentContext?.findRenderObject() as RenderBox?;
          Offset logoPosition = Offset.zero;
          if (renderBox != null) {
            logoPosition = logoRenderBox.localToGlobal(Offset.zero);
          }
          double topOffset =
              logoPosition.dy + (renderBox?.size.height ?? _iconSize);
          _showPopupMenu(
            context,
            Offset(logoPosition.dx + _collapsedWidth, topOffset - _iconSize),
            _buildPopupSubMenu(subModules),
          );
        }
      },
      onExit: (_) {
        setState(() => _activeModule = "");
        if (!widget.isSidebarOpen && _overlayEntry != null) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (_activeModule == "") {
              if (_overlayEntry != null) {
                //check
                _overlayEntry?.remove();
                _overlayEntry = null;
              }
            }
          });
        }
      },
      child: Material(
        color:
            _activeModule == "Membership"
                ? const Color.fromRGBO(67, 94, 190, 1)
                : Colors.transparent,
        child: ExpansionTile(
          leading: Icon(
            Icons.group_work,
            color: Colors.white70,
            size: _iconSize,
          ),
          title: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: widget.isSidebarOpen ? 1 : 0,
            child: const Text(
              "Membership",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          initiallyExpanded: _membershipExpanded,
          onExpansionChanged:
              (expanded) => setState(() => _membershipExpanded = expanded),
          children: widget.isSidebarOpen ? subModules : [],
        ),
      ),
    );
  }

  Widget _buildPastorModule() {
    List<Widget> subModules = [
      _buildSubModuleItem("Pastor List", "pastorlist"),
      _buildSubModuleItem("New Pastor", "add_pastor"),
    ];
    return MouseRegion(
      onEnter: (_) {
        setState(() => _activeModule = "Pastor");
        if (!widget.isSidebarOpen && _logoKey.currentContext != null) {
          final RenderBox logoRenderBox =
              _logoKey.currentContext!.findRenderObject() as RenderBox;
          final RenderBox? renderBox =
              _logoKey.currentContext?.findRenderObject() as RenderBox?;
          Offset logoPosition = Offset.zero;
          if (renderBox != null) {
            logoPosition = logoRenderBox.localToGlobal(Offset.zero);
          }
          double topOffset =
              logoPosition.dy + (renderBox?.size.height ?? _iconSize);
          _showPopupMenu(
            context,
            Offset(logoPosition.dx + _collapsedWidth, topOffset - _iconSize),
            _buildPopupSubMenu(subModules),
          );
        }
      },
      onExit: (_) {
        setState(() => _activeModule = "");
        if (!widget.isSidebarOpen && _overlayEntry != null) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (_activeModule == "") {
              if (_overlayEntry != null) {
                //check
                _overlayEntry?.remove();
                _overlayEntry = null;
              }
            }
          });
        }
      },
      child: Material(
        color:
            _activeModule == "Pastor"
                ? const Color.fromRGBO(67, 94, 190, 1)
                : Colors.transparent,
        child: ExpansionTile(
          leading: Icon(
            Icons.volunteer_activism,
            color: Colors.white70,
            size: _iconSize,
          ),
          title: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: widget.isSidebarOpen ? 1 : 0,
            child: const Text(
              "Pastor",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          initiallyExpanded: _pastorExpanded,
          onExpansionChanged:
              (expanded) => setState(() => _pastorExpanded = expanded),
          children: widget.isSidebarOpen ? subModules : [],
        ),
      ),
    );
  }

  Widget _buildChurchModule() {
    List<Widget> subModules = [
      _buildSubModuleItem("Church List", "churchlist"),
      _buildSubModuleItem("New Church", "add_church"),
    ];
    return MouseRegion(
      onEnter: (_) {
        setState(() => _activeModule = "Churchs");
        if (!widget.isSidebarOpen && _logoKey.currentContext != null) {
          final RenderBox logoRenderBox =
              _logoKey.currentContext!.findRenderObject() as RenderBox;
          final RenderBox? renderBox =
              _logoKey.currentContext?.findRenderObject() as RenderBox?;
          Offset logoPosition = Offset.zero;
          if (renderBox != null) {
            logoPosition = logoRenderBox.localToGlobal(Offset.zero);
          }
          double topOffset =
              logoPosition.dy + (renderBox?.size.height ?? _iconSize);
          _showPopupMenu(
            context,
            Offset(logoPosition.dx + _collapsedWidth, topOffset - _iconSize),
            _buildPopupSubMenu(subModules),
          );
        }
      },
      onExit: (_) {
        setState(() => _activeModule = "");
        if (!widget.isSidebarOpen && _overlayEntry != null) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (_activeModule == "") {
              if (_overlayEntry != null) {
                //check
                _overlayEntry?.remove();
                _overlayEntry = null;
              }
            }
          });
        }
      },
      child: Material(
        color:
            _activeModule == "Churchs"
                ? const Color.fromRGBO(67, 94, 190, 1)
                : Colors.transparent,
        child: ExpansionTile(
          leading: Icon(Icons.church, color: Colors.white70, size: _iconSize),
          title: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: widget.isSidebarOpen ? 1 : 0,
            child: const Text(
              "Church",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          initiallyExpanded: _churchExpanded,
          onExpansionChanged:
              (expanded) => setState(() => _churchExpanded = expanded),
          children: widget.isSidebarOpen ? subModules : [],
        ),
      ),
    );
  }

  Widget _buildOrganizationModule() {
    List<Widget> subModules = [
      _buildSubModuleItem("Organization List", "orglist"),
      _buildSubModuleItem("New Organization", "add_org"),
    ];
    return MouseRegion(
      onEnter: (_) {
        setState(() => _activeModule = "Organization");
        if (!widget.isSidebarOpen && _logoKey.currentContext != null) {
          final RenderBox logoRenderBox =
              _logoKey.currentContext!.findRenderObject() as RenderBox;
          final RenderBox? renderBox =
              _logoKey.currentContext?.findRenderObject() as RenderBox?;
          Offset logoPosition = Offset.zero;
          if (renderBox != null) {
            logoPosition = logoRenderBox.localToGlobal(Offset.zero);
          }
          double topOffset =
              logoPosition.dy + (renderBox?.size.height ?? _iconSize);
          _showPopupMenu(
            context,
            Offset(logoPosition.dx + _collapsedWidth, topOffset - _iconSize),
            _buildPopupSubMenu(subModules),
          );
        }
      },
      onExit: (_) {
        setState(() => _activeModule = "");
        if (!widget.isSidebarOpen && _overlayEntry != null) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (_activeModule == "") {
              if (_overlayEntry != null) {
                //check
                _overlayEntry?.remove();
                _overlayEntry = null;
              }
            }
          });
        }
      },
      child: Material(
        color:
            _activeModule == "Organization"
                ? const Color.fromRGBO(67, 94, 190, 1)
                : Colors.transparent,
        child: ExpansionTile(
          leading: Icon(
            Icons.account_tree,
            color: Colors.white70,
            size: _iconSize,
          ),
          title: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: widget.isSidebarOpen ? 1 : 0,
            child: const Text(
              "Organization",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          initiallyExpanded: _organizationExpanded,
          onExpansionChanged:
              (expanded) => setState(() => _organizationExpanded = expanded),
          children: widget.isSidebarOpen ? subModules : [],
        ),
      ),
    );
  }

  Widget _buildClaimsRequestModule() {
    List<Widget> subModules = [
      _buildSubModuleItem("Incident Management", "Claims_Request"),
      _buildSubModuleItem("New Request", "add_org"),
      _buildSubModuleItem("Request Approval", "request_approval"),
      _buildSubModuleItem("Releasing", "release_disbursement"),
    ];
    return MouseRegion(
      onEnter: (_) {
        setState(() => _activeModule = "ClaimsRequest");
        if (!widget.isSidebarOpen && _logoKey.currentContext != null) {
          final RenderBox logoRenderBox =
              _logoKey.currentContext!.findRenderObject() as RenderBox;
          final RenderBox? renderBox =
              _logoKey.currentContext?.findRenderObject() as RenderBox?;
          Offset logoPosition = Offset.zero;
          if (renderBox != null) {
            logoPosition = logoRenderBox.localToGlobal(Offset.zero);
          }
          double topOffset =
              logoPosition.dy + (renderBox?.size.height ?? _iconSize);
          _showPopupMenu(
            context,
            Offset(logoPosition.dx + _collapsedWidth, topOffset - _iconSize),
            _buildPopupSubMenu(subModules),
          );
        }
      },
      onExit: (_) {
        setState(() => _activeModule = "");
        if (!widget.isSidebarOpen && _overlayEntry != null) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (_activeModule == "") {
              if (_overlayEntry != null) {
                //check
                _overlayEntry?.remove();
                _overlayEntry = null;
              }
            }
          });
        }
      },
      child: Material(
        color:
            _activeModule == "ClaimsRequest"
                ? const Color.fromRGBO(67, 94, 190, 1)
                : Colors.transparent,
        child: ExpansionTile(
          leading: Icon(
            Icons.request_page,
            color: Colors.white70,
            size: _iconSize,
          ),
          title: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: widget.isSidebarOpen ? 1 : 0,
            child: const Text(
              "Claims & Request",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          initiallyExpanded: _claimsRequestExpanded,
          onExpansionChanged:
              (expanded) => setState(() => _claimsRequestExpanded = expanded),
          children: widget.isSidebarOpen ? subModules : [],
        ),
      ),
    );
  }

  Widget _buildContributionModule() {
    List<Widget> subModules = [
      _buildSubModuleItem("Contribution Posted", "contributions"),
      _buildSubModuleItem("Incident Contributions", "incedent_"),
    ];
    return MouseRegion(
      onEnter: (_) {
        setState(() => _activeModule = "Contributions");
        if (!widget.isSidebarOpen && _logoKey.currentContext != null) {
          final RenderBox logoRenderBox =
              _logoKey.currentContext!.findRenderObject() as RenderBox;
          final RenderBox? renderBox =
              _logoKey.currentContext?.findRenderObject() as RenderBox?;
          Offset logoPosition = Offset.zero;
          if (renderBox != null) {
            logoPosition = logoRenderBox.localToGlobal(Offset.zero);
          }
          double topOffset =
              logoPosition.dy + (renderBox?.size.height ?? _iconSize);
          _showPopupMenu(
            context,
            Offset(logoPosition.dx + _collapsedWidth, topOffset - _iconSize),
            _buildPopupSubMenu(subModules),
          );
        }
      },
      onExit: (_) {
        setState(() => _activeModule = "");
        if (!widget.isSidebarOpen && _overlayEntry != null) {
          Future.delayed(const Duration(milliseconds: 100), () {
            if (_activeModule == "") {
              if (_overlayEntry != null) {
                //check
                _overlayEntry?.remove();
                _overlayEntry = null;
              }
            }
          });
        }
      },
      child: Material(
        color:
            _activeModule == "ClaimsRequest"
                ? const Color.fromRGBO(67, 94, 190, 1)
                : Colors.transparent,
        child: ExpansionTile(
          leading: Icon(
            Icons.attach_money,
            color: Colors.white70,
            size: _iconSize,
          ),
          title: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: widget.isSidebarOpen ? 1 : 0,
            child: const Text(
              "Contributions",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          initiallyExpanded: _contributionRequestExpanded,
          onExpansionChanged:
              (expanded) =>
                  setState(() => _contributionRequestExpanded = expanded),
          children: widget.isSidebarOpen ? subModules : [],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: widget.isSidebarOpen ? _expandedWidth : _collapsedWidth,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 30, 30, 45),
        boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 5)],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                widget.isSidebarOpen ? Icons.menu_open : Icons.menu,
                color: Colors.white,
              ),
              onPressed: () => widget.onSelectModule('toggleSidebar'),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildModule("Dashboard", Icons.dashboard, const []),
                _buildManageUsersModule(),
                _buildManageMembers(),
                _buildPastorModule(),
                _buildChurchModule(),
                _buildOrganizationModule(),
                _buildClaimsRequestModule(),
                _buildContributionModule(),
                // _buildModule("Contributions", Icons.attach_money, const []),
                // _buildModule("Reports", Icons.bar_chart, const []),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

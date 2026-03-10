import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode
          ? ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.dark(primary: Color(0xFF00897B)),
              switchTheme: SwitchThemeData(
                thumbColor: WidgetStateProperty.resolveWith((states) =>
                    states.contains(WidgetState.selected)
                        ? const Color(0xFF00897B)
                        : null),
                trackColor: WidgetStateProperty.resolveWith((states) =>
                    states.contains(WidgetState.selected)
                        ? const Color(0xFF00897B).withOpacity(0.5)
                        : null),
              ),
            )
          : ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(primary: Color(0xFF00695C)),
            ),
      child: Scaffold(
        backgroundColor:
            _isDarkMode ? const Color(0xFF121212) : const Color(0xFFF5F7F5),
        appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: const Color(0xFF00695C),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 8),

            // Appearance section
            _sectionLabel('Appearance', _isDarkMode),
            const SizedBox(height: 8),
            _SettingsCard(
              isDark: _isDarkMode,
              children: [
                _ToggleTile(
                  icon: _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  iconColor: _isDarkMode ? Colors.indigo : Colors.orange,
                  iconBg: _isDarkMode
                      ? Colors.indigo.shade900
                      : Colors.orange.shade50,
                  title: 'Dark Mode',
                  subtitle:
                      _isDarkMode ? 'Dark theme is on' : 'Light theme is on',
                  value: _isDarkMode,
                  isDark: _isDarkMode,
                  onChanged: (val) => setState(() => _isDarkMode = val),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // About section
            _sectionLabel('About', _isDarkMode),
            const SizedBox(height: 8),
            _SettingsCard(
              isDark: _isDarkMode,
              children: [
                _InfoTile(
                  icon: Icons.info_outline,
                  iconColor: const Color(0xFF00695C),
                  iconBg: const Color(0xFF00695C).withOpacity(0.1),
                  title: 'App Version',
                  trailing: Text(
                    '1.0.0',
                    style: TextStyle(
                      color: _isDarkMode ? Colors.grey.shade400 : Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  isDark: _isDarkMode,
                ),
                _divider(_isDarkMode),
                _InfoTile(
                  icon: Icons.privacy_tip_outlined,
                  iconColor: Colors.blue,
                  iconBg: Colors.blue.shade50,
                  title: 'Privacy Policy',
                  trailing: Icon(Icons.chevron_right,
                      color: _isDarkMode
                          ? Colors.grey.shade500
                          : Colors.grey.shade400),
                  isDark: _isDarkMode,
                  onTap: () {},
                ),
                _divider(_isDarkMode),
                _InfoTile(
                  icon: Icons.description_outlined,
                  iconColor: Colors.purple,
                  iconBg: Colors.purple.shade50,
                  title: 'Terms of Service',
                  trailing: Icon(Icons.chevron_right,
                      color: _isDarkMode
                          ? Colors.grey.shade500
                          : Colors.grey.shade400),
                  isDark: _isDarkMode,
                  onTap: () {},
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 2),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: isDark ? const Color(0xFF00897B) : const Color(0xFF00695C),
          fontWeight: FontWeight.bold,
          fontSize: 12,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _divider(bool isDark) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 56,
      color: isDark ? Colors.white10 : Colors.grey.shade100,
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  final bool isDark;
  const _SettingsCard({required this.children, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final bool value;
  final bool isDark;
  final ValueChanged<bool> onChanged;

  const _ToggleTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.isDark,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? Colors.grey.shade400 : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF00695C),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final Widget trailing;
  final bool isDark;
  final VoidCallback? onTap;

  const _InfoTile({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.trailing,
    required this.isDark,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isDark ? iconColor.withOpacity(0.15) : iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

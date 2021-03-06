project('budgie-weather-applet',
    ['c', 'vala'],
    version: '1.1.0',
    license: 'GPL-2.0',
    default_options: [
        'c_std=c11',
    ],
)

i18n = import('i18n')

am_cflags = [
    '-fstack-protector',
    '-pedantic',
    '-Wstrict-prototypes',
    '-Wundef',
    '-Werror-implicit-function-declaration',
    '-Wformat',
    '-Wformat-security',
    '-Werror=format-security',
    '-Wconversion',
    '-Wunused-variable',
    '-Wunreachable-code',
    '-Wall',
    '-W',
]

add_global_arguments(am_cflags, language: 'c')

dep_gtk3 = dependency('gtk+-3.0', version: '>=3.18')
dep_glib = dependency('glib-2.0', version: '>= 2.46.0')
dep_peas = dependency('libpeas-1.0', version: '>= 1.8.0')
dep_budgie = dependency('budgie-1.0', version: '>= 2')
dep_json_glib = dependency('json-glib-1.0', version: '>= 1.2')
dep_libsoup = dependency('libsoup-2.4', version: '>= 2.54')
dep_gweather = dependency('gweather-3.0', version: '>= 3.18')

# Make gettext work
add_project_arguments(
    '-DGETTEXT_PACKAGE="@0@"'.format(meson.project_name()),
    language:'c'
)

LIB_INSTALL_DIR = join_paths(get_option('prefix'), get_option('libdir'), 'budgie-desktop', 'plugins', meson.project_name())

subdir('data')
subdir('src')
subdir('po')

meson.add_install_script('meson/meson_post_install.py')

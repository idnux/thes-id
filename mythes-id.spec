Summary: Indonesian thesaurus.
Name: mythes-id
Version: 1.0.2
Release: 1.idnux
License: LGPL
BuildArch: noarch
Requires: mythes
Group: Applications/Text
Source: https://github.com/idnux/thes-id/archive/1.0.2.tar.gz
URL: https://idnux.wordpress.com/proyek/mythes-id

%description
Indonesian Thesaurus for LibreOffice.

This package contains an Indonesian thesaurus for LibreOffice.

%prep
%autosetup -n thes-id-1.0.2
%build
make

%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/%{_datadir}/mythes

install -m 644 th_id_ID_v2.idx $RPM_BUILD_ROOT/%{_datadir}/mythes
install -m 644 th_id_ID_v2.dat $RPM_BUILD_ROOT/%{_datadir}/mythes

%clean
rm -rf $RPM_BUILD_ROOT

%files
%defattr(-,root,root,-)
%license LICENSE
%doc README INSTALL LICENSE
%{_datadir}/mythes/*

%changelog
* Tue Mar 13 2018 Ali Ahmadi <idnux09@gmail.com>
- Fix missing or incorrect line counts (Thanks to Mr. Andika Triwidada - <atriwidada@src.gnome.org>).

* Wed Jan 24 2018 Ali Ahmadi <idnux09@gmail.com>
- Add Makefile.

* Wed Feb 22 2017 Ali Ahmadi <idnux09@gmail.com>
- Initial release.

Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6019D7133B8
	for <lists+qemu-devel@lfdr.de>; Sat, 27 May 2023 11:30:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2qEg-0007cR-Fe; Sat, 27 May 2023 05:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2qEf-0007cJ-3g
 for qemu-devel@nongnu.org; Sat, 27 May 2023 05:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2qES-0007Xg-G4
 for qemu-devel@nongnu.org; Sat, 27 May 2023 05:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685179743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVqurTewusebIALfBp9aNfkONSHewhf9vIXPQ1JheQE=;
 b=IzfVYTCRFUte2tQ/3moMI88bzdSmhK0qlMMr+pmntLAwDrRD//s/9cj3UI12sm7AAeU49b
 26h2ShXYQ0OBCC0xU4jQv35nvnX0qq6s2akMx8QDoNJWV8f+txAJjIu9yg3HSJPVVcXtj/
 wKgWXMB51KVbp2AUiU2ZaO21xcEauU4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-CIHSQKcVNSuyBUt6o9jCBg-1; Sat, 27 May 2023 05:29:02 -0400
X-MC-Unique: CIHSQKcVNSuyBUt6o9jCBg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-96f4f1bb838so144434366b.3
 for <qemu-devel@nongnu.org>; Sat, 27 May 2023 02:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685179740; x=1687771740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVqurTewusebIALfBp9aNfkONSHewhf9vIXPQ1JheQE=;
 b=TXgzCAihnZ/ZqgVLm3uB0Vg0hzluhwcOatoTWsKsKr5s3nDfEOTsjiOMSiswFX5n/F
 Q7HVtA0N0Sodti7e9gYcAv5LxELN02sZ3AAL83eSxumCoY/c+Y6PYfKB97/H8fGrJGl8
 fM8d6nBtkRy+IWsk4Ky0KK+lQf6Wa28uyRrSSZhLUxtBNMHi6AwGkKY0VSyoZo15kalf
 /ex0YAi4uywrcvE7yQE+Geildc7DcZzhN7i6KGwnmgHHk31/UjpgsTggnRLh2JD26k+r
 1PU65I7nNvnWlcu4DZJcVuUZGzY+FCoccdgYN+nnHzu8yuCqkPh0miJFUlxjSDVh/n2f
 XFGg==
X-Gm-Message-State: AC+VfDyI4E3F9aIay9iMJ67Ifpgg2XUq2MtfYi0A7+/6oM8XH6bmKvW1
 cJZHsVHUaU7lQ5WGS81DXezDLWe8mH56ERa2ACbwT22OchbVIv1gFX4sjL1Mu3Pp4YodCw+9+qY
 1vwt9bde1ba3AFCE4NM+JgMUojp/ygRRGsKQCUjwzuki23JbmVhTEo39KVKQbHoAFc0guVYNWRY
 o=
X-Received: by 2002:a17:907:1b24:b0:969:f677:11b4 with SMTP id
 mp36-20020a1709071b2400b00969f67711b4mr4695417ejc.37.1685179740225; 
 Sat, 27 May 2023 02:29:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6VioES/Rx9hP8AsA1zJI1QwwVzx2zuT8nmSRlfliYPMRJzv0dfZPl/HDERIlCHYJCqFPbHOQ==
X-Received: by 2002:a17:907:1b24:b0:969:f677:11b4 with SMTP id
 mp36-20020a1709071b2400b00969f67711b4mr4695404ejc.37.1685179739847; 
 Sat, 27 May 2023 02:28:59 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a1709064e4500b0096f6647b5e8sm3237121ejw.64.2023.05.27.02.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 May 2023 02:28:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH 3/5] meson: subprojects: replace submodules with wrap files
Date: Sat, 27 May 2023 11:28:49 +0200
Message-Id: <20230527092851.705884-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230527092851.705884-1-pbonzini@redhat.com>
References: <20230527092851.705884-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Compared to submodules, .wrap files have several advantages:

* option parsing and downloading is delegated to meson

* the commit is stored in a text file instead of a magic entry in the
  git tree object

* we could stop shipping external dependencies that are only used as a
  fallback, but not break compilation on platforms that lack them.
  For example it may make sense to download dtc at build time, controlled
  by --enable-download, even when building from a tarball.  Right now,
  this patch does the opposite: make-release treats dtc like libvfio-user
  (which is not stable API and therefore hasn't found its way into any
  distros) and keycodemap (which is a copylib, for better or worse).

dependency() can fall back to a wrap automatically.  However, this
is only possible for libraries that come with a .pc file, and this
is not very common for libfdt even though the upstream project in
principle provides it; it also removes the control that we provide with
--enable-fdt={system,internal}.  Therefore, the logic to pick system
vs. internal libfdt is left untouched.

--enable-fdt=git is removed; it was already a synonym for
--enable-fdt=internal.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml |  1 +
 .gitmodules                         |  9 ----
 configure                           | 75 ++++++++++++-----------------
 meson.build                         | 15 +-----
 scripts/archive-source.sh           | 11 ++++-
 scripts/make-release                |  5 ++
 subprojects/.gitignore              |  3 ++
 subprojects/dtc                     |  1 -
 subprojects/dtc.wrap                |  4 ++
 subprojects/keycodemapdb            |  1 -
 subprojects/keycodemapdb.wrap       |  4 ++
 subprojects/libvfio-user            |  1 -
 subprojects/libvfio-user.wrap       |  4 ++
 13 files changed, 61 insertions(+), 73 deletions(-)
 delete mode 160000 subprojects/dtc
 create mode 100644 subprojects/dtc.wrap
 delete mode 160000 subprojects/keycodemapdb
 create mode 100644 subprojects/keycodemapdb.wrap
 delete mode 160000 subprojects/libvfio-user
 create mode 100644 subprojects/libvfio-user.wrap

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index c9f2e737c09a..3c997d7265b2 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -44,6 +44,7 @@
   script:
     - scripts/git-submodule.sh update
         $(sed -n '/GIT_SUBMODULES=/ s/.*=// p' build/config-host.mak)
+    - meson subprojects download $(cd build/subprojects && echo *)
     - cd build
     - find . -type f -exec touch {} +
     # Avoid recompiling by hiding ninja with NINJA=":"
diff --git a/.gitmodules b/.gitmodules
index f8b2ddf3877c..a934c85e4e40 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -13,9 +13,6 @@
 [submodule "roms/qemu-palcode"]
 	path = roms/qemu-palcode
 	url = https://gitlab.com/qemu-project/qemu-palcode.git
-[submodule "subprojects/dtc"]
-	path = subprojects/dtc
-	url = https://gitlab.com/qemu-project/dtc.git
 [submodule "roms/u-boot"]
 	path = roms/u-boot
 	url = https://gitlab.com/qemu-project/u-boot.git
@@ -25,9 +22,6 @@
 [submodule "roms/QemuMacDrivers"]
 	path = roms/QemuMacDrivers
 	url = https://gitlab.com/qemu-project/QemuMacDrivers.git
-[submodule "subprojects/keycodemapdb"]
-	path = subprojects/keycodemapdb
-	url = https://gitlab.com/qemu-project/keycodemapdb.git
 [submodule "roms/seabios-hppa"]
 	path = roms/seabios-hppa
 	url = https://gitlab.com/qemu-project/seabios-hppa.git
@@ -55,6 +49,3 @@
 [submodule "tests/lcitool/libvirt-ci"]
 	path = tests/lcitool/libvirt-ci
 	url = https://gitlab.com/libvirt/libvirt-ci.git
-[submodule "subprojects/libvfio-user"]
-	path = subprojects/libvfio-user
-	url = https://gitlab.com/qemu-project/libvfio-user.git
diff --git a/configure b/configure
index 2f908660e4f1..1d1b8736c0eb 100755
--- a/configure
+++ b/configure
@@ -253,7 +253,7 @@ else
     git_submodules_action="ignore"
 fi
 
-git_submodules="subprojects/keycodemapdb"
+git_submodules=""
 git="git"
 debug_tcg="no"
 docs="auto"
@@ -269,7 +269,6 @@ python=
 download="enabled"
 bindir="bin"
 skip_meson=no
-vfio_user_server="disabled"
 use_containers="yes"
 gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
 gdb_arches=""
@@ -281,16 +280,13 @@ unset target_list_exclude
 
 # The following Meson options are handled manually (still they
 # are included in the automatically generated help message)
-
-# 1. Track which submodules are needed
-fdt="auto"
-
-# 2. Automatically enable/disable other options
+# because they automatically enable/disable other options
 tcg="auto"
 cfi="false"
 
-# 3. Need to check for -static-pie before Meson runs.  Also,
-# Meson has PIE as a boolean rather than enabled/disabled/auto.
+# Meson has PIE as a boolean rather than enabled/disabled/auto,
+# and we also need to check for -static-pie before Meson runs
+# which requires knowing whether --static is enabled.
 pie=""
 static="no"
 
@@ -743,14 +739,6 @@ for opt do
   ;;
   --disable-cfi) cfi="false"
   ;;
-  --disable-fdt) fdt="disabled"
-  ;;
-  --enable-fdt) fdt="enabled"
-  ;;
-  --enable-fdt=git) fdt="internal"
-  ;;
-  --enable-fdt=*) fdt="$optarg"
-  ;;
   --with-git=*) git="$optarg"
   ;;
   --with-git-submodules=*)
@@ -774,10 +762,6 @@ for opt do
   ;;
   --gdb=*) gdb_bin="$optarg"
   ;;
-  --enable-vfio-user-server) vfio_user_server="enabled"
-  ;;
-  --disable-vfio-user-server) vfio_user_server="disabled"
-  ;;
   # everything else has the same name in configure and meson
   --*) meson_option_parse "$opt" "$optarg"
   ;;
@@ -789,6 +773,30 @@ if test "$plugins" = "yes" -a "$tcg" = "disabled"; then
     error_exit "Can't enable plugins on non-TCG builds"
 fi
 
+if ! test -f "$source_path/subprojects/keycodemapdb/README" \
+    && test -f "$download" = disabled
+then
+    echo
+    echo "ERROR: missing subprojects"
+    echo
+    if test -e "$source_path/.git"; then
+        echo "--disable-download specified but subprojects were not"
+        echo "checked out.  Please download subprojects."
+    else
+        echo "This is not a GIT checkout but subproject content appears to"
+        echo "be missing. Do not use 'git archive' or GitHub download links"
+        echo "to acquire QEMU source archives. Non-GIT builds are only"
+        echo "supported with source archives linked from:"
+        echo
+        echo "  https://www.qemu.org/download/#source"
+        echo
+        echo "Developers working with GIT can use scripts/archive-source.sh"
+        echo "if they need to create valid source archives."
+    fi
+    echo
+    exit 1
+fi
+
 case $git_submodules_action in
     update|validate)
         if test ! -e "$source_path/.git" || ! has git; then
@@ -797,7 +805,7 @@ case $git_submodules_action in
         fi
     ;;
     ignore)
-        if ! test -f "$source_path/subprojects/keycodemapdb/README"
+        if ! test -f "$source_path/tests/fp/berkeley-testfloat-3/README.md"
         then
             echo
             echo "ERROR: missing GIT submodules"
@@ -1166,16 +1174,6 @@ EOF
   fi
 fi
 
-##########################################
-# fdt probe
-
-case "$fdt" in
-  auto | enabled | internal)
-    # Simpler to always update submodule, even if not needed.
-    git_submodules="${git_submodules} subprojects/dtc"
-    ;;
-esac
-
 ########################################
 # check if ccache is interfering with
 # semantic analysis of macros
@@ -1611,17 +1609,6 @@ write_target_makefile() {
   fi
 }
 
-##########################################
-# check for vfio_user_server
-
-case "$vfio_user_server" in
-  enabled )
-    if test "$git_submodules_action" != "ignore"; then
-      git_submodules="${git_submodules} subprojects/libvfio-user"
-    fi
-    ;;
-esac
-
 #######################################
 # cross-compiled firmware targets
 
@@ -1953,12 +1940,10 @@ if test "$skip_meson" = no; then
   # QEMU options
   test "$cfi" != false && meson_option_add "-Dcfi=$cfi"
   test "$docs" != auto && meson_option_add "-Ddocs=$docs"
-  test "$fdt" != auto && meson_option_add "-Dfdt=$fdt"
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
   test "$qemu_suffix" != qemu && meson_option_add "-Dqemu_suffix=$qemu_suffix"
   test "$smbd" != '' && meson_option_add "-Dsmbd=$smbd"
   test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
-  test "$vfio_user_server" != auto && meson_option_add "-Dvfio_user_server=$vfio_user_server"
   run_meson() {
     NINJA=$ninja $meson setup --prefix "$prefix" "$@" $cross_arg "$PWD" "$source_path"
   }
diff --git a/meson.build b/meson.build
index b11773ab39e8..610f47d24593 100644
--- a/meson.build
+++ b/meson.build
@@ -3047,14 +3047,7 @@ endif
 
 libvfio_user_dep = not_found
 if have_system and vfio_user_server_allowed
-  have_internal = fs.exists(meson.current_source_dir() / 'subprojects/libvfio-user/meson.build')
-
-  if not have_internal
-    error('libvfio-user source not found - please pull git submodule')
-  endif
-
-  libvfio_user_proj = subproject('libvfio-user')
-
+  libvfio_user_proj = subproject('libvfio-user', required: true)
   libvfio_user_dep = libvfio_user_proj.get_variable('libvfio_user_dep')
 endif
 
@@ -3082,12 +3075,6 @@ if fdt_required.length() > 0 or fdt_opt == 'enabled'
   endif
   if not fdt.found()
     assert(fdt_opt == 'internal')
-    have_internal = fs.exists(meson.current_source_dir() / 'subprojects/dtc/meson.build')
-
-    if not have_internal
-      error('libfdt source not found - please pull git submodule')
-    endif
-
     libfdt_proj = subproject('dtc', required: true,
                              default_options: ['tools=false',  'yaml=disabled',
                                                'python=disabled', 'default_library=static'])
diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
index dba5ae05b67e..b99cb66e4122 100755
--- a/scripts/archive-source.sh
+++ b/scripts/archive-source.sh
@@ -26,8 +26,8 @@ sub_file="${sub_tdir}/submodule.tar"
 # independent of what the developer currently has initialized
 # in their checkout, because the build environment is completely
 # different to the host OS.
-submodules="subprojects/dtc subprojects/keycodemapdb"
-submodules="$submodules tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
+subprojects="dtc keycodemapdb libvfio-user"
+submodules="tests/fp/berkeley-softfloat-3 tests/fp/berkeley-testfloat-3"
 sub_deinit=""
 
 function cleanup() {
@@ -70,4 +70,11 @@ for sm in $submodules; do
     tar --concatenate --file "$tar_file" "$sub_file"
     test $? -ne 0 && error "failed append submodule $sm to $tar_file"
 done
+
+for sp in $subprojects; do
+    meson subprojects download $sp
+    test $? -ne 0 && error "failed to download subproject $sp"
+    tar --append --file "$tar_file" --exclude=.git subprojects/$sp
+    test $? -ne 0 && error "failed to append subproject $sp to $tar_file"
+done
 exit 0
diff --git a/scripts/make-release b/scripts/make-release
index 44a9d86a04a7..0604e61b8143 100755
--- a/scripts/make-release
+++ b/scripts/make-release
@@ -16,6 +16,9 @@ if [ $# -ne 2 ]; then
     exit 0
 fi
 
+# Only include wraps that are invoked with subproject()
+SUBPROJECTS="dtc libvfio-user keycodemapdb"
+
 src="$1"
 version="$2"
 destination=qemu-${version}
@@ -26,6 +29,8 @@ git clone --single-branch -b "v${version}" -c advice.detachedHead=false \
 pushd ${destination}
 
 git submodule update --init --single-branch
+meson subprojects download $SUBPROJECTS
+
 (cd roms/seabios && git describe --tags --long --dirty > .version)
 (cd roms/skiboot && ./make_version.sh > .version)
 # Fetch edk2 submodule's submodules, since it won't have access to them via
diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index 7560ebb0b1a0..935e9a72a8f9 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -1,3 +1,6 @@
 /packagecache
 
+/dtc
+/keycodemapdb
+/libvfio-user
 /slirp
diff --git a/subprojects/dtc b/subprojects/dtc
deleted file mode 160000
index b6910bec1161..000000000000
--- a/subprojects/dtc
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit b6910bec11614980a21e46fbccc35934b671bd81
diff --git a/subprojects/dtc.wrap b/subprojects/dtc.wrap
new file mode 100644
index 000000000000..d1bc9174e913
--- /dev/null
+++ b/subprojects/dtc.wrap
@@ -0,0 +1,4 @@
+[wrap-git]
+url = https://gitlab.com/qemu-project/dtc.git
+revision = b6910bec11614980a21e46fbccc35934b671bd81
+depth = 1
diff --git a/subprojects/keycodemapdb b/subprojects/keycodemapdb
deleted file mode 160000
index f5772a62ec52..000000000000
--- a/subprojects/keycodemapdb
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit f5772a62ec52591ff6870b7e8ef32482371f22c6
diff --git a/subprojects/keycodemapdb.wrap b/subprojects/keycodemapdb.wrap
new file mode 100644
index 000000000000..dda7b0e5716f
--- /dev/null
+++ b/subprojects/keycodemapdb.wrap
@@ -0,0 +1,4 @@
+[wrap-git]
+url = https://gitlab.com/qemu-project/keycodemapdb.git
+revision = f5772a62ec52591ff6870b7e8ef32482371f22c6
+depth = 1
diff --git a/subprojects/libvfio-user b/subprojects/libvfio-user
deleted file mode 160000
index 0b28d205572c..000000000000
--- a/subprojects/libvfio-user
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit 0b28d205572c80b568a1003db2c8f37ca333e4d7
diff --git a/subprojects/libvfio-user.wrap b/subprojects/libvfio-user.wrap
new file mode 100644
index 000000000000..416955ca4515
--- /dev/null
+++ b/subprojects/libvfio-user.wrap
@@ -0,0 +1,4 @@
+[wrap-git]
+url = https://gitlab.com/qemu-project/libvfio-user.git
+revision = 0b28d205572c80b568a1003db2c8f37ca333e4d7
+depth = 1
-- 
2.40.1



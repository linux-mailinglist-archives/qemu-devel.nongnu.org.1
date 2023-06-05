Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 062D57222A8
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:53:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66tq-0002yO-Mh; Mon, 05 Jun 2023 05:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66tT-0002r7-NK
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66tR-0006rY-5a
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685958772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UDtZI8Y4EzgVfohnE7GF0D4hAr7LgQNUJEm2QKAAE/Y=;
 b=Rux7VBpGBoUYwINi7a5roUBh27vhRpy+uZ/dnJNZmF1OxJsbvdQ+c5ZJnOeJTm0KD1/JZt
 kpghvOYAd2SoCkFAfDcS9bsSLeFGQ0P8ZHlmCxVBoDl0BtbcgjGf+JWoX1GJzmArG5DQi6
 w/Uoek7C6wmBs5tvdkSL8B3Hv68rR+o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-zJyvubCZNNuLDgTng_VVpA-1; Mon, 05 Jun 2023 05:52:50 -0400
X-MC-Unique: zJyvubCZNNuLDgTng_VVpA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9745c72d99cso291742066b.1
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 02:52:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685958754; x=1688550754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UDtZI8Y4EzgVfohnE7GF0D4hAr7LgQNUJEm2QKAAE/Y=;
 b=CfWFqb7tquASltPa2q9iQ8oIgDxN6i8uLtr9Ldj+2kRlmd3O2AV0Hn4biLc6CdQB4u
 wY/EfVksovQ0Bty9IhGrfsYCg7IiVX8cMn1cJnhXo7BYPvKhLdVy5Cl6j/pEkdK5+Bl+
 C2W7V6pHqHb2+D9ip03lV6EWvXngI31mXqMpDsvwjezw+0fGZ9rnPGcmOXUEb8G5OSIx
 uuexX0jXAjt/llKDKkkhvpZV6ljn9cMyWG49J1znZStcnUn600UrwQYbeP8hTafj22K3
 4spSbtXg/548thliupqe22tjHs44eiFDtWd7TKvxtaQxDpvHXhU0TtB/3MnvpQvZ4bhG
 mbLA==
X-Gm-Message-State: AC+VfDypoXchLLGy34lrpRHsaA3xMiBUohKgVgtSSLK0nf3jilog+HWu
 +Be/tDPf60ZPnp9VeQJsy41aou/RfP1pHEmAhDZfEULyKq7icMeY8h1Lx1ZBoOZkFzeJ5/8/PTH
 4WJJ+QQoqbhT1voGabW3jxNHZEZPSqOyd+qAaf2Etd8gh4gZlnPznpHNytwoind2KmjGfaKOZVY
 E=
X-Received: by 2002:a17:906:fd81:b0:968:c3b5:8b92 with SMTP id
 xa1-20020a170906fd8100b00968c3b58b92mr5753423ejb.57.1685958753839; 
 Mon, 05 Jun 2023 02:52:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6uXFmZ3lrbWDUa7yqYSk7jK6V2zlfOmGrvS4qTrcFuXB9ImGelMlMRwg9NIphzbcPpx6OZbQ==
X-Received: by 2002:a17:906:fd81:b0:968:c3b5:8b92 with SMTP id
 xa1-20020a170906fd8100b00968c3b58b92mr5753411ejb.57.1685958753488; 
 Mon, 05 Jun 2023 02:52:33 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 k16-20020a1709065fd000b00977db7d08cbsm924302ejv.74.2023.06.05.02.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 02:52:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH 05/10] meson: subprojects: replace submodules with wrap files
Date: Mon,  5 Jun 2023 11:52:18 +0200
Message-Id: <20230605095223.107653-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605095223.107653-1-pbonzini@redhat.com>
References: <20230605095223.107653-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 configure                           | 77 ++++++++++++-----------------
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
 13 files changed, 63 insertions(+), 73 deletions(-)
 delete mode 160000 subprojects/dtc
 create mode 100644 subprojects/dtc.wrap
 delete mode 160000 subprojects/keycodemapdb
 create mode 100644 subprojects/keycodemapdb.wrap
 delete mode 160000 subprojects/libvfio-user
 create mode 100644 subprojects/libvfio-user.wrap

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index c9f2e737c09..3c997d7265b 100644
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
index f8b2ddf3877..a934c85e4e4 100644
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
index 52274212310..45d43ddbd97 100755
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
   --with-git-submodules=*)
       git_submodules_action="$optarg"
   ;;
@@ -772,10 +760,6 @@ for opt do
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
@@ -787,6 +771,32 @@ if test "$plugins" = "yes" -a "$tcg" = "disabled"; then
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
+        echo 'checked out.  Please invoke "meson subprojects download"'
+        echo "before configuring QEMU, or remove --disable-download"
+        echo "from the command line."
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
@@ -795,7 +805,7 @@ case $git_submodules_action in
         fi
     ;;
     ignore)
-        if ! test -f "$source_path/subprojects/keycodemapdb/README"
+        if ! test -f "$source_path/tests/fp/berkeley-testfloat-3/README.md"
         then
             echo
             echo "ERROR: missing GIT submodules"
@@ -1164,16 +1174,6 @@ EOF
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
@@ -1609,17 +1609,6 @@ write_target_makefile() {
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
 
@@ -1951,12 +1940,10 @@ if test "$skip_meson" = no; then
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
index eb09af6ec82..badeeffd529 100644
--- a/meson.build
+++ b/meson.build
@@ -3046,14 +3046,7 @@ endif
 
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
 
@@ -3081,12 +3074,6 @@ if fdt_required.length() > 0 or fdt_opt == 'enabled'
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
index dba5ae05b67..b99cb66e412 100755
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
index 44a9d86a04a..0604e61b814 100755
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
index 7560ebb0b1a..935e9a72a8f 100644
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
index b6910bec116..00000000000
--- a/subprojects/dtc
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit b6910bec11614980a21e46fbccc35934b671bd81
diff --git a/subprojects/dtc.wrap b/subprojects/dtc.wrap
new file mode 100644
index 00000000000..d1bc9174e91
--- /dev/null
+++ b/subprojects/dtc.wrap
@@ -0,0 +1,4 @@
+[wrap-git]
+url = https://gitlab.com/qemu-project/dtc.git
+revision = b6910bec11614980a21e46fbccc35934b671bd81
+depth = 1
diff --git a/subprojects/keycodemapdb b/subprojects/keycodemapdb
deleted file mode 160000
index f5772a62ec5..00000000000
--- a/subprojects/keycodemapdb
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit f5772a62ec52591ff6870b7e8ef32482371f22c6
diff --git a/subprojects/keycodemapdb.wrap b/subprojects/keycodemapdb.wrap
new file mode 100644
index 00000000000..dda7b0e5716
--- /dev/null
+++ b/subprojects/keycodemapdb.wrap
@@ -0,0 +1,4 @@
+[wrap-git]
+url = https://gitlab.com/qemu-project/keycodemapdb.git
+revision = f5772a62ec52591ff6870b7e8ef32482371f22c6
+depth = 1
diff --git a/subprojects/libvfio-user b/subprojects/libvfio-user
deleted file mode 160000
index 0b28d205572..00000000000
--- a/subprojects/libvfio-user
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit 0b28d205572c80b568a1003db2c8f37ca333e4d7
diff --git a/subprojects/libvfio-user.wrap b/subprojects/libvfio-user.wrap
new file mode 100644
index 00000000000..416955ca451
--- /dev/null
+++ b/subprojects/libvfio-user.wrap
@@ -0,0 +1,4 @@
+[wrap-git]
+url = https://gitlab.com/qemu-project/libvfio-user.git
+revision = 0b28d205572c80b568a1003db2c8f37ca333e4d7
+depth = 1
-- 
2.40.1



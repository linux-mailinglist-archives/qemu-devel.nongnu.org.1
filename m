Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4539E7C9F96
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH93-000420-FL; Mon, 16 Oct 2023 02:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8x-00040D-SN
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8v-0005TN-K7
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REi6HQck2TUeMpOKRqPBSFfgxuGcZSMdyfYk1mhVlOw=;
 b=LKG3IhPCDDK7wWIqTiygEYw7+0ZjUQraapS/99j26aH9ipNQiiw8mm/wzHBYqhfk3IiLFz
 7eeBI/C4cBsVh5cit4wxC8HhbEY2mk9i+eCKLl7DI2XRVBrka8ccZJOOUWdp1jYkTYRmm4
 Og/VA54NNVtJsuFdNZDvGzJ/CJsKQ6s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-_ltPE-YoMEOEK5ubLWAVzw-1; Mon, 16 Oct 2023 02:31:54 -0400
X-MC-Unique: _ltPE-YoMEOEK5ubLWAVzw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9bd91ce3033so260201166b.0
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437913; x=1698042713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REi6HQck2TUeMpOKRqPBSFfgxuGcZSMdyfYk1mhVlOw=;
 b=dOQfjhSdjhc1Vy3Te6ubMhSSJhmDpAQ6Fxiel+Q2GCaVschLqDY2OZLrNrr23kP6mA
 Lxw/DVS+xnyLX9EY1zIziYak8GEv3GnI5WOp0lWV7ftjwb+1U6uA10W7Cwu2TlU2u43b
 Q+olEOm6tvySUESkfOIisomw+TlaA8kmsSTuyBkztfZSaZ83Fav2Ab8C14CrBDBXpYBE
 F1lUYI5WLLSw7MpmSV8jOg0NltXCL0OPFBn70/hEEdjQDT9mmjIqWtjKRcy0n/tis+vL
 EgrzxTELdxF38TcPp4v5n6TorstciDnPAMyJDKo2iQEr+qphJfM2cPe6vD/+q3QJeR3l
 LguQ==
X-Gm-Message-State: AOJu0YwylLv6VNKyjsWlms+DmCECafbmjXAFxn1/0owqRmZf159YYtbw
 Ql9J20GCImde7DaLdHEjLz66cgH2G9X7qm48JGSeycAcXGKCYrwp0ZN51L93aUbs5nE9gbAn6+r
 I72hVcc7oJEWlLYtQoPNxNOQMR5oU9cmvD0hzNVPevniiu0XDRxyrqwWyhTt+S1e3fA/vSxBryJ
 k=
X-Received: by 2002:a17:907:2d27:b0:9bf:4e0b:fb05 with SMTP id
 gs39-20020a1709072d2700b009bf4e0bfb05mr4523007ejc.11.1697437913270; 
 Sun, 15 Oct 2023 23:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFcDow/BUKnhkxTQsIFGZvQUTLpZD7QCkWFa0Qisc7Cw7H63N0Zr0bBN9+e1Ze3irNV7bGMQw==
X-Received: by 2002:a17:907:2d27:b0:9bf:4e0b:fb05 with SMTP id
 gs39-20020a1709072d2700b009bf4e0bfb05mr4522985ejc.11.1697437912859; 
 Sun, 15 Oct 2023 23:31:52 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 my13-20020a1709065a4d00b0099bc8bd9066sm3357257ejc.150.2023.10.15.23.31.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:31:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/17] configure: move target-specific defaults to an external
 machine file
Date: Mon, 16 Oct 2023 08:31:22 +0200
Message-ID: <20231016063127.161204-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016063127.161204-1-pbonzini@redhat.com>
References: <20231016063127.161204-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Enable Windows-specific defaults with a machine file, so that related
options can be automatically parsed and included in the help message.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/meson/windows.txt     |  9 +++++++++
 configure                     | 38 +++++++++++++++--------------------
 scripts/meson-buildoptions.py |  4 +++-
 scripts/meson-buildoptions.sh |  7 +++++++
 4 files changed, 35 insertions(+), 23 deletions(-)
 create mode 100644 configs/meson/windows.txt

diff --git a/configs/meson/windows.txt b/configs/meson/windows.txt
new file mode 100644
index 00000000000..55b192e71b1
--- /dev/null
+++ b/configs/meson/windows.txt
@@ -0,0 +1,9 @@
+# target-specific defaults, can still be overridden on
+# the command line
+
+[built-in options]
+bindir = ''
+prefix = '/qemu'
+
+[project options]
+qemu_suffix = ''
diff --git a/configure b/configure
index 211591911cc..e6787dc4111 100755
--- a/configure
+++ b/configure
@@ -246,8 +246,6 @@ default_cflags='-O2 -g'
 git_submodules_action="update"
 docs="auto"
 EXESUF=""
-prefix="/usr/local"
-qemu_suffix="qemu"
 system="yes"
 linux_user=""
 bsd_user=""
@@ -256,7 +254,6 @@ subdirs=""
 ninja=""
 python=
 download="enabled"
-bindir="bin"
 skip_meson=no
 use_containers="yes"
 gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
@@ -582,9 +579,6 @@ done
 
 if test "$targetos" = "windows" ; then
   EXESUF=".exe"
-  prefix="/qemu"
-  bindir=""
-  qemu_suffix=""
 fi
 
 meson_option_build_array() {
@@ -618,6 +612,15 @@ meson_option_parse() {
   fi
 }
 
+meson_add_machine_file() {
+  if test "$cross_compile" = "yes"; then
+    meson_option_add --cross-file
+  else
+    meson_option_add --native-file
+  fi
+  meson_option_add "$1"
+}
+
 for opt do
   optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
   case "$opt" in
@@ -625,8 +628,6 @@ for opt do
   ;;
   --version|-V) exec cat "$source_path/VERSION"
   ;;
-  --prefix=*) prefix="$optarg"
-  ;;
   --cross-prefix=*)
   ;;
   --cc=*)
@@ -697,10 +698,6 @@ for opt do
   ;;
   --static) static="yes"
   ;;
-  --bindir=*) bindir="$optarg"
-  ;;
-  --with-suffix=*) qemu_suffix="$optarg"
-  ;;
   --host=*|--build=*|\
   --disable-dependency-tracking|\
   --sbindir=*|--sharedstatedir=*|\
@@ -857,7 +854,6 @@ Options: [defaults in brackets after descriptions]
 
 Standard options:
   --help                   print this message
-  --prefix=PREFIX          install in PREFIX [$prefix]
   --target-list=LIST       set target list (default: build all)
 $(echo Available targets: $default_target_list | \
   fold -s -w 53 | sed -e 's/^/                           /')
@@ -882,8 +878,6 @@ Advanced options (experts only):
   --ninja=NINJA            use specified ninja [$ninja]
   --smbd=SMBD              use specified smbd [$smbd]
   --static                 enable static build [$static]
-  --bindir=PATH            install binaries in PATH
-  --with-suffix=SUFFIX     suffix for QEMU data inside datadir/libdir/sysconfdir/docdir [$qemu_suffix]
   --without-default-features default all --enable-* options to "disabled"
   --without-default-devices  do not include any device that is not needed to
                            start the emulator (only use if you are including
@@ -1799,24 +1793,25 @@ if test "$skip_meson" = no; then
     else
         echo "endian = 'little'" >> $cross
     fi
-    cross_arg="--cross-file config-meson.cross"
 
     native="config-meson.native.new"
     echo "# Automatically generated by configure - do not modify" > $native
     echo "[binaries]" >> $native
     echo "c = [$(meson_quote $host_cc)]" >> $native
     mv $native config-meson.native
-    cross_arg="$cross_arg --native-file config-meson.native"
-  else
-    cross_arg="--native-file config-meson.cross"
+    meson_option_add --native-file
+    meson_option_add config-meson.native
   fi
   mv $cross config-meson.cross
+  meson_add_machine_file config-meson.cross
+  if test -f "$source_path/configs/meson/$targetos.txt"; then
+    meson_add_machine_file $source_path/configs/meson/$targetos.txt
+  fi
 
   rm -rf meson-private meson-info meson-logs
 
   # Built-in options
   test "$download" = "disabled" && meson_option_add "--wrap-mode=nodownload"
-  test "$bindir" != "bin" && meson_option_add "-Dbindir=$bindir"
   test "$default_feature" = no && meson_option_add -Dauto_features=disabled
   test "$static" = yes && meson_option_add -Dprefer_static=true
   test "$pie" = no && meson_option_add -Db_pie=false
@@ -1828,11 +1823,10 @@ if test "$skip_meson" = no; then
   test "$docs" != auto && meson_option_add "-Ddocs=$docs"
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
   test "$plugins" = yes && meson_option_add "-Dplugins=true"
-  test "$qemu_suffix" != qemu && meson_option_add "-Dqemu_suffix=$qemu_suffix"
   test "$smbd" != '' && meson_option_add "-Dsmbd=$smbd"
   test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
   run_meson() {
-    NINJA=$ninja $meson setup --prefix "$prefix" "$@" $cross_arg "$PWD" "$source_path"
+    NINJA=$ninja $meson setup "$@" "$PWD" "$source_path"
   }
   eval run_meson $meson_options
   if test "$?" -ne 0 ; then
diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
index b787c84e914..0c24bdc1e8c 100644
--- a/scripts/meson-buildoptions.py
+++ b/scripts/meson-buildoptions.py
@@ -28,7 +28,6 @@
 SKIP_OPTIONS = {
     "default_devices",
     "fuzzing_engine",
-    "qemu_suffix",
     "smbd",
 }
 
@@ -40,6 +39,7 @@
     "malloc": "enable-malloc",
     "pkgversion": "with-pkgversion",
     "qemu_firmwarepath": "firmwarepath",
+    "qemu_suffix": "with-suffix",
     "trace_backends": "enable-trace-backends",
     "trace_file": "with-trace-file",
 }
@@ -52,6 +52,7 @@
 BUILTIN_OPTIONS = {
     "b_coverage",
     "b_lto",
+    "bindir",
     "datadir",
     "debug",
     "includedir",
@@ -60,6 +61,7 @@
     "localedir",
     "localstatedir",
     "mandir",
+    "prefix",
     "strip",
     "sysconfdir",
 }
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 22d69966606..e1522030619 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -3,6 +3,7 @@ meson_options_help() {
   printf "%s\n" '  --audio-drv-list=CHOICES Set audio driver list [default] (choices: alsa/co'
   printf "%s\n" '                           reaudio/default/dsound/jack/oss/pa/pipewire/sdl/s'
   printf "%s\n" '                           ndio)'
+  printf "%s\n" '  --bindir=VALUE           Executable directory [bin]'
   printf "%s\n" '  --block-drv-ro-whitelist=VALUE'
   printf "%s\n" '                           set block driver read-only whitelist (by default'
   printf "%s\n" '                           affects only QEMU, not tools like qemu-img)'
@@ -62,6 +63,7 @@ meson_options_help() {
   printf "%s\n" '  --localedir=VALUE        Locale data directory [share/locale]'
   printf "%s\n" '  --localstatedir=VALUE    Localstate data directory [/var/local]'
   printf "%s\n" '  --mandir=VALUE           Manual page directory [share/man]'
+  printf "%s\n" '  --prefix=VALUE           Installation prefix [/usr/local]'
   printf "%s\n" '  --sysconfdir=VALUE       Sysconf data directory [etc]'
   printf "%s\n" '  --tls-priority=VALUE     Default TLS protocol/cipher priority string'
   printf "%s\n" '                           [NORMAL]'
@@ -69,6 +71,8 @@ meson_options_help() {
   printf "%s\n" '                           auto/sigaltstack/ucontext/windows)'
   printf "%s\n" '  --with-pkgversion=VALUE  use specified string as sub-version of the'
   printf "%s\n" '                           package'
+  printf "%s\n" '  --with-suffix=VALUE      Suffix for QEMU data/modules/config directories'
+  printf "%s\n" '                           (can be empty) [qemu]'
   printf "%s\n" '  --with-trace-file=VALUE  Trace file prefix for simple backend [trace]'
   printf "%s\n" ''
   printf "%s\n" 'Optional features, enabled with --enable-FEATURE and'
@@ -229,6 +233,7 @@ _meson_option_parse() {
     --disable-gcov) printf "%s" -Db_coverage=false ;;
     --enable-lto) printf "%s" -Db_lto=true ;;
     --disable-lto) printf "%s" -Db_lto=false ;;
+    --bindir=*) quote_sh "-Dbindir=$2" ;;
     --enable-blkio) printf "%s" -Dblkio=enabled ;;
     --disable-blkio) printf "%s" -Dblkio=disabled ;;
     --block-drv-ro-whitelist=*) quote_sh "-Dblock_drv_ro_whitelist=$2" ;;
@@ -407,6 +412,7 @@ _meson_option_parse() {
     --disable-plugins) printf "%s" -Dplugins=false ;;
     --enable-png) printf "%s" -Dpng=enabled ;;
     --disable-png) printf "%s" -Dpng=disabled ;;
+    --prefix=*) quote_sh "-Dprefix=$2" ;;
     --enable-pvrdma) printf "%s" -Dpvrdma=enabled ;;
     --disable-pvrdma) printf "%s" -Dpvrdma=disabled ;;
     --enable-qcow1) printf "%s" -Dqcow1=enabled ;;
@@ -414,6 +420,7 @@ _meson_option_parse() {
     --enable-qed) printf "%s" -Dqed=enabled ;;
     --disable-qed) printf "%s" -Dqed=disabled ;;
     --firmwarepath=*) quote_sh "-Dqemu_firmwarepath=$(meson_option_build_array $2)" ;;
+    --with-suffix=*) quote_sh "-Dqemu_suffix=$2" ;;
     --enable-qga-vss) printf "%s" -Dqga_vss=enabled ;;
     --disable-qga-vss) printf "%s" -Dqga_vss=disabled ;;
     --enable-qom-cast-debug) printf "%s" -Dqom_cast_debug=true ;;
-- 
2.41.0



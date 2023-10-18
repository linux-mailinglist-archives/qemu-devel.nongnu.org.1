Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA93E7CD67B
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:30:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1wB-00046Q-Sj; Wed, 18 Oct 2023 04:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1vV-0002mB-JA
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:29:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1vO-0003jc-FZ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CLjhPjGdV9P1B3Px9THOBvhOzGu2EdgUFKT1l6imsao=;
 b=HptOqUraNsBt5NPOlDe0A5FJo3Y1Zjkl4ldXHdtfS0JMbMBmq6KDVHE0US5rQBk9SAasqy
 f+SYcUqFLiJiTrntMoHpFN1DQmXwFfbMCBxPg4DsTgnQ+x2UDZ5gcyVE41wtYh+nR9+CU1
 i+pBQrhYGv6eSEQQrYvYb3MxDj4qqHU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-H-cscebAPjSm7Zd13AhaFA-1; Wed, 18 Oct 2023 04:28:44 -0400
X-MC-Unique: H-cscebAPjSm7Zd13AhaFA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9b65c46bca8so192462366b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617722; x=1698222522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CLjhPjGdV9P1B3Px9THOBvhOzGu2EdgUFKT1l6imsao=;
 b=XF/627KKm20H3wAOFe15h8Oe3rsuw/pJzSiszaRU93HTaezDWh5uiopCsO4Y7VMFii
 Ir3ZtyF4lrdTFImzKyVUmE1evRqN804kzh9hC36MD01TI1XW6sFdO2Arc8q7wZXj8hOX
 iahv9usPU2oTQbqp5GmXm5ngAGsN/dmi725pEa/0hoKN+rmJQoGZcqk5/H7BKbJH8etJ
 SMs1GE1gIMFimHzjAurUgEGUvxHmKKp/JWLp+A1u2OiuKNhj8JNl1/kECQNlXu4elKfd
 kfPGNcIZ07SiFEv4+GweAnNIGLaHFerjgkDSwsvyRkSfefNI20itRbuJACtkA9O+0DtU
 T6gA==
X-Gm-Message-State: AOJu0YyVsLHFGT3M+0KmfULpjcaugb+UZAME7fRlT/M5DvwaPVqVxdKp
 YD88UcXBZywfOWYUAsq0G78LaZ0kbzvuPqWQhz8wUsAgNg3KNhbaMHBYdBAFGN0Ko0627XmJhc3
 eWhxyqjiN7iCH8s4xT3vXgUjGU/ohSdqApAM6S6C12OG2jSe8mZZP5uqLOXlCBkgb+LB4QvArg+
 Q=
X-Received: by 2002:a50:d089:0:b0:53e:78ed:924d with SMTP id
 v9-20020a50d089000000b0053e78ed924dmr3269023edd.5.1697617722242; 
 Wed, 18 Oct 2023 01:28:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPloHHYZwPPJVwJddu13Hk8N3sRPc7XoS+GYFHln7cn2yBDCHULnclwC5PuVZUrYr/uDE0DA==
X-Received: by 2002:a50:d089:0:b0:53e:78ed:924d with SMTP id
 v9-20020a50d089000000b0053e78ed924dmr3269013edd.5.1697617721778; 
 Wed, 18 Oct 2023 01:28:41 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 cf14-20020a0564020b8e00b0053e0395059csm2374872edb.21.2023.10.18.01.28.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/32] configure: move target-specific defaults to an external
 machine file
Date: Wed, 18 Oct 2023 10:27:46 +0200
Message-ID: <20231018082752.322306-27-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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
 configure                     | 37 ++++++++++++++---------------------
 scripts/meson-buildoptions.py |  4 +++-
 scripts/meson-buildoptions.sh |  7 +++++++
 4 files changed, 34 insertions(+), 23 deletions(-)
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
index 0994f54530c..8f23c8d1655 100755
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
@@ -583,9 +580,6 @@ done
 
 if test "$targetos" = "windows" ; then
   EXESUF=".exe"
-  prefix="/qemu"
-  bindir=""
-  qemu_suffix=""
 fi
 
 meson_option_build_array() {
@@ -622,6 +616,14 @@ meson_option_parse() {
   fi
 }
 
+meson_add_machine_file() {
+  if test "$cross_compile" = "yes"; then
+    meson_option_add --cross-file "$1"
+  else
+    meson_option_add --native-file "$1"
+  fi
+}
+
 for opt do
   optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
   case "$opt" in
@@ -629,8 +631,6 @@ for opt do
   ;;
   --version|-V) exec cat "$source_path/VERSION"
   ;;
-  --prefix=*) prefix="$optarg"
-  ;;
   --cross-prefix=*)
   ;;
   --cc=*)
@@ -701,10 +701,6 @@ for opt do
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
@@ -861,7 +857,6 @@ Options: [defaults in brackets after descriptions]
 
 Standard options:
   --help                   print this message
-  --prefix=PREFIX          install in PREFIX [$prefix]
   --target-list=LIST       set target list (default: build all)
 $(echo Available targets: $default_target_list | \
   fold -s -w 53 | sed -e 's/^/                           /')
@@ -886,8 +881,6 @@ Advanced options (experts only):
   --ninja=NINJA            use specified ninja [$ninja]
   --smbd=SMBD              use specified smbd [$smbd]
   --static                 enable static build [$static]
-  --bindir=PATH            install binaries in PATH
-  --with-suffix=SUFFIX     suffix for QEMU data inside datadir/libdir/sysconfdir/docdir [$qemu_suffix]
   --without-default-features default all --enable-* options to "disabled"
   --without-default-devices  do not include any device that is not needed to
                            start the emulator (only use if you are including
@@ -1803,24 +1796,25 @@ if test "$skip_meson" = no; then
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
@@ -1831,11 +1825,10 @@ if test "$skip_meson" = no; then
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



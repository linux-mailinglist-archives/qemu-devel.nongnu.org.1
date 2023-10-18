Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AB07CD688
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:31:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1vD-00027L-Kj; Wed, 18 Oct 2023 04:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1v7-0001yn-4p
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1v5-0003hb-78
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/FD6YHefX6SOYwoQaJDUAPYd5JubXHFuESbVNleb6xc=;
 b=BxVS87pHZuk7on9kyaxmX2gN7o7G51blD8izunTqoUcoplQX0yJCMvCX4JPJWCbVyHWtxD
 GjRN7RssjELxl5/IIsqXueG/EYfsFZQ7LUW1raTTTy2w56UlQ3ODRcRFbXRovREASD6AzG
 PdG3ebgsXf08JM5103vI/4DU7eNmF3Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-hI845pAtOQ22PJ-VGGYCcA-1; Wed, 18 Oct 2023 04:28:45 -0400
X-MC-Unique: hI845pAtOQ22PJ-VGGYCcA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-993eeb3a950so433537766b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617724; x=1698222524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/FD6YHefX6SOYwoQaJDUAPYd5JubXHFuESbVNleb6xc=;
 b=CZg8eMgM+t/rvgP5Z7+f47u+5gjMr9DWXVVOvZXieZ333DgM5omm+ZAkvVHVetTpYI
 Bg4uY4ts7hxIA0CAoUYbd08UZTCSdRr42PxwOtxsA8YcFB81DyDHimvM7qVINR4t4sh4
 QXur8ZYaoXWolmE7wpwgwFo37CyjqqHreyKmg32sGA9QT2C5jHUsqzRWLu22WOxNn8Qx
 T961ukLhZcRf+n/DcWFVwEe5IrkJXx6jtDR7/rs6eeaKvju/f73q2MvFcm8Hq1O7XcWo
 8IBYJ7NKmmoMILYcbSZbAgjrK4mw7r6ek7G690J3WmAqFl37lddX7CPnWb27djsYVebA
 xF3g==
X-Gm-Message-State: AOJu0Yz/h9Ac56zhNLtagivHpdr5cymYj6pHk7pd8szckJpYkb2RMnX4
 i3y3oLHu7GJzmjMdMNr1FOlidJh4qADeWJIVZxFNVoDZdVaJ5nnJf8qmC55D1mhE+LpA5LVNoTn
 GOpRvFkUreu63vjCJb9FGDc1qC2D+yGfAWdVzu3ztsysUyBou/pCkKBfHflq6oB0YWRHMUQEC4P
 0=
X-Received: by 2002:a17:907:a48b:b0:9c7:5437:841e with SMTP id
 vp11-20020a170907a48b00b009c75437841emr121170ejc.11.1697617723372; 
 Wed, 18 Oct 2023 01:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFIgYQ9/lGLrwQCgAmcp3hdcER7cHfhSfHMfuF6LDiCBSXJkuTjYsZlf28pLGi8+OmT0OyvQ==
X-Received: by 2002:a17:907:a48b:b0:9c7:5437:841e with SMTP id
 vp11-20020a170907a48b00b009c75437841emr121160ejc.11.1697617722997; 
 Wed, 18 Oct 2023 01:28:42 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a170906b20400b009c7518b131dsm452609ejz.196.2023.10.18.01.28.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/32] configure: move environment-specific defaults to
 config-meson.cross
Date: Wed, 18 Oct 2023 10:27:47 +0200
Message-ID: <20231018082752.322306-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Store the -Werror and SMBD defaults in the machine file, which still allows
them to be overridden on the command line and enables automatic parsing
of the related options.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                     | 37 +++++++++++++----------------------
 scripts/meson-buildoptions.py |  3 ++-
 scripts/meson-buildoptions.sh |  5 +++++
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/configure b/configure
index 8f23c8d1655..200570a3d18 100755
--- a/configure
+++ b/configure
@@ -258,7 +258,6 @@ skip_meson=no
 use_containers="yes"
 gdb_bin=$(command -v "gdb-multiarch" || command -v "gdb")
 gdb_arches=""
-werror=""
 
 # Don't accept a target_list environment variable.
 unset target_list
@@ -314,7 +313,6 @@ objcopy="${OBJCOPY-${cross_prefix}objcopy}"
 ld="${LD-${cross_prefix}ld}"
 ranlib="${RANLIB-${cross_prefix}ranlib}"
 nm="${NM-${cross_prefix}nm}"
-smbd="$SMBD"
 strip="${STRIP-${cross_prefix}strip}"
 widl="${WIDL-${cross_prefix}widl}"
 windres="${WINDRES-${cross_prefix}windres}"
@@ -651,8 +649,6 @@ for opt do
   ;;
   --ninja=*) ninja="$optarg"
   ;;
-  --smbd=*) smbd="$optarg"
-  ;;
   --extra-cflags=*)
   ;;
   --extra-cxxflags=*)
@@ -744,10 +740,6 @@ for opt do
   ;;
   --disable-pie) pie="no"
   ;;
-  --enable-werror) werror="yes"
-  ;;
-  --disable-werror) werror="no"
-  ;;
   --enable-cfi) cfi=true
   ;;
   --disable-cfi) cfi=false
@@ -879,7 +871,6 @@ Advanced options (experts only):
   --cross-prefix-ARCH=PREFIX cross compiler prefix when building ARCH guest test cases
   --python=PYTHON          use specified python [$python]
   --ninja=NINJA            use specified ninja [$ninja]
-  --smbd=SMBD              use specified smbd [$smbd]
   --static                 enable static build [$static]
   --without-default-features default all --enable-* options to "disabled"
   --without-default-devices  do not include any device that is not needed to
@@ -887,7 +878,6 @@ Advanced options (experts only):
                            desired devices in configs/devices/)
   --with-devices-ARCH=NAME override default configs/devices
   --enable-debug           enable common debug build options
-  --disable-werror         disable compilation abort on warning
   --cpu=CPU                Build for host CPU [$cpu]
   --disable-containers     don't use containers for cross-building
   --container-engine=TYPE  which container engine to use [$container_engine]
@@ -1011,17 +1001,6 @@ if test -z "$ninja"; then
     fi
 fi
 
-# Consult white-list to determine whether to enable werror
-# by default.  Only enable by default for git builds
-if test -z "$werror" ; then
-    if test -e "$source_path/.git" && \
-        { test "$targetos" = linux || test "$targetos" = "windows"; }; then
-        werror="yes"
-    else
-        werror="no"
-    fi
-fi
-
 if test "$targetos" = "bogus"; then
     # Now that we know that we're not printing the help and that
     # the compiler works (so the results of the check_defines we used
@@ -1764,6 +1743,20 @@ if test "$skip_meson" = no; then
   test -n "$objcc" && echo "objc_args = [$(meson_quote $OBJCFLAGS $EXTRA_OBJCFLAGS)]" >> $cross
   echo "c_link_args = [$(meson_quote $CFLAGS $LDFLAGS $EXTRA_CFLAGS $EXTRA_LDFLAGS)]" >> $cross
   echo "cpp_link_args = [$(meson_quote $CXXFLAGS $LDFLAGS $EXTRA_CXXFLAGS $EXTRA_LDFLAGS)]" >> $cross
+
+  # Only enable by default for git builds and on select OSes
+  echo "# environment defaults, can still be overridden on " >> $cross
+  echo "# the command line" >> $cross
+  if test -e "$source_path/.git" && \
+      { test "$targetos" = linux || test "$targetos" = "windows"; }; then
+      echo 'werror = true' >> $cross
+  fi
+  echo "[project options]" >> $cross
+  if test "$SMBD" != ''; then
+    echo "smbd = $(meson_quote "$SMBD")" >> $cross
+  fi
+
+  echo >> $cross
   echo "[binaries]" >> $cross
   echo "c = [$(meson_quote $cc $CPU_CFLAGS)]" >> $cross
   test -n "$cxx" && echo "cpp = [$(meson_quote $cxx $CPU_CFLAGS)]" >> $cross
@@ -1818,14 +1811,12 @@ if test "$skip_meson" = no; then
   test "$default_feature" = no && meson_option_add -Dauto_features=disabled
   test "$static" = yes && meson_option_add -Dprefer_static=true
   test "$pie" = no && meson_option_add -Db_pie=false
-  test "$werror" = yes && meson_option_add -Dwerror=true
 
   # QEMU options
   test "$cfi" != false && meson_option_add "-Dcfi=$cfi" "-Db_lto=$cfi"
   test "$docs" != auto && meson_option_add "-Ddocs=$docs"
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
   test "$plugins" = yes && meson_option_add "-Dplugins=true"
-  test "$smbd" != '' && meson_option_add "-Dsmbd=$smbd"
   test "$tcg" != enabled && meson_option_add "-Dtcg=$tcg"
   run_meson() {
     NINJA=$ninja $meson setup "$@" "$PWD" "$source_path"
diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
index 0c24bdc1e8c..2e88732a291 100644
--- a/scripts/meson-buildoptions.py
+++ b/scripts/meson-buildoptions.py
@@ -28,7 +28,6 @@
 SKIP_OPTIONS = {
     "default_devices",
     "fuzzing_engine",
-    "smbd",
 }
 
 OPTION_NAMES = {
@@ -47,6 +46,7 @@
 # Options that configure autodetects, even though meson defines them as boolean
 AUTO_OPTIONS = {
     "plugins",
+    "werror",
 }
 
 BUILTIN_OPTIONS = {
@@ -64,6 +64,7 @@
     "prefix",
     "strip",
     "sysconfdir",
+    "werror",
 }
 
 LINE_WIDTH = 76
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index e1522030619..dec33820163 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -64,6 +64,7 @@ meson_options_help() {
   printf "%s\n" '  --localstatedir=VALUE    Localstate data directory [/var/local]'
   printf "%s\n" '  --mandir=VALUE           Manual page directory [share/man]'
   printf "%s\n" '  --prefix=VALUE           Installation prefix [/usr/local]'
+  printf "%s\n" '  --smbd=VALUE             Path to smbd for slirp networking'
   printf "%s\n" '  --sysconfdir=VALUE       Sysconf data directory [etc]'
   printf "%s\n" '  --tls-priority=VALUE     Default TLS protocol/cipher priority string'
   printf "%s\n" '                           [NORMAL]'
@@ -205,6 +206,7 @@ meson_options_help() {
   printf "%s\n" '  vpc             vpc image format support'
   printf "%s\n" '  vte             vte support for the gtk UI'
   printf "%s\n" '  vvfat           vvfat image format support'
+  printf "%s\n" '  werror          Treat warnings as errors'
   printf "%s\n" '  whpx            WHPX acceleration support'
   printf "%s\n" '  xen             Xen backend support'
   printf "%s\n" '  xen-pci-passthrough'
@@ -453,6 +455,7 @@ _meson_option_parse() {
     --disable-slirp-smbd) printf "%s" -Dslirp_smbd=disabled ;;
     --enable-smartcard) printf "%s" -Dsmartcard=enabled ;;
     --disable-smartcard) printf "%s" -Dsmartcard=disabled ;;
+    --smbd=*) quote_sh "-Dsmbd=$2" ;;
     --enable-snappy) printf "%s" -Dsnappy=enabled ;;
     --disable-snappy) printf "%s" -Dsnappy=disabled ;;
     --enable-sndio) printf "%s" -Dsndio=enabled ;;
@@ -529,6 +532,8 @@ _meson_option_parse() {
     --disable-vte) printf "%s" -Dvte=disabled ;;
     --enable-vvfat) printf "%s" -Dvvfat=enabled ;;
     --disable-vvfat) printf "%s" -Dvvfat=disabled ;;
+    --enable-werror) printf "%s" -Dwerror=true ;;
+    --disable-werror) printf "%s" -Dwerror=false ;;
     --enable-whpx) printf "%s" -Dwhpx=enabled ;;
     --disable-whpx) printf "%s" -Dwhpx=disabled ;;
     --enable-xen) printf "%s" -Dxen=enabled ;;
-- 
2.41.0



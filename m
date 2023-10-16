Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C667C9FA9
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:33:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH9M-0004cW-Me; Mon, 16 Oct 2023 02:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH9I-0004Ni-TL
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH9H-0005WU-0d
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:32:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7wRraFOki6xoNL40X+dNtMD9Sl5rl5qNKGPpTlgSs3w=;
 b=YKOtLoldTyWnWGHRxsRRC3BoL8kHUzaQ2zZ5+vmazvuIXUQhBqB2IAvfAX4oXQrS6nXNsC
 VUzlvepFFb4XLvTFTvjeYz6SEwqWeGUKt2Kt2Y50gLnCGxfXzdrqY9meMnphSDNe8zds+H
 7cGFFs9t/HRJa23Jcqi+xaMIqMg9cb4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-sQUOtt8cPhyXo6EiGol3TA-1; Mon, 16 Oct 2023 02:31:56 -0400
X-MC-Unique: sQUOtt8cPhyXo6EiGol3TA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9ae686dafedso294022266b.3
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:31:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437915; x=1698042715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7wRraFOki6xoNL40X+dNtMD9Sl5rl5qNKGPpTlgSs3w=;
 b=P2ddQ86C16kBz+VIXtcH0hUv3LDjqmkmyXdaEM0pQOmSqblYfg6Skg9uBgLYacCJAH
 9sWDa+QRovVO0Vs25nQIRghVqxgFB9GCL0AzSkSOexlkBZPX6ZSu0LpNPIbnfRA5TvzL
 oWvFmjnj8+7gZUHuZxk//d8cmVFjief/EQ7aZB/sBt56H4m8CFH9Yf8n5etqYJVuEp5b
 ZpdffxaWcN5xN2jN1Ljs/uLQug7jk3maxlj1Del3UxkTVZ27QClzAO5tsZh8DA3+fTaf
 RYy9hdZ79wLFSXKjiooERwrcRA6C83SM2MhwM80bJf8ZlQCTaDW5Na2mmDG26btQsULC
 MCaw==
X-Gm-Message-State: AOJu0YyCywayYHd82YJqICoFo8XThlxk7WNGJXKd0wt9iRQnCZTTr5wV
 4nwkwuAzKqRQrQ0+WJuEqWYEqoGvkVLlZ/kgU/3cIociAyTqQ9xqDNWoHarNlY+TofzWmNq3BvT
 1L9HWCspw0GJrvo/mil7CYkFLkDN0ZT9XQlG/iAhvns0qzX93DDdayCldbVEzzgoZCGT5d4Zr2u
 I=
X-Received: by 2002:a17:907:7ea4:b0:9be:3c01:f061 with SMTP id
 qb36-20020a1709077ea400b009be3c01f061mr5926056ejc.66.1697437915055; 
 Sun, 15 Oct 2023 23:31:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDh0bkkHAtP4yyEz6JHjdj3iaffOzC4o8eVcMtCWQIYIqfGqSxm50IMbl3/zH0yJI+TtVsbQ==
X-Received: by 2002:a17:907:7ea4:b0:9be:3c01:f061 with SMTP id
 qb36-20020a1709077ea400b009be3c01f061mr5926044ejc.66.1697437914697; 
 Sun, 15 Oct 2023 23:31:54 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 f25-20020a170906085900b009ae0042e48bsm3346343ejd.5.2023.10.15.23.31.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:31:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/17] configure: move environment-specific defaults to
 config-meson.cross
Date: Mon, 16 Oct 2023 08:31:23 +0200
Message-ID: <20231016063127.161204-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016063127.161204-1-pbonzini@redhat.com>
References: <20231016063127.161204-1-pbonzini@redhat.com>
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
index e6787dc4111..24f8866e141 100755
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
@@ -648,8 +646,6 @@ for opt do
   ;;
   --ninja=*) ninja="$optarg"
   ;;
-  --smbd=*) smbd="$optarg"
-  ;;
   --extra-cflags=*)
   ;;
   --extra-cxxflags=*)
@@ -741,10 +737,6 @@ for opt do
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
@@ -876,7 +868,6 @@ Advanced options (experts only):
   --cross-prefix-ARCH=PREFIX cross compiler prefix when building ARCH guest test cases
   --python=PYTHON          use specified python [$python]
   --ninja=NINJA            use specified ninja [$ninja]
-  --smbd=SMBD              use specified smbd [$smbd]
   --static                 enable static build [$static]
   --without-default-features default all --enable-* options to "disabled"
   --without-default-devices  do not include any device that is not needed to
@@ -884,7 +875,6 @@ Advanced options (experts only):
                            desired devices in configs/devices/)
   --with-devices-ARCH=NAME override default configs/devices
   --enable-debug           enable common debug build options
-  --disable-werror         disable compilation abort on warning
   --cpu=CPU                Build for host CPU [$cpu]
   --disable-containers     don't use containers for cross-building
   --container-engine=TYPE  which container engine to use [$container_engine]
@@ -1008,17 +998,6 @@ if test -z "$ninja"; then
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
@@ -1761,6 +1740,20 @@ if test "$skip_meson" = no; then
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
@@ -1815,7 +1808,6 @@ if test "$skip_meson" = no; then
   test "$default_feature" = no && meson_option_add -Dauto_features=disabled
   test "$static" = yes && meson_option_add -Dprefer_static=true
   test "$pie" = no && meson_option_add -Db_pie=false
-  test "$werror" = yes && meson_option_add -Dwerror=true
 
   # QEMU options
   test "$cfi" != false && meson_option_add "-Dcfi=$cfi"
@@ -1823,7 +1815,6 @@ if test "$skip_meson" = no; then
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



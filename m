Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4D57C9FA8
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:33:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH90-00041K-0Y; Mon, 16 Oct 2023 02:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8x-000405-IK
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8u-0005TD-Va
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QEBhg/nis2v2E6TOtez7OB+wequT7+FUk6KnJtqVqLQ=;
 b=XBIIPSh2p7wHw/8KxUKuNtEwuOmcCUbUSMDoXuoR1awGxbcBRUS3QOfhe//2i4tpTv2q5/
 v9+4EaMvOj56dDDNo5WIftjc0Zmany4JvSg78WXTDjh7IYlvRiQqdXBXRFUzoavYUBWyJG
 xc5+oKqfF+3Sudbm+oLgWG6DuwItO2A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-20BsEUevO1eosAyHqBxjrA-1; Mon, 16 Oct 2023 02:31:48 -0400
X-MC-Unique: 20BsEUevO1eosAyHqBxjrA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9bf8678af70so79786566b.2
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437907; x=1698042707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QEBhg/nis2v2E6TOtez7OB+wequT7+FUk6KnJtqVqLQ=;
 b=r0d7YNi2/GwbOPLbe/AGcV55jghIJNOXteqUafLwgHE4aZrz2Ro40gITaiRo1JhSwm
 J2m049HdJbrxzyTUMdDiHcdErPXEFiD1NPMsJSwt7HGrtUne2K5zxVFZ1ObydUbfP18s
 jZxX2YhcMSYomJCtJSYvVdvp9GRKF+1GvMq/LfNtVWex/DRHTF/2QoydFcDsbFHpFH7T
 SKiUaprvXbZoHKZv6cTbDeIZCGePnloljKX3e1QBHTg2PpssQIt89HeG8TV3KTjKo1Ma
 WO7PREWndrDGg2fDdxieG+i8zKIfbNEOfWIRJculfo5+9pGZJu2e3Q/UDlaU9N32haEC
 7RBA==
X-Gm-Message-State: AOJu0YwObkRu6hBnCDY3Rlv5Vl+FFfqMoM/Ir+3OOsVGMmn3jEGrZQ0Y
 6tRBEqDbXEBG+YW/xNSvki/fz5zuJOkKS3UbPB1ym+sA/b/Nsa7sGUyCL6moKc/uCwpGUJDWGda
 fA6rh7tUccwhV0EFYm5q+8LUUQETv+VZm07eHwc/UTDPhPWzwWbLJ8aT+LZPVaMP6FYXidunFAa
 E=
X-Received: by 2002:a17:906:1092:b0:9bd:8cfd:e588 with SMTP id
 u18-20020a170906109200b009bd8cfde588mr9430116eju.27.1697437907116; 
 Sun, 15 Oct 2023 23:31:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8iKsTJyQLe9NFzfJuJFc04u+LWkH7wByxPCpsdCjH86lkpHt8yWbA1G7Jd7O3KRQAVN8/8w==
X-Received: by 2002:a17:906:1092:b0:9bd:8cfd:e588 with SMTP id
 u18-20020a170906109200b009bd8cfde588mr9430104eju.27.1697437906806; 
 Sun, 15 Oct 2023 23:31:46 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 jz28-20020a17090775fc00b009b29553b648sm3285597ejc.206.2023.10.15.23.31.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:31:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/17] configure: clean up plugin option handling
Date: Mon, 16 Oct 2023 08:31:19 +0200
Message-ID: <20231016063127.161204-10-pbonzini@redhat.com>
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

Keep together all the conditions that lead to disabling plugins, and
remove now-dead code.

Since the option was not in SKIP_OPTIONS, it was present twice in
the help message, both from configure and from meson-buildoptions.sh.
Remove the duplication and take the occasion to document the option as
autodetected, which it is.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                     | 39 +++++++++++++++--------------------
 scripts/meson-buildoptions.py | 17 ++++++++++-----
 scripts/meson-buildoptions.sh |  2 +-
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/configure b/configure
index 732220fdd45..7dad78f329b 100755
--- a/configure
+++ b/configure
@@ -377,7 +377,6 @@ fi
 
 case $targetos in
 windows)
-  plugins="no"
   pie="no"
 ;;
 haiku)
@@ -737,7 +736,6 @@ for opt do
       default_cflags='-O0 -g'
   ;;
   --disable-tcg) tcg="disabled"
-                 plugins="no"
   ;;
   --enable-tcg) tcg="enabled"
   ;;
@@ -774,11 +772,7 @@ for opt do
   ;;
   --enable-download) download="enabled"; git_submodules_action=update;
   ;;
-  --enable-plugins) if test "$targetos" = "windows"; then
-                        error_exit "TCG plugins not currently supported on Windows platforms"
-                    else
-                        plugins="yes"
-                    fi
+  --enable-plugins) plugins="yes"
   ;;
   --disable-plugins) plugins="no"
   ;;
@@ -804,11 +798,6 @@ then
     git_submodules_action="validate"
 fi
 
-# test for any invalid configuration combinations
-if test "$plugins" = "yes" -a "$tcg" = "disabled"; then
-    error_exit "Can't enable plugins on non-TCG builds"
-fi
-
 if ! test -f "$source_path/subprojects/keycodemapdb/README" \
     && test "$download" = disabled
 then
@@ -919,8 +908,6 @@ Advanced options (experts only):
   --enable-debug           enable common debug build options
   --disable-werror         disable compilation abort on warning
   --cpu=CPU                Build for host CPU [$cpu]
-  --enable-plugins
-                           enable plugins via shared library loading
   --disable-containers     don't use containers for cross-building
   --container-engine=TYPE  which container engine to use [$container_engine]
   --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
@@ -1062,15 +1049,27 @@ if test "$targetos" = "bogus"; then
     error_exit "Unrecognized host OS (uname -s reports '$(uname -s)')"
 fi
 
+# test for any invalid configuration combinations
+if test "$targetos" = "windows"; then
+  if test "$plugins" = "yes"; then
+    error_exit "TCG plugins not currently supported on Windows platforms"
+  fi
+  plugins="no"
+fi
+if test "$tcg" = "disabled" ; then
+  if test "$plugins" = "yes"; then
+    error_exit "Can't enable plugins on non-TCG builds"
+  fi
+  plugins="no"
+fi
 if test "$static" = "yes" ; then
   if test "$plugins" = "yes"; then
     error_exit "static and plugins are mutually incompatible"
-  else
-    plugins="no"
   fi
+  plugins="no"
 fi
-test "$plugins" = "" && plugins=yes
-if test "$plugins" = "yes"; then
+if test "$plugins" != "no"; then
+  plugins=yes
   subdirs="$subdirs contrib/plugins"
 fi
 
@@ -1713,10 +1712,6 @@ mkdir -p tests/tcg
 echo "# Automatically generated by configure - do not modify" > $config_host_mak
 echo "SRC_PATH=$source_path" >> $config_host_mak
 
-if test "$plugins" = "yes" ; then
-    echo "CONFIG_PLUGIN=y" >> $config_host_mak
-fi
-
 tcg_tests_targets=
 for target in $target_list; do
   arch=${target%%-*}
diff --git a/scripts/meson-buildoptions.py b/scripts/meson-buildoptions.py
index 8d2e526132a..b787c84e914 100644
--- a/scripts/meson-buildoptions.py
+++ b/scripts/meson-buildoptions.py
@@ -44,6 +44,11 @@
     "trace_file": "with-trace-file",
 }
 
+# Options that configure autodetects, even though meson defines them as boolean
+AUTO_OPTIONS = {
+    "plugins",
+}
+
 BUILTIN_OPTIONS = {
     "b_coverage",
     "b_lto",
@@ -168,6 +173,7 @@ def cli_metavar(opt):
 
 def print_help(options):
     print("meson_options_help() {")
+    feature_opts = []
     for opt in sorted(options, key=cli_help_key):
         key = cli_help_key(opt)
         # The first section includes options that have an arguments,
@@ -176,7 +182,7 @@ def print_help(options):
             metavar = cli_metavar(opt)
             left = f"--{key}={metavar}"
             help_line(left, opt, 27, True)
-        elif opt["type"] == "boolean":
+        elif opt["type"] == "boolean" and opt["name"] not in AUTO_OPTIONS:
             left = f"--{key}"
             help_line(left, opt, 27, False)
         elif allow_arg(opt):
@@ -185,16 +191,17 @@ def print_help(options):
             else:
                 left = f"--{key}=CHOICE"
             help_line(left, opt, 27, True)
+        else:
+            feature_opts.append(opt)
 
     sh_print()
     sh_print("Optional features, enabled with --enable-FEATURE and")
     sh_print("disabled with --disable-FEATURE, default is enabled if available")
     sh_print("(unless built with --without-default-features):")
     sh_print()
-    for opt in options:
-        key = opt["name"].replace("_", "-")
-        if opt["type"] != "boolean" and not allow_arg(opt):
-            help_line(key, opt, 18, False)
+    for opt in sorted(feature_opts, key=cli_option):
+        key = cli_option(opt)
+        help_line(key, opt, 18, False)
     print("}")
 
 
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index d4b89e6b443..22d69966606 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -40,7 +40,6 @@ meson_options_help() {
   printf "%s\n" '                           jemalloc/system/tcmalloc)'
   printf "%s\n" '  --enable-module-upgrades try to load modules from alternate paths for'
   printf "%s\n" '                           upgrades'
-  printf "%s\n" '  --enable-plugins         TCG plugins via shared library loading'
   printf "%s\n" '  --enable-rng-none        dummy RNG, avoid using /dev/(u)random and'
   printf "%s\n" '                           getrandom()'
   printf "%s\n" '  --enable-safe-stack      SafeStack Stack Smash Protection (requires'
@@ -149,6 +148,7 @@ meson_options_help() {
   printf "%s\n" '  pa              PulseAudio sound support'
   printf "%s\n" '  parallels       parallels image format support'
   printf "%s\n" '  pipewire        PipeWire sound support'
+  printf "%s\n" '  plugins         TCG plugins via shared library loading'
   printf "%s\n" '  png             PNG support with libpng'
   printf "%s\n" '  pvrdma          Enable PVRDMA support'
   printf "%s\n" '  qcow1           qcow1 image format support'
-- 
2.41.0



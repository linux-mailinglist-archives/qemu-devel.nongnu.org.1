Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C94DA7CD6B0
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:34:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1vI-0002I4-To; Wed, 18 Oct 2023 04:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1vB-00027R-Kz
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1v9-0003i6-NX
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lOV11LHJmh8G61u7keMaCTfvvIJIPpPLJVUoEioDRH8=;
 b=WB+V/7O8p4t92y5TQO1swqCFT9PXIuZ2wKpNEgBK/x/340VKYX6SChgujx6QoNjDK8ZJRd
 a0zCBzIf6UcW9u7Dg1DNtP2aDOK0ZXVSnnxpXNH0Jy7kiztlOzDgi0lG9RUBGDqbMGdse1
 tuhvyJbPOvRK7zbM93tVGU7zIVpYYVU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-ulEYh87qMe6IJ8_uM8vhYw-1; Wed, 18 Oct 2023 04:28:39 -0400
X-MC-Unique: ulEYh87qMe6IJ8_uM8vhYw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9ba247e03aeso461812466b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617718; x=1698222518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lOV11LHJmh8G61u7keMaCTfvvIJIPpPLJVUoEioDRH8=;
 b=axCO6Y/bzCulx0FDHl5RUq0oomV+HbeS5B3WgO1hNEHfUi9ySYt3wksTVNAO328daZ
 1fvc5M23ZUxCH5shspRJLzIywX4fg/gYI5G1gMpwt2aBhFZlLJSdFf+QIyj3GWMpufy+
 3k8IduF6KXQ3oFYlRTt5VDivN+6L4hkukdKFPopUpgmK8wE/rHYAcMPveEldr6DSSGzB
 cUVIZzB1C6haJW3hgc12AV0Vp1ddIkZMjIAXz4A4sbCa+gzJlav0EKBGdFea9+zAe/m6
 GFzbcqyhGE9uAcN79PoijPfLNPD7DVxWzX0V7K8vhe1YyAdbBw40ixz5SEzEnuHQmQMX
 gI1A==
X-Gm-Message-State: AOJu0YxQ+GvSYWUKNWHNITwrOTDfaEhM7elUZFlRFhn4yvtsqRsYoFlz
 3vpM1RlJlrpkyF+iDs2cK7s3CKlgOvnDVmhliK0tFWeFBCsve4klUYXukoFN4oyKhjgrPBiQOL8
 DwEWKPAvbhc2L/HdF4keOoxxlJL+znAxNTTV9RGuM6J9kBxu17Va/EGiuT028BNV1WXqpJyQPfV
 o=
X-Received: by 2002:a17:906:7955:b0:9bd:a73a:7a0a with SMTP id
 l21-20020a170906795500b009bda73a7a0amr3451320ejo.58.1697617717701; 
 Wed, 18 Oct 2023 01:28:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQNuOfxYA1ZdyvPCXpqf/sSdHH+hG4Vcoy/3DqqTCPhz7cZCzpTOp1Sd6ylzTf7A2H5OYIig==
X-Received: by 2002:a17:906:7955:b0:9bd:a73a:7a0a with SMTP id
 l21-20020a170906795500b009bda73a7a0amr3451307ejo.58.1697617717273; 
 Wed, 18 Oct 2023 01:28:37 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 f27-20020a1709062c5b00b0098e78ff1a87sm1174541ejh.120.2023.10.18.01.28.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/32] configure: clean up plugin option handling
Date: Wed, 18 Oct 2023 10:27:43 +0200
Message-ID: <20231018082752.322306-24-pbonzini@redhat.com>
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
index ffcfabb8d36..688577bebd8 100755
--- a/configure
+++ b/configure
@@ -377,7 +377,6 @@ fi
 
 case $targetos in
 windows)
-  plugins="no"
   pie="no"
 ;;
 haiku)
@@ -741,7 +740,6 @@ for opt do
       default_cflags='-O0 -g'
   ;;
   --disable-tcg) tcg="disabled"
-                 plugins="no"
   ;;
   --enable-tcg) tcg="enabled"
   ;;
@@ -778,11 +776,7 @@ for opt do
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
@@ -808,11 +802,6 @@ then
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
@@ -923,8 +912,6 @@ Advanced options (experts only):
   --enable-debug           enable common debug build options
   --disable-werror         disable compilation abort on warning
   --cpu=CPU                Build for host CPU [$cpu]
-  --enable-plugins
-                           enable plugins via shared library loading
   --disable-containers     don't use containers for cross-building
   --container-engine=TYPE  which container engine to use [$container_engine]
   --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
@@ -1066,15 +1053,27 @@ if test "$targetos" = "bogus"; then
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
 
@@ -1717,10 +1716,6 @@ mkdir -p tests/tcg
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



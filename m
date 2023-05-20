Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF2270A622
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 09:24:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0Gv6-0007xD-B6; Sat, 20 May 2023 03:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q0Gv4-0007x4-IN
 for qemu-devel@nongnu.org; Sat, 20 May 2023 03:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q0Gv2-0005I0-7F
 for qemu-devel@nongnu.org; Sat, 20 May 2023 03:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684567342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sZCfGMGLOesec3wgs0sBQSwkmciYc3QkwxJONJ19Ww4=;
 b=VNAwuh1ovZxaDJIXcWxGnqVR8/yX0Bvqldpv1KQvUFM6roDEBd9p98N084ny3C11lYYSxI
 xS6uPSnx7fm2e8X5/h1FX5hFfOsTEXjrr4/6p1feYPlVyQKGOixDsHdmDnD31NMBY8GQBD
 yW3Ikk91ZC0euFULFZpEZTDsCYZVCAs=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-PbT7hrDIMaWOQVSw7zj8SA-1; Sat, 20 May 2023 03:22:21 -0400
X-MC-Unique: PbT7hrDIMaWOQVSw7zj8SA-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-643a1fed384so2510549b3a.3
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 00:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684567340; x=1687159340;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sZCfGMGLOesec3wgs0sBQSwkmciYc3QkwxJONJ19Ww4=;
 b=gOwSsRic6NQ7vY6Zj/liLxOwyC7ksBuKBVBFA5C+nqkC8NQ7rZWCLbqlgu+42VbJC7
 IA1UeIPMEbzMdBEXen7KqKmifPLqOuUDkHORGPUvwBZ4EjaKPGDLj6IwtbqJXL3cOUjU
 P+wzdB1lYhCBiKAAW/tEDNAqjbEWXcLmor5bKyMPfYbdJ/RMS3OIvO6zUlSGIumyKbWW
 ny0QjbNZ0NZ42wjGQ52P6Lbp7IGCv0bRjrhHihuaa29+WsOX2ysqTogtMMxQYnHi+1cG
 Ilzbg9+pCWgHBanrsQONvLqswBTZPJLuxNk+8KTPrwp7oOv7NA+Y7mfWc5byi0SEdSP/
 oFag==
X-Gm-Message-State: AC+VfDzrre7HXxnR29G93wRauTEczT2UyiW1iAmKsuH+uH0hPGmcjgnN
 iWoI4d5Sc9BK14AJu+wPZ/q1Peb/kPR9u/173IZRwf97VlwBHmJAY04i16OJ7mbSvHY0ZqCsTJ/
 uXaZ9KhTwTrpM5mk=
X-Received: by 2002:a05:6a00:2e1e:b0:64a:f730:1552 with SMTP id
 fc30-20020a056a002e1e00b0064af7301552mr6377979pfb.19.1684567339916; 
 Sat, 20 May 2023 00:22:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ53NIPZK79xI91tjtpUd6m0Dy9eICfLELThAFrgDMUxLvBdohZ5GiULt1ZUVIue7uqdAUZL4Q==
X-Received: by 2002:a05:6a00:2e1e:b0:64a:f730:1552 with SMTP id
 fc30-20020a056a002e1e00b0064af7301552mr6377951pfb.19.1684567339525; 
 Sat, 20 May 2023 00:22:19 -0700 (PDT)
Received: from localhost.localdomain ([115.96.105.135])
 by smtp.googlemail.com with ESMTPSA id
 b15-20020a631b4f000000b00534684201b0sm821344pgm.27.2023.05.20.00.22.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 00:22:19 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: alex.bennee@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2] acpi/tests/bios-tables-test: pass iasl path through
 environment variable
Date: Sat, 20 May 2023 12:52:09 +0530
Message-Id: <20230520072209.48766-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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

Currently the meson based QEMU build process locates the iasl binary from the
current PATH and other locations [1] and uses that to set CONFIG_IASL which is
then used by the test.

This has two disadvantages:
 - If iasl was not previously installed in the PATH, one has to install iasl
   and rebuild QEMU in order to pick up the iasl location. One cannot simply
   use the existing bios-tables-test binary because CONFIG_IASL is only set
   during the QEMU build time by meson and then bios-tables-test has to be
   rebuilt with CONFIG_IASL set in order to use iasl.
 - Sometimes, the stock iasl that comes with distributions is simply not good
   enough because it does not support the latest ACPI changes - newly
   introduced tables or new table attributes etc. In order to test ACPI code
   in QEMU, one has to clone the latest acpica upstream repository and
   rebuild iasl in order to get support for it. In those cases, one may want
   the test to use the iasl binary from a non-standard location.

In order to overcome the above two disadvantages, we make CONFIG_IASL an
environment variable that can be set by the meson build system as well as
by the tester. Bios-tables-test then uses this environment variable to set
its iasl location. This way developers can not only point CONFIG_IASL
environment variable to a possibly a non-standard custom build binary
and quickly run bios-tables-test but the meson build system can also set
it to a standard iasl binary that is found in the PATH.

[1] https://mesonbuild.com/Reference-manual_functions.html#find_program

CC: alex.bennee@linaro.org
CC: pbonzini@redhat.com
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 meson.build                    | 10 ----------
 meson_options.txt              |  2 --
 scripts/meson-buildoptions.sh  |  2 --
 tests/qtest/bios-tables-test.c | 16 ++++++++++------
 tests/qtest/meson.build        |  4 ++++
 5 files changed, 14 insertions(+), 20 deletions(-)

changelog:
v2:
addressed comments from v1. CONFIG_IASL is now an environment
variable and no new environment variable is introduced.
Top level meson.build now does not set CONFIG_IASL in the
platform header. References to iasl has been removed from other
files. Test doc is updated. For example:

"to see ASL diff between mismatched files install IASL, set CONFIG_IASL environment variable to the path of iasl binary,
 and run 'QTEST_QEMU_BINARY=<path to QEMU binary to test> V=1 ./tests/qtest/bios-tables-test' from build directory.
 Alternatively run 'V=1 make check-qtest -B' from build dir."


One drawback of this approach is that meson overrides the values
of environment variables that are passed from the OS command line
with the values it sets. So if CONFIG_IASL is passed as an
env variable by the developer while running "make check-qtest" and
meson finds iasl in the path, meson will override the value the
developer provided with the one that it found. I have not seen a
way to check for OS env from meson.build like we do os.environ.get()
in python.
Other than the above, other cases are tested. In absence of iasl,
the developer can provide their own CONFIG_IASL and path to a custom
binary and the test picks it up when run from make check-qtest.
Once iasl is installed, make check-qtest -B will force meson to
retest iasl path and pass it to the test as an enviroinment.
When running the test directly, one has to explicitly pass the path
of iasl in the commnand line as no meson is involved there. There is
no automatic PATH discovery in the test.
  
diff --git a/meson.build b/meson.build
index 25a4b9f2c1..18c7b669d9 100644
--- a/meson.build
+++ b/meson.build
@@ -179,12 +179,6 @@ if 'dtrace' in get_option('trace_backends')
   endif
 endif
 
-if get_option('iasl') == ''
-  iasl = find_program('iasl', required: false)
-else
-  iasl = find_program(get_option('iasl'), required: true)
-endif
-
 ##################
 # Compiler flags #
 ##################
@@ -1791,9 +1785,6 @@ foreach k : get_option('trace_backends')
 endforeach
 config_host_data.set_quoted('CONFIG_TRACE_FILE', get_option('trace_file'))
 config_host_data.set_quoted('CONFIG_TLS_PRIORITY', get_option('tls_priority'))
-if iasl.found()
-  config_host_data.set_quoted('CONFIG_IASL', iasl.full_path())
-endif
 config_host_data.set_quoted('CONFIG_BINDIR', get_option('prefix') / get_option('bindir'))
 config_host_data.set_quoted('CONFIG_PREFIX', get_option('prefix'))
 config_host_data.set_quoted('CONFIG_QEMU_CONFDIR', get_option('prefix') / qemu_confdir)
@@ -3761,7 +3752,6 @@ summary_info += {'sphinx-build':      sphinx_build}
 if config_host.has_key('HAVE_GDB_BIN')
   summary_info += {'gdb':             config_host['HAVE_GDB_BIN']}
 endif
-summary_info += {'iasl':              iasl}
 summary_info += {'genisoimage':       config_host['GENISOIMAGE']}
 if targetos == 'windows' and have_ga
   summary_info += {'wixl':            wixl}
diff --git a/meson_options.txt b/meson_options.txt
index d8330a1f71..9149df8004 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -14,8 +14,6 @@ option('smbd', type : 'string', value : '',
        description: 'Path to smbd for slirp networking')
 option('sphinx_build', type : 'string', value : 'sphinx-build',
        description: 'Use specified sphinx-build for building document')
-option('iasl', type : 'string', value : '',
-       description: 'Path to ACPI disassembler')
 option('tls_priority', type : 'string', value : 'NORMAL',
        description: 'Default TLS protocol/cipher priority string')
 option('default_devices', type : 'boolean', value : true,
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 2805d1c145..98ca2e53af 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -48,7 +48,6 @@ meson_options_help() {
   printf "%s\n" '                           dtrace/ftrace/log/nop/simple/syslog/ust)'
   printf "%s\n" '  --firmwarepath=VALUES    search PATH for firmware files [share/qemu-'
   printf "%s\n" '                           firmware]'
-  printf "%s\n" '  --iasl=VALUE             Path to ACPI disassembler'
   printf "%s\n" '  --includedir=VALUE       Header file directory [include]'
   printf "%s\n" '  --interp-prefix=VALUE    where to find shared libraries etc., use %M for'
   printf "%s\n" '                           cpu name [/usr/gnemul/qemu-%M]'
@@ -304,7 +303,6 @@ _meson_option_parse() {
     --disable-hexagon-idef-parser) printf "%s" -Dhexagon_idef_parser=false ;;
     --enable-hvf) printf "%s" -Dhvf=enabled ;;
     --disable-hvf) printf "%s" -Dhvf=disabled ;;
-    --iasl=*) quote_sh "-Diasl=$2" ;;
     --enable-iconv) printf "%s" -Diconv=enabled ;;
     --disable-iconv) printf "%s" -Diconv=disabled ;;
     --includedir=*) quote_sh "-Dincludedir=$2" ;;
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 7fd88b0e9c..e43a94787f 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -102,11 +102,7 @@ typedef struct {
 
 static char disk[] = "tests/acpi-test-disk-XXXXXX";
 static const char *data_dir = "tests/data/acpi";
-#ifdef CONFIG_IASL
-static const char *iasl = CONFIG_IASL;
-#else
 static const char *iasl;
-#endif
 
 static int verbosity_level;
 
@@ -441,6 +437,8 @@ static void test_acpi_asl(test_data *data)
     test_data exp_data = {};
     gboolean exp_err, err, all_tables_match = true;
 
+    iasl = getenv("CONFIG_IASL");
+
     exp_data.tables = load_expected_aml(data);
     dump_aml_files(data, false);
     for (i = 0; i < data->tables->len; ++i) {
@@ -473,6 +471,10 @@ static void test_acpi_asl(test_data *data)
             continue;
         }
 
+        if (verbosity_level >= 2) {
+            fprintf(stderr, "Using iasl: %s\n", iasl);
+        }
+
         err = load_asl(data->tables, sdt);
         asl = normalize_asl(sdt->asl);
 
@@ -529,8 +531,10 @@ static void test_acpi_asl(test_data *data)
     }
     if (!iasl && !all_tables_match) {
         fprintf(stderr, "to see ASL diff between mismatched files install IASL,"
-                " rebuild QEMU from scratch and re-run tests with V=1"
-                " environment variable set");
+                " set CONFIG_IASL environment variable to the path of iasl binary,\n"
+                " and run \'QTEST_QEMU_BINARY=<path to QEMU binary to test>"
+                " V=1 ./tests/qtest/bios-tables-test\' from build directory.\n"
+                " Alternatively run \'V=1 make check-qtest -B\' from build dir.\n");
     }
     g_assert(all_tables_match);
 
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 48cd35b5b2..f0b212bbd8 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -105,6 +105,7 @@ if dbus_display and targetos != 'windows'
   qtests_i386 += ['dbus-display-test']
 endif
 
+iasl = find_program('iasl', required: false)
 dbus_daemon = find_program('dbus-daemon', required: false)
 if dbus_daemon.found() and gdbus_codegen.found()
   # Temporarily disabled due to Patchew failures:
@@ -338,6 +339,9 @@ foreach dir : target_dirs
 
   test_deps = roms
   qtest_env = environment()
+  if iasl.found()
+    qtest_env.set('CONFIG_IASL', iasl.full_path())
+  endif
   if have_tools
     qtest_env.set('QTEST_QEMU_IMG', './qemu-img')
     test_deps += [qemu_img]
-- 
2.39.1



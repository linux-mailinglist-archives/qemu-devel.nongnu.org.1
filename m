Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28981830967
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:15:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7d7-0001Ym-2X; Wed, 17 Jan 2024 10:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ7d3-0001M1-D7
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:14:57 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ7d0-0005rR-O8
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:14:56 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a26fa294e56so1169957166b.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 07:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705504493; x=1706109293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rWquZDznl8GUJLKtfThc+dkHhiP6pDWBh8dOSA7ubck=;
 b=BA7W7aSlFVwyLUfKSPeUtqm2dMGnrOLUFxxwOsGPvV3n/Qthligv1akbi4G7/HEAL+
 27PTVTWi9ZJ24cUfI3zDmo0HcTIIBqdqKnmNhO8meVh7OkDlJsEIc9cnUSgDq3S1hXOn
 QJaVMzDO+17KaokprccHGGDCZScWmBbKonuAob+o17rrskqoUkf4Jt/G0PgrQmDjcy2W
 6p10THGz5uQVOEjVjZaXzHVkrofCjrzOj/7rW/n+1vSbtqO0hR8Pgc1ed55EjOe8iITe
 MpvQPdo0Mly1d+k87TKFnd4dFvprTqU6Fk5hUy6mjvvnP0VchlZtQ7LsKLYfiZd6yPbO
 kyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705504493; x=1706109293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rWquZDznl8GUJLKtfThc+dkHhiP6pDWBh8dOSA7ubck=;
 b=oglCrckXHUYtIRlLQyF8vbfV0D3BmzQeSmu+GRxuv9RXPXnPsI0twaMziN/pcDZsGR
 4PGsS6kWI7V4XtA8fLZ0aFd4Nqmo+1SNWOdqVOaxNBRtxcM5PcMPOQqwOBW8zEnrhgn1
 cqk1yhHn5vb01r71kvDWHsBdTZMFE55LlOvmHTfzhK48WYIEuOOQIo2GSFB8ykrXQzIt
 PJay6XEL+UXyvYOoDMGZ7VvIeZrl3sfzkMFYWuJIO6TaTOgOjykLlP0Nui3iHdoIMGGU
 76aqjrduC12GIL2jB+0+mnvhHqrVKaP/hLMax4S42GO2j+NY7V9+oef8Rm/ioslZnLng
 v0zg==
X-Gm-Message-State: AOJu0YxAlK+G7l3N+7KC0Bjd9ZM5o85okzqjZ6DD/1DtsfJUcOXsoVli
 SoaP4WD5A6NaKRfWvx+9f19raCg5bqllEVOAz4rFo8riQbY=
X-Google-Smtp-Source: AGHT+IGQ/HV1wo5l39Tctmo9IbyX/J3h3Iace2rSTglOd8DOwD9qSFw/79GBZsy72Xt8/XopFu9zrg==
X-Received: by 2002:a17:907:36c9:b0:a1d:b6b5:3416 with SMTP id
 bj9-20020a17090736c900b00a1db6b53416mr5053944ejc.84.1705504492834; 
 Wed, 17 Jan 2024 07:14:52 -0800 (PST)
Received: from m1x-phil.lan ([176.187.212.26])
 by smtp.gmail.com with ESMTPSA id
 k13-20020a1709062a4d00b00a290920c78csm7884465eje.187.2024.01.17.07.14.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jan 2024 07:14:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, devel@lists.libvirt.org,
 Laurent Vivier <laurent@vivier.eu>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] cli: Remove deprecated '-singlestep' command line option
Date: Wed, 17 Jan 2024 16:14:30 +0100
Message-ID: <20240117151430.29235-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240117151430.29235-1-philmd@linaro.org>
References: <20240117151430.29235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

This option has been deprecated before the 8.1 release,
in commit 12fd0f41d0 ("Document that -singlestep command
line option is deprecated"). Time to drop it.

Inspired-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       | 17 -----------------
 docs/about/removed-features.rst | 18 ++++++++++++++++++
 docs/user/main.rst              |  6 ------
 bsd-user/main.c                 |  3 +--
 linux-user/main.c               |  2 --
 system/vl.c                     | 18 +-----------------
 qemu-options.hx                 |  8 --------
 7 files changed, 20 insertions(+), 52 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 316a26a82c..f47446c079 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -63,23 +63,6 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
 However, short-form booleans are deprecated and full explicit ``arg_name=on``
 form is preferred.
 
-``-singlestep`` (since 8.1)
-'''''''''''''''''''''''''''
-
-The ``-singlestep`` option has been turned into an accelerator property,
-and given a name that better reflects what it actually does.
-Use ``-accel tcg,one-insn-per-tb=on`` instead.
-
-User-mode emulator command line arguments
------------------------------------------
-
-``-singlestep`` (since 8.1)
-'''''''''''''''''''''''''''
-
-The ``-singlestep`` option has been given a name that better reflects
-what it actually does. For both linux-user and bsd-user, use the
-new ``-one-insn-per-tb`` option instead.
-
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 855d788259..54081a6c19 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -482,6 +482,24 @@ Use ``-run-with async-teardown=on`` instead.
 
 Use ``-run-with chroot=dir`` instead.
 
+``-singlestep`` (removed in 9.0)
+''''''''''''''''''''''''''''''''
+
+The ``-singlestep`` option has been turned into an accelerator property,
+and given a name that better reflects what it actually does.
+Use ``-accel tcg,one-insn-per-tb=on`` instead.
+
+
+User-mode emulator command line arguments
+-----------------------------------------
+
+``-singlestep`` (removed in 9.0)
+''''''''''''''''''''''''''''''''
+
+The ``-singlestep`` option has been given a name that better reflects
+what it actually does. For both linux-user and bsd-user, use the
+``-one-insn-per-tb`` option instead.
+
 
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
diff --git a/docs/user/main.rst b/docs/user/main.rst
index f478635396..7e7ad07409 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -98,9 +98,6 @@ Debug options:
    This slows down emulation a lot, but can be useful in some situations,
    such as when trying to analyse the logs produced by the ``-d`` option.
 
-``-singlestep``
-   This is a deprecated synonym for the ``-one-insn-per-tb`` option.
-
 Environment variables:
 
 QEMU_STRACE
@@ -251,6 +248,3 @@ Debug options:
    Run the emulation with one guest instruction per translation block.
    This slows down emulation a lot, but can be useful in some situations,
    such as when trying to analyse the logs produced by the ``-d`` option.
-
-``-singlestep``
-   This is a deprecated synonym for the ``-one-insn-per-tb`` option.
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 4de226d211..e5efb7b845 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -163,7 +163,6 @@ static void usage(void)
            "                  (use '-d help' for a list of log items)\n"
            "-D logfile        write logs to 'logfile' (default stderr)\n"
            "-one-insn-per-tb  run with one guest instruction per emulated TB\n"
-           "-singlestep       deprecated synonym for -one-insn-per-tb\n"
            "-strace           log system calls\n"
            "-trace            [[enable=]<pattern>][,events=<file>][,file=<file>]\n"
            "                  specify tracing options\n"
@@ -391,7 +390,7 @@ int main(int argc, char **argv)
             (void) envlist_unsetenv(envlist, "LD_PRELOAD");
         } else if (!strcmp(r, "seed")) {
             seed_optarg = optarg;
-        } else if (!strcmp(r, "singlestep") || !strcmp(r, "one-insn-per-tb")) {
+        } else if (!strcmp(r, "one-insn-per-tb")) {
             opt_one_insn_per_tb = true;
         } else if (!strcmp(r, "strace")) {
             do_strace = 1;
diff --git a/linux-user/main.c b/linux-user/main.c
index 0cdaf30d34..c9470eeccf 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -500,8 +500,6 @@ static const struct qemu_argument arg_table[] = {
     {"one-insn-per-tb",
                    "QEMU_ONE_INSN_PER_TB",  false, handle_arg_one_insn_per_tb,
      "",           "run with one guest instruction per emulated TB"},
-    {"singlestep", "QEMU_SINGLESTEP",  false, handle_arg_one_insn_per_tb,
-     "",           "deprecated synonym for -one-insn-per-tb"},
     {"strace",     "QEMU_STRACE",      false, handle_arg_strace,
      "",           "log system calls"},
     {"seed",       "QEMU_RAND_SEED",   true,  handle_arg_seed,
diff --git a/system/vl.c b/system/vl.c
index c125fb9079..809f867bcc 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -181,7 +181,6 @@ static const char *log_file;
 static bool list_data_dirs;
 static const char *qtest_chrdev;
 static const char *qtest_log;
-static bool opt_one_insn_per_tb;
 
 static int has_defaults = 1;
 static int default_audio = 1;
@@ -2308,19 +2307,7 @@ static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
     qemu_opt_foreach(opts, accelerator_set_property,
                      accel,
                      &error_fatal);
-    /*
-     * If legacy -singlestep option is set, honour it for TCG and
-     * silently ignore for any other accelerator (which is how this
-     * option has always behaved).
-     */
-    if (opt_one_insn_per_tb) {
-        /*
-         * This will always succeed for TCG, and we want to ignore
-         * the error from trying to set a nonexistent property
-         * on any other accelerator.
-         */
-        object_property_set_bool(OBJECT(accel), "one-insn-per-tb", true, NULL);
-    }
+
     ret = accel_init_machine(accel, current_machine);
     if (ret < 0) {
         if (!qtest_with_kvm || ret != -ENOENT) {
@@ -3057,9 +3044,6 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_bios:
                 qdict_put_str(machine_opts_dict, "firmware", optarg);
                 break;
-            case QEMU_OPTION_singlestep:
-                opt_one_insn_per_tb = true;
-                break;
             case QEMU_OPTION_S:
                 autostart = 0;
                 break;
diff --git a/qemu-options.hx b/qemu-options.hx
index 9be6beb5a0..033fa873e4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4357,14 +4357,6 @@ SRST
     from a script.
 ERST
 
-DEF("singlestep", 0, QEMU_OPTION_singlestep, \
-    "-singlestep     deprecated synonym for -accel tcg,one-insn-per-tb=on\n", QEMU_ARCH_ALL)
-SRST
-``-singlestep``
-    This is a deprecated synonym for the TCG accelerator property
-    ``one-insn-per-tb``.
-ERST
-
 DEF("preconfig", 0, QEMU_OPTION_preconfig, \
     "--preconfig     pause QEMU before machine is initialized (experimental)\n",
     QEMU_ARCH_ALL)
-- 
2.41.0



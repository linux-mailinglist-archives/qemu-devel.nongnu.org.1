Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E6568832C5B
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 16:27:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQqkR-0002Oc-IV; Fri, 19 Jan 2024 10:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqkN-0002Nb-Kh
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQqkK-0001Cr-4c
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 10:25:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705677927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FZggUx+0zDgYPuUuORpEo5mIZug02y+mVWEfWGIY9uU=;
 b=F4G84G4HBX0pWBbxgYDNrw9RgckGf4OktKIfPfamrhfYO1jjjyZlnhzIFmjE0S1elSqatV
 XLZm5pE8ljQyQzYty2p8oXKRv70qlrbFvyRWWBFq4nstCMwa1ehQiU86q0M98Wjg0fo7me
 U1vb5GPWxeoAVqCys7wWnF8l+o/vJQE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-KoKfzNC5PVq-DpwyvICezg-1; Fri, 19 Jan 2024 10:25:24 -0500
X-MC-Unique: KoKfzNC5PVq-DpwyvICezg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FFC083B86C;
 Fri, 19 Jan 2024 15:25:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ADBB940D1B60;
 Fri, 19 Jan 2024 15:25:22 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 10/11] cli: Remove deprecated '-singlestep' command line option
Date: Fri, 19 Jan 2024 16:25:06 +0100
Message-ID: <20240119152507.55182-11-thuth@redhat.com>
In-Reply-To: <20240119152507.55182-1-thuth@redhat.com>
References: <20240119152507.55182-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

This option has been deprecated before the 8.1 release,
in commit 12fd0f41d0 ("Document that -singlestep command
line option is deprecated"). Time to drop it.

Inspired-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240117151430.29235-4-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
index 42d813474b..24706ae109 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4359,14 +4359,6 @@ SRST
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
2.43.0



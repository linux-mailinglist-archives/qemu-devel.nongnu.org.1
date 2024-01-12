Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D57D82BE09
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 11:02:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOEMO-0004PF-S5; Fri, 12 Jan 2024 05:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rOELm-00048y-4c
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:01:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rOELk-0005hI-0w
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 05:01:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705053675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xVy7qsKJPjI2/wKvXRpiG+jBXe0T6eGOpYnuJmahC8g=;
 b=AG2hyFO5DSFGJVQDqGW+SApuDUI3zsRhhcaa1MkRDHK6v/SVjIY3+WxF3qzbphVJRFwG83
 gM4OYD8D6Z/UF7xaVuRJRvXo5r58sdw546UNzYjneQ8PG1iX4uIP7qYnZh8riGag9tj/aj
 WuSJF0cj0x1VhsRTY1Jiyp28jKyNPRc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-C_05SQ0gOliezulKB9qyOA-1; Fri, 12 Jan 2024 05:01:12 -0500
X-MC-Unique: C_05SQ0gOliezulKB9qyOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DF84E8A4401;
 Fri, 12 Jan 2024 10:01:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.216])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 681DDC08ED4;
 Fri, 12 Jan 2024 10:01:10 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH 5/5] qemu-options: Remove the deprecated -singlestep option
Date: Fri, 12 Jan 2024 11:00:59 +0100
Message-ID: <20240112100059.965041-6-thuth@redhat.com>
In-Reply-To: <20240112100059.965041-1-thuth@redhat.com>
References: <20240112100059.965041-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

It's been marked as deprecated since QEMU 8.1, so it should be fine
to remove this now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst       |  6 ------
 docs/about/removed-features.rst |  7 +++++++
 system/vl.c                     | 18 +-----------------
 qemu-options.hx                 |  8 --------
 4 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index b50cfe596b..81a5149f1e 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -63,12 +63,6 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
 However, short-form booleans are deprecated and full explicit ``arg_name=on``
 form is preferred.
 
-``-singlestep`` (since 8.1)
-'''''''''''''''''''''''''''
-
-The ``-singlestep`` option has been turned into an accelerator property,
-and given a name that better reflects what it actually does.
-Use ``-accel tcg,one-insn-per-tb=on`` instead.
 
 User-mode emulator command line arguments
 -----------------------------------------
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index a8546f4787..d5c60ff47f 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -482,6 +482,13 @@ Use ``-run-with async-teardown=on`` instead.
 
 Use ``-run-with chroot=dir`` instead.
 
+``-singlestep`` (removed in 9.0)
+''''''''''''''''''''''''''''''''
+
+The ``-singlestep`` option has been turned into an accelerator property,
+and given a name that better reflects what it actually does.
+Use ``-accel tcg,one-insn-per-tb=on`` instead.
+
 
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
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
2.43.0



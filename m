Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC718316BA
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 11:39:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQPms-0003fs-P6; Thu, 18 Jan 2024 05:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQPmp-0003ea-LY
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 05:38:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rQPmo-00075U-6M
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 05:38:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705574293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/EnqBVp3iFF44e9a2z57CeFbDmzyosK7WKz6lJA5ao=;
 b=CBWm771BofZbS4GkDlABfcY2XCKn5VwcMhQgVAM/F46nBbhe4lKNZc1aKKZ1cefeUYw0l6
 /MrreET+sJYNGVeU8yN8kNJlwT5SHkHuCFPac+msITdLwlEcgzCbmlzcnwt/wv4GO5r/q4
 L3TES3YWv8UUfmdG8ksA3PnUfldsmos=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-xZ4O6ALNO0OzFA6d_aEunA-1; Thu, 18 Jan 2024 05:38:09 -0500
X-MC-Unique: xZ4O6ALNO0OzFA6d_aEunA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A616A108BD45;
 Thu, 18 Jan 2024 10:38:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC49E492BC6;
 Thu, 18 Jan 2024 10:38:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/4] qemu-options: Remove the deprecated -async-teardown
 option
Date: Thu, 18 Jan 2024 11:37:58 +0100
Message-ID: <20240118103759.130748-4-thuth@redhat.com>
In-Reply-To: <20240118103759.130748-1-thuth@redhat.com>
References: <20240118103759.130748-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

It's been marked as deprecated since QEMU 8.1 (and was only available
since QEMU 8.0 anyway), so it should be fine to remove this now.

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 docs/about/deprecated.rst       |  5 -----
 docs/about/removed-features.rst |  5 +++++
 system/vl.c                     |  6 ------
 qemu-options.hx                 | 10 ----------
 4 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 3f8e505df6..89ca4490d7 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -63,11 +63,6 @@ as short-form boolean values, and passed to plugins as ``arg_name=on``.
 However, short-form booleans are deprecated and full explicit ``arg_name=on``
 form is preferred.
 
-``-async-teardown`` (since 8.1)
-'''''''''''''''''''''''''''''''
-
-Use ``-run-with async-teardown=on`` instead.
-
 ``-chroot`` (since 8.1)
 '''''''''''''''''''''''
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index ae728b6130..43f64a26ba 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -472,6 +472,11 @@ Use ``-machine hpet=off`` instead.
 The ``-no-acpi`` setting has been turned into a machine property.
 Use ``-machine acpi=off`` instead.
 
+``-async-teardown`` (removed in 9.0)
+''''''''''''''''''''''''''''''''''''
+
+Use ``-run-with async-teardown=on`` instead.
+
 
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
diff --git a/system/vl.c b/system/vl.c
index 7e258889f3..924356f864 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3600,12 +3600,6 @@ void qemu_init(int argc, char **argv)
             case QEMU_OPTION_daemonize:
                 os_set_daemonize(true);
                 break;
-#if defined(CONFIG_LINUX)
-            /* deprecated */
-            case QEMU_OPTION_asyncteardown:
-                init_async_teardown();
-                break;
-#endif
             case QEMU_OPTION_run_with: {
                 const char *str;
                 opts = qemu_opts_parse_noisily(qemu_find_opts("run-with"),
diff --git a/qemu-options.hx b/qemu-options.hx
index dafecf47d6..10c952ba3f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4975,16 +4975,6 @@ HXCOMM Internal use
 DEF("qtest", HAS_ARG, QEMU_OPTION_qtest, "", QEMU_ARCH_ALL)
 DEF("qtest-log", HAS_ARG, QEMU_OPTION_qtest_log, "", QEMU_ARCH_ALL)
 
-#ifdef __linux__
-DEF("async-teardown", 0, QEMU_OPTION_asyncteardown,
-    "-async-teardown enable asynchronous teardown\n",
-    QEMU_ARCH_ALL)
-SRST
-``-async-teardown``
-    This option is deprecated and should no longer be used. The new option
-    ``-run-with async-teardown=on`` is a replacement.
-ERST
-#endif
 #ifdef CONFIG_POSIX
 DEF("run-with", HAS_ARG, QEMU_OPTION_run_with,
     "-run-with [async-teardown=on|off][,chroot=dir]\n"
-- 
2.43.0



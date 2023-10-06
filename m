Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A5F7BB7FA
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 14:41:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qok7K-0001f4-IY; Fri, 06 Oct 2023 08:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qok70-0001cv-Ko
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:39:24 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qok6x-0007nk-Vk
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:39:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CEF432186E;
 Fri,  6 Oct 2023 12:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696595957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6eZXUpCJCgXJcHKCCA6q9eaupV07gM00+KlT/9j3Qc=;
 b=gir6Jr2Ry9xIoNPg489WY+BWuwnIxGUHzoUNfj4Bu/AD+9x/Kkv5FpzcvPcmRo1mryt+6G
 Wiz3+d32zzw54zSdakE5UkpzOeA50JkpnbPOIm/K3eb1XNLV5hLT1Sr8f5bfMeStbADAU7
 sbU0VELdRdf/Fz0lAzCilv+1OtQNEbM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696595957;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6eZXUpCJCgXJcHKCCA6q9eaupV07gM00+KlT/9j3Qc=;
 b=iNOTBTXdom8SP9LezzJiLWabKlfKIinDk4UGDuHXq25pqa+ZlPBR+pz8jWkayVfuxbnHxr
 Wlz2Joes/3+TMABw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 500CA13A2E;
 Fri,  6 Oct 2023 12:39:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SB5MB/P/H2ULIgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 06 Oct 2023 12:39:15 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 1/9] tests/qtest: Allow qtest_qemu_binary to use a custom
 environment variable
Date: Fri,  6 Oct 2023 09:39:02 -0300
Message-Id: <20231006123910.17759-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231006123910.17759-1-farosas@suse.de>
References: <20231006123910.17759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We're adding support for testing migration using two different QEMU
binaries. We'll provide the second binary in a new environment
variable.

Allow qtest_qemu_binary() to receive the name of the new variable. If
the new environment variable is not set, that's not an error, we use
QTEST_QEMU_BINARY as a fallback.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index b1eba71ffe..1f971b98e0 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -336,10 +336,17 @@ void qtest_remove_abrt_handler(void *data)
     }
 }
 
-static const char *qtest_qemu_binary(void)
+static const char *qtest_qemu_binary(const char *var)
 {
     const char *qemu_bin;
 
+    if (var) {
+        qemu_bin = getenv(var);
+        if (qemu_bin) {
+            return qemu_bin;
+        }
+    }
+
     qemu_bin = getenv("QTEST_QEMU_BINARY");
     if (!qemu_bin) {
         fprintf(stderr, "Environment variable QTEST_QEMU_BINARY required\n");
@@ -392,7 +399,7 @@ static QTestState *G_GNUC_PRINTF(1, 2) qtest_spawn_qemu(const char *fmt, ...)
 
     va_start(ap, fmt);
     g_string_append_printf(command, CMD_EXEC "%s %s",
-                           qtest_qemu_binary(), tracearg);
+                           qtest_qemu_binary(NULL), tracearg);
     g_string_append_vprintf(command, fmt, ap);
     va_end(ap);
 
@@ -907,7 +914,7 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
 
 const char *qtest_get_arch(void)
 {
-    const char *qemu = qtest_qemu_binary();
+    const char *qemu = qtest_qemu_binary(NULL);
     const char *end = strrchr(qemu, '-');
 
     if (!end) {
-- 
2.35.3



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8327CE7B3
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 21:29:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtCCw-0003H9-T5; Wed, 18 Oct 2023 15:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtCCu-0003GI-FW
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:27:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtCCs-00053H-Tl
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 15:27:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E61F1F88B;
 Wed, 18 Oct 2023 19:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697657269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SuaAdA4r6gvUGRgqcCXCJsIKiI0xZQxmNEMBPAibCFg=;
 b=0fUW3sMYCcAb+qf8TPPdGAr6KfLH1gIo0Zs3jPA9HWjTch/ztaoE7gQcaDLTpA9EzGYXDI
 E7sGORj0sWGQd8cwZMZdwWNNK+HlOZdx1J/om7NHNlMeenEUJ/0OqZVIeENn+dOzlzWe6j
 ClYOJg+sygOtx723jso48q324FCVdKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697657269;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SuaAdA4r6gvUGRgqcCXCJsIKiI0xZQxmNEMBPAibCFg=;
 b=mopMeytWx+XkZtERxELAN8j1QV1S866WXXhT0Hsr6D9bpWubRS6G/THq8lR3i0Vu1rGoXh
 ob8sd00w5aPId/DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75115139E0;
 Wed, 18 Oct 2023 19:27:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mKH3D7IxMGVLaAAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 18 Oct 2023 19:27:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v4 01/12] tests/qtest: Allow qtest_qemu_binary to use a custom
 environment variable
Date: Wed, 18 Oct 2023 16:27:30 -0300
Message-Id: <20231018192741.25885-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231018192741.25885-1-farosas@suse.de>
References: <20231018192741.25885-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -1.11
X-Spamd-Result: default: False [-1.11 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.01)[95.13%]
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index dc7a55634c..03fa644663 100644
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
 
@@ -905,7 +912,7 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
 
 const char *qtest_get_arch(void)
 {
-    const char *qemu = qtest_qemu_binary();
+    const char *qemu = qtest_qemu_binary(NULL);
     const char *end = strrchr(qemu, '-');
 
     if (!end) {
-- 
2.35.3



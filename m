Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7EF7CDE54
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:09:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7E9-0004WQ-IF; Wed, 18 Oct 2023 10:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qt7Dc-0003yi-QT
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:08:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qt7Db-0003fA-7z
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:08:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0EE8D21C1A;
 Wed, 18 Oct 2023 14:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697638094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0H0YK/smzvRBVZZ9EhckynrSVjTX7hQMS/hZjk+gNOM=;
 b=GfW8Z+ML0K/dDKSUR6XCiu5c2eF1buFdywZKk29r9izxI2P5L+/UpZJ1UlCr0bWi04VteU
 UWdU651dMKJosxqz2JLfGNySjUAO73l4Zl69ns62NY+AZlQghX4YBstOxUNtJ1uPdImHyt
 dnOxvqO5PF2W6ferjamOUIGpLFQfPlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697638094;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0H0YK/smzvRBVZZ9EhckynrSVjTX7hQMS/hZjk+gNOM=;
 b=bIuy+DhpDhmqm7ArQNmK/iiYJpN6RhQSRYQ/FmSV0pIFYUKpBnvFWS6gMK9oe/CEv1sYky
 NgpQSAIldQGpnDAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7751813915;
 Wed, 18 Oct 2023 14:08:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CKS2EMvmL2WuTQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 18 Oct 2023 14:08:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 11/11] tests/qtest: Don't print messages from query
 instances
Date: Wed, 18 Oct 2023 11:07:36 -0300
Message-Id: <20231018140736.3618-12-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231018140736.3618-1-farosas@suse.de>
References: <20231018140736.3618-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 R_RATELIMIT(0.00)[to_ip_from(RLg3q9sbp57ska6k3y17j3rnax)];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[99.98%]
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

Now that we can query more than one binary, the "starting QEMU..."
message can get a little noisy. Mute those messages unless we're
running with --verbose.

Only affects qtest_init() calls from within libqtest. The tests
continue to output as usual.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index fda163836c..1ac4f7d36a 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -91,6 +91,7 @@ struct QTestState
 
 static GHookList abrt_hooks;
 static void (*sighandler_old)(int);
+static bool silence_spawn_log;
 
 static int qtest_query_target_endianness(QTestState *s);
 
@@ -405,7 +406,9 @@ static QTestState *G_GNUC_PRINTF(2, 3) qtest_spawn_qemu(const char *qemu_bin,
 
     qtest_add_abrt_handler(kill_qemu_hook_func, s);
 
-    g_test_message("starting QEMU: %s", command->str);
+    if (!silence_spawn_log) {
+        g_test_message("starting QEMU: %s", command->str);
+    }
 
 #ifndef _WIN32
     s->qemu_pid = fork();
@@ -1496,6 +1499,8 @@ static struct MachInfo *qtest_get_machines(const char *var)
         return machines;
     }
 
+    silence_spawn_log = !g_test_verbose();
+
     qts = qtest_init_with_env(qemu_var, "-machine none");
     response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
     g_assert(response);
@@ -1527,6 +1532,8 @@ static struct MachInfo *qtest_get_machines(const char *var)
     qtest_quit(qts);
     qobject_unref(response);
 
+    silence_spawn_log = false;
+
     memset(&machines[idx], 0, sizeof(struct MachInfo)); /* Terminating entry */
     return machines;
 }
-- 
2.35.3



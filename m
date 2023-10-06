Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5633C7BB7FB
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 14:41:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qok7p-0002j5-KO; Fri, 06 Oct 2023 08:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qok7M-0001vK-Ba
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:39:44 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qok7K-0007rY-IX
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 08:39:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 803E41F895;
 Fri,  6 Oct 2023 12:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696595981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFwHcg2CNaMOeHywW0cnhPu3lRB7gbKiAMM0JbLUJn4=;
 b=uJd8ShrKYAs6pHp1WDryyqRa8Ip5gdDS0iO2xoWH6rKBZGwsa+xMVAWhqTZNyiJgEHzkXl
 F6jqf6G+4G3uZ7M1bn/isnxRA4FlQo+BfHSsn85veiszD7iwR7uP3Ykko2CjzywCL1o9tU
 B3ZIPqf63teH8pBtMCK879DKjMFJuvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696595981;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rFwHcg2CNaMOeHywW0cnhPu3lRB7gbKiAMM0JbLUJn4=;
 b=qdY4B+11NR846NuguLy1SHpiG8YXzI7Y3m8LkljgDiZL8BEsSUPhHjUm6sTQoE276P50+6
 VrFjzSc3bto7iLAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0CAC13A2E;
 Fri,  6 Oct 2023 12:39:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kAdJLgoAIGULIgAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 06 Oct 2023 12:39:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 9/9] tests/qtest: Don't print messages from query instances
Date: Fri,  6 Oct 2023 09:39:10 -0300
Message-Id: <20231006123910.17759-10-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231006123910.17759-1-farosas@suse.de>
References: <20231006123910.17759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
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

Now that we can query more than one binary, the "starting QEMU..."
message can get a little noisy. Mute those messages unless we're
running with --verbose.

Only affects qtest_init() calls from within libqtest. The tests
continue to output as usual.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/libqtest.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index f2f1756de1..ea844ad7bc 100644
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
@@ -1465,6 +1468,8 @@ static struct MachInfo *qtest_get_machines(const char *var)
         return machines;
     }
 
+    silence_spawn_log = !g_test_verbose();
+
     qts = qtest_init_with_env(qemu_var, "-machine none");
     response = qtest_qmp(qts, "{ 'execute': 'query-machines' }");
     g_assert(response);
@@ -1496,6 +1501,8 @@ static struct MachInfo *qtest_get_machines(const char *var)
     qtest_quit(qts);
     qobject_unref(response);
 
+    silence_spawn_log = false;
+
     memset(&machines[idx], 0, sizeof(struct MachInfo)); /* Terminating entry */
     return machines;
 }
-- 
2.35.3



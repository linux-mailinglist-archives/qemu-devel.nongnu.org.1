Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 081B09EEA53
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 16:12:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkpv-0004HB-5K; Thu, 12 Dec 2024 10:10:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpj-0004CH-SA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:32 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLkpi-0003Fu-Aq
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 10:10:31 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 044BE1F383;
 Thu, 12 Dec 2024 15:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ay1NMkJSkWhbb4OVQCYEEjG1RHPxv29tdt3oW7I9uSk=;
 b=05bgw1Uwxl+GJjsXSVzT/eWKh/hLJSgg4WYhgbtssCD4DVG71ErUkf6MX8Sb/5W2rOORn5
 kLcH/jPeAjS9iHloHBGggKLCgbxPeLvZLu7NLkt85fcnu1ku4pvhYZcPVOOoeZsNS1bTBK
 dJ6G0Ni0JCK8tW916GQP4o/pRdYZ0rE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ay1NMkJSkWhbb4OVQCYEEjG1RHPxv29tdt3oW7I9uSk=;
 b=NMfjatQNWsu7qAGnN8M1PB3/aMoe2Sm6CnGnvwMptMyr3hBi5gFSpMP5jOUKbBpD+9Btwp
 sftNhPn8optyybCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1734016228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ay1NMkJSkWhbb4OVQCYEEjG1RHPxv29tdt3oW7I9uSk=;
 b=05bgw1Uwxl+GJjsXSVzT/eWKh/hLJSgg4WYhgbtssCD4DVG71ErUkf6MX8Sb/5W2rOORn5
 kLcH/jPeAjS9iHloHBGggKLCgbxPeLvZLu7NLkt85fcnu1ku4pvhYZcPVOOoeZsNS1bTBK
 dJ6G0Ni0JCK8tW916GQP4o/pRdYZ0rE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1734016228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ay1NMkJSkWhbb4OVQCYEEjG1RHPxv29tdt3oW7I9uSk=;
 b=NMfjatQNWsu7qAGnN8M1PB3/aMoe2Sm6CnGnvwMptMyr3hBi5gFSpMP5jOUKbBpD+9Btwp
 sftNhPn8optyybCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A82613508;
 Thu, 12 Dec 2024 15:10:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6MsaBOL8WmcTfQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 12 Dec 2024 15:10:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PULL 21/22] tests/qtest/migration-test: Fix and enable
 test_ignore_shared
Date: Thu, 12 Dec 2024 12:09:48 -0300
Message-Id: <20241212150949.16806-22-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212150949.16806-1-farosas@suse.de>
References: <20241212150949.16806-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[linaro.org,gmail.com,yandex-team.ru,treblig.org];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,yandex-team.ru:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

This test is already starting to bitrot, so first remove it from ifdef
and fix compile issues. ppc64 transfers about 2MB, so bump the size
threshold too.

It was said to be broken on aarch64 but it may have been due to the
limited shm size under Gitlab CI.

Cc: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: Dr. David Alan Gilbert <dave@treblig.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
[put it under flaky tests, we still don't have a solution for the CI]
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 0d1c8154d7..4b366a94a2 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -107,14 +107,15 @@ static void test_analyze_script(void)
 }
 #endif
 
-#if 0
-/* Currently upset on aarch64 TCG */
 static void test_ignore_shared(void)
 {
     g_autofree char *uri = g_strdup_printf("unix:%s/migsocket", tmpfs);
     QTestState *from, *to;
+    MigrateStart args = {
+        .use_shmem = true,
+    };
 
-    if (migrate_start(&from, &to, uri, false, true, NULL, NULL)) {
+    if (migrate_start(&from, &to, uri, &args)) {
         return;
     }
 
@@ -139,11 +140,11 @@ static void test_ignore_shared(void)
     wait_for_migration_complete(from);
 
     /* Check whether shared RAM has been really skipped */
-    g_assert_cmpint(read_ram_property_int(from, "transferred"), <, 1024 * 1024);
+    g_assert_cmpint(
+        read_ram_property_int(from, "transferred"), <, 4 * 1024 * 1024);
 
     migrate_end(from, to, true);
 }
-#endif
 
 static void do_test_validate_uuid(MigrateStart *args, bool should_fail)
 {
@@ -290,7 +291,13 @@ int main(int argc, char **argv)
     migration_test_add("/migration/analyze-script", test_analyze_script);
 #endif
 
-    /* migration_test_add("/migration/ignore_shared", test_ignore_shared); */
+    /*
+     * Our CI system has problems with shared memory.
+     * Don't run this test until we find a workaround.
+     */
+    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
+        migration_test_add("/migration/ignore-shared", test_ignore_shared);
+    }
 
     migration_test_add("/migration/validate_uuid", test_validate_uuid);
     migration_test_add("/migration/validate_uuid_error",
-- 
2.35.3



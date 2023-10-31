Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F677DD802
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 23:02:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxwnS-00078A-Hm; Tue, 31 Oct 2023 18:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxwnN-00077x-QA
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:01:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qxwnL-0004ll-GF
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 18:01:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB69A1F38C;
 Tue, 31 Oct 2023 22:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698789665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZHMDxy+gHNLffPKfWeyrEJ98gwTVz9N83O0li1uP3k=;
 b=vRglsoYHyQ3KA8rZFuD0/x8LVOA4LBtelRa9GdsvbZcvEnLIBZhVk0BrVczHgLfzlTt1b5
 xK1IKATGQX3xjlsfjXd3KBiwrulAwEMALKd7WM7XvhB2w4SOMk1LGJfRNIqKvNH8tW9O3G
 Po3zkc/Rj2IRY/rqm96W4269Qfq8qDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698789665;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TZHMDxy+gHNLffPKfWeyrEJ98gwTVz9N83O0li1uP3k=;
 b=tcNORnTit46DupS9S5AlVQnYlhSunXusLdbGXcVoB4J19kOWdnhZCT36QAvAghHjmt0DRv
 LQDG5P/SSdYxzOAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D7901391B;
 Tue, 31 Oct 2023 22:01:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /NfHAiF5QWXfbwAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 31 Oct 2023 22:01:05 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v4 3/5] tests/migration-test: Add a test for postcopy
 hangs during RECOVER
In-Reply-To: <20231017202633.296756-4-peterx@redhat.com>
References: <20231017202633.296756-1-peterx@redhat.com>
 <20231017202633.296756-4-peterx@redhat.com>
Date: Tue, 31 Oct 2023 19:01:02 -0300
Message-ID: <87o7gecuzl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> From: Fabiano Rosas <farosas@suse.de>
>
> To do so, create two paired sockets, but make them not providing real data.
> Feed those fake sockets to src/dst QEMUs for recovery to let them go into
> RECOVER stage without going out.  Test that we can always kick it out and
> recover again with the right ports.
>
> This patch is based on Fabiano's version here:
>
> https://lore.kernel.org/r/877cowmdu0.fsf@suse.de
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> [peterx: write commit message, remove case 1, fix bugs, and more]
> Signed-off-by: Peter Xu <peterx@redhat.com>

This patch breaks the windows build. We need this:

-->8--
From 96fee99f2a3c8e11951100d94159eba02dd98540 Mon Sep 17 00:00:00 2001
From: Fabiano Rosas <farosas@suse.de>
Date: Tue, 31 Oct 2023 17:41:56 -0300
Subject: [PATCH] fixup! tests/migration-test: Add a test for postcopy hangs
 during RECOVER

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/migration-test.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 2359d349cf..604ffe7746 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1417,6 +1417,7 @@ static void wait_for_postcopy_status(QTestState *one, const char *status)
                                                   "completed", NULL });
 }
 
+#ifndef _WIN32
 static void postcopy_recover_fail(QTestState *from, QTestState *to)
 {
     int ret, pair1[2], pair2[2];
@@ -1481,6 +1482,7 @@ static void postcopy_recover_fail(QTestState *from, QTestState *to)
     close(pair2[0]);
     close(pair2[1]);
 }
+#endif
 
 static void test_postcopy_recovery_common(MigrateCommon *args)
 {
@@ -1520,6 +1522,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
     wait_for_postcopy_status(to, "postcopy-paused");
     wait_for_postcopy_status(from, "postcopy-paused");
 
+#ifndef _WIN32
     if (args->postcopy_recovery_test_fail) {
         /*
          * Test when a wrong socket specified for recover, and then the
@@ -1528,6 +1531,7 @@ static void test_postcopy_recovery_common(MigrateCommon *args)
         postcopy_recover_fail(from, to);
         /* continue with a good recovery */
     }
+#endif
 
     /*
      * Create a new socket to emulate a new channel that is different
@@ -1565,6 +1569,7 @@ static void test_postcopy_recovery_compress(void)
     test_postcopy_recovery_common(&args);
 }
 
+#ifndef _WIN32
 static void test_postcopy_recovery_double_fail(void)
 {
     MigrateCommon args = {
@@ -1573,6 +1578,7 @@ static void test_postcopy_recovery_double_fail(void)
 
     test_postcopy_recovery_common(&args);
 }
+#endif
 
 #ifdef CONFIG_GNUTLS
 static void test_postcopy_recovery_tls_psk(void)
@@ -3185,9 +3191,10 @@ int main(int argc, char **argv)
             qtest_add_func("/migration/postcopy/recovery/compress/plain",
                            test_postcopy_recovery_compress);
         }
+#ifndef _WIN32
         qtest_add_func("/migration/postcopy/recovery/double-failures",
                        test_postcopy_recovery_double_fail);
-
+#endif
     }
 
     qtest_add_func("/migration/bad_dest", test_baddest);
-- 
2.35.3



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0174E79AA81
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 19:14:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfkTl-0002mp-G9; Mon, 11 Sep 2023 13:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfkTk-0002mT-65
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 13:13:40 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfkTi-0000AE-0G
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 13:13:39 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9D5A421875;
 Mon, 11 Sep 2023 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694452415; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4F3Z9FAUn93sfwbK8FJ9e5DMMvpXA/8ArfN50R/0eg=;
 b=xMfAarmjooA7RcdpfBeXAAEqZjbRIuUM2tuC+Wnekwx3KQRJVZzbH0S8wfWTgYZzd96HNy
 OH5sOdFgNJwQuZxdttCRm7vhwmOW3RqfcUq+v5X+CuvPzj5ABvK95rP4sCApWMkafgS9KN
 ne/7GeaFsTHdB7Um/bcxSvtX+yyjeQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694452415;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4F3Z9FAUn93sfwbK8FJ9e5DMMvpXA/8ArfN50R/0eg=;
 b=GME/daoo0Dz5+FuOi1SbdhjDM2OfLhzGML9G2vgMbEgDicYPFOYgT6pV8z5C8uK47GCfXd
 K81c1zi/8ePb+CAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E42D139CC;
 Mon, 11 Sep 2023 17:13:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iPmKL71K/2QyIAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 11 Sep 2023 17:13:33 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v6 05/10] migration: Consolidate return path closing code
Date: Mon, 11 Sep 2023 14:13:15 -0300
Message-Id: <20230911171320.24372-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230911171320.24372-1-farosas@suse.de>
References: <20230911171320.24372-1-farosas@suse.de>
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

We'll start calling the await_return_path_close_on_source() function
from other parts of the code, so move all of the related checks and
tracepoints into it.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 195726eb4a..4edbee3a5d 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2049,6 +2049,14 @@ static int open_return_path_on_source(MigrationState *ms,
 /* Returns 0 if the RP was ok, otherwise there was an error on the RP */
 static int await_return_path_close_on_source(MigrationState *ms)
 {
+    int ret;
+
+    if (!ms->rp_state.rp_thread_created) {
+        return 0;
+    }
+
+    trace_migration_return_path_end_before();
+
     /*
      * If this is a normal exit then the destination will send a SHUT
      * and the rp_thread will exit, however if there's an error we
@@ -2066,7 +2074,10 @@ static int await_return_path_close_on_source(MigrationState *ms)
     qemu_thread_join(&ms->rp_state.rp_thread);
     ms->rp_state.rp_thread_created = false;
     trace_await_return_path_close_on_source_close();
-    return ms->rp_state.error;
+
+    ret = ms->rp_state.error;
+    trace_migration_return_path_end_after(ret);
+    return ret;
 }
 
 static inline void
@@ -2362,20 +2373,8 @@ static void migration_completion(MigrationState *s)
         goto fail;
     }
 
-    /*
-     * If rp was opened we must clean up the thread before
-     * cleaning everything else up (since if there are no failures
-     * it will wait for the destination to send it's status in
-     * a SHUT command).
-     */
-    if (s->rp_state.rp_thread_created) {
-        int rp_error;
-        trace_migration_return_path_end_before();
-        rp_error = await_return_path_close_on_source(s);
-        trace_migration_return_path_end_after(rp_error);
-        if (rp_error) {
-            goto fail;
-        }
+    if (await_return_path_close_on_source(s)) {
+        goto fail;
     }
 
     if (qemu_file_get_error(s->to_dst_file)) {
-- 
2.35.3



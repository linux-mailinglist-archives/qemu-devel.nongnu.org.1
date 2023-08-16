Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 049F977E390
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 16:28:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWHSd-0003ty-Cn; Wed, 16 Aug 2023 10:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWHSb-0003rR-JV
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:25:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWHSZ-0003jS-DF
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:25:21 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4CD052190B;
 Wed, 16 Aug 2023 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692195918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jAsBqbZmyUB1R931rGfF3+iNeAKRaD7BagsRZjWBM0I=;
 b=HDrbjv1idM79n+u3HVqOEjE8Q/SSE+iyjUEuPS3BgUewojaF5U7MUR9XJi2jkoDOtUbJ4X
 WG7TYuZvoD+uqxL5hrmvmUnrKR9fJboKOQs48GZ9nsBPWyZnVvc0jkpEGHJJoHUxO9J1bg
 jPQlxa+ho8eHQ/OhkdW5Cq1t8XaDp18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692195918;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jAsBqbZmyUB1R931rGfF3+iNeAKRaD7BagsRZjWBM0I=;
 b=bgUKneSOFHz2OWc7CwozNOIs9zhLHS1ivFbvAeZtqFzbwUUgj7mxMju7FI+KhgSfZVsuZG
 Xk6/S1iCE7yfAaDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBF41133F2;
 Wed, 16 Aug 2023 14:25:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oHwNIUzc3GShdwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 16 Aug 2023 14:25:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v4 2/8] migration: Fix possible races when shutting down the
 return path
Date: Wed, 16 Aug 2023 11:25:04 -0300
Message-Id: <20230816142510.5637-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230816142510.5637-1-farosas@suse.de>
References: <20230816142510.5637-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We cannot call qemu_file_shutdown() on the return path file without
taking the file lock. The return path thread could be running it's
cleanup code and have just cleared the from_dst_file pointer.

Checking ms->to_dst_file for errors could also race with
migrate_fd_cleanup() which clears the to_dst_file pointer.

Protect both accesses by taking the file lock.

This was caught by inspection, it should be rare, but the next patches
will start calling this code from other places, so let's do the
correct thing.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f88c86079c..85c171f32c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2052,17 +2052,18 @@ static int open_return_path_on_source(MigrationState *ms,
 static int await_return_path_close_on_source(MigrationState *ms)
 {
     /*
-     * If this is a normal exit then the destination will send a SHUT and the
-     * rp_thread will exit, however if there's an error we need to cause
-     * it to exit.
+     * If this is a normal exit then the destination will send a SHUT
+     * and the rp_thread will exit, however if there's an error we
+     * need to cause it to exit. shutdown(2), if we have it, will
+     * cause it to unblock if it's stuck waiting for the destination.
      */
-    if (qemu_file_get_error(ms->to_dst_file) && ms->rp_state.from_dst_file) {
-        /*
-         * shutdown(2), if we have it, will cause it to unblock if it's stuck
-         * waiting for the destination.
-         */
-        qemu_file_shutdown(ms->rp_state.from_dst_file);
+    WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
+        if (ms->to_dst_file && ms->rp_state.from_dst_file &&
+            qemu_file_get_error(ms->to_dst_file)) {
+            qemu_file_shutdown(ms->rp_state.from_dst_file);
+        }
     }
+
     trace_await_return_path_close_on_source_joining();
     qemu_thread_join(&ms->rp_state.rp_thread);
     ms->rp_state.rp_thread_created = false;
-- 
2.35.3



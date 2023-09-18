Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FBB7A5101
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 19:29:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiI3E-000727-PF; Mon, 18 Sep 2023 13:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiI3B-0006wq-RO
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:28:45 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qiI38-0004U0-U4
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 13:28:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 87F632003E;
 Mon, 18 Sep 2023 17:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695058121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xAMfDFMZ+ezrCTtyQ8YqIFwJmcIIhXTsp71GC2FgNq8=;
 b=h3YzGygrxm2/np0y3trSFrTtzlky3Q8/4vHR50lquUGm7J4U6e0zpJjn+UGsRhSxmkilFm
 YwlSGPFs/ZGGZf6d/0S36jeq0hWDCZXd6TtZqCtOpWWQ8p1LbO1nM+ZulS2H8MY6PBhmsv
 9lDeOjeYsEAqbdsoURhw/NmNf8CjT6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695058121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xAMfDFMZ+ezrCTtyQ8YqIFwJmcIIhXTsp71GC2FgNq8=;
 b=y4cTQNhRu/7K7wX0Uq1Z8jfgwH7pCi8ZyaDcgetzNz/f+Y55F1pPp7CciKatlz4HVg3/AY
 Vf3uvc1DoQbIdOCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0B50C1358A;
 Mon, 18 Sep 2023 17:28:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6AaPMceICGUoGAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 18 Sep 2023 17:28:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 8/8] migration: Move return path cleanup to main migration
 thread
Date: Mon, 18 Sep 2023 14:28:22 -0300
Message-Id: <20230918172822.19052-9-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918172822.19052-1-farosas@suse.de>
References: <20230918172822.19052-1-farosas@suse.de>
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

Now that the return path thread is allowed to finish during a paused
migration, we can move the cleanup of the QEMUFiles to the main
migration thread.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index af78f7ee54..e2ed85b5be 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -98,6 +98,7 @@ static int migration_maybe_pause(MigrationState *s,
                                  int *current_active_state,
                                  int new_state);
 static void migrate_fd_cancel(MigrationState *s);
+static int await_return_path_close_on_source(MigrationState *s);
 
 static bool migration_needs_multiple_sockets(void)
 {
@@ -1178,6 +1179,12 @@ static void migrate_fd_cleanup(MigrationState *s)
         qemu_fclose(tmp);
     }
 
+    /*
+     * We already cleaned up to_dst_file, so errors from the return
+     * path might be due to that, ignore them.
+     */
+    await_return_path_close_on_source(s);
+
     assert(!migration_is_active(s));
 
     if (s->state == MIGRATION_STATUS_CANCELLING) {
@@ -1997,7 +2004,6 @@ out:
     }
 
     trace_source_return_path_thread_end();
-    migration_release_dst_files(ms);
     rcu_unregister_thread();
     return NULL;
 }
@@ -2051,6 +2057,9 @@ static int await_return_path_close_on_source(MigrationState *ms)
 
     ret = ms->rp_state.error;
     ms->rp_state.error = false;
+
+    migration_release_dst_files(ms);
+
     trace_migration_return_path_end_after(ret);
     return ret;
 }
-- 
2.35.3



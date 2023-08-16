Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F4F77E396
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 16:29:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWHSm-0004Ei-SF; Wed, 16 Aug 2023 10:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWHSl-0004CZ-Jq
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:25:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWHSj-0003nr-3U
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 10:25:31 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0EB85211AE;
 Wed, 16 Aug 2023 14:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692195928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGhGE717fUJFvyUY5vhbyY/GLiHbUzH5b0cd6j63xVg=;
 b=sXKigsg0Uvi1sIiHxKJHLSbbF7vU2X2kJf+2VuxA70kHbsVO0K1pSHMNgXA2hh1Yfoe20J
 IE1uisSmeNC4+uHkf40hsqBUg2xLtGzKOvLMXgCU/u13gDuCeubi6WrhgoglnH9EJejCxo
 FnEHJ822ZelwZh6Vt2705LHEnV7N0YQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692195928;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DGhGE717fUJFvyUY5vhbyY/GLiHbUzH5b0cd6j63xVg=;
 b=V8ENgObPzOl/SoSeAfxbcbekXhazIcjgw/bjbVHQvVTxxACIsoj6sNFEkVkAxvC+ZlJsTS
 thu0aElSUSzma1BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8402C133F2;
 Wed, 16 Aug 2023 14:25:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kLekE1bc3GShdwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 16 Aug 2023 14:25:26 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v4 7/8] migration: Move return path cleanup to main migration
 thread
Date: Wed, 16 Aug 2023 11:25:09 -0300
Message-Id: <20230816142510.5637-8-farosas@suse.de>
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

Now that the return path thread is allowed to finish during a paused
migration, we can move the cleanup of the QEMUFiles to the main
migration thread.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7dfcbc3634..7fec57ad7f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -98,6 +98,7 @@ static int migration_maybe_pause(MigrationState *s,
                                  int *current_active_state,
                                  int new_state);
 static void migrate_fd_cancel(MigrationState *s);
+static int await_return_path_close_on_source(MigrationState *s);
 
 static bool migration_needs_multiple_sockets(void)
 {
@@ -1177,6 +1178,12 @@ static void migrate_fd_cleanup(MigrationState *s)
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
@@ -1985,7 +1992,6 @@ out:
     }
 
     trace_source_return_path_thread_end();
-    migration_release_dst_files(ms);
     rcu_unregister_thread();
     return NULL;
 }
@@ -2039,6 +2045,9 @@ static int await_return_path_close_on_source(MigrationState *ms)
 
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 090D379AA88
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 19:15:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfkTm-0002mz-D7; Mon, 11 Sep 2023 13:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfkTk-0002mh-Nt
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 13:13:40 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qfkTc-00009j-FQ
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 13:13:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5DD9321860;
 Mon, 11 Sep 2023 17:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694452411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ratvuBX3qQ91vHO0LxE42YTYPtTJVqto9t43u0ml8kE=;
 b=RA8+wNYMyGLJM6odTLQY9gvtqnhQt1tzx27oKif49ocJYohGIPXMnG36fmpru1wGJMi9Ed
 OXSBbVo/hreZBRiAwe+iiY2aFSWl75ptuqiiK3uZksEGrrMCi53wxK/yHOCzAsaS1HFAkI
 gLZSb7UDKSJojadL7aaHytKIXlf9sT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694452411;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ratvuBX3qQ91vHO0LxE42YTYPtTJVqto9t43u0ml8kE=;
 b=r//NEdKFlVpq8jCfWRBjzRlMlBPxcxsSocu4u0WK4ONXiCiFo65uLNK03YpjvR1rlUhj6U
 ux75easfabIl/eCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5BC3139CC;
 Mon, 11 Sep 2023 17:13:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6CbGILlK/2QyIAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 11 Sep 2023 17:13:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v6 03/10] migration: Fix possible race when shutting down
 to_dst_file
Date: Mon, 11 Sep 2023 14:13:13 -0300
Message-Id: <20230911171320.24372-4-farosas@suse.de>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

It's not safe to call qemu_file_shutdown() on the to_dst_file without
first checking for the file's presence under the lock. The cleanup of
this file happens at postcopy_pause() and migrate_fd_cleanup() which
are not necessarily running in the same thread as migrate_fd_cancel().

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 85c171f32c..5e6a766235 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1245,7 +1245,7 @@ static void migrate_fd_error(MigrationState *s, const Error *error)
 static void migrate_fd_cancel(MigrationState *s)
 {
     int old_state ;
-    QEMUFile *f = migrate_get_current()->to_dst_file;
+
     trace_migrate_fd_cancel();
 
     WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
@@ -1271,11 +1271,13 @@ static void migrate_fd_cancel(MigrationState *s)
      * If we're unlucky the migration code might be stuck somewhere in a
      * send/write while the network has failed and is waiting to timeout;
      * if we've got shutdown(2) available then we can force it to quit.
-     * The outgoing qemu file gets closed in migrate_fd_cleanup that is
-     * called in a bh, so there is no race against this cancel.
      */
-    if (s->state == MIGRATION_STATUS_CANCELLING && f) {
-        qemu_file_shutdown(f);
+    if (s->state == MIGRATION_STATUS_CANCELLING) {
+        WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
+            if (s->to_dst_file) {
+                qemu_file_shutdown(s->to_dst_file);
+            }
+        }
     }
     if (s->state == MIGRATION_STATUS_CANCELLING && s->block_inactive) {
         Error *local_err = NULL;
@@ -1519,12 +1521,14 @@ void qmp_migrate_pause(Error **errp)
 {
     MigrationState *ms = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
-    int ret;
+    int ret = 0;
 
     if (ms->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
         /* Source side, during postcopy */
         qemu_mutex_lock(&ms->qemu_file_lock);
-        ret = qemu_file_shutdown(ms->to_dst_file);
+        if (ms->to_dst_file) {
+            ret = qemu_file_shutdown(ms->to_dst_file);
+        }
         qemu_mutex_unlock(&ms->qemu_file_lock);
         if (ret) {
             error_setg(errp, "Failed to pause source migration");
-- 
2.35.3



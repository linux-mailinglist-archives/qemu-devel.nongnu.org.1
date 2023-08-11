Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75042779288
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 17:10:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUTl7-0000ba-1F; Fri, 11 Aug 2023 11:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qUTkz-0000Zs-9w
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:08:53 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qUTkv-0006Hu-3k
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 11:08:51 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE7B62188D;
 Fri, 11 Aug 2023 15:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691766527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGQOHZA1EOlvWg+cTrtICJk/oIlwUWTaoHqhgAIgHuE=;
 b=t8vx8ShN4dS+OUzU4cVi1tvRwEx1J23jGljol5fvTyMr5zDIncmUnUYddtTfGApUOlgahM
 cd+xxsqYSQ1Des9gHiXOcuvhTSoUvvG4AN7I3LxEVziVEF9UfbvOCG2BGJfjLTacSMnJsw
 uGDUziFeaVtgFrAW5UDjAZAvGtq5Bx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691766527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TGQOHZA1EOlvWg+cTrtICJk/oIlwUWTaoHqhgAIgHuE=;
 b=I3E5xfudieMG3Th5S5nkqgq3SFSvyCtrHsOGq4n8VyaaEonjMoa1S3a3+MDc6YQnk822u8
 Zo2JLyXthOhdTSAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D3BB13592;
 Fri, 11 Aug 2023 15:08:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4GpPBv5O1mS7KwAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 11 Aug 2023 15:08:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v3 04/10] migration: Fix possible race when shutting down
 to_dst_file
Date: Fri, 11 Aug 2023 12:08:30 -0300
Message-Id: <20230811150836.2895-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230811150836.2895-1-farosas@suse.de>
References: <20230811150836.2895-1-farosas@suse.de>
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

It's not safe to call qemu_file_shutdown() on the to_dst_file without
first checking for the file's presence under the lock. The cleanup of
this file happens at postcopy_pause() and migrate_fd_cleanup() which
are not necessarily running in the same thread as migrate_fd_cancel().

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



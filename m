Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD7F8331A0
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 00:41:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQySa-000235-IA; Fri, 19 Jan 2024 18:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQySY-000217-Na
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:39:38 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQyST-0001zp-94
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:39:38 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E281E1F825;
 Fri, 19 Jan 2024 23:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705707572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0XQTyt/2YjP2TRQqmcfI1a7NiC92TEF2AK8VliVRkI4=;
 b=mfFP+mVIKYYBD20OK3AwMh1fV+Z8iIlRRiwOJpmPQAtC5UWSwizwIksEFqcSCfVvmo4B/c
 +Z0k4mrMYBjHI6ZFdr0Eslseoyj6ZAEzwZFBZNx7BLqPGh9jn3zWDTCSY0rXIEQsOWSl5r
 2/8pXSHP8r3/Hbuljk6YhKNwGlBvoVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705707572;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0XQTyt/2YjP2TRQqmcfI1a7NiC92TEF2AK8VliVRkI4=;
 b=h7jDT+TUQOgTwhk9K0Ikfj3b//g9AhH9CvC/RkgUHLuLr9CJ0CCgnBFdEDtOV6h4vQshXO
 bTz7eBb9++dISAAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705707571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0XQTyt/2YjP2TRQqmcfI1a7NiC92TEF2AK8VliVRkI4=;
 b=OZIIXJgrpTKBTxQnx1HIQuCGtf3OgKrVrXm5qlmBUTuVq+xggt25ebOEBc3oXi7NxwHp4O
 pb2WvEEM41nOh44x3q91IhWEcfOQC22936QD9IefL73lQPyQutf4IrUuSPQALyL/8IMrg/
 5sZsC8kg5zbCeKRiKLmnWsx8SpykKSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705707571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0XQTyt/2YjP2TRQqmcfI1a7NiC92TEF2AK8VliVRkI4=;
 b=lwFbaowjwDeMH9nEVMyLal1ggKju+5bPg/LOpIsT0RBWKk0Iq+DbM14TR0I0sqFw83i/Zw
 IobyV2weB6DIouDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1A8C1375D;
 Fri, 19 Jan 2024 23:39:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8CkdLTIIq2VxVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Jan 2024 23:39:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PATCH 4/5] migration: Add a wrapper to qemu_bh_schedule
Date: Fri, 19 Jan 2024 20:39:21 -0300
Message-Id: <20240119233922.32588-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240119233922.32588-1-farosas@suse.de>
References: <20240119233922.32588-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OZIIXJgr;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lwFbaowj
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.84 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.65)[98.47%]
X-Spam-Score: 0.84
X-Rspamd-Queue-Id: E281E1F825
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
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

Wrap qemu_bh_schedule() to ensure we always hold a reference to the
current_migration object.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index b1213b59ce..0e7f101d64 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -199,6 +199,16 @@ void migration_object_init(void)
     dirty_bitmap_mig_init();
 }
 
+static void migration_bh_schedule(MigrationState *s, QEMUBH *bh)
+{
+    /*
+     * Ref the state for bh, because it may be called when
+     * there're already no other refs
+     */
+    object_ref(OBJECT(s));
+    qemu_bh_schedule(bh);
+}
+
 void migration_cancel(const Error *error)
 {
     if (error) {
@@ -714,8 +724,7 @@ process_incoming_migration_co(void *opaque)
     }
 
     mis->bh = qemu_bh_new(process_incoming_migration_bh, mis);
-    object_ref(OBJECT(migrate_get_current()));
-    qemu_bh_schedule(mis->bh);
+    migration_bh_schedule(migrate_get_current(), mis->bh);
     return;
 fail:
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
@@ -1332,16 +1341,6 @@ static void migrate_fd_cleanup(MigrationState *s)
     yank_unregister_instance(MIGRATION_YANK_INSTANCE);
 }
 
-static void migrate_fd_cleanup_schedule(MigrationState *s)
-{
-    /*
-     * Ref the state for bh, because it may be called when
-     * there're already no other refs
-     */
-    object_ref(OBJECT(s));
-    qemu_bh_schedule(s->cleanup_bh);
-}
-
 static void migrate_fd_cleanup_bh(void *opaque)
 {
     MigrationState *s = opaque;
@@ -3140,7 +3139,7 @@ static void migration_iteration_finish(MigrationState *s)
         error_report("%s: Unknown ending state %d", __func__, s->state);
         break;
     }
-    migrate_fd_cleanup_schedule(s);
+    migration_bh_schedule(s, s->cleanup_bh);
     bql_unlock();
 }
 
@@ -3171,7 +3170,7 @@ static void bg_migration_iteration_finish(MigrationState *s)
         break;
     }
 
-    migrate_fd_cleanup_schedule(s);
+    migration_bh_schedule(s, s->cleanup_bh);
     bql_unlock();
 }
 
@@ -3487,9 +3486,7 @@ static void *bg_migration_thread(void *opaque)
      * writes to virtio VQs memory which is in write-protected region.
      */
     s->vm_start_bh = qemu_bh_new(bg_migration_vm_start_bh, s);
-    object_ref(OBJECT(s));
-    qemu_bh_schedule(s->vm_start_bh);
-
+    migration_bh_schedule(s, s->vm_start_bh);
     bql_unlock();
 
     while (migration_is_active(s)) {
-- 
2.35.3



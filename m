Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F4DA34CB3
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Feb 2025 19:01:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tidV8-00063D-Bx; Thu, 13 Feb 2025 12:59:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tidV4-00062D-A8
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:59:46 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tidV2-00068B-IZ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:59:45 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 424141F7D5;
 Thu, 13 Feb 2025 17:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739469583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqYihIibyWzFsfc9DKP4F9feIU8zrcGN4fyn5ULpxBA=;
 b=MYbLkxv4ZoHfg4bpZk3UJKkDe/FAMKa9hmwCv1asJI4lUGLjtKWYF3iRllFjiZtzyZ8wV7
 Ey2wx6XUUYPQzSK8/WvdLfiW7qsAKf1/jjw+dRDLJDL3kF/cLHKlpFAod2+IiSrNM1AO/k
 t75t5zF2+W5EddM44BrC4Nf6SUhIfB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739469583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqYihIibyWzFsfc9DKP4F9feIU8zrcGN4fyn5ULpxBA=;
 b=MsW5fXw6MyMOWV+BNYD9Qr3dfX1A1tGfDElhszBTymky0CjohvjTONkck6XTxzaRMFc+R7
 qKrHAldZqzbOLpBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MYbLkxv4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=MsW5fXw6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739469583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqYihIibyWzFsfc9DKP4F9feIU8zrcGN4fyn5ULpxBA=;
 b=MYbLkxv4ZoHfg4bpZk3UJKkDe/FAMKa9hmwCv1asJI4lUGLjtKWYF3iRllFjiZtzyZ8wV7
 Ey2wx6XUUYPQzSK8/WvdLfiW7qsAKf1/jjw+dRDLJDL3kF/cLHKlpFAod2+IiSrNM1AO/k
 t75t5zF2+W5EddM44BrC4Nf6SUhIfB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739469583;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mqYihIibyWzFsfc9DKP4F9feIU8zrcGN4fyn5ULpxBA=;
 b=MsW5fXw6MyMOWV+BNYD9Qr3dfX1A1tGfDElhszBTymky0CjohvjTONkck6XTxzaRMFc+R7
 qKrHAldZqzbOLpBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E10D913874;
 Thu, 13 Feb 2025 17:59:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eKdZJw0zrmfqMgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 13 Feb 2025 17:59:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 6/9] migration: Don't set FAILED state when cancelling
Date: Thu, 13 Feb 2025 14:59:24 -0300
Message-Id: <20250213175927.19642-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250213175927.19642-1-farosas@suse.de>
References: <20250213175927.19642-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 424141F7D5
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The expected outcome from qmp_migrate_cancel() is that the source
migration goes to the terminal state
MIGRATION_STATUS_CANCELLED. Anything different from this is a bug when
cancelling.

Make sure there is never a state transition from an unspecified state
into FAILED. Code that sets FAILED, should always either make sure
that the old state is not CANCELLING or specify the old state.

Note that the destination is allowed to go into FAILED, so there's no
issue there.

(I don't think this is relevant as a backport because cancelling does
work, it just doesn't show the right state at the end)

Fixes: 3dde8fdbad ("migration: Merge precopy/postcopy on switchover start")
Fixes: d0edb8a173 ("migration: Create the postcopy preempt channel asynchronously")
Fixes: 8518278a6a ("migration: implementation of background snapshot thread")
Fixes: bf78a046b9 ("migration: refactor migrate_fd_connect failures")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 48c9ad3c96..c597aa707e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2648,7 +2648,10 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     if (migrate_postcopy_preempt()) {
         migration_wait_main_channel(ms);
         if (postcopy_preempt_establish_channel(ms)) {
-            migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
+            if (ms->state != MIGRATION_STATUS_CANCELLING) {
+                migrate_set_state(&ms->state, ms->state,
+                                  MIGRATION_STATUS_FAILED);
+            }
             error_setg(errp, "%s: Failed to establish preempt channel",
                        __func__);
             return -1;
@@ -2986,7 +2989,9 @@ fail:
         error_free(local_err);
     }
 
-    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+    if (s->state != MIGRATION_STATUS_CANCELLING) {
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+    }
 }
 
 /**
@@ -3009,7 +3014,7 @@ static void bg_migration_completion(MigrationState *s)
         qemu_put_buffer(s->to_dst_file, s->bioc->data, s->bioc->usage);
         qemu_fflush(s->to_dst_file);
     } else if (s->state == MIGRATION_STATUS_CANCELLING) {
-        goto fail;
+        return;
     }
 
     if (qemu_file_get_error(s->to_dst_file)) {
@@ -3953,7 +3958,9 @@ void migration_connect(MigrationState *s, Error *error_in)
 
 fail:
     migrate_set_error(s, local_err);
-    migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+    if (s->state != MIGRATION_STATUS_CANCELLING) {
+        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
+    }
     error_report_err(local_err);
     migration_cleanup(s);
 }
-- 
2.35.3



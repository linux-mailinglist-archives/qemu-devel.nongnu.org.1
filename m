Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3F476D046
	for <lists+qemu-devel@lfdr.de>; Wed,  2 Aug 2023 16:40:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRCyl-0006bR-BA; Wed, 02 Aug 2023 10:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qRCyC-0005By-E3
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 10:37:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qRCy3-00072D-WE
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 10:36:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7AF8A1F889;
 Wed,  2 Aug 2023 14:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690987010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMb3qAivY1c37CdOHWbc5oVyEYgvE5PM07Pa/uSzoM4=;
 b=xo/+g996iUrVEqKdZBxUWUOZyeazVp7/NHvWzgkFNNbjWKo93qlthyZL2fbSVhEs0XxcJR
 7w5bZ0w2vmTab+5NbrYXfT7CSkJvHEnT8B1SxsPcZvgRIz2rRlbN0IJ8oHZvUl4d8aCtB1
 946/Ag1kIFMdPE4/Bo10+j3t6Rpa0Yw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690987010;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMb3qAivY1c37CdOHWbc5oVyEYgvE5PM07Pa/uSzoM4=;
 b=CnL36d7nLXs1yno4bih5n5ldz9Lv4rGbNVRrKzgg275x2+y0yx1FtoWBvZ/6gl1b194koq
 Kag0JFEYsbhefNAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 00C0813909;
 Wed,  2 Aug 2023 14:36:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qB4ALwBqymSmEgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 02 Aug 2023 14:36:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: [PATCH v2 1/2] migration: Split await_return_path_close_on_source
Date: Wed,  2 Aug 2023 11:36:43 -0300
Message-Id: <20230802143644.7534-2-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230802143644.7534-1-farosas@suse.de>
References: <20230802143644.7534-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This function currently has a straight-forward part which is waiting
for the thread to join and a complicated part which is doing a
qemu_file_shutdown() on the return path file.

The shutdown is tricky because all calls to qemu_file_shutdown() set
f->last_error to -EIO, which means we can never know if an error is an
actual error or if we cleanly shutdown the file previously.

This is particularly bothersome for postcopy because it would send the
return path thread into the retry routine which would wait on the
postcopy_pause_rp_sem and consequently block the main thread. We
haven't had reports of this so I must presume we never reach here with
postcopy.

The shutdown call is also racy because since it doesn't take the
qemu_file_lock, it could NULL-dereference if the return path thread
happens to be in the middle of the critical region at
migration_release_dst_files().

Move this more complicated part of the code to a separate routine so
we can wait on the thread without all of this baggage.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c | 46 +++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 91bba630a8..58f09275a8 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2038,6 +2038,25 @@ static int open_return_path_on_source(MigrationState *ms,
 /* Returns 0 if the RP was ok, otherwise there was an error on the RP */
 static int await_return_path_close_on_source(MigrationState *ms)
 {
+    if (!ms->rp_state.rp_thread_created) {
+        return 0;
+    }
+
+    trace_await_return_path_close_on_source_joining();
+    qemu_thread_join(&ms->rp_state.rp_thread);
+    ms->rp_state.rp_thread_created = false;
+    trace_await_return_path_close_on_source_close();
+    return ms->rp_state.error;
+}
+
+static int close_return_path_on_source(MigrationState *ms)
+{
+    int ret;
+
+    if (!ms->rp_state.rp_thread_created) {
+        return 0;
+    }
+
     /*
      * If this is a normal exit then the destination will send a SHUT and the
      * rp_thread will exit, however if there's an error we need to cause
@@ -2051,11 +2070,12 @@ static int await_return_path_close_on_source(MigrationState *ms)
         qemu_file_shutdown(ms->rp_state.from_dst_file);
         mark_source_rp_bad(ms);
     }
-    trace_await_return_path_close_on_source_joining();
-    qemu_thread_join(&ms->rp_state.rp_thread);
-    ms->rp_state.rp_thread_created = false;
-    trace_await_return_path_close_on_source_close();
-    return ms->rp_state.error;
+
+    trace_migration_return_path_end_before();
+    ret = await_return_path_close_on_source(ms);
+    trace_migration_return_path_end_after(ret);
+
+    return ret;
 }
 
 static inline void
@@ -2351,20 +2371,8 @@ static void migration_completion(MigrationState *s)
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
+    if (close_return_path_on_source(s)) {
+        goto fail;
     }
 
     if (qemu_file_get_error(s->to_dst_file)) {
-- 
2.35.3



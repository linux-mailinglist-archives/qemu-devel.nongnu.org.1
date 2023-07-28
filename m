Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 714D7766DDD
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:12:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPMNw-0008Q8-3O; Fri, 28 Jul 2023 08:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qPMNU-0008MR-QV
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 08:15:47 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qPMNR-0001be-3R
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 08:15:27 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E2B49219DB;
 Fri, 28 Jul 2023 12:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690546523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x1NX5e+s4TSo2RVnYpLpDHBnlHTIjC1lK3bw9ReJxG8=;
 b=Ugw58yjx+AYT5lTrnfPPjn4JLGJpjCRnmB1sVKC3PbVmPol/2JE0H6lxYIH6v51ehwT/0q
 rm71sdn1QDHjHLsXUOehcA78tCQLxx4oJTMP0e7aAllM7AbDtiLuUcVGhq7vl80FbkqIkf
 84zVmV3W3jAFPXjLV/7TkuWHJO2WgrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690546523;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x1NX5e+s4TSo2RVnYpLpDHBnlHTIjC1lK3bw9ReJxG8=;
 b=Y1IVzC0LDDoDgJiLAb7E2mtwyAVv7/wEspw63eHXnuC2DUu4WOgFxCeyEFtHgoczwthwys
 Myql1vxIs+YEDuCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A66313276;
 Fri, 28 Jul 2023 12:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uPEUGVqxw2RBYQAAMHmgww
 (envelope-from <farosas@suse.de>); Fri, 28 Jul 2023 12:15:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: [PATCH 2/3] migration: Simplify calling of
 await_return_path_close_on_source
Date: Fri, 28 Jul 2023 09:15:15 -0300
Message-Id: <20230728121516.16258-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230728121516.16258-1-farosas@suse.de>
References: <20230728121516.16258-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

We're about to reuse this function so move the 'rp_thread_created'
check into it and remove the redundant tracing and comment.

Add a new tracepoint akin to what is already done at
migration_completion().

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/migration.c  | 21 +++++++--------------
 migration/trace-events |  3 +--
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 051067f8c5..d6f4470265 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2038,6 +2038,10 @@ static int open_return_path_on_source(MigrationState *ms,
 /* Returns 0 if the RP was ok, otherwise there was an error on the RP */
 static int await_return_path_close_on_source(MigrationState *ms)
 {
+    if (!ms->rp_state.rp_thread_created) {
+        return 0;
+    }
+
     /*
      * If this is a normal exit then the destination will send a SHUT and the
      * rp_thread will exit, however if there's an error we need to cause
@@ -2350,20 +2354,9 @@ static void migration_completion(MigrationState *s)
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
+        trace_migration_completion_rp_err();
+        goto fail;
     }
 
     if (qemu_file_get_error(s->to_dst_file)) {
diff --git a/migration/trace-events b/migration/trace-events
index 5259c1044b..33a69064ca 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -157,13 +157,12 @@ migrate_pending_estimate(uint64_t size, uint64_t pre, uint64_t post) "estimate p
 migrate_send_rp_message(int msg_type, uint16_t len) "%d: len %d"
 migrate_send_rp_recv_bitmap(char *name, int64_t size) "block '%s' size 0x%"PRIi64
 migration_completion_file_err(void) ""
+migration_completion_rp_err(void) ""
 migration_completion_vm_stop(int ret) "ret %d"
 migration_completion_postcopy_end(void) ""
 migration_completion_postcopy_end_after_complete(void) ""
 migration_rate_limit_pre(int ms) "%d ms"
 migration_rate_limit_post(int urgent) "urgent: %d"
-migration_return_path_end_before(void) ""
-migration_return_path_end_after(int rp_error) "%d"
 migration_thread_after_loop(void) ""
 migration_thread_file_err(void) ""
 migration_thread_setup_complete(void) ""
-- 
2.35.3



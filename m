Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DD37D40F6
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:37:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1fH-0002lQ-Bx; Mon, 23 Oct 2023 16:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1f4-0002kO-O7
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1f2-0001nb-57
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:30 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F072321B2B;
 Mon, 23 Oct 2023 20:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MN/9Rl5hTxRBM5kTsHsF/qHtTFcfjGc7CfXTqshdHOY=;
 b=F64ij8sSYsOWIbJCp/iSVGv2odXZJTtGNWysGfu2rQjweehtFH9GAKdXECK2PgzRew8g1x
 CzDjS9eexiHxQxioYDLI5MNIYGhEo0e1dvnIXi8pIWUXhTKNBYO2zGHRSsGFsriH9+VfIe
 662mlxtU1R5s/nmlHaTzfgp2ecQqO0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093386;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MN/9Rl5hTxRBM5kTsHsF/qHtTFcfjGc7CfXTqshdHOY=;
 b=5I9hAkaIp1Q15cvRiwVa1AdtHf3A0xNp8btIqpi6caH4HdBMaNRIBNAKdiC+c6sbSgIoUD
 zYBc8zH2OWrtVdCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16523132FD;
 Mon, 23 Oct 2023 20:36:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EOywNEjZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:36:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v2 05/29] migration: Introduce global_state_store_once
Date: Mon, 23 Oct 2023 17:35:44 -0300
Message-Id: <20231023203608.26370-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023203608.26370-1-farosas@suse.de>
References: <20231023203608.26370-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
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

There are some situations during migration when we want to change the
runstate of the VM, but don't actually want the new runstate to be put
on the wire to be restored on the destination VM. In those cases, the
pattern is to use global_state_store() to save the state for migration
before changing it.

One scenario where this happens is when switching the source VM into
the FINISH_MIGRATE state. This state only makes sense on the source
VM. Another situation is when pausing the source VM prior to migration
completion.

We are about to introduce a third scenario when the whole migration
should be performed with a paused VM. In this case we will want to
save the VM runstate at the very start of the migration and that state
will be the one restored on the destination regardless of all the
runstate changes that happen in between.

To achieve that we need to make sure that the other two calls to
global_state_store() do not overwrite the state that is to be
migrated.

Introduce a version of global_state_store() that only saves the state
if no other state has already been saved.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/global_state.h |  1 +
 migration/global_state.c         | 13 +++++++++++++
 migration/migration.c            |  6 +++---
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/migration/global_state.h b/include/migration/global_state.h
index e268dc1f18..9d3624100e 100644
--- a/include/migration/global_state.h
+++ b/include/migration/global_state.h
@@ -17,6 +17,7 @@
 
 void register_global_state(void);
 RunState global_state_store(void);
+RunState global_state_store_once(void);
 void global_state_store_running(void);
 bool global_state_received(void);
 RunState global_state_get_runstate(void);
diff --git a/migration/global_state.c b/migration/global_state.c
index d094af6198..beb00039d9 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -45,6 +45,19 @@ RunState global_state_store(void)
     return r;
 }
 
+RunState global_state_store_once(void)
+{
+    int r;
+    char *runstate = (char *)global_state.runstate;
+
+    r = qapi_enum_parse(&RunState_lookup, runstate, -1, NULL);
+    if (r < 0) {
+        return global_state_store();
+    }
+
+    return r;
+}
+
 void global_state_store_running(void)
 {
     global_state_do_store(RUN_STATE_RUNNING);
diff --git a/migration/migration.c b/migration/migration.c
index 0c23117369..a6efbd837a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2144,7 +2144,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     trace_postcopy_start_set_run();
 
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
-    global_state_store();
+    global_state_store_once();
     ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
     if (ret < 0) {
         goto fail;
@@ -2344,7 +2344,7 @@ static int migration_completion_precopy(MigrationState *s,
     s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
 
-    s->vm_old_state = global_state_store();
+    s->vm_old_state = global_state_store_once();
 
     ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
     trace_migration_completion_vm_stop(ret);
@@ -3200,7 +3200,7 @@ static void *bg_migration_thread(void *opaque)
      * transition in vm_stop_force_state() we need to wakeup it up.
      */
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
-    s->vm_old_state = global_state_store();
+    s->vm_old_state = global_state_store_once();
 
     /* Forcibly stop VM before saving state of vCPUs and devices */
     if (vm_stop_force_state(RUN_STATE_PAUSED)) {
-- 
2.35.3



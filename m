Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EFA7D4108
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 22:39:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv1f6-0002kX-VM; Mon, 23 Oct 2023 16:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1f3-0002k8-D7
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:29 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qv1f1-0001nQ-Of
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 16:36:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A4BA21FE38;
 Mon, 23 Oct 2023 20:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698093384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0u7duS6dyvaT8TiOJ6V1+0DT2Vtx+lGHJt60GutAQM=;
 b=v09lQ3QKPYhGMFrC+CQKUHaEWLi/i6IXsWuNoOpSlFIlTMnE5Ct0ApbgoYTe8oEPYt4kMw
 3FwM4dQZyW5r7GMmN2KAwWGQwq/Z0p6sSl8Z1Hc/Q0oO/Ldli4p6NMIGA1Lo2cq2vmvqhn
 daOheRQfC5ZkCeHO427Sc5x+00ooAGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698093384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0u7duS6dyvaT8TiOJ6V1+0DT2Vtx+lGHJt60GutAQM=;
 b=/RLLFmPkYaBJutNtM3dPFQ4N8ehpxZs1lGqsv0ZPRS9xw2jJA4FT7G727ePI/I47+KfnvI
 aLtUr1M1SVAHZfBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACC85132FD;
 Mon, 23 Oct 2023 20:36:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IEFjHUbZNmV1JQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 20:36:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v2 04/29] migration: Return the saved state from
 global_state_store
Date: Mon, 23 Oct 2023 17:35:43 -0300
Message-Id: <20231023203608.26370-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023203608.26370-1-farosas@suse.de>
References: <20231023203608.26370-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -0.48
X-Spamd-Result: default: False [-0.48 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.38)[90.76%]
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

There is a pattern of calling runstate_get() to store the current
runstate and calling global_state_store() to save the current runstate
for migration. Since global_state_store() also calls runstate_get(),
make it return the runstate instead.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/global_state.h | 2 +-
 migration/global_state.c         | 7 +++++--
 migration/migration.c            | 6 ++----
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/migration/global_state.h b/include/migration/global_state.h
index d7c2cd3216..e268dc1f18 100644
--- a/include/migration/global_state.h
+++ b/include/migration/global_state.h
@@ -16,7 +16,7 @@
 #include "qapi/qapi-types-run-state.h"
 
 void register_global_state(void);
-void global_state_store(void);
+RunState global_state_store(void);
 void global_state_store_running(void);
 bool global_state_received(void);
 RunState global_state_get_runstate(void);
diff --git a/migration/global_state.c b/migration/global_state.c
index 4e2a9d8ec0..d094af6198 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -37,9 +37,12 @@ static void global_state_do_store(RunState state)
               state_str, '\0');
 }
 
-void global_state_store(void)
+RunState global_state_store(void)
 {
-    global_state_do_store(runstate_get());
+    RunState r = runstate_get();
+
+    global_state_do_store(r);
+    return r;
 }
 
 void global_state_store_running(void)
diff --git a/migration/migration.c b/migration/migration.c
index 67547eb6a1..0c23117369 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2344,8 +2344,7 @@ static int migration_completion_precopy(MigrationState *s,
     s->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
 
-    s->vm_old_state = runstate_get();
-    global_state_store();
+    s->vm_old_state = global_state_store();
 
     ret = vm_stop_force_state(RUN_STATE_FINISH_MIGRATE);
     trace_migration_completion_vm_stop(ret);
@@ -3201,9 +3200,8 @@ static void *bg_migration_thread(void *opaque)
      * transition in vm_stop_force_state() we need to wakeup it up.
      */
     qemu_system_wakeup_request(QEMU_WAKEUP_REASON_OTHER, NULL);
-    s->vm_old_state = runstate_get();
+    s->vm_old_state = global_state_store();
 
-    global_state_store();
     /* Forcibly stop VM before saving state of vCPUs and devices */
     if (vm_stop_force_state(RUN_STATE_PAUSED)) {
         goto fail;
-- 
2.35.3



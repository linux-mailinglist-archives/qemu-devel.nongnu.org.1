Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE3C1823B75
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 05:34:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLFPh-0000WE-82; Wed, 03 Jan 2024 23:33:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFPf-0000Op-9p
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:32:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rLFPd-0006ZZ-Bz
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 23:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704342776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8TfpCka1YSMdMRbf5/huRwSV5G6ZPsE5XhlMly3s4AI=;
 b=R3qdOUW9daCLalVkEYckRWh5h71OFZjZhbfNGPVg9O7546jhBi/FS57DM2tW087p+x5TRe
 tVA6IoUR3ORg5MtYKAlN1z3cRXSbvvbOT9VcN/ju/pVdELogxoriOSKlBrX5zxE9WqoE+P
 UQmwVUBT3v8ITdlrvUCSCWHeXvWHKuU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-28d9F-tAOKeKefhifK3dpg-1; Wed,
 03 Jan 2024 23:32:55 -0500
X-MC-Unique: 28d9F-tAOKeKefhifK3dpg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 109BF3816D84;
 Thu,  4 Jan 2024 04:32:55 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 39426C15968;
 Thu,  4 Jan 2024 04:32:49 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>,
 Juan Quintela <quintela@trasno.org>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 07/26] migration: propagate suspended runstate
Date: Thu,  4 Jan 2024 12:31:52 +0800
Message-ID: <20240104043213.431566-8-peterx@redhat.com>
In-Reply-To: <20240104043213.431566-1-peterx@redhat.com>
References: <20240104043213.431566-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.601,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

If the outgoing machine was previously suspended, propagate that to the
incoming side via global_state, so a subsequent vm_start restores the
suspended state.  To maintain backward and forward compatibility, reclaim
some space from the runstate member.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/1704312341-66640-6-git-send-email-steven.sistare@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/global_state.c | 47 +++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/migration/global_state.c b/migration/global_state.c
index 4e2a9d8ec0..64a573c683 100644
--- a/migration/global_state.c
+++ b/migration/global_state.c
@@ -22,7 +22,16 @@
 
 typedef struct {
     uint32_t size;
-    uint8_t runstate[100];
+
+    /*
+     * runstate was 100 bytes, zero padded, but we trimmed it to add a
+     * few fields and maintain backwards compatibility.
+     */
+    uint8_t runstate[32];
+    uint8_t has_vm_was_suspended;
+    uint8_t vm_was_suspended;
+    uint8_t unused[66];
+
     RunState state;
     bool received;
 } GlobalState;
@@ -35,6 +44,10 @@ static void global_state_do_store(RunState state)
     assert(strlen(state_str) < sizeof(global_state.runstate));
     strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
               state_str, '\0');
+    global_state.has_vm_was_suspended = true;
+    global_state.vm_was_suspended = vm_get_suspended();
+
+    memset(global_state.unused, 0, sizeof(global_state.unused));
 }
 
 void global_state_store(void)
@@ -59,24 +72,7 @@ RunState global_state_get_runstate(void)
 
 static bool global_state_needed(void *opaque)
 {
-    GlobalState *s = opaque;
-    char *runstate = (char *)s->runstate;
-
-    /* If it is not optional, it is mandatory */
-
-    if (migrate_get_current()->store_global_state) {
-        return true;
-    }
-
-    /* If state is running or paused, it is not needed */
-
-    if (strcmp(runstate, "running") == 0 ||
-        strcmp(runstate, "paused") == 0) {
-        return false;
-    }
-
-    /* for any other state it is needed */
-    return true;
+    return migrate_get_current()->store_global_state;
 }
 
 static int global_state_post_load(void *opaque, int version_id)
@@ -93,7 +89,7 @@ static int global_state_post_load(void *opaque, int version_id)
                 sizeof(s->runstate)) == sizeof(s->runstate)) {
         /*
          * This condition should never happen during migration, because
-         * all runstate names are shorter than 100 bytes (the size of
+         * all runstate names are shorter than 32 bytes (the size of
          * s->runstate). However, a malicious stream could overflow
          * the qapi_enum_parse() call, so we force the last character
          * to a NUL byte.
@@ -110,6 +106,14 @@ static int global_state_post_load(void *opaque, int version_id)
     }
     s->state = r;
 
+    /*
+     * global_state is saved on the outgoing side before forcing a stopped
+     * state, so it may have saved state=suspended and vm_was_suspended=0.
+     * Now we are in a paused state, and when we later call vm_start, it must
+     * restore the suspended state, so we must set vm_was_suspended=1 here.
+     */
+    vm_set_suspended(s->vm_was_suspended || r == RUN_STATE_SUSPENDED);
+
     return 0;
 }
 
@@ -134,6 +138,9 @@ static const VMStateDescription vmstate_globalstate = {
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(size, GlobalState),
         VMSTATE_BUFFER(runstate, GlobalState),
+        VMSTATE_UINT8(has_vm_was_suspended, GlobalState),
+        VMSTATE_UINT8(vm_was_suspended, GlobalState),
+        VMSTATE_BUFFER(unused, GlobalState),
         VMSTATE_END_OF_LIST()
     },
 };
-- 
2.41.0



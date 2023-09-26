Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1787AF02D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:02:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlATc-0000nc-D6; Tue, 26 Sep 2023 11:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qlATa-0000lB-EQ
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qlATY-00080Q-TW
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695743992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VZkf53Aba5z/edFlTgY8x01NMPUo1KjmUdwQvCtIJ4I=;
 b=RJp/lhQ+ogs+YsSQyuKN7mIML5L9xTDLwuNT9Dk4NOwb+oD0ItPsyYJPFfxHqL2XMA25SE
 LirT9vgXjgMfwj02H70MJ8k76KDtcEaFnJal189wU5WUtCzLdZxMVjz0zkAw3nmJcTWwTE
 IKCZag/DafRUN90za1g6sLOmq+fLFoQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-7CP5MYWoOYWJ6fO3btcMxw-1; Tue, 26 Sep 2023 11:59:50 -0400
X-MC-Unique: 7CP5MYWoOYWJ6fO3btcMxw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29F1E101A58B;
 Tue, 26 Sep 2023 15:59:50 +0000 (UTC)
Received: from localhost (unknown [10.39.208.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6CC65492C37;
 Tue, 26 Sep 2023 15:59:49 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-block@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, Peter Xu <peterx@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 5/5] RFC: migration: check required entries are loaded, once
Date: Tue, 26 Sep 2023 19:59:25 +0400
Message-ID: <20230926155925.1396309-6-marcandre.lureau@redhat.com>
In-Reply-To: <20230926155925.1396309-1-marcandre.lureau@redhat.com>
References: <20230926155925.1396309-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 migration/savevm.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index bb3e99194c..6a17bb0f73 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -217,6 +217,7 @@ typedef struct SaveStateEntry {
     void *opaque;
     CompatEntry *compat;
     int is_ram;
+    bool visited;
 } SaveStateEntry;
 
 typedef struct SaveState {
@@ -1718,6 +1719,36 @@ int qemu_save_device_state(QEMUFile *f)
     return qemu_file_get_error(f);
 }
 
+static void savevm_reset_visited(void)
+{
+    SaveStateEntry *se;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        se->visited = false;
+    }
+}
+
+static bool loadvm_check_visited(Error **errp)
+{
+    SaveStateEntry *se;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (se->ops && se->ops->is_active && !se->ops->is_active(se->opaque)) {
+            continue;
+        }
+        if (se->vmsd && !vmstate_save_needed(se->vmsd, se->opaque)) {
+            continue;
+        }
+        if (!se->visited) {
+            error_setg(errp, "Missing entry '%s' while loading VM", se->idstr);
+            return false;
+        }
+    }
+
+    return true;
+}
+
+
 static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id)
 {
     SaveStateEntry *se;
@@ -2520,6 +2551,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
                      idstr, instance_id);
         return -EINVAL;
     }
+    if (se->visited) {
+        error_report("error while loading state for instance 0x%"PRIx32" of"
+                     " device '%s'", instance_id, idstr);
+        return -EINVAL;
+    }
 
     /* Validate version */
     if (version_id > se->version_id) {
@@ -2546,6 +2582,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis)
         return -EINVAL;
     }
 
+    se->visited = true;
+
     return 0;
 }
 
@@ -2852,7 +2890,12 @@ int qemu_loadvm_state(QEMUFile *f)
 
     cpu_synchronize_all_pre_loadvm();
 
+    savevm_reset_visited();
     ret = qemu_loadvm_state_main(f, mis);
+    if (!loadvm_check_visited(&local_err)) {
+        error_report_err(local_err);
+        return -EINVAL;
+    }
     qemu_event_set(&mis->main_thread_load_event);
 
     trace_qemu_loadvm_state_post_main(ret);
-- 
2.41.0



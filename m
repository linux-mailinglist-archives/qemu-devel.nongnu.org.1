Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 128917E2059
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:49:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxuG-0003Ug-Ph; Mon, 06 Nov 2023 06:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzxuE-0003Ss-8f
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:36:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzxuC-0003NW-NP
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:36:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699270591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxz4CKuoDceZoulGqF2DZo3Gxh1pLSHJIFAuQk+doJc=;
 b=IvGFSH6WZtnJ+OpY1cQsJv5mRSSODsdkdErlvcCbqhRNAIWKnT0Y+QWBg8eOKrBC0ZegIS
 lTlG3fO6O9fzNHXoPSAv7iGvqPE35z76Y7A48uqlT1o1qmRCA0tsJTndJvua9z9pdu7pbd
 y0UsN0LagKSx0PmYfryX7GxpVF+M2uI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-SN3Em1GNOqGOPJa4gsv6rQ-1; Mon,
 06 Nov 2023 06:36:26 -0500
X-MC-Unique: SN3Em1GNOqGOPJa4gsv6rQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 517C638130A6;
 Mon,  6 Nov 2023 11:36:26 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F492492A;
 Mon,  6 Nov 2023 11:36:25 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 4/6] migration: check required entries are loaded, once
Date: Mon,  6 Nov 2023 15:35:58 +0400
Message-ID: <20231106113601.2052601-5-marcandre.lureau@redhat.com>
In-Reply-To: <20231106113601.2052601-1-marcandre.lureau@redhat.com>
References: <20231106113601.2052601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 migration/savevm.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index bc98c2ea6f..2ae65b8088 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -217,6 +217,7 @@ typedef struct SaveStateEntry {
     void *opaque;
     CompatEntry *compat;
     int is_ram;
+    bool visited;
 } SaveStateEntry;
 
 typedef struct SaveState {
@@ -1787,6 +1788,36 @@ int qemu_save_device_state(QEMUFile *f)
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
+        if (se->vmsd && !vmstate_section_needed(se->vmsd, se->opaque)) {
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
@@ -2592,6 +2623,11 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis,
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
@@ -2629,6 +2665,8 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis,
         return -EINVAL;
     }
 
+    se->visited = true;
+
     return 0;
 }
 
@@ -2950,7 +2988,12 @@ int qemu_loadvm_state(QEMUFile *f)
 
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B99C57E204E
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:46:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxuK-0003Y6-OE; Mon, 06 Nov 2023 06:36:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzxuI-0003Vg-Av
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:36:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qzxuG-0003Pb-Pp
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699270596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ykzcK24toXYFXZThqkyiXwFLo9+xNpodTrpRFNx/j/U=;
 b=NvJ8U5Pyur2fOmnJjqdTEKSc0qruie9PTLfZFCYF/EoAOKjGUW0+8QYnuqn9iZZGRWEaOC
 eGl4YZd+vkxszF4Mpwuj4CDP6DK0C0uT3jPQI7LM0BwmoMRsdKOn5QaLD3reLOVlCmv28Y
 VqkALUWXBBXpblUXEeXbwpGaIvauccg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-zg8EtDQ6PjWCsEam_tXmeg-1; Mon, 06 Nov 2023 06:36:22 -0500
X-MC-Unique: zg8EtDQ6PjWCsEam_tXmeg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D01481D82E;
 Mon,  6 Nov 2023 11:36:22 +0000 (UTC)
Received: from localhost (unknown [10.39.208.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5F959C1596F;
 Mon,  6 Nov 2023 11:36:21 +0000 (UTC)
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
Subject: [PATCH v3 3/6] migration: check required subsections are loaded, once
Date: Mon,  6 Nov 2023 15:35:57 +0400
Message-ID: <20231106113601.2052601-4-marcandre.lureau@redhat.com>
In-Reply-To: <20231106113601.2052601-1-marcandre.lureau@redhat.com>
References: <20231106113601.2052601-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Check that required subsections have been loaded.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 migration/vmstate.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index b7723a4187..9d7a58d26b 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -452,22 +452,51 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 }
 
 static const VMStateDescription *
-vmstate_get_subsection(const VMStateDescription **sub, char *idstr)
+vmstate_get_subsection(const VMStateDescription **sub, char *idstr, bool *visited)
 {
+    size_t i = 0;
+
     while (sub && *sub) {
         if (strcmp(idstr, (*sub)->name) == 0) {
+            if (visited[i]) {
+                return NULL;
+            }
+            visited[i] = true;
             return *sub;
         }
+        i++;
         sub++;
     }
     return NULL;
 }
 
+static size_t
+vmstate_get_n_subsections(const VMStateDescription **sub)
+{
+    size_t n = 0;
+
+    if (!sub) {
+        return 0;
+    }
+
+    while (sub[n]) {
+        n++;
+    }
+
+    return n;
+}
+
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque)
 {
+    size_t i, n;
+    g_autofree bool *visited = NULL;
+
     trace_vmstate_subsection_load(vmsd->name);
 
+    n = vmstate_get_n_subsections(vmsd->subsections);
+    visited = g_new0(bool, n);
+
     while (qemu_peek_byte(f, 0) == QEMU_VM_SUBSECTION) {
         char idstr[256], *idstr_ret;
         int ret;
@@ -493,7 +522,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
             /* it doesn't have a valid subsection name */
             return 0;
         }
-        sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
+        sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr, visited);
         if (sub_vmsd == NULL) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
             return -ENOENT;
@@ -510,6 +539,13 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         }
     }
 
+    for (i = 0; i < n; i++) {
+        if (!visited[i] && vmstate_section_needed(vmsd->subsections[i], opaque)) {
+            error_report("Subsection %s %s missing",
+                         vmsd->name, vmsd->subsections[i]->name);
+        }
+    }
+
     trace_vmstate_subsection_load_good(vmsd->name);
     return 0;
 }
-- 
2.41.0



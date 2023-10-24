Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5834F7D4AAB
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 10:42:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvCys-0004Cc-LD; Tue, 24 Oct 2023 04:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvCyS-0003yl-Fr
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:41:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qvCyP-0003LT-QN
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 04:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698136873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LnsG5NWQMp6ppcb6O/Y0IH9dMdUd6gQTyemwrekuS08=;
 b=PWTockgSkXoVd5oKEn/OxwHbfOCtGtO9ZupfksWL3uR9X2znYWB0+9Ndyb31EzpC1yhHD8
 s4vgjt0defySlf0IO5ZsZ6hpixwv7DoaQzxVWY59rFpnvcoAuJoAExRoAWBkrEergXrraN
 8Mrsyf7vlPQz5tKxYFox2d9LzyS5dM0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-1RGbMSjsMmCVGt_lZbA9OQ-1; Tue,
 24 Oct 2023 04:41:09 -0400
X-MC-Unique: 1RGbMSjsMmCVGt_lZbA9OQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5A25C1C051A1;
 Tue, 24 Oct 2023 08:41:09 +0000 (UTC)
Received: from localhost (unknown [10.39.208.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CE44492BD9;
 Tue, 24 Oct 2023 08:41:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 5/9] migration: check required subsections are loaded, once
Date: Tue, 24 Oct 2023 12:40:39 +0400
Message-ID: <20231024084043.2926316-6-marcandre.lureau@redhat.com>
In-Reply-To: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
References: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Check that required subsections have been loaded.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 migration/vmstate.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 16e33a5d34..d6fe38a5e1 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -451,22 +451,51 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
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
@@ -492,7 +521,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
             /* it doesn't have a valid subsection name */
             return 0;
         }
-        sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
+        sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr, visited);
         if (sub_vmsd == NULL) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
             return -ENOENT;
@@ -509,6 +538,13 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         }
     }
 
+    for (i = 0; i < n; i++) {
+        if (!visited[i] && vmstate_section_needed(vmsd->subsections[i], opaque)) {
+            trace_vmstate_subsection_load_bad(vmsd->name, vmsd->subsections[i]->name, "(not visited)");
+            return -ENOENT;
+        }
+    }
+
     trace_vmstate_subsection_load_good(vmsd->name);
     return 0;
 }
-- 
2.41.0



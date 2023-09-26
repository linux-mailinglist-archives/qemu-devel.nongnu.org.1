Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B82DD7AF026
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 18:00:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlATZ-0000kl-QE; Tue, 26 Sep 2023 11:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qlATY-0000fd-F2
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:59:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1qlATX-000802-2O
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:59:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695743990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=420sJXRf3fQ/UcPXLnCN0vEy2RSMbyqEMfQ2NFn4vT4=;
 b=avPIylrATErwteJZ6uH1dMezusSVBF06m5KgtOIY5ZgUK2i3RJAeGnr+KubQYQLHeWdbf7
 zN7QXQAQI8Mjv+utlRx7z/HZQyiN9XNLWco99E5a8KN9i8F0/acWnwrdlumC6UeQVvQARj
 ooXEfmBvMx4n8yIzBUTnH3zPK3knw5w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-9Bl_ghs8Ny6c-qIwfOtOYg-1; Tue, 26 Sep 2023 11:59:46 -0400
X-MC-Unique: 9Bl_ghs8Ny6c-qIwfOtOYg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7ED383C23FD0;
 Tue, 26 Sep 2023 15:59:46 +0000 (UTC)
Received: from localhost (unknown [10.39.208.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDC452156702;
 Tue, 26 Sep 2023 15:59:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, qemu-block@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>, Peter Xu <peterx@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 4/5] RFC: migration: check required subsections are loaded,
 once
Date: Tue, 26 Sep 2023 19:59:24 +0400
Message-ID: <20230926155925.1396309-5-marcandre.lureau@redhat.com>
In-Reply-To: <20230926155925.1396309-1-marcandre.lureau@redhat.com>
References: <20230926155925.1396309-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 31842c3afb..5147a8191d 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -426,22 +426,51 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
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
@@ -467,7 +496,7 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
             /* it doesn't have a valid subsection name */
             return 0;
         }
-        sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
+        sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr, visited);
         if (sub_vmsd == NULL) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
             return -ENOENT;
@@ -484,6 +513,13 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         }
     }
 
+    for (i = 0; i < n; i++) {
+        if (!visited[i] && vmstate_save_needed(vmsd->subsections[i], opaque)) {
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



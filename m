Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB3B7F34FF
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 18:35:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5Udt-0003gF-QB; Tue, 21 Nov 2023 12:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5Uds-0003fu-1D
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:34:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1r5Udo-0008Ix-Tt
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 12:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700588066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K7qNnSKJxOZantk4zTpYBHMaq49b+c+NbuYszzcGHU4=;
 b=dNFMm4BPLATDWSvqEPSANULwBFiaCi45RGb7w+sDee1C+qpf12Vy2TSjbCeMgU7gjsUOh4
 yCXNXvTyz7cdUAoFt/7SCj9/DEqckzaopr0BM0BTzJ6EMuGJjdaU5Qzaz6psQkNygo9DNW
 gGIZ5Kh2oP7wJC9GoPbnTBstSRHrpgs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-xIWxVDC1MwK_mUWKLw-x9A-1; Tue,
 21 Nov 2023 12:34:24 -0500
X-MC-Unique: xIWxVDC1MwK_mUWKLw-x9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BFE21C060CE;
 Tue, 21 Nov 2023 17:34:24 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.112])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA84A1C060AE;
 Tue, 21 Nov 2023 17:34:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, thuth@redhat.com, armbru@redhat.com, philmd@linaro.org,
 peter.maydell@linaro.org
Subject: [PATCH for-8.2 1/2] qdev: Fix crash in array property getter
Date: Tue, 21 Nov 2023 18:34:15 +0100
Message-ID: <20231121173416.346610-2-kwolf@redhat.com>
In-Reply-To: <20231121173416.346610-1-kwolf@redhat.com>
References: <20231121173416.346610-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Passing an uninitialised list to visit_start_list() happens to work for
the QObject output visitor because it treats the pointer as an opaque
value and never dereferences it, but the string output visitor expects a
valid list to check if it has more than one element.

The existing code crashes with the string output visitor if the
uninitialised value is non-NULL. Passing an explicit NULL would fix the
crash, but still result in wrong output.

Rework get_prop_array() so that it conforms to the expectations that the
string output visitor has. This includes building a real list first and
using visit_next_list() to iterate it.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1993
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/core/qdev-properties.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 91632f7be9..840006e953 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -689,23 +689,36 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
     Property *prop = opaque;
     uint32_t *alenptr = object_field_prop_ptr(obj, prop);
     void **arrayptr = (void *)obj + prop->arrayoffset;
-    char *elem = *arrayptr;
-    GenericList *list;
-    const size_t list_elem_size = sizeof(*list) + prop->arrayfieldsize;
+    char *elemptr = *arrayptr;
+    ArrayElementList *list = NULL, *elem;
+    ArrayElementList **tail = &list;
+    const size_t size = sizeof(*list);
     int i;
     bool ok;
 
-    if (!visit_start_list(v, name, &list, list_elem_size, errp)) {
+    /* At least the string output visitor needs a real list */
+    for (i = 0; i < *alenptr; i++) {
+        elem = g_new0(ArrayElementList, 1);
+        elem->value = elemptr;
+        elemptr += prop->arrayfieldsize;
+
+        *tail = elem;
+        tail = &elem->next;
+    }
+
+    if (!visit_start_list(v, name, (GenericList **) &list, size, errp)) {
         return;
     }
 
-    for (i = 0; i < *alenptr; i++) {
-        Property elem_prop = array_elem_prop(obj, prop, name, elem);
+    elem = list;
+    while (elem) {
+        Property elem_prop = array_elem_prop(obj, prop, name, elem->value);
         prop->arrayinfo->get(obj, v, NULL, &elem_prop, errp);
         if (*errp) {
             goto out_obj;
         }
-        elem += prop->arrayfieldsize;
+        elem = (ArrayElementList *) visit_next_list(v, (GenericList*) elem,
+                                                    size);
     }
 
     /* visit_check_list() can only fail for input visitors */
@@ -714,6 +727,12 @@ static void get_prop_array(Object *obj, Visitor *v, const char *name,
 
 out_obj:
     visit_end_list(v, (void**) &list);
+
+    while (list) {
+        elem = list;
+        list = elem->next;
+        g_free(elem);
+    }
 }
 
 static void default_prop_array(ObjectProperty *op, const Property *prop)
-- 
2.42.0



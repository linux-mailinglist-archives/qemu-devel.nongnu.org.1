Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFBC76F3AE
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 21:52:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qReMP-0001Yz-Hd; Thu, 03 Aug 2023 15:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qReMO-0001Tu-1z
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 15:51:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qReMM-0004EZ-IO
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 15:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691092305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=MWb5IBCdKVK2wBi7MLFtLkcZsKcC5OjbDXuQtGWncWU=;
 b=gLFyFXnWLIskr+A5MBp/ZU8oVduOrWgOBEfIhxzQaEyLjAs0fmDjR9Be3X68JgGYaSQ3sb
 ZcUdicujyJQuOenJdK4gnzRlKebspqcckRu8alknRi2h3TE5z2PrupAjtW1PTj/vTSJ8Y2
 C9nLLLE4bVs0UftA5w73mxLuzM7KSAQ=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-J6uFnvnCMcut00DV__yW4A-1; Thu, 03 Aug 2023 15:51:43 -0400
X-MC-Unique: J6uFnvnCMcut00DV__yW4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 822B81C0515D;
 Thu,  3 Aug 2023 19:51:43 +0000 (UTC)
Received: from localhost (unknown [10.39.192.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 059A3201F11C;
 Thu,  3 Aug 2023 19:51:42 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] qdev-properties: alias all object class properties
Date: Thu,  3 Aug 2023 15:51:15 -0400
Message-ID: <20230803195115.2367293-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
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

qdev_alias_all_properties() aliases a DeviceState's qdev properties onto
an Object. This is used for VirtioPCIProxy types so that --device
virtio-blk-pci has properties of its embedded --device virtio-blk-device
object.

Currently this function is implemented using qdev properties. Change the
function to use QOM object class properties instead. This works because
qdev properties create QOM object class properties, but it also catches
any QOM object class-only properties that have no qdev properties.

This change ensures that properties of devices are shown with --device
foo,\? even if they are QOM object class properties.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/core/qdev-properties.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 357b8761b5..fbf3969d3c 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -959,16 +959,18 @@ void device_class_set_props(DeviceClass *dc, Property *props)
 void qdev_alias_all_properties(DeviceState *target, Object *source)
 {
     ObjectClass *class;
-    Property *prop;
+    ObjectPropertyIterator iter;
+    ObjectProperty *prop;
 
     class = object_get_class(OBJECT(target));
-    do {
-        DeviceClass *dc = DEVICE_CLASS(class);
 
-        for (prop = dc->props_; prop && prop->name; prop++) {
-            object_property_add_alias(source, prop->name,
-                                      OBJECT(target), prop->name);
+    object_class_property_iter_init(&iter, class);
+    while ((prop = object_property_iter_next(&iter))) {
+        if (object_property_find(source, prop->name)) {
+            continue; /* skip duplicate properties */
         }
-        class = object_class_get_parent(class);
-    } while (class != object_class_by_name(TYPE_DEVICE));
+
+        object_property_add_alias(source, prop->name,
+                                  OBJECT(target), prop->name);
+    }
 }
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F95B81C01C
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 22:28:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGQXm-0003SH-KP; Thu, 21 Dec 2023 16:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQXU-0002CV-DQ
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:25:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rGQXQ-0008Hk-8v
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 16:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703193902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ObH+2iq7N92PStpmtf9CsW10bUTlnhlA02SjRBESHKw=;
 b=e7bKp+2ZXJkgroLw5qLsKoS/zWjt2GVaK0F46FcCEAOyPb9Q1BGzKXd+nklK+xal39YlbL
 j3apXUn0B/X+8rS2QEbW8SkMcTwURo7xoqhxc1+q+S+OYyUOACcCV9ymao/t7E0ozNKZAX
 CsLKCkdIBwmKSCl23Y7co3uWycbJpRo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-WkUM2WnLOiSomlgqU-n_Lw-1; Thu, 21 Dec 2023 16:25:01 -0500
X-MC-Unique: WkUM2WnLOiSomlgqU-n_Lw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 218218B3965;
 Thu, 21 Dec 2023 21:25:01 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.128])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5B69BC15E6A;
 Thu, 21 Dec 2023 21:24:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 31/33] qdev-properties: alias all object class properties
Date: Thu, 21 Dec 2023 22:23:36 +0100
Message-ID: <20231221212339.164439-32-kwolf@redhat.com>
In-Reply-To: <20231221212339.164439-1-kwolf@redhat.com>
References: <20231221212339.164439-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

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
Message-ID: <20231220134755.814917-2-stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/hw/qdev-properties.h |  4 ++--
 hw/core/qdev-properties.c    | 18 ++++++++++--------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
index 25743a29a0..09aa04ca1e 100644
--- a/include/hw/qdev-properties.h
+++ b/include/hw/qdev-properties.h
@@ -230,8 +230,8 @@ void qdev_property_add_static(DeviceState *dev, Property *prop);
  * @target: Device which has properties to be aliased
  * @source: Object to add alias properties to
  *
- * Add alias properties to the @source object for all qdev properties on
- * the @target DeviceState.
+ * Add alias properties to the @source object for all properties on the @target
+ * DeviceState.
  *
  * This is useful when @target is an internal implementation object
  * owned by @source, and you want to expose all the properties of that
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 840006e953..7d6fa726fd 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -1076,16 +1076,18 @@ void device_class_set_props(DeviceClass *dc, Property *props)
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
2.43.0



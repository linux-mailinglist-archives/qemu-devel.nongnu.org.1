Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A26C818B00
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 16:17:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFbpW-0006SQ-FD; Tue, 19 Dec 2023 10:16:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFbpO-0006AX-4P
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 10:16:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rFbpI-0002BE-4y
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 10:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702998958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aJp28RWD0Bmd2/0WGTsegmzATzRz3IZpSu80iClxoG4=;
 b=RHCWrnR9/eIk5kWrUqrr0MJLIyA1umkfNFoHPEm88Yr9BE6S01jOrm9QKlc942Uc2uaiN0
 gfISRvi8lbuAFiamskSzSPoBwL3/B+Lk7HcrYkt4n1Gn/Sdthv/H9XgjGWaKfnLSMgnIzD
 4S7KKc8tsLI4eVzXNTjSdWPUB5THidA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-SVOUB7bUOjSokU8jsMrTow-1; Tue,
 19 Dec 2023 10:15:56 -0500
X-MC-Unique: SVOUB7bUOjSokU8jsMrTow-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9CE6D3813BC3;
 Tue, 19 Dec 2023 15:15:55 +0000 (UTC)
Received: from localhost (unknown [10.39.194.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15A03492BF0;
 Tue, 19 Dec 2023 15:15:54 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michal Privoznik <mprivozn@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v3 1/4] qdev-properties: alias all object class properties
Date: Tue, 19 Dec 2023 10:15:47 -0500
Message-ID: <20231219151550.223303-2-stefanha@redhat.com>
In-Reply-To: <20231219151550.223303-1-stefanha@redhat.com>
References: <20231219151550.223303-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



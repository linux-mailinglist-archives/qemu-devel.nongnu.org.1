Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A07537D123F
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:08:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtr56-0005Wr-6W; Fri, 20 Oct 2023 11:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtr4n-0005QS-O7
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:06:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtr4j-0001If-L3
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697814367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AtyXc2PDXBxm2NIC2xqoUACH89ruTQjSXNR1a0bS5Cc=;
 b=ZB7otEdeVr7Xr4QQrbKxHLAQNgZGIyucPGBcQ9IBFsSsLVN0b/2qHgDNWEI8U38D5/p8LM
 Zra7g2/mQnUJcY/zHmfD9D5HrND+k93F6pdx9//NqXu+E+V3GsBH842OORtaEgjm6eiRWF
 brPI1IRTizRtHaOuYxTWyf8Z6O0hZZA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-lbPY1wHLPTiX2BffiyVRzg-1; Fri, 20 Oct 2023 11:06:03 -0400
X-MC-Unique: lbPY1wHLPTiX2BffiyVRzg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8E2C0185A790;
 Fri, 20 Oct 2023 15:06:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 366982166B2B;
 Fri, 20 Oct 2023 15:06:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 3/3] hw/s390x/s390-stattrib: Don't call
 register_savevm_live() during instance_init()
Date: Fri, 20 Oct 2023 17:05:54 +0200
Message-ID: <20231020150554.664422-4-thuth@redhat.com>
In-Reply-To: <20231020150554.664422-1-thuth@redhat.com>
References: <20231020150554.664422-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

We must not call register_savevm_live() from an instance_init() function
(since this could be called multiple times during device introspection).
Move this to the realize() function instead.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-stattrib.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 52f9fc036e..54a138011c 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -331,6 +331,17 @@ static const TypeInfo qemu_s390_stattrib_info = {
 
 /* Generic abstract object: */
 
+static SaveVMHandlers savevm_s390_stattrib_handlers = {
+    .save_setup = cmma_save_setup,
+    .save_live_iterate = cmma_save_iterate,
+    .save_live_complete_precopy = cmma_save_complete,
+    .state_pending_exact = cmma_state_pending,
+    .state_pending_estimate = cmma_state_pending,
+    .save_cleanup = cmma_save_cleanup,
+    .load_state = cmma_load,
+    .is_active = cmma_active,
+};
+
 static void s390_stattrib_realize(DeviceState *dev, Error **errp)
 {
     bool ambiguous = false;
@@ -338,7 +349,11 @@ static void s390_stattrib_realize(DeviceState *dev, Error **errp)
     object_resolve_path_type("", TYPE_S390_STATTRIB, &ambiguous);
     if (ambiguous) {
         error_setg(errp, "storage_attributes device already exists");
+        return;
     }
+
+    register_savevm_live(TYPE_S390_STATTRIB, 0, 0,
+                         &savevm_s390_stattrib_handlers, dev);
 }
 
 static Property s390_stattrib_props[] = {
@@ -355,24 +370,10 @@ static void s390_stattrib_class_init(ObjectClass *oc, void *data)
     device_class_set_props(dc, s390_stattrib_props);
 }
 
-static SaveVMHandlers savevm_s390_stattrib_handlers = {
-    .save_setup = cmma_save_setup,
-    .save_live_iterate = cmma_save_iterate,
-    .save_live_complete_precopy = cmma_save_complete,
-    .state_pending_exact = cmma_state_pending,
-    .state_pending_estimate = cmma_state_pending,
-    .save_cleanup = cmma_save_cleanup,
-    .load_state = cmma_load,
-    .is_active = cmma_active,
-};
-
 static void s390_stattrib_instance_init(Object *obj)
 {
     S390StAttribState *sas = S390_STATTRIB(obj);
 
-    register_savevm_live(TYPE_S390_STATTRIB, 0, 0,
-                         &savevm_s390_stattrib_handlers, sas);
-
     sas->migration_cur_gfn = 0;
 }
 
-- 
2.41.0



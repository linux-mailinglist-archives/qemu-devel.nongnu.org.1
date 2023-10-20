Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DEF7D102B
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:01:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtp4j-00025k-Ld; Fri, 20 Oct 2023 08:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtp4d-00023J-Ai
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtp4Y-0003Lv-QT
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697806668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VABJ5KTK8UFDUwBj9mLNBPFGTkRXoAJZdRfYgjxMzfM=;
 b=epsq+NR/V47SnCTCr0dpTEWoPxK8pAbtIIu2p6X81psz3DaC2My6dcUwlASAx6on+TeH8y
 idaRF0UzcJL58NgDdOqBIi7YlcFiAD/n2188asAwo39zQ8LdDa8b/CTJ/GEQmIlZf47Nn1
 Ww5oKHwTJFvWlYEGzHQ2wyAMUO5giJk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-K_9RO8Z4M-2FE0hyxwR6Cw-1; Fri, 20 Oct 2023 08:57:37 -0400
X-MC-Unique: K_9RO8Z4M-2FE0hyxwR6Cw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F5DC857D0A;
 Fri, 20 Oct 2023 12:57:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 278DB503B;
 Fri, 20 Oct 2023 12:57:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH 3/3] hw/s390x/s390-stattrib: Don't call register_savevm_live()
 during instance_init()
Date: Fri, 20 Oct 2023 14:57:28 +0200
Message-ID: <20231020125728.579747-4-thuth@redhat.com>
In-Reply-To: <20231020125728.579747-1-thuth@redhat.com>
References: <20231020125728.579747-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

We must not call register_savevm_live() from an instance_init() function
(since this could be called multiple times during device introspection).
Move this to the realize() function instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-stattrib.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 52f9fc036e..3217263418 100644
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
@@ -339,6 +350,9 @@ static void s390_stattrib_realize(DeviceState *dev, Error **errp)
     if (ambiguous) {
         error_setg(errp, "storage_attributes device already exists");
     }
+
+    register_savevm_live(TYPE_S390_STATTRIB, 0, 0,
+                         &savevm_s390_stattrib_handlers, sas);
 }
 
 static Property s390_stattrib_props[] = {
@@ -355,24 +369,10 @@ static void s390_stattrib_class_init(ObjectClass *oc, void *data)
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



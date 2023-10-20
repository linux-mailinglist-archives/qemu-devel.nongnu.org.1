Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 509A27D1018
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 15:00:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtp4i-00024e-2L; Fri, 20 Oct 2023 08:58:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtp4c-00022w-Tf
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtp4W-0003Li-VZ
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697806666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nrV7G3DrFjDs/BJZKCEEHFKRlqvIGvHSzO/+kQmaZlc=;
 b=QA6TNVXoIt6X+8ig1kDPfI9jUsCYC+gCCQKgFLVJLKkvLHMPp1YZTEdcwLEQhtOBaydegQ
 tqpuP8r7jzXgAmonRRy3ir30df1bM7hd842mxjQ1cBCAjekotLMrloAXxWaRXXdVe1LPoW
 Nn24zd/ZK/BSHt/g9FQrJMUpsHxvemo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-isQj0l6_NDuXd7L38c-9ug-1; Fri, 20 Oct 2023 08:57:35 -0400
X-MC-Unique: isQj0l6_NDuXd7L38c-9ug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D713A88B7AC;
 Fri, 20 Oct 2023 12:57:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 655D8503C;
 Fri, 20 Oct 2023 12:57:33 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH 2/3] hw/s390x/s390-stattrib: Simplify handling of the
 "migration-enabled" property
Date: Fri, 20 Oct 2023 14:57:27 +0200
Message-ID: <20231020125728.579747-3-thuth@redhat.com>
In-Reply-To: <20231020125728.579747-1-thuth@redhat.com>
References: <20231020125728.579747-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
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

There's no need for dedicated handlers here if they don't do anything
special.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-stattrib.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 220e845d12..52f9fc036e 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -13,6 +13,7 @@
 #include "qemu/units.h"
 #include "migration/qemu-file.h"
 #include "migration/register.h"
+#include "hw/qdev-properties.h"
 #include "hw/s390x/storage-attributes.h"
 #include "qemu/error-report.h"
 #include "exec/ram_addr.h"
@@ -340,6 +341,10 @@ static void s390_stattrib_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static Property s390_stattrib_props[] = {
+    DEFINE_PROP_BOOL("migration-enabled", S390StAttribState, migration_enabled, true),
+};
+
 static void s390_stattrib_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -347,22 +352,7 @@ static void s390_stattrib_class_init(ObjectClass *oc, void *data)
     dc->hotpluggable = false;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->realize = s390_stattrib_realize;
-}
-
-static inline bool s390_stattrib_get_migration_enabled(Object *obj,
-                                                       Error **errp)
-{
-    S390StAttribState *s = S390_STATTRIB(obj);
-
-    return s->migration_enabled;
-}
-
-static inline void s390_stattrib_set_migration_enabled(Object *obj, bool value,
-                                            Error **errp)
-{
-    S390StAttribState *s = S390_STATTRIB(obj);
-
-    s->migration_enabled = value;
+    device_class_set_props(dc, s390_stattrib_props);
 }
 
 static SaveVMHandlers savevm_s390_stattrib_handlers = {
@@ -383,10 +373,6 @@ static void s390_stattrib_instance_init(Object *obj)
     register_savevm_live(TYPE_S390_STATTRIB, 0, 0,
                          &savevm_s390_stattrib_handlers, sas);
 
-    object_property_add_bool(obj, "migration-enabled",
-                             s390_stattrib_get_migration_enabled,
-                             s390_stattrib_set_migration_enabled);
-    object_property_set_bool(obj, "migration-enabled", true, NULL);
     sas->migration_cur_gfn = 0;
 }
 
-- 
2.41.0



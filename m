Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FFF7D1235
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:07:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtr4z-0005QZ-9w; Fri, 20 Oct 2023 11:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtr4m-0005Pc-8i
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:06:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qtr4g-0001IC-K0
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697814363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NG+yzLcAuX4z6AnLXT7tTZKW/GTwN0xS26UfaJvCq+Q=;
 b=N0dkuUzGND0d5PrK6090jWqZCox0DVYDjOHna4SrZg4goQKN2shBbJk9vFbsshlpqBoQw8
 f002co7iRhzC72Jp6D/9DR7zOj5pSKJrwPONNSIBybbG3NxnGZotwCbNSiP/7ZUUwOZblG
 uK0Wk0aWxz6pBrkQSVimLi22RlDEh94=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-k83WJI3rO9CO1MDuyaPzIw-1; Fri, 20 Oct 2023 11:05:59 -0400
X-MC-Unique: k83WJI3rO9CO1MDuyaPzIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2003E3816B53;
 Fri, 20 Oct 2023 15:05:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 976F22166B26;
 Fri, 20 Oct 2023 15:05:57 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v2 1/3] hw/s390x/s390-skeys: Don't call register_savevm_live()
 during instance_init()
Date: Fri, 20 Oct 2023 17:05:52 +0200
Message-ID: <20231020150554.664422-2-thuth@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since the instance_init() function immediately tries to set the
property to "true", the s390_skeys_set_migration_enabled() tries
to register a savevm handler during instance_init(). However,
instance_init() functions can be called multiple times, e.g. for
introspection of devices. That means multiple instances of devices
can be created during runtime (which is fine as long as they all
don't get realized, too), so the "Prevent double registration of
savevm handler" check in the s390_skeys_set_migration_enabled()
function does not work at all as expected (since there could be
more than one instance).

Thus we must not call register_savevm_live() from an instance_init()
function at all. Move this to the realize() function instead. This
way we can also get rid of the property getter and setter functions
completely, simplifying the code along the way quite a bit.

Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-skeys.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 5024faf411..8e9d9e41e8 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "hw/boards.h"
+#include "hw/qdev-properties.h"
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc-target.h"
@@ -432,58 +433,38 @@ static int s390_storage_keys_load(QEMUFile *f, void *opaque, int version_id)
     return ret;
 }
 
-static inline bool s390_skeys_get_migration_enabled(Object *obj, Error **errp)
-{
-    S390SKeysState *ss = S390_SKEYS(obj);
-
-    return ss->migration_enabled;
-}
-
 static SaveVMHandlers savevm_s390_storage_keys = {
     .save_state = s390_storage_keys_save,
     .load_state = s390_storage_keys_load,
 };
 
-static inline void s390_skeys_set_migration_enabled(Object *obj, bool value,
-                                            Error **errp)
+static void s390_skeys_realize(DeviceState *dev, Error **errp)
 {
-    S390SKeysState *ss = S390_SKEYS(obj);
-
-    /* Prevent double registration of savevm handler */
-    if (ss->migration_enabled == value) {
-        return;
-    }
-
-    ss->migration_enabled = value;
+    S390SKeysState *ss = S390_SKEYS(dev);
 
     if (ss->migration_enabled) {
         register_savevm_live(TYPE_S390_SKEYS, 0, 1,
                              &savevm_s390_storage_keys, ss);
-    } else {
-        unregister_savevm(VMSTATE_IF(ss), TYPE_S390_SKEYS, ss);
     }
 }
 
-static void s390_skeys_instance_init(Object *obj)
-{
-    object_property_add_bool(obj, "migration-enabled",
-                             s390_skeys_get_migration_enabled,
-                             s390_skeys_set_migration_enabled);
-    object_property_set_bool(obj, "migration-enabled", true, NULL);
-}
+static Property s390_skeys_props[] = {
+    DEFINE_PROP_BOOL("migration-enabled", S390SKeysState, migration_enabled, true),
+};
 
 static void s390_skeys_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
 
     dc->hotpluggable = false;
+    dc->realize = s390_skeys_realize;
+    device_class_set_props(dc, s390_skeys_props);
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
 }
 
 static const TypeInfo s390_skeys_info = {
     .name          = TYPE_S390_SKEYS,
     .parent        = TYPE_DEVICE,
-    .instance_init = s390_skeys_instance_init,
     .instance_size = sizeof(S390SKeysState),
     .class_init    = s390_skeys_class_init,
     .class_size    = sizeof(S390SKeysClass),
-- 
2.41.0



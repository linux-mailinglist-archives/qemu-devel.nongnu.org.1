Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 937FB750127
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 10:19:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJV3S-0004Cn-N5; Wed, 12 Jul 2023 04:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJV3P-0004C1-P1
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qJV3O-0000Yy-5w
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 04:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689149908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VrCfSebggGFbD66fy7MfMP1e1eR5p2C++NNqwGAX5mM=;
 b=E9MSU1bW+aspFucmkG/Bqdxq/ZUAyVXbMSg85p9FXdZ5IN3EM6J9omq1Nl0EPfABT+qavh
 WKSmDOBNMNhzfxW67iBUDhjo3m684ymhPKXWg6+14UOolkQu5t0ZFLwq+WMNBEr9+09V3e
 P2kB/v7oziHjGMQhaNZ7VugHwmXAm7Q=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-2A0yn001OYOrHQOZ0q2p_A-1; Wed, 12 Jul 2023 04:18:25 -0400
X-MC-Unique: 2A0yn001OYOrHQOZ0q2p_A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5ABC22808E65;
 Wed, 12 Jul 2023 08:18:23 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E1FD04CD0C9;
 Wed, 12 Jul 2023 08:18:21 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>, Juan Quintela <quintela@redhat.com>
Subject: [GIT PULL 14/21] virtio-mem: Support "x-ignore-shared" migration
Date: Wed, 12 Jul 2023 10:17:43 +0200
Message-ID: <20230712081750.80852-15-david@redhat.com>
In-Reply-To: <20230712081750.80852-1-david@redhat.com>
References: <20230712081750.80852-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
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

To achieve desired "x-ignore-shared" functionality, we should not
discard all RAM when realizing the device and not mess with
preallocation/postcopy when loading device state. In essence, we should
not touch RAM content.

As "x-ignore-shared" gets set after realizing the device, we cannot
rely on that. Let's simply skip discarding of RAM on incoming migration.
Note that virtio_mem_post_load() will call
virtio_mem_restore_unplugged() -- unless "x-ignore-shared" is set. So
once migration finished we'll have a consistent state.

The initial system reset will also not discard any RAM, because
virtio_mem_unplug_all() will not call virtio_mem_unplug_all() when no
memory is plugged (which is the case before loading the device state).

Note that something like VM templating -- see commit b17fbbe55cba
("migration: allow private destination ram with x-ignore-shared") -- is
currently incompatible with virtio-mem and ram_block_discard_range() will
warn in case a private file mapping is supplied by virtio-mem.

For VM templating with virtio-mem, it makes more sense to either
(a) Create the template without the virtio-mem device and hotplug a
    virtio-mem device to the new VM instances using proper own memory
    backend.
(b) Use a virtio-mem device that doesn't provide any memory in the
    template (requested-size=0) and use private anonymous memory.

Message-ID: <20230706075612.67404-5-david@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 47 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index a922c21380..3f41e00e74 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -18,6 +18,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-mem.h"
@@ -901,11 +902,23 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    ret = ram_block_discard_range(rb, 0, qemu_ram_get_used_length(rb));
-    if (ret) {
-        error_setg_errno(errp, -ret, "Unexpected error discarding RAM");
-        ram_block_coordinated_discard_require(false);
-        return;
+    /*
+     * We don't know at this point whether shared RAM is migrated using
+     * QEMU or migrated using the file content. "x-ignore-shared" will be
+     * configured after realizing the device. So in case we have an
+     * incoming migration, simply always skip the discard step.
+     *
+     * Otherwise, make sure that we start with a clean slate: either the
+     * memory backend might get reused or the shared file might still have
+     * memory allocated.
+     */
+    if (!runstate_check(RUN_STATE_INMIGRATE)) {
+        ret = ram_block_discard_range(rb, 0, qemu_ram_get_used_length(rb));
+        if (ret) {
+            error_setg_errno(errp, -ret, "Unexpected error discarding RAM");
+            ram_block_coordinated_discard_require(false);
+            return;
+        }
     }
 
     virtio_mem_resize_usable_region(vmem, vmem->requested_size, true);
@@ -977,10 +990,6 @@ static int virtio_mem_post_load(void *opaque, int version_id)
     RamDiscardListener *rdl;
     int ret;
 
-    if (vmem->prealloc && !vmem->early_migration) {
-        warn_report("Proper preallocation with migration requires a newer QEMU machine");
-    }
-
     /*
      * We started out with all memory discarded and our memory region is mapped
      * into an address space. Replay, now that we updated the bitmap.
@@ -993,6 +1002,18 @@ static int virtio_mem_post_load(void *opaque, int version_id)
         }
     }
 
+    /*
+     * If shared RAM is migrated using the file content and not using QEMU,
+     * don't mess with preallocation and postcopy.
+     */
+    if (migrate_ram_is_ignored(vmem->memdev->mr.ram_block)) {
+        return 0;
+    }
+
+    if (vmem->prealloc && !vmem->early_migration) {
+        warn_report("Proper preallocation with migration requires a newer QEMU machine");
+    }
+
     if (migration_in_incoming_postcopy()) {
         return 0;
     }
@@ -1025,6 +1046,14 @@ static int virtio_mem_post_load_early(void *opaque, int version_id)
         return 0;
     }
 
+    /*
+     * If shared RAM is migrated using the file content and not using QEMU,
+     * don't mess with preallocation and postcopy.
+     */
+    if (migrate_ram_is_ignored(rb)) {
+        return 0;
+    }
+
     /*
      * We restored the bitmap and verified that the basic properties
      * match on source and destination, so we can go ahead and preallocate
-- 
2.41.0



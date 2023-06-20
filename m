Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 694FE736CBA
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 15:05:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBb21-0002i9-9b; Tue, 20 Jun 2023 09:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qBb1w-0002hc-Hb
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qBb1u-0006rw-Ry
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687266258;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rWUIrI8C9YsuJ+7+y+l3JJ4pfQWH+opp1AGMxC8VxUo=;
 b=UNcVS+RBv0FYDFuxhiZLlEFXsq46Ap9GkgAzicCCeQdzu+aTsqEks3m/63gZ/hEqK8ww6K
 ZBz2yN93rydDxvOyECO/smZBxu2LSzAaVHimwM+9FwQX4ETK5GS3lOgux8I5rDJwJl7iyN
 gxosyIs5lVPlmrP/7+Xnsft8y7rozLc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-I5uONs_aNM2hcBFhnlWvag-1; Tue, 20 Jun 2023 09:04:16 -0400
X-MC-Unique: I5uONs_aNM2hcBFhnlWvag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DC8C53810D3B;
 Tue, 20 Jun 2023 13:04:06 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB4CD2166B26;
 Tue, 20 Jun 2023 13:04:04 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>
Subject: [PATCH v1 4/4] virtio-mem: Support "x-ignore-shared" migration
Date: Tue, 20 Jun 2023 15:03:54 +0200
Message-Id: <20230620130354.322180-5-david@redhat.com>
In-Reply-To: <20230620130354.322180-1-david@redhat.com>
References: <20230620130354.322180-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 47 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 9f6169af32..b013dfbaf0 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -18,6 +18,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/reset.h"
+#include "sysemu/runstate.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
@@ -886,11 +887,23 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
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
+     * configurated after realizing the device. So in case we have an
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
@@ -962,10 +975,6 @@ static int virtio_mem_post_load(void *opaque, int version_id)
     RamDiscardListener *rdl;
     int ret;
 
-    if (vmem->prealloc && !vmem->early_migration) {
-        warn_report("Proper preallocation with migration requires a newer QEMU machine");
-    }
-
     /*
      * We started out with all memory discarded and our memory region is mapped
      * into an address space. Replay, now that we updated the bitmap.
@@ -978,6 +987,18 @@ static int virtio_mem_post_load(void *opaque, int version_id)
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
@@ -1010,6 +1031,14 @@ static int virtio_mem_post_load_early(void *opaque, int version_id)
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
2.40.1



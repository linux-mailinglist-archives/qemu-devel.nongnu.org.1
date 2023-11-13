Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECB47E9806
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 09:48:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Sb2-00036S-2T; Mon, 13 Nov 2023 03:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1r2Sap-00035n-6w
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 03:46:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1r2San-0006in-Kj
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 03:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699865208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f3pnhiVn+oXshJaAfi0nBYu1HESNTh+w6UcqfG6KYW8=;
 b=O6oqbEuNHDUHiaYISuXgcQgHrlu0zXtVF1ose9RgXpyeRV4jI5CYcgSQgr5Osu+v0zbvzk
 8dIJUPduJPa3b7ET9+e8OTE12GaZT05PIvh471RLIQjm0iVRuHOZEeHoqJwfj1Xfsab7Ts
 EsURTDoT5QiBgScTXc/fbxpMfinoHzM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-qi_pdC7PMpyi4ojEENHFHw-1; Mon, 13 Nov 2023 03:46:44 -0500
X-MC-Unique: qi_pdC7PMpyi4ojEENHFHw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 714BD185A785;
 Mon, 13 Nov 2023 08:46:44 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.193.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8383D492BFA;
 Mon, 13 Nov 2023 08:46:43 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Mario Casquero <mcasquer@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>
Subject: [GIT PULL 1/1] virtio-mem: fix division by zero in
 virtio_mem_activate_memslots_to_plug()
Date: Mon, 13 Nov 2023 09:46:42 +0100
Message-ID: <20231113084642.150354-2-david@redhat.com>
In-Reply-To: <20231113084642.150354-1-david@redhat.com>
References: <20231113084642.150354-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

When running with "dynamic-memslots=off", we enter
virtio_mem_activate_memslots_to_plug() to return immediately again
because "vmem->dynamic_memslots == false". However, the compiler might
not optimize out calculating start_idx+end_idx, where we divide by
vmem->memslot_size. In such a configuration, the memslot size is 0 and
we'll get a division by zero:

    (qemu) qom-set vmem0 requested-size 3G
    (qemu) q35.sh: line 38: 622940 Floating point exception(core dumped)

The same is true for virtio_mem_deactivate_unplugged_memslots(), however
we never really reach that code without a prior
virtio_mem_activate_memslots_to_plug() call.

Let's fix it by simply calling these functions only with
"dynamic-memslots=on".

This was found when using a debug build of QEMU.

Message-ID: <20231023111341.219317-1-david@redhat.com>
Reprted-by: Mario Casquero <mcasquer@redhat.com>
Fixes: 177f9b1ee464 ("virtio-mem: Expose device memory dynamically via multiple memslots if enabled")
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index a5ea3be414..75ee38aa46 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -525,9 +525,7 @@ static void virtio_mem_activate_memslots_to_plug(VirtIOMEM *vmem,
                                  vmem->memslot_size;
     unsigned int idx;
 
-    if (!vmem->dynamic_memslots) {
-        return;
-    }
+    assert(vmem->dynamic_memslots);
 
     /* Activate all involved memslots in a single transaction. */
     memory_region_transaction_begin();
@@ -547,9 +545,7 @@ static void virtio_mem_deactivate_unplugged_memslots(VirtIOMEM *vmem,
                                  vmem->memslot_size;
     unsigned int idx;
 
-    if (!vmem->dynamic_memslots) {
-        return;
-    }
+    assert(vmem->dynamic_memslots);
 
     /* Deactivate all memslots with unplugged blocks in a single transaction. */
     memory_region_transaction_begin();
@@ -598,7 +594,9 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
         virtio_mem_notify_unplug(vmem, offset, size);
         virtio_mem_set_range_unplugged(vmem, start_gpa, size);
         /* Deactivate completely unplugged memslots after updating the state. */
-        virtio_mem_deactivate_unplugged_memslots(vmem, offset, size);
+        if (vmem->dynamic_memslots) {
+            virtio_mem_deactivate_unplugged_memslots(vmem, offset, size);
+        }
         return 0;
     }
 
@@ -635,9 +633,11 @@ static int virtio_mem_set_block_state(VirtIOMEM *vmem, uint64_t start_gpa,
          * blocks we are plugging here. The following notification will inform
          * registered listeners about the blocks we're plugging.
          */
-        virtio_mem_activate_memslots_to_plug(vmem, offset, size);
+        if (vmem->dynamic_memslots) {
+            virtio_mem_activate_memslots_to_plug(vmem, offset, size);
+        }
         ret = virtio_mem_notify_plug(vmem, offset, size);
-        if (ret) {
+        if (ret && vmem->dynamic_memslots) {
             virtio_mem_deactivate_unplugged_memslots(vmem, offset, size);
         }
     }
@@ -749,7 +749,9 @@ static int virtio_mem_unplug_all(VirtIOMEM *vmem)
         notifier_list_notify(&vmem->size_change_notifiers, &vmem->size);
 
         /* Deactivate all memslots after updating the state. */
-        virtio_mem_deactivate_unplugged_memslots(vmem, 0, region_size);
+        if (vmem->dynamic_memslots) {
+            virtio_mem_deactivate_unplugged_memslots(vmem, 0, region_size);
+        }
     }
 
     trace_virtio_mem_unplugged_all();
-- 
2.41.0



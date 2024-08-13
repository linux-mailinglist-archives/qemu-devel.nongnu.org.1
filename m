Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA60950946
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Aug 2024 17:40:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdtd6-0003A6-TQ; Tue, 13 Aug 2024 11:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sdtd3-0002zC-1G
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:40:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1sdtcn-0007Or-9E
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 11:40:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723563592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BH2nZ069vTgdVPVcpqPPG8whg4igkAfJo9IWQrDvPsY=;
 b=Ojx2GYDtwhBgcXJ4O5JAPO08TnU6QNMMxjvVwX4ngmiZkkCIy9AI08oCJEgDUnjnyVywip
 f/WwMdVxbaGOvcvSNdikIEtxEZ6MIzHacxDThOMAd1N0RfHjjnfIPYvuan2bPW6S8hf2DR
 QAD23NHULqaEUepolozhra6jnxq6S6k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-JLIXNw-HPdeCKVp7UfaIvg-1; Tue,
 13 Aug 2024 11:39:49 -0400
X-MC-Unique: JLIXNw-HPdeCKVp7UfaIvg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84A3C19560B7; Tue, 13 Aug 2024 15:39:48 +0000 (UTC)
Received: from rh-jmarcin.redhat.com (unknown [10.45.226.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E59E300019C; Tue, 13 Aug 2024 15:39:46 +0000 (UTC)
From: Juraj Marcin <jmarcin@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 3/4] virtio-mem: Use new Resettable framework instead of
 LegacyReset
Date: Tue, 13 Aug 2024 17:39:19 +0200
Message-ID: <20240813153922.311788-4-jmarcin@redhat.com>
In-Reply-To: <20240813153922.311788-1-jmarcin@redhat.com>
References: <20240813153922.311788-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

LegacyReset does not pass ResetType to the reset callback method, which
the new Resettable framework uses. Due to this, virtio-mem cannot use
the new RESET_TYPE_WAKEUP to skip the reset during wake-up from a
suspended state.

This patch adds overrides Resettable interface methods in VirtIOMEMClass
to use the new Resettable framework and replaces
qemu_[un]register_reset() calls with qemu_[un]register_resettable().

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem.c         | 38 +++++++++++++++++++++-------------
 include/hw/virtio/virtio-mem.h |  4 ++++
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index ef64bf1b4a..aeee381eb2 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -895,18 +895,6 @@ static int virtio_mem_validate_features(VirtIODevice *vdev)
     return 0;
 }
 
-static void virtio_mem_system_reset(void *opaque)
-{
-    VirtIOMEM *vmem = VIRTIO_MEM(opaque);
-
-    /*
-     * During usual resets, we will unplug all memory and shrink the usable
-     * region size. This is, however, not possible in all scenarios. Then,
-     * the guest has to deal with this manually (VIRTIO_MEM_REQ_UNPLUG_ALL).
-     */
-    virtio_mem_unplug_all(vmem);
-}
-
 static void virtio_mem_prepare_mr(VirtIOMEM *vmem)
 {
     const uint64_t region_size = memory_region_size(&vmem->memdev->mr);
@@ -1123,7 +1111,7 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
         vmstate_register_any(VMSTATE_IF(vmem),
                              &vmstate_virtio_mem_device_early, vmem);
     }
-    qemu_register_reset(virtio_mem_system_reset, vmem);
+    qemu_register_resettable(OBJECT(vmem));
 
     /*
      * Set ourselves as RamDiscardManager before the plug handler maps the
@@ -1143,7 +1131,7 @@ static void virtio_mem_device_unrealize(DeviceState *dev)
      * found via an address space anymore. Unset ourselves.
      */
     memory_region_set_ram_discard_manager(&vmem->memdev->mr, NULL);
-    qemu_unregister_reset(virtio_mem_system_reset, vmem);
+    qemu_unregister_resettable(OBJECT(vmem));
     if (vmem->early_migration) {
         vmstate_unregister(VMSTATE_IF(vmem), &vmstate_virtio_mem_device_early,
                            vmem);
@@ -1843,12 +1831,31 @@ static void virtio_mem_unplug_request_check(VirtIOMEM *vmem, Error **errp)
     }
 }
 
+static ResettableState *virtio_mem_get_reset_state(Object *obj)
+{
+    VirtIOMEM *vmem = VIRTIO_MEM(obj);
+    return &vmem->reset_state;
+}
+
+static void virtio_mem_system_reset_hold(Object *obj, ResetType type)
+{
+    VirtIOMEM *vmem = VIRTIO_MEM(obj);
+
+    /*
+     * During usual resets, we will unplug all memory and shrink the usable
+     * region size. This is, however, not possible in all scenarios. Then,
+     * the guest has to deal with this manually (VIRTIO_MEM_REQ_UNPLUG_ALL).
+     */
+    virtio_mem_unplug_all(vmem);
+}
+
 static void virtio_mem_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     VirtioDeviceClass *vdc = VIRTIO_DEVICE_CLASS(klass);
     VirtIOMEMClass *vmc = VIRTIO_MEM_CLASS(klass);
     RamDiscardManagerClass *rdmc = RAM_DISCARD_MANAGER_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
     device_class_set_props(dc, virtio_mem_properties);
     dc->vmsd = &vmstate_virtio_mem;
@@ -1875,6 +1882,9 @@ static void virtio_mem_class_init(ObjectClass *klass, void *data)
     rdmc->replay_discarded = virtio_mem_rdm_replay_discarded;
     rdmc->register_listener = virtio_mem_rdm_register_listener;
     rdmc->unregister_listener = virtio_mem_rdm_unregister_listener;
+
+    rc->get_state = virtio_mem_get_reset_state;
+    rc->phases.hold = virtio_mem_system_reset_hold;
 }
 
 static const TypeInfo virtio_mem_info = {
diff --git a/include/hw/virtio/virtio-mem.h b/include/hw/virtio/virtio-mem.h
index 5f5b02b8f9..a1af144c28 100644
--- a/include/hw/virtio/virtio-mem.h
+++ b/include/hw/virtio/virtio-mem.h
@@ -14,6 +14,7 @@
 #define HW_VIRTIO_MEM_H
 
 #include "standard-headers/linux/virtio_mem.h"
+#include "hw/resettable.h"
 #include "hw/virtio/virtio.h"
 #include "qapi/qapi-types-misc.h"
 #include "sysemu/hostmem.h"
@@ -115,6 +116,9 @@ struct VirtIOMEM {
 
     /* listeners to notify on plug/unplug activity. */
     QLIST_HEAD(, RamDiscardListener) rdl_list;
+
+    /* State of the resettable container */
+    ResettableState reset_state;
 };
 
 struct VirtIOMEMClass {
-- 
2.46.0



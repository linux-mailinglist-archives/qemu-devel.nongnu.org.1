Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 856F1732B89
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 11:29:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA5kD-000598-Uk; Fri, 16 Jun 2023 05:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qA5kC-00055q-DV
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:27:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qA5kA-0000Lu-TN
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686907666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XM+HePR6LNcuziWHsgGYi0zTa4lGcGp8H1+/yHmULy8=;
 b=MFz9zoLuXjg3tA+xAwtjxtnXIV/NpeKnyy4oU+kXgB70rRyxyHQVjfP6VPRY3a5IJajDmI
 r1y6fg+bEhlJ3zI9PvzI+RavzJ3Yu2N127IWHMHPc6CsQlUauuy6YRehDZ75g+RGmVytfc
 JnpjmQssUUlWabuHLSy+IKzLXBbkDt0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-581-YQHJtK1AMzGU30RbNQ8YJg-1; Fri, 16 Jun 2023 05:27:42 -0400
X-MC-Unique: YQHJtK1AMzGU30RbNQ8YJg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A3A0280AA28;
 Fri, 16 Jun 2023 09:27:42 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.194.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A80111121314;
 Fri, 16 Jun 2023 09:27:39 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Michal Privoznik <mprivozn@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gavin Shan <gshan@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH v1 10/15] pc-dimm: Provide pc_dimm_get_free_slots() to query
 free ram slots
Date: Fri, 16 Jun 2023 11:26:49 +0200
Message-Id: <20230616092654.175518-11-david@redhat.com>
In-Reply-To: <20230616092654.175518-1-david@redhat.com>
References: <20230616092654.175518-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

memory device wants to figure out at per-device memslot limit for memory
devices that want to consume more than a single memslot. We want to try
setting the memslots required for DIMMs/NVDIMMs (1 memslot per such device)
aside, so expose how many of these slots are still free.

Keep it simple and place the stub into qmp_memory_device.c.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/pc-dimm.c          | 27 +++++++++++++++++++++++++++
 include/hw/mem/pc-dimm.h  |  1 +
 stubs/qmp_memory_device.c |  6 ++++++
 3 files changed, 34 insertions(+)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 37f1f4ccfd..64ee0c38c0 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -152,6 +152,33 @@ out:
     return slot;
 }
 
+static int pc_dimm_count_slots(Object *obj, void *opaque)
+{
+    unsigned int *slots = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_PC_DIMM)) {
+        DeviceState *dev = DEVICE(obj);
+        if (dev->realized) { /* count only realized DIMMs */
+            (*slots)++;
+        }
+    }
+    return 0;
+}
+
+unsigned int pc_dimm_get_free_slots(MachineState *machine)
+{
+    const unsigned int max_slots = machine->ram_slots;
+    unsigned int slots = 0;
+
+    if (!max_slots) {
+        return 0;
+    }
+
+    object_child_foreach_recursive(OBJECT(machine), pc_dimm_count_slots,
+                                   &slots);
+    return max_slots - slots;
+}
+
 static Property pc_dimm_properties[] = {
     DEFINE_PROP_UINT64(PC_DIMM_ADDR_PROP, PCDIMMDevice, addr, 0),
     DEFINE_PROP_UINT32(PC_DIMM_NODE_PROP, PCDIMMDevice, node, 0),
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 322bebe555..60051ac753 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -70,4 +70,5 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
                       const uint64_t *legacy_align, Error **errp);
 void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine);
 void pc_dimm_unplug(PCDIMMDevice *dimm, MachineState *machine);
+unsigned int pc_dimm_get_free_slots(MachineState *machine);
 #endif
diff --git a/stubs/qmp_memory_device.c b/stubs/qmp_memory_device.c
index 74707ed9fd..7022bd188b 100644
--- a/stubs/qmp_memory_device.c
+++ b/stubs/qmp_memory_device.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/mem/memory-device.h"
+#include "hw/mem/pc-dimm.h"
 
 MemoryDeviceInfoList *qmp_memory_device_list(void)
 {
@@ -19,3 +20,8 @@ unsigned int memory_devices_get_reserved_memslots(void)
 {
     return 0;
 }
+
+unsigned int pc_dimm_get_free_slots(MachineState *machine)
+{
+    return 0;
+}
-- 
2.40.1



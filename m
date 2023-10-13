Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C167C83C6
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 12:53:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFnJ-0008ME-Rs; Fri, 13 Oct 2023 06:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qrFnG-00089S-Rn; Fri, 13 Oct 2023 06:53:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1qrFnF-0008Hn-3k; Fri, 13 Oct 2023 06:53:22 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S6NZ96l3Hz6J9hJ;
 Fri, 13 Oct 2023 18:50:09 +0800 (CST)
Received: from A190218597.china.huawei.com (10.195.247.32) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 13 Oct 2023 11:53:02 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <oliver.upton@linux.dev>,
 <pbonzini@redhat.com>, <mst@redhat.com>, <will@kernel.org>,
 <gshan@redhat.com>, <rafael@kernel.org>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>,
 <linuxarm@huawei.com>
Subject: [PATCH V6 4/9] hw/acpi: Init GED framework with CPU hotplug events
Date: Fri, 13 Oct 2023 11:51:24 +0100
Message-ID: <20231013105129.25648-5-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20231013105129.25648-1-salil.mehta@huawei.com>
References: <20231013105129.25648-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.195.247.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 lhrpeml500001.china.huawei.com (7.191.163.213)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=salil.mehta@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Salil Mehta <salil.mehta@huawei.com>
From:  Salil Mehta via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

ACPI GED(as described in the ACPI 6.2 spec) can be used to generate ACPI events
when OSPM/guest receives an interrupt listed in the _CRS object of GED. OSPM
then maps or demultiplexes the event by evaluating _EVT method.

This change adds the support of CPU hotplug event initialization in the
existing GED framework.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Xianglai Li <lixianglai@loongson.cn>
---
 hw/acpi/generic_event_device.c         | 8 ++++++++
 include/hw/acpi/generic_event_device.h | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index a3d31631fe..d2fa1d0e4a 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -25,6 +25,7 @@ static const uint32_t ged_supported_events[] = {
     ACPI_GED_MEM_HOTPLUG_EVT,
     ACPI_GED_PWR_DOWN_EVT,
     ACPI_GED_NVDIMM_HOTPLUG_EVT,
+    ACPI_GED_CPU_HOTPLUG_EVT,
 };
 
 /*
@@ -400,6 +401,13 @@ static void acpi_ged_initfn(Object *obj)
     memory_region_init_io(&ged_st->regs, obj, &ged_regs_ops, ged_st,
                           TYPE_ACPI_GED "-regs", ACPI_GED_REG_COUNT);
     sysbus_init_mmio(sbd, &ged_st->regs);
+
+    s->cpuhp.device = OBJECT(s);
+    memory_region_init(&s->container_cpuhp, OBJECT(dev), "cpuhp container",
+                       ACPI_CPU_HOTPLUG_REG_LEN);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->container_cpuhp);
+    cpu_hotplug_hw_init(&s->container_cpuhp, OBJECT(dev),
+                        &s->cpuhp_state, 0);
 }
 
 static void acpi_ged_class_init(ObjectClass *class, void *data)
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index ba84ce0214..a803ea818e 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -60,6 +60,7 @@
 #define HW_ACPI_GENERIC_EVENT_DEVICE_H
 
 #include "hw/sysbus.h"
+#include "hw/acpi/cpu_hotplug.h"
 #include "hw/acpi/memory_hotplug.h"
 #include "hw/acpi/ghes.h"
 #include "qom/object.h"
@@ -95,6 +96,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 #define ACPI_GED_MEM_HOTPLUG_EVT   0x1
 #define ACPI_GED_PWR_DOWN_EVT      0x2
 #define ACPI_GED_NVDIMM_HOTPLUG_EVT 0x4
+#define ACPI_GED_CPU_HOTPLUG_EVT    0x8
 
 typedef struct GEDState {
     MemoryRegion evt;
@@ -106,6 +108,9 @@ struct AcpiGedState {
     SysBusDevice parent_obj;
     MemHotplugState memhp_state;
     MemoryRegion container_memhp;
+    CPUHotplugState cpuhp_state;
+    MemoryRegion container_cpuhp;
+    AcpiCpuHotplug cpuhp;
     GEDState ged_state;
     uint32_t ged_event_bitmap;
     qemu_irq irq;
-- 
2.34.1



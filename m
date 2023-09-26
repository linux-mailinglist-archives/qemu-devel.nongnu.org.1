Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C2F7AEA93
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 12:39:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql5Sy-00062j-NU; Tue, 26 Sep 2023 06:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql5Sf-0005aP-51; Tue, 26 Sep 2023 06:38:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@huawei.com>)
 id 1ql5Sd-0001w7-51; Tue, 26 Sep 2023 06:38:36 -0400
Received: from lhrpeml500001.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rvx0s03xrz6J80t;
 Tue, 26 Sep 2023 18:33:32 +0800 (CST)
Received: from A190218597.china.huawei.com (10.126.174.16) by
 lhrpeml500001.china.huawei.com (7.191.163.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 26 Sep 2023 11:38:12 +0100
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: <salil.mehta@huawei.com>, <maz@kernel.org>, <jean-philippe@linaro.org>,
 <jonathan.cameron@huawei.com>, <lpieralisi@kernel.org>,
 <peter.maydell@linaro.org>, <richard.henderson@linaro.org>,
 <imammedo@redhat.com>, <andrew.jones@linux.dev>, <david@redhat.com>,
 <philmd@linaro.org>, <eric.auger@redhat.com>, <will@kernel.org>,
 <ardb@kernel.org>, <oliver.upton@linux.dev>, <pbonzini@redhat.com>,
 <mst@redhat.com>, <gshan@redhat.com>, <rafael@kernel.org>,
 <borntraeger@linux.ibm.com>, <alex.bennee@linaro.org>,
 <linux@armlinux.org.uk>, <darren@os.amperecomputing.com>,
 <ilkka@os.amperecomputing.com>, <vishnu@os.amperecomputing.com>,
 <karl.heubaum@oracle.com>, <miguel.luis@oracle.com>,
 <salil.mehta@opnsrc.net>, <zhukeqian1@huawei.com>,
 <wangxiongfeng2@huawei.com>, <wangyanan55@huawei.com>,
 <jiakernel2@gmail.com>, <maobibo@loongson.cn>, <lixianglai@loongson.cn>
Subject: [PATCH RFC V2 35/37] hw/arm: Support hotplug capability check using
 _OSC method
Date: Tue, 26 Sep 2023 11:36:52 +0100
Message-ID: <20230926103654.34424-4-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20230926103654.34424-1-salil.mehta@huawei.com>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926103654.34424-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.174.16]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Physical CPU hotplug results in (un)setting of ACPI _STA.Present bit. AARCH64
platforms do not support physical CPU hotplug. Virtual CPU hotplug support being
implemented toggles ACPI _STA.Enabled Bit to achieve hotplug functionality. This
is not same as physical CPU hotplug support.

In future, if ARM architecture supports physical CPU hotplug then the current
design of virtual CPU hotplug can be used unchanged. Hence, there is a need for
firmware/VMM/Qemu to support evaluation of platform wide capabilitiy related to
the *type* of CPU hotplug support present on the platform. OSPM might need this
during boot time to correctly initialize the CPUs and other related components
in the kernel.

NOTE: This implementation will be improved to add the support of *query* in the
subsequent versions. This is very minimal support to assist kernel.

ASL for the implemented _OSC method:

Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
{
    CreateDWordField (Arg3, Zero, CDW1)
    If ((Arg0 == ToUUID ("0811b06e-4a27-44f9-8d60-3cbbc22e7b48") /* Platform-wide Capabilities */))
    {
        CreateDWordField (Arg3, 0x04, CDW2)
        Local0 = CDW2 /* \_SB_._OSC.CDW2 */
        If ((Arg1 != One))
        {
            CDW1 |= 0x08
        }

        Local0 &= 0x00800000
        If ((CDW2 != Local0))
        {
            CDW1 |= 0x10
        }

        CDW2 = Local0
    }
    Else
    {
        CDW1 |= 0x04
    }

    Return (Arg3)
}

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/arm/virt-acpi-build.c | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index cbccd2ca2d..377450dd16 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -861,6 +861,55 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
     build_fadt(table_data, linker, &fadt, vms->oem_id, vms->oem_table_id);
 }
 
+static void build_virt_osc_method(Aml *scope, VirtMachineState *vms)
+{
+    Aml *if_uuid, *else_uuid, *if_rev, *if_caps_masked, *method;
+    Aml *a_cdw1 = aml_name("CDW1");
+    Aml *a_cdw2 = aml_local(0);
+
+    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
+    aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
+
+    /* match UUID */
+    if_uuid = aml_if(aml_equal(
+        aml_arg(0), aml_touuid("0811B06E-4A27-44F9-8D60-3CBBC22E7B48")));
+
+    aml_append(if_uuid, aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
+    aml_append(if_uuid, aml_store(aml_name("CDW2"), a_cdw2));
+
+    /* check unknown revision in arg(1) */
+    if_rev = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
+    /* set revision error bits,  DWORD1 Bit[3] */
+    aml_append(if_rev, aml_or(a_cdw1, aml_int(0x08), a_cdw1));
+    aml_append(if_uuid, if_rev);
+
+    /*
+     * check support for vCPU hotplug type(=enabled) platform-wide capability
+     * in DWORD2 as sepcified in the below ACPI Specification ECR,
+     *  # https://bugzilla.tianocore.org/show_bug.cgi?id=4481
+     */
+    if (vms->acpi_dev) {
+        aml_append(if_uuid, aml_and(a_cdw2, aml_int(0x800000), a_cdw2));
+        /* check if OSPM specified hotplug capability bits were masked */
+        if_caps_masked = aml_if(aml_lnot(aml_equal(aml_name("CDW2"), a_cdw2)));
+        aml_append(if_caps_masked, aml_or(a_cdw1, aml_int(0x10), a_cdw1));
+        aml_append(if_uuid, if_caps_masked);
+    }
+    aml_append(if_uuid, aml_store(a_cdw2, aml_name("CDW2")));
+
+    aml_append(method, if_uuid);
+    else_uuid = aml_else();
+
+    /* set unrecognized UUID error bits, DWORD1 Bit[2] */
+    aml_append(else_uuid, aml_or(a_cdw1, aml_int(4), a_cdw1));
+    aml_append(method, else_uuid);
+
+    aml_append(method, aml_return(aml_arg(3)));
+    aml_append(scope, method);
+
+    return;
+}
+
 /* DSDT */
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
@@ -894,6 +943,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     } else {
         acpi_dsdt_add_cpus(scope, vms);
     }
+
+    build_virt_osc_method(scope, vms);
+
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
                        (irqmap[VIRT_UART] + ARM_SPI_BASE));
     if (vmc->acpi_expose_flash) {
-- 
2.34.1



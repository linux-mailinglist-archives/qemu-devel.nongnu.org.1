Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5BFAF6DA4
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Jul 2025 10:50:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFeA-0001Tf-IG; Thu, 03 Jul 2025 04:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uXFdB-0000Bb-Qv; Thu, 03 Jul 2025 04:49:22 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1uXFd9-0004PP-KM; Thu, 03 Jul 2025 04:49:21 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bXr5n6GQsz6L5Dn;
 Thu,  3 Jul 2025 16:48:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 6094B1402F0;
 Thu,  3 Jul 2025 16:49:14 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.203.177.241) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 3 Jul 2025 10:49:05 +0200
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <imammedo@redhat.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <smostafa@google.com>, <gustavo.romero@linaro.org>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <linuxarm@huawei.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: [PATCH v6 11/12] qtest/bios-tables-test: Add tests for legacy smmuv3
 and smmuv3 device
Date: Thu, 3 Jul 2025 09:46:42 +0100
Message-ID: <20250703084643.85740-12-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
References: <20250703084643.85740-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.203.177.241]
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

For the legacy SMMUv3 test, the setup includes three PCIe Root Complexes,
one of which has bypass_iommu enabled. The generated IORT table contains
a single SMMUv3 node, a Root Complex(RC) node and 1 ITS node.
RC node features 4 ID mappings, of which 2 points to SMMU node and the
remaining ones points to ITS.

       pcie.0 -> {SMMU0} -> {ITS}
{RC}   pcie.1 -> {SMMU0} -> {ITS}
       pcie.2            -> {ITS}
       [all other ids]   -> {ITS}

For the -device arm-smmuv3,... test, the configuration also includes three
Root Complexes, with two connected to separate SMMUv3 devices.
The resulting IORT table contains 1 RC node, 2 SMMU nodes and 1 ITS node.
RC node features 4 ID mappings. 2 of them target the 2 SMMU nodes while
the others targets the ITS.

        pcie.0 -> {SMMU0} -> {ITS}
{RC}    pcie.1 -> {SMMU1} -> {ITS}
        pcie.2            -> {ITS}
        [all other ids]   -> {ITS}

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 tests/qtest/bios-tables-test.c | 86 ++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 4dbc07ec5e..79f8ca6559 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2250,6 +2250,86 @@ static void test_acpi_aarch64_virt_viot(void)
     free_test_data(&data);
 }
 
+static void test_acpi_aarch64_virt_smmuv3_legacy(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * MiB,
+    };
+
+    /*
+     * cdrom is plugged into scsi controller to avoid conflict
+     * with pxb-pcie. See comments in test_acpi_aarch64_virt_tcg_pxb() for
+     * details.
+     *
+     * The setup includes three PCIe root complexes, one of which has
+     * bypass_iommu enabled. The generated IORT table contains a single
+     * SMMUv3 node and a Root Complex node with three ID mappings. Two
+     * of the ID mappings have output references pointing to the SMMUv3
+     * node and the remaining one points to ITS.
+     */
+    data.variant = ".smmuv3-legacy";
+    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
+                  " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
+                  " -drive file="
+                  "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
+                  "if=none,media=cdrom,id=drive-scsi0-0-0-1,readonly=on"
+                  " -device scsi-cd,bus=scsi0.0,scsi-id=0,"
+                  "drive=drive-scsi0-0-0-1,id=scsi0-0-0-1,bootindex=1"
+                  " -cpu cortex-a57"
+                  " -M iommu=smmuv3"
+                  " -device pxb-pcie,id=pcie.1,bus=pcie.0,bus_nr=0x10"
+                  " -device pxb-pcie,id=pcie.2,bus=pcie.0,bus_nr=0x20,bypass_iommu=on",
+                  &data);
+    free_test_data(&data);
+}
+
+static void test_acpi_aarch64_virt_smmuv3_dev(void)
+{
+    test_data data = {
+        .machine = "virt",
+        .arch = "aarch64",
+        .tcg_only = true,
+        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
+        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
+        .ram_start = 0x40000000ULL,
+        .scan_len = 128ULL * MiB,
+    };
+
+    /*
+     * cdrom is plugged into scsi controller to avoid conflict
+     * with pxb-pcie. See comments in test_acpi_aarch64_virt_tcg_pxb()
+     * for details.
+     *
+     * The setup includes three PCie root complexes, two of which are
+     * connected to separate SMMUv3 devices. The resulting IORT table
+     * contains two SMMUv3 nodes and a Root Complex node with ID mappings
+     * of which two of the ID mappings have output references pointing
+     * to two different SMMUv3 nodes and the remaining ones pointing to
+     * ITS.
+     */
+    data.variant = ".smmuv3-dev";
+    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
+                  " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
+                  " -drive file="
+                  "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
+                  "if=none,media=cdrom,id=drive-scsi0-0-0-1,readonly=on"
+                  " -device scsi-cd,bus=scsi0.0,scsi-id=0,"
+                  "drive=drive-scsi0-0-0-1,id=scsi0-0-0-1,bootindex=1"
+                  " -cpu cortex-a57"
+                  " -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0"
+                  " -device pxb-pcie,id=pcie.1,bus=pcie.0,bus_nr=0x10"
+                  " -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1"
+                  " -device pxb-pcie,id=pcie.2,bus=pcie.0,bus_nr=0x20",
+                  &data);
+    free_test_data(&data);
+}
+
 #ifndef _WIN32
 # define DEV_NULL "/dev/null"
 #else
@@ -2607,6 +2687,12 @@ int main(int argc, char *argv[])
             if (qtest_has_device("virtio-iommu-pci")) {
                 qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_viot);
             }
+            qtest_add_func("acpi/virt/smmuv3-legacy",
+                           test_acpi_aarch64_virt_smmuv3_legacy);
+            if (qtest_has_device("arm-smmuv3")) {
+                qtest_add_func("acpi/virt/smmuv3-dev",
+                               test_acpi_aarch64_virt_smmuv3_dev);
+            }
         }
     } else if (strcmp(arch, "riscv64") == 0) {
         if (has_tcg && qtest_has_device("virtio-blk-pci")) {
-- 
2.34.1



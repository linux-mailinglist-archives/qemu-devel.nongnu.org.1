Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D16A756A18
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 19:23:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLRw4-0006Qb-D2; Mon, 17 Jul 2023 13:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qLRvz-0006QE-OO
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 13:22:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qLRvx-0005Mq-Sx
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 13:22:55 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TN84xhVz67T1b;
 Tue, 18 Jul 2023 01:19:36 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:22:51 +0100
To: <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
 <qemu-devel@nongnu.org>
CC: <linuxarm@huawei.com>, Alison Schofield <alison.schofield@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr
 Bueso <dave@stgolabs.net>, Viacheslav Dubeyko <slava@dubeyko.com>, Shesha
 Bhushan Sreenivasamurthy <sheshas@marvell.com>, Fan Ni <fan.ni@samsung.com>,
 Michael Tsirkin <mst@redhat.com>, Jonathan Zhang <jonzhang@meta.com>, Klaus
 Jensen <k.jensen@samsung.com>
Subject: [RFC PATCH 12/17] HACK: hw/arm/virt: Add ACPI support for aspeed-i2c
 / mctp
Date: Mon, 17 Jul 2023 18:16:41 +0100
Message-ID: <20230717171646.8972-13-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Enable this for FM-API testing for CXL devices via MCTP over I2C

Example DSDT block:

Device (MCTP)
{
    Name (_HID, "PRP0001")  // _HID: Hardware ID
    Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
    {
        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
        Package (0x03)
        {
            Package (0x02)
            {
                "compatible",
                "aspeed,ast2600-i2c-bus"
            },
            Package (0x02)
            {
                "bus-frequency",
                0x00061A80
            },
            Package (0x02)
            {
                "mctp-controller",
                One
            }
        }
    })
    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
    {
        Memory32Fixed (ReadWrite,
            0x0B000080,         // Address Base
            0x00000080,         // Address Length
            )
        Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
        {
            0x0000002A,
        }
    })
}
Device (MCTS)
{
    Name (_HID, "PRP0001")  // _HID: Hardware ID
    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
    {
        I2cSerialBusV2 (0x0050, DeviceInitiated, 0x000186A0,
           AddressingMode7Bit, "\\_SB.MCTP",
           0x00, ResourceProducer, , Exclusive,
            )
    })
    Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
    {
        ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
        Package (0x01)
        {
            Package (0x02)
            {
                "compatible",
                "mctp-i2c-controller"
            }
        }
    })
}

Tests not updated given I'm not currently proposing this for upstream.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/arm/virt-acpi-build.c | 60 ++++++++++++++++++++++++++++++++++++++++
 hw/i2c/meson.build       |  2 +-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e4a74324b8..ad31e2055e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -78,6 +78,65 @@ static void acpi_dsdt_add_cpus(Aml *scope, VirtMachineState *vms)
     }
 }
 
+static void acpi_dsdt_add_mctp(Aml *scope, VirtMachineState *vms)
+{
+    uint32_t interrupt = vms->irqmap[VIRT_I2C] + ARM_SPI_BASE;
+    Aml *main_dev = aml_device("MCTP");
+    Aml *sub_dev = aml_device("MCTS");
+    Aml *dsd_pkg = aml_package(2);
+    Aml *props_pkg = aml_package(3);
+    Aml *pkg = aml_package(2);
+    Aml *crs = aml_resource_template();
+
+    aml_append(main_dev, aml_name_decl("_HID", aml_string("PRP0001")));
+
+    aml_append(pkg, aml_string("compatible"));
+    aml_append(pkg, aml_string("aspeed,ast2600-i2c-bus"));
+    aml_append(props_pkg, pkg);
+
+    pkg = aml_package(2);
+    aml_append(pkg, aml_string("bus-frequency"));
+    aml_append(pkg, aml_int(400000));
+    aml_append(props_pkg, pkg);
+
+    pkg = aml_package(2);
+    aml_append(pkg, aml_string("mctp-controller"));
+    aml_append(pkg, aml_int(1));
+    aml_append(props_pkg, pkg);
+
+    aml_append(dsd_pkg, aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301"));
+    aml_append(dsd_pkg, props_pkg);
+    aml_append(main_dev, aml_name_decl("_DSD", dsd_pkg));
+
+    aml_append(crs, aml_memory32_fixed(vms->memmap[VIRT_I2C].base + 0x80,
+                                      0x80, AML_READ_WRITE));
+    aml_append(crs,
+               aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+                             AML_EXCLUSIVE, &interrupt, 1));
+    aml_append(main_dev, aml_name_decl("_CRS", crs));
+
+    aml_append(sub_dev, aml_name_decl("_HID", aml_string("PRP0001")));
+
+    dsd_pkg = aml_package(2);
+    aml_append(dsd_pkg, aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301"));
+
+    props_pkg = aml_package(1);
+
+    pkg = aml_package(2);
+    aml_append(pkg, aml_string("compatible"));
+    aml_append(pkg, aml_string("mctp-i2c-controller"));
+    aml_append(props_pkg, pkg);
+    aml_append(dsd_pkg, props_pkg);
+
+    crs = aml_resource_template();
+    aml_append(crs, aml_i2c_slv_serial_bus_device(0x50, "\\_SB.MCTP"));
+    aml_append(sub_dev, aml_name_decl("_CRS", crs));
+    aml_append(sub_dev, aml_name_decl("_DSD", dsd_pkg));
+
+    aml_append(scope, main_dev);
+    aml_append(scope, sub_dev);
+}
+
 static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
                                            uint32_t uart_irq)
 {
@@ -888,6 +947,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
      */
     scope = aml_scope("\\_SB");
     acpi_dsdt_add_cpus(scope, vms);
+    acpi_dsdt_add_mctp(scope, vms);
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
                        (irqmap[VIRT_UART] + ARM_SPI_BASE));
     if (vmc->acpi_expose_flash) {
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index d707ec58f7..75db13c10e 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -4,7 +4,7 @@ i2c_ss.add(when: 'CONFIG_MCTP_I2C', if_true: files('mctp.c'))
 i2c_ss.add(when: 'CONFIG_SMBUS', if_true: files('smbus_slave.c', 'smbus_master.c'))
 i2c_ss.add(when: 'CONFIG_ACPI_SMBUS', if_true: files('pm_smbus.c'))
 i2c_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('smbus_ich9.c'))
-i2c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i2c.c'))
+i2c_ss.add(when: 'CONFIG_I2C', if_true: files('aspeed_i2c.c'))
 i2c_ss.add(when: 'CONFIG_BITBANG_I2C', if_true: files('bitbang_i2c.c'))
 i2c_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_i2c.c'))
 i2c_ss.add(when: 'CONFIG_IMX_I2C', if_true: files('imx_i2c.c'))
-- 
2.39.2



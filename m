Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A2EAFD92D
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Jul 2025 23:07:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFK9-0002kD-2L; Tue, 08 Jul 2025 16:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZEHC-0005YX-NS
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:46:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZEH9-00078c-5D
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752003999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LaHhRWCkXgGNJ+cRyviv9tQN1UpLUsvaFiwWXTMdnDI=;
 b=Dwhh+xgqm/qNoXv96EEWhNAasw/dFVseqg1TW/Nb3+/oTTarqHqpKwkYIJu/JvHSQZnSwR
 sINkVlxBi/iA//fR/QgpbJE+eogH5We/nZgTME83b5O+CzAwArA1kAZmjkoOSxw60bmj1O
 sDVPU3JKtcA+63PO7mT5YBra++swHTI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-1V_4l14OPH-Xog7OzxVZRw-1; Tue,
 08 Jul 2025 10:25:49 -0400
X-MC-Unique: 1V_4l14OPH-Xog7OzxVZRw-1
X-Mimecast-MFC-AGG-ID: 1V_4l14OPH-Xog7OzxVZRw_1751984747
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4762D1954198; Tue,  8 Jul 2025 14:25:47 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.187])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF52830001B1; Tue,  8 Jul 2025 14:25:41 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, imammedo@redhat.com,
 Jonathan.Cameron@huawei.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com,
	philmd@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH v6 09/36] hw/pci-host/gpex-acpi: Use
 build_pci_host_bridge_osc_method
Date: Tue,  8 Jul 2025 16:22:51 +0200
Message-ID: <20250708142437.1344644-10-eric.auger@redhat.com>
In-Reply-To: <20250708142437.1344644-1-eric.auger@redhat.com>
References: <20250708142437.1344644-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

gpex build_host_bridge_osc() and x86 originated
build_pci_host_bridge_osc_method() are mostly identical.

In GPEX, SUPP is set to CDW2 but is not further used. CTRL
is same as Local0.

So let gpex code reuse build_pci_host_bridge_osc_method()
and remove build_host_bridge_osc().

Also add an imply ACPI_PCI clause along with
PCI_EXPRESS_GENERIC_BRIDGE to compile hw/acpi/pci.c
when its dependency is resolved (ie. CONFIG_ACPI_PCI).
This is requested to link qemu-system-mips64el.

The disassembled DSDT difference is given below:

  * Original Table Header:
  *     Signature        "DSDT"
- *     Length           0x00001A4F (6735)
+ *     Length           0x00001A35 (6709)
  *     Revision         0x02
- *     Checksum         0xBF
+ *     Checksum         0xDD
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "BXPC    "
  *     OEM Revision     0x00000001 (1)
@@ -1849,27 +1849,26 @@ DefinitionBlock ("", "DSDT", 2, "BOCHS ", "BXPC    ", 0x00000001)
                 {
                     CreateDWordField (Arg3, 0x04, CDW2)
                     CreateDWordField (Arg3, 0x08, CDW3)
-                    SUPP = CDW2 /* \_SB_.PCI0._OSC.CDW2 */
-                    CTRL = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
-                    CTRL &= 0x1F
+                    Local0 = CDW3 /* \_SB_.PCI0._OSC.CDW3 */
+                    Local0 &= 0x1F
                     If ((Arg1 != One))
                     {
                         CDW1 |= 0x08
                     }

-                    If ((CDW3 != CTRL))
+                    If ((CDW3 != Local0))
                     {
                         CDW1 |= 0x10
                     }

-                    CDW3 = CTRL /* \_SB_.PCI0.CTRL */
-                    Return (Arg3)
+                    CDW3 = Local0
                 }
                 Else
                 {
                     CDW1 |= 0x04
-                    Return (Arg3)
                 }
+
+                Return (Arg3)
             }

             Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

---

v3 -> v4:
- Fix link issue:
/usr/bin/ld: libsystem.a.p/hw_pci-host_gpex-acpi.c.o: in function `acpi_dsdt_add_host_bridge_methods':
./hw/pci-host/gpex-acpi.c:83: undefined reference to `build_pci_host_bridge_osc_method'

v1 -> v2:
- move in the dsdt.dsl diff in the commit message and remove useless
  info (Gustavo, Michael)
---
 hw/pci-host/gpex-acpi.c | 62 ++++-------------------------------------
 hw/pci-host/Kconfig     |  1 +
 2 files changed, 6 insertions(+), 57 deletions(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index 44737a8d81..952a0ace19 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -1,5 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/aml-build.h"
+#include "hw/acpi/pci.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/arm/virt.h"
 #include "hw/pci/pci_bus.h"
@@ -50,61 +51,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
     }
 }
 
-static Aml *build_host_bridge_osc(bool enable_native_pcie_hotplug)
-{
-    Aml *method, *UUID, *ifctx, *ifctx1, *elsectx;
-    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
-    aml_append(method, aml_name_decl("SUPP", aml_int(0)));
-    aml_append(method, aml_name_decl("CTRL", aml_int(0)));
-    aml_append(method,
-        aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
-
-    /* PCI Firmware Specification 3.0
-     * 4.5.1. _OSC Interface for PCI Host Bridge Devices
-     * The _OSC interface for a PCI/PCI-X/PCI Express hierarchy is
-     * identified by the Universal Unique IDentifier (UUID)
-     * 33DB4D5B-1FF7-401C-9657-7441C03DD766
-     */
-    UUID = aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766");
-    ifctx = aml_if(aml_equal(aml_arg(0), UUID));
-    aml_append(ifctx,
-        aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
-    aml_append(ifctx,
-        aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
-    aml_append(ifctx, aml_store(aml_name("CDW2"), aml_name("SUPP")));
-    aml_append(ifctx, aml_store(aml_name("CDW3"), aml_name("CTRL")));
-
-    /*
-     * Allow OS control for SHPCHotplug, PME, AER, PCIeCapability,
-     * and PCIeHotplug depending on enable_native_pcie_hotplug
-     */
-    aml_append(ifctx, aml_and(aml_name("CTRL"),
-               aml_int(0x1E | (enable_native_pcie_hotplug ? 0x1 : 0x0)),
-               aml_name("CTRL")));
-
-    ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
-    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
-                              aml_name("CDW1")));
-    aml_append(ifctx, ifctx1);
-
-    ifctx1 = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), aml_name("CTRL"))));
-    aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x10),
-                              aml_name("CDW1")));
-    aml_append(ifctx, ifctx1);
-
-    aml_append(ifctx, aml_store(aml_name("CTRL"), aml_name("CDW3")));
-    aml_append(ifctx, aml_return(aml_arg(3)));
-    aml_append(method, ifctx);
-
-    elsectx = aml_else();
-    aml_append(elsectx, aml_or(aml_name("CDW1"), aml_int(4),
-                               aml_name("CDW1")));
-    aml_append(elsectx, aml_return(aml_arg(3)));
-    aml_append(method, elsectx);
-    return method;
-}
-
-static Aml *build_host_bridge_dsm(void)
+static Aml *build_pci_host_bridge_dsm_method(void)
 {
     Aml *method = aml_method("_DSM", 4, AML_NOTSERIALIZED);
     Aml *UUID, *ifctx, *ifctx1, *buf;
@@ -133,8 +80,9 @@ static void acpi_dsdt_add_host_bridge_methods(Aml *dev,
                                               bool enable_native_pcie_hotplug)
 {
     /* Declare an _OSC (OS Control Handoff) method */
-    aml_append(dev, build_host_bridge_osc(enable_native_pcie_hotplug));
-    aml_append(dev, build_host_bridge_dsm());
+    aml_append(dev,
+               build_pci_host_bridge_osc_method(enable_native_pcie_hotplug));
+    aml_append(dev, build_pci_host_bridge_dsm_method());
 }
 
 void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 35c0415242..9824fa188d 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -54,6 +54,7 @@ config PCI_EXPRESS_Q35
 config PCI_EXPRESS_GENERIC_BRIDGE
     bool
     select PCI_EXPRESS
+    imply ACPI_PCI
 
 config PCI_EXPRESS_XILINX
     bool
-- 
2.49.0



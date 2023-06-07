Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C45D27262AD
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:21:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6u0x-0002uE-7I; Wed, 07 Jun 2023 10:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0v-0002tw-Ce
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:53 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=51561cf95=anthony.perard@citrix.com>)
 id 1q6u0t-0003TL-Mi
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1686147591;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wWUJ7WtaHa9rB7fKP/foYa0k256I9Y1yoW9klntUSLk=;
 b=e06bdVeDDWVRrdZQpdcOS2OQhUsZYUuceSsVRPEGVYQk6v7gShbp0HlT
 1K3khXWRhrshrhQD/La79sLyP0RjMcHkqgam5by6dsJpk8xzDiNyTcoeo
 GXnlU74H4IF3VzPOB4pZAno35RPmRuggzZlo7Qk/EBqs+jNIpDawHhuPb M=;
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none
X-SBRS: 4.0
X-MesageID: 110672765
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.123
X-Policy: $RELAYED
IronPort-Data: A9a23:c1iBcajPy6pABe7Ma6aq0Xi2X161ZhAKZh0ujC45NGQN5FlHY01je
 htvDTqDPq2JYWf8Ko9zbdy28kIO68DRztBmG1Y/+yo2QX4b9cadCdqndUqhZCn6wu8v7q5Ex
 55HNoSfdpBcolv0/ErF3m3J9CEkvU2wbuOgTrWCYmYpHlUMpB4J0XpLg/Q+jpNjne+3CgaMv
 cKai8DEMRqu1iUc3lg8sspvkzsx+qyq0N8klgZmP6sT4geBzyN94K83fsldEVOpGuG4IcbiL
 wrz5OnR1n/U+R4rFuSknt7TGqHdauePVeQmoiM+t5mK2nCulARrukoIHKN0hXNsoyeIh7hMJ
 OBl7vRcf+uL0prkw4zxWzEAe8130DYvFLXveRBTuuTLp6HKnueFL1yDwyjaMKVBktubD12i+
 tRfFWAhbzKdnNiq7722cPB2pMEqAJPkadZ3VnFIlVk1DN4jSJHHBa7L+cVZzHE7gcUm8fT2P
 pRDL2A1NVKZPkMJYw1MYH49tL7Aan3XejtEqFWTtOwv7nLa1gBZ27nxKtvFPNeNQK25m27B/
 zqYoD6mXExy2Nq34BrG40+nlr/2hxzFX5xRJYea7L1DuQjGroAUIEJPDgbqyRWjsWanVtdCb
 kAZ5Ccqha418kOtU5/6RRLQiGWEsxgAVst4HOgz6QXLwa3Rizt1HUBdEGQHMoZ/8pZrG3pzj
 AThc87V6SJH94DFZXO/6KyusRy9NBIMN00HbANeQl5QizX8m70bghXKR9dlNae6iNzpBD39q
 wy3QDgCa6Y71pBSifjilbzTq3f1/8WSEFZpjunCdjj9hj6VcrJJcGBBBbLzyf9bZLiUQVCa1
 JTvs5jPtbteZX1hecHkfQnsIF1Lz6zdWNE/qQQ1d3XEy9hK0yDLQGyoyGsiTHqFy+5dEdMTX
 GfduBlK+LhYN2awYKl8buqZUpp6k/C/S465DaGIN7Kih6SdkifdpEmCgmbKhgjQfLUEy/lja
 f93j+7yZZrlNUiX5GXvHLpMuVPa7is/2XnSVfjGI+ePiNKjiIquYe5dajOmN7lphJ5oVS2Jq
 76zwePWkUQAOAA/CwGLmbMuwacicyBmVM6s9pYOHgNBSyI/cFwc5zbq6etJU+RYc259z48kI
 lnVtpdk9WfC
IronPort-HdrOrdr: A9a23:kSKmDqsIHHAAvWEAKTjetPXj7skCiIAji2hC6mlwRA09TyXGra
 6TdaUguiMc1gx8ZJh5o6H8BEGBKUmskKKdkrNhQYtKPTOW9VdASbsJ0WKM+UyYJ8STzJ8/6U
 4kSdkFNDSSNyk3sS+Z2njBLz9I+rDum83I5ds2jU0dNj2CAJsQizuRfzzrdHGeMzM2YqbReq
 DshPZvln6FQzA6f867Dn4KU6zqoMDKrovvZVorFgMq8w6HiBKv8frfHwKD1hkTfjtTyfN6mF
 K13TDR1+GGibWW2xXc32jc49B/n8bg8MJKAIihm9UYMTLljyevfcBEV6eZtD44jemz4BIBkc
 XKoT0nI8NvgkmhMV2dkF/I4U3NwTwu43jtxRuzmn34u/H0Qzo8Fo5omZ9ZWgGx0TthgPhMlI
 Zwm06JvZteCh3N2A7n4cLTah1snk2o5VI/jO8oiWBFW4d2Us4TkWVfxjIWLH4zJlO/1GkVKp
 goMCga3ocRTbquVQGdgoCo+q30Yp18JGbffqFIgL3r79EfpgEG86Jf/r1fol4wsKsnTZ9K/u
 LFNbktuo1vY6YtHPhALdZEeNCwDGPVRxLKLSa1GnTIUI86G1+lke+t3F0SjNvaJKDgCKFCxa
 jpQRdWs3U/dFnpDtDL1JpX8grVSGH4Rjj1zNpCjqIJ8oHUVf7oKiWNVVEjk8yy5/MCH8bcR/
 G/UagmdsMLglGea7qh8jeOLaW6E0NuGfE9q5I+QRaDs8jLIorluqjSd+vSPqPkFXIhVnnkCn
 UOUTDvLIEYh3rbEEPQkVzUQTfga0b/9ZV/HOzT+PUS0pEEMslJvhIOgVq068mXIXlJs7Awfk
 F5PLT7+5nL7lWe7CLN9SFkKxBdBkFa7PHpVG5LvxYDNwfufbMKq7ykCBdvNbu8V2tCpu/tYX
 1iTg5MiNOKxrSrtFAfN+4=
X-Talos-CUID: 9a23:pCU5YGOD4si+wO5DHxQ32E82BNsfblLSwU3JOW29AEozR+jA
X-Talos-MUID: 9a23:Dk7y7wYnOYMkP+BTnh+vlQxpJJdR+ZuQD15OoK8koYqtDHkl
X-IronPort-AV: E=Sophos;i="6.00,224,1681185600"; d="scan'208";a="110672765"
To: <qemu-devel@nongnu.org>
CC: Bernhard Beschow <shentey@gmail.com>, Anthony PERARD
 <anthony.perard@citrix.com>
Subject: [PULL 11/12] hw/isa/piix3: Resolve redundant TYPE_PIIX3_XEN_DEVICE
Date: Wed, 7 Jun 2023 15:18:38 +0100
Message-ID: <20230607141839.48422-12-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230607141839.48422-1-anthony.perard@citrix.com>
References: <20230607141839.48422-1-anthony.perard@citrix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=216.71.155.168;
 envelope-from=prvs=51561cf95=anthony.perard@citrix.com;
 helo=esa5.hc3370-68.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-to:  Anthony PERARD <anthony.perard@citrix.com>
From:  Anthony PERARD via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: Bernhard Beschow <shentey@gmail.com>

During the last patches, TYPE_PIIX3_XEN_DEVICE turned into a clone of
TYPE_PIIX3_DEVICE. Remove this redundancy.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
Tested-by: Chuck Zmudzinski <brchuckz@aol.com>
Message-Id: <20230312120221.99183-7-shentey@gmail.com>
Message-Id: <20230403074124.3925-8-shentey@gmail.com>
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 hw/i386/pc_piix.c             |  5 ++---
 hw/isa/piix3.c                | 15 ---------------
 include/hw/southbridge/piix.h |  1 -
 3 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2ed2b3f3c6..42af03dbb4 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -239,8 +239,6 @@ static void pc_init1(MachineState *machine,
     if (pcmc->pci_enabled) {
         PIIX3State *piix3;
         PCIDevice *pci_dev;
-        const char *type = xen_enabled() ? TYPE_PIIX3_XEN_DEVICE
-                                         : TYPE_PIIX3_DEVICE;
 
         pci_bus = i440fx_init(pci_type,
                               i440fx_host,
@@ -253,7 +251,8 @@ static void pc_init1(MachineState *machine,
                                        : pc_pci_slot_get_pirq);
         pcms->bus = pci_bus;
 
-        pci_dev = pci_create_simple_multifunction(pci_bus, -1, true, type);
+        pci_dev = pci_create_simple_multifunction(pci_bus, -1, true,
+                                                  TYPE_PIIX3_DEVICE);
 
         if (xen_enabled()) {
             pci_device_set_intx_routing_notifier(
diff --git a/hw/isa/piix3.c b/hw/isa/piix3.c
index 0549e043ca..117024e450 100644
--- a/hw/isa/piix3.c
+++ b/hw/isa/piix3.c
@@ -30,7 +30,6 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/isa/isa.h"
-#include "hw/xen/xen.h"
 #include "sysemu/runstate.h"
 #include "migration/vmstate.h"
 #include "hw/acpi/acpi_aml_interface.h"
@@ -381,24 +380,10 @@ static const TypeInfo piix3_info = {
     .class_init    = piix3_class_init,
 };
 
-static void piix3_xen_class_init(ObjectClass *klass, void *data)
-{
-    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-
-    k->realize = piix3_realize;
-}
-
-static const TypeInfo piix3_xen_info = {
-    .name          = TYPE_PIIX3_XEN_DEVICE,
-    .parent        = TYPE_PIIX3_PCI_DEVICE,
-    .class_init    = piix3_xen_class_init,
-};
-
 static void piix3_register_types(void)
 {
     type_register_static(&piix3_pci_type_info);
     type_register_static(&piix3_info);
-    type_register_static(&piix3_xen_info);
 }
 
 type_init(piix3_register_types)
diff --git a/include/hw/southbridge/piix.h b/include/hw/southbridge/piix.h
index a840340308..278171752f 100644
--- a/include/hw/southbridge/piix.h
+++ b/include/hw/southbridge/piix.h
@@ -67,7 +67,6 @@ DECLARE_INSTANCE_CHECKER(PIIX3State, PIIX3_PCI_DEVICE,
                          TYPE_PIIX3_PCI_DEVICE)
 
 #define TYPE_PIIX3_DEVICE "PIIX3"
-#define TYPE_PIIX3_XEN_DEVICE "PIIX3-xen"
 #define TYPE_PIIX4_PCI_DEVICE "piix4-isa"
 
 #endif
-- 
Anthony PERARD



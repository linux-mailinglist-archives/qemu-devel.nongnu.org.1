Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6A8BCC95E
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Oct 2025 12:43:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7AaE-0001JQ-M8; Fri, 10 Oct 2025 06:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v7AaB-0001GX-Qs; Fri, 10 Oct 2025 06:42:43 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v7Aa7-0007am-Sk; Fri, 10 Oct 2025 06:42:42 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 59AAaVSb065199
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 10 Oct 2025 19:36:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=77yV9fYbXC5pzBNX3eGAOmBVD/+cfEjFUpOr2dKNlEY=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1760092606; v=1;
 b=Mjx8pti/hT9j4javu08WKSV4r+2Ad3+i/NXM3NiDY9OW7WJSEDvk0Y9BGfjKw3T4
 eyiPU0uw5JwqiEoz53f/WI4MWjtQUe3617i2U0aAGbhw4633ePzHG6mVRYvIaYM5
 am450eyHk1D8f9AzWN/RVWAPg6GDKlUVLLFBX4pCnmkad2tAFaWbGRkyz/QXIDRY
 jXE71a9F0HaFYMrFHUQ52mi4aEqiZxq/N11b/1Dhh05Q/WNvwFag0NncaKMP67F3
 bgk+3rpom3A15EwpR0yVpnmzgGRYtfPbALmN7rBVlD/L9fuiIO8DIwVB64U+BQY7
 YfZRaniyCZoLSRyFRy8oOA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 10 Oct 2025 19:35:37 +0900
Subject: [PATCH v2 09/12] pci: Do not delete the subregions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-subregion-v2-9-435a472bc9cd@rsg.ci.i.u-tokyo.ac.jp>
References: <20251010-subregion-v2-0-435a472bc9cd@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20251010-subregion-v2-0-435a472bc9cd@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?utf-8?q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

It is no longer necessary.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/pci/pci.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index acc03fd4707c..63e4e49b7e1b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1190,10 +1190,6 @@ static void do_pci_unregister_device(PCIDevice *pci_dev)
     if (xen_mode == XEN_EMULATE) {
         xen_evtchn_remove_pci_device(pci_dev);
     }
-    if (memory_region_is_mapped(&pci_dev->bus_master_enable_region)) {
-        memory_region_del_subregion(&pci_dev->bus_master_container_region,
-                                    &pci_dev->bus_master_enable_region);
-    }
     address_space_destroy(&pci_dev->bus_master_as);
 }
 
@@ -1419,27 +1415,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
     return pci_dev;
 }
 
-static void pci_unregister_io_regions(PCIDevice *pci_dev)
-{
-    PCIIORegion *r;
-    int i;
-
-    for(i = 0; i < PCI_NUM_REGIONS; i++) {
-        r = &pci_dev->io_regions[i];
-        if (!r->size || r->addr == PCI_BAR_UNMAPPED)
-            continue;
-        memory_region_del_subregion(r->address_space, r->memory);
-    }
-
-    pci_unregister_vga(pci_dev);
-}
-
 static void pci_qdev_unrealize(DeviceState *dev)
 {
     PCIDevice *pci_dev = PCI_DEVICE(dev);
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
 
-    pci_unregister_io_regions(pci_dev);
     pci_del_option_rom(pci_dev);
     pcie_sriov_unregister_device(pci_dev);
 

-- 
2.51.0



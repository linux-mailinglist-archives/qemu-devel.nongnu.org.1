Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B4DB3D9AC
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Sep 2025 08:15:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usxmT-0001gP-BL; Mon, 01 Sep 2025 02:12:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1usxmQ-0001dm-V3; Mon, 01 Sep 2025 02:12:38 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1usxmO-0002oG-Rv; Mon, 01 Sep 2025 02:12:38 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5816ACAf076640
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 1 Sep 2025 15:10:28 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=a9y4Uz2vRhIfhworOPPwHJGJ+Fl7vXHFoarWH13fJvM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1756707029; v=1;
 b=n3WBRCVPtkQGMlsdzqb5PJ7kTAIaadyC6RQEetatvpyFPkBNiO2aj3ougFWQyrlb
 4hPz0yxNfS19H4CCyYccfIoNEXaBmGcb5G6d2p4aTkvRWZbT3rnFQPyH6OW02Nj9
 LZBLzZitg+LEFozQsL3U6rY8Y7CD1fXZlkN/OhDjkCdRPgm6JJ0bK+P+ppsZw2rO
 GPgYfm8PPJmtUK/Y3Kwjgp+/PPiGJd+CvCDEFKc7xBXai9vdzDRjrEnJiUnf4WBE
 pcc1r2XDIByHKWAjtnWcjq59SFSirpE6JR0D7GL+tfoCVWOt39CMamH1by34fZ+p
 yebK5Z3YN1uGAhg57H6LIQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 01 Sep 2025 15:10:09 +0900
Subject: [PATCH 11/16] pci: Do not delete the subregions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-mr-v1-11-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
References: <20250901-mr-v1-0-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250901-mr-v1-0-dd7cb6b1480b@rsg.ci.i.u-tokyo.ac.jp>
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
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
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
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.14.2
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
index c70b5ceebaf1f2b10768bd030526cbb518da2b8d..1dd577ca20ab204b5f38469c801e421398660718 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1188,10 +1188,6 @@ static void do_pci_unregister_device(PCIDevice *pci_dev)
     if (xen_mode == XEN_EMULATE) {
         xen_evtchn_remove_pci_device(pci_dev);
     }
-    if (memory_region_is_mapped(&pci_dev->bus_master_enable_region)) {
-        memory_region_del_subregion(&pci_dev->bus_master_container_region,
-                                    &pci_dev->bus_master_enable_region);
-    }
     address_space_destroy(&pci_dev->bus_master_as);
 }
 
@@ -1417,27 +1413,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
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



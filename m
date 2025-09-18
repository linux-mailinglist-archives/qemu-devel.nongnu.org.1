Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EC2B46871
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Sep 2025 04:29:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuiZn-0006iX-Vq; Fri, 05 Sep 2025 22:22:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuiZj-0006gq-2m; Fri, 05 Sep 2025 22:22:47 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uuiZN-0000Og-OJ; Fri, 05 Sep 2025 22:22:42 -0400
Received: from [10.40.4.92] (93-51-222-138.ip268.fastwebnet.it [93.51.222.138])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5862Btnp041566
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 6 Sep 2025 11:16:14 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Qvj4+hZAXQ+HATM7aKOWvKVpmlqyAC4ni6CowomDhZk=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1757124986; v=1;
 b=u3oUoc5FS+ykl5ye/y72MYN+xpl/H+FpkE3N5flf8YijwL1Eup8sUzv1QZCfoJEv
 EB+w4DI5hDa+8I8MI0lZVrOR/d+YAI8PRSO+ZYaAo7rKkO+uBHpV1YJDlry9YqVN
 HFY+x3nd5sc/p766vyCs5/2RyeGxqLlPE7oLpNYamCSy1k+zf2fgIll7Aa8uSbV0
 4JhvXCSM/+g1xaAL3qAqD6hfSvSHuhH7dhK22rde8YLVQUE0wwVwtYwnNGhRt7Gf
 188wmUrhH5Jc1CSaM2L5V1DPhaGF3H4Sqm4d5HXGOjI6qzD49esGZhVttY0w7kA1
 xmF/5WIUCHT/RRe2iHLMrA==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 06 Sep 2025 04:11:29 +0200
Subject: [PATCH 20/22] hw/ppc/spapr_pci: Do not delete the subregions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-use-v1-20-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
References: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
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
X-Mailer: b4 0.14.2
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
 hw/ppc/spapr_pci.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 1ac1185825e84ca908fd878f6cbe7e8cacac1d89..b4043ee752c5f9ab2c0f5800dffa809d3c182225 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1735,27 +1735,13 @@ static void spapr_phb_unrealize(DeviceState *dev)
     SysBusDevice *s = SYS_BUS_DEVICE(dev);
     PCIHostState *phb = PCI_HOST_BRIDGE(s);
     SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(phb);
-    SpaprTceTable *tcet;
     int i;
-    const unsigned windows_supported = spapr_phb_windows_supported(sphb);
 
     if (sphb->msi) {
         g_hash_table_unref(sphb->msi);
         sphb->msi = NULL;
     }
 
-    /*
-     * Remove IO/MMIO subregions and aliases, rest should get cleaned
-     * via PHB's unrealize->object_finalize
-     */
-    for (i = windows_supported - 1; i >= 0; i--) {
-        tcet = spapr_tce_find_by_liobn(sphb->dma_liobn[i]);
-        if (tcet) {
-            memory_region_del_subregion(&sphb->iommu_root,
-                                        spapr_tce_get_iommu(tcet));
-        }
-    }
-
     remove_drcs(sphb, phb->bus);
 
     for (i = PCI_NUM_PINS - 1; i >= 0; i--) {
@@ -1767,8 +1753,6 @@ static void spapr_phb_unrealize(DeviceState *dev)
 
     QLIST_REMOVE(sphb, list);
 
-    memory_region_del_subregion(&sphb->iommu_root, &sphb->msiwindow);
-
     /*
      * An attached PCI device may have memory listeners, eg. VFIO PCI. We have
      * unmapped all sections. Remove the listeners now, before destroying the
@@ -1779,12 +1763,6 @@ static void spapr_phb_unrealize(DeviceState *dev)
 
     qbus_set_hotplug_handler(BUS(phb->bus), NULL);
     pci_unregister_root_bus(phb->bus);
-
-    memory_region_del_subregion(get_system_memory(), &sphb->iowindow);
-    if (sphb->mem64_win_pciaddr != (hwaddr)-1) {
-        memory_region_del_subregion(get_system_memory(), &sphb->mem64window);
-    }
-    memory_region_del_subregion(get_system_memory(), &sphb->mem32window);
 }
 
 static void spapr_phb_destroy_msi(gpointer opaque)

-- 
2.51.0



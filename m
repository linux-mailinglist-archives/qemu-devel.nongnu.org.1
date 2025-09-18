Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EBCB80C62
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Sep 2025 17:54:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyrsk-0002R5-DM; Wed, 17 Sep 2025 09:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uyrpp-0005yl-SU; Wed, 17 Sep 2025 09:04:36 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uyrpn-0005yS-VF; Wed, 17 Sep 2025 09:04:33 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58HCuN6v008967
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 17 Sep 2025 21:56:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=yCjTOSOzxNJD5tmMZUwxklHNpokb7XYrU7eEhj5X1Iw=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1758113805; v=1;
 b=goSPsWuW9Jj92+Df4/yOaL+2mBbccLanyC5vTRtnIUxTOrzpx7c2JKj3BDVgBxnW
 xMUACCiXN6RtiFkxp3kel2Dw9mb+UOs8qbI9DIx0f7bN49eXmTkZHHILSUJ5UpeL
 fislhEzAdtQ9BljxNbp181vYL7ouDdHy+KNin8gOvSch1nlREyHc/eanNkaPD1i4
 tKNaBHfLTG0MINVZLpOw7EJDitJt4dJorhJ+WLMiDLYjAkp/NprL7sl+Hu9SC+s9
 RdxSj4+ywrD25EoQDA+iSura1pyexWC31pVOzrr/lrJgTB/FzXEpMaOaGV9SE59+
 lT98kkQS3fqxLFGj4/NHOQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 17 Sep 2025 21:56:29 +0900
Subject: [PATCH 17/35] hw/pci: QOM-ify AddressSpace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-qom-v1-17-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
References: <20250917-qom-v1-0-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250917-qom-v1-0-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Eric Auger <eric.auger@redhat.com>,
 Helge Deller <deller@gmx.de>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Ninad Palsule <ninad@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Laurent Vivier <laurent@vivier.eu>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>, BALATON Zoltan <balaton@eik.bme.hu>,
 Bernhard Beschow <shentey@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Bin Meng <bmeng.cn@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Peter Xu <peterx@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-block@nongnu.org, kvm@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
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

Make AddressSpaces QOM objects to ensure that they are destroyed when
their owners are finalized and also to get a unique path for debugging
output.

The name arguments were used to distinguish AddresSpaces in debugging
output, but they will represent property names after QOM-ification and
debugging output will show QOM paths. So change them to make them more
concise and also avoid conflicts with other properties.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/pci/pci.c        |  6 +++---
 hw/pci/pci_bridge.c | 11 +++++------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 340384a8876a..7ab93df2969d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1188,7 +1188,7 @@ static void do_pci_unregister_device(PCIDevice *pci_dev)
     if (xen_mode == XEN_EMULATE) {
         xen_evtchn_remove_pci_device(pci_dev);
     }
-    address_space_destroy(&pci_dev->bus_master_as);
+    object_unparent(OBJECT(&pci_dev->bus_master_as));
 }
 
 /* Extract PCIReqIDCache into BDF format */
@@ -1359,8 +1359,8 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
 
     memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
                        "bus master container", UINT64_MAX);
-    address_space_init(&pci_dev->bus_master_as, NULL,
-                       &pci_dev->bus_master_container_region, pci_dev->name);
+    address_space_init(&pci_dev->bus_master_as, OBJECT(pci_dev),
+                       &pci_dev->bus_master_container_region, "bus-master-as");
     pci_dev->bus_master_as.max_bounce_buffer_size =
         pci_dev->max_bounce_buffer_size;
 
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 94b61b907ea2..fd74622edb9f 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -388,13 +388,12 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
     sec_bus->map_irq = br->map_irq ? br->map_irq : pci_swizzle_map_irq_fn;
     sec_bus->address_space_mem = &br->address_space_mem;
     memory_region_init(&br->address_space_mem, OBJECT(br), "pci_bridge_pci", UINT64_MAX);
-    address_space_init(&br->as_mem, NULL, &br->address_space_mem,
-                       "pci_bridge_pci_mem");
+    address_space_init(&br->as_mem, OBJECT(br), &br->address_space_mem,
+                       "mem-as");
     sec_bus->address_space_io = &br->address_space_io;
     memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io",
                        4 * GiB);
-    address_space_init(&br->as_io, NULL, &br->address_space_io,
-                       "pci_bridge_pci_io");
+    address_space_init(&br->as_io, OBJECT(br), &br->address_space_io, "io-as");
     pci_bridge_region_update(br, true);
     QLIST_INIT(&sec_bus->child);
     QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
@@ -411,8 +410,8 @@ void pci_bridge_exitfn(PCIDevice *pci_dev)
     PCIBridge *s = PCI_BRIDGE(pci_dev);
     assert(QLIST_EMPTY(&s->sec_bus.child));
     QLIST_REMOVE(&s->sec_bus, sibling);
-    address_space_destroy(&s->as_mem);
-    address_space_destroy(&s->as_io);
+    object_unparent(OBJECT(&s->as_mem));
+    object_unparent(OBJECT(&s->as_io));
     pci_bridge_region_del(s, &s->windows);
     pci_bridge_region_cleanup(s, &s->windows);
     /* object_unparent() is called automatically during device deletion */

-- 
2.51.0



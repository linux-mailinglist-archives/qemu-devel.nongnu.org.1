Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 579D6B8092C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Sep 2025 17:31:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyrsH-0000Up-V7; Wed, 17 Sep 2025 09:07:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uyroe-0004z0-Iu; Wed, 17 Sep 2025 09:03:23 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1uyroa-0005tJ-GY; Wed, 17 Sep 2025 09:03:20 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58HCuN6j008967
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 17 Sep 2025 21:56:35 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=SN54eqMpyxZn5t52ldVheDzKEoBDUBkvg/chu4l0yTs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1758113796; v=1;
 b=DUSefoHX+5AQ41jKoyMQZ/520KnWRg3PTuzflX+/GPXZq3riyQSurxvuJq6Y+xeA
 sc0QE5yEaHKX31nXhL9x1HMWA8aCw1Kd//xPmJ1dS9TuYPRYEBUV3wIEZhunNBJy
 KSkDKTovU4HxAGab/4PCRKGMY+wWz4sLV/SxfhbPFp4A9F+HbrufBwEu6zktI+9n
 37l8Va3KoDIqMDlZsWOzKy4/48ABx7OARe8Nt0FjkxJ7uloAMGpNVwmyed0owEJw
 5AyPLLiP+X0+9IMBiwGrNzhPbldNRxURcOfovreIznCLAPrtI/DRx+W457D9g07k
 PFKYTh6R/xZXDBSuQAmfDQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 17 Sep 2025 21:56:17 +0900
Subject: [PATCH 05/35] hw/arm: QOM-ify AddressSpace
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-qom-v1-5-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
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
 hw/arm/armv7m.c         | 2 +-
 hw/arm/aspeed_ast27x0.c | 2 +-
 hw/arm/smmu-common.c    | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 7fa854bc14df..54d0d9f78207 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -117,7 +117,7 @@ static void bitband_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    address_space_init(&s->source_as, NULL, s->source_memory, "bitband-source");
+    address_space_init(&s->source_as, OBJECT(s), s->source_memory, "as");
 }
 
 /* Board init.  */
diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index f8c0ac5f87df..7fe097ad3f11 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -387,7 +387,7 @@ static bool aspeed_soc_ast2700_dram_init(DeviceState *dev, Error **errp)
     memory_region_init(&s->dram_container, OBJECT(s), "ram-container",
                        ram_size);
     memory_region_add_subregion(&s->dram_container, 0, s->dram_mr);
-    address_space_init(&s->dram_as, NULL, s->dram_mr, "dram");
+    address_space_init(&s->dram_as, OBJECT(s), s->dram_mr, "dram-as");
 
     /*
      * Add a memory region beyond the RAM region to emulate
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 081c50750947..7c1648165b9f 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -863,6 +863,7 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
     sdev = sbus->pbdev[devfn];
     if (!sdev) {
         char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn, index++);
+        g_autofree char *as_name = g_strconcat(name, "-as", NULL);
 
         sdev = sbus->pbdev[devfn] = g_new0(SMMUDevice, 1);
 
@@ -873,8 +874,8 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
         memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
                                  s->mrtypename,
                                  OBJECT(s), name, UINT64_MAX);
-        address_space_init(&sdev->as, NULL,
-                           MEMORY_REGION(&sdev->iommu), name);
+        address_space_init(&sdev->as, OBJECT(s),
+                           MEMORY_REGION(&sdev->iommu), as_name);
         trace_smmu_add_mr(name);
         g_free(name);
     }

-- 
2.51.0



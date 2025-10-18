Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF387BED0E3
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Oct 2025 16:06:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA7Yi-0008Vp-I7; Sat, 18 Oct 2025 10:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vA7YL-0008Iy-BN; Sat, 18 Oct 2025 10:05:01 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vA7YI-0006yO-7P; Sat, 18 Oct 2025 10:04:59 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B96B45972F6;
 Sat, 18 Oct 2025 16:04:56 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id kZkbmt1hqwqh; Sat, 18 Oct 2025 16:04:54 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BD0B05972F8; Sat, 18 Oct 2025 16:04:54 +0200 (CEST)
Message-ID: <b856f7dd678ddabdb80e2a5d3848f214164bf4e9.1760795082.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1760795082.git.balaton@eik.bme.hu>
References: <cover.1760795082.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 10/16] hw/pci-host/raven: Fix PCI config direct access
 region
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Date: Sat, 18 Oct 2025 16:04:54 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

The PCI configuration direct access region occupies 8 MiB at offset
0x800000 in PCI IO space so model that accordingly.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/raven.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/pci-host/raven.c b/hw/pci-host/raven.c
index 23020fd09f..bb0be40eb4 100644
--- a/hw/pci-host/raven.c
+++ b/hw/pci-host/raven.c
@@ -235,8 +235,8 @@ static void raven_pcihost_realizefn(DeviceState *d, Error **errp)
 
     mr = g_new0(MemoryRegion, 1);
     memory_region_init_io(mr, OBJECT(h), &raven_mmcfg_ops, h->bus,
-                          "pci-mmcfg", 0x00400000);
-    memory_region_add_subregion(address_space_mem, 0x80800000, mr);
+                          "pci-mmcfg", 8 * MiB);
+    memory_region_add_subregion(&s->pci_io, 0x800000, mr);
 
     memory_region_init_io(&s->pci_intack, OBJECT(s), &raven_intack_ops, s,
                           "pci-intack", 1);
-- 
2.41.3



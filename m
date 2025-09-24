Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94023B983B6
	for <lists+qemu-devel@lfdr.de>; Wed, 24 Sep 2025 06:46:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1HMm-0002Z8-CK; Wed, 24 Sep 2025 00:44:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v1HMi-0002XU-OR; Wed, 24 Sep 2025 00:44:28 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1v1HMc-00070F-1P; Wed, 24 Sep 2025 00:44:28 -0400
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58O4bSn0091795
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 13:37:42 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ZLD6q50HK2lQwLzxRbQaSBBUwzyTsangDxSOgNJJx8I=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1758688662; v=1;
 b=HoN1iIkjYTsHEWCTgud6NoTyf1nD5F3t22JXFPqbYILfMLp+Xrv09z7OyGyuwUSk
 YYTcgI7g/+wZoGi91mRCqJFylcf+umFGGjaeZoaPi4MZwGG/W+j/T5X7jHjQYz6W
 ZcIRQ+yOnar0zOtxrCDqHIvyOsXVRnI8GS8sclqgSjFxHKXsPZOliFvo2dR2qGyo
 wwkcnvo1PhlyJ9qEjPaI+Ifqu5GIL1FKT++9yCSM6DDEEwNPND0Loz+98LE4Ta2b
 7OfpePR7t1PFBMnbhLklDPAfrosOVAlQHA/niUjo66Ttb31aBuFGkLYkcPcWkWNW
 jurSTzbiNvWzl9uoid98OQ==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 24 Sep 2025 13:37:25 +0900
Subject: [PATCH v4 6/7] vfio: Do not unparent in instance_finalize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250924-use-v4-6-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp>
References: <20250924-use-v4-0-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20250924-use-v4-0-07c6c598f53d@rsg.ci.i.u-tokyo.ac.jp>
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
 Alistair Francis <alistair@alistair23.me>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Bin Meng <bmeng.cn@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org,
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

Children are automatically unparented so manually unparenting is
unnecessary.

Worse, automatic unparenting happens before the instance_finalize()
callback of the parent gets called, so object_unparent() calls in
the callback will refer to objects that are already unparented, which
is semantically incorrect.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/vfio/pci-quirks.c | 9 +--------
 hw/vfio/region.c     | 3 ---
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index c97606dbf194..b5da6afbf5b0 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1159,15 +1159,12 @@ void vfio_vga_quirk_exit(VFIOPCIDevice *vdev)
 
 void vfio_vga_quirk_finalize(VFIOPCIDevice *vdev)
 {
-    int i, j;
+    int i;
 
     for (i = 0; i < ARRAY_SIZE(vdev->vga->region); i++) {
         while (!QLIST_EMPTY(&vdev->vga->region[i].quirks)) {
             VFIOQuirk *quirk = QLIST_FIRST(&vdev->vga->region[i].quirks);
             QLIST_REMOVE(quirk, next);
-            for (j = 0; j < quirk->nr_mem; j++) {
-                object_unparent(OBJECT(&quirk->mem[j]));
-            }
             g_free(quirk->mem);
             g_free(quirk->data);
             g_free(quirk);
@@ -1207,14 +1204,10 @@ void vfio_bar_quirk_exit(VFIOPCIDevice *vdev, int nr)
 void vfio_bar_quirk_finalize(VFIOPCIDevice *vdev, int nr)
 {
     VFIOBAR *bar = &vdev->bars[nr];
-    int i;
 
     while (!QLIST_EMPTY(&bar->quirks)) {
         VFIOQuirk *quirk = QLIST_FIRST(&bar->quirks);
         QLIST_REMOVE(quirk, next);
-        for (i = 0; i < quirk->nr_mem; i++) {
-            object_unparent(OBJECT(&quirk->mem[i]));
-        }
         g_free(quirk->mem);
         g_free(quirk->data);
         g_free(quirk);
diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index d04c57db630f..b165ab0b9378 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -365,12 +365,9 @@ void vfio_region_finalize(VFIORegion *region)
     for (i = 0; i < region->nr_mmaps; i++) {
         if (region->mmaps[i].mmap) {
             munmap(region->mmaps[i].mmap, region->mmaps[i].size);
-            object_unparent(OBJECT(&region->mmaps[i].mem));
         }
     }
 
-    object_unparent(OBJECT(region->mem));
-
     g_free(region->mem);
     g_free(region->mmaps);
 

-- 
2.51.0



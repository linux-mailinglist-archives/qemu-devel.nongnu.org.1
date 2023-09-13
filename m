Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4CA79E904
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 15:19:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgPlD-0007LL-IY; Wed, 13 Sep 2023 09:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPlA-0007KV-TH; Wed, 13 Sep 2023 09:18:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgPl8-0002zP-8n; Wed, 13 Sep 2023 09:18:24 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4397821762;
 Wed, 13 Sep 2023 16:18:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 3EF9F27C85;
 Wed, 13 Sep 2023 16:18:02 +0300 (MSK)
Received: (nullmailer pid 4073289 invoked by uid 1000);
 Wed, 13 Sep 2023 13:18:00 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.0.5 08/66] bcm2835_property: disable reentrancy detection
 for iomem
Date: Wed, 13 Sep 2023 16:17:32 +0300
Message-Id: <20230913131757.4073200-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
References: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Alexander Bulekov <alxndr@bu.edu>

As the code is designed for re-entrant calls from bcm2835_property to
bcm2835_mbox and back into bcm2835_property, mark iomem as
reentrancy-safe.

Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20230427211013.2994127-7-alxndr@bu.edu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
(cherry picked from commit 985c4a4e547afb9573b6bd6843d20eb2c3d1d1cd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 890ae7bae5..de056ea2df 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -382,6 +382,13 @@ static void bcm2835_property_init(Object *obj)
 
     memory_region_init_io(&s->iomem, OBJECT(s), &bcm2835_property_ops, s,
                           TYPE_BCM2835_PROPERTY, 0x10);
+
+    /*
+     * bcm2835_property_ops call into bcm2835_mbox, which in-turn reads from
+     * iomem. As such, mark iomem as re-entracy safe.
+     */
+    s->iomem.disable_reentrancy_guard = true;
+
     sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->iomem);
     sysbus_init_irq(SYS_BUS_DEVICE(s), &s->mbox_irq);
 }
-- 
2.39.2



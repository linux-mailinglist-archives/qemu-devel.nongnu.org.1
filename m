Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 442D27D2410
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 18:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quals-0006Fx-57; Sun, 22 Oct 2023 11:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+88d8721f4af1339c2fab+7364+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1quala-0005PO-D7; Sun, 22 Oct 2023 11:53:26 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+88d8721f4af1339c2fab+7364+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1qualT-0008WT-Ik; Sun, 22 Oct 2023 11:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=cDe39DUQ85zReKLUErmTIqxRmXQD1aFZCXjsrH+LZ3s=; b=wYlHB7MJR3qNQm673tJ6ylQwiG
 Q4w+wdhYCdAZUH/BSQXjPoKmOmQH8VIR1ApYlF6SbYjU3nPhXVX5v9WVfwe0Hw3vR5HVqKer14Ic0
 upRmCB8gD1y0SNLX4JlW79DJoNu0ryKdzFIaW24UiHxH5MFibLvPH5bnh3GFI7mJVd8trcpFy/qn3
 gRFzd4OBA1qLgVVjhXcy/WN+TAiiJxNTtV6PRmseWqaw6LJsuuFh4Zpjo4T9IS3oU9W2GS2veJHCF
 6BbaK5WbTGgjXIu+V/KNB3DyniptnKAaSTMPnixjVArh1n7rmDwzaovXV4xmepF471piCTbELCmYh
 JjKAF+Mw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1quakJ-008TGd-WA; Sun, 22 Oct 2023 15:52:08 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96 #2 (Red Hat
 Linux)) id 1quakJ-001qaD-1v; Sun, 22 Oct 2023 16:52:07 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rob Herring <robh@kernel.org>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Helge Deller <deller@gmx.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <huth@tuxfamily.org>,
 Laurent Vivier <laurent@vivier.eu>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Bin Meng <bin.meng@windriver.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liweiwei@iscas.ac.cn>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org
Subject: [PATCH 29/45] hw/arm/stellaris: use qemu_find_nic_info()
Date: Sun, 22 Oct 2023 16:51:44 +0100
Message-Id: <20231022155200.436340-30-dwmw2@infradead.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231022155200.436340-1-dwmw2@infradead.org>
References: <20231022155200.436340-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+88d8721f4af1339c2fab+7364+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

Rather than just using qemu_configure_nic_device(), populate the MAC
address in the system-registers device by peeking at the NICInfo before
it's assigned to the device.

Generate the MAC address early, if there is no matching -nic option.
Otherwise the MAC address wouldn't be generated until net_client_init1()
runs.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/arm/stellaris.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index aa5b0ddfaa..9385ccaafb 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1025,7 +1025,8 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     DeviceState *ssys_dev;
     int i;
     int j;
-    const uint8_t *macaddr;
+    NICInfo *nd;
+    MACAddr mac;
 
     MemoryRegion *sram = g_new(MemoryRegion, 1);
     MemoryRegion *flash = g_new(MemoryRegion, 1);
@@ -1048,12 +1049,22 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
      * need its sysclk output.
      */
     ssys_dev = qdev_new(TYPE_STELLARIS_SYS);
-    /* Most devices come preprogrammed with a MAC address in the user data. */
-    macaddr = nd_table[0].macaddr.a;
+
+    /*
+     * Most devices come preprogrammed with a MAC address in the user data.
+     * Generate a MAC address now, if there isn't a matching -nic for it.
+     */
+    nd = qemu_find_nic_info("stellaris_enet", true, "stellaris");
+    if (nd) {
+        memcpy(mac.a, nd->macaddr.a, sizeof(mac.a));
+    } else {
+        qemu_macaddr_default_if_unset(&mac);
+    }
+
     qdev_prop_set_uint32(ssys_dev, "user0",
-                         macaddr[0] | (macaddr[1] << 8) | (macaddr[2] << 16));
+                         mac.a[0] | (mac.a[1] << 8) | (mac.a[2] << 16));
     qdev_prop_set_uint32(ssys_dev, "user1",
-                         macaddr[3] | (macaddr[4] << 8) | (macaddr[5] << 16));
+                         mac.a[3] | (mac.a[4] << 8) | (mac.a[5] << 16));
     qdev_prop_set_uint32(ssys_dev, "did0", board->did0);
     qdev_prop_set_uint32(ssys_dev, "did1", board->did1);
     qdev_prop_set_uint32(ssys_dev, "dc0", board->dc0);
@@ -1265,10 +1276,13 @@ static void stellaris_init(MachineState *ms, stellaris_board_info *board)
     if (board->dc4 & (1 << 28)) {
         DeviceState *enet;
 
-        qemu_check_nic_model(&nd_table[0], "stellaris");
-
         enet = qdev_new("stellaris_enet");
-        qdev_set_nic_properties(enet, &nd_table[0]);
+        if (nd) {
+            qdev_set_nic_properties(enet, nd);
+        } else {
+            qdev_prop_set_macaddr(enet, "mac", mac.a);
+        }
+
         sysbus_realize_and_unref(SYS_BUS_DEVICE(enet), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(enet), 0, 0x40048000);
         sysbus_connect_irq(SYS_BUS_DEVICE(enet), 0, qdev_get_gpio_in(nvic, 42));
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED4D7E2D70
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 20:59:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r05hR-0000Zz-7r; Mon, 06 Nov 2023 14:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7ad6dfa9aff48d363c6b+7379+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r05gy-0006OS-4Y; Mon, 06 Nov 2023 14:55:25 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7ad6dfa9aff48d363c6b+7379+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1r05gn-00066b-K6; Mon, 06 Nov 2023 14:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=5bcCMvV82e1Sve2BVcG15Kkp2UpIXLhocOoMJ70sRvM=; b=MkbWAP53t45zN+J3OWeTYLRWqY
 IxlT+triXTTst7xf9SvNcu8e8o7Y0xaQ4Ne6iu1sC6cAx4OcKM5enOL97HpiQYuuSwPUIVIF+5TdK
 MtcKcGgKJ3l5ADxs/LybZam94ZFFFa9iaUGNCykVTVjEFYxwZuyI4Bqgmtz7xhrpJh8nXM7ojZdSr
 uoG91AJ6DjX9JRGuYnwh0gBz5OP/QET0xcxH8+d91nQT+Z0g5ZEonDhQuPKD5idwhniGeKgJcqRRZ
 qBTybWjW24MrUYxXRNdxTR2jofI8qvQoAw3+ygenrcCyriRs/Lu1txhaK9XjnuhVc+hfjrtDrBAd3
 91AbXCAA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1r05fa-007taN-LN; Mon, 06 Nov 2023 19:53:59 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96.2 #2 (Red
 Hat Linux)) id 1r05fa-001GNj-2g; Mon, 06 Nov 2023 19:53:58 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
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
Subject: [PATCH for-8.3 v2 17/46] hw/ppc: use pci_init_nic_devices()
Date: Mon,  6 Nov 2023 19:49:22 +0000
Message-ID: <20231106195352.301038-18-dwmw2@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106195352.301038-1-dwmw2@infradead.org>
References: <20231106195352.301038-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+7ad6dfa9aff48d363c6b+7379+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/ppc/e500.c          |  4 +---
 hw/ppc/mac_newworld.c  |  4 +---
 hw/ppc/mac_oldworld.c  |  4 +---
 hw/ppc/ppc440_bamboo.c | 14 +++++---------
 4 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index e04114fb3c..f62eeb3411 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1075,9 +1075,7 @@ void ppce500_init(MachineState *machine)
 
     if (pci_bus) {
         /* Register network interfaces. */
-        for (i = 0; i < nb_nics; i++) {
-            pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
-        }
+        pci_init_nic_devices(pci_bus, mc->default_nic);
     }
 
     /* Register spinning region */
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 535710314a..b36dbaf2b6 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -444,9 +444,7 @@ static void ppc_core99_init(MachineState *machine)
         graphic_depth = 15;
     }
 
-    for (i = 0; i < nb_nics; i++) {
-        pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
-    }
+    pci_init_nic_devices(pci_bus, mc->default_nic);
 
     /* The NewWorld NVRAM is not located in the MacIO device */
     if (kvm_enabled() && qemu_real_host_page_size() > 4096) {
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 9acc7adfc9..1981d3d8f6 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -277,9 +277,7 @@ static void ppc_heathrow_init(MachineState *machine)
 
     pci_vga_init(pci_bus);
 
-    for (i = 0; i < nb_nics; i++) {
-        pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
-    }
+    pci_init_nic_devices(pci_bus, mc->default_nic);
 
     /* MacIO IDE */
     ide_drive_get(hd, ARRAY_SIZE(hd));
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index a189942de4..c75c3083e6 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -161,7 +161,6 @@ static void bamboo_init(MachineState *machine)
     DeviceState *uicdev;
     SysBusDevice *uicsbd;
     int success;
-    int i;
 
     if (kvm_enabled()) {
         error_report("machine %s does not support the KVM accelerator",
@@ -234,14 +233,11 @@ static void bamboo_init(MachineState *machine)
     }
 
     if (pcibus) {
-        /* Register network interfaces. */
-        for (i = 0; i < nb_nics; i++) {
-            /*
-             * There are no PCI NICs on the Bamboo board, but there are
-             * PCI slots, so we can pick whatever default model we want.
-             */
-            pci_nic_init_nofail(&nd_table[i], pcibus, mc->default_nic, NULL);
-        }
+        /*
+         * There are no PCI NICs on the Bamboo board, but there are
+         * PCI slots, so we can pick whatever default model we want.
+         */
+        pci_init_nic_devices(pcibus, mc->default_nic);
     }
 
     /* Load kernel. */
-- 
2.41.0



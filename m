Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FCE8279BF
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 21:56:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMwaY-0005sg-8C; Mon, 08 Jan 2024 15:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+41a72dc6539c0dfbbc31+7442+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rMwZv-00041T-87; Mon, 08 Jan 2024 15:50:35 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+41a72dc6539c0dfbbc31+7442+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1rMwZq-0000v7-Gp; Mon, 08 Jan 2024 15:50:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=gAKwLxJ9GrgFAgVd8NfOlltKClYjwdlcDlfOHDbpTRo=; b=m9RL72hoic6j71eYQXCMpigCQe
 kc7kcinrlRJQT0Dra5IIza7HBIzUpfvP5+FJXezICTEkDc6nRNpoxfqjpKKsZVnzqw1cURpeRGXx+
 V6y/uGAb1uqTlEvsdxiw913WMZpVWKi1lJF/d98AFA9UytmAYsZSF71U5gtWVtT0BdwqCH8eM2ocW
 Pqh3uqD98gkzuDPYFCSM2yaVbwuk+7KGIn0tWWOErXzbgRblNoO2egcYiWSXe5JWB9k7sSjPHzsk9
 TBJVdEVZ5St8UB4risV+pAvMeTKX4hufCKmrZBrjH8zqus4Fwf68EclEkgpVrxIJHhDSQ9MO7C5ob
 5Ffqt/iA==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1rMwYk-008RPx-4k; Mon, 08 Jan 2024 20:49:23 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96.2 #2 (Red
 Hat Linux)) id 1rMwYk-002NFp-28; Mon, 08 Jan 2024 20:49:22 +0000
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
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v3 27/46] hw/arm/highbank: use qemu_create_nic_device()
Date: Mon,  8 Jan 2024 20:26:56 +0000
Message-ID: <20240108204909.564514-28-dwmw2@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240108204909.564514-1-dwmw2@infradead.org>
References: <20240108204909.564514-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+41a72dc6539c0dfbbc31+7442+infradead.org+dwmw2@casper.srs.infradead.org;
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
 hw/arm/highbank.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index c21e18d08f..6a0e20e58d 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -296,19 +296,17 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
 
     sysbus_create_simple(TYPE_SYSBUS_AHCI, 0xffe08000, pic[83]);
 
-    if (nd_table[0].used) {
-        qemu_check_nic_model(&nd_table[0], "xgmac");
-        dev = qdev_new("xgmac");
-        qdev_set_nic_properties(dev, &nd_table[0]);
+    dev = qemu_create_nic_device("xgmac", true, NULL);
+    if (dev) {
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xfff50000);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[77]);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, pic[78]);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 2, pic[79]);
+    }
 
-        qemu_check_nic_model(&nd_table[1], "xgmac");
-        dev = qdev_new("xgmac");
-        qdev_set_nic_properties(dev, &nd_table[1]);
+    dev = qemu_create_nic_device("xgmac", true, NULL);
+    if (dev) {
         sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
         sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xfff51000);
         sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[80]);
-- 
2.41.0



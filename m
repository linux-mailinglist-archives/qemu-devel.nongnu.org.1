Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECBD7E2D61
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 20:57:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r05h6-0006O4-Vb; Mon, 06 Nov 2023 14:55:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+aa7b7dce24b49c47a83c+7379+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1r05gm-0006Ju-EF; Mon, 06 Nov 2023 14:55:15 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+aa7b7dce24b49c47a83c+7379+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1r05gj-00065f-Hl; Mon, 06 Nov 2023 14:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=tlzAB3Jn/UWpyGkQsCC1RyHcWVov5/+PrTpxS04M0Yo=; b=fJHIzraBFvJZJ10z0UlO4aRJj/
 hLvbp2Pve7Xl/DpKD8kAP6iuZkpDARbSazchWV2nc8WqXdLkAOWPBJ0Lk2e0/a8XPsBH9lHjQ/UxI
 91IUnUT/jAODNLORFQq3LjMM2DWg996OBIWOvaGuxcMBiO5MW3/2MyaUIyygth+ZSHoLJTT5t1sFp
 7g2rLRKqjSHzUjNaZaNsp87VNFib/Q0gk5yTJofnKN6v6uK31fS+rGaz43y/oPF/HTQjJW3s6KBI4
 15d2ynXpAj+ssIMKEXqKfSBFkmHyIhsnEh+1qqeYiDOyf9x7nzgrzX1GgO43DYk68838vdbnaEMLA
 bi3Jrljw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1r05fc-00AkG9-37; Mon, 06 Nov 2023 19:54:02 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.96.2 #2 (Red
 Hat Linux)) id 1r05fc-001GP9-28; Mon, 06 Nov 2023 19:54:00 +0000
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
Subject: [PATCH for-8.3 v2 36/46] hw/mips/jazz: use qemu_find_nic_info()
Date: Mon,  6 Nov 2023 19:49:41 +0000
Message-ID: <20231106195352.301038-37-dwmw2@infradead.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106195352.301038-1-dwmw2@infradead.org>
References: <20231106195352.301038-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+aa7b7dce24b49c47a83c+7379+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
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

Extract the MAC address from the NICInfo, or generate one explicitly if
there was no corresponding NIC configuration, to put it in the PROM.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/mips/jazz.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/mips/jazz.c b/hw/mips/jazz.c
index d33a76ad4d..39a82fc2be 100644
--- a/hw/mips/jazz.c
+++ b/hw/mips/jazz.c
@@ -113,15 +113,19 @@ static const MemoryRegionOps dma_dummy_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
-static void mips_jazz_init_net(NICInfo *nd, IOMMUMemoryRegion *rc4030_dma_mr,
+static void mips_jazz_init_net(IOMMUMemoryRegion *rc4030_dma_mr,
                                DeviceState *rc4030, MemoryRegion *dp8393x_prom)
 {
     DeviceState *dev;
     SysBusDevice *sysbus;
     int checksum, i;
     uint8_t *prom;
+    NICInfo *nd;
 
-    qemu_check_nic_model(nd, "dp83932");
+    nd = qemu_find_nic_info("dp8393x", true, "dp82932");
+    if (!nd) {
+        return;
+    }
 
     dev = qdev_new("dp8393x");
     qdev_set_nic_properties(dev, nd);
@@ -316,12 +320,7 @@ static void mips_jazz_init(MachineState *machine,
     }
 
     /* Network controller */
-    if (nb_nics == 1) {
-        mips_jazz_init_net(&nd_table[0], rc4030_dma_mr, rc4030, dp8393x_prom);
-    } else if (nb_nics > 1) {
-        error_report("This machine only supports one NIC");
-        exit(1);
-    }
+    mips_jazz_init_net(rc4030_dma_mr, rc4030, dp8393x_prom);
 
     /* SCSI adapter */
     dev = qdev_new(TYPE_SYSBUS_ESP);
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFA970AD6D
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 12:25:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0gET-0004HD-Jb; Sun, 21 May 2023 06:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0gEO-0004Ft-VJ
 for qemu-devel@nongnu.org; Sun, 21 May 2023 06:24:04 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0gEM-0003Jk-6d
 for qemu-devel@nongnu.org; Sun, 21 May 2023 06:24:03 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailout.nyi.internal (Postfix) with ESMTP id B162B5C0105;
 Sun, 21 May 2023 06:24:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute5.internal (MEProxy); Sun, 21 May 2023 06:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1684664641; x=
 1684751041; bh=A50qCsdarzBpdPo8QuJCvbqUHL76ir9sIgtUulN2W1w=; b=L
 E8CPqeM0Jg2PrZO5MzsBtc5HZu6ivJ6wmgeuk8/uz4XaUg/CRZ0vfnX2/eq8yENN
 kl0ZEq0EAEk4ChPf1mMJoqt78cuJJvDAlXXoDCiTCBwt0UBz1fNzTXXzsLQaD/e/
 xnQd7DIgwNAX/wNC5tCQ8ZkMWVR1tsncPbT6ziMGDi7IOpxFicDu6Dv/qRYiCjK1
 QbE0s190uy7yAsPdxgO4JWdV2Qeded97P36o/N6PUr7LSECiEPIs5NNaq+O+yo4M
 xXHIClHoZQ/5+zoOrCEUn1HA/QEi2yPujzZGw8GLEmKM7cqswdTVIexTpPUoOFlF
 1TQ6WYW5vWO4oNZS/e4Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684664641; x=
 1684751041; bh=A50qCsdarzBpdPo8QuJCvbqUHL76ir9sIgtUulN2W1w=; b=V
 KwUowu8mooNNkDCCOhtT5pmH2yZWQvyZgktwTxKP9XdtQNmHuKItMqqJWbqnTHHU
 vG0j7Kaf6s7d1D9Dvih/70bysHsHRQWp8qMjHtj/AM04aO0AwKbxY4F3+xkNQ6a1
 u637PX7XLkHcEV0BfT/9LIWRzTw2JMyPVq1dknYMQGCyonSXnpk8W5LWbda3UoUb
 crzhGXDHo5n8cf2vAcsL95d88zW2IG6SIr4SXRYIMztp6pMh/+qbyyw0Im6YgSWe
 o3IMAUswtkFsdVwYephVQXmJCk/Uun39MHPrJe/X/9Du/fN3JfbmRsJpXmPRpoue
 16Lp4BMOjpV7LFTkdgHFA==
X-ME-Sender: <xms:QfFpZIG1uO3RkWozCK8OTJ4j5cCWaMZx21cmj1kkm8aIp2oFJQoyBw>
 <xme:QfFpZBVKmaOLIW4xIxa30AhCdIhIInaOI8UrnWF0_PH0Fzoxd3gv8Z10Qo_3YbNO6
 mGH5Cix4TxducaDBBw>
X-ME-Received: <xmr:QfFpZCLBj9mke5OuPxZ5b5ph8VvZwAm0g3kXwdTe5gKgBiSatrjygsrpd5dC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiledgvdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
 ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
 ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
 dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
 vgepudenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
 hgohgrthdrtghomh
X-ME-Proxy: <xmx:QfFpZKEz9ZXiXtVFFg2LtkyrGn54lnI_pjEu6FuxIOY8UiXZ8svOUw>
 <xmx:QfFpZOVleZglGnsqfy2fOzA6HWRCIkCLNWdwT9R-HW3P7Tb1gzwmIg>
 <xmx:QfFpZNO8PgMmFC0YAdWgBGbBoMDSBWOfnyWjeVdF2l04FHwS-tY5oQ>
 <xmx:QfFpZJGDbSBXaCfzdxQ-QpQHW2i9aMmvOa9LEsPkK50bN0NRKebjXA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 May 2023 06:24:00 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Cc: yangxiaojuan@loongson.cn, gaosong@loongson.cn, philmd@linaro.org,
 chenhuacai@kernel.org, crosa@redhat.com, wainersm@redhat.com,
 bleal@redhat.com, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/4] hw/mips/loongson3_virt: Wire up loongarch_ipi device
Date: Sun, 21 May 2023 11:23:06 +0100
Message-Id: <20230521102307.87081-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.25; envelope-from=jiaxun.yang@flygoat.com;
 helo=out1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Wire up loongarch_ipi device for loongson3_virt machine, so we
can have SMP support for TCG backend as well.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 hw/mips/Kconfig           |  1 +
 hw/mips/loongson3_bootp.c |  2 --
 hw/mips/loongson3_bootp.h |  3 +++
 hw/mips/loongson3_virt.c  | 20 ++++++++++++++++++--
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index da3a37e215ec..7cb6c1def16c 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -40,6 +40,7 @@ config LOONGSON3V
     imply QXL if SPICE
     select SERIAL
     select GOLDFISH_RTC
+    select LOONGARCH_IPI
     select LOONGSON_LIOINTC
     select PCI_DEVICES
     select PCI_EXPRESS_GENERIC_BRIDGE
diff --git a/hw/mips/loongson3_bootp.c b/hw/mips/loongson3_bootp.c
index f99af229327a..474d3556b2e5 100644
--- a/hw/mips/loongson3_bootp.c
+++ b/hw/mips/loongson3_bootp.c
@@ -25,8 +25,6 @@
 #include "hw/boards.h"
 #include "hw/mips/loongson3_bootp.h"
 
-#define LOONGSON3_CORE_PER_NODE 4
-
 static void init_cpu_info(void *g_cpuinfo, uint64_t cpu_freq)
 {
     struct efi_cpuinfo_loongson *c = g_cpuinfo;
diff --git a/hw/mips/loongson3_bootp.h b/hw/mips/loongson3_bootp.h
index d525ab745a69..55f98858a5f4 100644
--- a/hw/mips/loongson3_bootp.h
+++ b/hw/mips/loongson3_bootp.h
@@ -200,6 +200,8 @@ struct boot_params {
     struct efi_reset_system_t reset_system;
 };
 
+#define LOONGSON3_CORE_PER_NODE 4
+
 /* Overall MMIO & Memory layout */
 enum {
     VIRT_LOWMEM,
@@ -211,6 +213,7 @@ enum {
     VIRT_BIOS_ROM,
     VIRT_UART,
     VIRT_LIOINTC,
+    VIRT_IPI,
     VIRT_PCIE_MMIO,
     VIRT_HIGHMEM
 };
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index 25534288dd81..a57245012598 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -38,6 +38,7 @@
 #include "hw/mips/loongson3_bootp.h"
 #include "hw/misc/unimp.h"
 #include "hw/intc/i8259.h"
+#include "hw/intc/loongarch_ipi.h"
 #include "hw/loader.h"
 #include "hw/isa/superio.h"
 #include "hw/pci/msi.h"
@@ -76,6 +77,7 @@ const MemMapEntry virt_memmap[] = {
     [VIRT_PCIE_ECAM] =   { 0x1a000000,     0x2000000 },
     [VIRT_BIOS_ROM] =    { 0x1fc00000,      0x200000 },
     [VIRT_UART] =        { 0x1fe001e0,           0x8 },
+    [VIRT_IPI] =         { 0x3ff01000,         0x400 },
     [VIRT_LIOINTC] =     { 0x3ff01400,          0x64 },
     [VIRT_PCIE_MMIO] =   { 0x40000000,    0x40000000 },
     [VIRT_HIGHMEM] =     { 0x80000000,           0x0 }, /* Variable */
@@ -529,6 +531,8 @@ static void mips_loongson3_virt_init(MachineState *machine)
     clock_set_hz(cpuclk, DEF_LOONGSON3_FREQ);
 
     for (i = 0; i < machine->smp.cpus; i++) {
+        int node = i / LOONGSON3_CORE_PER_NODE;
+        int core = i % LOONGSON3_CORE_PER_NODE;
         int ip;
 
         /* init CPUs */
@@ -539,12 +543,24 @@ static void mips_loongson3_virt_init(MachineState *machine)
         cpu_mips_clock_init(cpu);
         qemu_register_reset(main_cpu_reset, cpu);
 
-        if (i >= 4) {
+        /* IPI controller is in kernel for KVM */
+        if (!kvm_enabled()) {
+            DeviceState *ipi;
+
+            hwaddr base = ((hwaddr)node << 44) + virt_memmap[VIRT_IPI].base;
+            base += core * 0x100;
+            ipi = qdev_new(TYPE_LOONGARCH_IPI);
+            sysbus_realize_and_unref(SYS_BUS_DEVICE(ipi), &error_fatal);
+            qdev_connect_gpio_out(ipi, 0, cpu->env.irq[6]);
+            sysbus_mmio_map(SYS_BUS_DEVICE(ipi), 0, base);
+        }
+
+        if (node > 0) {
             continue; /* Only node-0 can be connected to LIOINTC */
         }
 
         for (ip = 0; ip < 4 ; ip++) {
-            int pin = i * 4 + ip;
+            int pin = core * LOONGSON3_CORE_PER_NODE + ip;
             sysbus_connect_irq(SYS_BUS_DEVICE(liointc),
                                pin, cpu->env.irq[ip + 2]);
         }
-- 
2.39.2 (Apple Git-143)



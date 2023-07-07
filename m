Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD58574B024
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 13:45:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHjgn-0001w8-BT; Fri, 07 Jul 2023 07:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgh-0001uw-HF; Fri, 07 Jul 2023 07:31:47 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHjgf-0006Y2-5u; Fri, 07 Jul 2023 07:31:46 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6b74faaac3bso1624147a34.1; 
 Fri, 07 Jul 2023 04:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688729503; x=1691321503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndNoYF/nwDu6Pe/3jyDnKrPjFeIA0wtutwRoW6DvcPc=;
 b=J45mp95TSKbSTwJIj3uS0KXa49lQw03JiuX72ab67UaS86S7ew57hiFvxIiJH7f0VE
 gbYsWQK9/Xdn2R31gat5rTu8nMUtRvx2F5Zo5YMS5goRR0f3gpQKXTQLNKtyVpyAaE/P
 GBzNAdv7nrkICjcQXpI3i+6/5+mxTxCVbOqdVP3wT0xdpv9uoqu/+m7uOXA2AUGFaphI
 TNHyMsk1m/ePGNgIC4HghnB+xH6gStnKIlIksikbqzCe4ikPMG5W0CXConNxm/7FbTp/
 onBZ9YfBKa35oeI+1++G9FijQgsRuBchFLDCsbx1ilE0ly0TvT56cSaV9h7nGJ0rXjK4
 r0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688729503; x=1691321503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ndNoYF/nwDu6Pe/3jyDnKrPjFeIA0wtutwRoW6DvcPc=;
 b=DpF+XKWiBsr4+gXCy2+28gD7NCP2Ac7e5sgFQwFukxHbmy6lhzRiSNnSZ0Zpe6gVtz
 s0AMTQLCG2mxNmzANMgfvfLVn4EDLYxvCs8HqY149qapWTrvD5xLmyYjkqv327Q3zfvT
 2m0GwPhGuvsiH36tV1zhDiGIQe6WddW9sFcNva04PGGVQmFK0QdTf9Rb3HLfpinGOB0L
 u3MBWseO5TmGnAc6bZVkx0nvxtouN5J/pYoqRDWxCZpht0AWhLPKToSo65PjqmEeGn74
 /JzOMXjdgEpMoFYrZ09PMNwqvnBqm2lYsHKWKEuVqAz6ejaCA0INTVoBFaLxjyfd3mWL
 5tQg==
X-Gm-Message-State: ABy/qLYwKyppe+ECKYzskSGsvrcd9TJyVyz7vOq3eCf70IJfEjuEX9D9
 3RVxpPTED42BNz4Btf4/QVHdDIwIdnU=
X-Google-Smtp-Source: APBJJlEVyakrEeq6wGLeGvkHF3Y1bqXSVgIDNp7uzfjMd7ixdqKj+y8OmyodZQs82ceeMdORVWiB/w==
X-Received: by 2002:a9d:7411:0:b0:6b7:5363:1eea with SMTP id
 n17-20020a9d7411000000b006b753631eeamr4688702otk.16.1688729503640; 
 Fri, 07 Jul 2023 04:31:43 -0700 (PDT)
Received: from grind.. ([2804:14c:f435:9162::1002])
 by smtp.gmail.com with ESMTPSA id
 g17-20020a9d6c51000000b006b74b37f5e5sm1574859otq.20.2023.07.07.04.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 04:31:43 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PULL 08/60] sungem: Add WOL MMIO
Date: Fri,  7 Jul 2023 08:30:16 -0300
Message-ID: <20230707113108.7145-9-danielhb413@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
References: <20230707113108.7145-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

Apple sungem devices are expected to have WOL MMIO registers.
Add a region to prevent transaction failures, and implement the
WOL-disable CSR write because the Linux driver reset writes
this.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20230625201628.65231-1-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/net/sungem.c     | 52 +++++++++++++++++++++++++++++++++++++++++++++
 hw/net/trace-events |  2 ++
 2 files changed, 54 insertions(+)

diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index eb01520790..e0e8e5ae41 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -107,6 +107,15 @@ OBJECT_DECLARE_SIMPLE_TYPE(SunGEMState, SUNGEM)
 #define RXDMA_FTAG        0x0110UL    /* RX FIFO Tag */
 #define RXDMA_FSZ         0x0120UL    /* RX FIFO Size */
 
+/* WOL Registers */
+#define SUNGEM_MMIO_WOL_SIZE   0x14
+
+#define WOL_MATCH0        0x0000UL
+#define WOL_MATCH1        0x0004UL
+#define WOL_MATCH2        0x0008UL
+#define WOL_MCOUNT        0x000CUL
+#define WOL_WAKECSR       0x0010UL
+
 /* MAC Registers */
 #define SUNGEM_MMIO_MAC_SIZE   0x200
 
@@ -168,6 +177,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(SunGEMState, SUNGEM)
 #define SUNGEM_MMIO_PCS_SIZE   0x60
 #define PCS_MIISTAT       0x0004UL    /* PCS MII Status Register */
 #define PCS_ISTAT         0x0018UL    /* PCS Interrupt Status Reg */
+
 #define PCS_SSTATE        0x005CUL    /* Serialink State Register */
 
 /* Descriptors */
@@ -200,6 +210,7 @@ struct SunGEMState {
     MemoryRegion greg;
     MemoryRegion txdma;
     MemoryRegion rxdma;
+    MemoryRegion wol;
     MemoryRegion mac;
     MemoryRegion mif;
     MemoryRegion pcs;
@@ -1076,6 +1087,43 @@ static const MemoryRegionOps sungem_mmio_rxdma_ops = {
     },
 };
 
+static void sungem_mmio_wol_write(void *opaque, hwaddr addr, uint64_t val,
+                                    unsigned size)
+{
+    trace_sungem_mmio_wol_write(addr, val);
+
+    switch (addr) {
+    case WOL_WAKECSR:
+        if (val != 0) {
+            qemu_log_mask(LOG_UNIMP, "sungem: WOL not supported\n");
+        }
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "sungem: WOL not supported\n");
+    }
+}
+
+static uint64_t sungem_mmio_wol_read(void *opaque, hwaddr addr, unsigned size)
+{
+    uint32_t val = -1;
+
+    qemu_log_mask(LOG_UNIMP, "sungem: WOL not supported\n");
+
+    trace_sungem_mmio_wol_read(addr, val);
+
+    return val;
+}
+
+static const MemoryRegionOps sungem_mmio_wol_ops = {
+    .read = sungem_mmio_wol_read,
+    .write = sungem_mmio_wol_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
 static void sungem_mmio_mac_write(void *opaque, hwaddr addr, uint64_t val,
                                   unsigned size)
 {
@@ -1344,6 +1392,10 @@ static void sungem_realize(PCIDevice *pci_dev, Error **errp)
                           "sungem.rxdma", SUNGEM_MMIO_RXDMA_SIZE);
     memory_region_add_subregion(&s->sungem, 0x4000, &s->rxdma);
 
+    memory_region_init_io(&s->wol, OBJECT(s), &sungem_mmio_wol_ops, s,
+                          "sungem.wol", SUNGEM_MMIO_WOL_SIZE);
+    memory_region_add_subregion(&s->sungem, 0x3000, &s->wol);
+
     memory_region_init_io(&s->mac, OBJECT(s), &sungem_mmio_mac_ops, s,
                           "sungem.mac", SUNGEM_MMIO_MAC_SIZE);
     memory_region_add_subregion(&s->sungem, 0x6000, &s->mac);
diff --git a/hw/net/trace-events b/hw/net/trace-events
index e4a98b2c7d..930e5b4293 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -350,6 +350,8 @@ sungem_mmio_txdma_write(uint64_t addr, uint64_t val) "MMIO txdma write to 0x%"PR
 sungem_mmio_txdma_read(uint64_t addr, uint64_t val) "MMIO txdma read from 0x%"PRIx64" val=0x%"PRIx64
 sungem_mmio_rxdma_write(uint64_t addr, uint64_t val) "MMIO rxdma write to 0x%"PRIx64" val=0x%"PRIx64
 sungem_mmio_rxdma_read(uint64_t addr, uint64_t val) "MMIO rxdma read from 0x%"PRIx64" val=0x%"PRIx64
+sungem_mmio_wol_write(uint64_t addr, uint64_t val) "MMIO wol write to 0x%"PRIx64" val=0x%"PRIx64
+sungem_mmio_wol_read(uint64_t addr, uint64_t val) "MMIO wol read from 0x%"PRIx64" val=0x%"PRIx64
 sungem_mmio_mac_write(uint64_t addr, uint64_t val) "MMIO mac write to 0x%"PRIx64" val=0x%"PRIx64
 sungem_mmio_mac_read(uint64_t addr, uint64_t val) "MMIO mac read from 0x%"PRIx64" val=0x%"PRIx64
 sungem_mmio_mif_write(uint64_t addr, uint64_t val) "MMIO mif write to 0x%"PRIx64" val=0x%"PRIx64
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D1373D394
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 22:18:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDWA6-0002Wk-EA; Sun, 25 Jun 2023 16:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDWA4-0002WV-PV; Sun, 25 Jun 2023 16:16:40 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDWA3-0001fB-1v; Sun, 25 Jun 2023 16:16:40 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-262ec7b261bso411161a91.3; 
 Sun, 25 Jun 2023 13:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687724197; x=1690316197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3vU7Yi9mmPHRB1byk9SAV/uXRnkBClztyRAiv/Yr29Q=;
 b=PcmUp/7HrThd2sD8BNA2yjuBe9ePMG4znAQm70cMDTTnUi0H28B8/iIE+LXT/7Z08v
 SIDuTNWXyZA/w8gvey2qrAWEGLWH5i1oAHkZg3mblBnYeKmSbQQr0gILpilHo6oKAvvw
 QmRdZHYL/J/cdQRbK5sZ1iPkA81qQ7RlPy7N8eMxWsUF7ROu5JgA07yZwmqfMzP7zgT6
 Jq/xzrVIMXuoDMY8OXQS2DECoep958tFDOMkeL+4TxyuRRu8Fz0DRkpcM7VNJnpOpx1V
 WPsEXOiJ0WBb0DQ+EohvECsBjfMo4NHNhUe9M09bNkOqMVr8WCJRbO+OJMag2w7Wi5pf
 5+sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687724197; x=1690316197;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3vU7Yi9mmPHRB1byk9SAV/uXRnkBClztyRAiv/Yr29Q=;
 b=AnvrdDF0L+sBUvJu5h1GLyJnLnW54jAK/2I5HkK4yJLdig51zZTIxYsTHgoivw8mnB
 kwlJs9EdoeFRct3bpkOtgt7vINlnw7ea5SmNpgpSRB8cu65NohQYgvPLlnXVM1oD/a2l
 +rJA0x6cakLyjeb4Y5L1D6Vw4X9vexXGlPduhogpFbLXGxvDYHwC4ps42R05qdQTJRKE
 rraukk42esPK7ZhchildLyddQIt5LJUOXkmct208EG1IPpb+J5TFfQOUjfu6SCfZBcQO
 qGJzb1RWOFoT/ImToQDO2t00ECapmQP7bTUKh8AYcYZMJXU/cQZIOkFpincnSwviVOrf
 t6Ew==
X-Gm-Message-State: AC+VfDwIUubi8q8zhRmJC6oIrTdM85I1YMCwnqig5meMj5JbjpxnNSkV
 /Wk0stUgpWcHhdDLb8M2v4s=
X-Google-Smtp-Source: ACHHUZ65qEr0SuNguQ6KQaWZ7t9b/CdKbx8I6UEOY8c+5RnxTMn19kyVT6DtsP9DbQh7K8OgtqT/rw==
X-Received: by 2002:a17:90b:4b88:b0:262:b22b:d2e8 with SMTP id
 lr8-20020a17090b4b8800b00262b22bd2e8mr7185845pjb.17.1687724197199; 
 Sun, 25 Jun 2023 13:16:37 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 y15-20020a17090a6c8f00b00260cce91d20sm3203094pjj.33.2023.06.25.13.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Jun 2023 13:16:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH] sungem: Add WOL MMIO
Date: Mon, 26 Jun 2023 06:16:28 +1000
Message-Id: <20230625201628.65231-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Apple sungem devices are expected to have WOL MMIO registers.
Add a region to prevent transaction failures, and implement the
WOL-disable CSR write because the Linux driver reset writes
this.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
This fixes the failed MMIO error in the Linux sungem driver reset
when it clears the WOL CSR.

Thanks,
Nick

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
2.40.1



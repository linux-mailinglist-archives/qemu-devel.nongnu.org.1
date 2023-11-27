Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E09587FA79F
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 18:09:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7f6D-0007V6-KZ; Mon, 27 Nov 2023 12:08:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f63-0007Sc-JV
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:36 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r7f61-0004do-A6
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 12:08:34 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2c87adce180so54661761fa.0
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 09:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701104911; x=1701709711; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r7VN+FUHi4irf+Hlji9rNkb2Vpl4dSI7XsEUkLnRwXY=;
 b=XKUXt+cZ/EJEc9urUIHlZpL77MT4eP3bdcJxV1go8RlzlQ5EzqREGn3eE+ehjtIL3o
 RLaEtHmQK+pmpVBdtQaTtXfOqYbptdmnn5DFvuPSN0sW1FszXXa01cO4C2qA1EQWs/Kn
 g57R1PVDT6/ydrmZg0ah2CSulXebhn0k8psMJ8vfaKvgNRAG8hEpJ0LgR3N3IkpokaFJ
 TQJ5Q1R9QWetgN3OIAiY2qwPOZRlIVodo2QvStTMUwHLq3Szo8mK1f4XLRX6CGEKPra5
 WWa0cLOw3DouQK+vPulMhlOqYtaoi+ngCrgh9l04G91/NfoAZr5gwAdwTlOwaKtC0Bhj
 TOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701104911; x=1701709711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r7VN+FUHi4irf+Hlji9rNkb2Vpl4dSI7XsEUkLnRwXY=;
 b=dhi49IksCCmlvQP6VPrPJ6o6HmVpiAMOl5eNTimiz5zwM7iO/upx+qy0/+AjB1ioBd
 9f8+fYWWAZFCMdikByhrtA+IWyyrUVrX29nUff3Ku4b44qODyqFwWOTQ6NlDKMwMX7/H
 KrCpK+R4MsihfRY0f2gH8CYFM83loj9rllvdSyF6VqAV+9ZRsYb6t1oNYPplcCaFutCA
 Nd8PFT7yQb6mU5wfMZ2457NvCkP8WeN5RVRFnGLQJOEMwE0Mjp9Al2P/uzG7VV5atxwT
 10mWS2mAjN7ZnPT//U1UviFCWT25+hFrQ282PQ9sZIFeFC7pcJzL2oAhG6mraPdCm5tl
 62fA==
X-Gm-Message-State: AOJu0YwFL0U3Bmyd0wF3KCIUbeNV54Z9BFo1bpSzUTYhMcSYDWc8NsvR
 RdzwibeAA0AqX9UiacJ81YoP+YYieXL5DvVbhfY=
X-Google-Smtp-Source: AGHT+IFuj6WVWGl6AUS/UQbvq6SRqgXnU7dR7oz2kGroewS9TL/DH82Djm8sUbpbPMIYUxYHUQlXwg==
X-Received: by 2002:a05:651c:48b:b0:2c9:9737:28ab with SMTP id
 s11-20020a05651c048b00b002c9973728abmr5175016ljc.2.1701104911601; 
 Mon, 27 Nov 2023 09:08:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 fl8-20020a05600c0b8800b004030e8ff964sm15353216wmb.34.2023.11.27.09.08.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 09:08:31 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/13] hw/ssi/xilinx_spips: fix an out of bound access
Date: Mon, 27 Nov 2023 17:08:21 +0000
Message-Id: <20231127170823.589863-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231127170823.589863-1-peter.maydell@linaro.org>
References: <20231127170823.589863-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Frederic Konrad <fkonrad@amd.com>

The spips, qspips, and zynqmp-qspips share the same realize function
(xilinx_spips_realize) and initialize their io memory region with different
mmio_ops passed through the class.  The size of the memory region is set to
the largest area (0x200 bytes for zynqmp-qspips) thus it is possible to write
out of s->regs[addr] in xilinx_spips_write for spips and qspips.

This fixes that wrong behavior.

Reviewed-by: Luc Michel <luc.michel@amd.com>
Signed-off-by: Frederic Konrad <fkonrad@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20231124143505.1493184-2-fkonrad@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/ssi/xilinx_spips.h | 3 +++
 hw/ssi/xilinx_spips.c         | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index 1386d5ac8fe..7a754bf67a2 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -33,7 +33,9 @@
 
 typedef struct XilinxSPIPS XilinxSPIPS;
 
+/* For SPIPS, QSPIPS.  */
 #define XLNX_SPIPS_R_MAX        (0x100 / 4)
+/* For ZYNQMP_QSPIPS.  */
 #define XLNX_ZYNQMP_SPIPS_R_MAX (0x200 / 4)
 
 /* Bite off 4k chunks at a time */
@@ -125,6 +127,7 @@ struct XilinxSPIPSClass {
     SysBusDeviceClass parent_class;
 
     const MemoryRegionOps *reg_ops;
+    uint64_t reg_size;
 
     uint32_t rx_fifo_size;
     uint32_t tx_fifo_size;
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index a3955c6c50c..0bdfad7e2e5 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -973,6 +973,8 @@ static void xilinx_spips_write(void *opaque, hwaddr addr,
 
     DB_PRINT_L(0, "addr=" HWADDR_FMT_plx " = %x\n", addr, (unsigned)value);
     addr >>= 2;
+    assert(addr < XLNX_SPIPS_R_MAX);
+
     switch (addr) {
     case R_CONFIG:
         mask = ~(R_CONFIG_RSVD | MAN_START_COM);
@@ -1299,7 +1301,7 @@ static void xilinx_spips_realize(DeviceState *dev, Error **errp)
     }
 
     memory_region_init_io(&s->iomem, OBJECT(s), xsc->reg_ops, s,
-                          "spi", XLNX_ZYNQMP_SPIPS_R_MAX * 4);
+                          "spi", xsc->reg_size);
     sysbus_init_mmio(sbd, &s->iomem);
 
     s->irqline = -1;
@@ -1435,6 +1437,7 @@ static void xilinx_qspips_class_init(ObjectClass *klass, void * data)
 
     dc->realize = xilinx_qspips_realize;
     xsc->reg_ops = &qspips_ops;
+    xsc->reg_size = XLNX_SPIPS_R_MAX * 4;
     xsc->rx_fifo_size = RXFF_A_Q;
     xsc->tx_fifo_size = TXFF_A_Q;
 }
@@ -1450,6 +1453,7 @@ static void xilinx_spips_class_init(ObjectClass *klass, void *data)
     dc->vmsd = &vmstate_xilinx_spips;
 
     xsc->reg_ops = &spips_ops;
+    xsc->reg_size = XLNX_SPIPS_R_MAX * 4;
     xsc->rx_fifo_size = RXFF_A;
     xsc->tx_fifo_size = TXFF_A;
 }
@@ -1464,6 +1468,7 @@ static void xlnx_zynqmp_qspips_class_init(ObjectClass *klass, void * data)
     dc->vmsd = &vmstate_xlnx_zynqmp_qspips;
     device_class_set_props(dc, xilinx_zynqmp_qspips_properties);
     xsc->reg_ops = &xlnx_zynqmp_qspips_ops;
+    xsc->reg_size = XLNX_ZYNQMP_SPIPS_R_MAX * 4;
     xsc->rx_fifo_size = RXFF_A_Q;
     xsc->tx_fifo_size = TXFF_A_Q;
 }
-- 
2.34.1



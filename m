Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D5782F11F
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 16:13:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPl7L-0006gr-TL; Tue, 16 Jan 2024 10:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7J-0006fP-GS
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:41 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPl7F-0005rQ-TN
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 10:12:41 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40e7983ebbbso19135225e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 07:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705417956; x=1706022756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5Kdubwu0P5P8z8NWkhauyT9bVLY3Ot4ak22wBEfwo70=;
 b=v8fYQ7dUlED3DWoa1Cu7uGi1NC7WXuUuvGKpI10tWL7n/lmrH4IOM3+pvH83ogtQ5n
 VaK0z0cBc7EYhHyI454z3M+ZBOn826bmkp7nAKl7TKtlhoASxWcbY7zZbinhNNnkut11
 YhrDHyzJ/rED+aGBWwPuzH/WpCY68GAMTYCLz0/4F6VlqEfoaBiK60dQvJdrHVnBms9h
 YuJJBFQn6fEhmNnqkt2YXNokF35wrdsTXyBsbWryQb4xe3Tkf9Vq/shgsDS0nQHkfyW8
 9OX5Yxh7lhuz8mcNKbvEYYbYy14SAf28F4GnDiQmWJgUxQD/1SW0cBBam7O5hJOFGsq0
 wuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705417956; x=1706022756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Kdubwu0P5P8z8NWkhauyT9bVLY3Ot4ak22wBEfwo70=;
 b=PxJslrSRd/tEcdMGCZk1NGalECJ8ZKHRAWAAG+6BeurKQbzsN0HZoLhxgHonFOi+34
 P0qfcD7/Pjyg2vfIVE/N3feKFwcdqxpAnTjN1lHff9nQfHP2IYzpHZInllesZfbbGXoZ
 quuoDKr3oueARG11E/naGpFkOZeJjAJe0HqPixbhxUbkozIIblXvVlVDsGo8wanGrBrI
 +uoDWOccpMXYgGXk0GJKMff3SbkazOD1n+WqfO9ffKtIUux3ziz4jBjJPrfDSeSayLFF
 Oj95le5Tw9nUywWS4wlZHp7cQUiMJ2lS+2OKaFEMgk+8/jonzSjZqcfrh0yrIcAlilbX
 ry4w==
X-Gm-Message-State: AOJu0Yz8udCCBGfp/5LXxzNWV9F458zhdOvXnBm4XmZYI+v83w768GdR
 AbnZDBUvNR9QIMZqxsUfpbfyV78PE0cHb7aWlaZACmTFEAM=
X-Google-Smtp-Source: AGHT+IHGPbP7C6j2M5F5aatocyHWS9VDIRrF+bbsC8IHRaADXnTRRLTlZIsYd44mlc4FrHiR6xuknQ==
X-Received: by 2002:a05:600c:2112:b0:40e:7f2c:a3fe with SMTP id
 u18-20020a05600c211200b0040e7f2ca3femr1233125wml.142.1705417956081; 
 Tue, 16 Jan 2024 07:12:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adff38e000000b003379b549a00sm10091357wro.10.2024.01.16.07.12.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 07:12:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/21] hw/net: GMAC Rx Implementation
Date: Tue, 16 Jan 2024 15:12:23 +0000
Message-Id: <20240116151228.2430754-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116151228.2430754-1-peter.maydell@linaro.org>
References: <20240116151228.2430754-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Nabih Estefan Diaz <nabihestefan@google.com>

- Implementation of Receive function for packets
- Implementation for reading and writing from and to descriptors in
  memory for Rx

When RX starts, we need to flush the queued packets so that they
can be received by the GMAC device. Without this it won't work
with TAP NIC device.

When RX descriptor list is full, it returns a DMA_STATUS for software
to handle it. But there's no way to indicate the software has
handled all RX descriptors and the whole pipeline stalls.

We do something similar to NPCM7XX EMC to handle this case.

1. Return packet size when RX descriptor is full, effectively
dropping these packets in such a case.
2. When software clears RX descriptor full bit, continue receiving
further packets by flushing QEMU packet queue.

Added relevant trace-events

Change-Id: I132aa254a94cda1a586aba2ea33bbfc74ecdb831
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
Message-id: 20240110234232.4116804-9-nabihestefan@google.com
[PMM: moved a couple of functions into the following patch]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/npcm_gmac.c  | 276 +++++++++++++++++++++++++++++++++++++++++++-
 hw/net/trace-events |   5 +
 2 files changed, 279 insertions(+), 2 deletions(-)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 44c4ffaff42..8dfd370f54c 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -24,6 +24,10 @@
 #include "hw/net/mii.h"
 #include "hw/net/npcm_gmac.h"
 #include "migration/vmstate.h"
+#include "net/checksum.h"
+#include "net/eth.h"
+#include "net/net.h"
+#include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/units.h"
 #include "sysemu/dma.h"
@@ -146,6 +150,17 @@ static void gmac_phy_set_link(NPCMGMACState *gmac, bool active)
 
 static bool gmac_can_receive(NetClientState *nc)
 {
+    NPCMGMACState *gmac = NPCM_GMAC(qemu_get_nic_opaque(nc));
+
+    /* If GMAC receive is disabled. */
+    if (!(gmac->regs[R_NPCM_GMAC_MAC_CONFIG] & NPCM_GMAC_MAC_CONFIG_RX_EN)) {
+        return false;
+    }
+
+    /* If GMAC DMA RX is stopped. */
+    if (!(gmac->regs[R_NPCM_DMA_CONTROL] & NPCM_DMA_CONTROL_START_STOP_RX)) {
+        return false;
+    }
     return true;
 }
 
@@ -189,10 +204,256 @@ static void gmac_update_irq(NPCMGMACState *gmac)
     qemu_set_irq(gmac->irq, level);
 }
 
+static int gmac_read_rx_desc(dma_addr_t addr, struct NPCMGMACRxDesc *desc)
+{
+    if (dma_memory_read(&address_space_memory, addr, desc,
+                        sizeof(*desc), MEMTXATTRS_UNSPECIFIED)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Failed to read descriptor @ 0x%"
+                      HWADDR_PRIx "\n", __func__, addr);
+        return -1;
+    }
+    desc->rdes0 = le32_to_cpu(desc->rdes0);
+    desc->rdes1 = le32_to_cpu(desc->rdes1);
+    desc->rdes2 = le32_to_cpu(desc->rdes2);
+    desc->rdes3 = le32_to_cpu(desc->rdes3);
+    return 0;
+}
+
+static int gmac_write_rx_desc(dma_addr_t addr, struct NPCMGMACRxDesc *desc)
+{
+    struct NPCMGMACRxDesc le_desc;
+    le_desc.rdes0 = cpu_to_le32(desc->rdes0);
+    le_desc.rdes1 = cpu_to_le32(desc->rdes1);
+    le_desc.rdes2 = cpu_to_le32(desc->rdes2);
+    le_desc.rdes3 = cpu_to_le32(desc->rdes3);
+    if (dma_memory_write(&address_space_memory, addr, &le_desc,
+                        sizeof(le_desc), MEMTXATTRS_UNSPECIFIED)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Failed to write descriptor @ 0x%"
+                      HWADDR_PRIx "\n", __func__, addr);
+        return -1;
+    }
+    return 0;
+}
+
+static int gmac_rx_transfer_frame_to_buffer(uint32_t rx_buf_len,
+                                            uint32_t *left_frame,
+                                            uint32_t rx_buf_addr,
+                                            bool *eof_transferred,
+                                            const uint8_t **frame_ptr,
+                                            uint16_t *transferred)
+{
+    uint32_t to_transfer;
+    /*
+     * Check that buffer is bigger than the frame being transfered
+     * If bigger then transfer only whats left of frame
+     * Else, fill frame with all the content possible
+     */
+    if (rx_buf_len >= *left_frame) {
+        to_transfer = *left_frame;
+        *eof_transferred = true;
+    } else {
+        to_transfer = rx_buf_len;
+    }
+
+    /* write frame part to memory */
+    if (dma_memory_write(&address_space_memory, (uint64_t) rx_buf_addr,
+                         *frame_ptr, to_transfer, MEMTXATTRS_UNSPECIFIED)) {
+        return -1;
+    }
+
+    /* update frame pointer and size of whats left of frame */
+    *frame_ptr += to_transfer;
+    *left_frame -= to_transfer;
+    *transferred += to_transfer;
+
+    return 0;
+}
+
+static void gmac_dma_set_state(NPCMGMACState *gmac, int shift, uint32_t state)
+{
+    gmac->regs[R_NPCM_DMA_STATUS] = deposit32(gmac->regs[R_NPCM_DMA_STATUS],
+        shift, 3, state);
+}
+
 static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t len)
 {
-    /* Placeholder. Function will be filled in following patches */
-    return 0;
+    /*
+     * Comments have steps that relate to the
+     * receiving process steps in pg 386
+     */
+    NPCMGMACState *gmac = NPCM_GMAC(qemu_get_nic_opaque(nc));
+    uint32_t left_frame = len;
+    const uint8_t *frame_ptr = buf;
+    uint32_t desc_addr;
+    uint32_t rx_buf_len, rx_buf_addr;
+    struct NPCMGMACRxDesc rx_desc;
+    uint16_t transferred = 0;
+    bool eof_transferred = false;
+
+    trace_npcm_gmac_packet_receive(DEVICE(gmac)->canonical_path, len);
+    if (!gmac_can_receive(nc)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "GMAC Currently is not able for Rx");
+        return -1;
+    }
+    if (!gmac->regs[R_NPCM_DMA_HOST_RX_DESC]) {
+        gmac->regs[R_NPCM_DMA_HOST_RX_DESC] =
+            NPCM_DMA_HOST_RX_DESC_MASK(gmac->regs[R_NPCM_DMA_RX_BASE_ADDR]);
+    }
+    desc_addr = NPCM_DMA_HOST_RX_DESC_MASK(gmac->regs[R_NPCM_DMA_HOST_RX_DESC]);
+
+    /* step 1 */
+    gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
+        NPCM_DMA_STATUS_RX_RUNNING_FETCHING_STATE);
+    trace_npcm_gmac_packet_desc_read(DEVICE(gmac)->canonical_path, desc_addr);
+    if (gmac_read_rx_desc(desc_addr, &rx_desc)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "RX Descriptor @ 0x%x cant be read\n",
+                      desc_addr);
+        gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
+            NPCM_DMA_STATUS_RX_SUSPENDED_STATE);
+        return -1;
+    }
+
+    /* step 2 */
+    if (!(rx_desc.rdes0 & RX_DESC_RDES0_OWN)) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "RX Descriptor @ 0x%x is owned by software\n",
+                      desc_addr);
+        gmac->regs[R_NPCM_DMA_STATUS] |= NPCM_DMA_STATUS_RU;
+        gmac->regs[R_NPCM_DMA_STATUS] |= NPCM_DMA_STATUS_RI;
+        gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
+            NPCM_DMA_STATUS_RX_SUSPENDED_STATE);
+        gmac_update_irq(gmac);
+        return len;
+    }
+    /* step 3 */
+    /*
+     * TODO --
+     * Implement all frame filtering and processing (with its own interrupts)
+     */
+    trace_npcm_gmac_debug_desc_data(DEVICE(gmac)->canonical_path, &rx_desc,
+                                    rx_desc.rdes0, rx_desc.rdes1, rx_desc.rdes2,
+                                    rx_desc.rdes3);
+    /* Clear rdes0 for the incoming descriptor and set FS in first descriptor.*/
+    rx_desc.rdes0 = RX_DESC_RDES0_FIRST_DESC_MASK;
+
+    gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
+        NPCM_DMA_STATUS_RX_RUNNING_TRANSFERRING_STATE);
+
+    /* Pad the frame with FCS as the kernel driver will strip it away. */
+    left_frame += ETH_FCS_LEN;
+
+    /* repeat while we still have frame to transfer to memory */
+    while (!eof_transferred) {
+        /* Return descriptor no matter what happens */
+        rx_desc.rdes0 &= ~RX_DESC_RDES0_OWN;
+        /* Set the frame to be an IPv4/IPv6 frame. */
+        rx_desc.rdes0 |= RX_DESC_RDES0_FRM_TYPE_MASK;
+
+        /* step 4 */
+        rx_buf_len = RX_DESC_RDES1_BFFR1_SZ_MASK(rx_desc.rdes1);
+        rx_buf_addr = rx_desc.rdes2;
+        gmac->regs[R_NPCM_DMA_CUR_RX_BUF_ADDR] = rx_buf_addr;
+        gmac_rx_transfer_frame_to_buffer(rx_buf_len, &left_frame, rx_buf_addr,
+                                         &eof_transferred, &frame_ptr,
+                                         &transferred);
+
+        trace_npcm_gmac_packet_receiving_buffer(DEVICE(gmac)->canonical_path,
+                                                rx_buf_len, rx_buf_addr);
+        /* if we still have frame left and the second buffer is not chained */
+         if (!(rx_desc.rdes1 & RX_DESC_RDES1_SEC_ADDR_CHND_MASK) && \
+              !eof_transferred) {
+            /* repeat process from above on buffer 2 */
+            rx_buf_len = RX_DESC_RDES1_BFFR2_SZ_MASK(rx_desc.rdes1);
+            rx_buf_addr = rx_desc.rdes3;
+            gmac->regs[R_NPCM_DMA_CUR_RX_BUF_ADDR] = rx_buf_addr;
+            gmac_rx_transfer_frame_to_buffer(rx_buf_len, &left_frame,
+                                             rx_buf_addr, &eof_transferred,
+                                             &frame_ptr, &transferred);
+            trace_npcm_gmac_packet_receiving_buffer( \
+                                                DEVICE(gmac)->canonical_path,
+                                                rx_buf_len, rx_buf_addr);
+        }
+        /* update address for descriptor */
+        gmac->regs[R_NPCM_DMA_HOST_RX_DESC] = rx_buf_addr;
+        /* Return descriptor */
+        rx_desc.rdes0 &= ~RX_DESC_RDES0_OWN;
+        /* Update frame length transferred */
+        rx_desc.rdes0 |= ((uint32_t)transferred)
+            << RX_DESC_RDES0_FRAME_LEN_SHIFT;
+        trace_npcm_gmac_debug_desc_data(DEVICE(gmac)->canonical_path, &rx_desc,
+                                        rx_desc.rdes0, rx_desc.rdes1,
+                                        rx_desc.rdes2, rx_desc.rdes3);
+
+        /* step 5 */
+        gmac_write_rx_desc(desc_addr, &rx_desc);
+        trace_npcm_gmac_debug_desc_data(DEVICE(gmac)->canonical_path,
+                                        &rx_desc, rx_desc.rdes0,
+                                        rx_desc.rdes1, rx_desc.rdes2,
+                                        rx_desc.rdes3);
+        /* read new descriptor into rx_desc if needed*/
+        if (!eof_transferred) {
+            /* Get next descriptor address (chained or sequential) */
+            if (rx_desc.rdes1 & RX_DESC_RDES1_RC_END_RING_MASK) {
+                desc_addr = gmac->regs[R_NPCM_DMA_RX_BASE_ADDR];
+            } else if (rx_desc.rdes1 & RX_DESC_RDES1_SEC_ADDR_CHND_MASK) {
+                desc_addr = rx_desc.rdes3;
+            } else {
+                desc_addr += sizeof(rx_desc);
+            }
+            trace_npcm_gmac_packet_desc_read(DEVICE(gmac)->canonical_path,
+                                             desc_addr);
+            if (gmac_read_rx_desc(desc_addr, &rx_desc)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "RX Descriptor @ 0x%x cant be read\n",
+                              desc_addr);
+                gmac->regs[R_NPCM_DMA_STATUS] |= NPCM_DMA_STATUS_RU;
+                gmac_update_irq(gmac);
+                return len;
+            }
+
+            /* step 6 */
+            if (!(rx_desc.rdes0 & RX_DESC_RDES0_OWN)) {
+                if (!(gmac->regs[R_NPCM_DMA_CONTROL] & \
+                     NPCM_DMA_CONTROL_FLUSH_MASK)) {
+                    rx_desc.rdes0 |= RX_DESC_RDES0_DESC_ERR_MASK;
+                }
+                eof_transferred = true;
+            }
+            /* Clear rdes0 for the incoming descriptor */
+            rx_desc.rdes0 = 0;
+        }
+    }
+    gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
+        NPCM_DMA_STATUS_RX_RUNNING_CLOSING_STATE);
+
+    rx_desc.rdes0 |= RX_DESC_RDES0_LAST_DESC_MASK;
+    if (!(rx_desc.rdes1 & RX_DESC_RDES1_DIS_INTR_COMP_MASK)) {
+        gmac->regs[R_NPCM_DMA_STATUS] |= NPCM_DMA_STATUS_RI;
+        gmac_update_irq(gmac);
+    }
+    trace_npcm_gmac_debug_desc_data(DEVICE(gmac)->canonical_path, &rx_desc,
+                                    rx_desc.rdes0, rx_desc.rdes1, rx_desc.rdes2,
+                                    rx_desc.rdes3);
+
+    /* step 8 */
+    gmac->regs[R_NPCM_DMA_CONTROL] |= NPCM_DMA_CONTROL_FLUSH_MASK;
+
+    /* step 9 */
+    trace_npcm_gmac_packet_received(DEVICE(gmac)->canonical_path, left_frame);
+    gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
+        NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE);
+    gmac_write_rx_desc(desc_addr, &rx_desc);
+
+    /* Get next descriptor address (chained or sequential) */
+    if (rx_desc.rdes1 & RX_DESC_RDES1_RC_END_RING_MASK) {
+        desc_addr = gmac->regs[R_NPCM_DMA_RX_BASE_ADDR];
+    } else if (rx_desc.rdes1 & RX_DESC_RDES1_SEC_ADDR_CHND_MASK) {
+        desc_addr = rx_desc.rdes3;
+    } else {
+        desc_addr += sizeof(rx_desc);
+    }
+    gmac->regs[R_NPCM_DMA_HOST_RX_DESC] = desc_addr;
+    return len;
 }
 
 static void gmac_cleanup(NetClientState *nc)
@@ -303,6 +564,7 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
         break;
 
     case A_NPCM_GMAC_MAC_CONFIG:
+        gmac->regs[offset / sizeof(uint32_t)] = v;
         break;
 
     case A_NPCM_GMAC_MII_ADDR:
@@ -344,6 +606,8 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
 
     case A_NPCM_DMA_RCV_POLL_DEMAND:
         /* We dont actually care about the value */
+        gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
+            NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE);
         break;
 
     case A_NPCM_DMA_STATUS:
@@ -354,6 +618,14 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
                            HWADDR_PRIx ", value: 0x%04" PRIx64 "\n",
                            DEVICE(gmac)->canonical_path, offset, v);
         }
+        /* for W1C bits, implement W1C */
+        gmac->regs[offset / sizeof(uint32_t)] &= ~NPCM_DMA_STATUS_W1C_MASK(v);
+        if (v & NPCM_DMA_STATUS_RU) {
+            /* Clearing RU bit indicates descriptor is owned by DMA again. */
+            gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
+                NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE);
+            qemu_flush_queued_packets(qemu_get_queue(gmac->nic));
+        }
         break;
 
     default:
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 56057de47f3..f91b1a4a3de 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -474,6 +474,11 @@ npcm_gmac_mdio_access(const char *name, uint8_t is_write, uint8_t pa, uint8_t gr
 npcm_gmac_reset(const char *name, uint16_t value) "%s: phy_regs[0][1]: 0x%04" PRIx16
 npcm_gmac_set_link(bool active) "Set link: active=%u"
 npcm_gmac_update_irq(const char *name, uint32_t status, uint32_t intr_en, int level) "%s: Status Reg: 0x%04" PRIX32 " Interrupt Enable Reg: 0x%04" PRIX32 " IRQ Set: %d"
+npcm_gmac_packet_desc_read(const char* name, uint32_t desc_addr) "%s: attempting to read descriptor @0x%04" PRIX32
+npcm_gmac_packet_receive(const char* name, uint32_t len) "%s: RX packet length: 0x%04" PRIX32
+npcm_gmac_packet_receiving_buffer(const char* name, uint32_t buf_len, uint32_t rx_buf_addr) "%s: Receiving into Buffer size: 0x%04" PRIX32 " at address 0x%04" PRIX32
+npcm_gmac_packet_received(const char* name, uint32_t len) "%s: Reception finished, packet left: 0x%04" PRIX32
+npcm_gmac_debug_desc_data(const char* name, void* addr, uint32_t des0, uint32_t des1, uint32_t des2, uint32_t des3)"%s: Address: %p Descriptor 0: 0x%04" PRIX32 " Descriptor 1: 0x%04" PRIX32 "Descriptor 2: 0x%04" PRIX32 " Descriptor 3: 0x%04" PRIX32
 
 # npcm_pcs.c
 npcm_pcs_reg_read(const char *name, uint16_t indirect_access_baes, uint64_t offset, uint16_t value) "%s: IND: 0x%02" PRIx16 " offset: 0x%04" PRIx64 " value: 0x%04" PRIx16
-- 
2.34.1



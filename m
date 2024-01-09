Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5BF827BD8
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 01:05:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMzaA-0002Tm-7j; Mon, 08 Jan 2024 19:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Ko2cZQwKCukYLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com>)
 id 1rMza6-0002Rz-Hj
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 19:02:58 -0500
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Ko2cZQwKCukYLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com>)
 id 1rMza2-0002ue-Ds
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 19:02:58 -0500
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-28d532578a4so938123a91.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 16:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704758571; x=1705363371; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=LOS6q1SJdxqKZ9FJ53NTYlogRPhSbx+e3UkIQY3RVmw=;
 b=koGERpS1abywxU2nIqgsciNXoKlSyV1dV37o6tRAHYiFKbglbIyFpKMl/sjzNGoRtg
 SZGmXE+BNHfbFlpqCjwsWdT7qex6xcGsGIQfYADXwpCl60SPCWB0Bmwe5eTsV0dq/jbY
 Ow0P/KY6+ik0aP429F2DUrdcLOZ9Oc3HPJsQX/ghfaYu2KYK1S+E347KeSfKRplZvASG
 +hSI14MO+L13lRbKqMpVXf9WCuR59ZXEGLHuHbL/TsrpWHjtsYoyxD1SZ2diKREsBixR
 +Cjg4qyXOlTByJlG9ZHri/pqLFIfkX7n7zStkP7wYyKfrMEHmGJdulYPDSxGbbgUrFRP
 /L2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704758571; x=1705363371;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LOS6q1SJdxqKZ9FJ53NTYlogRPhSbx+e3UkIQY3RVmw=;
 b=qtKRAOPhUigDke+PC3xxlWb6BFKkJCPxW1b65jjtk0Lgz15GyfMAWIydkE8w3SJpWA
 /SD/105E4T2KVhatcpUaNFMB9KuiR4RmJoGrGzgw34qyNNSfBgaJ/B0B/N8EyJrXhdYX
 zELbSobJTwwRN4Q1gETwkYrJJrvU7M0TU3nOJLZYK8aogifwOIhw/+wwU/ZSl1vlF4bV
 Mr8amjEKLchqz4kaRbzNXDqdXxugo4SorraCe0P65oX0SFY8iH40JLniqGv9eeR/3bY8
 AL0iv4mxE3db3y5t6UkukcSGs9FqXfAy2xMgVvu3JfJA4mfWqzMfI48SFPPg4Mo99uUz
 gCfw==
X-Gm-Message-State: AOJu0Yxe3/8iieN/oxLsm27/AhgYfLps5IRf0E0ivFdAZToKhSsJdaJG
 cHMKKbpKmrXQIp7yWQVw/+3vrqWIH5O8WT3b6nVNTTNHfQ==
X-Google-Smtp-Source: AGHT+IF9mV5yxWN42oZ65uOThU1ixlK/+E9WAofGUolKS1Nw+qtAxkgPiBulhp7M1SG18zBslFy4CA7yus0JwTLNW0M=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a17:90a:6843:b0:28d:2946:982e with
 SMTP id e3-20020a17090a684300b0028d2946982emr430287pjm.2.1704758570772; Mon,
 08 Jan 2024 16:02:50 -0800 (PST)
Date: Tue,  9 Jan 2024 00:02:32 +0000
In-Reply-To: <20240109000234.2799153-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20240109000234.2799153-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240109000234.2799153-9-nabihestefan@google.com>
Subject: [PATCH v11 08/10] hw/net: GMAC Rx Implementation
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasowang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3Ko2cZQwKCukYLMTSPdePQLYRZZRWP.NZXbPXf-OPgPWYZYRYf.ZcR@flex--nabihestefan.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

When RX descriptor list is full, it returns a DMA_STATUS for
software to handle it. But there's no way to indicate the software has
handled all RX descriptors and the whole pipeline stalls.

We do something similar to NPCM7XX EMC to handle this case.

1. Return packet size when RX descriptor is full, effectively dropping
these packets in such a case.
2. When software clears RX descriptor full bit, continue receiving
further packets by flushing QEMU packet queue.

Added relevant trace-events

Change-Id: I132aa254a94cda1a586aba2ea33bbfc74ecdb831
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
---
 hw/net/npcm_gmac.c  | 479 +++++++++++++++++++++++++++++++++++++++++++-
 hw/net/trace-events |   5 +
 2 files changed, 482 insertions(+), 2 deletions(-)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 44c4ffaff4..c107e835b1 100644
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
 
@@ -189,12 +204,438 @@ static void gmac_update_irq(NPCMGMACState *gmac)
     qemu_set_irq(gmac->irq, level);
 }
 
-static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t len)
+static int gmac_read_rx_desc(dma_addr_t addr, struct NPCMGMACRxDesc *desc)
 {
-    /* Placeholder. Function will be filled in following patches */
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
     return 0;
 }
 
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
+static int gmac_read_tx_desc(dma_addr_t addr, struct NPCMGMACTxDesc *desc)
+{
+    if (dma_memory_read(&address_space_memory, addr, desc,
+                        sizeof(*desc), MEMTXATTRS_UNSPECIFIED)) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Failed to read descriptor @ 0x%"
+                      HWADDR_PRIx "\n", __func__, addr);
+        return -1;
+    }
+    desc->tdes0 = le32_to_cpu(desc->tdes0);
+    desc->tdes1 = le32_to_cpu(desc->tdes1);
+    desc->tdes2 = le32_to_cpu(desc->tdes2);
+    desc->tdes3 = le32_to_cpu(desc->tdes3);
+    return 0;
+}
+
+static int gmac_write_tx_desc(dma_addr_t addr, struct NPCMGMACTxDesc *desc)
+{
+    struct NPCMGMACTxDesc le_desc;
+    le_desc.tdes0 = cpu_to_le32(desc->tdes0);
+    le_desc.tdes1 = cpu_to_le32(desc->tdes1);
+    le_desc.tdes2 = cpu_to_le32(desc->tdes2);
+    le_desc.tdes3 = cpu_to_le32(desc->tdes3);
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
+static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t len)
+{
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
+}
+
+static int gmac_tx_get_csum(uint32_t tdes1)
+{
+    uint32_t mask = TX_DESC_TDES1_CHKSM_INS_CTRL_MASK(tdes1);
+    int csum = 0;
+
+    if (likely(mask > 0)) {
+        csum |= CSUM_IP;
+    }
+    if (likely(mask > 1)) {
+        csum |= CSUM_TCP | CSUM_UDP;
+    }
+
+    return csum;
+}
+
+static void gmac_try_send_next_packet(NPCMGMACState *gmac)
+{
+    /*
+     * Comments about steps refer to steps for
+     * transmitting in page 384 of datasheet
+     */
+    uint16_t tx_buffer_size = 2048;
+    g_autofree uint8_t *tx_send_buffer = g_malloc(tx_buffer_size);
+    uint32_t desc_addr;
+    struct NPCMGMACTxDesc tx_desc;
+    uint32_t tx_buf_addr, tx_buf_len;
+    uint16_t length = 0;
+    uint8_t *buf = tx_send_buffer;
+    uint32_t prev_buf_size = 0;
+    int csum = 0;
+
+    /* steps 1&2 */
+    if (!gmac->regs[R_NPCM_DMA_HOST_TX_DESC]) {
+        gmac->regs[R_NPCM_DMA_HOST_TX_DESC] =
+            NPCM_DMA_HOST_TX_DESC_MASK(gmac->regs[R_NPCM_DMA_TX_BASE_ADDR]);
+    }
+    desc_addr = gmac->regs[R_NPCM_DMA_HOST_TX_DESC];
+
+    while (true) {
+        gmac_dma_set_state(gmac, NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT,
+            NPCM_DMA_STATUS_TX_RUNNING_FETCHING_STATE);
+        if (gmac_read_tx_desc(desc_addr, &tx_desc)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "TX Descriptor @ 0x%x can't be read\n",
+                          desc_addr);
+            return;
+        }
+        /* step 3 */
+
+        trace_npcm_gmac_packet_desc_read(DEVICE(gmac)->canonical_path,
+            desc_addr);
+        trace_npcm_gmac_debug_desc_data(DEVICE(gmac)->canonical_path, &tx_desc,
+            tx_desc.tdes0, tx_desc.tdes1, tx_desc.tdes2, tx_desc.tdes3);
+
+        /* 1 = DMA Owned, 0 = Software Owned */
+        if (!(tx_desc.tdes0 & TX_DESC_TDES0_OWN)) {
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "TX Descriptor @ 0x%x is owned by software\n",
+                          desc_addr);
+            gmac->regs[R_NPCM_DMA_STATUS] |= NPCM_DMA_STATUS_TU;
+            gmac_dma_set_state(gmac, NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT,
+                NPCM_DMA_STATUS_TX_SUSPENDED_STATE);
+            gmac_update_irq(gmac);
+            return;
+        }
+
+        gmac_dma_set_state(gmac, NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT,
+            NPCM_DMA_STATUS_TX_RUNNING_READ_STATE);
+        /* Give the descriptor back regardless of what happens. */
+        tx_desc.tdes0 &= ~TX_DESC_TDES0_OWN;
+
+        if (tx_desc.tdes1 & TX_DESC_TDES1_FIRST_SEG_MASK) {
+            csum = gmac_tx_get_csum(tx_desc.tdes1);
+        }
+
+        /* step 4 */
+        tx_buf_addr = tx_desc.tdes2;
+        gmac->regs[R_NPCM_DMA_CUR_TX_BUF_ADDR] = tx_buf_addr;
+        tx_buf_len = TX_DESC_TDES1_BFFR1_SZ_MASK(tx_desc.tdes1);
+        buf = &tx_send_buffer[prev_buf_size];
+
+        if ((prev_buf_size + tx_buf_len) > sizeof(buf)) {
+            tx_buffer_size = prev_buf_size + tx_buf_len;
+            tx_send_buffer = g_realloc(tx_send_buffer, tx_buffer_size);
+            buf = &tx_send_buffer[prev_buf_size];
+        }
+
+        /* step 5 */
+        if (dma_memory_read(&address_space_memory, tx_buf_addr, buf,
+                            tx_buf_len, MEMTXATTRS_UNSPECIFIED)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: Failed to read packet @ 0x%x\n",
+                        __func__, tx_buf_addr);
+            return;
+        }
+        length += tx_buf_len;
+        prev_buf_size += tx_buf_len;
+
+        /* If not chained we'll have a second buffer. */
+        if (!(tx_desc.tdes1 & TX_DESC_TDES1_SEC_ADDR_CHND_MASK)) {
+            tx_buf_addr = tx_desc.tdes3;
+            gmac->regs[R_NPCM_DMA_CUR_TX_BUF_ADDR] = tx_buf_addr;
+            tx_buf_len = TX_DESC_TDES1_BFFR2_SZ_MASK(tx_desc.tdes1);
+            buf = &tx_send_buffer[prev_buf_size];
+
+            if ((prev_buf_size + tx_buf_len) > sizeof(buf)) {
+                tx_buffer_size = prev_buf_size + tx_buf_len;
+                tx_send_buffer = g_realloc(tx_send_buffer, tx_buffer_size);
+                buf = &tx_send_buffer[prev_buf_size];
+            }
+
+            if (dma_memory_read(&address_space_memory, tx_buf_addr, buf,
+                                tx_buf_len, MEMTXATTRS_UNSPECIFIED)) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "%s: Failed to read packet @ 0x%x\n",
+                              __func__, tx_buf_addr);
+                return;
+            }
+            length += tx_buf_len;
+            prev_buf_size += tx_buf_len;
+        }
+        if (tx_desc.tdes1 & TX_DESC_TDES1_LAST_SEG_MASK) {
+            net_checksum_calculate(tx_send_buffer, length, csum);
+            qemu_send_packet(qemu_get_queue(gmac->nic), tx_send_buffer, length);
+            trace_npcm_gmac_packet_sent(DEVICE(gmac)->canonical_path, length);
+            buf = tx_send_buffer;
+            length = 0;
+        }
+
+        /* step 6 */
+        gmac_dma_set_state(gmac, NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT,
+            NPCM_DMA_STATUS_TX_RUNNING_CLOSING_STATE);
+        gmac_write_tx_desc(desc_addr, &tx_desc);
+        if (tx_desc.tdes1 & TX_DESC_TDES1_TX_END_RING_MASK) {
+            desc_addr = gmac->regs[R_NPCM_DMA_TX_BASE_ADDR];
+        } else if (tx_desc.tdes1 & TX_DESC_TDES1_SEC_ADDR_CHND_MASK) {
+            desc_addr = tx_desc.tdes3;
+        } else {
+            desc_addr += sizeof(tx_desc);
+        }
+        gmac->regs[R_NPCM_DMA_HOST_TX_DESC] = desc_addr;
+
+        /* step 7 */
+        if (tx_desc.tdes1 & TX_DESC_TDES1_INTERR_COMP_MASK) {
+            gmac->regs[R_NPCM_DMA_STATUS] |= NPCM_DMA_STATUS_TI;
+            gmac_update_irq(gmac);
+        }
+    }
+}
+
 static void gmac_cleanup(NetClientState *nc)
 {
     /* Nothing to do yet. */
@@ -303,6 +744,7 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
         break;
 
     case A_NPCM_GMAC_MAC_CONFIG:
+        gmac->regs[offset / sizeof(uint32_t)] = v;
         break;
 
     case A_NPCM_GMAC_MII_ADDR:
@@ -344,6 +786,31 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
 
     case A_NPCM_DMA_RCV_POLL_DEMAND:
         /* We dont actually care about the value */
+        gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
+            NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE);
+        break;
+
+    case A_NPCM_DMA_XMT_POLL_DEMAND:
+        /* We dont actually care about the value */
+        gmac_try_send_next_packet(gmac);
+        break;
+
+    case A_NPCM_DMA_CONTROL:
+        gmac->regs[offset / sizeof(uint32_t)] = v;
+        if (v & NPCM_DMA_CONTROL_START_STOP_TX) {
+            gmac_try_send_next_packet(gmac);
+        } else {
+            gmac_dma_set_state(gmac, NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT,
+                NPCM_DMA_STATUS_TX_STOPPED_STATE);
+        }
+        if (v & NPCM_DMA_CONTROL_START_STOP_RX) {
+            gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
+                NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE);
+            qemu_flush_queued_packets(qemu_get_queue(gmac->nic));
+        } else {
+            gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
+                NPCM_DMA_STATUS_RX_STOPPED_STATE);
+        }
         break;
 
     case A_NPCM_DMA_STATUS:
@@ -354,6 +821,14 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
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
index 56057de47f..f91b1a4a3d 100644
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
2.43.0.472.g3155946c3a-goog



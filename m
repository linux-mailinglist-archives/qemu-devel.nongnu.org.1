Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF5E7CCA72
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:14:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsoYD-00051y-NY; Tue, 17 Oct 2023 14:12:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3fM4uZQwKCgUsfgnmjxyjkfslttlqj.htrvjrz-ij0jqstslsz.twl@flex--nabihestefan.bounces.google.com>)
 id 1qsoYC-00051O-6N
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:12:16 -0400
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3fM4uZQwKCgUsfgnmjxyjkfslttlqj.htrvjrz-ij0jqstslsz.twl@flex--nabihestefan.bounces.google.com>)
 id 1qsoY9-0006z3-HR
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 14:12:15 -0400
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5a507eb61a6so87557467b3.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697566332; x=1698171132; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5Vk4eklH/LLriEgz+hsJb2bKAxyBL8z8XdUZ0yxnuI=;
 b=ScYb8D7YXl3VTEvkwcURn1uAtQeQkp7s+iLLzfHFOK1/HYxnXATFTwivEJpHQszk0L
 FNpiFki0wjelJvAfNjxAE/2oADCRq2WHYYufqtff6y+Df68eCDa5Am9+bEp+PB73CcCR
 6i4S4KBQ4WQ6WIQRE5PBuNVXVXe/inGt9EHN6+YJVw4AliGQHvam34y2erTQnjL/1xZa
 mp2jAz6tMZ1mtxZbpGqrP83nisGkUl7w/nnPQutv8wPPjGxEz6D6gwRO5MSl7hjw/AIV
 owotuXArjIE3PJffObYCT45jOhYhM/N/4r7sOB3T8WFWBQJMt1nSiR6dDdtpbu0a8yOh
 QISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697566332; x=1698171132;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z5Vk4eklH/LLriEgz+hsJb2bKAxyBL8z8XdUZ0yxnuI=;
 b=tqwbdzogyZm/keOp1ziFgwAhQdrAuYWdP8dhob81affQ43Wvpi0pOWXPoVdYJubmMM
 ZsP1zlDDVAe3e6YwJCtMucVb1HOJBSQAj2gYkKU1GjMN0//0/cqSOR4nL9IFzOD18ywO
 M3SZmVAhez8/kQM9B918vtHxPg+hkJ6Gp8uPhC1iMUpiyF1VVriC8bo7p/PCrW5UQo2Q
 JBogFYLD/32+ZtepXJatdeMDm0HVpcavgMcBl1freA6uBjH1Duy6Y4oWV+mfWOC1xhSp
 3MmzlpHChA6iH+Jx3zZ37tApgV54S8PYn/rYrzeQgaB3hmXOfHdHhVZEwC95+12Aaygk
 LzAg==
X-Gm-Message-State: AOJu0Yytv022Gc5Q/GrgSCR8EcLkSMUiccTU6F5DShGZkvrpMEtxneXP
 dUKDUauoZUxhhE+bBX1n4rk4ksfl9h7achDiOmY=
X-Google-Smtp-Source: AGHT+IGOLQ/9P9ne00KWFUF72zKPypMkC3EapZdXmiKs9wHDs0yhfneXIV1luJ7/Vb3NsqqDDTH2VkE/nWWRrQv+Tf4=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a81:5213:0:b0:592:83d2:1f86 with SMTP
 id g19-20020a815213000000b0059283d21f86mr65113ywb.4.1697566332277; Tue, 17
 Oct 2023 11:12:12 -0700 (PDT)
Date: Tue, 17 Oct 2023 18:11:50 +0000
In-Reply-To: <20231017181152.201887-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20231017181152.201887-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231017181152.201887-10-nabihestefan@google.com>
Subject: [PATCH 09/11] hw/net: GMAC Rx Implementation
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 Nabih Estefan Diaz <nabihestefan@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3fM4uZQwKCgUsfgnmjxyjkfslttlqj.htrvjrz-ij0jqstslsz.twl@flex--nabihestefan.bounces.google.com;
 helo=mail-yw1-x1149.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

NOTE: At this point in development we believe this function is working
as intended, and the kernel supports these findings, but we need the
Transmit function to work before we upload

Signed-off-by: Nabih Estefan Diaz <nabihestefan@google.com>

hw/net: npcm_gmac Flush queued packets when starting RX

When RX starts, we need to flush the queued packets so that they
can be received by the GMAC device. Without this it won't work
with TAP NIC device.

Signed-off-by: Hao Wu <wuhaotsh@google.com>

hw/net: Handle RX desc full in NPCM GMAC

When RX descriptor list is full, it returns a DMA_STATUS for software to handle it. But there's no way to indicate the software ha handled all RX descriptors and the whole pipeline stalls.

We do something similar to NPCM7XX EMC to handle this case.

1. Return packet size when RX descriptor is full, effectively dropping these packets in such a case.
2. When software clears RX descriptor full bit, continue receiving further packets by flushing QEMU packet queue.

Signed-off-by: Hao Wu <wuhaotsh@google.com>

hw/net: Receive and drop packets when descriptors are full in GMAC

Effectively this allows QEMU to receive and drop incoming packets when
RX descriptors are full. Similar to EMC, this lets GMAC to drop packets
faster, especially during bootup sequence.

Signed-off-by: Hao Wu <wuhaotsh@google.com>

hw/net: Update frame_ptr during gmac_receive

There was a bug that frame_ptr wasn't updated after receiving
the first batch of data, causing the received data to be wrong
when the frame is too large.

Signed-off-by: Hao Wu <wuhaotsh@google.com>

hw/net: Fix GMAC not detecting owned by software properly in RX

RX should stop receiving when a descriptor is owned by software
but currently implementation made it reversed (owned by DMA) instead.

Signed-off-by: Hao Wu <wuhaotsh@google.com>

hw/net: Fix GMAC receive problem

Fix the following 2 problems in GMAC receive function:

1. When kernel driver disables GMAC RX interrupt and all descriptors
    are full, it will not send further interrupt to the kernel
    driver as the driver doesn't listen to NPCM_DMA_STATUS_RU.
    Since descriptors full indicates that there are packets received
    we should also set NPCM_DMA_STATUS_RI for firing the interrupt.
2. Kernel driver does not clear rdes0 from used descriptor so we need
    to clear it such that old flags are removed before setting new
    flags.

Signed-off-by: Hao Wu <wuhaotsh@google.com>
---
 hw/net/npcm_gmac.c         | 356 ++++++++++++++++++++++++++++++++++---
 include/hw/net/npcm_gmac.h |  28 +--
 2 files changed, 342 insertions(+), 42 deletions(-)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 6f8109e0ee..a7c8b67223 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -23,7 +23,11 @@
 #include "hw/registerfields.h"
 #include "hw/net/mii.h"
 #include "hw/net/npcm_gmac.h"
+#include "linux/if_ether.h"
 #include "migration/vmstate.h"
+#include "net/checksum.h"
+#include "net/net.h"
+#include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "qemu/units.h"
 #include "sysemu/dma.h"
@@ -91,7 +95,6 @@ REG32(NPCM_GMAC_PTP_TTSR, 0x71c)
 #define NPCM_DMA_BUS_MODE_SWR               BIT(0)
 
 static const uint32_t npcm_gmac_cold_reset_values[NPCM_GMAC_NR_REGS] = {
-    /* Reduce version to 3.2 so that the kernel can enable interrupt. */
     [R_NPCM_GMAC_VERSION]         = 0x00001032,
     [R_NPCM_GMAC_TIMER_CTRL]      = 0x03e80000,
     [R_NPCM_GMAC_MAC0_ADDR_HI]    = 0x8000ffff,
@@ -146,6 +149,17 @@ static void gmac_phy_set_link(NPCMGMACState *s, bool active)
 
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
 
@@ -191,11 +205,288 @@ static void gmac_update_irq(NPCMGMACState *gmac)
     qemu_set_irq(gmac->irq, level);
 }
 
-static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t len)
+static int gmac_read_rx_desc(dma_addr_t addr, struct NPCMGMACRxDesc *desc)
 {
-    /* Placeholder */
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
     return 0;
 }
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
+                         *frame_ptr, to_transfer, MEMTXATTRS_UNSPECIFIED))
+    {
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
 static void gmac_cleanup(NetClientState *nc)
 {
     /* Nothing to do yet. */
@@ -281,7 +572,6 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
                               uint64_t v, unsigned size)
 {
     NPCMGMACState *gmac = opaque;
-    uint32_t prev;
 
     trace_npcm_gmac_reg_write(DEVICE(gmac)->canonical_path, offset, v);
 
@@ -305,22 +595,7 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
         break;
 
     case A_NPCM_GMAC_MAC_CONFIG:
-        prev = gmac->regs[offset / sizeof(uint32_t)];
         gmac->regs[offset / sizeof(uint32_t)] = v;
-
-        /* If transmit is being enabled for first time, update desc addr */
-        if (~(prev & NPCM_GMAC_MAC_CONFIG_TX_EN) &
-             (v & NPCM_GMAC_MAC_CONFIG_TX_EN)) {
-            gmac->regs[R_NPCM_DMA_HOST_TX_DESC] =
-                gmac->regs[R_NPCM_DMA_TX_BASE_ADDR];
-        }
-
-        /* If receive is being enabled for first time, update desc addr */
-        if (~(prev & NPCM_GMAC_MAC_CONFIG_RX_EN) &
-             (v & NPCM_GMAC_MAC_CONFIG_RX_EN)) {
-            gmac->regs[R_NPCM_DMA_HOST_RX_DESC] =
-                gmac->regs[R_NPCM_DMA_RX_BASE_ADDR];
-        }
         break;
 
     case A_NPCM_GMAC_MII_ADDR:
@@ -362,6 +637,31 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
 
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
@@ -371,16 +671,14 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
                           "%s: Write of read-only bits of reg: offset: 0x%04"
                            HWADDR_PRIx ", value: 0x%04" PRIx64 "\n",
                            DEVICE(gmac)->canonical_path, offset, v);
-        } else {
-            /* for W1c bits, implement W1C */
-            gmac->regs[offset / sizeof(uint32_t)] &=
-                ~NPCM_DMA_STATUS_W1C_MASK(v);
-            if (v & NPCM_DMA_STATUS_NIS_BITS) {
-                gmac->regs[offset / sizeof(uint32_t)] &= ~NPCM_DMA_STATUS_NIS;
-            }
-            if (v & NPCM_DMA_STATUS_AIS_BITS) {
-                gmac->regs[offset / sizeof(uint32_t)] &= ~NPCM_DMA_STATUS_AIS;
-            }
+        }
+        /* for W1C bits, implement W1C */
+        gmac->regs[offset / sizeof(uint32_t)] &= ~NPCM_DMA_STATUS_W1C_MASK(v);
+        if (v & NPCM_DMA_STATUS_RU) {
+            /* Clearing RU bit indicates descriptor is owned by DMA again. */
+            gmac_dma_set_state(gmac, NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT,
+                NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE);
+            qemu_flush_queued_packets(qemu_get_queue(gmac->nic));
         }
         break;
 
diff --git a/include/hw/net/npcm_gmac.h b/include/hw/net/npcm_gmac.h
index c97eb6fe6e..d0a37e6988 100644
--- a/include/hw/net/npcm_gmac.h
+++ b/include/hw/net/npcm_gmac.h
@@ -136,7 +136,7 @@ struct NPCMGMACTxDesc {
 #define TX_DESC_TDES1_INTERR_COMP_MASK BIT(31)
 /* Last Segment */
 #define TX_DESC_TDES1_LAST_SEG_MASK BIT(30)
-/* Last Segment */
+/* First Segment */
 #define TX_DESC_TDES1_FIRST_SEG_MASK BIT(29)
 /* Checksum Insertion Control */
 #define TX_DESC_TDES1_CHKSM_INS_CTRL_MASK(word) extract32(word, 27, 2)
@@ -176,32 +176,32 @@ OBJECT_DECLARE_SIMPLE_TYPE(NPCMGMACState, NPCM_GMAC)
 #define NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT 20
 /* Transmit States */
 #define NPCM_DMA_STATUS_TX_STOPPED_STATE \
-    (0b000 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
+    (0b000)
 #define NPCM_DMA_STATUS_TX_RUNNING_FETCHING_STATE \
-    (0b001 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
+    (0b001)
 #define NPCM_DMA_STATUS_TX_RUNNING_WAITING_STATE \
-    (0b010 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
+    (0b010)
 #define NPCM_DMA_STATUS_TX_RUNNING_READ_STATE \
-    (0b011 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
+    (0b011)
 #define NPCM_DMA_STATUS_TX_SUSPENDED_STATE \
-    (0b110 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
+    (0b110)
 #define NPCM_DMA_STATUS_TX_RUNNING_CLOSING_STATE \
-    (0b111 << NPCM_DMA_STATUS_TX_PROCESS_STATE_SHIFT)
+    (0b111)
 /* Transmit Process State */
 #define NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT 17
 /* Receive States */
 #define NPCM_DMA_STATUS_RX_STOPPED_STATE \
-    (0b000 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
+    (0b000)
 #define NPCM_DMA_STATUS_RX_RUNNING_FETCHING_STATE \
-    (0b001 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
+    (0b001)
 #define NPCM_DMA_STATUS_RX_RUNNING_WAITING_STATE \
-    (0b011 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
+    (0b011)
 #define NPCM_DMA_STATUS_RX_SUSPENDED_STATE \
-    (0b100 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
+    (0b100)
 #define NPCM_DMA_STATUS_RX_RUNNING_CLOSING_STATE \
-    (0b101 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
+    (0b101)
 #define NPCM_DMA_STATUS_RX_RUNNING_TRANSFERRING_STATE \
-    (0b111 << NPCM_DMA_STATUS_RX_PROCESS_STATE_SHIFT)
+    (0b111)
 
 
 /* Early Receive Interrupt */
@@ -302,6 +302,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(NPCMGMACState, NPCM_GMAC)
 #define NPCM_DMA_CONTROL_FLUSH_MASK BIT(24)
 /* Start/stop Transmit */
 #define NPCM_DMA_CONTROL_START_STOP_TX BIT(13)
+/* Start/stop Receive */
+#define NPCM_DMA_CONTROL_START_STOP_RX BIT(1)
 /* Next receive descriptor start address */
 #define NPCM_DMA_HOST_RX_DESC_MASK(word) ((uint32_t) (word) & ~3u)
 /* Next transmit descriptor start address */
-- 
2.42.0.655.g421f12c284-goog



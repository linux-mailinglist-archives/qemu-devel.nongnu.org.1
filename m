Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E59A180D4B7
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 18:54:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCkTP-0004GI-DO; Mon, 11 Dec 2023 12:53:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3YEx3ZQwKCgkwjkrqn12nojwpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--nabihestefan.bounces.google.com>)
 id 1rCkSV-0003K1-71
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:52:49 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3YEx3ZQwKCgkwjkrqn12nojwpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--nabihestefan.bounces.google.com>)
 id 1rCkSI-0000Zf-2i
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:52:44 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-dbc1f00dc35so5339646276.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 09:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702317153; x=1702921953; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=hxyvqahpMNrgn5pY5vvgs/nMosvZmPq6YYkO852M0v4=;
 b=aEhLqCLW3CcfU8oLvSbMYK0poRmWlj53DIYcOB8JQD8D4zcxneyo/aXE01LWhHwpiq
 NsjBkYLb8cXakiijHOEFhKI09rIWw9wDtLMXX2w75Vxc7a9irCAIQUQgAukNtiU62yjV
 yA0cw/vtg0RuhU5VXhDpxUj5WTVy2TtmR4PSmvgMhHtsIjt5bvY3w6WBpREvYhr7cMT9
 fwXGgWSHutnJWPsasaA6esC1N5uVNAjRDJ6LCOlB3j8trALdNbPJWuyUVY1VQhc29WSY
 PuzOokCbltwKSWLnLM05Kx5FYyPdyaXskfEjqB3zdsxihiGxI97MpEtPnAiZ+Jo4p6kd
 FUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317153; x=1702921953;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hxyvqahpMNrgn5pY5vvgs/nMosvZmPq6YYkO852M0v4=;
 b=TphYLCHh2zEyAK764d8fjjZJmtTXfvRChLk/8Re0Dm0vi42rxexY/UsYr92ECikDTz
 fMhsNW5lOP0Xa3yFUPqryIFr6qQ9IKTQRJ/bN3fM2GytFnjSzBlZZ2seJF147YgV6U33
 At+UrCVUWnt/Go8UCcSeJjqqZ5fl8Gvrr/nz78uBMeJtzru2i+C5lX9Z8FeSz6yBoOk7
 v1IT4qB5zTuLCe9LRN7zxLdpG/IoAs2SpCNS52EgGUyG7PRwkjCE43PiRJJOUQ9Bq0Zg
 oV8fqpHN7AcrVM59yomYWRwpXXvJFIeCcg6x8DMnCDnGpujQ15NuC9owwozIACroFEzO
 Se8A==
X-Gm-Message-State: AOJu0Yz3biR4+ELFV3MNMYwsb5rI6sIqTz/36NnpLYmk7CtME6atr3Qm
 xMu1R0HNx9DASvCb9TWMcLep9F4no6Sq8EhJUi8=
X-Google-Smtp-Source: AGHT+IGE90Ou1HR30lxWC5HGR/vfiSOj7S4d5lx/DpzsE1/f6y75PFi5dAXzByzQ0zUhabe5soMm0/Jew2/pUNAgn8c=
X-Received: from nabihestefan.c.googlers.com
 ([fda3:e722:ac3:cc00:20:ed76:c0a8:2737])
 (user=nabihestefan job=sendgmr) by 2002:a5b:783:0:b0:db5:4766:e363 with SMTP
 id b3-20020a5b0783000000b00db54766e363mr34871ybq.6.1702317152850; Mon, 11 Dec
 2023 09:52:32 -0800 (PST)
Date: Mon, 11 Dec 2023 17:52:12 +0000
In-Reply-To: <20231211175215.3216667-1-nabihestefan@google.com>
Mime-Version: 1.0
References: <20231211175215.3216667-1-nabihestefan@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231211175215.3216667-10-nabihestefan@google.com>
Subject: [PATCH v7 09/11] hw/net: GMAC Rx Implementation
From: Nabih Estefan <nabihestefan@google.com>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, kfting@nuvoton.com, 
 wuhaotsh@google.com, jasonwang@redhat.com, avi.fishman@nuvoton.com, 
 nabihestefan@google.com, kwliu@nuvoton.com, tomer.maimon@nuvoton.com, 
 Hila.Miranda-Kuzi@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3YEx3ZQwKCgkwjkrqn12nojwpxxpun.lxvznv3-mn4nuwxwpw3.x0p@flex--nabihestefan.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

When RX descriptor list is full, it returns a DMA_STATUS for software to handle it. But there's no way to indicate the software ha handled all RX descriptors and the whole pipeline stalls.

We do something similar to NPCM7XX EMC to handle this case.

1. Return packet size when RX descriptor is full, effectively dropping these packets in such a case.
2. When software clears RX descriptor full bit, continue receiving further packets by flushing QEMU packet queue.

Change-Id: I53dd4169272d7c3e990fb17261014c2cd2a881d9
Signed-off-by: Hao Wu <wuhaotsh@google.com>
Signed-off-by: Nabih Estefan <nabihestefan@google.com>
Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
---
 hw/net/npcm_gmac.c         | 331 ++++++++++++++++++++++++++++++++++++-
 include/hw/net/npcm_gmac.h |  28 ++--
 2 files changed, 343 insertions(+), 16 deletions(-)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 220955346c..cd59ca5fd4 100644
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
@@ -146,6 +150,17 @@ static void gmac_phy_set_link(NPCMGMACState *s, bool active)
 
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
 
@@ -191,11 +206,288 @@ static void gmac_update_irq(NPCMGMACState *gmac)
     qemu_set_irq(gmac->irq, level);
 }
 
-static ssize_t gmac_receive(NetClientState *nc, const uint8_t *buf, size_t len)
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
 {
-    /* Placeholder */
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
@@ -281,7 +573,6 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
                               uint64_t v, unsigned size)
 {
     NPCMGMACState *gmac = opaque;
-    uint32_t prev;
 
     trace_npcm_gmac_reg_write(DEVICE(gmac)->canonical_path, offset, v);
 
@@ -305,6 +596,7 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
         break;
 
     case A_NPCM_GMAC_MAC_CONFIG:
+        gmac->regs[offset / sizeof(uint32_t)] = v;
         break;
 
     case A_NPCM_GMAC_MII_ADDR:
@@ -346,6 +638,31 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
 
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
@@ -356,6 +673,14 @@ static void npcm_gmac_write(void *opaque, hwaddr offset,
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
2.43.0.472.g3155946c3a-goog



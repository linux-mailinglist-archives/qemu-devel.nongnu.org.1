Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E29E5809951
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 03:36:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBQgb-0006oU-59; Thu, 07 Dec 2023 21:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQgX-0006YF-QX; Thu, 07 Dec 2023 21:33:49 -0500
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rBQgU-0002ea-9K; Thu, 07 Dec 2023 21:33:49 -0500
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ca02def690so18916721fa.3; 
 Thu, 07 Dec 2023 18:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702002823; x=1702607623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B9Nhv49pbU7bZ8mzot2h9NoKamHuW2o0gQPpPceL6vk=;
 b=Zhx1/D6JS9LMmH51RNbXVVJY937U3oBLH0ODWCImYUMrtr2TmQk7N3asCNOg+lD/Hl
 iEzQz/8HmOYiPCnsMg828mDOqhS7baSCiwCsRNeqJrCGZJF6C4gjABwA4qfnmG7RvAaI
 VocCpnxBN1ZKiy9STI2jF71SEokFatBRvyem/YGCnIHage6UlFJzKAb8b7gM3s3/LC9a
 DF9L0002z+gasIiNgmx2Bt4+bteHVoUVrNAAuzvhYigJYdpR5lJZAeStYf7f1+0o/W/c
 Yex2kGSrVtjDbUeRblgnKiYoZAthH1/R8Eot4OH1rzKMZ8RqKWEHs0SXgROtIGxkH5/k
 qAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702002823; x=1702607623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B9Nhv49pbU7bZ8mzot2h9NoKamHuW2o0gQPpPceL6vk=;
 b=D0DYpzCIgfVl5asvVTDizv2r06YGGxlvsUdSO4T6mRiT7T1GXr8uo+CWm8IcJzd+qB
 Fq8WEGvviYFSHIco7re7wqNFuJnt8E1TraCbFro5ZXgreoCw0eAlGFQPMumyb98N7Uj5
 xuYQiYuba5qbo5tPO/z+b7sukIybJ2P1V3VPBU0lFcAwwXbi1hQq0DCutfpbBAcB73LJ
 reFXWPineUcNyq7GIUCndcDN28LOYb2kKgUW+5gD1UfOCbAk52Ddf4ZUimUHSQ/MYWUi
 +oSAI+JRpFBGGdqhjnb0pDLnZ2UItGnrfUAe9ifSkTs2Iq8kTE/nYAosEQYubjXYpMnG
 e/Nw==
X-Gm-Message-State: AOJu0YwhOm8ncrdIf/HIQZ1Q8YqvYQCERr+FAO4owqig4/zw8in5G9HR
 3TN41hpKx5hFOiZiAQm1SvPa5Md6fddjwg==
X-Google-Smtp-Source: AGHT+IGQR0FYjgmY+GV3jmrmjjo8AkEFNkUpaGELIXMR/WRikIJ6VDTtuI5ma+DlfHihPeKix8JLnA==
X-Received: by 2002:a2e:9cd5:0:b0:2c9:f727:7e65 with SMTP id
 g21-20020a2e9cd5000000b002c9f7277e65mr2077161ljj.38.1702002823401; 
 Thu, 07 Dec 2023 18:33:43 -0800 (PST)
Received: from localhost.localdomain ([185.200.240.39])
 by smtp.gmail.com with ESMTPSA id
 r1-20020a2e94c1000000b002c9e6cbf78esm99062ljh.19.2023.12.07.18.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Dec 2023 18:33:42 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v4 31/45] Implement GENET RX path
Date: Thu,  7 Dec 2023 20:31:31 -0600
Message-Id: <20231208023145.1385775-32-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=serg.oker@gmail.com; helo=mail-lj1-x230.google.com
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/net/bcm2838_genet.c         | 265 ++++++++++++++++++++++++++++++++-
 include/hw/net/bcm2838_genet.h |   1 +
 2 files changed, 265 insertions(+), 1 deletion(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 4c9b39a3ca..61c1981e10 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -511,6 +511,25 @@ static bool bcm2838_genet_tdma_ring_active(BCM2838GenetState *s,
     return active;
 }
 
+static bool bcm2838_genet_rdma_ring_active(BCM2838GenetState *s,
+                                           unsigned int ring_index)
+{
+    uint32_t ring_mask = 1 << ring_index;
+
+    bool dma_en = FIELD_EX32(s->regs.rdma.ctrl, GENET_DMA_CTRL, EN) != 0;
+    bool ring_en = (FIELD_EX32(s->regs.rdma.ring_cfg, GENET_DMA_RING_CFG, EN)
+                    & ring_mask) != 0;
+    bool ring_buf_en = (FIELD_EX32(s->regs.rdma.ctrl,
+                                   GENET_DMA_CTRL, RING_BUF_EN)
+                        & ring_mask) != 0;
+    bool active = dma_en && ring_en && ring_buf_en;
+
+    trace_bcm2838_genet_rx_dma_ring_active(ring_index,
+                                           active ? "active" : "halted");
+
+    return active;
+}
+
 static void bcm2838_genet_tdma(BCM2838GenetState *s, hwaddr offset,
                                uint64_t value)
 {
@@ -721,9 +740,251 @@ static const MemoryRegionOps bcm2838_genet_ops = {
     .valid = {.min_access_size = 4},
 };
 
+static int32_t bcm2838_genet_filter(BCM2838GenetState *s, const void *buf,
+                                    size_t size)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "Packet filtration with HFB isn't implemented yet");
+    return -1;
+}
+
+static int32_t bcm2838_genet_filter2ring(BCM2838GenetState *s,
+                                         uint32_t filter_idx)
+{
+    qemu_log_mask(LOG_UNIMP,
+                  "Packet filtration with HFB isn't implemented yet");
+    return -1;
+}
+
+static bool is_packet_broadcast(const uint8_t *buf, size_t size)
+{
+    static const uint8_t bcst_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
+
+    if (size < sizeof(bcst_addr)) {
+        return false;
+    }
+
+    return !memcmp(buf, bcst_addr, sizeof(bcst_addr));
+}
+
+static bool is_packet_multicast(const uint8_t *buf, size_t size)
+{
+    return !!(buf[0] & 0x01);
+}
+
+static ssize_t bcm2838_genet_rdma(BCM2838GenetState *s, uint32_t ring_idx,
+                                  const void *buf, size_t size)
+{
+    const size_t DESC_WORD_SIZE =
+        sizeof(BCM2838GenetRdmaDesc) / sizeof(uint32_t);
+
+    ssize_t len = 0;
+    BCM2838GenetRegsRdma *rdma = &s->regs.rdma;
+    BCM2838GenetRdmaRing *ring = &rdma->rings[ring_idx];
+    hwaddr write_index =
+        (ring->write_ptr + ((hwaddr)ring->write_ptr_hi << 32)) / DESC_WORD_SIZE;
+    BCM2838GenetRdmaDesc *desc = &rdma->descs[write_index];
+
+    const hwaddr START_INDEX =
+        (ring->start_addr + ((hwaddr)ring->start_addr_hi << 32))
+            / DESC_WORD_SIZE;
+    const hwaddr END_INDEX =
+        (ring->end_addr + ((hwaddr)ring->end_addr_hi << 32)) / DESC_WORD_SIZE;
+
+    if (!bcm2838_genet_rdma_ring_active(s, ring_idx)) {
+        return -1;
+    }
+
+    desc->length_status = FIELD_DP32(desc->length_status,
+                                     GENET_RDMA_LENGTH_STATUS, SOP, 1);
+
+    while (len < size) {
+        size_t l = size - len;
+        size_t buf_size = ring->ring_buf_size & 0xffff;
+        uint8_t *dma_buf = s->rx_packet;
+        hwaddr dma_buf_addr =
+            desc->address_lo + ((hwaddr)desc->address_hi << 32);
+        MemTxResult mem_tx_result = MEMTX_OK;
+        uint8_t *frame_buf = dma_buf + sizeof(BCM2838GenetXmitStatus) + 2;
+        BCM2838GenetXmitStatus *xmit_status = (BCM2838GenetXmitStatus *)dma_buf;
+        struct iovec iov;
+        bool isip4, isip6;
+        size_t l3hdr_off, l4hdr_off, l5hdr_off;
+        eth_ip6_hdr_info ip6hdr_info;
+        eth_ip4_hdr_info ip4hdr_info;
+        eth_l4_hdr_info  l4hdr_info;
+
+        bool crc_fwd = FIELD_EX32(s->regs.umac.cmd, GENET_UMAC_CMD, CRC_FWD);
+        size_t buflength;
+        uint32_t prod_index;
+
+        if (l > ring->ring_buf_size) {
+            l = ring->ring_buf_size;
+        }
+
+        memcpy(frame_buf, buf + len, l);
+        iov.iov_base = frame_buf;
+        iov.iov_len = l;
+        eth_get_protocols(&iov, 1, 0,
+                          &isip4, &isip6,
+                          &l3hdr_off, &l4hdr_off, &l5hdr_off,
+                          &ip6hdr_info, &ip4hdr_info, &l4hdr_info);
+
+        len += l;
+
+        desc->length_status = FIELD_DP32(desc->length_status,
+                                         GENET_RDMA_LENGTH_STATUS,
+                                         EOP, !!(len >= size));
+
+        buflength = l + sizeof(BCM2838GenetXmitStatus) + 2;
+        if (crc_fwd) {
+            buflength += 4;
+        }
+
+        desc->length_status = FIELD_DP32(desc->length_status,
+                                         GENET_RDMA_LENGTH_STATUS,
+                                         BUFLENGTH, buflength);
+
+        desc->length_status = FIELD_DP32(desc->length_status,
+                                         GENET_RDMA_LENGTH_STATUS,
+                                         BROADCAST,
+                                         !!is_packet_broadcast(frame_buf, l));
+        desc->length_status = FIELD_DP32(desc->length_status,
+                                         GENET_RDMA_LENGTH_STATUS,
+                                         MULTICAST,
+                                         !!is_packet_multicast(frame_buf, l));
+
+        xmit_status->rx_csum = 0;
+        if (isip4) {
+            xmit_status->rx_csum = ip4hdr_info.ip4_hdr.ip_sum;
+        }
+        xmit_status->length_status = desc->length_status;
+
+        mem_tx_result = address_space_write(&s->dma_as, dma_buf_addr,
+                                            MEMTXATTRS_UNSPECIFIED,
+                                            dma_buf, buf_size);
+        if (mem_tx_result != MEMTX_OK) {
+            desc->length_status = FIELD_DP32(desc->length_status,
+                                             GENET_RDMA_LENGTH_STATUS,
+                                             RXERR, 1);
+        }
+
+        if (FIELD_EX32(desc->length_status,
+                       GENET_RDMA_LENGTH_STATUS, RXERR) != 0) {
+            break;
+        }
+
+        prod_index = FIELD_EX32(ring->prod_index, GENET_DMA_PROD_INDEX, INDEX);
+        ring->prod_index = FIELD_DP32(ring->prod_index,
+                                      GENET_DMA_PROD_INDEX,
+                                      INDEX, ++prod_index);
+        if (++write_index > END_INDEX) {
+            write_index = START_INDEX;
+        }
+        desc = &rdma->descs[write_index];
+        ring->write_ptr = write_index * DESC_WORD_SIZE;
+        ring->write_ptr_hi = ((hwaddr)write_index * DESC_WORD_SIZE) >> 32;
+    }
+
+    if (ring_idx == BCM2838_GENET_DMA_RING_DEFAULT) {
+        s->regs.intrl0.stat = FIELD_DP32(s->regs.intrl0.stat,
+                                         GENET_INTRL_0, RXDMA_MBDONE, 1);
+    } else {
+        uint32_t rx_intrs =
+            FIELD_EX32(s->regs.intrl1.stat, GENET_INTRL_1, RX_INTRS);
+        rx_intrs |= 1 << ring_idx;
+
+        s->regs.intrl1.stat = FIELD_DP32(s->regs.intrl1.stat,
+                                         GENET_INTRL_1, RX_INTRS, rx_intrs);
+    }
+
+    return len;
+}
+
+static ssize_t bcm2838_genet_receive(NetClientState *nc, const uint8_t *buf,
+                                     size_t size)
+{
+    BCM2838GenetState *s = (BCM2838GenetState *)qemu_get_nic_opaque(nc);
+    ssize_t bytes_received = -1;
+    int32_t filter_index = -1;
+    int32_t ring_index = -1;
+
+    if (FIELD_EX32(s->regs.rdma.ctrl, GENET_DMA_CTRL, EN) != 0) {
+        filter_index = bcm2838_genet_filter(s, buf, size);
+
+        if (filter_index >= 0) {
+            ring_index = bcm2838_genet_filter2ring(s, filter_index);
+        } else {
+            ring_index = BCM2838_GENET_DMA_RING_CNT - 1;
+        }
+
+        if (size <= MAX_PACKET_SIZE) {
+            bytes_received = bcm2838_genet_rdma(s, ring_index, buf, size);
+        }
+    }
+
+    bcm2838_genet_set_irq_default(s);
+    bcm2838_genet_set_irq_prio(s);
+
+    return bytes_received;
+}
+
+static void bcm2838_genet_phy_update_link(BCM2838GenetState *s)
+{
+    bool qemu_link_down = qemu_get_queue(s->nic)->link_down != 0;
+
+    bool lstatus = FIELD_EX32(s->phy_regs.bmsr, GENET_PHY_BMSR, LSTATUS) != 0;
+
+    if (qemu_link_down && lstatus) {
+        trace_bcm2838_genet_phy_update_link("down");
+
+        s->phy_regs.bmsr = FIELD_DP32(s->phy_regs.bmsr,
+                                      GENET_PHY_BMSR, ANEGCOMPLETE, 0);
+        s->phy_regs.bmsr = FIELD_DP32(s->phy_regs.bmsr,
+                                      GENET_PHY_BMSR, LSTATUS, 0);
+        s->regs.intrl0.stat = FIELD_DP32(s->regs.intrl0.stat,
+                                         GENET_INTRL_0, LINK_DOWN, 1);
+    } else if (!qemu_link_down && !lstatus) {
+        trace_bcm2838_genet_phy_update_link("up");
+
+        /*
+         * Complete auto-negotiation (fixed link partner's abilities for now:
+         * 1Gbps with flow control)
+         */
+        s->phy_regs.stat1000 = FIELD_DP32(s->phy_regs.stat1000,
+                                          GENET_PHY_STAT_1000, HALF, 1);
+        s->phy_regs.stat1000 = FIELD_DP32(s->phy_regs.stat1000,
+                                          GENET_PHY_STAT_1000, FULL, 1);
+
+        s->phy_regs.lpa = FIELD_DP32(s->phy_regs.lpa,
+                                     GENET_PHY_LPA, PAUSE_CAP, 1);
+        s->phy_regs.lpa = FIELD_DP32(s->phy_regs.lpa,
+                                     GENET_PHY_LPA, PAUSE_ASYM, 1);
+        s->phy_regs.lpa = FIELD_DP32(s->phy_regs.lpa, GENET_PHY_LPA, LPACK, 1);
+
+        s->phy_regs.bmsr = FIELD_DP32(s->phy_regs.bmsr,
+                                      GENET_PHY_BMSR, ANEGCOMPLETE, 1);
+        s->phy_regs.bmsr = FIELD_DP32(s->phy_regs.bmsr,
+                                      GENET_PHY_BMSR, LSTATUS, 1);
+
+        s->regs.intrl0.stat = FIELD_DP32(s->regs.intrl0.stat,
+                                         GENET_INTRL_0, LINK_UP, 1);
+    }
+
+    bcm2838_genet_set_irq_default(s);
+}
+static void bcm2838_genet_set_link(NetClientState *nc)
+{
+    BCM2838GenetState *s = qemu_get_nic_opaque(nc);
+
+    bcm2838_genet_phy_update_link(s);
+}
+
 static NetClientInfo bcm2838_genet_client_info = {
     .type = NET_CLIENT_DRIVER_NIC,
-    .size = sizeof(NICState)
+    .size = sizeof(NICState),
+    .receive = bcm2838_genet_receive,
+    .link_status_changed = bcm2838_genet_set_link,
 };
 
 static void bcm2838_genet_realize(DeviceState *dev, Error **errp)
@@ -777,6 +1038,8 @@ static void bcm2838_genet_phy_reset(BCM2838GenetState *s)
     s->phy_aux_ctl_shd_regs.misc = 0x1E;
 
     trace_bcm2838_genet_phy_reset("done");
+
+    bcm2838_genet_phy_update_link(s);
 }
 
 static void bcm2838_genet_reset(DeviceState *d)
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index f96ea3a145..f044d0d17e 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -420,6 +420,7 @@ struct BCM2838GenetState {
     qemu_irq irq_prio;
 
     uint8_t tx_packet[MAX_FRAME_SIZE];
+    uint8_t rx_packet[MAX_FRAME_SIZE];
 };
 
 #endif /* BCM2838_GENET_H */
-- 
2.34.1



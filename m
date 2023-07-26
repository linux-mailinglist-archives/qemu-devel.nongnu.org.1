Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B6B763858
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:07:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeX0-0003By-EH; Wed, 26 Jul 2023 09:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWk-0002vN-Cb; Wed, 26 Jul 2023 09:26:07 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWe-0003Pc-Sw; Wed, 26 Jul 2023 09:26:04 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4fe0d5f719dso1787928e87.2; 
 Wed, 26 Jul 2023 06:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377957; x=1690982757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMoLRrEeP6GlGwybUlQhvlY7X2S+PocFu4C8n4ArlZc=;
 b=U3PNjKp5S3bnGbOX1XHBxBHmIDdOJn5bh5RNTnPEzVXOtgX5IFSeKKiIm6vRBK0nQs
 2C2jF5he+BA1Wn/fVBGcKebO15Hi+TxFuzDBb91/mwChftuGwg6sbVDp7tSQYgSPaQxN
 YXCwWbb2qj+J0m9/v1Hv+kyC3kEFOwb5v5B80dEHidcEBzw2sbKgYB/nRjF7kdFf4KDo
 ktgA6L/fX2ha1MPiLzO0bSZhy1IIbiEwPHP1dP8cBpZNOwE+tacxJymQXExKvWXOpZS9
 zmIix3OIoDlSUvTVSTBHRkPfvo+NjhI0ell6znkl34njXbsQNgDw1iRD/fwdFdmnPEA5
 +OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377957; x=1690982757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XMoLRrEeP6GlGwybUlQhvlY7X2S+PocFu4C8n4ArlZc=;
 b=ZbgOF/CemjC50m3lArks76fCwv6mA9vNTDNDWkRA1YkepHC0aL9iV8WRb2tExhAYZr
 6PIeJ0JSwSqtS1pAk4mDoBfAcdfB983IufJi++qkcmu44HkvYA3QaUVq42nzTYKfI3DD
 ZnGN2E6O99RuqT+XzlLB/IC8oaS5N/cIhVB1/HiyMv6wMKJkkE5fp1a7aC1k0CGmy6qk
 pi/p8QDPH8hRsR/yCmnhT6LIIW1F6WXsAj+/U4QPT2sbPA1+kJ/EIx2rJwNub9IP4szK
 YQgnBpDFPe92ZXs0EGw9Ch3Y7zBeS9C/jGHgz9xD+a7tKaw7hN3pTZY9BC5GfPk+i374
 Dy6w==
X-Gm-Message-State: ABy/qLa0TcWpO9yMboZEfOKhZIWoM2BszNBN/oyILfNId760qB6OtAW0
 TbY54OrCP4xeX21v9uJv3x+KbvzQPy8=
X-Google-Smtp-Source: APBJJlFZAUvK3dU1UQ6wFImVV2AVwaxe9GIbjaMei8RpdJYueZwPBcP53ZEmONpDARGtiLLzB49UDg==
X-Received: by 2002:ac2:52a6:0:b0:4fb:911b:4e19 with SMTP id
 r6-20020ac252a6000000b004fb911b4e19mr1311212lfm.35.1690377956683; 
 Wed, 26 Jul 2023 06:25:56 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:56 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 31/44] Impl GENET RX path
Date: Wed, 26 Jul 2023 16:24:59 +0300
Message-Id: <20230726132512.149618-32-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x12a.google.com
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
 hw/net/bcm2838_genet.c         | 222 ++++++++++++++++++++++++++++++++-
 include/hw/net/bcm2838_genet.h |   1 +
 2 files changed, 222 insertions(+), 1 deletion(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index 98030216f4..0686cb5002 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -251,6 +251,21 @@ static bool bcm2838_genet_tdma_ring_active(BCM2838GenetState *s,
     return active;
 }
 
+static bool bcm2838_genet_rdma_ring_active(BCM2838GenetState *s,
+                                           unsigned int ring_index)
+{
+    uint32_t ring_mask = 1 << ring_index;
+    bool dma_en = s->regs.rdma.ctrl.fields.en == 1;
+    bool ring_en = (s->regs.rdma.ring_cfg.fields.en & ring_mask) != 0;
+    bool ring_buf_en = (s->regs.rdma.ctrl.fields.ring_buf_en & ring_mask) != 0;
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
@@ -434,9 +449,212 @@ static const MemoryRegionOps bcm2838_genet_ops = {
     .valid = {.min_access_size = sizeof(uint32_t)},
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
+    desc->length_status.fields.sop = 1;
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
+        desc->length_status.fields.eop = !!(len >= size);
+        desc->length_status.fields.buflength = l
+            + sizeof(BCM2838GenetXmitStatus) + 2;
+        if (s->regs.umac.cmd.fields.crc_fwd) {
+            desc->length_status.fields.buflength += 4;
+        }
+        desc->length_status.fields.broadcast =
+            !!is_packet_broadcast(frame_buf, l);
+        desc->length_status.fields.multicast =
+            !!is_packet_multicast(frame_buf, l);
+
+        xmit_status->rx_csum = 0;
+        if (isip4) {
+            xmit_status->rx_csum = ip4hdr_info.ip4_hdr.ip_sum;
+        }
+        xmit_status->length_status = desc->length_status.value;
+
+        mem_tx_result = address_space_write(&s->dma_as, dma_buf_addr,
+                                            MEMTXATTRS_UNSPECIFIED,
+                                            dma_buf, buf_size);
+        if (mem_tx_result != MEMTX_OK) {
+            desc->length_status.fields.rxerr = 1;
+        }
+
+        if (desc->length_status.fields.rxerr) {
+            break;
+        }
+
+        ++ring->prod_index.fields.index;
+        if (++write_index > END_INDEX) {
+            write_index = START_INDEX;
+        }
+        desc = &rdma->descs[write_index];
+        ring->write_ptr = write_index * DESC_WORD_SIZE;
+        ring->write_ptr_hi = ((hwaddr)write_index * DESC_WORD_SIZE) >> 32;
+    }
+
+    if (ring_idx == BCM2838_GENET_DMA_RING_DEFAULT) {
+        s->regs.intrl0.stat.fields.rxdma_mbdone = 1;
+    } else {
+        s->regs.intrl1.stat.fields.rx_intrs |= 1 << ring_idx;
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
+    if (s->regs.rdma.ctrl.fields.en) {
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
+    if (qemu_link_down && s->phy_regs.bmsr.fields.lstatus == 1) {
+        trace_bcm2838_genet_phy_update_link("down");
+
+        s->phy_regs.bmsr.fields.anegcomplete = 0;
+
+        s->phy_regs.bmsr.fields.lstatus = 0;
+        s->regs.intrl0.stat.fields.link_down = 1;
+    } else if (!qemu_link_down && s->phy_regs.bmsr.fields.lstatus == 0) {
+        trace_bcm2838_genet_phy_update_link("up");
+
+        /*
+         * Complete auto-negotiation (fixed link partner's abilities for now:
+         * 1Gbps with flow control)
+         */
+        s->phy_regs.stat1000.fields._1000half = 1;
+        s->phy_regs.stat1000.fields._1000full = 1;
+
+        s->phy_regs.lpa.fields.pause_cap = 1;
+        s->phy_regs.lpa.fields.pause_asym = 1;
+        s->phy_regs.lpa.fields.lpack = 1;
+
+        s->phy_regs.bmsr.fields.anegcomplete = 1;
+
+        s->phy_regs.bmsr.fields.lstatus = 1;
+        s->regs.intrl0.stat.fields.link_up = 1;
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
@@ -489,6 +707,8 @@ static void bcm2838_genet_phy_reset(BCM2838GenetState *s)
     s->phy_aux_ctl_shd_regs.misc = 0x1E;
 
     trace_bcm2838_genet_phy_reset("done");
+
+    bcm2838_genet_phy_update_link(s);
 }
 
 static void bcm2838_genet_reset(DeviceState *d)
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 7fbe4d3ea5..8bcf560f87 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -726,6 +726,7 @@ struct BCM2838GenetState {
     qemu_irq irq_prio;
 
     uint8_t tx_packet[MAX_FRAME_SIZE];
+    uint8_t rx_packet[MAX_FRAME_SIZE];
 };
 
 #endif /* BCM2838_GENET_H */
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E48577638E4
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 16:18:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOeWw-00038S-Fe; Wed, 26 Jul 2023 09:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWk-0002vG-73; Wed, 26 Jul 2023 09:26:07 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1qOeWc-0003P9-PC; Wed, 26 Jul 2023 09:26:01 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4fb73ba3b5dso10769535e87.1; 
 Wed, 26 Jul 2023 06:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690377956; x=1690982756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+e0XkIaPGL7X+jqKcKymgJuXTNREg5bu7d7MRYJ6vU=;
 b=fHNR2GxRe9VEP37B+WUWn4llLGvK4u4jpG/CJuGAFWjERKwWMktiG2aoLGNAVAItuo
 y08K/YBzPZOmAs2KnzQYaPh9AEaPtOqWIB/svw0/ZVz1AMSN07G7Uzg4mszCa8S4fbSN
 /jgAF7zs5iubRK4St66YAl4k7hbINB3BAMkHlVTvCES7359UjuqwU+LVx0Ike3ojFmMO
 4NXRCOZM8zfRTJH3+1KQGhrbXhK/9Mu7yGp2kfsGT2s6wwd+qw4IjBrlN5+SrPPlULU/
 aig6VqruRIZFqfs20VOTU8SCsK1V064w/7sD74Vr3LNzyxtsbdNNXrXUr7mdkqNyanrd
 21AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690377956; x=1690982756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+e0XkIaPGL7X+jqKcKymgJuXTNREg5bu7d7MRYJ6vU=;
 b=JFI9xKDTbSbnM9YeG0CskS5nzzemzgGv/y1dXvV4Vd4gW35QkjYfLyFtIQkpjvirO8
 E5I+FAWCT4vowu6bQY1FfX7JHBvYjSV5BADYgkskJ5Lv+Fs30tk1Wge8M45/5RNvo1MK
 fW22n7fGcsWl8/CWljVei4fhIhkx5CdWTYdbCSUEHNzeyNfRSUJN0F2+bbOn+QDEdsHG
 glFCNOFZrFX+hekGUjy94cjQ4tY8xInnABNcw3t05p0KHQuq1eRENuksZ9tXE2GGjppt
 b2QktU3SzYl5wFjqFMWwux5xgri8vpSu0E4MaklyHbx0mCmZerqQJEEIUWtFV0d6fwIU
 I19Q==
X-Gm-Message-State: ABy/qLZ/JbDj1cu6FBv++iOkomMh9q5CMgt8z9HQ64wgZcL2C0V8U+hb
 c+Kx/PVkbj8aOp8JFMRYJ2VjvZm3+6M=
X-Google-Smtp-Source: APBJJlGPz6/0BY4IgZTOUAO/8r9zXoG0NEJ9KX7sW3tZeq496763ORkgBZA+6EBdsxB1Lt2cFVkiKw==
X-Received: by 2002:a19:ae10:0:b0:4fe:cc0:340 with SMTP id
 f16-20020a19ae10000000b004fe0cc00340mr1236420lfc.60.1690377955611; 
 Wed, 26 Jul 2023 06:25:55 -0700 (PDT)
Received: from sergevik-thinkpad.localdomain ([213.197.136.186])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a19f516000000b004fe0c3d8bb4sm565079lfb.84.2023.07.26.06.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 06:25:55 -0700 (PDT)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH 30/44] Impl GENET TX path
Date: Wed, 26 Jul 2023 16:24:58 +0300
Message-Id: <20230726132512.149618-31-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=serg.oker@gmail.com; helo=mail-lf1-x133.google.com
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
 hw/net/bcm2838_genet.c         | 170 ++++++++++++++++++++++++++++++++-
 include/hw/net/bcm2838_genet.h |  26 +++++
 2 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
index e633323d17..98030216f4 100644
--- a/hw/net/bcm2838_genet.c
+++ b/hw/net/bcm2838_genet.c
@@ -149,6 +149,174 @@ static uint64_t bcm2838_genet_mdio_cmd(BCM2838GenetState *s, uint64_t cmd)
     return umac_mdio_cmd.value;
 }
 
+static void bcm2838_genet_xmit_packet(NetClientState *s, void *packet,
+                                      size_t size)
+{
+    uint8_t *buf = packet + sizeof(BCM2838GenetXmitStatus);
+    size_t len = size;
+    uint16_t len_type = 0;
+
+    len -= sizeof(BCM2838GenetXmitStatus);
+    net_checksum_calculate(buf, len, CSUM_ALL);
+
+    memcpy(&len_type, &buf[12], sizeof(len_type));
+    len_type = ntohs(len_type);
+    if (len_type < MAX_PAYLOAD_SIZE) {
+        len_type = len;
+        len_type = htons(len_type);
+        memcpy(&buf[12], &len_type, sizeof(len_type));
+    }
+
+    qemu_send_packet(s, buf, len);
+}
+
+static uint64_t bcm2838_genet_tx(BCM2838GenetState *s, unsigned int ring_index,
+                                 BCM2838GenetDmaProdIndex prod_index,
+                                 BCM2838GenetDmaConsIndex cons_index)
+{
+    const unsigned int DESC_SIZE_WORDS
+        = sizeof(BCM2838GenetTdmaDesc) / sizeof(uint32_t);
+    const uint64_t RING_START_ADDR
+        = ((uint64_t)s->regs.tdma.rings[ring_index].start_addr_hi << 32)
+            + s->regs.tdma.rings[ring_index].start_addr;
+    const uint64_t RING_END_ADDR
+        = ((uint64_t)s->regs.tdma.rings[ring_index].end_addr_hi << 32)
+            + s->regs.tdma.rings[ring_index].end_addr;
+
+    hwaddr data_addr;
+    uint64_t desc_index;
+    BCM2838GenetTdmaLengthStatus desc_status;
+    uint64_t num_descs = 0;
+    uint64_t read_ptr
+        = ((uint64_t)s->regs.tdma.rings[ring_index].read_ptr_hi << 32)
+            + s->regs.tdma.rings[ring_index].read_ptr;
+    off_t packet_off = 0;
+
+    while (cons_index.fields.index != prod_index.fields.index) {
+        desc_index = read_ptr / DESC_SIZE_WORDS;
+        if (desc_index >= BCM2838_GENET_DMA_DESC_CNT) {
+            qemu_log_mask(
+                LOG_GUEST_ERROR,
+                "%s: invalid TX descriptor index %" PRIu64 " (exceeds %u)\n",
+                __func__, desc_index, BCM2838_GENET_DMA_DESC_CNT - 1);
+            break;
+        }
+        desc_status.value = s->regs.tdma.descs[desc_index].length_status.value;
+        data_addr = ((uint64_t)s->regs.tdma.descs[desc_index].address_hi << 32)
+            + s->regs.tdma.descs[desc_index].address_lo;
+        trace_bcm2838_genet_tx(ring_index, desc_index, desc_status.value,
+                               data_addr);
+
+        if (desc_status.fields.sop) {
+            packet_off = 0;
+        }
+
+        /* TODO: Add address_space_read() return value check */
+        address_space_read(&s->dma_as, data_addr,
+                                        MEMTXATTRS_UNSPECIFIED,
+                                        s->tx_packet + packet_off,
+                                        desc_status.fields.buflength);
+        packet_off += desc_status.fields.buflength;
+
+        if (desc_status.fields.eop) {
+            bcm2838_genet_xmit_packet(qemu_get_queue(s->nic), s->tx_packet,
+                                                     packet_off);
+            packet_off = 0;
+        }
+
+        num_descs++;
+        cons_index.fields.index++;
+        s->regs.tdma.descs[desc_index].length_status.fields.own = 1;
+        read_ptr = read_ptr == RING_END_ADDR + 1 - DESC_SIZE_WORDS
+            ? RING_START_ADDR : read_ptr + DESC_SIZE_WORDS;
+    }
+
+    s->regs.tdma.rings[ring_index].read_ptr = read_ptr;
+    s->regs.tdma.rings[ring_index].read_ptr_hi = read_ptr >> 32;
+
+    return num_descs;
+}
+
+static bool bcm2838_genet_tdma_ring_active(BCM2838GenetState *s,
+                                           unsigned int ring_index)
+{
+    uint32_t ring_mask = 1 << ring_index;
+    bool dma_en = s->regs.tdma.ctrl.fields.en == 1;
+    bool ring_en = (s->regs.tdma.ring_cfg.fields.en & ring_mask) != 0;
+    bool ring_buf_en = (s->regs.tdma.ctrl.fields.ring_buf_en & ring_mask) != 0;
+    bool active = dma_en && ring_en && ring_buf_en;
+
+    trace_bcm2838_genet_tx_dma_ring_active(ring_index,
+                                           active ? "active" : "halted");
+    return active;
+}
+
+static void bcm2838_genet_tdma(BCM2838GenetState *s, hwaddr offset,
+                               uint64_t value)
+{
+    hwaddr ring_offset;
+    uint64_t num_descs_tx;
+    unsigned int ring_index;
+    BCM2838GenetDmaConsIndex cons_index;
+    BCM2838GenetDmaRingCfg ring_cfg = {.value = value};
+    BCM2838GenetDmaCtrl ctrl = {.value = value};
+    BCM2838GenetDmaProdIndex prod_index = {.value = value};
+
+    switch (offset) {
+    case BCM2838_GENET_TDMA_RINGS
+        ... BCM2838_GENET_TDMA_RINGS + sizeof(s->regs.tdma.rings) - 1:
+        ring_index = (offset - BCM2838_GENET_TDMA_RINGS)
+            / sizeof(BCM2838GenetTdmaRing);
+        if (bcm2838_genet_tdma_ring_active(s, ring_index)) {
+            ring_offset = offset - BCM2838_GENET_TDMA_RINGS
+                - ring_index * sizeof(BCM2838GenetTdmaRing);
+            switch (ring_offset) {
+            case BCM2838_GENET_TRING_PROD_INDEX:
+                cons_index.value
+                    = s->regs.tdma.rings[ring_index].cons_index.value;
+                if (cons_index.fields.index != prod_index.fields.index) {
+                    trace_bcm2838_genet_tx_request(ring_index,
+                                                   prod_index.fields.index,
+                                                   cons_index.fields.index);
+                    num_descs_tx = bcm2838_genet_tx(s, ring_index, prod_index,
+                                                    cons_index);
+                    if (num_descs_tx > 0) {
+                        s->regs.tdma.rings[ring_index].cons_index.fields.index
+                            += num_descs_tx;
+                        if (ring_index == BCM2838_GENET_DMA_RING_DEFAULT) {
+                            s->regs.intrl0.stat.fields.txdma_mbdone = 1;
+                        } else {
+                            s->regs.intrl1.stat.fields.tx_intrs
+                                |= 1 << ring_index;
+                        }
+                    }
+                }
+                break;
+            default:
+                break;
+            }
+        }
+        break;
+    case BCM2838_GENET_TDMA_RING_CFG:
+        if (s->regs.tdma.ring_cfg.fields.en != ring_cfg.fields.en) {
+            trace_bcm2838_genet_tx_dma_ring(ring_cfg.fields.en);
+        }
+        break;
+    case BCM2838_GENET_TDMA_CTRL:
+        if (s->regs.tdma.ctrl.fields.en != ctrl.fields.en) {
+            s->regs.tdma.status.fields.disabled = s->regs.tdma.ctrl.fields.en;
+            trace_bcm2838_genet_tx_dma(
+                ctrl.fields.en == 1 ? "enabled" : "disabled");
+        }
+        if (s->regs.tdma.ctrl.fields.ring_buf_en != ctrl.fields.ring_buf_en) {
+            trace_bcm2838_genet_tx_dma_ring_buf(ctrl.fields.ring_buf_en);
+        }
+        break;
+    default:
+        break;
+    }
+}
+
 static uint64_t bcm2838_genet_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint64_t value = ~0;
@@ -241,7 +409,7 @@ static void bcm2838_genet_write(void *opaque, hwaddr offset, uint64_t value,
             break;
         case BCM2838_GENET_TDMA_REGS
             ... BCM2838_GENET_TDMA_REGS + sizeof(BCM2838GenetRegsTdma) - 1:
-            qemu_log_mask(LOG_UNIMP, "TDMA isn't implemented yet");
+            bcm2838_genet_tdma(s, offset, value);
             break;
         default:
             break;
diff --git a/include/hw/net/bcm2838_genet.h b/include/hw/net/bcm2838_genet.h
index 025ac467d7..7fbe4d3ea5 100644
--- a/include/hw/net/bcm2838_genet.h
+++ b/include/hw/net/bcm2838_genet.h
@@ -110,6 +110,30 @@ OBJECT_DECLARE_SIMPLE_TYPE(BCM2838GenetState, BCM2838_GENET)
 #define BCM2838_GENET_PHY_EXP_SHD_REGS_CNT \
     (1u << (8 * SIZEOF_FIELD(BCM2838GenetPhyExpSel, reg_id)))
 
+#define MAX_FRAME_SIZE                  0xFFF
+#define MAX_PACKET_SIZE                 1518
+#define MAX_PAYLOAD_SIZE                1500
+#define TX_MIN_PKT_SIZE                 60
+
+typedef union BCM2838GenetTxCsumInfo {
+    uint32_t value;
+    struct {
+        uint32_t offset:15;
+        uint32_t proto_udp:1;
+        uint32_t start:15;
+        uint32_t lv:1;
+    };
+} BCM2838GenetTxCsumInfo;
+
+typedef struct QEMU_PACKED BCM2838GenetXmitStatus {
+    uint32_t                length_status;  /* length and peripheral status */
+    uint32_t                ext_status;     /* Extended status */
+    uint32_t                rx_csum;        /* partial rx checksum */
+    uint32_t                unused1[9];     /* unused */
+    BCM2838GenetTxCsumInfo  tx_csum_info;   /* Tx checksum info. */
+    uint32_t                unused2[3];     /* unused */
+} BCM2838GenetXmitStatus;
+
 typedef union {
     uint32_t value;
     struct {
@@ -700,6 +724,8 @@ struct BCM2838GenetState {
 
     qemu_irq irq_default;
     qemu_irq irq_prio;
+
+    uint8_t tx_packet[MAX_FRAME_SIZE];
 };
 
 #endif /* BCM2838_GENET_H */
-- 
2.34.1



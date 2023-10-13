Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9848E7C80E0
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqu-00020A-3g; Fri, 13 Oct 2023 04:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqm-0001fO-6u
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:53 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqk-0001Ah-E2
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:51 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3231df054c4so1541898f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186929; x=1697791729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYUOeNNLdvO0RoLiodk1PXET5SEaKx9SVV6ucdM+jZA=;
 b=HOLvnf+pZmXQzjNeF8DeNBJ9Svf22zsA48V+u5siAQ0b8fErLzJvXpSsU9uq1jFZoe
 ibUo5BaAMmzDp6Gs8ZFTy5HjXLZb0986gDCAmL6CyXH1ubXvnkbecBkx7Xzer92ErqiQ
 8AXSXidthHyS2o+MPTfWij6tQTKmq2C61M68zOXj+Av34p+Qa8uWpXpVHc8i5FNywlfm
 x6pjIlM0eZlESrumBQI7twiJx4Za5sApjStOIn8OpzXbr1BU2j9n6WkcQrvONV6IKeiV
 HC79CTsOihd5ZUXCl5YTZeuTFVvCuwL0gC0+TFnuSjZPZCqc3ZKlwuMkgDc4xEVSX0l3
 P+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186929; x=1697791729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYUOeNNLdvO0RoLiodk1PXET5SEaKx9SVV6ucdM+jZA=;
 b=SUWB8uZ13xJFnMIpo3GAhwCb4OzIaPT1A+cHy2Har3MaYsr4sOwrOk3Tm/QQ/g0FId
 kN/1FP4yUWgCPyvJsXB5RSiNexiIbhZ6Rpe1eXEU1+/+C20q0SuOld8YMArx1bNkY7QH
 KsJnSXaBD3n1swCDKHDnkxgV75BZ2CMmrJg9Oc0+VwpFV07YNZNWTwlED3zk6xKq6Kg/
 6Qmc403xj9CXD1jitHRVgV2ekVD80e4M4Brk/fRP9nfQ5PHkgs1jgxQo+yYe8SmxZNcr
 cOzSj+8vei/R7rQkMp2QmhVlIFZ/R3cs9P0gYLqQ1EgfS+qNzzjh3wWuhcRGKJ/60oDK
 6PYA==
X-Gm-Message-State: AOJu0YzDsK+VYYItN1c4iwBkDmUkVP+tk+Zn+Jbrf4uHqQGYtWLb+fhX
 PidFaKyNB06GVyWNkVuh0F1hmEu0BqsTrFAt+qI=
X-Google-Smtp-Source: AGHT+IFiMvdJ353pi8DAZHkLqpExjVyBzeibnuxABs9uDgdlhr3p4ytE/PofCLPMOWTwDiEN9NFe0g==
X-Received: by 2002:a05:6000:144a:b0:32d:82f7:e79 with SMTP id
 v10-20020a056000144a00b0032d82f70e79mr8273638wrx.15.1697186928835; 
 Fri, 13 Oct 2023 01:48:48 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:48 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, Vikram Garhwal <fnu.vikram@xilinx.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq)
Subject: [RFC PATCH v3 57/78] hw/net: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:25 +0300
Message-Id: <84a6d743b5ff71c323cee718412e2a67084b9237.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/net/cadence_gem.c     | 4 ++--
 hw/net/can/can_sja1000.c | 4 ++--
 hw/net/igb_core.c        | 2 +-
 hw/net/igbvf.c           | 2 +-
 hw/net/imx_fec.c         | 2 +-
 hw/net/net_rx_pkt.c      | 2 +-
 hw/net/pcnet.c           | 2 +-
 hw/net/rtl8139.c         | 6 ++++--
 hw/net/xilinx_ethlite.c  | 2 +-
 9 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index f445d8bb5e..a59991af5b 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -834,10 +834,10 @@ static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
                 qemu_log_mask(LOG_UNIMP, "TCP compare offsets"
                               "unimplemented - assuming UDP\n");
                 offset += 8;
-                /* Fallthrough */
+                fallthrough;
             case 2: /* skip the IP header */
                 offset += 20;
-                /* Fallthrough */
+                fallthrough;
             case 1: /* Count from after the ethertype */
                 offset += 14;
                 break;
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 73201f9139..14052b2700 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -544,7 +544,7 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
             break;
         case 16: /* RX frame information addr16-28. */
             s->status_pel |= (1 << 5); /* Set transmit status. */
-            /* fallthrough */
+            fallthrough;
         case 17 ... 28:
             if (s->mode & 0x01) { /* Reset mode */
                 if (addr < 24) {
@@ -642,7 +642,7 @@ void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
             break;
         case 10:
             s->status_bas |= (1 << 5); /* Set transmit status. */
-            /* fallthrough */
+            fallthrough;
         case 11 ... 19:
             if ((s->control & 0x01) == 0) { /* Operation mode */
                 s->tx_buff[addr - 10] = val; /* Store to TX buffer directly. */
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index f6a5e2327b..1117f7cb59 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1419,7 +1419,7 @@ igb_build_rx_metadata_common(IGBCore *core,
             if (!csum_valid) {
                 *status_flags |= E1000_RXDEXT_STATERR_TCPE;
             }
-            /* fall through */
+            fallthrough;
         case ETH_L4_HDR_PROTO_TCP:
             *status_flags |= E1000_RXD_STAT_TCPCS;
             break;
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index d55e1e8a6a..ff68a4f3c5 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -188,7 +188,7 @@ static hwaddr vf_to_pf_addr(hwaddr addr, uint16_t vfn, bool write)
         if (write) {
             return HWADDR_MAX;
         }
-        /* fallthrough */
+        fallthrough;
     case 0x34E8: /* PBTWAC */
     case 0x24E8: /* PBRWAC */
         return addr;
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 5d1f1f104c..a7e8b06d48 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -918,7 +918,7 @@ static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
                           TYPE_IMX_FEC, __func__);
             return;
         }
-        /* fall through */
+        fallthrough;
     case ENET_TDAR:
         if (s->regs[ENET_ECR] & ENET_ECR_ETHEREN) {
             s->regs[index] = ENET_TDAR_TDAR;
diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 32e5f3f9cf..52e2432c9b 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -605,7 +605,7 @@ bool net_rx_pkt_validate_l4_csum(struct NetRxPkt *pkt, bool *csum_valid)
             trace_net_rx_pkt_l4_csum_validate_udp_with_no_checksum();
             return false;
         }
-        /* fall through */
+        fallthrough;
     case ETH_L4_HDR_PROTO_TCP:
         csum = _net_rx_pkt_calc_l4_csum(pkt);
         *csum_valid = ((csum == 0) || (csum == 0xFFFF));
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 02828ae716..a32174ef93 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -1502,7 +1502,7 @@ static void pcnet_bcr_writew(PCNetState *s, uint32_t rap, uint32_t val)
 #ifdef PCNET_DEBUG
        printf("BCR_SWS=0x%04x\n", val);
 #endif
-        /* fall through */
+       fallthrough;
     case BCR_LNKST:
     case BCR_LED1:
     case BCR_LED2:
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 4525fda383..42f19618b1 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -2447,8 +2447,10 @@ static uint32_t rtl8139_TxStatus_TxAddr_read(RTL8139State *s, uint32_t regs[],
     }
 
     switch (size) {
-    case 1: /* fall through */
-    case 2: /* fall through */
+    case 1:
+        fallthrough;
+    case 2:
+        fallthrough;
     case 4:
         ret = (regs[reg] >> offset * 8) & (((uint64_t)1 << (size * 8)) - 1);
         DPRINTF("TxStatus/TxAddr[%d] read addr=0x%x size=0x%x val=0x%08x\n",
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 89f4f3b254..5ae4032ec2 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -151,7 +151,7 @@ eth_write(void *opaque, hwaddr addr,
             if (!(value & CTRL_S)) {
                 qemu_flush_queued_packets(qemu_get_queue(s->nic));
             }
-            /* fall through */
+            fallthrough;
         case R_TX_LEN0:
         case R_TX_LEN1:
         case R_TX_GIE0:
-- 
2.39.2



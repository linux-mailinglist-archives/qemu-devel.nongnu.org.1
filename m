Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FA67C7F76
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:06:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD5C-0006Mi-8P; Fri, 13 Oct 2023 03:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD59-0005yU-9X
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:39 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD56-0007Gd-2E
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:38 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50305abe5f0so2426381e87.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183974; x=1697788774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U7eIdKYi0C0PTj9AIh0k7ZAKSjll1l4WSVMVqT9Um+g=;
 b=X+7IUvWfDUExYuXkBXE/WUrYFtedYXqj//aLdW1siFfA4jLBNYWPmzAQWJdkE0y2NQ
 FxmHtXj9+NRIczztoqjvT5F3uJC394tWr55T6iXP000X7DaT4ABgB1aN3IxYd8x33ajc
 b8BHH6uUDwBPknRASm1BNWpailxWaV4W6LbKLTP+mbAD5lfcmqkKhB9jdamKcEd4HtxG
 iKVmPIjeNJtxqLq8vnPQzu6wGMcaHWrP+K0yi6R+BON+Owb8lCNKUlIKiE1RWfYluzNL
 wc/xnZN4Q2S4uHHkcJzmasi2He9p53YeNXjdjgjKzwVpBHMqiNzBeIGgPz6+DJ/gJ+jl
 3sGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183974; x=1697788774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U7eIdKYi0C0PTj9AIh0k7ZAKSjll1l4WSVMVqT9Um+g=;
 b=MBR8NgNPCwLw1G8ccYlEY/6SRY/39xmRAdAQh4BN6YFNFjNi9YEN4xiH72RmPwzIn1
 Ch8mcs71DHLNRASGRueYngwQrOrKDsEOCER8l4M94RVFl78+jXLsjLv8KelvI/A/vxaF
 OV/TRIncPkfQbH/p002UdMPCG4IUfTJfk8cRH/orJ+eCz6mP4hSEJbm2UWtyFqPSjvLT
 eUhybVNfHAxNp8q70Nb03iTpdsqW+8YVhqcJunpDf/2/XFLuabD9vA91N0tVMtYAeO4A
 Q424mth4pYFbxBacgsyHyVd8Taaj8nXYgC4jpX0Ph7owkNVhO4+OVUT0zQJ5g8URyNpf
 X6zw==
X-Gm-Message-State: AOJu0YyjsR2UsoBcdnoOYTn/0h2+9lFEHrg49GtmjOO3gOf17Q/Drfgx
 syq3+Yv2aa9Csz1QpEfIpC8TJED0PISfu+Y9k1c=
X-Google-Smtp-Source: AGHT+IE/oeohDUmkcglMmUsbqbv5irvy6yhUD+ayaMPbbL0DPXEeTiINiEngSpHXYe8PsPCnmZPWWg==
X-Received: by 2002:a19:f70c:0:b0:500:cb2b:8678 with SMTP id
 z12-20020a19f70c000000b00500cb2b8678mr19584951lfe.40.1697183974047; 
 Fri, 13 Oct 2023 00:59:34 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:33 -0700 (PDT)
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
Subject: [RFC PATCH v2 57/78] hw/net: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:24 +0300
Message-Id: <40a1851702b201aab0c5e11af72c937c2f9aaabc.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x134.google.com
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
@@ -748,119 +748,119 @@ static int gem_mac_address_filter(CadenceGEMState *s, const uint8_t *packet)
 /* Figure out which queue the received data should be sent to */
 static int get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
                                  unsigned rxbufsize)
 {
     uint32_t reg;
     bool matched, mismatched;
     int i, j;
 
     for (i = 0; i < s->num_type1_screeners; i++) {
         reg = s->regs[GEM_SCREENING_TYPE1_REGISTER_0 + i];
         matched = false;
         mismatched = false;
 
         /* Screening is based on UDP Port */
         if (reg & GEM_ST1R_UDP_PORT_MATCH_ENABLE) {
             uint16_t udp_port = rxbuf_ptr[14 + 22] << 8 | rxbuf_ptr[14 + 23];
             if (udp_port == extract32(reg, GEM_ST1R_UDP_PORT_MATCH_SHIFT,
                                            GEM_ST1R_UDP_PORT_MATCH_WIDTH)) {
                 matched = true;
             } else {
                 mismatched = true;
             }
         }
 
         /* Screening is based on DS/TC */
         if (reg & GEM_ST1R_DSTC_ENABLE) {
             uint8_t dscp = rxbuf_ptr[14 + 1];
             if (dscp == extract32(reg, GEM_ST1R_DSTC_MATCH_SHIFT,
                                        GEM_ST1R_DSTC_MATCH_WIDTH)) {
                 matched = true;
             } else {
                 mismatched = true;
             }
         }
 
         if (matched && !mismatched) {
             return extract32(reg, GEM_ST1R_QUEUE_SHIFT, GEM_ST1R_QUEUE_WIDTH);
         }
     }
 
     for (i = 0; i < s->num_type2_screeners; i++) {
         reg = s->regs[GEM_SCREENING_TYPE2_REGISTER_0 + i];
         matched = false;
         mismatched = false;
 
         if (reg & GEM_ST2R_ETHERTYPE_ENABLE) {
             uint16_t type = rxbuf_ptr[12] << 8 | rxbuf_ptr[13];
             int et_idx = extract32(reg, GEM_ST2R_ETHERTYPE_INDEX_SHIFT,
                                         GEM_ST2R_ETHERTYPE_INDEX_WIDTH);
 
             if (et_idx > s->num_type2_screeners) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Out of range ethertype "
                               "register index: %d\n", et_idx);
             }
             if (type == s->regs[GEM_SCREENING_TYPE2_ETHERTYPE_REG_0 +
                                 et_idx]) {
                 matched = true;
             } else {
                 mismatched = true;
             }
         }
 
         /* Compare A, B, C */
         for (j = 0; j < 3; j++) {
             uint32_t cr0, cr1, mask;
             uint16_t rx_cmp;
             int offset;
             int cr_idx = extract32(reg, GEM_ST2R_COMPARE_A_SHIFT + j * 6,
                                         GEM_ST2R_COMPARE_WIDTH);
 
             if (!(reg & (GEM_ST2R_COMPARE_A_ENABLE << (j * 6)))) {
                 continue;
             }
             if (cr_idx > s->num_type2_screeners) {
                 qemu_log_mask(LOG_GUEST_ERROR, "Out of range compare "
                               "register index: %d\n", cr_idx);
             }
 
             cr0 = s->regs[GEM_TYPE2_COMPARE_0_WORD_0 + cr_idx * 2];
             cr1 = s->regs[GEM_TYPE2_COMPARE_0_WORD_0 + cr_idx * 2 + 1];
             offset = extract32(cr1, GEM_T2CW1_OFFSET_VALUE_SHIFT,
                                     GEM_T2CW1_OFFSET_VALUE_WIDTH);
 
             switch (extract32(cr1, GEM_T2CW1_COMPARE_OFFSET_SHIFT,
                                    GEM_T2CW1_COMPARE_OFFSET_WIDTH)) {
             case 3: /* Skip UDP header */
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
             case 0:
                 /* Offset from start of frame */
                 break;
             }
 
             rx_cmp = rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
             mask = extract32(cr0, 0, 16);
 
             if ((rx_cmp & mask) == (extract32(cr0, 16, 16) & mask)) {
                 matched = true;
             } else {
                 mismatched = true;
             }
         }
 
         if (matched && !mismatched) {
             return extract32(reg, GEM_ST2R_QUEUE_SHIFT, GEM_ST2R_QUEUE_WIDTH);
         }
     }
 
     /* We made it here, assume it's queue 0 */
     return 0;
 }
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 73201f9139..14052b2700 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -422,235 +422,235 @@ static void can_sja_update_bas_irq(CanSJA1000State *s)
 void can_sja_mem_write(CanSJA1000State *s, hwaddr addr, uint64_t val,
                        unsigned size)
 {
     qemu_can_frame   frame;
     uint32_t         tmp;
     uint8_t          tmp8, count;
 
 
     DPRINTF("write 0x%02llx addr 0x%02x\n",
             (unsigned long long)val, (unsigned int)addr);
 
     if (addr > CAN_SJA_MEM_SIZE) {
         return;
     }
 
     if (s->clock & 0x80) { /* PeliCAN Mode */
         switch (addr) {
         case SJA_MOD: /* Mode register */
             s->mode = 0x1f & val;
             if ((s->mode & 0x01) && ((val & 0x01) == 0)) {
                 /* Go to operation mode from reset mode. */
                 if (s->mode & (1 << 3)) { /* Single mode. */
                     /* For EFF */
                     can_sja_single_filter(&s->filter[0],
                         s->code_mask + 0, s->code_mask + 4, 1);
 
                     /* For SFF */
                     can_sja_single_filter(&s->filter[1],
                         s->code_mask + 0, s->code_mask + 4, 0);
 
                     can_bus_client_set_filters(&s->bus_client, s->filter, 2);
                 } else { /* Dual mode */
                     /* For EFF */
                     can_sja_dual_filter(&s->filter[0],
                         s->code_mask + 0, s->code_mask + 4, 1);
 
                     can_sja_dual_filter(&s->filter[1],
                         s->code_mask + 2, s->code_mask + 6, 1);
 
                     /* For SFF */
                     can_sja_dual_filter(&s->filter[2],
                         s->code_mask + 0, s->code_mask + 4, 0);
 
                     can_sja_dual_filter(&s->filter[3],
                         s->code_mask + 2, s->code_mask + 6, 0);
 
                     can_bus_client_set_filters(&s->bus_client, s->filter, 4);
                 }
 
                 s->rxmsg_cnt = 0;
                 s->rx_cnt = 0;
             }
             break;
 
         case SJA_CMR: /* Command register. */
             if (0x01 & val) { /* Send transmission request. */
                 buff2frame_pel(s->tx_buff, &frame);
                 if (DEBUG_FILTER) {
                     can_display_msg("[cansja]: Tx request " , &frame);
                 }
 
                 /*
                  * Clear transmission complete status,
                  * and Transmit Buffer Status.
                  * write to the backends.
                  */
                 s->status_pel &= ~(3 << 2);
 
                 can_bus_client_send(&s->bus_client, &frame, 1);
 
                 /*
                  * Set transmission complete status
                  * and Transmit Buffer Status.
                  */
                 s->status_pel |= (3 << 2);
 
                 /* Clear transmit status. */
                 s->status_pel &= ~(1 << 5);
                 s->interrupt_pel |= 0x02;
                 can_sja_update_pel_irq(s);
             }
             if (0x04 & val) { /* Release Receive Buffer */
                 if (s->rxmsg_cnt <= 0) {
                     break;
                 }
 
                 tmp8 = s->rx_buff[s->rxbuf_start]; count = 0;
                 if (tmp8 & (1 << 7)) { /* EFF */
                     count += 2;
                 }
                 count += 3;
                 if (!(tmp8 & (1 << 6))) { /* DATA */
                     count += (tmp8 & 0x0f);
                 }
 
                 if (DEBUG_FILTER) {
                     qemu_log("[cansja]: message released from "
                              "Rx FIFO cnt=%d, count=%d\n", s->rx_cnt, count);
                 }
 
                 s->rxbuf_start += count;
                 s->rxbuf_start %= SJA_RCV_BUF_LEN;
 
                 s->rx_cnt -= count;
                 s->rxmsg_cnt--;
                 if (s->rxmsg_cnt == 0) {
                     s->status_pel &= ~(1 << 0);
                     s->interrupt_pel &= ~(1 << 0);
                     can_sja_update_pel_irq(s);
                 }
             }
             if (0x08 & val) { /* Clear data overrun */
                 s->status_pel &= ~(1 << 1);
                 s->interrupt_pel &= ~(1 << 3);
                 can_sja_update_pel_irq(s);
             }
             break;
         case SJA_SR: /* Status register */
         case SJA_IR: /* Interrupt register */
             break; /* Do nothing */
         case SJA_IER: /* Interrupt enable register */
             s->interrupt_en = val;
             break;
         case 16: /* RX frame information addr16-28. */
             s->status_pel |= (1 << 5); /* Set transmit status. */
-            /* fallthrough */
+            fallthrough;
         case 17 ... 28:
             if (s->mode & 0x01) { /* Reset mode */
                 if (addr < 24) {
                     s->code_mask[addr - 16] = val;
                 }
             } else { /* Operation mode */
                 s->tx_buff[addr - 16] = val; /* Store to TX buffer directly. */
             }
             break;
         case SJA_CDR:
             s->clock = val;
             break;
         }
     } else { /* Basic Mode */
         switch (addr) {
         case SJA_BCAN_CTR: /* Control register, addr 0 */
             if ((s->control & 0x01) && ((val & 0x01) == 0)) {
                 /* Go to operation mode from reset mode. */
                 s->filter[0].can_id = (s->code << 3) & (0xff << 3);
                 tmp = (~(s->mask << 3)) & (0xff << 3);
                 tmp |= QEMU_CAN_EFF_FLAG; /* Only Basic CAN Frame. */
                 s->filter[0].can_mask = tmp;
                 can_bus_client_set_filters(&s->bus_client, s->filter, 1);
 
                 s->rxmsg_cnt = 0;
                 s->rx_cnt = 0;
             } else if (!(s->control & 0x01) && !(val & 0x01)) {
                 can_sja_software_reset(s);
             }
 
             s->control = 0x1f & val;
             break;
         case SJA_BCAN_CMR: /* Command register, addr 1 */
             if (0x01 & val) { /* Send transmission request. */
                 buff2frame_bas(s->tx_buff, &frame);
                 if (DEBUG_FILTER) {
                     can_display_msg("[cansja]: Tx request " , &frame);
                 }
 
                 /*
                  * Clear transmission complete status,
                  * and Transmit Buffer Status.
                  */
                 s->status_bas &= ~(3 << 2);
 
                 /* write to the backends. */
                 can_bus_client_send(&s->bus_client, &frame, 1);
 
                 /*
                  * Set transmission complete status,
                  * and Transmit Buffer Status.
                  */
                 s->status_bas |= (3 << 2);
 
                 /* Clear transmit status. */
                 s->status_bas &= ~(1 << 5);
                 s->interrupt_bas |= 0x02;
                 can_sja_update_bas_irq(s);
             }
             if (0x04 & val) { /* Release Receive Buffer */
                 if (s->rxmsg_cnt <= 0) {
                     break;
                 }
 
                 tmp8 = s->rx_buff[(s->rxbuf_start + 1) % SJA_RCV_BUF_LEN];
                 count = 2 + (tmp8 & 0x0f);
 
                 if (DEBUG_FILTER) {
                     qemu_log("[cansja]: message released from "
                              "Rx FIFO cnt=%d, count=%d\n", s->rx_cnt, count);
                 }
 
                 s->rxbuf_start += count;
                 s->rxbuf_start %= SJA_RCV_BUF_LEN;
                 s->rx_cnt -= count;
                 s->rxmsg_cnt--;
 
                 if (s->rxmsg_cnt == 0) {
                     s->status_bas &= ~(1 << 0);
                     s->interrupt_bas &= ~(1 << 0);
                     can_sja_update_bas_irq(s);
                 }
             }
             if (0x08 & val) { /* Clear data overrun */
                 s->status_bas &= ~(1 << 1);
                 s->interrupt_bas &= ~(1 << 3);
                 can_sja_update_bas_irq(s);
             }
             break;
         case 4:
             s->code = val;
             break;
         case 5:
             s->mask = val;
             break;
         case 10:
             s->status_bas |= (1 << 5); /* Set transmit status. */
-            /* fallthrough */
+            fallthrough;
         case 11 ... 19:
             if ((s->control & 0x01) == 0) { /* Operation mode */
                 s->tx_buff[addr - 10] = val; /* Store to TX buffer directly. */
             }
             break;
         case SJA_CDR:
             s->clock = val;
             break;
         }
     }
 }
diff --git a/hw/net/igb_core.c b/hw/net/igb_core.c
index f6a5e2327b..1117f7cb59 100644
--- a/hw/net/igb_core.c
+++ b/hw/net/igb_core.c
@@ -1362,75 +1362,75 @@ static void
 igb_build_rx_metadata_common(IGBCore *core,
                              struct NetRxPkt *pkt,
                              bool is_eop,
                              uint32_t *status_flags,
                              uint16_t *vlan_tag)
 {
     struct virtio_net_hdr *vhdr;
     bool hasip4, hasip6, csum_valid;
     EthL4HdrProto l4hdr_proto;
 
     *status_flags = E1000_RXD_STAT_DD;
 
     /* No additional metadata needed for non-EOP descriptors */
     if (!is_eop) {
         goto func_exit;
     }
 
     *status_flags |= E1000_RXD_STAT_EOP;
 
     net_rx_pkt_get_protocols(pkt, &hasip4, &hasip6, &l4hdr_proto);
     trace_e1000e_rx_metadata_protocols(hasip4, hasip6, l4hdr_proto);
 
     /* VLAN state */
     if (net_rx_pkt_is_vlan_stripped(pkt)) {
         *status_flags |= E1000_RXD_STAT_VP;
         *vlan_tag = cpu_to_le16(net_rx_pkt_get_vlan_tag(pkt));
         trace_e1000e_rx_metadata_vlan(*vlan_tag);
     }
 
     /* RX CSO information */
     if (hasip6 && (core->mac[RFCTL] & E1000_RFCTL_IPV6_XSUM_DIS)) {
         trace_e1000e_rx_metadata_ipv6_sum_disabled();
         goto func_exit;
     }
 
     vhdr = net_rx_pkt_get_vhdr(pkt);
 
     if (!(vhdr->flags & VIRTIO_NET_HDR_F_DATA_VALID) &&
         !(vhdr->flags & VIRTIO_NET_HDR_F_NEEDS_CSUM)) {
         trace_e1000e_rx_metadata_virthdr_no_csum_info();
         igb_verify_csum_in_sw(core, pkt, status_flags, l4hdr_proto);
         goto func_exit;
     }
 
     if (igb_rx_l3_cso_enabled(core)) {
         *status_flags |= hasip4 ? E1000_RXD_STAT_IPCS : 0;
     } else {
         trace_e1000e_rx_metadata_l3_cso_disabled();
     }
 
     if (igb_rx_l4_cso_enabled(core)) {
         switch (l4hdr_proto) {
         case ETH_L4_HDR_PROTO_SCTP:
             if (!net_rx_pkt_validate_l4_csum(pkt, &csum_valid)) {
                 trace_e1000e_rx_metadata_l4_csum_validation_failed();
                 goto func_exit;
             }
             if (!csum_valid) {
                 *status_flags |= E1000_RXDEXT_STATERR_TCPE;
             }
-            /* fall through */
+            fallthrough;
         case ETH_L4_HDR_PROTO_TCP:
             *status_flags |= E1000_RXD_STAT_TCPCS;
             break;
 
         case ETH_L4_HDR_PROTO_UDP:
             *status_flags |= E1000_RXD_STAT_TCPCS | E1000_RXD_STAT_UDPCS;
             break;
 
         default:
             break;
         }
     } else {
         trace_e1000e_rx_metadata_l4_cso_disabled();
     }
diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
index d55e1e8a6a..ff68a4f3c5 100644
--- a/hw/net/igbvf.c
+++ b/hw/net/igbvf.c
@@ -62,139 +62,139 @@ struct IgbVfState {
 static hwaddr vf_to_pf_addr(hwaddr addr, uint16_t vfn, bool write)
 {
     switch (addr) {
     case E1000_CTRL:
     case E1000_CTRL_DUP:
         return E1000_PVTCTRL(vfn);
     case E1000_EICS:
         return E1000_PVTEICS(vfn);
     case E1000_EIMS:
         return E1000_PVTEIMS(vfn);
     case E1000_EIMC:
         return E1000_PVTEIMC(vfn);
     case E1000_EIAC:
         return E1000_PVTEIAC(vfn);
     case E1000_EIAM:
         return E1000_PVTEIAM(vfn);
     case E1000_EICR:
         return E1000_PVTEICR(vfn);
     case E1000_EITR(0):
     case E1000_EITR(1):
     case E1000_EITR(2):
         return E1000_EITR(22) + (addr - E1000_EITR(0)) - vfn * 0xC;
     case E1000_IVAR0:
         return E1000_VTIVAR + vfn * 4;
     case E1000_IVAR_MISC:
         return E1000_VTIVAR_MISC + vfn * 4;
     case 0x0F04: /* PBACL */
         return E1000_PBACLR;
     case 0x0F0C: /* PSRTYPE */
         return E1000_PSRTYPE(vfn);
     case E1000_V2PMAILBOX(0):
         return E1000_V2PMAILBOX(vfn);
     case E1000_VMBMEM(0) ... E1000_VMBMEM(0) + 0x3F:
         return addr + vfn * 0x40;
     case E1000_RDBAL_A(0):
         return E1000_RDBAL(vfn);
     case E1000_RDBAL_A(1):
         return E1000_RDBAL(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_RDBAH_A(0):
         return E1000_RDBAH(vfn);
     case E1000_RDBAH_A(1):
         return E1000_RDBAH(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_RDLEN_A(0):
         return E1000_RDLEN(vfn);
     case E1000_RDLEN_A(1):
         return E1000_RDLEN(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_SRRCTL_A(0):
         return E1000_SRRCTL(vfn);
     case E1000_SRRCTL_A(1):
         return E1000_SRRCTL(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_RDH_A(0):
         return E1000_RDH(vfn);
     case E1000_RDH_A(1):
         return E1000_RDH(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_RXCTL_A(0):
         return E1000_RXCTL(vfn);
     case E1000_RXCTL_A(1):
         return E1000_RXCTL(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_RDT_A(0):
         return E1000_RDT(vfn);
     case E1000_RDT_A(1):
         return E1000_RDT(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_RXDCTL_A(0):
         return E1000_RXDCTL(vfn);
     case E1000_RXDCTL_A(1):
         return E1000_RXDCTL(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_RQDPC_A(0):
         return E1000_RQDPC(vfn);
     case E1000_RQDPC_A(1):
         return E1000_RQDPC(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_TDBAL_A(0):
         return E1000_TDBAL(vfn);
     case E1000_TDBAL_A(1):
         return E1000_TDBAL(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_TDBAH_A(0):
         return E1000_TDBAH(vfn);
     case E1000_TDBAH_A(1):
         return E1000_TDBAH(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_TDLEN_A(0):
         return E1000_TDLEN(vfn);
     case E1000_TDLEN_A(1):
         return E1000_TDLEN(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_TDH_A(0):
         return E1000_TDH(vfn);
     case E1000_TDH_A(1):
         return E1000_TDH(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_TXCTL_A(0):
         return E1000_TXCTL(vfn);
     case E1000_TXCTL_A(1):
         return E1000_TXCTL(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_TDT_A(0):
         return E1000_TDT(vfn);
     case E1000_TDT_A(1):
         return E1000_TDT(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_TXDCTL_A(0):
         return E1000_TXDCTL(vfn);
     case E1000_TXDCTL_A(1):
         return E1000_TXDCTL(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_TDWBAL_A(0):
         return E1000_TDWBAL(vfn);
     case E1000_TDWBAL_A(1):
         return E1000_TDWBAL(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_TDWBAH_A(0):
         return E1000_TDWBAH(vfn);
     case E1000_TDWBAH_A(1):
         return E1000_TDWBAH(vfn + IGB_MAX_VF_FUNCTIONS);
     case E1000_VFGPRC:
         return E1000_PVFGPRC(vfn);
     case E1000_VFGPTC:
         return E1000_PVFGPTC(vfn);
     case E1000_VFGORC:
         return E1000_PVFGORC(vfn);
     case E1000_VFGOTC:
         return E1000_PVFGOTC(vfn);
     case E1000_VFMPRC:
         return E1000_PVFMPRC(vfn);
     case E1000_VFGPRLBC:
         return E1000_PVFGPRLBC(vfn);
     case E1000_VFGPTLBC:
         return E1000_PVFGPTLBC(vfn);
     case E1000_VFGORLBC:
         return E1000_PVFGORLBC(vfn);
     case E1000_VFGOTLBC:
         return E1000_PVFGOTLBC(vfn);
     case E1000_STATUS:
     case E1000_FRTIMER:
         if (write) {
             return HWADDR_MAX;
         }
-        /* fallthrough */
+        fallthrough;
     case 0x34E8: /* PBTWAC */
     case 0x24E8: /* PBRWAC */
         return addr;
     }
 
     trace_igbvf_wrn_io_addr_unknown(addr);
 
     return HWADDR_MAX;
 }
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 5d1f1f104c..a7e8b06d48 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -888,170 +888,170 @@ static void imx_enet_write(IMXFECState *s, uint32_t index, uint32_t value)
 static void imx_eth_write(void *opaque, hwaddr offset, uint64_t value,
                            unsigned size)
 {
     IMXFECState *s = IMX_FEC(opaque);
     const bool single_tx_ring = !imx_eth_is_multi_tx_ring(s);
     uint32_t index = offset >> 2;
 
     trace_imx_eth_write(index, imx_eth_reg_name(s, index), value);
 
     switch (index) {
     case ENET_EIR:
         s->regs[index] &= ~value;
         break;
     case ENET_EIMR:
         s->regs[index] = value;
         break;
     case ENET_RDAR:
         if (s->regs[ENET_ECR] & ENET_ECR_ETHEREN) {
             if (!s->regs[index]) {
                 imx_eth_enable_rx(s, true);
             }
         } else {
             s->regs[index] = 0;
         }
         break;
     case ENET_TDAR1:
     case ENET_TDAR2:
         if (unlikely(single_tx_ring)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "[%s]%s: trying to access TDAR2 or TDAR1\n",
                           TYPE_IMX_FEC, __func__);
             return;
         }
-        /* fall through */
+        fallthrough;
     case ENET_TDAR:
         if (s->regs[ENET_ECR] & ENET_ECR_ETHEREN) {
             s->regs[index] = ENET_TDAR_TDAR;
             imx_eth_do_tx(s, index);
         }
         s->regs[index] = 0;
         break;
     case ENET_ECR:
         if (value & ENET_ECR_RESET) {
             return imx_eth_reset(DEVICE(s));
         }
         s->regs[index] = value;
         if ((s->regs[index] & ENET_ECR_ETHEREN) == 0) {
             s->regs[ENET_RDAR] = 0;
             s->rx_descriptor = s->regs[ENET_RDSR];
             s->regs[ENET_TDAR]  = 0;
             s->regs[ENET_TDAR1] = 0;
             s->regs[ENET_TDAR2] = 0;
             s->tx_descriptor[0] = s->regs[ENET_TDSR];
             s->tx_descriptor[1] = s->regs[ENET_TDSR1];
             s->tx_descriptor[2] = s->regs[ENET_TDSR2];
         }
         break;
     case ENET_MMFR:
         s->regs[index] = value;
         if (extract32(value, 29, 1)) {
             /* This is a read operation */
             s->regs[ENET_MMFR] = deposit32(s->regs[ENET_MMFR], 0, 16,
                                            imx_phy_read(s,
                                                        extract32(value,
                                                                  18, 10)));
         } else {
             /* This is a write operation */
             imx_phy_write(s, extract32(value, 18, 10), extract32(value, 0, 16));
         }
         /* raise the interrupt as the PHY operation is done */
         s->regs[ENET_EIR] |= ENET_INT_MII;
         break;
     case ENET_MSCR:
         s->regs[index] = value & 0xfe;
         break;
     case ENET_MIBC:
         /* TODO: Implement MIB.  */
         s->regs[index] = (value & 0x80000000) ? 0xc0000000 : 0;
         break;
     case ENET_RCR:
         s->regs[index] = value & 0x07ff003f;
         /* TODO: Implement LOOP mode.  */
         break;
     case ENET_TCR:
         /* We transmit immediately, so raise GRA immediately.  */
         s->regs[index] = value;
         if (value & 1) {
             s->regs[ENET_EIR] |= ENET_INT_GRA;
         }
         break;
     case ENET_PALR:
         s->regs[index] = value;
         s->conf.macaddr.a[0] = value >> 24;
         s->conf.macaddr.a[1] = value >> 16;
         s->conf.macaddr.a[2] = value >> 8;
         s->conf.macaddr.a[3] = value;
         break;
     case ENET_PAUR:
         s->regs[index] = (value | 0x0000ffff) & 0xffff8808;
         s->conf.macaddr.a[4] = value >> 24;
         s->conf.macaddr.a[5] = value >> 16;
         break;
     case ENET_OPD:
         s->regs[index] = (value & 0x0000ffff) | 0x00010000;
         break;
     case ENET_IAUR:
     case ENET_IALR:
     case ENET_GAUR:
     case ENET_GALR:
         /* TODO: implement MAC hash filtering.  */
         break;
     case ENET_TFWR:
         if (s->is_fec) {
             s->regs[index] = value & 0x3;
         } else {
             s->regs[index] = value & 0x13f;
         }
         break;
     case ENET_RDSR:
         if (s->is_fec) {
             s->regs[index] = value & ~3;
         } else {
             s->regs[index] = value & ~7;
         }
         s->rx_descriptor = s->regs[index];
         break;
     case ENET_TDSR:
         if (s->is_fec) {
             s->regs[index] = value & ~3;
         } else {
             s->regs[index] = value & ~7;
         }
         s->tx_descriptor[0] = s->regs[index];
         break;
     case ENET_TDSR1:
         if (unlikely(single_tx_ring)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "[%s]%s: trying to access TDSR1\n",
                           TYPE_IMX_FEC, __func__);
             return;
         }
 
         s->regs[index] = value & ~7;
         s->tx_descriptor[1] = s->regs[index];
         break;
     case ENET_TDSR2:
         if (unlikely(single_tx_ring)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "[%s]%s: trying to access TDSR2\n",
                           TYPE_IMX_FEC, __func__);
             return;
         }
 
         s->regs[index] = value & ~7;
         s->tx_descriptor[2] = s->regs[index];
         break;
     case ENET_MRBR:
         s->regs[index] = value & 0x00003ff0;
         break;
     default:
         if (s->is_fec) {
             imx_fec_write(s, index, value);
         } else {
             imx_enet_write(s, index, value);
         }
         return;
     }
 
     imx_eth_update(s);
 }
diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 32e5f3f9cf..52e2432c9b 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -591,36 +591,36 @@ _net_rx_pkt_validate_sctp_sum(struct NetRxPkt *pkt)
 bool net_rx_pkt_validate_l4_csum(struct NetRxPkt *pkt, bool *csum_valid)
 {
     uint32_t csum;
 
     trace_net_rx_pkt_l4_csum_validate_entry();
 
     if (pkt->hasip4 && pkt->ip4hdr_info.fragment) {
         trace_net_rx_pkt_l4_csum_validate_ip4_fragment();
         return false;
     }
 
     switch (pkt->l4hdr_info.proto) {
     case ETH_L4_HDR_PROTO_UDP:
         if (pkt->l4hdr_info.hdr.udp.uh_sum == 0) {
             trace_net_rx_pkt_l4_csum_validate_udp_with_no_checksum();
             return false;
         }
-        /* fall through */
+        fallthrough;
     case ETH_L4_HDR_PROTO_TCP:
         csum = _net_rx_pkt_calc_l4_csum(pkt);
         *csum_valid = ((csum == 0) || (csum == 0xFFFF));
         break;
 
     case ETH_L4_HDR_PROTO_SCTP:
         *csum_valid = _net_rx_pkt_validate_sctp_sum(pkt);
         break;
 
     default:
         trace_net_rx_pkt_l4_csum_validate_not_xxp();
         return false;
     }
 
     trace_net_rx_pkt_l4_csum_validate_csum(*csum_valid);
 
     return true;
 }
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 02828ae716..a32174ef93 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -1474,47 +1474,47 @@ static uint32_t pcnet_csr_readw(PCNetState *s, uint32_t rap)
 static void pcnet_bcr_writew(PCNetState *s, uint32_t rap, uint32_t val)
 {
     rap &= 127;
 #ifdef PCNET_DEBUG_BCR
     printf("pcnet_bcr_writew rap=%d val=0x%04x\n", rap, val);
 #endif
     switch (rap) {
     case BCR_SWS:
         if (!(CSR_STOP(s) || CSR_SPND(s)))
             return;
         val &= ~0x0300;
         switch (val & 0x00ff) {
         case 0:
             val |= 0x0200;
             break;
         case 1:
             val |= 0x0100;
             break;
         case 2:
         case 3:
             val |= 0x0300;
             break;
         default:
             qemu_log_mask(LOG_GUEST_ERROR, "pcnet: Bad SWSTYLE=0x%02x\n",
                           val & 0xff);
             val = 0x0200;
             break;
         }
 #ifdef PCNET_DEBUG
        printf("BCR_SWS=0x%04x\n", val);
 #endif
-        /* fall through */
+       fallthrough;
     case BCR_LNKST:
     case BCR_LED1:
     case BCR_LED2:
     case BCR_LED3:
     case BCR_MC:
     case BCR_FDC:
     case BCR_BSBC:
     case BCR_EECAS:
     case BCR_PLAT:
         s->bcr[rap] = val;
         break;
     default:
         break;
     }
 }
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 4525fda383..42f19618b1 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -2435,29 +2435,31 @@ static void rtl8139_TxStatus_write(RTL8139State *s, uint32_t txRegOffset, uint32
 static uint32_t rtl8139_TxStatus_TxAddr_read(RTL8139State *s, uint32_t regs[],
                                              uint32_t base, uint8_t addr,
                                              int size)
 {
     uint32_t reg = (addr - base) / 4;
     uint32_t offset = addr & 0x3;
     uint32_t ret = 0;
 
     if (addr & (size - 1)) {
         DPRINTF("not implemented read for TxStatus/TxAddr "
                 "addr=0x%x size=0x%x\n", addr, size);
         return ret;
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
                 reg, addr, size, ret);
         break;
     default:
         DPRINTF("unsupported size 0x%x of TxStatus/TxAddr reading\n", size);
         break;
     }
 
     return ret;
 }
diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
index 89f4f3b254..5ae4032ec2 100644
--- a/hw/net/xilinx_ethlite.c
+++ b/hw/net/xilinx_ethlite.c
@@ -113,55 +113,55 @@ static void
 eth_write(void *opaque, hwaddr addr,
           uint64_t val64, unsigned int size)
 {
     struct xlx_ethlite *s = opaque;
     unsigned int base = 0;
     uint32_t value = val64;
 
     addr >>= 2;
     switch (addr) 
     {
         case R_TX_CTRL0:
         case R_TX_CTRL1:
             if (addr == R_TX_CTRL1)
                 base = 0x800 / 4;
 
             D(qemu_log("%s addr=" HWADDR_FMT_plx " val=%x\n",
                        __func__, addr * 4, value));
             if ((value & (CTRL_P | CTRL_S)) == CTRL_S) {
                 qemu_send_packet(qemu_get_queue(s->nic),
                                  (void *) &s->regs[base],
                                  s->regs[base + R_TX_LEN0]);
                 D(qemu_log("eth_tx %d\n", s->regs[base + R_TX_LEN0]));
                 if (s->regs[base + R_TX_CTRL0] & CTRL_I)
                     eth_pulse_irq(s);
             } else if ((value & (CTRL_P | CTRL_S)) == (CTRL_P | CTRL_S)) {
                 memcpy(&s->conf.macaddr.a[0], &s->regs[base], 6);
                 if (s->regs[base + R_TX_CTRL0] & CTRL_I)
                     eth_pulse_irq(s);
             }
 
             /* We are fast and get ready pretty much immediately so
                we actually never flip the S nor P bits to one.  */
             s->regs[addr] = value & ~(CTRL_P | CTRL_S);
             break;
 
         /* Keep these native.  */
         case R_RX_CTRL0:
         case R_RX_CTRL1:
             if (!(value & CTRL_S)) {
                 qemu_flush_queued_packets(qemu_get_queue(s->nic));
             }
-            /* fall through */
+            fallthrough;
         case R_TX_LEN0:
         case R_TX_LEN1:
         case R_TX_GIE0:
             D(qemu_log("%s addr=" HWADDR_FMT_plx " val=%x\n",
                        __func__, addr * 4, value));
             s->regs[addr] = value;
             break;
 
         default:
             s->regs[addr] = tswap32(value);
             break;
     }
 }
-- 
2.39.2



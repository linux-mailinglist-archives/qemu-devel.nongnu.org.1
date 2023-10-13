Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFE17C7F58
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:04:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCyN-0003Du-Ir; Fri, 13 Oct 2023 03:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxV-0007Hk-5P
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:46 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxK-00057J-Qw
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:44 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32c9f2ce71aso1491319f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183485; x=1697788285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/6tifHfgA2E9FYqICTGGAq/GsQQsYwI5XCUGqJk1TI=;
 b=ehMcDTv/Yb5uPS2ZiyUvTiDurJvyARqWidCxtjSIAHIzGJynqC4Wdm9YbQlXR3mxBS
 Gku7Fr7k0q+QMUvwru1h1scOA3fZmFlRMkJpsZJn8LTbWnR88V2ilGevTi1a6Frg7XK1
 QEflFFU2YNqrfD2doIfrffvb/H7zZSM2XC8IpSdgsfif5umWqQVSHUpCZKC0TCoh/yJ8
 a/Gkkx5wYHkZmXnuS0CHv3bLNCqceWXTMekJHx3acT1bslMPeyKrze7spsKEo4y8IocG
 YZ3dsjXRkM0YGfEwx0V9eNgQEcG8uu8TTLWjmkHyrbVhAbbH0D71Qdx3EILQXScnDclm
 uF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183485; x=1697788285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/6tifHfgA2E9FYqICTGGAq/GsQQsYwI5XCUGqJk1TI=;
 b=NquiRROGFxTBuMs0mgrBiPJMxIisTdD+nuuPZPOmEGXDaAgaDAmZfQWCkL1DQRYFem
 W+wuyqJdZKK3hH/jqpgLmrqpMZKGQEG47xqEkAN5V+xUK5HyGRO2kxZq8BvFIo0k0LqE
 rMGQgXuKtQRAk0GiEes+oRuZ+ks9nZm90I+TDKrVSXr4YgUxbr0jmGNpupYLCT2EJ518
 6cKIUbGppLfdlEkkhgBmv90eB2NbMq83nD4ZaEqUFDQAHTNADLyAwopU6t+8OVRG7YXG
 mmPLHoPxy0jjXHWtMTDppXJi7RlQoAGWYBEu/rwaO3EtpTbzgTEM4gYv8eQ0RK0hiaLR
 ookA==
X-Gm-Message-State: AOJu0YzqPslFnDG1YQ4UWIgrykr3qfFrdcApyDZfhIYE5NctFHij3lu4
 TOjgh5eCJTTpkDOkH+VPSeB/B4sWBst4TKllDIA=
X-Google-Smtp-Source: AGHT+IGQzwNs0VnVKIiDkb6ehAOG9GmRVTmE0vPOaxAdG/r9yru27O/KZ7gdH8DX1W7Su44+dG09YA==
X-Received: by 2002:adf:e3ca:0:b0:317:6a07:83a7 with SMTP id
 k10-20020adfe3ca000000b003176a0783a7mr22661773wrm.38.1697183484816; 
 Fri, 13 Oct 2023 00:51:24 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:24 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [RFC PATCH 44/75] hw/dma: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:55 +0300
Message-Id: <40a8d1996d9839162ac89837bb2fc614e0dd2e19.1697034504.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
References: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42c.google.com
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

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/dma/omap_dma.c    | 32 ++++++++++++++++----------------
 hw/dma/pxa2xx_dma.c  |  4 ++--
 hw/dma/sparc32_dma.c |  2 +-
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 77797a67b5..dd43dbf3d2 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -1457,46 +1457,46 @@ static int omap_dma_sys_read(struct omap_dma_s *s, int offset,
 static uint64_t omap_dma_read(void *opaque, hwaddr addr, unsigned size)
 {
     struct omap_dma_s *s = opaque;
     int reg, ch;
     uint16_t ret;
 
     if (size != 2) {
         return omap_badwidth_read16(opaque, addr);
     }
 
     switch (addr) {
     case 0x300 ... 0x3fe:
         if (s->model <= omap_dma_3_1 || !s->omap_3_1_mapping_disabled) {
             if (omap_dma_3_1_lcd_read(&s->lcd_ch, addr, &ret))
                 break;
             return ret;
         }
-        /* Fall through. */
+        fallthrough;
     case 0x000 ... 0x2fe:
         reg = addr & 0x3f;
         ch = (addr >> 6) & 0x0f;
         if (omap_dma_ch_reg_read(s, &s->ch[ch], reg, &ret))
             break;
         return ret;
 
     case 0x404 ... 0x4fe:
         if (s->model <= omap_dma_3_1)
             break;
-        /* Fall through. */
+        fallthrough;
     case 0x400:
         if (omap_dma_sys_read(s, addr, &ret))
             break;
         return ret;
 
     case 0xb00 ... 0xbfe:
         if (s->model == omap_dma_3_2 && s->omap_3_1_mapping_disabled) {
             if (omap_dma_3_2_lcd_read(&s->lcd_ch, addr, &ret))
                 break;
             return ret;
         }
         break;
     }
 
     OMAP_BAD_REG(addr);
     return 0;
 }
@@ -1504,46 +1504,46 @@ static uint64_t omap_dma_read(void *opaque, hwaddr addr, unsigned size)
 static void omap_dma_write(void *opaque, hwaddr addr,
                            uint64_t value, unsigned size)
 {
     struct omap_dma_s *s = opaque;
     int reg, ch;
 
     if (size != 2) {
         omap_badwidth_write16(opaque, addr, value);
         return;
     }
 
     switch (addr) {
     case 0x300 ... 0x3fe:
         if (s->model <= omap_dma_3_1 || !s->omap_3_1_mapping_disabled) {
             if (omap_dma_3_1_lcd_write(&s->lcd_ch, addr, value))
                 break;
             return;
         }
-        /* Fall through.  */
+        fallthrough;
     case 0x000 ... 0x2fe:
         reg = addr & 0x3f;
         ch = (addr >> 6) & 0x0f;
         if (omap_dma_ch_reg_write(s, &s->ch[ch], reg, value))
             break;
         return;
 
     case 0x404 ... 0x4fe:
         if (s->model <= omap_dma_3_1)
             break;
-        /* fall through */
+        fallthrough;
     case 0x400:
         if (omap_dma_sys_write(s, addr, value))
             break;
         return;
 
     case 0xb00 ... 0xbfe:
         if (s->model == omap_dma_3_2 && s->omap_3_1_mapping_disabled) {
             if (omap_dma_3_2_lcd_write(&s->lcd_ch, addr, value))
                 break;
             return;
         }
         break;
     }
 
     OMAP_BAD_REG(addr);
 }
@@ -1702,155 +1702,155 @@ static void omap_dma_interrupts_4_update(struct omap_dma_s *s)
 static uint64_t omap_dma4_read(void *opaque, hwaddr addr,
                                unsigned size)
 {
     struct omap_dma_s *s = opaque;
     int irqn = 0, chnum;
     struct omap_dma_channel_s *ch;
 
     if (size == 1) {
         return omap_badwidth_read16(opaque, addr);
     }
 
     switch (addr) {
     case 0x00:	/* DMA4_REVISION */
         return 0x40;
 
     case 0x14:	/* DMA4_IRQSTATUS_L3 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x10:	/* DMA4_IRQSTATUS_L2 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x0c:	/* DMA4_IRQSTATUS_L1 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x08:	/* DMA4_IRQSTATUS_L0 */
         return s->irqstat[irqn];
 
     case 0x24:	/* DMA4_IRQENABLE_L3 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x20:	/* DMA4_IRQENABLE_L2 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x1c:	/* DMA4_IRQENABLE_L1 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x18:	/* DMA4_IRQENABLE_L0 */
         return s->irqen[irqn];
 
     case 0x28:	/* DMA4_SYSSTATUS */
         return 1;						/* RESETDONE */
 
     case 0x2c:	/* DMA4_OCP_SYSCONFIG */
         return s->ocp;
 
     case 0x64:	/* DMA4_CAPS_0 */
         return s->caps[0];
     case 0x6c:	/* DMA4_CAPS_2 */
         return s->caps[2];
     case 0x70:	/* DMA4_CAPS_3 */
         return s->caps[3];
     case 0x74:	/* DMA4_CAPS_4 */
         return s->caps[4];
 
     case 0x78:	/* DMA4_GCR */
         return s->gcr;
 
     case 0x80 ... 0xfff:
         addr -= 0x80;
         chnum = addr / 0x60;
         ch = s->ch + chnum;
         addr -= chnum * 0x60;
         break;
 
     default:
         OMAP_BAD_REG(addr);
         return 0;
     }
 
     /* Per-channel registers */
     switch (addr) {
     case 0x00:	/* DMA4_CCR */
         return (ch->buf_disable << 25) |
                 (ch->src_sync << 24) |
                 (ch->prefetch << 23) |
                 ((ch->sync & 0x60) << 14) |
                 (ch->bs << 18) |
                 (ch->transparent_copy << 17) |
                 (ch->constant_fill << 16) |
                 (ch->mode[1] << 14) |
                 (ch->mode[0] << 12) |
                 (0 << 10) | (0 << 9) |
                 (ch->suspend << 8) |
                 (ch->enable << 7) |
                 (ch->priority << 6) |
                 (ch->fs << 5) | (ch->sync & 0x1f);
 
     case 0x04:	/* DMA4_CLNK_CTRL */
         return (ch->link_enabled << 15) | ch->link_next_ch;
 
     case 0x08:	/* DMA4_CICR */
         return ch->interrupts;
 
     case 0x0c:	/* DMA4_CSR */
         return ch->cstatus;
 
     case 0x10:	/* DMA4_CSDP */
         return (ch->endian[0] << 21) |
                 (ch->endian_lock[0] << 20) |
                 (ch->endian[1] << 19) |
                 (ch->endian_lock[1] << 18) |
                 (ch->write_mode << 16) |
                 (ch->burst[1] << 14) |
                 (ch->pack[1] << 13) |
                 (ch->translate[1] << 9) |
                 (ch->burst[0] << 7) |
                 (ch->pack[0] << 6) |
                 (ch->translate[0] << 2) |
                 (ch->data_type >> 1);
 
     case 0x14:	/* DMA4_CEN */
         return ch->elements;
 
     case 0x18:	/* DMA4_CFN */
         return ch->frames;
 
     case 0x1c:	/* DMA4_CSSA */
         return ch->addr[0];
 
     case 0x20:	/* DMA4_CDSA */
         return ch->addr[1];
 
     case 0x24:	/* DMA4_CSEI */
         return ch->element_index[0];
 
     case 0x28:	/* DMA4_CSFI */
         return ch->frame_index[0];
 
     case 0x2c:	/* DMA4_CDEI */
         return ch->element_index[1];
 
     case 0x30:	/* DMA4_CDFI */
         return ch->frame_index[1];
 
     case 0x34:	/* DMA4_CSAC */
         return ch->active_set.src & 0xffff;
 
     case 0x38:	/* DMA4_CDAC */
         return ch->active_set.dest & 0xffff;
 
     case 0x3c:	/* DMA4_CCEN */
         return ch->active_set.element;
 
     case 0x40:	/* DMA4_CCFN */
         return ch->active_set.frame;
 
     case 0x44:	/* DMA4_COLOR */
         /* XXX only in sDMA */
         return ch->color;
 
     default:
         OMAP_BAD_REG(addr);
         return 0;
     }
 }
@@ -1858,213 +1858,213 @@ static uint64_t omap_dma4_read(void *opaque, hwaddr addr,
 static void omap_dma4_write(void *opaque, hwaddr addr,
                             uint64_t value, unsigned size)
 {
     struct omap_dma_s *s = opaque;
     int chnum, irqn = 0;
     struct omap_dma_channel_s *ch;
 
     if (size == 1) {
         omap_badwidth_write16(opaque, addr, value);
         return;
     }
 
     switch (addr) {
     case 0x14:	/* DMA4_IRQSTATUS_L3 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x10:	/* DMA4_IRQSTATUS_L2 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x0c:	/* DMA4_IRQSTATUS_L1 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x08:	/* DMA4_IRQSTATUS_L0 */
         s->irqstat[irqn] &= ~value;
         if (!s->irqstat[irqn])
             qemu_irq_lower(s->irq[irqn]);
         return;
 
     case 0x24:	/* DMA4_IRQENABLE_L3 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x20:	/* DMA4_IRQENABLE_L2 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x1c:	/* DMA4_IRQENABLE_L1 */
         irqn ++;
-        /* fall through */
+        fallthrough;
     case 0x18:	/* DMA4_IRQENABLE_L0 */
         s->irqen[irqn] = value;
         return;
 
     case 0x2c:	/* DMA4_OCP_SYSCONFIG */
         if (value & 2)						/* SOFTRESET */
             omap_dma_reset(s->dma);
         s->ocp = value & 0x3321;
         if (((s->ocp >> 12) & 3) == 3) { /* MIDLEMODE */
             qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid DMA power mode\n",
                           __func__);
         }
         return;
 
     case 0x78:	/* DMA4_GCR */
         s->gcr = value & 0x00ff00ff;
         if ((value & 0xff) == 0x00) { /* MAX_CHANNEL_FIFO_DEPTH */
             qemu_log_mask(LOG_GUEST_ERROR, "%s: wrong FIFO depth in GCR\n",
                           __func__);
         }
         return;
 
     case 0x80 ... 0xfff:
         addr -= 0x80;
         chnum = addr / 0x60;
         ch = s->ch + chnum;
         addr -= chnum * 0x60;
         break;
 
     case 0x00:	/* DMA4_REVISION */
     case 0x28:	/* DMA4_SYSSTATUS */
     case 0x64:	/* DMA4_CAPS_0 */
     case 0x6c:	/* DMA4_CAPS_2 */
     case 0x70:	/* DMA4_CAPS_3 */
     case 0x74:	/* DMA4_CAPS_4 */
         OMAP_RO_REG(addr);
         return;
 
     default:
         OMAP_BAD_REG(addr);
         return;
     }
 
     /* Per-channel registers */
     switch (addr) {
     case 0x00:	/* DMA4_CCR */
         ch->buf_disable = (value >> 25) & 1;
         ch->src_sync = (value >> 24) & 1;	/* XXX For CamDMA must be 1 */
         if (ch->buf_disable && !ch->src_sync) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: Buffering disable is not allowed in "
                           "destination synchronised mode\n", __func__);
         }
         ch->prefetch = (value >> 23) & 1;
         ch->bs = (value >> 18) & 1;
         ch->transparent_copy = (value >> 17) & 1;
         ch->constant_fill = (value >> 16) & 1;
         ch->mode[1] = (omap_dma_addressing_t) ((value & 0xc000) >> 14);
         ch->mode[0] = (omap_dma_addressing_t) ((value & 0x3000) >> 12);
         ch->suspend = (value & 0x0100) >> 8;
         ch->priority = (value & 0x0040) >> 6;
         ch->fs = (value & 0x0020) >> 5;
         if (ch->fs && ch->bs && ch->mode[0] && ch->mode[1]) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: For a packet transfer at least one port "
                           "must be constant-addressed\n", __func__);
         }
         ch->sync = (value & 0x001f) | ((value >> 14) & 0x0060);
         /* XXX must be 0x01 for CamDMA */
 
         if (value & 0x0080)
             omap_dma_enable_channel(s, ch);
         else
             omap_dma_disable_channel(s, ch);
 
         break;
 
     case 0x04:	/* DMA4_CLNK_CTRL */
         ch->link_enabled = (value >> 15) & 0x1;
         ch->link_next_ch = value & 0x1f;
         break;
 
     case 0x08:	/* DMA4_CICR */
         ch->interrupts = value & 0x09be;
         break;
 
     case 0x0c:	/* DMA4_CSR */
         ch->cstatus &= ~value;
         break;
 
     case 0x10:	/* DMA4_CSDP */
         ch->endian[0] =(value >> 21) & 1;
         ch->endian_lock[0] =(value >> 20) & 1;
         ch->endian[1] =(value >> 19) & 1;
         ch->endian_lock[1] =(value >> 18) & 1;
         if (ch->endian[0] != ch->endian[1]) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: DMA endianness conversion enable attempt\n",
                           __func__);
         }
         ch->write_mode = (value >> 16) & 3;
         ch->burst[1] = (value & 0xc000) >> 14;
         ch->pack[1] = (value & 0x2000) >> 13;
         ch->translate[1] = (value & 0x1e00) >> 9;
         ch->burst[0] = (value & 0x0180) >> 7;
         ch->pack[0] = (value & 0x0040) >> 6;
         ch->translate[0] = (value & 0x003c) >> 2;
         if (ch->translate[0] | ch->translate[1]) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: bad MReqAddressTranslate sideband signal\n",
                           __func__);
         }
         ch->data_type = 1 << (value & 3);
         if ((value & 3) == 3) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: bad data_type for DMA channel\n", __func__);
             ch->data_type >>= 1;
         }
         break;
 
     case 0x14:	/* DMA4_CEN */
         ch->set_update = 1;
         ch->elements = value & 0xffffff;
         break;
 
     case 0x18:	/* DMA4_CFN */
         ch->frames = value & 0xffff;
         ch->set_update = 1;
         break;
 
     case 0x1c:	/* DMA4_CSSA */
         ch->addr[0] = (hwaddr) (uint32_t) value;
         ch->set_update = 1;
         break;
 
     case 0x20:	/* DMA4_CDSA */
         ch->addr[1] = (hwaddr) (uint32_t) value;
         ch->set_update = 1;
         break;
 
     case 0x24:	/* DMA4_CSEI */
         ch->element_index[0] = (int16_t) value;
         ch->set_update = 1;
         break;
 
     case 0x28:	/* DMA4_CSFI */
         ch->frame_index[0] = (int32_t) value;
         ch->set_update = 1;
         break;
 
     case 0x2c:	/* DMA4_CDEI */
         ch->element_index[1] = (int16_t) value;
         ch->set_update = 1;
         break;
 
     case 0x30:	/* DMA4_CDFI */
         ch->frame_index[1] = (int32_t) value;
         ch->set_update = 1;
         break;
 
     case 0x44:	/* DMA4_COLOR */
         /* XXX only in sDMA */
         ch->color = value;
         break;
 
     case 0x34:	/* DMA4_CSAC */
     case 0x38:	/* DMA4_CDAC */
     case 0x3c:	/* DMA4_CCEN */
     case 0x40:	/* DMA4_CCFN */
         OMAP_RO_REG(addr);
         break;
 
     default:
         OMAP_BAD_REG(addr);
     }
 }
diff --git a/hw/dma/pxa2xx_dma.c b/hw/dma/pxa2xx_dma.c
index fa896f7edf..ac47256572 100644
--- a/hw/dma/pxa2xx_dma.c
+++ b/hw/dma/pxa2xx_dma.c
@@ -266,59 +266,59 @@ static void pxa2xx_dma_run(PXA2xxDMAState *s)
 static uint64_t pxa2xx_dma_read(void *opaque, hwaddr offset,
                                 unsigned size)
 {
     PXA2xxDMAState *s = (PXA2xxDMAState *) opaque;
     unsigned int channel;
 
     if (size != 4) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad access width %u\n",
                       __func__, size);
         return 5;
     }
 
     switch (offset) {
     case DRCMR64 ... DRCMR74:
         offset -= DRCMR64 - DRCMR0 - (64 << 2);
-        /* Fall through */
+        fallthrough;
     case DRCMR0 ... DRCMR63:
         channel = (offset - DRCMR0) >> 2;
         return s->req[channel];
 
     case DRQSR0:
     case DRQSR1:
     case DRQSR2:
         return 0;
 
     case DCSR0 ... DCSR31:
         channel = offset >> 2;
         if (s->chan[channel].request)
             return s->chan[channel].state | DCSR_REQPEND;
         return s->chan[channel].state;
 
     case DINT:
         return s->stopintr | s->eorintr | s->rasintr |
                 s->startintr | s->endintr;
 
     case DALGN:
         return s->align;
 
     case DPCSR:
         return s->pio;
     }
 
     if (offset >= D_CH0 && offset < D_CH0 + (s->channels << 4)) {
         channel = (offset - D_CH0) >> 4;
         switch ((offset & 0x0f) >> 2) {
         case DDADR:
             return s->chan[channel].descr;
         case DSADR:
             return s->chan[channel].src;
         case DTADR:
             return s->chan[channel].dest;
         case DCMD:
             return s->chan[channel].cmd;
         }
     }
     qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
                   __func__, offset);
     return 7;
 }
@@ -326,105 +326,105 @@ static uint64_t pxa2xx_dma_read(void *opaque, hwaddr offset,
 static void pxa2xx_dma_write(void *opaque, hwaddr offset,
                              uint64_t value, unsigned size)
 {
     PXA2xxDMAState *s = (PXA2xxDMAState *) opaque;
     unsigned int channel;
 
     if (size != 4) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad access width %u\n",
                       __func__, size);
         return;
     }
 
     switch (offset) {
     case DRCMR64 ... DRCMR74:
         offset -= DRCMR64 - DRCMR0 - (64 << 2);
-        /* Fall through */
+        fallthrough;
     case DRCMR0 ... DRCMR63:
         channel = (offset - DRCMR0) >> 2;
 
         if (value & DRCMR_MAPVLD)
             if ((value & DRCMR_CHLNUM) > s->channels)
                 hw_error("%s: Bad DMA channel %i\n",
                          __func__, (unsigned)value & DRCMR_CHLNUM);
 
         s->req[channel] = value;
         break;
 
     case DRQSR0:
     case DRQSR1:
     case DRQSR2:
         /* Nothing to do */
         break;
 
     case DCSR0 ... DCSR31:
         channel = offset >> 2;
         s->chan[channel].state &= 0x0000071f & ~(value &
                         (DCSR_EORINT | DCSR_ENDINTR |
                          DCSR_STARTINTR | DCSR_BUSERRINTR));
         s->chan[channel].state |= value & 0xfc800000;
 
         if (s->chan[channel].state & DCSR_STOPIRQEN)
             s->chan[channel].state &= ~DCSR_STOPINTR;
 
         if (value & DCSR_NODESCFETCH) {
             /* No-descriptor-fetch mode */
             if (value & DCSR_RUN) {
                 s->chan[channel].state &= ~DCSR_STOPINTR;
                 pxa2xx_dma_run(s);
             }
         } else {
             /* Descriptor-fetch mode */
             if (value & DCSR_RUN) {
                 s->chan[channel].state &= ~DCSR_STOPINTR;
                 pxa2xx_dma_descriptor_fetch(s, channel);
                 pxa2xx_dma_run(s);
             }
         }
 
         /* Shouldn't matter as our DMA is synchronous.  */
         if (!(value & (DCSR_RUN | DCSR_MASKRUN)))
             s->chan[channel].state |= DCSR_STOPINTR;
 
         if (value & DCSR_CLRCMPST)
             s->chan[channel].state &= ~DCSR_CMPST;
         if (value & DCSR_SETCMPST)
             s->chan[channel].state |= DCSR_CMPST;
 
         pxa2xx_dma_update(s, channel);
         break;
 
     case DALGN:
         s->align = value;
         break;
 
     case DPCSR:
         s->pio = value & 0x80000001;
         break;
 
     default:
         if (offset >= D_CH0 && offset < D_CH0 + (s->channels << 4)) {
             channel = (offset - D_CH0) >> 4;
             switch ((offset & 0x0f) >> 2) {
             case DDADR:
                 s->chan[channel].descr = value;
                 break;
             case DSADR:
                 s->chan[channel].src = value;
                 break;
             case DTADR:
                 s->chan[channel].dest = value;
                 break;
             case DCMD:
                 s->chan[channel].cmd = value;
                 break;
             default:
                 goto fail;
             }
 
             break;
         }
     fail:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
                       __func__, offset);
     }
 }
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 0ef13c5e9a..c68e068cc9 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -180,49 +180,49 @@ static uint64_t dma_mem_read(void *opaque, hwaddr addr,
 static void dma_mem_write(void *opaque, hwaddr addr,
                           uint64_t val, unsigned size)
 {
     DMADeviceState *s = opaque;
     uint32_t saddr;
 
     saddr = (addr & DMA_MASK) >> 2;
     trace_sparc32_dma_mem_writel(addr, s->dmaregs[saddr], val);
     switch (saddr) {
     case 0:
         if (val & DMA_INTREN) {
             if (s->dmaregs[0] & DMA_INTR) {
                 trace_sparc32_dma_set_irq_raise();
                 qemu_irq_raise(s->irq);
             }
         } else {
             if (s->dmaregs[0] & (DMA_INTR | DMA_INTREN)) {
                 trace_sparc32_dma_set_irq_lower();
                 qemu_irq_lower(s->irq);
             }
         }
         if (val & DMA_RESET) {
             qemu_irq_raise(s->gpio[GPIO_RESET]);
             qemu_irq_lower(s->gpio[GPIO_RESET]);
         } else if (val & DMA_DRAIN_FIFO) {
             val &= ~DMA_DRAIN_FIFO;
         } else if (val == 0)
             val = DMA_DRAIN_FIFO;
 
         if (val & DMA_EN && !(s->dmaregs[0] & DMA_EN)) {
             trace_sparc32_dma_enable_raise();
             qemu_irq_raise(s->gpio[GPIO_DMA]);
         } else if (!(val & DMA_EN) && !!(s->dmaregs[0] & DMA_EN)) {
             trace_sparc32_dma_enable_lower();
             qemu_irq_lower(s->gpio[GPIO_DMA]);
         }
 
         val &= ~DMA_CSR_RO_MASK;
         val |= DMA_VER;
         s->dmaregs[0] = (s->dmaregs[0] & DMA_CSR_RO_MASK) | val;
         break;
     case 1:
         s->dmaregs[0] |= DMA_LOADED;
-        /* fall through */
+        fallthrough;
     default:
         s->dmaregs[saddr] = val;
         break;
     }
 }
-- 
2.39.2



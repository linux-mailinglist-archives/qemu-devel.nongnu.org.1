Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 438557C7F3F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:02:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCz2-0004J1-DV; Fri, 13 Oct 2023 03:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxt-00017q-3o
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:09 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxV-0005Dd-1s
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:52:08 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso1637457f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183503; x=1697788303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LC6FOzdVPfj53c0PnkbeOhejYZ/A9OnwVnvV0AXUNRc=;
 b=S2xUST2XHx7Lm5ghakaW9YrT4H041Fm1qgwFtNFhQ9s+uL5IpdAt9qHIcIKxsbLEwS
 NnGfV5I2j9aJn84ddd9Ni7CwxfEzn58Hr140PaN2BDaMwrklPtTXs0KvJwFDvFZ9ec0/
 6AKZEyHG8k8uOsgUxlWzvxJ26d+x6huVEi69lh3rixCICspxWgz+osYNR1j5+l+Kt6jT
 BO7CJXXX07i0iJ7sVS+TfF+/GInKnGQovV2LVseLPA0FEknZBr2yGUcKEhLGUJzvrW0S
 pi2XQRVHyXkruZct/UmNVq51nNI5cKabYi0yP7/82nCPkmG3e5JtWxzSvVmGqOTw0iSV
 O11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183503; x=1697788303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LC6FOzdVPfj53c0PnkbeOhejYZ/A9OnwVnvV0AXUNRc=;
 b=HoEh3xBxkV8dj2FUW8qfnSMU0fBjuLmp5R0nadEXy/95KlgpfnqCzE2E/P2vTfRaUl
 hAjn6Tr9/l1Z4VS5e1H8AjG2II3SFN74T7FQ5WkXPr4ml0iLuuWltleDxWPdEJtn45tq
 HNRNBDkUnvxSrWiZ6uMI+17xL5u2gFeRjy8BbEJtzFiSsJl7Rm4DLiPY+ubWkxH8/1kf
 1owiCyNGVjmEhahKWlFGYLtAdNN2eIdl8Efcg+j1oY6WQ9DPhGZzGFOqXFMchTHEgiE7
 GhQxAQjv1sieTsveb20cLaVqbobtW9d/wr+Jlk4ymR2//sjE7Fuye8Dab1UJGPHyarpk
 HEsw==
X-Gm-Message-State: AOJu0YydByf0qTcY23JmrhUBlfYNRHGcTOTh8vBB+jIntJinb9TbZF7F
 47722pKahJr1wOv2FSsitsHe085VAM9Ue1RclkM=
X-Google-Smtp-Source: AGHT+IEg10LJ4AQ5JNLSSunBxQwERjJRIZUTobKAVs+urJCPguBUbLDwbXcClgHConRAgMIh2igEXg==
X-Received: by 2002:a05:6000:369:b0:324:e284:fac2 with SMTP id
 f9-20020a056000036900b00324e284fac2mr21163301wrf.5.1697183503210; 
 Fri, 13 Oct 2023 00:51:43 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:42 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH 49/78] hw/arm: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:48:05 +0300
Message-Id: <b2fea0a8886b9726ab1621946b8dc2d6d6a778dc.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x430.google.com
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
 hw/arm/omap1.c     | 8 ++++----
 hw/arm/pxa2xx.c    | 6 +++---
 hw/arm/stellaris.c | 1 +
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index d5438156ee..c54a4ec553 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -531,46 +531,46 @@ static struct omap_32khz_timer_s *omap_os_timer_init(MemoryRegion *memory,
 /* Ultra Low-Power Device Module */
 static uint64_t omap_ulpd_pm_read(void *opaque, hwaddr addr,
                                   unsigned size)
 {
     struct omap_mpu_state_s *s = opaque;
     uint16_t ret;
 
     if (size != 2) {
         return omap_badwidth_read16(opaque, addr);
     }
 
     switch (addr) {
     case 0x14:	/* IT_STATUS */
         ret = s->ulpd_pm_regs[addr >> 2];
         s->ulpd_pm_regs[addr >> 2] = 0;
         qemu_irq_lower(qdev_get_gpio_in(s->ih[1], OMAP_INT_GAUGE_32K));
         return ret;
 
     case 0x18:	/* Reserved */
     case 0x1c:	/* Reserved */
     case 0x20:	/* Reserved */
     case 0x28:	/* Reserved */
     case 0x2c:	/* Reserved */
         OMAP_BAD_REG(addr);
-        /* fall through */
+        fallthrough;
     case 0x00:	/* COUNTER_32_LSB */
     case 0x04:	/* COUNTER_32_MSB */
     case 0x08:	/* COUNTER_HIGH_FREQ_LSB */
     case 0x0c:	/* COUNTER_HIGH_FREQ_MSB */
     case 0x10:	/* GAUGING_CTRL */
     case 0x24:	/* SETUP_ANALOG_CELL3_ULPD1 */
     case 0x30:	/* CLOCK_CTRL */
     case 0x34:	/* SOFT_REQ */
     case 0x38:	/* COUNTER_32_FIQ */
     case 0x3c:	/* DPLL_CTRL */
     case 0x40:	/* STATUS_REQ */
         /* XXX: check clk::usecount state for every clock */
     case 0x48:	/* LOCL_TIME */
     case 0x4c:	/* APLL_CTRL */
     case 0x50:	/* POWER_CTRL */
         return s->ulpd_pm_regs[addr >> 2];
     }
 
     OMAP_BAD_REG(addr);
     return 0;
 }
@@ -600,120 +600,120 @@ static inline void omap_ulpd_req_update(struct omap_mpu_state_s *s,
 static void omap_ulpd_pm_write(void *opaque, hwaddr addr,
                                uint64_t value, unsigned size)
 {
     struct omap_mpu_state_s *s = opaque;
     int64_t now, ticks;
     int div, mult;
     static const int bypass_div[4] = { 1, 2, 4, 4 };
     uint16_t diff;
 
     if (size != 2) {
         omap_badwidth_write16(opaque, addr, value);
         return;
     }
 
     switch (addr) {
     case 0x00:	/* COUNTER_32_LSB */
     case 0x04:	/* COUNTER_32_MSB */
     case 0x08:	/* COUNTER_HIGH_FREQ_LSB */
     case 0x0c:	/* COUNTER_HIGH_FREQ_MSB */
     case 0x14:	/* IT_STATUS */
     case 0x40:	/* STATUS_REQ */
         OMAP_RO_REG(addr);
         break;
 
     case 0x10:	/* GAUGING_CTRL */
         /* Bits 0 and 1 seem to be confused in the OMAP 310 TRM */
         if ((s->ulpd_pm_regs[addr >> 2] ^ value) & 1) {
             now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
             if (value & 1)
                 s->ulpd_gauge_start = now;
             else {
                 now -= s->ulpd_gauge_start;
 
                 /* 32-kHz ticks */
                 ticks = muldiv64(now, 32768, NANOSECONDS_PER_SECOND);
                 s->ulpd_pm_regs[0x00 >> 2] = (ticks >>  0) & 0xffff;
                 s->ulpd_pm_regs[0x04 >> 2] = (ticks >> 16) & 0xffff;
                 if (ticks >> 32)	/* OVERFLOW_32K */
                     s->ulpd_pm_regs[0x14 >> 2] |= 1 << 2;
 
                 /* High frequency ticks */
                 ticks = muldiv64(now, 12000000, NANOSECONDS_PER_SECOND);
                 s->ulpd_pm_regs[0x08 >> 2] = (ticks >>  0) & 0xffff;
                 s->ulpd_pm_regs[0x0c >> 2] = (ticks >> 16) & 0xffff;
                 if (ticks >> 32)	/* OVERFLOW_HI_FREQ */
                     s->ulpd_pm_regs[0x14 >> 2] |= 1 << 1;
 
                 s->ulpd_pm_regs[0x14 >> 2] |= 1 << 0;	/* IT_GAUGING */
                 qemu_irq_raise(qdev_get_gpio_in(s->ih[1], OMAP_INT_GAUGE_32K));
             }
         }
         s->ulpd_pm_regs[addr >> 2] = value;
         break;
 
     case 0x18:	/* Reserved */
     case 0x1c:	/* Reserved */
     case 0x20:	/* Reserved */
     case 0x28:	/* Reserved */
     case 0x2c:	/* Reserved */
         OMAP_BAD_REG(addr);
-        /* fall through */
+        fallthrough;
     case 0x24:	/* SETUP_ANALOG_CELL3_ULPD1 */
     case 0x38:	/* COUNTER_32_FIQ */
     case 0x48:	/* LOCL_TIME */
     case 0x50:	/* POWER_CTRL */
         s->ulpd_pm_regs[addr >> 2] = value;
         break;
 
     case 0x30:	/* CLOCK_CTRL */
         diff = s->ulpd_pm_regs[addr >> 2] ^ value;
         s->ulpd_pm_regs[addr >> 2] = value & 0x3f;
         omap_ulpd_clk_update(s, diff, value);
         break;
 
     case 0x34:	/* SOFT_REQ */
         diff = s->ulpd_pm_regs[addr >> 2] ^ value;
         s->ulpd_pm_regs[addr >> 2] = value & 0x1f;
         omap_ulpd_req_update(s, diff, value);
         break;
 
     case 0x3c:	/* DPLL_CTRL */
         /* XXX: OMAP310 TRM claims bit 3 is PLL_ENABLE, and bit 4 is
          * omitted altogether, probably a typo.  */
         /* This register has identical semantics with DPLL(1:3) control
          * registers, see omap_dpll_write() */
         diff = s->ulpd_pm_regs[addr >> 2] & value;
         s->ulpd_pm_regs[addr >> 2] = value & 0x2fff;
         if (diff & (0x3ff << 2)) {
             if (value & (1 << 4)) {			/* PLL_ENABLE */
                 div = ((value >> 5) & 3) + 1;		/* PLL_DIV */
                 mult = MIN((value >> 7) & 0x1f, 1);	/* PLL_MULT */
             } else {
                 div = bypass_div[((value >> 2) & 3)];	/* BYPASS_DIV */
                 mult = 1;
             }
             omap_clk_setrate(omap_findclk(s, "dpll4"), div, mult);
         }
 
         /* Enter the desired mode.  */
         s->ulpd_pm_regs[addr >> 2] =
                 (s->ulpd_pm_regs[addr >> 2] & 0xfffe) |
                 ((s->ulpd_pm_regs[addr >> 2] >> 4) & 1);
 
         /* Act as if the lock is restored.  */
         s->ulpd_pm_regs[addr >> 2] |= 2;
         break;
 
     case 0x4c:	/* APLL_CTRL */
         diff = s->ulpd_pm_regs[addr >> 2] & value;
         s->ulpd_pm_regs[addr >> 2] = value & 0xf;
         if (diff & (1 << 0))				/* APLL_NDPLL_SWITCH */
             omap_clk_reparent(omap_findclk(s, "ck_48m"), omap_findclk(s,
                                     (value & (1 << 0)) ? "apll" : "dpll4"));
         break;
 
     default:
         OMAP_BAD_REG(addr);
     }
 }
@@ -3169,97 +3169,97 @@ static void omap_mcbsp_req_update(struct omap_mcbsp_s *s)
 static uint64_t omap_mcbsp_read(void *opaque, hwaddr addr,
                                 unsigned size)
 {
     struct omap_mcbsp_s *s = opaque;
     int offset = addr & OMAP_MPUI_REG_MASK;
     uint16_t ret;
 
     if (size != 2) {
         return omap_badwidth_read16(opaque, addr);
     }
 
     switch (offset) {
     case 0x00:	/* DRR2 */
         if (((s->rcr[0] >> 5) & 7) < 3)			/* RWDLEN1 */
             return 0x0000;
-        /* Fall through.  */
+        fallthrough;
     case 0x02:	/* DRR1 */
         if (s->rx_req < 2) {
             printf("%s: Rx FIFO underrun\n", __func__);
             omap_mcbsp_rx_done(s);
         } else {
             s->tx_req -= 2;
             if (s->codec && s->codec->in.len >= 2) {
                 ret = s->codec->in.fifo[s->codec->in.start ++] << 8;
                 ret |= s->codec->in.fifo[s->codec->in.start ++];
                 s->codec->in.len -= 2;
             } else
                 ret = 0x0000;
             if (!s->tx_req)
                 omap_mcbsp_rx_done(s);
             return ret;
         }
         return 0x0000;
 
     case 0x04:	/* DXR2 */
     case 0x06:	/* DXR1 */
         return 0x0000;
 
     case 0x08:	/* SPCR2 */
         return s->spcr[1];
     case 0x0a:	/* SPCR1 */
         return s->spcr[0];
     case 0x0c:	/* RCR2 */
         return s->rcr[1];
     case 0x0e:	/* RCR1 */
         return s->rcr[0];
     case 0x10:	/* XCR2 */
         return s->xcr[1];
     case 0x12:	/* XCR1 */
         return s->xcr[0];
     case 0x14:	/* SRGR2 */
         return s->srgr[1];
     case 0x16:	/* SRGR1 */
         return s->srgr[0];
     case 0x18:	/* MCR2 */
         return s->mcr[1];
     case 0x1a:	/* MCR1 */
         return s->mcr[0];
     case 0x1c:	/* RCERA */
         return s->rcer[0];
     case 0x1e:	/* RCERB */
         return s->rcer[1];
     case 0x20:	/* XCERA */
         return s->xcer[0];
     case 0x22:	/* XCERB */
         return s->xcer[1];
     case 0x24:	/* PCR0 */
         return s->pcr;
     case 0x26:	/* RCERC */
         return s->rcer[2];
     case 0x28:	/* RCERD */
         return s->rcer[3];
     case 0x2a:	/* XCERC */
         return s->xcer[2];
     case 0x2c:	/* XCERD */
         return s->xcer[3];
     case 0x2e:	/* RCERE */
         return s->rcer[4];
     case 0x30:	/* RCERF */
         return s->rcer[5];
     case 0x32:	/* XCERE */
         return s->xcer[4];
     case 0x34:	/* XCERF */
         return s->xcer[5];
     case 0x36:	/* RCERG */
         return s->rcer[6];
     case 0x38:	/* RCERH */
         return s->rcer[7];
     case 0x3a:	/* XCERG */
         return s->xcer[6];
     case 0x3c:	/* XCERH */
         return s->xcer[7];
     }
 
     OMAP_BAD_REG(addr);
     return 0;
 }
@@ -3267,135 +3267,135 @@ static uint64_t omap_mcbsp_read(void *opaque, hwaddr addr,
 static void omap_mcbsp_writeh(void *opaque, hwaddr addr,
                 uint32_t value)
 {
     struct omap_mcbsp_s *s = opaque;
     int offset = addr & OMAP_MPUI_REG_MASK;
 
     switch (offset) {
     case 0x00:	/* DRR2 */
     case 0x02:	/* DRR1 */
         OMAP_RO_REG(addr);
         return;
 
     case 0x04:	/* DXR2 */
         if (((s->xcr[0] >> 5) & 7) < 3)			/* XWDLEN1 */
             return;
-        /* Fall through.  */
+        fallthrough;
     case 0x06:	/* DXR1 */
         if (s->tx_req > 1) {
             s->tx_req -= 2;
             if (s->codec && s->codec->cts) {
                 s->codec->out.fifo[s->codec->out.len ++] = (value >> 8) & 0xff;
                 s->codec->out.fifo[s->codec->out.len ++] = (value >> 0) & 0xff;
             }
             if (s->tx_req < 2)
                 omap_mcbsp_tx_done(s);
         } else
             printf("%s: Tx FIFO overrun\n", __func__);
         return;
 
     case 0x08:	/* SPCR2 */
         s->spcr[1] &= 0x0002;
         s->spcr[1] |= 0x03f9 & value;
         s->spcr[1] |= 0x0004 & (value << 2);		/* XEMPTY := XRST */
         if (~value & 1)					/* XRST */
             s->spcr[1] &= ~6;
         omap_mcbsp_req_update(s);
         return;
     case 0x0a:	/* SPCR1 */
         s->spcr[0] &= 0x0006;
         s->spcr[0] |= 0xf8f9 & value;
         if (value & (1 << 15))				/* DLB */
             printf("%s: Digital Loopback mode enable attempt\n", __func__);
         if (~value & 1) {				/* RRST */
             s->spcr[0] &= ~6;
             s->rx_req = 0;
             omap_mcbsp_rx_done(s);
         }
         omap_mcbsp_req_update(s);
         return;
 
     case 0x0c:	/* RCR2 */
         s->rcr[1] = value & 0xffff;
         return;
     case 0x0e:	/* RCR1 */
         s->rcr[0] = value & 0x7fe0;
         return;
     case 0x10:	/* XCR2 */
         s->xcr[1] = value & 0xffff;
         return;
     case 0x12:	/* XCR1 */
         s->xcr[0] = value & 0x7fe0;
         return;
     case 0x14:	/* SRGR2 */
         s->srgr[1] = value & 0xffff;
         omap_mcbsp_req_update(s);
         return;
     case 0x16:	/* SRGR1 */
         s->srgr[0] = value & 0xffff;
         omap_mcbsp_req_update(s);
         return;
     case 0x18:	/* MCR2 */
         s->mcr[1] = value & 0x03e3;
         if (value & 3)					/* XMCM */
             printf("%s: Tx channel selection mode enable attempt\n", __func__);
         return;
     case 0x1a:	/* MCR1 */
         s->mcr[0] = value & 0x03e1;
         if (value & 1)					/* RMCM */
             printf("%s: Rx channel selection mode enable attempt\n", __func__);
         return;
     case 0x1c:	/* RCERA */
         s->rcer[0] = value & 0xffff;
         return;
     case 0x1e:	/* RCERB */
         s->rcer[1] = value & 0xffff;
         return;
     case 0x20:	/* XCERA */
         s->xcer[0] = value & 0xffff;
         return;
     case 0x22:	/* XCERB */
         s->xcer[1] = value & 0xffff;
         return;
     case 0x24:	/* PCR0 */
         s->pcr = value & 0x7faf;
         return;
     case 0x26:	/* RCERC */
         s->rcer[2] = value & 0xffff;
         return;
     case 0x28:	/* RCERD */
         s->rcer[3] = value & 0xffff;
         return;
     case 0x2a:	/* XCERC */
         s->xcer[2] = value & 0xffff;
         return;
     case 0x2c:	/* XCERD */
         s->xcer[3] = value & 0xffff;
         return;
     case 0x2e:	/* RCERE */
         s->rcer[4] = value & 0xffff;
         return;
     case 0x30:	/* RCERF */
         s->rcer[5] = value & 0xffff;
         return;
     case 0x32:	/* XCERE */
         s->xcer[4] = value & 0xffff;
         return;
     case 0x34:	/* XCERF */
         s->xcer[5] = value & 0xffff;
         return;
     case 0x36:	/* RCERG */
         s->rcer[6] = value & 0xffff;
         return;
     case 0x38:	/* RCERH */
         s->rcer[7] = value & 0xffff;
         return;
     case 0x3a:	/* XCERG */
         s->xcer[6] = value & 0xffff;
         return;
     case 0x3c:	/* XCERH */
         s->xcer[7] = value & 0xffff;
         return;
     }
 
     OMAP_BAD_REG(addr);
 }
diff --git a/hw/arm/pxa2xx.c b/hw/arm/pxa2xx.c
index 07d5dd8691..eaa6684243 100644
--- a/hw/arm/pxa2xx.c
+++ b/hw/arm/pxa2xx.c
@@ -265,68 +265,68 @@ static void pxa2xx_clkcfg_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void pxa2xx_pwrmode_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
     PXA2xxState *s = (PXA2xxState *)ri->opaque;
     static const char *pwrmode[8] = {
         "Normal", "Idle", "Deep-idle", "Standby",
         "Sleep", "reserved (!)", "reserved (!)", "Deep-sleep",
     };
 
     if (value & 8) {
         printf("%s: CPU voltage change attempt\n", __func__);
     }
     switch (value & 7) {
     case 0:
         /* Do nothing */
         break;
 
     case 1:
         /* Idle */
         if (!(s->cm_regs[CCCR >> 2] & (1U << 31))) { /* CPDIS */
             cpu_interrupt(CPU(s->cpu), CPU_INTERRUPT_HALT);
             break;
         }
-        /* Fall through.  */
+        fallthrough;
 
     case 2:
         /* Deep-Idle */
         cpu_interrupt(CPU(s->cpu), CPU_INTERRUPT_HALT);
         s->pm_regs[RCSR >> 2] |= 0x8; /* Set GPR */
         goto message;
 
     case 3:
         s->cpu->env.uncached_cpsr = ARM_CPU_MODE_SVC;
         s->cpu->env.daif = PSTATE_A | PSTATE_F | PSTATE_I;
         s->cpu->env.cp15.sctlr_ns = 0;
         s->cpu->env.cp15.cpacr_el1 = 0;
         s->cpu->env.cp15.ttbr0_el[1] = 0;
         s->cpu->env.cp15.dacr_ns = 0;
         s->pm_regs[PSSR >> 2] |= 0x8; /* Set STS */
         s->pm_regs[RCSR >> 2] |= 0x8; /* Set GPR */
 
         /*
          * The scratch-pad register is almost universally used
          * for storing the return address on suspend.  For the
          * lack of a resuming bootloader, perform a jump
          * directly to that address.
          */
         memset(s->cpu->env.regs, 0, 4 * 15);
         s->cpu->env.regs[15] = s->pm_regs[PSPR >> 2];
 
 #if 0
         buffer = 0xe59ff000; /* ldr     pc, [pc, #0] */
         cpu_physical_memory_write(0, &buffer, 4);
         buffer = s->pm_regs[PSPR >> 2];
         cpu_physical_memory_write(8, &buffer, 4);
 #endif
 
         /* Suspend */
         cpu_interrupt(current_cpu, CPU_INTERRUPT_HALT);
 
         goto message;
 
     default:
     message:
         printf("%s: machine entered %s mode\n", __func__,
                pwrmode[value & 7]);
     }
 }
@@ -419,18 +419,18 @@ static void pxa2xx_setup_cp14(PXA2xxState *s)
 static uint64_t pxa2xx_mm_read(void *opaque, hwaddr addr,
                                unsigned size)
 {
     PXA2xxState *s = (PXA2xxState *) opaque;
 
     switch (addr) {
     case MDCNFG ... SA1110:
         if ((addr & 3) == 0)
             return s->mm_regs[addr >> 2];
-        /* fall through */
+        fallthrough;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad read offset 0x%"HWADDR_PRIx"\n",
                       __func__, addr);
         break;
     }
     return 0;
 }
@@ -438,19 +438,19 @@ static uint64_t pxa2xx_mm_read(void *opaque, hwaddr addr,
 static void pxa2xx_mm_write(void *opaque, hwaddr addr,
                             uint64_t value, unsigned size)
 {
     PXA2xxState *s = (PXA2xxState *) opaque;
 
     switch (addr) {
     case MDCNFG ... SA1110:
         if ((addr & 3) == 0) {
             s->mm_regs[addr >> 2] = value;
             break;
         }
-        /* fallthrough */
+        fallthrough;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: Bad write offset 0x%"HWADDR_PRIx"\n",
                       __func__, addr);
         break;
     }
 }
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index aa5b0ddfaa..d68602ab71 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -147,20 +147,21 @@ static uint32_t pllcfg_fury[16] = {
 static int ssys_board_class(const ssys_state *s)
 {
     uint32_t did0 = s->did0;
     switch (did0 & DID0_VER_MASK) {
     case DID0_VER_0:
         return DID0_CLASS_SANDSTORM;
     case DID0_VER_1:
         switch (did0 & DID0_CLASS_MASK) {
         case DID0_CLASS_SANDSTORM:
         case DID0_CLASS_FURY:
             return did0 & DID0_CLASS_MASK;
         }
         /* for unknown classes, fall through */
+        fallthrough;
     default:
         /* This can only happen if the hardwired constant did0 value
          * in this board's stellaris_board_info struct is wrong.
          */
         g_assert_not_reached();
     }
 }
-- 
2.39.2



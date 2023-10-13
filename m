Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D347C7FF8
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:21:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD6O-0002un-5S; Fri, 13 Oct 2023 04:00:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5h-0008IZ-2Q
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:13 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5e-0007Zf-HY
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:00:12 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5041335fb9cso2336899e87.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697184007; x=1697788807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xmf183b4ta6tcMGecZtTP0rIT/9ZmK0d0ilVGrqNESE=;
 b=bNHUZbZhoEsz+/pPoh0hhjp+D32TtpuMH2Rn2luDICnGWGA4BSzSxfW57mf1WwtZDK
 TBQQ/BLTatC0uYvq1iCj9GzAVNlbm+FhmFD6c9uPDkpTpxdKiMuyy+czIaJHpw4ZHWkr
 u1tCL8rt5qWq9zkAhCgulSpWBSnfiw0ctP+pQKvu2cM4qeu5keLZvkzJQ85skOpvZ7JM
 YL4Y1WiHxzVYBzojDAk1+D/jqq+J7yk+T0V5no+Ehip8RpIyRzEw6z7ux2J40/NEZnJp
 7VnG0Q7dKR0oxquPd/FP8cy/gAJHQR63gC27rnEZqLuRAa453JDNVxBWh6duAO7iP85z
 rCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697184007; x=1697788807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xmf183b4ta6tcMGecZtTP0rIT/9ZmK0d0ilVGrqNESE=;
 b=dxcgbm5KJbT/9yibLHgJEgnt+9nVyPMKHlp3zSKM+mSGP8/omXC7GyQVwVEHNZGU8s
 h29dyuQ3C8IhvvCviphlURruTuzOsMsuI0usrkgCSDHXHR33ce1WkY8sqvjgSOLMymHJ
 kQlnRSn85g+ut6svHoZ6Bynoa03wtGZRYDYdLZMUYrGdWE4QbPfUkLwUoEH1FKMDTpDn
 aaKiLuworduqn8es7Y+/FyOk0nLJexEsFm7qSNkvWKLVRVCxJMuDPKBx7UAZvWYCyCyj
 BQqdFQDZkyQ2H8foAruwEO9R66fO5AGzZrQB1JNPAptLKwLyx4FbhLic6f49QM1R6ZiF
 qi4Q==
X-Gm-Message-State: AOJu0YwiN9cS3kTtzp25/m5370JSUwZmEfnFw/Mi0lXHKZuPKSP+6xD9
 NATZh2XhIQRwEwqOM54DLnMh268rB0LsG018qM4=
X-Google-Smtp-Source: AGHT+IElDsS3nMm3rKvstY8pjfBCXVdh903/YqjQBzvQCBIGqZ8/X+PnKajM7tFuBSrFU9OX7trYQg==
X-Received: by 2002:a05:6512:1104:b0:500:98ff:4162 with SMTP id
 l4-20020a056512110400b0050098ff4162mr26921139lfg.40.1697184007302; 
 Fri, 13 Oct 2023 01:00:07 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.01.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:00:06 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Nuvoton NPCM7xx)
Subject: [RFC PATCH v2 72/78] hw/ssi: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:39 +0300
Message-Id: <b91b0b3d02447d987b3191f0f8ff26afb54a05d5.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 hw/ssi/npcm7xx_fiu.c | 14 ++++++-------
 hw/ssi/omap_spi.c    | 48 ++++++++++++++++++++++----------------------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
index 4eedb2927e..fadd66a675 100644
--- a/hw/ssi/npcm7xx_fiu.c
+++ b/hw/ssi/npcm7xx_fiu.c
@@ -145,103 +145,103 @@ static void npcm7xx_fiu_deselect(NPCM7xxFIUState *s)
 /* Direct flash memory read handler. */
 static uint64_t npcm7xx_fiu_flash_read(void *opaque, hwaddr addr,
                                        unsigned int size)
 {
     NPCM7xxFIUFlash *f = opaque;
     NPCM7xxFIUState *fiu = f->fiu;
     uint64_t value = 0;
     uint32_t drd_cfg;
     int dummy_cycles;
     int i;
 
     if (fiu->active_cs != -1) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: direct flash read with CS%d already active",
                       DEVICE(fiu)->canonical_path, fiu->active_cs);
     }
 
     npcm7xx_fiu_select(fiu, npcm7xx_fiu_cs_index(fiu, f));
 
     drd_cfg = fiu->regs[NPCM7XX_FIU_DRD_CFG];
     ssi_transfer(fiu->spi, FIU_DRD_CFG_RDCMD(drd_cfg));
 
     switch (FIU_DRD_CFG_ADDSIZ(drd_cfg)) {
     case FIU_ADDSIZ_4BYTES:
         ssi_transfer(fiu->spi, extract32(addr, 24, 8));
-        /* fall through */
+        fallthrough;
     case FIU_ADDSIZ_3BYTES:
         ssi_transfer(fiu->spi, extract32(addr, 16, 8));
         ssi_transfer(fiu->spi, extract32(addr, 8, 8));
         ssi_transfer(fiu->spi, extract32(addr, 0, 8));
         break;
 
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: bad address size %d\n",
                       DEVICE(fiu)->canonical_path, FIU_DRD_CFG_ADDSIZ(drd_cfg));
         break;
     }
 
     /* Flash chip model expects one transfer per dummy bit, not byte */
     dummy_cycles =
         (FIU_DRD_CFG_DBW(drd_cfg) * 8) >> FIU_DRD_CFG_ACCTYPE(drd_cfg);
     for (i = 0; i < dummy_cycles; i++) {
         ssi_transfer(fiu->spi, 0);
     }
 
     for (i = 0; i < size; i++) {
         value = deposit64(value, 8 * i, 8, ssi_transfer(fiu->spi, 0));
     }
 
     trace_npcm7xx_fiu_flash_read(DEVICE(fiu)->canonical_path, fiu->active_cs,
                                  addr, size, value);
 
     npcm7xx_fiu_deselect(fiu);
 
     return value;
 }
 
 /* Direct flash memory write handler. */
 static void npcm7xx_fiu_flash_write(void *opaque, hwaddr addr, uint64_t v,
                                     unsigned int size)
 {
     NPCM7xxFIUFlash *f = opaque;
     NPCM7xxFIUState *fiu = f->fiu;
     uint32_t dwr_cfg;
     unsigned cs_id;
     int i;
 
     if (fiu->active_cs != -1) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: direct flash write with CS%d already active",
                       DEVICE(fiu)->canonical_path, fiu->active_cs);
     }
 
     cs_id = npcm7xx_fiu_cs_index(fiu, f);
     trace_npcm7xx_fiu_flash_write(DEVICE(fiu)->canonical_path, cs_id, addr,
                                   size, v);
     npcm7xx_fiu_select(fiu, cs_id);
 
     dwr_cfg = fiu->regs[NPCM7XX_FIU_DWR_CFG];
     ssi_transfer(fiu->spi, FIU_DWR_CFG_WRCMD(dwr_cfg));
 
     switch (FIU_DWR_CFG_ADDSIZ(dwr_cfg)) {
     case FIU_ADDSIZ_4BYTES:
         ssi_transfer(fiu->spi, extract32(addr, 24, 8));
-        /* fall through */
+        fallthrough;
     case FIU_ADDSIZ_3BYTES:
         ssi_transfer(fiu->spi, extract32(addr, 16, 8));
         ssi_transfer(fiu->spi, extract32(addr, 8, 8));
         ssi_transfer(fiu->spi, extract32(addr, 0, 8));
         break;
 
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: bad address size %d\n",
                       DEVICE(fiu)->canonical_path, FIU_DWR_CFG_ADDSIZ(dwr_cfg));
         break;
     }
 
     for (i = 0; i < size; i++) {
         ssi_transfer(fiu->spi, extract64(v, i * 8, 8));
     }
 
     npcm7xx_fiu_deselect(fiu);
 }
@@ -282,22 +282,22 @@ static uint64_t npcm7xx_fiu_ctrl_read(void *opaque, hwaddr addr,
 /* Send the specified number of address bytes from the UMA address register. */
 static void send_address(SSIBus *spi, unsigned int addsiz, uint32_t addr)
 {
     switch (addsiz) {
     case 4:
         ssi_transfer(spi, extract32(addr, 24, 8));
-        /* fall through */
+        fallthrough;
     case 3:
         ssi_transfer(spi, extract32(addr, 16, 8));
-        /* fall through */
+        fallthrough;
     case 2:
         ssi_transfer(spi, extract32(addr, 8, 8));
-        /* fall through */
+        fallthrough;
     case 1:
         ssi_transfer(spi, extract32(addr, 0, 8));
-        /* fall through */
+        fallthrough;
     case 0:
         break;
     }
 }
 
 /* Send the number of dummy bits specified in the UMA config register. */
@@ -378,79 +378,79 @@ static void npcm7xx_fiu_uma_transaction(NPCM7xxFIUState *s)
 /* Control register write handler. */
 static void npcm7xx_fiu_ctrl_write(void *opaque, hwaddr addr, uint64_t v,
                                    unsigned int size)
 {
     hwaddr reg = addr / sizeof(uint32_t);
     NPCM7xxFIUState *s = opaque;
     uint32_t value = v;
 
     trace_npcm7xx_fiu_ctrl_write(DEVICE(s)->canonical_path, addr, value);
 
     switch (reg) {
     case NPCM7XX_FIU_UMA_CFG:
         if (s->regs[reg] & FIU_UMA_CFG_CMMLCK) {
             value &= ~FIU_UMA_CFG_CMMLCK_MASK;
             value |= (s->regs[reg] & FIU_UMA_CFG_CMMLCK_MASK);
         }
-        /* fall through */
+        fallthrough;
     case NPCM7XX_FIU_DRD_CFG:
     case NPCM7XX_FIU_DWR_CFG:
         if (s->regs[reg] & NPCM7XX_FIU_CFG_LCK) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: write to locked register @ 0x%" PRIx64 "\n",
                           DEVICE(s)->canonical_path, addr);
             return;
         }
         s->regs[reg] = value;
         break;
 
     case NPCM7XX_FIU_UMA_CTS:
         if (value & FIU_UMA_CTS_RDYST) {
             value &= ~FIU_UMA_CTS_RDYST;
         } else {
             value |= s->regs[reg] & FIU_UMA_CTS_RDYST;
         }
         if ((s->regs[reg] ^ value) & FIU_UMA_CTS_SW_CS) {
             if (value & FIU_UMA_CTS_SW_CS) {
                 /*
                  * Don't drop CS if there's a transfer in progress, or we're
                  * about to start one.
                  */
                 if (!((value | s->regs[reg]) & FIU_UMA_CTS_EXEC_DONE)) {
                     npcm7xx_fiu_deselect(s);
                 }
             } else {
                 int cs_id = FIU_UMA_CTS_DEV_NUM(s->regs[NPCM7XX_FIU_UMA_CTS]);
                 npcm7xx_fiu_select(s, cs_id);
             }
         }
         s->regs[reg] = value | (s->regs[reg] & FIU_UMA_CTS_EXEC_DONE);
         if (value & FIU_UMA_CTS_EXEC_DONE) {
             npcm7xx_fiu_uma_transaction(s);
         }
         break;
 
     case NPCM7XX_FIU_UMA_DR0 ... NPCM7XX_FIU_UMA_DR3:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: write to read-only register @ 0x%" PRIx64 "\n",
                       DEVICE(s)->canonical_path, addr);
         return;
 
     case NPCM7XX_FIU_PRT_CFG:
     case NPCM7XX_FIU_PRT_CMD0 ... NPCM7XX_FIU_PRT_CMD9:
         qemu_log_mask(LOG_UNIMP, "%s: PRT is not implemented\n", __func__);
         break;
 
     case NPCM7XX_FIU_UMA_CMD:
     case NPCM7XX_FIU_UMA_ADDR:
     case NPCM7XX_FIU_UMA_DW0 ... NPCM7XX_FIU_UMA_DW3:
     case NPCM7XX_FIU_CFG:
         s->regs[reg] = value;
         break;
 
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: write to invalid offset 0x%" PRIx64 "\n",
                       DEVICE(s)->canonical_path, addr);
         return;
     }
 }
diff --git a/hw/ssi/omap_spi.c b/hw/ssi/omap_spi.c
index 8f85c3e391..a0f367bd17 100644
--- a/hw/ssi/omap_spi.c
+++ b/hw/ssi/omap_spi.c
@@ -137,87 +137,87 @@ void omap_mcspi_reset(struct omap_mcspi_s *s)
 static uint64_t omap_mcspi_read(void *opaque, hwaddr addr, unsigned size)
 {
     struct omap_mcspi_s *s = opaque;
     int ch = 0;
     uint32_t ret;
 
     if (size != 4) {
         return omap_badwidth_read32(opaque, addr);
     }
 
     switch (addr) {
     case 0x00:	/* MCSPI_REVISION */
         return 0x91;
 
     case 0x10:	/* MCSPI_SYSCONFIG */
         return s->sysconfig;
 
     case 0x14:	/* MCSPI_SYSSTATUS */
         return 1;					/* RESETDONE */
 
     case 0x18:	/* MCSPI_IRQSTATUS */
         return s->irqst;
 
     case 0x1c:	/* MCSPI_IRQENABLE */
         return s->irqen;
 
     case 0x20:	/* MCSPI_WAKEUPENABLE */
         return s->wken;
 
     case 0x24:	/* MCSPI_SYST */
         return s->systest;
 
     case 0x28:	/* MCSPI_MODULCTRL */
         return s->control;
 
     case 0x68: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x54: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x40: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x2c:	/* MCSPI_CHCONF */
         return s->ch[ch].config;
 
     case 0x6c: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x58: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x44: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x30:	/* MCSPI_CHSTAT */
         return s->ch[ch].status;
 
     case 0x70: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x5c: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x48: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x34:	/* MCSPI_CHCTRL */
         return s->ch[ch].control;
 
     case 0x74: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x60: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x4c: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x38:	/* MCSPI_TX */
         return s->ch[ch].tx;
 
     case 0x78: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x64: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x50: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x3c:	/* MCSPI_RX */
         s->ch[ch].status &= ~(1 << 0);			/* RXS */
         ret = s->ch[ch].rx;
         omap_mcspi_transfer_run(s, ch);
         return ret;
     }
 
     OMAP_BAD_REG(addr);
     return 0;
 }
@@ -225,117 +225,117 @@ static uint64_t omap_mcspi_read(void *opaque, hwaddr addr, unsigned size)
 static void omap_mcspi_write(void *opaque, hwaddr addr,
                              uint64_t value, unsigned size)
 {
     struct omap_mcspi_s *s = opaque;
     int ch = 0;
 
     if (size != 4) {
         omap_badwidth_write32(opaque, addr, value);
         return;
     }
 
     switch (addr) {
     case 0x00:	/* MCSPI_REVISION */
     case 0x14:	/* MCSPI_SYSSTATUS */
     case 0x30:	/* MCSPI_CHSTAT0 */
     case 0x3c:	/* MCSPI_RX0 */
     case 0x44:	/* MCSPI_CHSTAT1 */
     case 0x50:	/* MCSPI_RX1 */
     case 0x58:	/* MCSPI_CHSTAT2 */
     case 0x64:	/* MCSPI_RX2 */
     case 0x6c:	/* MCSPI_CHSTAT3 */
     case 0x78:	/* MCSPI_RX3 */
         OMAP_RO_REG(addr);
         return;
 
     case 0x10:	/* MCSPI_SYSCONFIG */
         if (value & (1 << 1))				/* SOFTRESET */
             omap_mcspi_reset(s);
         s->sysconfig = value & 0x31d;
         break;
 
     case 0x18:	/* MCSPI_IRQSTATUS */
         if (!((s->control & (1 << 3)) && (s->systest & (1 << 11)))) {
             s->irqst &= ~value;
             omap_mcspi_interrupt_update(s);
         }
         break;
 
     case 0x1c:	/* MCSPI_IRQENABLE */
         s->irqen = value & 0x1777f;
         omap_mcspi_interrupt_update(s);
         break;
 
     case 0x20:	/* MCSPI_WAKEUPENABLE */
         s->wken = value & 1;
         break;
 
     case 0x24:	/* MCSPI_SYST */
         if (s->control & (1 << 3))			/* SYSTEM_TEST */
             if (value & (1 << 11)) {			/* SSB */
                 s->irqst |= 0x1777f;
                 omap_mcspi_interrupt_update(s);
             }
         s->systest = value & 0xfff;
         break;
 
     case 0x28:	/* MCSPI_MODULCTRL */
         if (value & (1 << 3))				/* SYSTEM_TEST */
             if (s->systest & (1 << 11)) {		/* SSB */
                 s->irqst |= 0x1777f;
                 omap_mcspi_interrupt_update(s);
             }
         s->control = value & 0xf;
         break;
 
     case 0x68: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x54: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x40: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x2c:	/* MCSPI_CHCONF */
         if ((value ^ s->ch[ch].config) & (3 << 14))	/* DMAR | DMAW */
             omap_mcspi_dmarequest_update(s->ch + ch);
         if (((value >> 12) & 3) == 3) { /* TRM */
             qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid TRM value (3)\n",
                           __func__);
         }
         if (((value >> 7) & 0x1f) < 3) { /* WL */
             qemu_log_mask(LOG_GUEST_ERROR,
                           "%s: invalid WL value (%" PRIx64 ")\n",
                           __func__, (value >> 7) & 0x1f);
         }
         s->ch[ch].config = value & 0x7fffff;
         break;
 
     case 0x70: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x5c: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x48: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x34:	/* MCSPI_CHCTRL */
         if (value & ~s->ch[ch].control & 1) {		/* EN */
             s->ch[ch].control |= 1;
             omap_mcspi_transfer_run(s, ch);
         } else
             s->ch[ch].control = value & 1;
         break;
 
     case 0x74: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x60: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x4c: ch ++;
-        /* fall through */
+        fallthrough;
     case 0x38:	/* MCSPI_TX */
         s->ch[ch].tx = value;
         s->ch[ch].status &= ~(1 << 1);			/* TXS */
         omap_mcspi_transfer_run(s, ch);
         break;
 
     default:
         OMAP_BAD_REG(addr);
         return;
     }
 }
-- 
2.39.2



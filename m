Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E46F17C7FDC
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:18:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCxs-0000uT-7b; Fri, 13 Oct 2023 03:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxB-0006jz-NZ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:27 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCww-0004za-KH
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:25 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-32d9effe314so147061f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183468; x=1697788268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHkwerARMVrwTTd/RS2SbAUQb/LRufm8Kjc23C7Om/k=;
 b=ojI6qlkeSQNE2G8SIxrQWHUwv5qujm6nhdmAqnpsosUcOyOy8Cp2onYunc2Pl/8WCu
 BVNrf7Ku+MQtAGeeE8UrZUsT0ptD+fHOLr7hCByqDwRPPsCCe1qnZTP9D1yMYKtoYRYh
 nqzrm+9D2br+1WJx+yfNOmoXZ4WK6y0pgnpoZ1HUa1c3jPz/G+ylkbi0E+ogCkcSmSx+
 Lx89iO26gBPQMErvtEkkOeE788iKiN3F6jFzfBY1Bm5ta35sZcOITuF/2cWrfJwxyaB4
 ZYqu6l4JfERavq/1PE89dHX2Q+Nb0WF3NIZwem76Enx5rHTgcBwoDwN064VNQvyoLG4p
 ywQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183468; x=1697788268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MHkwerARMVrwTTd/RS2SbAUQb/LRufm8Kjc23C7Om/k=;
 b=BvyiP5AL1D0yMd6AoGqgpodjZJdy6yaMoNPa3id/yVdWcvH4QRn9O6i0xjWEL2VH/s
 /zpkIiP2IeBdzj9kw27bAL9waKsVlaTpSjhF6MH6HpVph1cesEsgQ7TTX9Xd7DKgbH7/
 SjhjKm5X8GPHtxO2mZfdsumhddnVRUd70391XB0sLKc9U/9HH1TRUd7PxvO30pLbJjjY
 GYCy/kmpLF13TOluP4j3VKzCxZk+OsPpEVCj3gObSzKkdChXBVgAC0dYRX8CyUfifKtY
 /CBvlR1C11ajsEefoimw6+d7xRbiDoXtTMbdR84gGoU1B2zufEU2+7MzrBMEHO8HMAGO
 hHwQ==
X-Gm-Message-State: AOJu0YwMia/TS4FUmCYw52Rrj6lTRuf1tBTY0Int9/OBGqPrADop9Vrr
 HTkljhIA3xKu1omO7hS86fZb4j3ZEZozqUmhsu0=
X-Google-Smtp-Source: AGHT+IHR+eoDk5nX8ugVDqBOA0t0tlbUf12cZF04gXlocAkFhF7e+HsXYsdfV2gnp6IEKwW6P9oQIA==
X-Received: by 2002:a05:6000:98f:b0:32d:89b5:6d05 with SMTP id
 by15-20020a056000098f00b0032d89b56d05mr6199061wrb.35.1697183468572; 
 Fri, 13 Oct 2023 00:51:08 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:08 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bin.meng@windriver.com>
Subject: [RFC PATCH 40/78] hw/sd/sdhci.c: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:47 +0300
Message-Id: <9c2cdf34edb01e45141db197877910d22767dd89.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x429.google.com
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
 hw/sd/sdhci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 5564765a9b..5c641d24de 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -75,138 +75,138 @@ static bool sdhci_check_capab_freq_range(SDHCIState *s, const char *desc,
 static void sdhci_check_capareg(SDHCIState *s, Error **errp)
 {
     uint64_t msk = s->capareg;
     uint32_t val;
     bool y;
 
     switch (s->sd_spec_version) {
     case 4:
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, BUS64BIT_V4);
         trace_sdhci_capareg("64-bit system bus (v4)", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, BUS64BIT_V4, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, UHS_II);
         trace_sdhci_capareg("UHS-II", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, UHS_II, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, ADMA3);
         trace_sdhci_capareg("ADMA3", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, ADMA3, 0);
 
-    /* fallthrough */
+        fallthrough;
     case 3:
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, ASYNC_INT);
         trace_sdhci_capareg("async interrupt", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, ASYNC_INT, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, SLOT_TYPE);
         if (val) {
             error_setg(errp, "slot-type not supported");
             return;
         }
         trace_sdhci_capareg("slot type", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, SLOT_TYPE, 0);
 
         if (val != 2) {
             val = FIELD_EX64(s->capareg, SDHC_CAPAB, EMBEDDED_8BIT);
             trace_sdhci_capareg("8-bit bus", val);
         }
         msk = FIELD_DP64(msk, SDHC_CAPAB, EMBEDDED_8BIT, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, BUS_SPEED);
         trace_sdhci_capareg("bus speed mask", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, BUS_SPEED, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, DRIVER_STRENGTH);
         trace_sdhci_capareg("driver strength mask", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, DRIVER_STRENGTH, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, TIMER_RETUNING);
         trace_sdhci_capareg("timer re-tuning", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, TIMER_RETUNING, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, SDR50_TUNING);
         trace_sdhci_capareg("use SDR50 tuning", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, SDR50_TUNING, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, RETUNING_MODE);
         trace_sdhci_capareg("re-tuning mode", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, RETUNING_MODE, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, CLOCK_MULT);
         trace_sdhci_capareg("clock multiplier", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, CLOCK_MULT, 0);
 
-    /* fallthrough */
+        fallthrough;
     case 2: /* default version */
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, ADMA2);
         trace_sdhci_capareg("ADMA2", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, ADMA2, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, ADMA1);
         trace_sdhci_capareg("ADMA1", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, ADMA1, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, BUS64BIT);
         trace_sdhci_capareg("64-bit system bus (v3)", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, BUS64BIT, 0);
 
-    /* fallthrough */
+        fallthrough;
     case 1:
         y = FIELD_EX64(s->capareg, SDHC_CAPAB, TOUNIT);
         msk = FIELD_DP64(msk, SDHC_CAPAB, TOUNIT, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, TOCLKFREQ);
         trace_sdhci_capareg(y ? "timeout (MHz)" : "Timeout (KHz)", val);
         if (sdhci_check_capab_freq_range(s, "timeout", val, errp)) {
             return;
         }
         msk = FIELD_DP64(msk, SDHC_CAPAB, TOCLKFREQ, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, BASECLKFREQ);
         trace_sdhci_capareg(y ? "base (MHz)" : "Base (KHz)", val);
         if (sdhci_check_capab_freq_range(s, "base", val, errp)) {
             return;
         }
         msk = FIELD_DP64(msk, SDHC_CAPAB, BASECLKFREQ, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, MAXBLOCKLENGTH);
         if (val >= 3) {
             error_setg(errp, "block size can be 512, 1024 or 2048 only");
             return;
         }
         trace_sdhci_capareg("max block length", sdhci_get_fifolen(s));
         msk = FIELD_DP64(msk, SDHC_CAPAB, MAXBLOCKLENGTH, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, HIGHSPEED);
         trace_sdhci_capareg("high speed", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, HIGHSPEED, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, SDMA);
         trace_sdhci_capareg("SDMA", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, SDMA, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, SUSPRESUME);
         trace_sdhci_capareg("suspend/resume", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, SUSPRESUME, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, V33);
         trace_sdhci_capareg("3.3v", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, V33, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, V30);
         trace_sdhci_capareg("3.0v", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, V30, 0);
 
         val = FIELD_EX64(s->capareg, SDHC_CAPAB, V18);
         trace_sdhci_capareg("1.8v", val);
         msk = FIELD_DP64(msk, SDHC_CAPAB, V18, 0);
         break;
 
     default:
         error_setg(errp, "Unsupported spec version: %u", s->sd_spec_version);
     }
     if (msk) {
         qemu_log_mask(LOG_UNIMP,
                       "SDHCI: unknown CAPAB mask: 0x%016" PRIx64 "\n", msk);
     }
 }
@@ -1688,160 +1688,160 @@ static void
 usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 {
     SDHCIState *s = SYSBUS_SDHCI(opaque);
     uint8_t hostctl1;
     uint32_t value = (uint32_t)val;
 
     switch (offset) {
     case USDHC_DLL_CTRL:
     case USDHC_TUNE_CTRL_STATUS:
     case USDHC_UNDOCUMENTED_REG27:
     case USDHC_TUNING_CTRL:
     case USDHC_WTMK_LVL:
         break;
 
     case USDHC_VENDOR_SPEC:
         s->vendor_spec = value;
         switch (s->vendor) {
         case SDHCI_VENDOR_IMX:
             if (value & USDHC_IMX_FRC_SDCLK_ON) {
                 s->prnsts &= ~SDHC_IMX_CLOCK_GATE_OFF;
             } else {
                 s->prnsts |= SDHC_IMX_CLOCK_GATE_OFF;
             }
             break;
         default:
             break;
         }
         break;
 
     case SDHC_HOSTCTL:
         /*
          * Here's What ESDHCI has at offset 0x28 (SDHC_HOSTCTL)
          *
          *       7         6     5      4      3      2        1      0
          * |-----------+--------+--------+-----------+----------+---------|
          * | Card      | Card   | Endian | DATA3     | Data     | Led     |
          * | Detect    | Detect | Mode   | as Card   | Transfer | Control |
          * | Signal    | Test   |        | Detection | Width    |         |
          * | Selection | Level  |        | Pin       |          |         |
          * |-----------+--------+--------+-----------+----------+---------|
          *
          * and 0x29
          *
          *  15      10 9    8
          * |----------+------|
          * | Reserved | DMA  |
          * |          | Sel. |
          * |          |      |
          * |----------+------|
          *
          * and here's what SDCHI spec expects those offsets to be:
          *
          * 0x28 (Host Control Register)
          *
          *     7        6         5       4  3      2         1        0
          * |--------+--------+----------+------+--------+----------+---------|
          * | Card   | Card   | Extended | DMA  | High   | Data     | LED     |
          * | Detect | Detect | Data     | Sel. | Speed  | Transfer | Control |
          * | Signal | Test   | Transfer |      | Enable | Width    |         |
          * | Sel.   | Level  | Width    |      |        |          |         |
          * |--------+--------+----------+------+--------+----------+---------|
          *
          * and 0x29 (Power Control Register)
          *
          * |----------------------------------|
          * | Power Control Register           |
          * |                                  |
          * | Description omitted,             |
          * | since it has no analog in ESDHCI |
          * |                                  |
          * |----------------------------------|
          *
          * Since offsets 0x2A and 0x2B should be compatible between
          * both IP specs we only need to reconcile least 16-bit of the
          * word we've been given.
          */
 
         /*
          * First, save bits 7 6 and 0 since they are identical
          */
         hostctl1 = value & (SDHC_CTRL_LED |
                             SDHC_CTRL_CDTEST_INS |
                             SDHC_CTRL_CDTEST_EN);
         /*
          * Second, split "Data Transfer Width" from bits 2 and 1 in to
          * bits 5 and 1
          */
         if (value & USDHC_CTRL_8BITBUS) {
             hostctl1 |= SDHC_CTRL_8BITBUS;
         }
 
         if (value & USDHC_CTRL_4BITBUS) {
             hostctl1 |= USDHC_CTRL_4BITBUS;
         }
 
         /*
          * Third, move DMA select from bits 9 and 8 to bits 4 and 3
          */
         hostctl1 |= SDHC_DMA_TYPE(value >> (8 - 3));
 
         /*
          * Now place the corrected value into low 16-bit of the value
          * we are going to give standard SDHCI write function
          *
          * NOTE: This transformation should be the inverse of what can
          * be found in drivers/mmc/host/sdhci-esdhc-imx.c in Linux
          * kernel
          */
         value &= ~UINT16_MAX;
         value |= hostctl1;
         value |= (uint16_t)s->pwrcon << 8;
 
         sdhci_write(opaque, offset, value, size);
         break;
 
     case USDHC_MIX_CTRL:
         /*
          * So, when SD/MMC stack in Linux tries to write to "Transfer
          * Mode Register", ESDHC i.MX quirk code will translate it
          * into a write to ESDHC_MIX_CTRL, so we do the opposite in
          * order to get where we started
          *
          * Note that Auto CMD23 Enable bit is located in a wrong place
          * on i.MX, but since it is not used by QEMU we do not care.
          *
          * We don't want to call sdhci_write(.., SDHC_TRNMOD, ...)
          * here because it will result in a call to
          * sdhci_send_command(s) which we don't want.
          *
          */
         s->trnmod = value & UINT16_MAX;
         break;
     case SDHC_TRNMOD:
         /*
          * Similar to above, but this time a write to "Command
          * Register" will be translated into a 4-byte write to
          * "Transfer Mode register" where lower 16-bit of value would
          * be set to zero. So what we do is fill those bits with
          * cached value from s->trnmod and let the SDHCI
          * infrastructure handle the rest
          */
         sdhci_write(opaque, offset, val | s->trnmod, size);
         break;
     case SDHC_BLKSIZE:
         /*
          * ESDHCI does not implement "Host SDMA Buffer Boundary", and
          * Linux driver will try to zero this field out which will
          * break the rest of SDHCI emulation.
          *
          * Linux defaults to maximum possible setting (512K boundary)
          * and it seems to be the only option that i.MX IP implements,
          * so we artificially set it to that value.
          */
         val |= 0x7 << 12;
-        /* FALLTHROUGH */
+        fallthrough;
     default:
         sdhci_write(opaque, offset, val, size);
         break;
     }
 }
-- 
2.39.2



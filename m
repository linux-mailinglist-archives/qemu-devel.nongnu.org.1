Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CE27C7F2C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:00:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCwN-0004qP-07; Fri, 13 Oct 2023 03:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwJ-0004i5-HL
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:31 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCw2-0004Nx-W5
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:31 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32d569e73acso1689191f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183412; x=1697788212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IHHNv9a7p6HwYLVLm/9xkBe05lXBtnT5aw37gy92uds=;
 b=DA8Qc5Z2ScWu3/yiSrxTyoDuhCUWVN8UiiAa+pFf6K6FCH5TkeWCoMzfDoNlNNCrWe
 YTzwjzTiQ7puz4bmtmR5IBn+lqMl1JMrTyE+ndnv9f7Py3CoGubJs/xI36o9NSQd3imY
 agFu/Lb0VPQHLXlrivSQ8HesxHJETRLM5hGISpSmtxLTlOXYnkipnOwMQWisFjfCJEte
 DvWQangD919Q/sFqCu3i5FlEPhFLKGGXuiHKT3KNqTbKvVhkFmhi14HtO9T80B0Q9z8y
 TDyTFEHM0RBSqwg5j4aDxlRKMU1oW+mUd0Eo55NzVct6DYVts6HG5+vf8WKZx5mzPrGy
 WxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183412; x=1697788212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IHHNv9a7p6HwYLVLm/9xkBe05lXBtnT5aw37gy92uds=;
 b=sHDzONeNee25l0HGHwIlKxOXloH31ycy5ktxr0hFzShquwOXY0FWutzIDu656/8S77
 r8oVaT27YOyIIjrZh5pH8SCD4ft6PDTW9WzDmpjMOtK6pRWbYr1hcOzY1JbH1hrkOC8Y
 XL12Nh2DgEsj5TBV8bUdQ6S+d84RBp1xNK65RuK/xHt8x/Dr/7kRC41WUQDuR3aFx1mQ
 H7PIbSLMjZlBhakAGP/vYNyDynpT1vUN5KInpOm8+n+5Arf7j4FgHv49+Ng0EHFznpdh
 tcFr6SYQ7pgJNa84C5nO9jiYUYyac9HHlzOTHqlukj3iCjZrUq0V98H0ik2Q3W35hbsO
 CMiA==
X-Gm-Message-State: AOJu0YwwSAIdE7EbTSURaQPk93a+j324A9gqk5r9INVbCy7V0IxMHTgk
 O8PHGjFUvon8pdg607DXAkYpT1B04Xxnqu1FTKU=
X-Google-Smtp-Source: AGHT+IEYALPaAyB5HLWgSBJDRW6m0TkhXG/WeYF3FI0DHGopUCcj5AX3bw2rytw5m9Oy9T7I0skM1Q==
X-Received: by 2002:adf:f005:0:b0:321:52fb:5703 with SMTP id
 j5-20020adff005000000b0032152fb5703mr23883977wro.13.1697183412357; 
 Fri, 13 Oct 2023 00:50:12 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:50:11 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [RFC PATCH 13/78] hw/adc: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:17 +0300
Message-Id: <5bd9400e01587cac991c16c51ce0f89982f3d529.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x433.google.com
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
 hw/adc/aspeed_adc.c | 12 ++++++------
 hw/adc/zynq-xadc.c  |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/adc/aspeed_adc.c b/hw/adc/aspeed_adc.c
index 0d29663129..f9f5f7bb17 100644
--- a/hw/adc/aspeed_adc.c
+++ b/hw/adc/aspeed_adc.c
@@ -107,59 +107,59 @@ static uint32_t read_channel_sample(AspeedADCEngineState *s, int reg)
 static uint64_t aspeed_adc_engine_read(void *opaque, hwaddr addr,
                                        unsigned int size)
 {
     AspeedADCEngineState *s = ASPEED_ADC_ENGINE(opaque);
     int reg = TO_REG(addr);
     uint32_t value = 0;
 
     switch (reg) {
     case BOUNDS_CHANNEL_8 ... BOUNDS_CHANNEL_15:
         if (s->nr_channels <= 8) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: engine[%u]: "
                           "bounds register %u invalid, only 0...7 valid\n",
                           __func__, s->engine_id, reg - BOUNDS_CHANNEL_0);
             break;
         }
-        /* fallthrough */
+        fallthrough;
     case HYSTERESIS_CHANNEL_8 ... HYSTERESIS_CHANNEL_15:
         if (s->nr_channels <= 8) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: engine[%u]: "
                           "hysteresis register %u invalid, only 0...7 valid\n",
                           __func__, s->engine_id, reg - HYSTERESIS_CHANNEL_0);
             break;
         }
-        /* fallthrough */
+        fallthrough;
     case BOUNDS_CHANNEL_0 ... BOUNDS_CHANNEL_7:
     case HYSTERESIS_CHANNEL_0 ... HYSTERESIS_CHANNEL_7:
     case ENGINE_CONTROL:
     case INTERRUPT_CONTROL:
     case VGA_DETECT_CONTROL:
     case CLOCK_CONTROL:
     case INTERRUPT_SOURCE:
     case COMPENSATING_AND_TRIMMING:
         value = s->regs[reg];
         break;
     case DATA_CHANNEL_9_AND_8 ... DATA_CHANNEL_15_AND_14:
         if (s->nr_channels <= 8) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: engine[%u]: "
                           "data register %u invalid, only 0...3 valid\n",
                           __func__, s->engine_id, reg - DATA_CHANNEL_1_AND_0);
             break;
         }
-        /* fallthrough */
+        fallthrough;
     case DATA_CHANNEL_1_AND_0 ... DATA_CHANNEL_7_AND_6:
         value = read_channel_sample(s, reg);
         /* Allow 16-bit reads of the data registers */
         if (addr & 0x2) {
             assert(size == 2);
             value >>= 16;
         }
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: engine[%u]: 0x%" HWADDR_PRIx "\n",
                       __func__, s->engine_id, addr);
         break;
     }
 
     trace_aspeed_adc_engine_read(s->engine_id, addr, value);
     return value;
 }
@@ -167,69 +167,69 @@ static uint64_t aspeed_adc_engine_read(void *opaque, hwaddr addr,
 static void aspeed_adc_engine_write(void *opaque, hwaddr addr, uint64_t value,
                                     unsigned int size)
 {
     AspeedADCEngineState *s = ASPEED_ADC_ENGINE(opaque);
     int reg = TO_REG(addr);
     uint32_t init = 0;
 
     trace_aspeed_adc_engine_write(s->engine_id, addr, value);
 
     switch (reg) {
     case ENGINE_CONTROL:
         init = !!(value & ASPEED_ADC_ENGINE_EN);
         init *= ASPEED_ADC_ENGINE_INIT;
 
         value &= ~ASPEED_ADC_ENGINE_INIT;
         value |= init;
 
         value &= ~ASPEED_ADC_ENGINE_AUTO_COMP;
         break;
     case INTERRUPT_CONTROL:
     case VGA_DETECT_CONTROL:
     case CLOCK_CONTROL:
         break;
     case DATA_CHANNEL_9_AND_8 ... DATA_CHANNEL_15_AND_14:
         if (s->nr_channels <= 8) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: engine[%u]: "
                           "data register %u invalid, only 0...3 valid\n",
                           __func__, s->engine_id, reg - DATA_CHANNEL_1_AND_0);
             return;
         }
-        /* fallthrough */
+        fallthrough;
     case BOUNDS_CHANNEL_8 ... BOUNDS_CHANNEL_15:
         if (s->nr_channels <= 8) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: engine[%u]: "
                           "bounds register %u invalid, only 0...7 valid\n",
                           __func__, s->engine_id, reg - BOUNDS_CHANNEL_0);
             return;
         }
-        /* fallthrough */
+        fallthrough;
     case DATA_CHANNEL_1_AND_0 ... DATA_CHANNEL_7_AND_6:
     case BOUNDS_CHANNEL_0 ... BOUNDS_CHANNEL_7:
         value &= ASPEED_ADC_LH_MASK;
         break;
     case HYSTERESIS_CHANNEL_8 ... HYSTERESIS_CHANNEL_15:
         if (s->nr_channels <= 8) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: engine[%u]: "
                           "hysteresis register %u invalid, only 0...7 valid\n",
                           __func__, s->engine_id, reg - HYSTERESIS_CHANNEL_0);
             return;
         }
-        /* fallthrough */
+        fallthrough;
     case HYSTERESIS_CHANNEL_0 ... HYSTERESIS_CHANNEL_7:
         value &= (ASPEED_ADC_HYST_EN | ASPEED_ADC_LH_MASK);
         break;
     case INTERRUPT_SOURCE:
         value &= 0xffff;
         break;
     case COMPENSATING_AND_TRIMMING:
         value &= 0xf;
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s: engine[%u]: "
                       "0x%" HWADDR_PRIx " 0x%" PRIx64 "\n",
                       __func__, s->engine_id, addr, value);
         break;
     }
 
     s->regs[reg] = value;
 }
diff --git a/hw/adc/zynq-xadc.c b/hw/adc/zynq-xadc.c
index 032e19cbd0..a74de3a4fd 100644
--- a/hw/adc/zynq-xadc.c
+++ b/hw/adc/zynq-xadc.c
@@ -189,61 +189,61 @@ static uint64_t zynq_xadc_read(void *opaque, hwaddr offset, unsigned size)
 static void zynq_xadc_write(void *opaque, hwaddr offset, uint64_t val,
                             unsigned size)
 {
     ZynqXADCState *s = (ZynqXADCState *)opaque;
     int reg = offset / 4;
     int xadc_reg;
     int xadc_cmd;
     int xadc_data;
 
     if (!zynq_xadc_check_offset(reg, false)) {
         qemu_log_mask(LOG_GUEST_ERROR, "zynq_xadc: Invalid write access "
                       "to addr %" HWADDR_PRIx "\n", offset);
         return;
     }
 
     switch (reg) {
     case CFG:
         s->regs[CFG] = val;
         break;
     case INT_STS:
         s->regs[INT_STS] &= ~val;
         break;
     case INT_MASK:
         s->regs[INT_MASK] = val & INT_ALL;
         break;
     case CMDFIFO:
         xadc_cmd  = extract32(val, 26,  4);
         xadc_reg  = extract32(val, 16, 10);
         xadc_data = extract32(val,  0, 16);
 
         if (s->regs[MCTL] & MCTL_RESET) {
             qemu_log_mask(LOG_GUEST_ERROR, "zynq_xadc: Sending command "
                           "while comm channel held in reset: %" PRIx32 "\n",
                           (uint32_t) val);
             break;
         }
 
         if (xadc_reg >= ZYNQ_XADC_NUM_ADC_REGS && xadc_cmd != CMD_NOP) {
             qemu_log_mask(LOG_GUEST_ERROR, "read/write op to invalid xadc "
                           "reg 0x%x\n", xadc_reg);
             break;
         }
 
         switch (xadc_cmd) {
         case CMD_READ:
             xadc_push_dfifo(s, s->xadc_regs[xadc_reg]);
             break;
         case CMD_WRITE:
             s->xadc_regs[xadc_reg] = xadc_data;
-            /* fallthrough */
+            fallthrough;
         case CMD_NOP:
             xadc_push_dfifo(s, 0);
             break;
         }
         break;
     case MCTL:
         s->regs[MCTL] = val & 0x00fffeff;
         break;
     }
     zynq_xadc_update_ints(s);
 }
-- 
2.39.2



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 907BE8201BE
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:29:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKLh-0007XM-4C; Fri, 29 Dec 2023 16:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLf-0007T8-0L
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:55 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKLa-0006yg-6f
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:54 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6d9b2c8e2a4so2694144b3a.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885086; x=1704489886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UdAUtVG2pZL0Z9aYfR2pwp7z3p2m4ly+ECo0FK04wVc=;
 b=lUM6tS1BI2YvjF1BUSvSYs1s2qFvepqlJOx4dRS1Hiv+xP78l++9cqHZ2NF0TVroly
 KJGLVwk5BmsCuiM3RhhSDZltrXZuaQ79NRV/p6e7en792ZelMvuD2RQZv5BhGvUkA6XS
 vIY/lrgp9qa90GJPF4y22Oe5/zKpr8+LZ86eD09aB8YdpDHUQRzS9W1XClPHOmmKiXru
 REy2C3JD8OyBTgZps23huIymHWNB9uGHZ4TetlNY++Nw6tiy+gwCkFkyE5yihN60+ky0
 zalpyhNR/himnDfLc9YTC6HemDr36Kg5lHvudj8u2VuFHTIdYODoH0SDfE/mIj2//N9Y
 ts6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885086; x=1704489886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UdAUtVG2pZL0Z9aYfR2pwp7z3p2m4ly+ECo0FK04wVc=;
 b=EX/P6qorjsp28bqCYnWb5vIbRkeAQ06c0VftyZdF/gBRS2XrBd2bWkgQVFX9ljdeKw
 Q/KUfzmOJ6HKvSE3llRKikrzkmTqen5YN+ibvMYYVBG61XovUzWdGCPnQsGyR0flj6DU
 TfpIGoCXy7rEel4CJBZI0aQGxLIwB9XdEnVjcAuzs+VFn/V1qbu1uTySyvcM3HEHJkGX
 E1J2oAnPLkkBFHzEiRuJ88mmmQa4NCnHOXkghKI+Uw91xTRYr/zxLoMTXcOQ05mmhxFc
 A8eJlHM3pPRbnpEgS79Ghzr3OOEUi9mmliuH9LLYak0EzI/LTR/bmIFfNOCfgQWeKGUM
 3y/w==
X-Gm-Message-State: AOJu0YxeaL3esT65+eUtUfJX/qQTm+j+9e2T99n+Z0O7DAN+cAc4IOFg
 nxRmn8gg+tSQWF6WQ7GD3vq3SbHPiqtUFin57qwJEQw5VytTVA==
X-Google-Smtp-Source: AGHT+IGOKO/xpIH6jRyZuJbDStd26dE07hPTolj4CtWI1yjwR9+3NHObjGol7/xNB3B2aDeXWPmXyg==
X-Received: by 2002:a05:6a20:4f23:b0:196:5bf1:68a5 with SMTP id
 gi35-20020a056a204f2300b001965bf168a5mr2690129pzb.45.1703885086620; 
 Fri, 29 Dec 2023 13:24:46 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:46 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/71] hw/adc: Constify VMState
Date: Sat, 30 Dec 2023 08:22:57 +1100
Message-Id: <20231229212346.147149-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231221031652.119827-23-richard.henderson@linaro.org>
---
 hw/adc/aspeed_adc.c    | 2 +-
 hw/adc/max111x.c       | 2 +-
 hw/adc/npcm7xx_adc.c   | 2 +-
 hw/adc/stm32f2xx_adc.c | 2 +-
 hw/adc/zynq-xadc.c     | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/adc/aspeed_adc.c b/hw/adc/aspeed_adc.c
index 0d29663129..68bdbc73b0 100644
--- a/hw/adc/aspeed_adc.c
+++ b/hw/adc/aspeed_adc.c
@@ -280,7 +280,7 @@ static const VMStateDescription vmstate_aspeed_adc_engine = {
     .name = TYPE_ASPEED_ADC,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedADCEngineState, ASPEED_ADC_NR_REGS),
         VMSTATE_END_OF_LIST(),
     }
diff --git a/hw/adc/max111x.c b/hw/adc/max111x.c
index e8bf4cccd4..957d177e1c 100644
--- a/hw/adc/max111x.c
+++ b/hw/adc/max111x.c
@@ -96,7 +96,7 @@ static const VMStateDescription vmstate_max111x = {
     .name = "max111x",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_SSI_PERIPHERAL(parent_obj, MAX111xState),
         VMSTATE_UINT8(tb1, MAX111xState),
         VMSTATE_UINT8(rb2, MAX111xState),
diff --git a/hw/adc/npcm7xx_adc.c b/hw/adc/npcm7xx_adc.c
index bc6f3f55e6..c6647eec6d 100644
--- a/hw/adc/npcm7xx_adc.c
+++ b/hw/adc/npcm7xx_adc.c
@@ -253,7 +253,7 @@ static const VMStateDescription vmstate_npcm7xx_adc = {
     .name = "npcm7xx-adc",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_TIMER(conv_timer, NPCM7xxADCState),
         VMSTATE_UINT32(con, NPCM7xxADCState),
         VMSTATE_UINT32(data, NPCM7xxADCState),
diff --git a/hw/adc/stm32f2xx_adc.c b/hw/adc/stm32f2xx_adc.c
index 01a0b14e69..e9df6ea53f 100644
--- a/hw/adc/stm32f2xx_adc.c
+++ b/hw/adc/stm32f2xx_adc.c
@@ -254,7 +254,7 @@ static const VMStateDescription vmstate_stm32f2xx_adc = {
     .name = TYPE_STM32F2XX_ADC,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(adc_sr, STM32F2XXADCState),
         VMSTATE_UINT32(adc_cr1, STM32F2XXADCState),
         VMSTATE_UINT32(adc_cr2, STM32F2XXADCState),
diff --git a/hw/adc/zynq-xadc.c b/hw/adc/zynq-xadc.c
index 032e19cbd0..34268319a4 100644
--- a/hw/adc/zynq-xadc.c
+++ b/hw/adc/zynq-xadc.c
@@ -269,7 +269,7 @@ static const VMStateDescription vmstate_zynq_xadc = {
     .name = "zynq-xadc",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, ZynqXADCState, ZYNQ_XADC_NUM_IO_REGS),
         VMSTATE_UINT16_ARRAY(xadc_regs, ZynqXADCState,
                              ZYNQ_XADC_NUM_ADC_REGS),
-- 
2.34.1



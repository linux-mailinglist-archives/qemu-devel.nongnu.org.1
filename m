Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8B081AD56
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:24:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9a6-00011j-4s; Wed, 20 Dec 2023 22:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9a3-0000oK-In
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:39 -0500
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9a1-0003xH-SE
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:18:39 -0500
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7810827e54eso19198585a.2
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128717; x=1703733517; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apdBW8u4RJGdPS0f4s0stukFnKbHgrmeOG3RpFod6gE=;
 b=K+2oHDwk0lagyxeAJGxxjBYG3ZNguofsq1hKEXU6+qFXBPh2avJ1kLg7oX/xfiXr4W
 HYK1IFJF9jIHhFkdzhKDyM9FDjpQSibu8Bga9hPfPwo31Iaq2/UK08Iw59v/YfI6AdK8
 g91gMsUoYHWJdqzPG0g2KvMAmmICMIzDXSKCxFCllcqi+UuSFGI8+cgnwzhPWNqBEg5Q
 ExSTyXQT38MaxVNLx2kOA5NoHRB9f/q56FvLbWKm4+Laf0xbKF8SIq67nOj4G45CwZ0a
 iK4cLyzzTKRyZbjN15+nzSQIpj4Gqg1L36SGSmCo+ObLg2XxzgyXbw1PznvYEbaxWsPd
 I+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128717; x=1703733517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=apdBW8u4RJGdPS0f4s0stukFnKbHgrmeOG3RpFod6gE=;
 b=BUDk+OH+rl6AflatjFn2YXCcTprvf1v5OdYapmlKNVtD0DaEreE9naX3Pr4okOYcJH
 gz6QWDLZcCsRNWDYmHmS89FGBqu06L2yMBjdVlt7DOnDZ9M7StvFVY2zCWMoo1wyVfBh
 VAvBFD5UoyxRKKjKZP9w8/FSabFlieWkiWcFLl5VVKsFsIVayHoOzYi4Po2oHnNkA4SM
 GSYEFXBFcauFTVy9rucNVjSk3jyXLIQ80liE4UCixaDGj6IaPF903+fWjP6XcU2exkME
 sAhMdfGnE0o5VTQtuGvSDEQDS/hWtTV/M7z7wSxNbSEdYtRVTglhQ7vkOvrz3K+47D2r
 o11Q==
X-Gm-Message-State: AOJu0YwYkXrzg8+YYpZizPvslxrlcWuCJHwdx/Q95UI+4J7c5+UryYN3
 A8xdEJtmxDaXQWGfJQ/Yb/VRYkNR1sKaYeTDEue21xXn
X-Google-Smtp-Source: AGHT+IEfRiXLtzTJKLve4dE+iOBOjfClpXkRC/rSf38T1dXgeqS7WMsUK11f+u00cn+RV3snCMSesA==
X-Received: by 2002:a05:620a:b44:b0:77f:3d4a:6dcd with SMTP id
 x4-20020a05620a0b4400b0077f3d4a6dcdmr22548552qkg.27.1703128716982; 
 Wed, 20 Dec 2023 19:18:36 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:18:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 22/71] hw/adc: Constify VMState
Date: Thu, 21 Dec 2023 14:16:03 +1100
Message-Id: <20231221031652.119827-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72f.google.com
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



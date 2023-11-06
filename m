Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEED07E1AAB
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 08:05:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qztaB-0005aW-KS; Mon, 06 Nov 2023 01:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZT-0004WP-QI
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:53 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qztZR-0001Pj-QV
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 01:58:51 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cc921a4632so33243405ad.1
 for <qemu-devel@nongnu.org>; Sun, 05 Nov 2023 22:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699253928; x=1699858728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zr0BCEZXlOszW9F+AA54UFJBcbquArbNcDAeurWNap0=;
 b=t7A6A1dzscIghe0yIBAxuZxy9NHFchK5SXr7u+DUxIz6c3p7xgqzL7IKWkFvAUvRB2
 qgisEN5/Pn4uDpYnRHNJv/9V/3xVaWDzXO2eH0eLrLfyapoy5UHbPOrduf3Gx0bP9oQC
 LxLGseIy5GDGNAfAbWEKn5eSvpQcO+hPsh0UnGGjMFHyvR/bXPlMYx5+xPzWWVZZ7OOj
 NkPDl2qFuCXrIQvTl9rsqbeP21LF+Sh6OF1lZxC9iWpm89C+2D3m9ZGdbuPufDYCBb2Z
 DeuefEsvZY8a6xRtK8bLSDBmk+Zsid+2SrafoeOQm5WpX8AU9Cn6T9rSVj3y+r+DlsZi
 R5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699253928; x=1699858728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zr0BCEZXlOszW9F+AA54UFJBcbquArbNcDAeurWNap0=;
 b=GqGhJbX48gd/N25U+gwpn06hQ65Tcf9mVpE6KtHToHJFgy35WP9tmfdV/zLPpN16/c
 usxRG4m/k0z3fCpJQ/dVA5Jc1weiZ5/DB8aAdLQeBMxZQpcgP1QBs1Mb91hL2TUdOKwx
 V3s72SgPqW4xBfu8e+QK9GLXH6i6UX6mllWtiv0RwcbnY+DlKmfwRORXtJquZrYX+IfG
 TPgk6kynAKh/MJKZ4+dFli3dWHJSmKO/Fh09WORnKZsmK5/WxLcfXsQnj0QWG9TjNYae
 587iL9EdELfQacQzW2WsswpPmhE8vmNnQPWKZkxMPiZRWZpqr3yScICiLG09RWZU1zkr
 2h+A==
X-Gm-Message-State: AOJu0YzJFc0zlm8MHiCt2RA0uOZRTi3D+kMjcGyUAmYJhrwREDTp6Zv8
 Jlh4OLnY1Z2JTdcVD6YwZct6NjKhvZWTa5EX0Jw=
X-Google-Smtp-Source: AGHT+IFzvR9P7hs0SIcdcE1SPlaelNPZxvP1az1aaBhFgt7mGgzEDalpFatH3Pl9g5Q3u/9RX+mJOA==
X-Received: by 2002:a17:902:c751:b0:1cc:29ef:df7d with SMTP id
 q17-20020a170902c75100b001cc29efdf7dmr24013593plq.65.1699253928392; 
 Sun, 05 Nov 2023 22:58:48 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c3-20020a170902d48300b001c62e3e1286sm5167130plg.166.2023.11.05.22.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Nov 2023 22:58:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: quintela@redhat.com, peterx@redhat.com, farosas@suse.de, leobras@redhat.com
Subject: [PATCH 22/71] hw/adc: Constify VMState
Date: Sun,  5 Nov 2023 22:57:38 -0800
Message-Id: <20231106065827.543129-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106065827.543129-1-richard.henderson@linaro.org>
References: <20231106065827.543129-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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



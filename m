Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FBF81AD21
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 04:18:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rG9Yt-0007Hz-MF; Wed, 20 Dec 2023 22:17:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Yr-0007HY-1R
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:25 -0500
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rG9Yo-0003gr-Nd
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 22:17:24 -0500
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-67f6739d7acso2636516d6.1
 for <qemu-devel@nongnu.org>; Wed, 20 Dec 2023 19:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703128642; x=1703733442; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CO1n59RKvGJ8mDHbI2a9AmuVb0Qv+rjHRJAkCB6pSQw=;
 b=H8LNZcxEvVso4+Vqc6ziB+rDX9r/+GADJjl3kLYVkwxS0o/fSmOxUQ1RQbz1tcVmzi
 MqRFg7P5ol3kq97gjpVr0cIzNPuM3OquHMGuU/h+F54IgQz2p5/fzMX1pfs4lIb25HtP
 1/tL6fiJlZQNVao9CS5AlmxDSEqL6or/WfbfIXef/mcJ/Z2DKep10TliDiP+dF7DmGEw
 FrmCH1klRLl/HgE97BSrxGRz/hmmgpZf3rVCIudZEbdaHPoyuCYWifSF8bz/v0VxUgTs
 8Un97uW9exxxtFJ8j2aWAO7jTs8r/hdeqy/ShgwYnSuMcIMpJvE87WGTboCfnuG9TrHx
 kxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703128642; x=1703733442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CO1n59RKvGJ8mDHbI2a9AmuVb0Qv+rjHRJAkCB6pSQw=;
 b=KLhzsBuy0T7Jn0kiqCozNK3tI2e7b2Dbi+SRomFrXVyDkb6/BulVdIrpyl5UWpyS+3
 GKP0IGAp6TnXLkU1UKTbyRK+cX1yMER4xjI2vZb/Z24FpyBc+LZ/DU1z2TdPO4WlrSjb
 PbPyyzJLxoae8XI6lW2w7Fzusa39paZxP1dywNSM3f9HniqtpxnCxBlZGaF1MzAcU2GI
 C4NqEj5bViI5lT2h3UOsYaRyzBVNZxU6sH2a4XYP4bcWQnPxGsSMoqfsoEPLCBdZhADU
 Ta5h4avHWZ3fkymnRooVueHP7x0SOmjvnIQVnNF9yiQaApPXPmQOZmuNelwk2meFT8bp
 0+aQ==
X-Gm-Message-State: AOJu0YyrDNwt/JKJYvqx2LqYmXGWvR1bMyltVBZIl8YnBuNGFGIGfkWd
 f2PrURiE3Q1Ostp586CRroHY/GrSCLwKSRGvZmykQ5ZC0etrTDeU
X-Google-Smtp-Source: AGHT+IEOBzNUXurMmuc3kQiIx82WIOoJUHrw2wbdXRisFSGO8jmy+o2eOAb1/MvfT3S4O5S4kSKkDQ==
X-Received: by 2002:ad4:5ae3:0:b0:67a:a72d:fbb0 with SMTP id
 c3-20020ad45ae3000000b0067aa72dfbb0mr49589qvh.46.1703128641930; 
 Wed, 20 Dec 2023 19:17:21 -0800 (PST)
Received: from stoup.. ([172.58.139.164]) by smtp.gmail.com with ESMTPSA id
 n8-20020a05620a294800b0078116d55191sm360808qkp.130.2023.12.20.19.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 19:17:21 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 03/71] target/arm: Constify hvf/hvf.c
Date: Thu, 21 Dec 2023 14:15:44 +1100
Message-Id: <20231221031652.119827-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221031652.119827-1-richard.henderson@linaro.org>
References: <20231221031652.119827-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf30.google.com
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 757e13b0f9..203d88f80b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -36,7 +36,7 @@
 #define MDSCR_EL1_SS_SHIFT  0
 #define MDSCR_EL1_MDE_SHIFT 15
 
-static uint16_t dbgbcr_regs[] = {
+static const uint16_t dbgbcr_regs[] = {
     HV_SYS_REG_DBGBCR0_EL1,
     HV_SYS_REG_DBGBCR1_EL1,
     HV_SYS_REG_DBGBCR2_EL1,
@@ -54,7 +54,8 @@ static uint16_t dbgbcr_regs[] = {
     HV_SYS_REG_DBGBCR14_EL1,
     HV_SYS_REG_DBGBCR15_EL1,
 };
-static uint16_t dbgbvr_regs[] = {
+
+static const uint16_t dbgbvr_regs[] = {
     HV_SYS_REG_DBGBVR0_EL1,
     HV_SYS_REG_DBGBVR1_EL1,
     HV_SYS_REG_DBGBVR2_EL1,
@@ -72,7 +73,8 @@ static uint16_t dbgbvr_regs[] = {
     HV_SYS_REG_DBGBVR14_EL1,
     HV_SYS_REG_DBGBVR15_EL1,
 };
-static uint16_t dbgwcr_regs[] = {
+
+static const uint16_t dbgwcr_regs[] = {
     HV_SYS_REG_DBGWCR0_EL1,
     HV_SYS_REG_DBGWCR1_EL1,
     HV_SYS_REG_DBGWCR2_EL1,
@@ -90,7 +92,8 @@ static uint16_t dbgwcr_regs[] = {
     HV_SYS_REG_DBGWCR14_EL1,
     HV_SYS_REG_DBGWCR15_EL1,
 };
-static uint16_t dbgwvr_regs[] = {
+
+static const uint16_t dbgwvr_regs[] = {
     HV_SYS_REG_DBGWVR0_EL1,
     HV_SYS_REG_DBGWVR1_EL1,
     HV_SYS_REG_DBGWVR2_EL1,
@@ -2010,7 +2013,7 @@ static const VMStateDescription vmstate_hvf_vtimer = {
     .name = "hvf-vtimer",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(vtimer_val, HVFVTimer),
         VMSTATE_END_OF_LIST()
     },
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 231E48201C9
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 22:31:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJKKt-0006qy-4B; Fri, 29 Dec 2023 16:24:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKKq-0006qK-9Z
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:04 -0500
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rJKKo-0005uT-Tk
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 16:24:04 -0500
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-35fea35c432so47816355ab.0
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 13:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703885041; x=1704489841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gT4WX0PoL92afkyPoSUzD3XqpdNjfk+jVfvP3kUng1I=;
 b=Kis/vHPo+GYe7FN/5zdb9g+TVWCseXjdHFFa6N0tLutCiJ+3BDzOiNrJkkAJpjRexH
 p7fcbGCfTOPYB/tUa0/fVN9E//ZL1xYrcX7wXEy8FwGZqwJt1OrmQs+y5ZIRp1EipkeU
 dciuGnvD1avfPDdzXI37RPlT1sSg0igwyaUSpFXgCe2zvvWifTT7FceJ2eWg+gD2a5V+
 F1PmGGspdskWZKM8AZiv9rsy5UXxwOmAa6C+1Vevqlwhw7253fDUoyx8Oo73KNm0sZM7
 a4pmmS31IBSPOiycRW6JQr0ns+Pt+PQwUmaMitRo4pBZTUt6CigvtbJja2M4q45IxzXy
 tmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703885041; x=1704489841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gT4WX0PoL92afkyPoSUzD3XqpdNjfk+jVfvP3kUng1I=;
 b=eHDcE9hjw67xTywY/ai9X96O9XIKtNbc4vTz4l4fH4ZDvZlOy8BmQe1VcnvDg88RSy
 5dO3beRAyd9QxeNUHWE5CeeWXlKi8bHEeB2AzcYkekCuWLRJwtmBjCEZALmAM6dygZSR
 X7YiaMm2PTACwFMkJ8u8qGWGpXMH5WqYoeAmG3TLipcpf/8wOuI1yUjBxLGkhhURniI/
 y6/YleJgaHXIVI6rF0Tv/VfWDxsGwSlJoKfWJm0tcBuwPWzJIt1RTcvqjOup6r1+BKkM
 p9iorz7zGgP/mCz41pl4B208Y32ArsBwU/w8+u6rg3xUu1Cy+lMb/lsbl9cBWqi29biy
 EIhQ==
X-Gm-Message-State: AOJu0YyH8rL9pbnIiEDMAEmHwbk7+Uo5W0qizGZtAi386NG5wSlXobZM
 5sG8Au6zR0mgn44q6QTbAgI3a1uXYLQ24kZLvUQtRB/LfmApxg==
X-Google-Smtp-Source: AGHT+IFcdApuXTJ9Nidoc3Fo5brhAqt+qHCz8p/PLBRnPSo1PCokyid1Dk4FDq7JQ8ngvAQcKod/Lg==
X-Received: by 2002:a92:c267:0:b0:35d:a84e:f729 with SMTP id
 h7-20020a92c267000000b0035da84ef729mr20321997ild.63.1703885041637; 
 Fri, 29 Dec 2023 13:24:01 -0800 (PST)
Received: from stoup.lan (203-217-28-32.perm.iinet.net.au. [203.217.28.32])
 by smtp.gmail.com with ESMTPSA id
 a34-20020a631a22000000b005c65e82a0cbsm15016237pga.17.2023.12.29.13.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Dec 2023 13:24:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/71] target/arm: Constify hvf/hvf.c
Date: Sat, 30 Dec 2023 08:22:38 +1100
Message-Id: <20231229212346.147149-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
References: <20231229212346.147149-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12d.google.com
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
Message-Id: <20231221031652.119827-4-richard.henderson@linaro.org>
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 495727E91BB
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 17:57:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2Dlw-0006oL-7J; Sun, 12 Nov 2023 11:57:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1r2Dlt-0006hS-K9; Sun, 12 Nov 2023 11:57:17 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1r2Dlr-0001zp-UG; Sun, 12 Nov 2023 11:57:17 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507a98517f3so4778003e87.0; 
 Sun, 12 Nov 2023 08:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699808233; x=1700413033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c/gV7WEkCFV29r9cbDCSPIqL1KG65x+4nmaMeydEVPg=;
 b=Y3XJGqBvGbvJBh95Njj7kLCZ/BUKz9XtYPg+XLLFLcqByYMf2BqX6GQJRLUQmBafhL
 xOjchEmoDHNMnAAAfrVFcpbi9z479P9adDGylsHvaXS40HHAVAyJOPrFy66F/IuuKi9w
 NTPRzhLlTUpV9MBTnHKInj7qhcaTTKeYonmkc4g7poXz4MAy8zjh2gi0FRlnI2AL0haK
 CM1bKJmBXE8pjEssVvxlXuI8dckP9fegzGa8yI7/zlKSpLayFZ0Go/uLE2tJj+7lW2yK
 23+iUC0xIjSAFXd9yxzsCxGtBTZrHujdkZgBo5pT7KHFzC3Mc7fq0czn2hbu2RWdaB9Z
 eFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699808233; x=1700413033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c/gV7WEkCFV29r9cbDCSPIqL1KG65x+4nmaMeydEVPg=;
 b=TuKK2H4VyVPBmI8W5umL8uNHszbbf8i6GPzNjFB4ntOigRvdH50GsshCDLeEwMN9GO
 OxP7gMIllyJiBAs4itggDhLOupcoYSotDDI0VGq5plYcbDVYsGoHMqP4rcif1wIInscl
 Iwe2MhIB3KFOzws9mwoQnICoa60gQTWv4b1lDL6MbH3taedbeLW5X1vZOJAOZs/8Mpum
 WW8i0gY4ydPEa5gEcIasr72xzB+knEltBIuZW77V2kI2aXB1qTYDnwVd35HuZne+tua0
 AeHqshwHFzx18OdLVW2ysl/+58miCQ835H2cwKY5u2Whp4VgiScwXPBGrq+PMeob/jmb
 kdvQ==
X-Gm-Message-State: AOJu0YzEl0G99Yf9t2LLcjcjoWEDFZi9XYM0cRs9BvbVayED3jfrMcrA
 tW+Sx62hEzjaYX6k0JjiZ7ZPRPByOLHxus+G
X-Google-Smtp-Source: AGHT+IFe//lfrK4WeIovK1y7vAgPZ6vV7ORA0E5xd6NJzEJaQBXl7q+XY6SMHUS4mvPVPaux4Xh+EA==
X-Received: by 2002:a05:6512:2313:b0:50a:756d:4105 with SMTP id
 o19-20020a056512231300b0050a756d4105mr3069221lfu.12.1699808232598; 
 Sun, 12 Nov 2023 08:57:12 -0800 (PST)
Received: from localhost.localdomain ([176.120.189.69])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a056512208900b005056fb1d6fbsm662044lfr.238.2023.11.12.08.57.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 08:57:12 -0800 (PST)
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nikita Ostrenkov <n.ostrenkov@gmail.com>
Subject: [PATCH v3] target/arm/tcg: enable pmu feature for cortex a9
Date: Sun, 12 Nov 2023 16:56:58 +0000
Message-Id: <20231112165658.2335-1-n.ostrenkov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

According to the technical reference manual Cortex A9 like Cortex A7 and Cortex A15 has Perfomance Unit Monitor (PMU)
https://developer.arm.com/documentation/100511/0401/performance-monitoring-unit/about-the-performance-monitoring-unit

Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
---
 target/arm/tcg/cpu32.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 0d5d8e307d..0008c3f890 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -418,6 +418,7 @@ static void cortex_a9_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_NEON);
     set_feature(&cpu->env, ARM_FEATURE_THUMB2EE);
     set_feature(&cpu->env, ARM_FEATURE_EL3);
+    set_feature(&cpu->env, ARM_FEATURE_PMU);
     /*
      * Note that A9 supports the MP extensions even for
      * A9UP and single-core A9MP (which are both different
-- 
2.34.1



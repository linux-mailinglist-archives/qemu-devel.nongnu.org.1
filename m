Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 963507E91B2
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 17:54:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2DiZ-0005iD-FP; Sun, 12 Nov 2023 11:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1r2DiV-0005hg-R6; Sun, 12 Nov 2023 11:53:48 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1r2DiP-0001RX-Sk; Sun, 12 Nov 2023 11:53:45 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-50949b7d7ffso5361117e87.0; 
 Sun, 12 Nov 2023 08:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699808019; x=1700412819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F1AvnSWiGvbigVuu/6MFNbfurAHFpFskCCpRglAvvlo=;
 b=UiC7T+GfuPwjnhYvnUjW4sVoS20wT0BleE5PVSyrSEhCAze2JE+8VJh4RUGki+Bys9
 m75wvVwYiedbNhaJqIAoCOyWyoeOuDgIAjV0mp9okYTkDkzUTxM0B7I0C3gM935PAxTa
 mMVlBTqo98Ms2j2R6A+fjmWr1qO8Wu65fWebkXkkmauM/e3kD2sCg2L0b9GVX/bUKZ8w
 9w8KzUkml8JT2ABWTtPTWFu8njKI8jRREFgx6uusY63HrsAQtGolsJloQg7TiB9gmiaE
 8f+leF+d9PIpwoaEm8KvS9GM7tNSM0Hsc075pmOpxgFBzZyMT9XAi3jFIXZrXF+0+pIl
 w7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699808019; x=1700412819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F1AvnSWiGvbigVuu/6MFNbfurAHFpFskCCpRglAvvlo=;
 b=CX8R20nIKWLitJJ6voL0wOGh4NeENJb/91Aua1Utjmr2W+bKIBrhhShU0m2bhB9hBw
 CVT04fi1m/tW52yPqv+TXZVE7/v9TwdEq3bAtchc/G9/7GbMbE79UKsgf+TolShl3b9J
 CaqlmQ/9abrYUdHTvH9mcUDkQ5b9QtyE4qrOjEajg4RIrzP+Lj2+oBltI9onC2wxGLaT
 OQLSoovhkEMluQluXAbA85vjA3JodVyiVFuJ4b+9KejQmz9rN4vtLPWpd9w08ponT7iF
 FcTa5pdCzf80npo67vU6WgzkQ3LzvkBpnu3hPTMYsy7BSDoGRkoBOVQUOV6MvPxFtYlX
 qSeQ==
X-Gm-Message-State: AOJu0YxIG/sMt9BxWSifV6Zz3f3yTX1kXpL4HNdJF6qEqnXSgEKTAojf
 Ss319viMRi6rhDjN2qKxpssaRDpoK0LOxJRd
X-Google-Smtp-Source: AGHT+IEg85dmIzUWSCs4f5XLLwkrGEenjkEhtUzSdCOB3OUmIJD/EvbKmDcjD/N6NKst2zGYa1lFgw==
X-Received: by 2002:a05:6512:4d1:b0:507:a58f:79b0 with SMTP id
 w17-20020a05651204d100b00507a58f79b0mr2628486lfq.9.1699808018695; 
 Sun, 12 Nov 2023 08:53:38 -0800 (PST)
Received: from localhost.localdomain ([176.120.189.69])
 by smtp.gmail.com with ESMTPSA id
 u7-20020a056512094700b00507ab956ab9sm668749lft.147.2023.11.12.08.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 08:53:38 -0800 (PST)
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nikita Ostrenkov <Nikita.Ostrenkov@gmail.com>
Subject: [PATCH v2] target/arm/tcg: enable pmu feature for cortex a9
Date: Sun, 12 Nov 2023 16:53:24 +0000
Message-Id: <20231112165324.1947-1-n.ostrenkov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-lf1-x12a.google.com
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

From: Nikita Ostrenkov <Nikita.Ostrenkov@gmail.com>

According to the technical reference manual Cortex A9 like Cortex A7 and Cortex A15 has Perfomance Unit Monitor (PMU)
https://developer.arm.com/documentation/100511/0401/performance-monitoring-unit/about-the-performance-monitoring-unit
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C767E91B0
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 17:51:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2DfK-00046n-IF; Sun, 12 Nov 2023 11:50:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1r2DfJ-00046a-4C; Sun, 12 Nov 2023 11:50:29 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1r2DfG-00015s-7d; Sun, 12 Nov 2023 11:50:28 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-507c5249d55so5601558e87.3; 
 Sun, 12 Nov 2023 08:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699807824; x=1700412624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=F1AvnSWiGvbigVuu/6MFNbfurAHFpFskCCpRglAvvlo=;
 b=Kaebh44fXB9K3452jJDhVAW4mAuFoWZ6MUTrdfrAe6v61kIEw2nQNOkE5RTKuKwoKa
 lGd8TgxGzYFNHA0Pw0J1pVGdumpj/EzFm0ywD3wXZtCtjqiJO+Nm6hw2igHgowopfjZ0
 Y3k8EBc4sdSgCIC/nBzdU5AJFIogHHU0+VjFbq2k+HnHr1z3cUkQyCuMIUCw/8O1InbY
 Lj3DcqVIuMcHeCAdBFMgIjqhsvtW2y62pGnFwc4VbVJmK7n1ztf312BayHR0LORBXji1
 mjskn+7nVzGScinkJ57g53miOlTF2LjYZECXbATuTUHqaITjgUfJh//GSDpIS1g6oLFf
 3u5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699807824; x=1700412624;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F1AvnSWiGvbigVuu/6MFNbfurAHFpFskCCpRglAvvlo=;
 b=JYEp6Y2zBPGwXIhKZkjwWObQI8LCu31heN5NOHGs1vA/iuqjnX4yBvuP9vD89+iQi6
 87/+a7nUv7nRmELUFenWUGuOpBH8Su7f5ORKvYmanI49ermmVBQZ57rC5MHUOi6p6z5q
 UbVjBzhxL7f/K6FXoMMwXm1NH/9yJn82n02d2c8fMdElvAJBh1IdT7LojJJ9qJHrFD7z
 X7/ngU2AjnTyfQq3aIfcnfRAgMZPj1kokMkDaTVxD4VBPp3wzSz+GhVS3kZ/PVHzzHdT
 sGmf6tQGQYuASTfpUqnh7CdmxGjW7/fUjGIMwzVAk9061slBy1bWngDkKZrmaMSXPxcH
 xmdQ==
X-Gm-Message-State: AOJu0Yx+IvJLfKwx1v52bn7ICplLEb/y+cjfr5iy6srpRnq4apZyC3Vp
 XYyQYEK+iuvkSBjsAFnVjREdmKQu0Wnu18uR
X-Google-Smtp-Source: AGHT+IGKWcKpNgVCPlBDkhHRV9NcE2FmXyEuzD+OVsATC6+QbZGzlyTyUZhWW3/irHFY7PQ6hCohNw==
X-Received: by 2002:a05:6512:15a2:b0:507:9ff6:75b6 with SMTP id
 bp34-20020a05651215a200b005079ff675b6mr4166409lfb.50.1699807823417; 
 Sun, 12 Nov 2023 08:50:23 -0800 (PST)
Received: from localhost.localdomain ([176.120.189.69])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a0565120a8700b005041b7735dbsm672620lfu.53.2023.11.12.08.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 08:50:22 -0800 (PST)
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nikita Ostrenkov <Nikita.Ostrenkov@gmail.com>
Subject: [PATCH] target/arm/tcg: enable pmu feature for cortex a9
Date: Sun, 12 Nov 2023 16:50:08 +0000
Message-Id: <20231112165008.1419-1-n.ostrenkov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-lf1-x132.google.com
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



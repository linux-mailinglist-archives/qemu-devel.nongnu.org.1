Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E3F816C6E
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:38:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsE-0006wF-CC; Mon, 18 Dec 2023 06:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsC-0006oF-58
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:24 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs5-0003LD-Cx
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:23 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-50e18689828so3145735e87.2
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899196; x=1703503996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FKQWnVGTfCUqUnya6YglJqR9o+KGIz1GEUxpR9ir3P8=;
 b=yAa54sD4mV/esqaB0EVo0XkRsHlH7MKK+GIquhlyRJoXN0ZEfVZnL+0p8OSahbrk4W
 euhpalCPIP1cHte6k0G6g+UwDg6IUYLL8C1/bR8WWYQRwYJ1ZoOFkepGKlBlIluGcOtF
 YMBLly98VV5veupRtbuYcqZYxmXfF4Jp8wHQOXSOwO2tqUyQelNWyiakaZxsWNuzXV/5
 7y7o3iEjGTKylsXwOfLl1d9uokwoVJgYslVAhIeHbDPIvh+MHnIgo9QW/NV61pzSyjyy
 CG4cM2n1V7AFYnPuuOLh4zeV0frVd4ayI+yI4fQ2Epvsr4kr2yG/mBWpDTHUDkVbGMmO
 649A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899196; x=1703503996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FKQWnVGTfCUqUnya6YglJqR9o+KGIz1GEUxpR9ir3P8=;
 b=WERXvtvOgs9lDtRmupSNqEhuG+yCVUYqGqcObf77DL0EYClm3l+BeCCCUcktMdjGWR
 1Y5n+nobP9KNOP4laz4QkQ3fzo92DsVediuBqLLtyWM2amDSPZe1Oo/aqWpLajKA/fK1
 zdF2+Zjn557DiCNkRL3ta5EKrnXpsfp4IaKGaP1A7o1Pj7omCfhSUTNtrBCOLQOvBOo9
 vJTfPBh4cKfdBNMctLvCXLU3WxAMJFEGS3hQIA4hNj/cIpFah/qzoOYVSMMq/WOB4JaQ
 KFcKVDLMZNthqrmiQJPlXUo5ZeCNw6Dxy48QHCDADBvF14sgXIZWBOnUpYH9xnF9loUa
 iTLQ==
X-Gm-Message-State: AOJu0Yzf7nj1d7I7jtjP9mB9RhlgcrXpsatNLz6KFgVEC5M51P/dObhc
 N4U1QZR7kSLTnRhEuoYHfr31ng==
X-Google-Smtp-Source: AGHT+IFOby4gC+qR5etJF+mOaXmC7WhEgDFClsSNUt0u4QHDWAINhza6Xii05DuXJksnV+G4RjB1iA==
X-Received: by 2002:a05:6512:2210:b0:50b:f1b2:3881 with SMTP id
 h16-20020a056512221000b0050bf1b23881mr9102789lfu.8.1702899195822; 
 Mon, 18 Dec 2023 03:33:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 19/35] target/arm: Treat LDTR* and STTR* as LDR/STR when NV,
 NV1 is 1, 1
Date: Mon, 18 Dec 2023 11:32:49 +0000
Message-Id: <20231218113305.2511480-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

FEAT_NV requires (per I_JKLJK) that when HCR_EL2.{NV,NV1} is {1,1} the
unprivileged-access instructions LDTR, STTR etc behave as normal
loads and stores. Implement the check that handles this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/hflags.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index f33c0a12741..8f254bf9ccb 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -261,8 +261,10 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
         switch (mmu_idx) {
         case ARMMMUIdx_E10_1:
         case ARMMMUIdx_E10_1_PAN:
-            /* TODO: ARMv8.3-NV */
-            DP_TBFLAG_A64(flags, UNPRIV, 1);
+            /* FEAT_NV: NV,NV1 == 1,1 means we don't do UNPRIV accesses */
+            if ((hcr & (HCR_NV | HCR_NV1)) != (HCR_NV | HCR_NV1)) {
+                DP_TBFLAG_A64(flags, UNPRIV, 1);
+            }
             break;
         case ARMMMUIdx_E20_2:
         case ARMMMUIdx_E20_2_PAN:
-- 
2.34.1



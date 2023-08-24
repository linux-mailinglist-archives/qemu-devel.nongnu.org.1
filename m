Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9548D786C1A
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 11:36:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ6eG-0004bM-7W; Thu, 24 Aug 2023 05:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e9-00047X-UN
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:59 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ6e3-00051I-DD
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 05:28:56 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so5525711f8f.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 02:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692869329; x=1693474129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Nl4ZpUZkjwvYqdaFnAmzJsKgzFy+tbw4XNF5WJzIR8U=;
 b=kdWzd7DkKdh+M3eYxNGQyo45Wic+zkTqOtqyWCh6GejzJK79/8HS/5HFhwmt3zv50W
 G7qTaH69kc0XYC8VKKe7EL1CRvhDq4OxT6kW/IAtz4KPtgZWDeH8rndG8X1ViJ5PeHet
 nPUfNayWsPBFHBSdvCC51fQthYs3b5mIYdes0v2E5RkqGHrVgNvtYExh+XDbFn6XmZXc
 0sBGXpUpNrnkQWMX9YfqGGbCJkJTyJ4Yb9rvsw90BQQA4JuTVOWx1NO18MWJkXnGxLqP
 oyu9ubJdr/DQFA0D3mmeT+AC0dWlNv2Dp0QKPjG8K3BK7YcRH5s0dH3gmxMgoDIT8co8
 lZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692869329; x=1693474129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nl4ZpUZkjwvYqdaFnAmzJsKgzFy+tbw4XNF5WJzIR8U=;
 b=ZN+iB7HIdwpIHAchJzC8/XypCyDrUNMCsivBGGqpMFSCWPBFjf9IPuH9DPMtQHtGRF
 Ss2+UiCvtloRCiL33Sb0qiZeUYZTif7bKjx7xhPj+/UZVy3mcgUdgshXzXut/ghHkWqY
 IvXFKRyJbSOUZWfLKuHQCmK1c0cOz68SLBDMWFZzfs004Sf6VPwy6ZKR4RRA6Y0l9Obm
 CIw6jBbQanl3jZIv+r5YnlcNMoKHnjZutgoeShyRAsLoc5+9vuhLwRIM2oDUbINTK6b2
 /6qtox1yROLOx35yTm+dBHpAgs49uESzcWHpf2qzwMzZ/un8VEoZRcxKtr1Yc2hcUAu5
 YK/w==
X-Gm-Message-State: AOJu0YyxYzkebCotEckz7fyk/7cPYWxySI97EslMyMfidqStszE4G/tV
 ORXVUTNSkZrz6BF4TATuaf8QJGZQNAB5+yy+rY4=
X-Google-Smtp-Source: AGHT+IGpTI82d8xYOXO8aDiaEBYvbgVGzeR/LVZCUN7HLTdkr7FZT+YLma0kPOFAaXcBgQ1M0/iL7g==
X-Received: by 2002:a5d:6308:0:b0:313:e953:65d0 with SMTP id
 i8-20020a5d6308000000b00313e95365d0mr11820296wru.28.1692869329640; 
 Thu, 24 Aug 2023 02:28:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b00317b5c8a4f1sm21844004wro.60.2023.08.24.02.28.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 02:28:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/35] target/arm/ptw: Set attributes correctly for MMU
 disabled data accesses
Date: Thu, 24 Aug 2023 10:28:25 +0100
Message-Id: <20230824092836.2239644-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824092836.2239644-1-peter.maydell@linaro.org>
References: <20230824092836.2239644-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the MMU is disabled, data accesses should be Device nGnRnE,
Outer Shareable, Untagged.  We handle the other cases from
AArch64.S1DisabledOutput() correctly but missed this one.
Device nGnRnE is memattr == 0, so the only part we were missing
was that shareability should be set to 2 for both insn fetches
and data accesses.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230807141514.19075-13-peter.maydell@linaro.org
---
 target/arm/ptw.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 312ccabe92e..7f217a31895 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3108,11 +3108,13 @@ static bool get_phys_addr_disabled(CPUARMState *env,
                 }
             }
         }
-        if (memattr == 0 && access_type == MMU_INST_FETCH) {
-            if (regime_sctlr(env, mmu_idx) & SCTLR_I) {
-                memattr = 0xee;  /* Normal, WT, RA, NT */
-            } else {
-                memattr = 0x44;  /* Normal, NC, No */
+        if (memattr == 0) {
+            if (access_type == MMU_INST_FETCH) {
+                if (regime_sctlr(env, mmu_idx) & SCTLR_I) {
+                    memattr = 0xee;  /* Normal, WT, RA, NT */
+                } else {
+                    memattr = 0x44;  /* Normal, NC, No */
+                }
             }
             shareability = 2; /* outer shareable */
         }
-- 
2.34.1



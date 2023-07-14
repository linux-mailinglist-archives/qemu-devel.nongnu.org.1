Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA574753F3E
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:47:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKL0b-0007HZ-0V; Fri, 14 Jul 2023 11:47:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0X-0007Fn-Mc
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:47:01 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0T-000764-4U
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:47:01 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5746cso19466425e9.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689349614; x=1691941614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FCSU4FtaO/3zeArkUS9xQ1e+FjPheX63usjZ65/2/SU=;
 b=I40HmBU3rZY0v8A2a6SryEyazK4Rika5QmWP1Ios04mMrSxepkYPiMIH87VL9FZWDw
 2rXoYF+OAm6chK0IFfeZHDRQExP97xeVEq6NvbLmLvh3Jbj2/zqEFfu39jJP7ScHpeZ7
 r1O2rbAdc95BXROfBbMtD9lvnjOhnMT95ht+h/uKFqUmbtJ8j4U1jwqEXwDpkITMBN4u
 btY+x8a1GnjU6DfuAOwWjgD/Jl2KMkCzG4hy6KU6Q1FzjaUJIQebMWmomvSfMTehymXs
 Or4/6mYmYnXeoVQ5ZTmkMY0nrO1L8BdFM9DBTVyAn7INFGRRFmQIKA2kM2z/gOEOMcp/
 6XkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689349614; x=1691941614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FCSU4FtaO/3zeArkUS9xQ1e+FjPheX63usjZ65/2/SU=;
 b=JM3VDHQY/THgwE9gUcHvTkVzUOokfVSutUTnx8S5QTsY6bGirfKsmk4TSxVw1QKqTw
 Bhb5yP/iLxTtHB2rAGYIhCHsxyt2iyEdDcQ5kwAVpiHr0qSItUjULoOQEfUvNJWQ3xG7
 xyBx1fGW1yXCVgvA3SfG54rXCpWm93QPjPJ0m/l0BQV+zVTvEo7ewchw3vN4MEzlTWt1
 aVfmmqsp1sMrENbBvEX134Nr6b021enGl1ya5LsqCHe1L2yIF3QFExOPF+YDaM2wWOJl
 uBxT/5cLLX9ZAjsRIsBgUklqfhJpE8CiyBZwe9iKCbJHSxflFGcavALxYvb1HYTSEFuA
 bytA==
X-Gm-Message-State: ABy/qLZ5JA/xwuz4gRLpNjhCbxKMe6FZyaMSRbrR7+HrGmgTh2yrDeBt
 6kfv/oFlDI1Tq0FpMJw1khRByinsa8cRaqTplto=
X-Google-Smtp-Source: APBJJlGohD/roEhQN+4DRh+6sEWtqOlcoTBi3EKArS/OQFtjo+zuY+YBaY85Y6CPfz0OV6JuvglYeA==
X-Received: by 2002:a5d:538e:0:b0:314:36f0:2214 with SMTP id
 d14-20020a5d538e000000b0031436f02214mr4443398wrv.6.1689349614715; 
 Fri, 14 Jul 2023 08:46:54 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d49d0000000b003143bb5ecd5sm11214025wrs.69.2023.07.14.08.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 08:46:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/14] target/arm/ptw: Remove last uses of ptw->in_secure
Date: Fri, 14 Jul 2023 16:46:42 +0100
Message-Id: <20230714154648.327466-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714154648.327466-1-peter.maydell@linaro.org>
References: <20230714154648.327466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Replace the last uses of ptw->in_secure with appropriate
checks on ptw->in_space.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index c30d3fe69a0..bc834675fb2 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3247,7 +3247,6 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                                       ARMMMUFaultInfo *fi)
 {
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
-    bool is_secure = ptw->in_secure;
     ARMMMUIdx s1_mmu_idx;
 
     /*
@@ -3255,8 +3254,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
      * cannot upgrade a NonSecure translation regime's attributes
      * to Secure or Realm.
      */
-    result->f.attrs.secure = is_secure;
     result->f.attrs.space = ptw->in_space;
+    result->f.attrs.secure = arm_space_is_secure(ptw->in_space);
 
     switch (mmu_idx) {
     case ARMMMUIdx_Phys_S:
@@ -3270,8 +3269,12 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     case ARMMMUIdx_Stage1_E0:
     case ARMMMUIdx_Stage1_E1:
     case ARMMMUIdx_Stage1_E1_PAN:
-        /* First stage lookup uses second stage for ptw. */
-        ptw->in_ptw_idx = is_secure ? ARMMMUIdx_Stage2_S : ARMMMUIdx_Stage2;
+        /*
+         * First stage lookup uses second stage for ptw; only
+         * Secure has both S and NS IPA and starts with Stage2_S.
+         */
+        ptw->in_ptw_idx = (ptw->in_space == ARMSS_Secure) ?
+            ARMMMUIdx_Stage2_S : ARMMMUIdx_Stage2;
         break;
 
     case ARMMMUIdx_Stage2:
-- 
2.34.1



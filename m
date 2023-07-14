Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9D7753F4F
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 17:50:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKL0d-0007L8-E5; Fri, 14 Jul 2023 11:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0a-0007HU-4l
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:47:05 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qKL0T-000778-Kr
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 11:47:03 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc244d307so19459555e9.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 08:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689349616; x=1691941616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KTXC6GkpQIvSes2vuxm04/9pQF6G3CB656Q7X8rE+8M=;
 b=QwTvGJflSF8mcrSCNZZM40d5QciGBrZ2N//cJV0gMXIIGqTacF1xTT6PE8b29e31TO
 /w9y/VQOUz0hcs37wkIAFrmqGsJGDfyWowrZtR8W1EU+Lz/tXFuRZN1+npRfF4smIc4D
 9ypVo/q+bgR7gCWuwGL5TOlhfrQ7HkGQkSaZH9VtKL6krelxBD2TYAtDFo8AlwtEgYKF
 0585LfpF+oCruOHmHk1EO3VzJr/vio763f7Fyj6YjdAoyRNPDIogB1oBfDuTnqtiJfAk
 TJOdJEoRyRtcsq+jBVcrESrXXc1X2GPOt1iMgfekfWP+pFv1xx97Ax3jKIVHWZG+eRZT
 vDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689349616; x=1691941616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KTXC6GkpQIvSes2vuxm04/9pQF6G3CB656Q7X8rE+8M=;
 b=M5aIvorpMzpX8A6TGrC0Z514IarAkeH846pwe4PUrE6TX6ziygSKWmqDCv4XFsCCA0
 Kwwilw8D8sPx6kYHolCx5+fRk3FX8DeFpbC6+jOSOmPF7C5hYwde89k1hL9f7n0dYvCU
 v1BjqxZsTrZINxe7BVzrZcYEWfd4l1jztNYSSqudfWdjF9zpSUMlcBjNjoQhsej16zNj
 hblZDm0wIfWB/ijOxuV410Grzk+QXOrdGNXb7pesP85tmOTJbNPJiObEPmv/D/lea30b
 CJQvBaAaPPaxcIZ7yf6pEql1UIwXSzzBxKFGtwBf8R8fAd4nYlJeeNj7QtYHvQpKf4dF
 w0LQ==
X-Gm-Message-State: ABy/qLZYL+mDn2HYcNkoI+TI8VOix0x6BQZosIyAkyh0R1zwSy8DDcke
 QfVbGWF0J3Z5u6Mv2V73gOG/2975VYtcKR9ZFTw=
X-Google-Smtp-Source: APBJJlGjTD8cb59iCM6aQ0M9aX2u8kMeSODt+hIh+vTG6XndvICBBQgp7+XpOvvs+czehSLXeFh8vw==
X-Received: by 2002:a05:6000:1189:b0:314:521:ce0a with SMTP id
 g9-20020a056000118900b003140521ce0amr4531254wrx.40.1689349616299; 
 Fri, 14 Jul 2023 08:46:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 t16-20020a5d49d0000000b003143bb5ecd5sm11214025wrs.69.2023.07.14.08.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 08:46:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 11/14] target/arm/ptw: Set attributes correctly for MMU
 disabled data accesses
Date: Fri, 14 Jul 2023 16:46:45 +0100
Message-Id: <20230714154648.327466-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230714154648.327466-1-peter.maydell@linaro.org>
References: <20230714154648.327466-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

When the MMU is disabled, data accesses should be Device nGnRnE,
Outer Shareable, Untagged.  We handle the other cases from
AArch64.S1DisabledOutput() correctly but missed this one.
Device nGnRnE is memattr == 0, so the only part we were missing
was that shareability should be set to 2 for both insn fetches
and data accesses.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2be6bf302b0..e4210abc148 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3106,11 +3106,13 @@ static bool get_phys_addr_disabled(CPUARMState *env,
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



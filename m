Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA71816C81
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 12:39:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFBsE-0006wZ-NS; Mon, 18 Dec 2023 06:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBsB-0006lm-RK
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:23 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFBs4-0003Kt-KZ
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 06:33:23 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3363eba94ebso2484308f8f.3
 for <qemu-devel@nongnu.org>; Mon, 18 Dec 2023 03:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702899195; x=1703503995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mkTOIRduoSdRtphW6RjCDGLMfyZbHjtFmslD+S81oCE=;
 b=xzxyt8e2t4rJH4QokNFN8DBDkcXjpYEdquDrg4v3K7Qk+4arRJqjkKGWpzkqLRGPSy
 n1g8LUFSGRTmhFwuDp/jVXkJU07wJYbcCNcVUeZ12xcSRHro3cHqmnZWSyYsG/cWTMFr
 8pSjGks7RDTekmYefU0Yq/n+UP9/vVh3kr65yNg6qOPwq3fOv82gpj2Kpq11wGLHQw7y
 8f282A6hq7IHoZEaEmGdtDEbksMgRexzuAEpvjzchkZcDmIDnI/EHv4uvVr6Ccj29HJd
 oBpxOiCquzlD3qwgwDUhSZMehBzDImjOEtmb6W+6+Mnb97IO/jjk4r7NiGjYUKlY8lYy
 Y0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899195; x=1703503995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mkTOIRduoSdRtphW6RjCDGLMfyZbHjtFmslD+S81oCE=;
 b=c484F0UZteEN1CizhT7JoSsbwFGKw5bah4jo4PNG9I5JMGXPbxhR9dSkaWa7b12CnZ
 v7LJOr864DkFZZudMEiafycjP/i85ujwEGlNZiLjPhhjJtj6iDt2SKXCCVjJKyiG8CL6
 o4Koe6hC7yxq1h7/3AiK7B9oe5O3YNss5cWsEa8qUVla4I6YQYq2FElsM44PMBXyAEDd
 /rlpPkDf+ojaqu7AyJn5LXjU8uhIUFWdTd8EFGGHXyQf7C34kd29JGJ395nG6g2fjSQy
 Aeu88KLgZhqm/yxIave9VZqmxL42sDam4HuPnmMh6Tcz0BphHJT1UxgTPjcRl7pPRHe7
 iDlA==
X-Gm-Message-State: AOJu0YxTJlYez8jEUkmGvxiPRtEVDX5ODsmtjJEOg0Hr+JcOfcNny5m0
 uBN0CYADR7Y3haWXmdYwpdVPqA==
X-Google-Smtp-Source: AGHT+IG28aGVZ24IRYz84xmrMbpkQRim8bVpDOFi2Ape20G3ApqwDAPVuRhGYkOcuUsxIDhAJaZV2Q==
X-Received: by 2002:a5d:484d:0:b0:336:67eb:ad7b with SMTP id
 n13-20020a5d484d000000b0033667ebad7bmr371013wrs.4.1702899195267; 
 Mon, 18 Dec 2023 03:33:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 j18-20020adff012000000b003366da509ecsm671193wro.85.2023.12.18.03.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 03:33:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 18/35] target/arm: Don't honour PSTATE.PAN when HCR_EL2.{NV,
 NV1} == {1, 1}
Date: Mon, 18 Dec 2023 11:32:48 +0000
Message-Id: <20231218113305.2511480-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218113305.2511480-1-peter.maydell@linaro.org>
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

For FEAT_NV, when HCR_EL2.{NV,NV1} is {1,1} PAN is always disabled
even when the PSTATE.PAN bit is set. Implement this by having
arm_pan_enabled() return false in this situation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4b0e46cfaae..28448624c36 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -266,6 +266,9 @@ void init_cpreg_list(ARMCPU *cpu)
 static bool arm_pan_enabled(CPUARMState *env)
 {
     if (is_a64(env)) {
+        if ((arm_hcr_el2_eff(env) & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1)) {
+            return false;
+        }
         return env->pstate & PSTATE_PAN;
     } else {
         return env->uncached_cpsr & CPSR_PAN;
-- 
2.34.1



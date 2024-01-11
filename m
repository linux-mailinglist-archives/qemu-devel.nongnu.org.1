Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB0982ACFC
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 12:10:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNssf-0001XM-80; Thu, 11 Jan 2024 06:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssD-0001O6-Ie
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:25 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNssB-0004Sr-2h
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 06:05:21 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3368ac0f74dso3616502f8f.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 03:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704971117; x=1705575917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RirnEYNLfsDFzm/H0oZcf/uGTEF4gj6EIg0qZ7yOeDg=;
 b=wmOOKML4EKvI6SoJI+290LPINBJxxvUviBupFM2QAEGXMtHjP3qV7Iturtgqu5Z0SW
 3uXxN02FEMmRC81xL49y3gjnGoSqlTbqpTlIc4ZE1tmKI1C83ezVxvCGCg5AA8SbQfB1
 Q6bR4DMRZ6WCyqX1vFd3/i0267pZYrkR1eCWl5DgrPXbDycwQbRJls6q1XHlZOkvxceT
 02AO0duwULwAndlgFNfMr8QhEdDjAfoM9qnBTjOAkqN4uvWN9HYykoBbLNj0vTLHcfVq
 +0Sb/Y5UpNC4C/gHIW0DeY3LvlA+4MTOCNzpTiAPrpWXZRlZjByESxO3q0hu4jDYmWaY
 FPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704971117; x=1705575917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RirnEYNLfsDFzm/H0oZcf/uGTEF4gj6EIg0qZ7yOeDg=;
 b=gtHhaSv7erIqCGdAzqLhusOo2qgnTEsawT3PHfZjqknF/EcPylPvcAchAqgvYxa2nx
 wq8uU37Fsbb4IQGIp9ScXq3T2ojSkwKRK0R1ZZaBe+ZZ4innxzoBHtqwDl6UREGDcos0
 S41BmYCCpkg92feEedP818xoeW1oY4LMzl35futi2dK0+C04CRliqz4MYXLdWl396C4a
 gngBD6SWplZcB+Cap38Jf6yNK924WOu1R6ErN7NGhkK0AUM+FyBqDwExuVhwVCu6wKMQ
 xJCzPHnrxznN0T1slESV8BvmXoOvgKwYRbZVt539Dk5pHbZf/PtvXJd6ELWl8X+OB3WZ
 sqmQ==
X-Gm-Message-State: AOJu0YzZi4JdrMR9rPUdp5ekaDnV4aBuCE/Arn+BghLDShEB1ajry06/
 5P3IuoGjRwqmXood6QPhcK0RGaOAga+M+l4YANnqSJgUw6g=
X-Google-Smtp-Source: AGHT+IFvcvPdtweL1XeIIZv0YtYd0aCMWwX3ZCCOf3zOfZWDl77UKAYLGlzmwYqAA23WHkX2+zqwlg==
X-Received: by 2002:adf:a4d0:0:b0:336:7e39:a9c7 with SMTP id
 h16-20020adfa4d0000000b003367e39a9c7mr514116wrb.141.1704971117470; 
 Thu, 11 Jan 2024 03:05:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v30-20020adf8b5e000000b0033690139ea5sm951323wra.44.2024.01.11.03.05.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 03:05:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/41] target/arm: Treat LDTR* and STTR* as LDR/STR when NV,
 NV1 is 1, 1
Date: Thu, 11 Jan 2024 11:04:49 +0000
Message-Id: <20240111110505.1563291-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111110505.1563291-1-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
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

FEAT_NV requires (per I_JKLJK) that when HCR_EL2.{NV,NV1} is {1,1} the
unprivileged-access instructions LDTR, STTR etc behave as normal
loads and stores. Implement the check that handles this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
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



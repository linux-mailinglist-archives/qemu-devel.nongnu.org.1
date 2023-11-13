Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D727EA251
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:47:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2b1W-0007HZ-1t; Mon, 13 Nov 2023 12:46:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2b1K-0006y0-8l
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:46:47 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2b1E-0003Jv-S7
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:46:46 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-408382da7f0so39268245e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699897598; x=1700502398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KnY4HIPw6PCJOFctLWZTvnAUbilKXxg/CSm+3MzKwSQ=;
 b=P0aYTjqciBSA2H4dAZOpdzmoOiT+RAqufN/qFV/hteM9okyFufE1JUiYumYWdszYYJ
 4kOiqI5AWD18gBSMYwHk+3tBvCEKtOYBdLbKP3D4Das1Hqi+kfYn+9rI2bcB7fHawcDm
 Klnr+KCegzpQZ/zoUEgNHSym5RvTtKHLE9eIyOEgyTUpcjriP0hFQ1mUdcrX9H7uHDqv
 w7i7mrqSulhszqALLpNOTZfWquop7nch1UP8fxnfBVFJ30QwAZ7sWkwjj/HN0977vlD6
 3DrfPMg+72Vm7UZmIrGtkWiCRe2T20Fp7HKIBvBI3fREbzFud8Bi37c8r6UT/IhiER/W
 WgaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699897598; x=1700502398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KnY4HIPw6PCJOFctLWZTvnAUbilKXxg/CSm+3MzKwSQ=;
 b=l9iFlG5ea+fol2q3n27NTuuokiYWru4hy4P5rLf0+GdHpSVxQ+OJuBXw1565JRsJen
 uxIKZqikk/vegfpWTlWbh4RM80+Jge4XlzJmjR787MPQ4fTf5kCNvOs4RiFJf017fwwr
 JCG8zMfkN4IixK7oLVLzh+z5Y0X1Qvj3YlE7k4tVOU3FM/IAcVLwvVFeQfAhXUZC75jJ
 /u/S9OOObKKIEyMUNlBmmEF9fPa6zfDptzRHY5LUkAnfxTwUskp8Q+Eju8RvzbUswx0g
 rtpBiaBLs9IVYSKRfDynPAb+1PpROrc3cKUKCDUW79lBzpAq/RsozYNLs+tk7Uq6twHY
 udwA==
X-Gm-Message-State: AOJu0Yye46nPnMwQDsDA/RJK4efyaLiIJwz0vGmKv+Z4ZJm4SLEWk2v0
 2E6MMtl73J0MlAOMHqPWbDzsl+igw3ghcOeMYBg=
X-Google-Smtp-Source: AGHT+IG16HnBSK1K6jsR+STuT2bCdFzzaBwibOUQ6gYoBsDtVtwuRbQep4NQYOaUkD9vU2v0pAejxg==
X-Received: by 2002:a05:600c:4f47:b0:405:34e4:14e3 with SMTP id
 m7-20020a05600c4f4700b0040534e414e3mr5517848wmq.3.1699897598163; 
 Mon, 13 Nov 2023 09:46:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c22c800b0040303a9965asm14391110wmg.40.2023.11.13.09.46.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:46:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/4] target/arm: HVC at EL3 should go to EL3, not EL2
Date: Mon, 13 Nov 2023 17:46:33 +0000
Message-Id: <20231113174635.2540484-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113174635.2540484-1-peter.maydell@linaro.org>
References: <20231113174635.2540484-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

AArch64 permits code at EL3 to use the HVC instruction; however the
exception we take should go to EL3, not down to EL2 (see the pseudocode
AArch64.CallHypervisor()). Fix the target EL.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar@zeroasic.com>
Message-id: 20231109151917.1925107-1-peter.maydell@linaro.org
---
 target/arm/tcg/translate-a64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 41484d8ae54..a2e49c39f9f 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2351,6 +2351,8 @@ static bool trans_SVC(DisasContext *s, arg_i *a)
 
 static bool trans_HVC(DisasContext *s, arg_i *a)
 {
+    int target_el = s->current_el == 3 ? 3 : 2;
+
     if (s->current_el == 0) {
         unallocated_encoding(s);
         return true;
@@ -2363,7 +2365,7 @@ static bool trans_HVC(DisasContext *s, arg_i *a)
     gen_helper_pre_hvc(tcg_env);
     /* Architecture requires ss advance before we do the actual work */
     gen_ss_advance(s);
-    gen_exception_insn_el(s, 4, EXCP_HVC, syn_aa64_hvc(a->imm), 2);
+    gen_exception_insn_el(s, 4, EXCP_HVC, syn_aa64_hvc(a->imm), target_el);
     return true;
 }
 
-- 
2.34.1



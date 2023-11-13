Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE997EA1DC
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:33:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2anr-0001Sj-II; Mon, 13 Nov 2023 12:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2ann-0001SE-Fh
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:47 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r2anj-0000v3-Q5
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:32:47 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1cc938f9612so28898165ad.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699896761; x=1700501561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lo0lQlUWSBjMt9Vl8JT1SFLp9AI2+HeOXlIlVWGHESw=;
 b=ieR7ZysYVpogFKfFx/fUMlikQ2yy9HgJ7G4B800slT2knetGrikwZ+Q+rT2OSx/pYY
 a9xfQDmJUEp/rPjX0Ux0iQVfWOL0mRiQexMzzeFpQhyIKn1b0Dt8dkmOo4tYHZQtUFCC
 JmSvDM0yBNmvVCcFlX06Hlbhp1aMhT7ZNFTO8XvJpBs4WcnIgzssUldqcL74lwO1sKze
 dF0WUWV7yOFKmRhFtPodS9uiED9b/c/ZVLadtwT7irBFnAyNsgGskUd10pacA7OB8XnV
 tKOJtb58QHef190H44JIYh5Q5QVU4GAK8p9tJXBrDNOzS5hhaQJ7g/+Qxs4OuBDPQXgS
 Rn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699896761; x=1700501561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lo0lQlUWSBjMt9Vl8JT1SFLp9AI2+HeOXlIlVWGHESw=;
 b=DmL8uDiJC6Tied3nQ8cVZd7o05rzzsfILSH0Ojzq4bHgdW4/uEesYiIouourN1PJz/
 QWzZDXijk0InGPMd6kO9zzn8BcaMSncJyd7U0nZg71U5T3wQFHfKjX6ehMJH+M4/fhKS
 LRFyXZH0ttVRK5mqjy0Dfqr2eU24Z/tO74+emmwtMUe6j0oMutuEFPLXYxSRu5oghiGL
 qe3pv+/eImRI80HtQXJCuq3VtjGPfOfF08sjbpYO8cIFGn4L0cdJ20sBTlpP7SH8RYhF
 g3CtA61r3W4/6Wbpwz1PjqrTkJ6dpoIid2phc9s9InwF2YEcOTvvdC1GZF27S1xafd6i
 6q+g==
X-Gm-Message-State: AOJu0Yw+wyBh0sQKzX6tJd8L1bLYAxHk27WmgkB4l5NCn4u0EpW0BAK+
 EyRdySeHviYunVafZ6suztacnPuDXriGxBJyzY8=
X-Google-Smtp-Source: AGHT+IHpAyrs/W0P68TiJcV3VNIxJxkIzzJHbPWNG9shmpCdqOTZ6pDZfv8qP/+zaN1kw1q4dZDeXA==
X-Received: by 2002:a17:902:8201:b0:1ce:a0b:7314 with SMTP id
 x1-20020a170902820100b001ce0a0b7314mr215816pln.61.1699896761208; 
 Mon, 13 Nov 2023 09:32:41 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001c731b62403sm4271910pld.218.2023.11.13.09.32.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Nov 2023 09:32:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/12] target/hppa: Use PRIV_P_TO_MMU_IDX in helper_probe
Date: Mon, 13 Nov 2023 09:32:28 -0800
Message-Id: <20231113173237.48233-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231113173237.48233-1-richard.henderson@linaro.org>
References: <20231113173237.48233-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Direct privilege level to mmu_idx mapping has been
false for some time.  Provide the correct value to
hppa_get_physical_address.

Fixes: fa824d99f9b ("target/hppa: Switch to use MMU indices 11-15")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/op_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/hppa/op_helper.c b/target/hppa/op_helper.c
index a0e31c0c25..7f607c3afd 100644
--- a/target/hppa/op_helper.c
+++ b/target/hppa/op_helper.c
@@ -338,7 +338,7 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
 #ifdef CONFIG_USER_ONLY
     return page_check_range(addr, 1, want);
 #else
-    int prot, excp;
+    int prot, excp, mmu_idx;
     hwaddr phys;
 
     trace_hppa_tlb_probe(addr, level, want);
@@ -347,7 +347,8 @@ target_ulong HELPER(probe)(CPUHPPAState *env, target_ulong addr,
         return 0;
     }
 
-    excp = hppa_get_physical_address(env, addr, level, 0, &phys,
+    mmu_idx = PRIV_P_TO_MMU_IDX(level, env->psw & PSW_P);
+    excp = hppa_get_physical_address(env, addr, mmu_idx, 0, &phys,
                                      &prot, NULL);
     if (excp >= 0) {
         if (env->psw & PSW_Q) {
-- 
2.34.1



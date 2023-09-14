Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B043879F85B
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 04:46:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgcM3-0000jO-ES; Wed, 13 Sep 2023 22:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLr-0000iP-7u
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:45:07 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qgcLi-0000jN-84
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 22:45:06 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1c0c6d4d650so4079325ad.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 19:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694659497; x=1695264297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EZT5ING+ZE481qx/oDCBgxI53LQt2Fh48UZBAugo2ys=;
 b=vuOJyz9ix6p6drBddsed9E81bAua+ca9eB6dF3/KpnaQuExsszNLAnt6uyPOn2+KXP
 d00lFZh2nNVHwveCuCd4r1bw3dAfsFFjKSaGOCxvL+kECt2xiXMwsYmgs3IHdC1eLgHy
 4/Y1SIYQWr66IDEOFMKivoeMY5BaUlux+dGc1rVHua3tZzBu9C+jC8u2EFofYuwb2o5j
 UpePr+aKCLWHePL0ioyLYknKIwJdXAw7winLHk707MATEwq4Pxg52+k94/u+Jx3KLnXC
 96FZjRfuJo51TXh9Q5e+fhaniqPL0PouD2cBu7tT1O/WnEsV0Qc+FymbckrvXEVxnsEY
 Cs8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694659497; x=1695264297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EZT5ING+ZE481qx/oDCBgxI53LQt2Fh48UZBAugo2ys=;
 b=FXNza4fftiWCpsHMI6A3omGhiO0BzoFM1fyOHUJfFjeUIJjROZ4XbdA+WK+uZ56rZc
 zjLa6JdRqaCEybCoPQUfo0/bWQgAAkXqQAIksjDkLKSK0Sgr8dGFNuGVx0vpNvyH7xKy
 bFXw7EZNSdWU9OM5pSQ77ia5PXIqxwFSLAlnfV1Y7yZmz2v2gBSn/uHG1S0exXPwUszY
 SZ2A14cpQYQ9do+Z0/7N+d/IoYK406vCzI9YhjJqcuaSUFaky3V26UqivTZSm1RFmPdg
 VZuIGFqSxi401Uc1ptW48Cze/3dYBwRBQviplaJWZjqHy6DfHs3hmiS6Tz/4CjaogLyG
 3s3g==
X-Gm-Message-State: AOJu0YwerjqYEkHQCjpiKuxgfxUQblOMbYv31vbsr5ctFBuYRHx6l5Nz
 5NywOqUn0JLVZPSXJ024Khh6HEO+xGxZLik/9Bo=
X-Google-Smtp-Source: AGHT+IFRFdl4tQsVhvbNAf/PSdPkIccwCQxJqwk5fSunGWzbHBKyMJzaTik6EQ9WjxHDmnxaMfhpqA==
X-Received: by 2002:a17:903:1248:b0:1bd:e998:ec0a with SMTP id
 u8-20020a170903124800b001bde998ec0amr5176889plh.67.1694659496980; 
 Wed, 13 Sep 2023 19:44:56 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x24-20020a170902b41800b001bbdf32f011sm304336plr.269.2023.09.13.19.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 19:44:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng,
	ale@rev.ng,
	philmd@linaro.org
Subject: [PATCH v2 22/24] accel/tcg: Remove env_tlb()
Date: Wed, 13 Sep 2023 19:44:33 -0700
Message-Id: <20230914024435.1381329-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914024435.1381329-1-richard.henderson@linaro.org>
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

From: Anton Johansson <anjo@rev.ng>

The function is no longer used to access the TLB,
and has been replaced by cpu->neg.tlb.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20230912153428.17816-9-anjo@rev.ng>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[rth: Merge comment update patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h       | 11 -----------
 tcg/aarch64/tcg-target.c.inc |  2 +-
 tcg/arm/tcg-target.c.inc     |  2 +-
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index af9516654a..b37715c27d 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -451,15 +451,4 @@ static inline CPUState *env_cpu(CPUArchState *env)
     return (void *)env - sizeof(CPUState);
 }
 
-/**
- * env_tlb(env)
- * @env: The architecture environment
- *
- * Return the CPUTLB state associated with the environment.
- */
-static inline CPUTLB *env_tlb(CPUArchState *env)
-{
-    return &env_cpu(env)->neg.tlb;
-}
-
 #endif /* CPU_ALL_H */
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 0931a69448..0db4c907e3 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1676,7 +1676,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     mask_type = (s->page_bits + s->tlb_dyn_max_bits > 32
                  ? TCG_TYPE_I64 : TCG_TYPE_I32);
 
-    /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {tmp0,tmp1}. */
+    /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {tmp0,tmp1}. */
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 8);
     tcg_out_insn(s, 3314, LDP, TCG_REG_TMP0, TCG_REG_TMP1, TCG_AREG0,
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index acb5f23b54..75978018c9 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1420,7 +1420,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     ldst->addrlo_reg = addrlo;
     ldst->addrhi_reg = addrhi;
 
-    /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {r0,r1}.  */
+    /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {r0,r1}.  */
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 4);
     tcg_out_ldrd_8(s, COND_AL, TCG_REG_R0, TCG_AREG0, fast_off);
-- 
2.34.1



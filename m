Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DDB7B6FFA
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 19:37:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnjFC-00005R-Kl; Tue, 03 Oct 2023 13:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF4-0008So-6x
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:31 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qnjF0-0007WW-WF
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 13:31:29 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5827f6d60aaso808361a12.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 10:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696354285; x=1696959085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1udcc8vCKKwT3FbIMobjuTK/NedfRQvAlVj2pEkzf1w=;
 b=Ff32LQzXQiUdsIMWt7yFnMjy0DQukSbL9B9KMSJs588agLn/QYIYopnEeACOI9Op8O
 HIwU79qwIDkHVCaeQJ5JMu2l6jOjcF4J9Q7Z9iBtFAA6eSP48CW45hZBU/JI1KiGsXc3
 U+tImTakCOkTMvnQ1pZP46nppyOiB1AUgEkD4e48jv5o3gmlAuV8f/Ap6W0h/+Ojfe1n
 TOxQTZTihY0OAtssCSeq7iABDIp9F7YOAgN93FilEmyVv1QzurF7hV+8rTL2vM3MFPmz
 udKOmV7ciJxMF33YIuexQqlw9F7duoYh+GMyWiu+Kr9kOGIa0iFkMiP+JIE2OkRCdV1X
 kRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696354285; x=1696959085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1udcc8vCKKwT3FbIMobjuTK/NedfRQvAlVj2pEkzf1w=;
 b=ksRLPzyhH4mRaSxRgPM1jh+Xy/IyIC4FdDG2AywUjvkeYVWVcDkuM6mS7hTnT16Bzd
 c//eU8nYTR2Jc/r8oCsFnVT1yX0bNl25jOdsR1qFibmjRiE9Pbk0+a8a0ujeusX5CCJl
 9COF6qd97PaGepFD7orFO1z5bfeuHLx13Qw6GRLFbEFy1oxKMgIHhWObt/tcPHO/lFtv
 46sG54PzMi44A7lvDAzZPzvfMjQsJ2BRNV/uAaUVVBcMgLXH5rEkDR/YtTrEBhAohGXx
 jdNzyKnEpt1VCDoSoqCHRbfzDPEX9B++hM29s+RiGdr1S6RZxrLLbLj609HE0QupJKoF
 M7NA==
X-Gm-Message-State: AOJu0YwvuziqhygWHtBKRlQBpTrxF+00CTWTyrKR27M9FDyhnkaBI2PK
 f/lY5VVUcxIULnJS2ISXbV8jRKo7fL3SDz0sYNw=
X-Google-Smtp-Source: AGHT+IHpfoUx/L/ER3c2pxnw1OT/N2SwmycM0+UA6bXHWlG0qDRbuCYieRnBsuwUs18xHkZkqlgi0w==
X-Received: by 2002:a05:6a20:734a:b0:15d:641b:57b6 with SMTP id
 v10-20020a056a20734a00b0015d641b57b6mr145113pzc.5.1696354285053; 
 Tue, 03 Oct 2023 10:31:25 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020aa78a47000000b00692c5b1a731sm1620195pfa.186.2023.10.03.10.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 10:31:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/47] accel/tcg: Remove env_tlb()
Date: Tue,  3 Oct 2023 10:30:33 -0700
Message-Id: <20231003173052.1601813-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003173052.1601813-1-richard.henderson@linaro.org>
References: <20231003173052.1601813-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[rth: Merge comment update patch]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/cpu-all.h       | 11 -----------
 tcg/aarch64/tcg-target.c.inc |  2 +-
 tcg/arm/tcg-target.c.inc     |  2 +-
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 46e494eeba..17c7420543 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -449,15 +449,4 @@ static inline CPUState *env_cpu(CPUArchState *env)
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
index 06ea3c7652..69f2daf2c2 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -1679,7 +1679,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
     mask_type = (s->page_bits + s->tlb_dyn_max_bits > 32
                  ? TCG_TYPE_I64 : TCG_TYPE_I32);
 
-    /* Load env_tlb(env)->f[mmu_idx].{mask,table} into {tmp0,tmp1}. */
+    /* Load cpu->neg.tlb.f[mmu_idx].{mask,table} into {tmp0,tmp1}. */
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, mask) != 0);
     QEMU_BUILD_BUG_ON(offsetof(CPUTLBDescFast, table) != 8);
     tcg_out_insn(s, 3314, LDP, TCG_REG_TMP0, TCG_REG_TMP1, TCG_AREG0,
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index b1d56362a7..a2f60106af 100644
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



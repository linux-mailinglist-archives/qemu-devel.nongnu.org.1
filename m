Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D34567E3383
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:06:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CPG-0007oI-Q5; Mon, 06 Nov 2023 22:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COR-0006uj-Q8
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:44 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0COL-0000gF-4a
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:04:43 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1cc2575dfc7so37448415ad.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326265; x=1699931065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LHnqcTd2zYy6MQLA9+Bgtzlrc46QZUrJeWNi/+sdBfc=;
 b=JEUHSSjGNkWO7RdYfJ3cuWVyXGNZwXuSsgOrBYHSwymGkozfGzDDVCpBLQZhp1wmPI
 vGrPHirmpuok2N1kFG1iLcJ0trCRVjI/erNndH223l/Npgy29MqHsXdkyUO/WwCFCw/1
 U/kyDs/awU0nAF02GDqqARCHtaWpd3lk91Dy9v88wZLE1muWdriglpq/I2vrwRJ1+SXf
 VmhiMUhmw+3umHeb2pE2YHdJGU/vZjomySHENR2Xj77EWSo4rG76nFjqQTSZIoyfFHMY
 fTrYcu7e3LLyPaOkrdFmlsT37SdfWE/0LUT1CSC12zVxBPwEPnuVEWwB+Pg3khguzG/l
 a3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326265; x=1699931065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHnqcTd2zYy6MQLA9+Bgtzlrc46QZUrJeWNi/+sdBfc=;
 b=qbp6vF/rHt7xLTqp4i27Rz/EsiTN3gU4R4+RBVILvM5Bmklrohr6kgQS3bx7m1IUJW
 +x5vsc0zWvxFmaxB4p0btAL8QmQL6juJsEKXrHVwywPtX2neBvHEoFry9fGhpSfI1QKR
 Oxv2Zi3z0DEo655nuj553XQMEFD8UKK5CdCortje0INSX/rIMQv4ZM823yxVc/5avxd5
 AQstSSiIhteT52FNrZUSSw4sRd6d2yBPxBZLwlJnUoSU8o1B93lK4iJ7jUGxcoihXub1
 zfEKstamuMlV5jcJf6mMG3RulEQhAcECJWCjabpC4c6raj4qn6rss+b4v6Lc+OWsd0wx
 cKrQ==
X-Gm-Message-State: AOJu0YzMgCWbS3/x+TbWfWBIJ+MtZmtI7hx4xBGUm1bBpKAbNEOXo7CQ
 EH5zo/pzOjcUMcufDUcQlzJQrfTsRH8DvR1pGLM=
X-Google-Smtp-Source: AGHT+IH8KIjfRDsiimKNqB0jzU9bT7K2nrW5G9pzcd9cVeVIY4c32KMc2C7SZEtGP2gltUBGqd0zmw==
X-Received: by 2002:a05:6a20:7fa8:b0:184:26f8:4396 with SMTP id
 d40-20020a056a207fa800b0018426f84396mr5519618pzj.21.1699326265029; 
 Mon, 06 Nov 2023 19:04:25 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 u9-20020a17090282c900b001c72d5e16acsm6518012plz.57.2023.11.06.19.04.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:04:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/85] target/hppa: Handle absolute addresses for pa2.0
Date: Mon,  6 Nov 2023 19:03:04 -0800
Message-Id: <20231107030407.8979-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

With pa2.0, absolute addresses are not the same as physical addresses,
and undergo a transformation based on PSW_W.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h        |  3 +++
 target/hppa/mem_helper.c | 43 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 301c82114a..2999df9ff9 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -313,6 +313,9 @@ static inline target_ulong hppa_form_gva(CPUHPPAState *env, uint64_t spc,
     return hppa_form_gva_psw(env->psw, spc, off);
 }
 
+hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr);
+hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr);
+
 /*
  * Since PSW_{I,CB} will never need to be in tb->flags, reuse them.
  * TB_FLAG_SR_SAME indicates that SR4 through SR7 all contain the
diff --git a/target/hppa/mem_helper.c b/target/hppa/mem_helper.c
index 327fb20c17..420b43a0f6 100644
--- a/target/hppa/mem_helper.c
+++ b/target/hppa/mem_helper.c
@@ -25,6 +25,45 @@
 #include "hw/core/cpu.h"
 #include "trace.h"
 
+hwaddr hppa_abs_to_phys_pa2_w1(vaddr addr)
+{
+    if (likely(extract64(addr, 58, 4) != 0xf)) {
+        /* Memory address space */
+        return addr & MAKE_64BIT_MASK(0, 62);
+    }
+    if (extract64(addr, 54, 4) != 0) {
+        /* I/O address space */
+        return addr | MAKE_64BIT_MASK(62, 2);
+    }
+    /* PDC address space */
+    return (addr & MAKE_64BIT_MASK(0, 54)) | MAKE_64BIT_MASK(60, 4);
+}
+
+hwaddr hppa_abs_to_phys_pa2_w0(vaddr addr)
+{
+    if (likely(extract32(addr, 28, 4) != 0xf)) {
+        /* Memory address space */
+        return addr & MAKE_64BIT_MASK(0, 32);
+    }
+    if (extract32(addr, 24, 4) != 0) {
+        /* I/O address space */
+        return addr | MAKE_64BIT_MASK(32, 32);
+    }
+    /* PDC address space */
+    return (addr & MAKE_64BIT_MASK(0, 24)) | MAKE_64BIT_MASK(60, 4);
+}
+
+static hwaddr hppa_abs_to_phys(CPUHPPAState *env, vaddr addr)
+{
+    if (!hppa_is_pa20(env)) {
+        return addr;
+    } else if (env->psw & PSW_W) {
+        return hppa_abs_to_phys_pa2_w1(addr);
+    } else {
+        return hppa_abs_to_phys_pa2_w0(addr);
+    }
+}
+
 static HPPATLBEntry *hppa_find_tlb(CPUHPPAState *env, vaddr addr)
 {
     IntervalTreeNode *i = interval_tree_iter_first(&env->tlb_root, addr, addr);
@@ -222,7 +261,7 @@ int hppa_get_physical_address(CPUHPPAState *env, vaddr addr, int mmu_idx,
     }
 
  egress:
-    *pphys = phys;
+    *pphys = phys = hppa_abs_to_phys(env, phys);
     *pprot = prot;
     trace_hppa_tlb_get_physical_address(env, ret, prot, addr, phys);
     return ret;
@@ -238,7 +277,7 @@ hwaddr hppa_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     /* ??? We really ought to know if the code mmu is disabled too,
        in order to get the correct debugging dumps.  */
     if (!(cpu->env.psw & PSW_D)) {
-        return addr;
+        return hppa_abs_to_phys(&cpu->env, addr);
     }
 
     excp = hppa_get_physical_address(&cpu->env, addr, MMU_KERNEL_IDX, 0,
-- 
2.34.1



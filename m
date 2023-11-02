Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA2C7DEA0A
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 02:32:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyMYJ-0005nM-BO; Wed, 01 Nov 2023 21:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXk-0005kN-J8
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:44 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyMXi-0001c3-Rt
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 21:30:44 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso487467b3a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 18:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698888641; x=1699493441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHnqcTd2zYy6MQLA9+Bgtzlrc46QZUrJeWNi/+sdBfc=;
 b=GBCcEeLbe0ymr0cQrB2N7RtHXOdjy/BbTKMa6UAhh4XtQb46Z9tavYfjW1hpaa3jAx
 XSTXdy2KPltg51tat39vtrKXE+OMxpZzByJf+7dQ9FceFpyb2ZEs8DgT1JjRmUAWMDVd
 Wnz8N1HliVZ5XuuRQaENyhgYR6LZzoQXZsYCfiqpMKmur3oQyHOdmE6WzRs3eLEuZwJS
 LNVwCCR3j5LBbQz1K9DEZZ4hUcljmn8yyPbj6JANiEQbXgCEND/9VEfgedEOajpAvBpp
 77B06cFuNG9+Xa5f5z4Ulxr/yjGHftGAt+KGscDZNKI8WYoSB2De+18fgtiUZCgzQPRT
 aTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698888641; x=1699493441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHnqcTd2zYy6MQLA9+Bgtzlrc46QZUrJeWNi/+sdBfc=;
 b=XoYhBtS8hRN/fg/Xplghijh5UDoEdmwo6YsrAJoaaukJtiBpoi4ZbgdH2B87PRboZc
 xbQOpmn+EagwL3DtyZgBWBqg2s3O2fJmfI34ss/KaAGwLHpg4k7DxgVIu9vIo2MEt42K
 U8p5iJMG4TW4JnwAAflzwJNJLz3mGcWeSAUDA3zEfDEoulC/cdUWBa/Y/uEPFs6r+D/O
 eOyF06ud0OAvUJfyUXn5PYjVkk5h+gU+X5m3WpausDymY8+UH6Wh7VZP9s2lk6zHkqRV
 7kjblnOt6hQUDSCf4llyBp2zfUgkq32yJgvZzXJQVqyyVs5BKo4D2N4T8EvsPMFj7Xr4
 550w==
X-Gm-Message-State: AOJu0YzE9BU11IPBD8y2m0SO5E3lEpFBCdmrcRkRcYrJxZPp7gTchwZW
 tL8dmld6hYKZb3VK5176TUfu5qFGKrc0yyiKJe4=
X-Google-Smtp-Source: AGHT+IHxodQIJlhMiebY/6qd49NsNvct0p8tEuBTEHSPG7AZiBV4yjhcpXES+aNbkxRbLH0TuE7awg==
X-Received: by 2002:a05:6a00:1488:b0:6be:b79:eca with SMTP id
 v8-20020a056a00148800b006be0b790ecamr21174106pfu.32.1698888640583; 
 Wed, 01 Nov 2023 18:30:40 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r23-20020aa78457000000b006979f70fdd5sm1784191pfn.219.2023.11.01.18.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 18:30:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v3 24/88] target/hppa: Handle absolute addresses for pa2.0
Date: Wed,  1 Nov 2023 18:29:12 -0700
Message-Id: <20231102013016.369010-25-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231102013016.369010-1-richard.henderson@linaro.org>
References: <20231102013016.369010-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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



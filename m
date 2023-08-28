Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A5578B7AC
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:57:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qahP9-0000qm-Bc; Mon, 28 Aug 2023 14:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP7-0000po-9D
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:56:01 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qahP5-0002S2-3K
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:56:01 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-26b44247123so2254482a91.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693248957; x=1693853757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zs4ouB+IX/j6ZyzVg7pnpseLfh71GLbrppugYTGLrDA=;
 b=lN7aAqolA/8tcvFHR0Zvln/tX1gsiAtzxgz8PfQaTFRmO4Q2G1WExradIaVLUIKdHL
 lnWGtKE0VB4kOMgeg5CMLaKdkUQ8q+sfyrG5hF6moKywqNAx4TaQQJTI15iSsVwFbG+7
 rIduSO6Jx2kCErACxo/K4oiuS8QRlBEnPOUKneSYWL1hMbeEmgFcsmnnbaxVU680J17n
 kOQuW+aGs19UGzBY2gSMA4jr0Fw87cgiLsDFPlOTUYJPTWlnItLcmW+dBfsn0bYuC+cO
 etuExAJEsDvP9ox0qw2WQ0QkRAy0/HSKy1945M4j/9yyN6/SoO4p97VSsT0hgmLMZBXA
 g3jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693248957; x=1693853757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zs4ouB+IX/j6ZyzVg7pnpseLfh71GLbrppugYTGLrDA=;
 b=V+U5b9noFalV2T2A32Y82ZdKVqrkFMa0GccHckzQ3u8FBtx7/NECWrtHtUPoy7rerV
 19PZ7/6AsPhXZUlakNEQ2vn/g862kFfYYGGTg9Fnpe08393okogMxpKNgpE6tVEl0Ztq
 fhgdKb1d3c9H0tuvEHgulbILk1PkjEJ2be8eIEc+3gGDYnubezoHVXIOZXBcZZB/BD14
 nFU6xZ958zWHgAXaEOK70aKycVaqQ3e5kkOGGIfGMNDgRVotlUz6C5PMQR61h874Dw+f
 Ej7kbZa7S9IibVYTKYvxdY4JLbPIPK1hl4QotLX8jvJS65PQhlTq+4wl053P85Yh7yAG
 y46g==
X-Gm-Message-State: AOJu0YzE1ZhzN9H+IRq35X0BO8nra1rDpX1ixLkmjZdLhxbbXFXJ3dUE
 trDiY1W/AgnUMU0hTfbEsePkKSZJhElt4BnxBC8=
X-Google-Smtp-Source: AGHT+IFzDI2HViV8nPd3B9S2CPNog0xZI3BM1ZOSsFsSB/wuoj8HM+8LB3y/FihbQt+5NJgIwj9KeQ==
X-Received: by 2002:a17:90b:4015:b0:262:e3aa:fd73 with SMTP id
 ie21-20020a17090b401500b00262e3aafd73mr25314055pjb.17.1693248957185; 
 Mon, 28 Aug 2023 11:55:57 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 4-20020a17090a190400b002680dfd368dsm7932835pjg.51.2023.08.28.11.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 11:55:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH 05/10] accel/tcg: Merge cpu_transaction_failed into io_failed
Date: Mon, 28 Aug 2023 11:55:45 -0700
Message-Id: <20230828185550.573653-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828185550.573653-1-richard.henderson@linaro.org>
References: <20230828185550.573653-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Push computation down into the if statements to the point
the data is used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b1dc213675..d2e4c4459d 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1347,23 +1347,6 @@ static inline void cpu_unaligned_access(CPUState *cpu, vaddr addr,
                                           mmu_idx, retaddr);
 }
 
-static inline void cpu_transaction_failed(CPUState *cpu, hwaddr physaddr,
-                                          vaddr addr, unsigned size,
-                                          MMUAccessType access_type,
-                                          int mmu_idx, MemTxAttrs attrs,
-                                          MemTxResult response,
-                                          uintptr_t retaddr)
-{
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (!cpu->ignore_memory_transaction_failures &&
-        cc->tcg_ops->do_transaction_failed) {
-        cc->tcg_ops->do_transaction_failed(cpu, physaddr, addr, size,
-                                           access_type, mmu_idx, attrs,
-                                           response, retaddr);
-    }
-}
-
 static MemoryRegionSection *
 io_prepare(hwaddr *out_offset, CPUArchState *env, hwaddr xlat,
            MemTxAttrs attrs, vaddr addr, uintptr_t retaddr)
@@ -1387,9 +1370,19 @@ static void io_failed(CPUArchState *env, CPUTLBEntryFull *full, vaddr addr,
                       unsigned size, MMUAccessType access_type, int mmu_idx,
                       MemTxResult response, uintptr_t retaddr)
 {
-    hwaddr physaddr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
-    cpu_transaction_failed(env_cpu(env), physaddr, addr, size, access_type,
-                           mmu_idx, full->attrs, response, retaddr);
+    CPUState *cpu = env_cpu(env);
+
+    if (!cpu->ignore_memory_transaction_failures) {
+        CPUClass *cc = CPU_GET_CLASS(cpu);
+
+        if (cc->tcg_ops->do_transaction_failed) {
+            hwaddr physaddr = full->phys_addr | (addr & ~TARGET_PAGE_MASK);
+
+            cc->tcg_ops->do_transaction_failed(cpu, physaddr, addr, size,
+                                               access_type, mmu_idx,
+                                               full->attrs, response, retaddr);
+        }
+    }
 }
 
 static uint64_t io_readx(CPUArchState *env, CPUTLBEntryFull *full,
-- 
2.34.1



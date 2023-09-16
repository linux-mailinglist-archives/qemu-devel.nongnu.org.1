Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9385C7A32C6
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Sep 2023 23:46:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhd3q-0006Tw-4b; Sat, 16 Sep 2023 17:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd3E-0005FB-GW
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:42:05 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhd3C-0000X0-H0
 for qemu-devel@nongnu.org; Sat, 16 Sep 2023 17:42:04 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68fb79ef55eso3072383b3a.0
 for <qemu-devel@nongnu.org>; Sat, 16 Sep 2023 14:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694900521; x=1695505321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/vqtkvJT/Vw/H5/mpmX6Mg0BjPMCG8MlnFWEAZngwVE=;
 b=n+BkgR+qhBzCHIcmlgxhaJH/RKCgbvyUWORMjaBhYLW88hMQF6yRAAP1tBe4hilYtW
 d2oOYGOPyLflM41Gcr687D6DjWQ8lNe/tcGEcYKrQiKC6eG7vZ7WUldQabfALSR0sn4I
 1MSbSnyi7sVNxpwKaGx2Pdz/odffefl+LYLH5aH67T+HiBtzvBvtu2fTdeQxF3imDb86
 8G92BpPjsMcKQoT1kmM5lP7bDTG/zCLfvOHpcLRXOWRMSbk9D7wtOCE9L0aGOPiHG+4C
 w7rOQqW2Iw95kxf+oKAuuBdSHobN9hwAst75x82rEa4iSN0xkhgF4Req3ItPuA32a+xd
 rA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694900521; x=1695505321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/vqtkvJT/Vw/H5/mpmX6Mg0BjPMCG8MlnFWEAZngwVE=;
 b=i6yzjk9ALXdpXPc/6wHijfgz/b7sI0rulrULDCcH6Mh+MmUoy2f0uPmeqieNT30kEM
 WQGC1KiUDVstrj1iXEwzHtVwtmHSHajYncn0xiGG0pd+N6+JAcgbv7RryJ4oD7ju14Zl
 M/aTFPjRY09s07Vj/HHA/Kgiy0285VdwCYlsDRniC1jv25Sb12ii6ViGu9YmLBSMixnY
 ZAlUB9tHyICnvGxsSK9TYR5Col1zcECJtQq20R8O6e8csxl9HvFql7jbiiJlHYuyNH6w
 3CmwP1OzeGtqVysUxH90ffKzaJXC9lalZ5Mt9e8uQoJkj5gAMChqCY0Gc2HJINx1jlUd
 3DaA==
X-Gm-Message-State: AOJu0Yyy3YIs7k5cBdta/lQ7gykle0wt/L296LKYUB/z+bpquRCqZKZ5
 QfOATWQAtn9/h5oyPr2t8EpoaOEdfMNP7ReQDHA=
X-Google-Smtp-Source: AGHT+IHHWkkEcG43cmjohgmyerrsd6EDb86z8Fos3TLM0S2vCuwu+2kaqR1tvyvCIZyogV8Q8jo0yQ==
X-Received: by 2002:a05:6a00:1490:b0:690:454a:dc7b with SMTP id
 v16-20020a056a00149000b00690454adc7bmr6779612pfu.28.1694900521393; 
 Sat, 16 Sep 2023 14:42:01 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 n21-20020aa79055000000b0068fde95aa93sm4871708pfo.135.2023.09.16.14.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Sep 2023 14:42:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	anjo@rev.ng
Subject: [PATCH v3 39/39] accel/tcg: Restrict tcg_exec_[un]realizefn() to TCG
Date: Sat, 16 Sep 2023 14:41:23 -0700
Message-Id: <20230916214123.525796-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230916214123.525796-1-richard.henderson@linaro.org>
References: <20230916214123.525796-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We don't need to expose these TCG-specific methods to the
whole code base. Register them as AccelClass handlers, they
will be called by the generic accel_cpu_[un]realize() methods.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230915190009.68404-6-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/internal-target.h | 3 +++
 include/exec/cpu-all.h      | 2 --
 accel/tcg/tcg-all.c         | 2 ++
 cpu-target.c                | 8 --------
 4 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
index 932bbe4b63..4e36cf858e 100644
--- a/accel/tcg/internal-target.h
+++ b/accel/tcg/internal-target.h
@@ -80,6 +80,9 @@ bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
 void cpu_restore_state_from_tb(CPUState *cpu, TranslationBlock *tb,
                                uintptr_t host_pc);
 
+bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
+void tcg_exec_unrealizefn(CPUState *cpu);
+
 /* Return the current PC from CPU, which may be cached in TB. */
 static inline vaddr log_pc(CPUState *cpu, const TranslationBlock *tb)
 {
diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index 6c1db14842..5340907cfd 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -410,8 +410,6 @@ static inline bool tlb_hit(uint64_t tlb_addr, vaddr addr)
 
 /* accel/tcg/cpu-exec.c */
 int cpu_exec(CPUState *cpu);
-bool tcg_exec_realizefn(CPUState *cpu, Error **errp);
-void tcg_exec_unrealizefn(CPUState *cpu);
 
 /* Validate correct placement of CPUArchState. */
 QEMU_BUILD_BUG_ON(offsetof(ArchCPU, parent_obj) != 0);
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index b32e0b80ec..a40e0aee37 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -227,6 +227,8 @@ static void tcg_accel_class_init(ObjectClass *oc, void *data)
     AccelClass *ac = ACCEL_CLASS(oc);
     ac->name = "tcg";
     ac->init_machine = tcg_init_machine;
+    ac->realize_cpu = tcg_exec_realizefn;
+    ac->unrealize_cpu = tcg_exec_unrealizefn;
     ac->allowed = &tcg_allowed;
     ac->gdbstub_supported_sstep_flags = tcg_gdbstub_supported_sstep_flags;
 
diff --git a/cpu-target.c b/cpu-target.c
index b928bbed50..1a8e730bed 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -140,11 +140,6 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
         return;
     }
 
-    /* NB: errp parameter is unused currently */
-    if (tcg_enabled()) {
-        tcg_exec_realizefn(cpu, errp);
-    }
-
     /* Wait until cpu initialization complete before exposing cpu. */
     cpu_list_add(cpu);
 
@@ -190,9 +185,6 @@ void cpu_exec_unrealizefn(CPUState *cpu)
      * accel_cpu_unrealize, which may free fields using call_rcu.
      */
     accel_cpu_unrealize(cpu);
-    if (tcg_enabled()) {
-        tcg_exec_unrealizefn(cpu);
-    }
 }
 
 /*
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C76F7BD92B
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:04:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpo32-0006vD-Gh; Mon, 09 Oct 2023 07:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpo2p-0006df-2n
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:03:27 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpo2m-0003SG-4H
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:03:26 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53b8f8c6b1fso2683984a12.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 04:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696849402; x=1697454202; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w1sigiR4LmduP3UlaMwnqexR3h3qqvWr4C29unZHhf0=;
 b=feS1yhHpaN/5U+Bw8svx9lFsQu4zG4Pk9bQtg/uP6dh6UWQQbueHoO6WjIxoXKQ81m
 UotfSriSUVNh4pHFndcupqUB0qFSKe96CO6xYrC03V5P4kKiReO60S2jNbUYHaXDQw/H
 Uq1kT5HS0H6BG07jmpq0AVTLaQog1A7f1LeeCgdwQHfVf0PUmPKwZEt7FQvNqaY9hdb0
 /9mA+acRi0JETuSmZlyvhhAe+PKZq5IgLo0Hw5OBYO2B2Est2VQOCntJ0+9YK7jXimdC
 MrBxW+SKhurn2E2p4M328xMIM+Bm5TXoWKOOU+PS74+Js4VJS2BPzxmK27l4737L0ZJO
 6tRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696849402; x=1697454202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w1sigiR4LmduP3UlaMwnqexR3h3qqvWr4C29unZHhf0=;
 b=aWh9tqG/KlZQnEb0Y1U/IGYJb83cydniLvEscwnMxnC9jbs8d8jAcOdptpOVWngchN
 xlG/0aNzypv9aPEEzj/rYOjRmH3Xhj98GZkKM0Glo2WquTIIveWV6PmzgFFpAP4C5RjZ
 ZKk3RYhLkgCUky/pTT/7OfPNRGJz1IC8+FUPJoqEAxnPSpqwAmIpdOk78AJmYrjMwj3P
 mrn7OX+96IEccsKMJlx8vLzB7PLqalPUtGUsQ1D4TxGZKzI/0O/HzqKoLbcAJ4ECQ0Rl
 u+zhAdhEqiIgS6lez446kGvDPIxqOXdpiE4Ap2VeGQ0dIT5g/RScCwSXew3mEi4HbU15
 DuhQ==
X-Gm-Message-State: AOJu0YwVS50p8CRAmwOW5p6TlCXn84wwWydWCHs3I5mX3l863Sp7LMpx
 FlD5F0Q+v3uaQ+J3Ch+H35JKU/QQqqfnzW13LeM=
X-Google-Smtp-Source: AGHT+IGTB5TvG49uVveL5d3xAMI/z69k2NeO2JEO2Qp2YaFn1vMnclHMmnkxW7Dx7nIMpam3RZLDhQ==
X-Received: by 2002:a05:6402:1adb:b0:538:7787:2d62 with SMTP id
 ba27-20020a0564021adb00b0053877872d62mr14085875edb.1.1696849401649; 
 Mon, 09 Oct 2023 04:03:21 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 f22-20020a056402151600b0052febc781bfsm6010828edw.36.2023.10.09.04.03.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 04:03:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Weiwei Li <liweiwei@iscas.ac.cn>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Bin Meng <bin.meng@windriver.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Cameron Esfahani <dirty@apple.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org,
 Max Filippov <jcmvbkbc@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/6] target/i386: Use env_archcpu() in simulate_[rdmsr/wrmsr]()
Date: Mon,  9 Oct 2023 13:02:39 +0200
Message-ID: <20231009110239.66778-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009110239.66778-1-philmd@linaro.org>
References: <20231009110239.66778-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When CPUArchState* is available (here CPUX86State*), we can
use the fast env_archcpu() macro to get ArchCPU* (here X86CPU*).
The QOM cast X86_CPU() macro will be slower when building with
--enable-qom-cast-debug.

Pass CPUX86State* as argument to simulate_rdmsr / simulate_wrmsr
instead of a CPUState* to avoid an extra cast.

simulate_rdmsr/simulate_rdmsr(CPUX86State

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
RFC: Not even build-tested.
---
 target/i386/hvf/x86_emu.h |  4 ++--
 target/i386/hvf/hvf.c     |  4 ++--
 target/i386/hvf/x86_emu.c | 21 ++++++++++-----------
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index 640da90b30..4b846ba80e 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -29,8 +29,8 @@ bool exec_instruction(CPUX86State *env, struct x86_decode *ins);
 void load_regs(struct CPUState *cpu);
 void store_regs(struct CPUState *cpu);
 
-void simulate_rdmsr(struct CPUState *cpu);
-void simulate_wrmsr(struct CPUState *cpu);
+void simulate_rdmsr(CPUX86State *env);
+void simulate_wrmsr(CPUX86State *env);
 
 target_ulong read_reg(CPUX86State *env, int reg, int size);
 void write_reg(CPUX86State *env, int reg, target_ulong val, int size);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index cb2cd0b02f..20b9ca3ef5 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -591,9 +591,9 @@ int hvf_vcpu_exec(CPUState *cpu)
         {
             load_regs(cpu);
             if (exit_reason == EXIT_REASON_RDMSR) {
-                simulate_rdmsr(cpu);
+                simulate_rdmsr(env);
             } else {
-                simulate_wrmsr(cpu);
+                simulate_wrmsr(env);
             }
             env->eip += ins_len;
             store_regs(cpu);
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index af1f205ecf..b1f8a685d1 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -663,11 +663,10 @@ static void exec_lods(CPUX86State *env, struct x86_decode *decode)
     env->eip += decode->len;
 }
 
-void simulate_rdmsr(struct CPUState *cpu)
+void simulate_rdmsr(CPUX86State *env)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-    CPUState *cs = env_cpu(env);
+    X86CPU *x86_cpu = env_archcpu(env);
+    CPUState *cpu = env_cpu(env);
     uint32_t msr = ECX(env);
     uint64_t val = 0;
 
@@ -746,8 +745,8 @@ void simulate_rdmsr(struct CPUState *cpu)
         val = env->mtrr_deftype;
         break;
     case MSR_CORE_THREAD_COUNT:
-        val = cs->nr_threads * cs->nr_cores; /* thread count, bits 15..0 */
-        val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
+        val = cpu->nr_threads * cpu->nr_cores;  /* thread count, bits 15..0 */
+        val |= ((uint32_t)cpu->nr_cores << 16); /* core count, bits 31..16 */
         break;
     default:
         /* fprintf(stderr, "%s: unknown msr 0x%x\n", __func__, msr); */
@@ -761,14 +760,14 @@ void simulate_rdmsr(struct CPUState *cpu)
 
 static void exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    simulate_rdmsr(env_cpu(env));
+    simulate_rdmsr(env);
     env->eip += decode->len;
 }
 
-void simulate_wrmsr(struct CPUState *cpu)
+void simulate_wrmsr(CPUX86State *env)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
+    X86CPU *x86_cpu = env_archcpu(env);
+    CPUState *cpu = env_cpu(env);
     uint32_t msr = ECX(env);
     uint64_t data = ((uint64_t)EDX(env) << 32) | EAX(env);
 
@@ -856,7 +855,7 @@ void simulate_wrmsr(struct CPUState *cpu)
 
 static void exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    simulate_wrmsr(env_cpu(env));
+    simulate_wrmsr(env);
     env->eip += decode->len;
 }
 
-- 
2.41.0



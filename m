Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEB87E1F86
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 12:08:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzxRk-0002lr-FH; Mon, 06 Nov 2023 06:07:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxRA-0001lz-VR
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:06:33 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qzxR5-0004TS-Uv
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 06:06:31 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4083dbc43cfso27296215e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 03:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699268786; x=1699873586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3KIslD3tBGe6rvvH4379K4CtN4FVJCslZLzDLuVWSbo=;
 b=Rq+3HeA0OiicbS7A69fEArM/Ft4/X1mS2qio5jqF0HXRVwRHjZNpMqGZ0FXjOS266H
 zIIleitRruyfQVvQFis5VqBPXxU/GIFtFh67Bn0ADHTgKG03ddvaUeDsHVdX3s8zB1Rc
 chYpGYhJ1yWQ9+Rgq9MX7hqGuk+X1TGEu+li6kmffd8br3r2FZgUbwg+6GB0/4bxmH6T
 Y4pl3v9aZFoQMK8Ik/K/oDjYu44/H2OG5/UjPp7yhwjNwpRNapU8vVvIvEhDvAg1z6ax
 FvkxkuWbGEO3C+KsSOf45S+e3bGfDIYC4/Darj3nqNLayXjGubtUHMpzQwfSiXSZY37a
 E45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699268786; x=1699873586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3KIslD3tBGe6rvvH4379K4CtN4FVJCslZLzDLuVWSbo=;
 b=ixLCwVc5FE18JHSwX3fxOrpwwcsJHf7AFReZn/OjJ1b9GUQR5BcEwk/pgpegXpXEjv
 fzGeKv81jHmPBIpm9CJb8B3ZBk/SoYNGloy9kLbtV5MNuYiGJ17zUJopY+waBtgEIu8J
 sxQ8IxW17aRwbwxY24PCQwqDVUdBCkkWrlGnqkLs4yndE5HBwPVmt//3bKXtN3FAmNsV
 xalsm3/a0pkxkYB/0aL9Ph0TpUmCMiCJD1ozoRHpvbHAvtGSxQFYzawOvGf/gEJEehYJ
 TQ1bnBl6cZaiaN3hdbSCD4hH4X5b74pLZnIC8hkJ8NIAVWsIprZKMI1J3ElWmXGUdmhh
 m36g==
X-Gm-Message-State: AOJu0YxrJZDaDAcYaTW4veQ0bfsZXndWxwhALl3K3d3Q2ga90V5fSU3/
 GpLQSAwCGl17g41sjaY/8JE4i9zsvy2r8NwNwPI=
X-Google-Smtp-Source: AGHT+IFqstTlySqqtM85ehr6LLy2+6l54CyDhFwQFN2W5FnsbrQ2ysa+hdHfl+FfvhmGvxPogIc2ZA==
X-Received: by 2002:a05:600c:1c27:b0:405:1c14:9227 with SMTP id
 j39-20020a05600c1c2700b004051c149227mr21583067wms.33.1699268786451; 
 Mon, 06 Nov 2023 03:06:26 -0800 (PST)
Received: from m1x-phil.lan (176-131-220-199.abo.bbox.fr. [176.131.220.199])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c1c1300b004060f0a0fd5sm11856347wms.13.2023.11.06.03.06.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Nov 2023 03:06:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <roman@roolebo.dev>, Zhao Liu <zhao1.liu@intel.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PULL 24/60] target/i386/hvf: Use env_archcpu() in
 simulate_[rdmsr/wrmsr]()
Date: Mon,  6 Nov 2023 12:02:56 +0100
Message-ID: <20231106110336.358-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231106110336.358-1-philmd@linaro.org>
References: <20231106110336.358-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Message-Id: <20231009110239.66778-7-philmd@linaro.org>
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



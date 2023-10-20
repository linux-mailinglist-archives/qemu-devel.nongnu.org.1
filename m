Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF43C7D0E32
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 13:13:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtnQ5-0007CE-9T; Fri, 20 Oct 2023 07:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtnQ3-00078T-JD
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:11:55 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtnQ1-0002U5-LK
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 07:11:55 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4084095722aso5698795e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 04:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697800312; x=1698405112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWtxXECf6UdxjpnkuP192qOcDL26kcTzh/w6DKsz3YI=;
 b=ZS3VLYSXqfj7ukM28fC5BYaVsoqbtK8XAGbIRZP8sKTrQjrQ6c212LAqYT5taCo4qv
 RHbH8Rxvx8w49k+110FFJHqJ/vdACGPCSWpOImN3asL3s9Rv+Yap26LWZ967uMLWph84
 sDgFvQ27ZHiyA2dUGg3tqQ+9VYyaXgOlEjMjXodjpnXnMpaVBNVFgGUqY6oCQfmZCT49
 9IUNkKTAOybkwfj/Z2P3PqfvZCny9Y26Tzx85xFXwUbr4ZGA5cumGokxcC15ZUVszHOa
 W/TMAqv+TZ+MxuyC3nLrPocjEI4WsPJ8wfv2ev7gqV+DQwTym9iaQ4k8BKlrR5jqRf4L
 rVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697800312; x=1698405112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nWtxXECf6UdxjpnkuP192qOcDL26kcTzh/w6DKsz3YI=;
 b=Q+5Uz+56SzGU99RyRKa3FC6fqPWdSZ2Lufap6Mf6+E+PuCm+1qM2/iRZLek1lJQ6fV
 OhS8XdgvuLEQHFkCd4mHY7L8QxOSbEtMMOn3iYyHJsh7gBEGHPK88njF9ZBFssY6Np5w
 dewpwtPSFGJgQZE9/MhXEGFGw2uSJtpsmQjQS7XWbtwUiNsMEOlXMDGAyF2LT6DDUw8G
 yRQTm3zFbxhbr+yeVl9pkQy6XicBbAAD92BWqEf5sgAQZirOeeBxE7ocyy+uJUcTYi3G
 krYbWjEO/6ixjb574nyGFtSDznd0D3dhYPe0LWJD/S9SBvn8LJp5jlYfm41v8XWf+zuN
 ltxg==
X-Gm-Message-State: AOJu0Yyte06D1xG8ccp6dE3RxegZvSGXFI/g5Rk+pxJjmzhWDDTkg0y7
 5B6xmWPm0nPRqJRkn6H72n6/lDu3nCbI3BTitnM=
X-Google-Smtp-Source: AGHT+IErfkfMMhUUl6mT9dm7ptN3SOBlezvqjGr1W/CBMw+E4P6YtKAZBWgcrXV2h+mXjmhZHyleQA==
X-Received: by 2002:a05:600c:3d87:b0:405:40ec:415d with SMTP id
 bi7-20020a05600c3d8700b0040540ec415dmr1159296wmb.39.1697800311949; 
 Fri, 20 Oct 2023 04:11:51 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 o12-20020a05600c4fcc00b0040775501256sm1913923wmq.16.2023.10.20.04.11.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 04:11:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/3] target/i386/hvf: Rename 'CPUState *cpu' variable as 'cs'
Date: Fri, 20 Oct 2023 13:11:35 +0200
Message-ID: <20231020111136.44401-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020111136.44401-1-philmd@linaro.org>
References: <20231020111136.44401-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Follow the naming used by other files in target/i386/.

No functional changes.

Suggested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/hvf/x86_emu.c | 92 +++++++++++++++++++--------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index cd7ef30126..5b82e84778 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -45,7 +45,7 @@
 #include "vmcs.h"
 #include "vmx.h"
 
-void hvf_handle_io(CPUState *cpu, uint16_t port, void *data,
+void hvf_handle_io(CPUState *cs, uint16_t port, void *data,
                    int direction, int size, uint32_t count);
 
 #define EXEC_2OP_FLAGS_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
@@ -666,13 +666,13 @@ static void exec_lods(CPUX86State *env, struct x86_decode *decode)
 void simulate_rdmsr(CPUX86State *env)
 {
     X86CPU *x86_cpu = env_archcpu(env);
-    CPUState *cpu = env_cpu(env);
+    CPUState *cs = env_cpu(env);
     uint32_t msr = ECX(env);
     uint64_t val = 0;
 
     switch (msr) {
     case MSR_IA32_TSC:
-        val = rdtscp() + rvmcs(cpu->accel->fd, VMCS_TSC_OFFSET);
+        val = rdtscp() + rvmcs(cs->accel->fd, VMCS_TSC_OFFSET);
         break;
     case MSR_IA32_APICBASE:
         val = cpu_get_apic_base(x86_cpu->apic_state);
@@ -681,16 +681,16 @@ void simulate_rdmsr(CPUX86State *env)
         val = x86_cpu->ucode_rev;
         break;
     case MSR_EFER:
-        val = rvmcs(cpu->accel->fd, VMCS_GUEST_IA32_EFER);
+        val = rvmcs(cs->accel->fd, VMCS_GUEST_IA32_EFER);
         break;
     case MSR_FSBASE:
-        val = rvmcs(cpu->accel->fd, VMCS_GUEST_FS_BASE);
+        val = rvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE);
         break;
     case MSR_GSBASE:
-        val = rvmcs(cpu->accel->fd, VMCS_GUEST_GS_BASE);
+        val = rvmcs(cs->accel->fd, VMCS_GUEST_GS_BASE);
         break;
     case MSR_KERNELGSBASE:
-        val = rvmcs(cpu->accel->fd, VMCS_HOST_FS_BASE);
+        val = rvmcs(cs->accel->fd, VMCS_HOST_FS_BASE);
         break;
     case MSR_STAR:
         abort();
@@ -745,8 +745,8 @@ void simulate_rdmsr(CPUX86State *env)
         val = env->mtrr_deftype;
         break;
     case MSR_CORE_THREAD_COUNT:
-        val = cpu->nr_threads * cpu->nr_cores;  /* thread count, bits 15..0 */
-        val |= ((uint32_t)cpu->nr_cores << 16); /* core count, bits 31..16 */
+        val = cs->nr_threads * cs->nr_cores;  /* thread count, bits 15..0 */
+        val |= ((uint32_t)cs->nr_cores << 16); /* core count, bits 31..16 */
         break;
     default:
         /* fprintf(stderr, "%s: unknown msr 0x%x\n", __func__, msr); */
@@ -767,7 +767,7 @@ static void exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
 void simulate_wrmsr(CPUX86State *env)
 {
     X86CPU *x86_cpu = env_archcpu(env);
-    CPUState *cpu = env_cpu(env);
+    CPUState *cs = env_cpu(env);
     uint32_t msr = ECX(env);
     uint64_t data = ((uint64_t)EDX(env) << 32) | EAX(env);
 
@@ -778,13 +778,13 @@ void simulate_wrmsr(CPUX86State *env)
         cpu_set_apic_base(x86_cpu->apic_state, data);
         break;
     case MSR_FSBASE:
-        wvmcs(cpu->accel->fd, VMCS_GUEST_FS_BASE, data);
+        wvmcs(cs->accel->fd, VMCS_GUEST_FS_BASE, data);
         break;
     case MSR_GSBASE:
-        wvmcs(cpu->accel->fd, VMCS_GUEST_GS_BASE, data);
+        wvmcs(cs->accel->fd, VMCS_GUEST_GS_BASE, data);
         break;
     case MSR_KERNELGSBASE:
-        wvmcs(cpu->accel->fd, VMCS_HOST_FS_BASE, data);
+        wvmcs(cs->accel->fd, VMCS_HOST_FS_BASE, data);
         break;
     case MSR_STAR:
         abort();
@@ -796,10 +796,10 @@ void simulate_wrmsr(CPUX86State *env)
         abort();
         break;
     case MSR_EFER:
-        /*printf("new efer %llx\n", EFER(cpu));*/
-        wvmcs(cpu->accel->fd, VMCS_GUEST_IA32_EFER, data);
+        /*printf("new efer %llx\n", EFER(cs));*/
+        wvmcs(cs->accel->fd, VMCS_GUEST_IA32_EFER, data);
         if (data & MSR_EFER_NXE) {
-            hv_vcpu_invalidate_tlb(cpu->accel->fd);
+            hv_vcpu_invalidate_tlb(cs->accel->fd);
         }
         break;
     case MSR_MTRRphysBase(0):
@@ -848,9 +848,9 @@ void simulate_wrmsr(CPUX86State *env)
 
     /* Related to support known hypervisor interface */
     /* if (g_hypervisor_iface)
-         g_hypervisor_iface->wrmsr_handler(cpu, msr, data);
+         g_hypervisor_iface->wrmsr_handler(cs, msr, data);
 
-    printf("write msr %llx\n", RCX(cpu));*/
+    printf("write msr %llx\n", RCX(cs));*/
 }
 
 static void exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
@@ -1417,56 +1417,56 @@ static void init_cmd_handler()
     }
 }
 
-void load_regs(CPUState *cpu)
+void load_regs(CPUState *cs)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
+    X86CPU *x86_cpu = X86_CPU(cs);
     CPUX86State *env = &x86_cpu->env;
 
     int i = 0;
-    RRX(env, R_EAX) = rreg(cpu->accel->fd, HV_X86_RAX);
-    RRX(env, R_EBX) = rreg(cpu->accel->fd, HV_X86_RBX);
-    RRX(env, R_ECX) = rreg(cpu->accel->fd, HV_X86_RCX);
-    RRX(env, R_EDX) = rreg(cpu->accel->fd, HV_X86_RDX);
-    RRX(env, R_ESI) = rreg(cpu->accel->fd, HV_X86_RSI);
-    RRX(env, R_EDI) = rreg(cpu->accel->fd, HV_X86_RDI);
-    RRX(env, R_ESP) = rreg(cpu->accel->fd, HV_X86_RSP);
-    RRX(env, R_EBP) = rreg(cpu->accel->fd, HV_X86_RBP);
+    RRX(env, R_EAX) = rreg(cs->accel->fd, HV_X86_RAX);
+    RRX(env, R_EBX) = rreg(cs->accel->fd, HV_X86_RBX);
+    RRX(env, R_ECX) = rreg(cs->accel->fd, HV_X86_RCX);
+    RRX(env, R_EDX) = rreg(cs->accel->fd, HV_X86_RDX);
+    RRX(env, R_ESI) = rreg(cs->accel->fd, HV_X86_RSI);
+    RRX(env, R_EDI) = rreg(cs->accel->fd, HV_X86_RDI);
+    RRX(env, R_ESP) = rreg(cs->accel->fd, HV_X86_RSP);
+    RRX(env, R_EBP) = rreg(cs->accel->fd, HV_X86_RBP);
     for (i = 8; i < 16; i++) {
-        RRX(env, i) = rreg(cpu->accel->fd, HV_X86_RAX + i);
+        RRX(env, i) = rreg(cs->accel->fd, HV_X86_RAX + i);
     }
 
-    env->eflags = rreg(cpu->accel->fd, HV_X86_RFLAGS);
+    env->eflags = rreg(cs->accel->fd, HV_X86_RFLAGS);
     rflags_to_lflags(env);
-    env->eip = rreg(cpu->accel->fd, HV_X86_RIP);
+    env->eip = rreg(cs->accel->fd, HV_X86_RIP);
 }
 
-void store_regs(CPUState *cpu)
+void store_regs(CPUState *cs)
 {
-    X86CPU *x86_cpu = X86_CPU(cpu);
+    X86CPU *x86_cpu = X86_CPU(cs);
     CPUX86State *env = &x86_cpu->env;
 
     int i = 0;
-    wreg(cpu->accel->fd, HV_X86_RAX, RAX(env));
-    wreg(cpu->accel->fd, HV_X86_RBX, RBX(env));
-    wreg(cpu->accel->fd, HV_X86_RCX, RCX(env));
-    wreg(cpu->accel->fd, HV_X86_RDX, RDX(env));
-    wreg(cpu->accel->fd, HV_X86_RSI, RSI(env));
-    wreg(cpu->accel->fd, HV_X86_RDI, RDI(env));
-    wreg(cpu->accel->fd, HV_X86_RBP, RBP(env));
-    wreg(cpu->accel->fd, HV_X86_RSP, RSP(env));
+    wreg(cs->accel->fd, HV_X86_RAX, RAX(env));
+    wreg(cs->accel->fd, HV_X86_RBX, RBX(env));
+    wreg(cs->accel->fd, HV_X86_RCX, RCX(env));
+    wreg(cs->accel->fd, HV_X86_RDX, RDX(env));
+    wreg(cs->accel->fd, HV_X86_RSI, RSI(env));
+    wreg(cs->accel->fd, HV_X86_RDI, RDI(env));
+    wreg(cs->accel->fd, HV_X86_RBP, RBP(env));
+    wreg(cs->accel->fd, HV_X86_RSP, RSP(env));
     for (i = 8; i < 16; i++) {
-        wreg(cpu->accel->fd, HV_X86_RAX + i, RRX(env, i));
+        wreg(cs->accel->fd, HV_X86_RAX + i, RRX(env, i));
     }
 
     lflags_to_rflags(env);
-    wreg(cpu->accel->fd, HV_X86_RFLAGS, env->eflags);
-    macvm_set_rip(cpu, env->eip);
+    wreg(cs->accel->fd, HV_X86_RFLAGS, env->eflags);
+    macvm_set_rip(cs, env->eip);
 }
 
 bool exec_instruction(CPUX86State *env, struct x86_decode *ins)
 {
-    /*if (hvf_vcpu_id(cpu))
-    printf("%d, %llx: exec_instruction %s\n", hvf_vcpu_id(cpu),  env->eip,
+    /*if (hvf_vcpu_id(cs))
+    printf("%d, %llx: exec_instruction %s\n", hvf_vcpu_id(cs),  env->eip,
           decode_cmd_to_string(ins->cmd));*/
 
     if (!_cmd_handler[ins->cmd].handler) {
-- 
2.41.0



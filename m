Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 211FBA3F6C5
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Feb 2025 15:05:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTbO-00004x-5l; Fri, 21 Feb 2025 09:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlOWs-0006Ui-9D
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:02 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlOWq-00016G-FM
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:37:02 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id D7968204E5BF; Fri, 21 Feb 2025 00:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7968204E5BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740126989;
 bh=BIBYYp20CH//yWy4bJewZDwiEhMoLrpDlcLszET5VZ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oYJpl08eiSe2aCOo+VWJ0XdX6Ej43jGy4ZfVNwJmAMT8hrNnpi7a4b3OQrmuf+PLv
 IP0BAjb8eYZGtF36eOUNa1A5hIpJvXwhvW+JFrgtAwW8WZjk9gzj1oXLt/J1qwi1Pq
 EGRSaSK+84uNgDtEcHvpoX+JO254NfVR3Ly/KlPM=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [RFC PATCH v1 12/19] target/i386/hvf: provide and use simulate_{wrmsr,
 rdmsr} in emul_ops
Date: Fri, 21 Feb 2025 00:36:20 -0800
Message-Id: <1740126987-8483-13-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Feb 2025 09:01:13 -0500
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

Change the first argument's type to be CPUState to match other hooks.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/hvf/hvf-i386.h |  4 ++--
 target/i386/hvf/hvf.c      | 18 ++++++++++--------
 target/i386/hvf/x86_emu.c  |  4 ++--
 target/i386/hvf/x86_emu.h  |  2 ++
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index 044ad236ae..8c42ae6b01 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -19,8 +19,8 @@
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
 
 void hvf_handle_io(CPUState *, uint16_t, void *, int, int, int);
-void hvf_simulate_rdmsr(CPUX86State *env);
-void hvf_simulate_wrmsr(CPUX86State *env);
+void hvf_simulate_rdmsr(CPUState *cpu);
+void hvf_simulate_wrmsr(CPUState *cpu);
 
 /* Host specific functions */
 int hvf_inject_interrupt(CPUArchState *env, int vector);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 88f5487b45..57a8029cfa 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -252,6 +252,8 @@ static const struct x86_emul_ops hvf_x86_emul_ops = {
     .write_mem = hvf_write_mem,
     .read_segment_descriptor = hvf_read_segment_descriptor,
     .handle_io = hvf_handle_io,
+    .simulate_rdmsr = hvf_simulate_rdmsr,
+    .simulate_wrmsr = hvf_simulate_wrmsr,
 };
 
 int hvf_arch_init_vcpu(CPUState *cpu)
@@ -506,10 +508,10 @@ void hvf_store_regs(CPUState *cs)
     macvm_set_rip(cs, env->eip);
 }
 
-void hvf_simulate_rdmsr(CPUX86State *env)
+void hvf_simulate_rdmsr(CPUState *cs)
 {
-    X86CPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
     uint32_t msr = ECX(env);
     uint64_t val = 0;
 
@@ -611,10 +613,10 @@ void hvf_simulate_rdmsr(CPUX86State *env)
     RDX(env) = (uint32_t)(val >> 32);
 }
 
-void hvf_simulate_wrmsr(CPUX86State *env)
+void hvf_simulate_wrmsr(CPUState *cs)
 {
-    X86CPU *cpu = env_archcpu(env);
-    CPUState *cs = env_cpu(env);
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
     uint32_t msr = ECX(env);
     uint64_t data = ((uint64_t)EDX(env) << 32) | EAX(env);
 
@@ -900,9 +902,9 @@ int hvf_vcpu_exec(CPUState *cpu)
         {
             hvf_load_regs(cpu);
             if (exit_reason == EXIT_REASON_RDMSR) {
-                hvf_simulate_rdmsr(env);
+                hvf_simulate_rdmsr(cpu);
             } else {
-                hvf_simulate_wrmsr(env);
+                hvf_simulate_wrmsr(cpu);
             }
             env->eip += ins_len;
             hvf_store_regs(cpu);
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index b6e63daea4..304c1ef396 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -672,13 +672,13 @@ void x86_emul_raise_exception(CPUX86State *env, int exception_index, int error_c
 
 static void exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    hvf_simulate_rdmsr(env);
+    emul_ops->simulate_rdmsr(env_cpu(env));
     env->eip += decode->len;
 }
 
 static void exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
 {
-    hvf_simulate_wrmsr(env);
+    emul_ops->simulate_wrmsr(env_cpu(env));
     env->eip += decode->len;
 }
 
diff --git a/target/i386/hvf/x86_emu.h b/target/i386/hvf/x86_emu.h
index 107c1f1ac8..555b567e2c 100644
--- a/target/i386/hvf/x86_emu.h
+++ b/target/i386/hvf/x86_emu.h
@@ -30,6 +30,8 @@ struct x86_emul_ops {
                                     enum X86Seg seg);
     void (*handle_io)(CPUState *cpu, uint16_t port, void *data, int direction,
                       int size, int count);
+    void (*simulate_rdmsr)(CPUState *cs);
+    void (*simulate_wrmsr)(CPUState *cs);
 };
 
 extern const struct x86_emul_ops *emul_ops;
-- 
2.39.5 (Apple Git-154)



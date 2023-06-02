Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A0571FB28
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 09:41:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4zNt-0003gJ-8O; Fri, 02 Jun 2023 03:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1q4zNn-0003fV-Uw
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 03:39:36 -0400
Received: from mx20.baidu.com ([111.202.115.85] helo=baidu.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaoshiyuan@baidu.com>)
 id 1q4zNj-0005Bz-Nh
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 03:39:34 -0400
From: Shiyuan Gao <gaoshiyuan@baidu.com>
To: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <kvm@vger.kernel.org>,
 <qemu-devel@nongnu.org>
CC: <likexu@tencent.com>, Shiyuan Gao <gaoshiyuan@baidu.com>
Subject: [PATCH] kvm: limit the maximum CPUID.0xA.edx[0..4] to 3
Date: Fri, 2 Jun 2023 15:38:57 +0800
Message-ID: <20230602073857.96790-1-gaoshiyuan@baidu.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex14.internal.baidu.com (10.127.64.37) To
 bjkjy-mail-ex26.internal.baidu.com (172.31.50.42)
X-FEAS-Client-IP: 172.31.51.58
X-FE-Policy-ID: 15:10:21:SYSTEM
Received-SPF: pass client-ip=111.202.115.85; envelope-from=gaoshiyuan@baidu.com;
 helo=baidu.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Now, the CPUID.0xA depends on the KVM report. The value of CPUID.0xA.edx[0..4]
and num_architectural_pmu_fixed_counters are inconsistent when the host kernel
before this commit 2e8cd7a3b828 ("kvm: x86: limit the maximum number of vPMU
fixed counters to 3") on icelake microarchitecture.

This also break the live-migration between source host kernel before commit
2e8cd7a3b828 and dest host kernel after the commit on icelake microarchitecture.

Signed-off-by: Shiyuan Gao <gaoshiyuan@baidu.com>
---
 target/i386/kvm/kvm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index de531842f6..e77129b737 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1761,7 +1761,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
-    uint32_t limit, i, j, cpuid_i;
+    uint32_t limit, i, j, cpuid_i, cpuid_0xa;
     uint32_t unused;
     struct kvm_cpuid_entry2 *c;
     uint32_t signature[3];
@@ -1773,6 +1773,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     memset(&cpuid_data, 0, sizeof(cpuid_data));
 
     cpuid_i = 0;
+    cpuid_0xa = 0;
 
     has_xsave2 = kvm_check_extension(cs->kvm_state, KVM_CAP_XSAVE2);
 
@@ -2045,6 +2046,9 @@ int kvm_arch_init_vcpu(CPUState *cs)
             c->function = i;
             c->flags = 0;
             cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            if (0x0a == i) {
+                cpuid_0xa = cpuid_i - 1;
+            }
             if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
                 /*
                  * KVM already returns all zeroes if a CPUID entry is missing,
@@ -2059,7 +2063,11 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (limit >= 0x0a) {
         uint32_t eax, edx;
 
-        cpu_x86_cpuid(env, 0x0a, 0, &eax, &unused, &unused, &edx);
+        assert(cpuid_0xa >= 0x0a);
+
+        c = &cpuid_data.entries[cpuid_0xa];
+        eax = c->eax;
+        edx = c->edx;
 
         has_architectural_pmu_version = eax & 0xff;
         if (has_architectural_pmu_version > 0) {
@@ -2078,6 +2086,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
                 if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
                     num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
+                    c->edx = (edx & ~0x1f) | num_architectural_pmu_fixed_counters;
                 }
             }
         }
-- 
2.36.1



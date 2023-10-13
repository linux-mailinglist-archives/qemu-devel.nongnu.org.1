Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD7A7C8010
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:24:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4i-00025i-Np; Fri, 13 Oct 2023 03:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4W-0000yj-MS
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:01 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4H-0006ub-Ai
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4060b623e64so11594245e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183923; x=1697788723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XSyTjFkWd55QcMZyWzJDp8jpUtI1cdqpMQ1ckmtSWKs=;
 b=uBuUDSAB38OHNfoCaEnu7mwLH8tkHmttdyu8yopXKgHqoCvFM+qmKRdUSLmIBIeELM
 ZKAIQmyJ0OKi4/6ZQ+w+4KGqFgwUw1iaSu8oqFkVufCWafyMcxcbpUxG2XSqASXydUBM
 C7l40s7esdivQLX7lX/if9cT83kfRwx7eYmTkjjEg66ujnXB+x506zxk9vUQjDGrlIEr
 oNHtQZIKq9zEaNCzun9nxYnk7T8a+G3QyYpZJw3ZF2+VDrUjRV4vRKMeW51/hNePFNo/
 3TEP7gXq2XzWTU6QRce7vH8JS/oRdM8iRTD7EXcbeOL2QG9z9DrBz+1g3JSLekPPnVvm
 FDaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183923; x=1697788723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XSyTjFkWd55QcMZyWzJDp8jpUtI1cdqpMQ1ckmtSWKs=;
 b=KzUcaTz00UoVFcGugT2QktwluSW5U0gYUuZD+t4hi8C9o/ELXxaUYpSHToZK0kgCZ1
 Hoa/Cj5rLpB0NjDmPLuVNGo35S1lFQSMIsaXb5Wxof2IYTe8bdT5IsiiW/2WoZc/rbDX
 GRJQjbnMabuQyIjZynMnTUiICEd5Azk1iBwYqHcX4QF0Wy6U7Z34ENQPa866Q4zA/mNk
 6V+Wvd1Znvwv5k+9ZUWnJm8JjnIC9AGPA7iLKFHafS2JgF05vmVZccWDivn0KWKNvuCw
 yYhBeo8+4rfk95G/lVE/bAOgpo1RK7y3AgeGNbVG2Dq0oQqkv3Wp00ANKHDUULbrkIvr
 76mA==
X-Gm-Message-State: AOJu0YwYGE/gkBVg0AYttqW4a3e7i6ewW0IQPSCxxc83SflxzgkOqDE7
 WC2FtmIMN9F7IxNLA2jdi2KaYGIXDqwecQ7JcbQ=
X-Google-Smtp-Source: AGHT+IHNhoEgKP2zDJ092ovoWz6foO0TeB+epuMXS9EQfWRikpJn2tQK5LcV+JegC276rNPUboYv+A==
X-Received: by 2002:a05:600c:5189:b0:406:5a14:5c1e with SMTP id
 fa9-20020a05600c518900b004065a145c1emr19512890wmb.1.1697183922601; 
 Fri, 13 Oct 2023 00:58:42 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:41 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 kvm@vger.kernel.org (open list:X86 KVM CPUs)
Subject: [RFC PATCH v2 25/78] target/i386: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:52 +0300
Message-Id: <c80ff242a5659616ba4aca5b931ff0cc597fce79.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/i386/cpu.c                | 2 +-
 target/i386/hvf/x86_decode.c     | 1 +
 target/i386/kvm/kvm.c            | 4 ++--
 target/i386/tcg/decode-new.c.inc | 6 +++---
 target/i386/tcg/emit.c.inc       | 2 +-
 target/i386/tcg/translate.c      | 8 +++-----
 6 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cec5d2b7b6..f73784edca 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6009,670 +6009,670 @@ uint32_t cpu_x86_virtual_addr_width(CPUX86State *env)
 void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
                    uint32_t *eax, uint32_t *ebx,
                    uint32_t *ecx, uint32_t *edx)
 {
     X86CPU *cpu = env_archcpu(env);
     CPUState *cs = env_cpu(env);
     uint32_t die_offset;
     uint32_t limit;
     uint32_t signature[3];
     X86CPUTopoInfo topo_info;
 
     topo_info.dies_per_pkg = env->nr_dies;
     topo_info.cores_per_die = cs->nr_cores;
     topo_info.threads_per_core = cs->nr_threads;
 
     /* Calculate & apply limits for different index ranges */
     if (index >= 0xC0000000) {
         limit = env->cpuid_xlevel2;
     } else if (index >= 0x80000000) {
         limit = env->cpuid_xlevel;
     } else if (index >= 0x40000000) {
         limit = 0x40000001;
     } else {
         limit = env->cpuid_level;
     }
 
     if (index > limit) {
         /* Intel documentation states that invalid EAX input will
          * return the same information as EAX=cpuid_level
          * (Intel SDM Vol. 2A - Instruction Set Reference - CPUID)
          */
         index = env->cpuid_level;
     }
 
     switch(index) {
     case 0:
         *eax = env->cpuid_level;
         *ebx = env->cpuid_vendor1;
         *edx = env->cpuid_vendor2;
         *ecx = env->cpuid_vendor3;
         break;
     case 1:
         *eax = env->cpuid_version;
         *ebx = (cpu->apic_id << 24) |
                8 << 8; /* CLFLUSH size in quad words, Linux wants it. */
         *ecx = env->features[FEAT_1_ECX];
         if ((*ecx & CPUID_EXT_XSAVE) && (env->cr[4] & CR4_OSXSAVE_MASK)) {
             *ecx |= CPUID_EXT_OSXSAVE;
         }
         *edx = env->features[FEAT_1_EDX];
         if (cs->nr_cores * cs->nr_threads > 1) {
             *ebx |= (cs->nr_cores * cs->nr_threads) << 16;
             *edx |= CPUID_HT;
         }
         if (!cpu->enable_pmu) {
             *ecx &= ~CPUID_EXT_PDCM;
         }
         break;
     case 2:
         /* cache info: needed for Pentium Pro compatibility */
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
         } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
         *eax = 1; /* Number of CPUID[EAX=2] calls required */
         *ebx = 0;
         if (!cpu->enable_l3_cache) {
             *ecx = 0;
         } else {
             *ecx = cpuid2_cache_descriptor(env->cache_info_cpuid2.l3_cache);
         }
         *edx = (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1d_cache) << 16) |
                (cpuid2_cache_descriptor(env->cache_info_cpuid2.l1i_cache) <<  8) |
                (cpuid2_cache_descriptor(env->cache_info_cpuid2.l2_cache));
         break;
     case 4:
         /* cache info: needed for Core compatibility */
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, count, eax, ebx, ecx, edx);
             /*
              * QEMU has its own number of cores/logical cpus,
              * set 24..14, 31..26 bit to configured values
              */
             if (*eax & 31) {
                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
                 int vcpus_per_socket = env->nr_dies * cs->nr_cores *
                                        cs->nr_threads;
                 if (cs->nr_cores > 1) {
                     *eax &= ~0xFC000000;
                     *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
                 }
                 if (host_vcpus_per_cache > vcpus_per_socket) {
                     *eax &= ~0x3FFC000;
                     *eax |= (pow2ceil(vcpus_per_socket) - 1) << 14;
                 }
             }
         } else if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
             *eax = *ebx = *ecx = *edx = 0;
         } else {
             *eax = 0;
             switch (count) {
             case 0: /* L1 dcache info */
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1d_cache,
                                     1, cs->nr_cores,
                                     eax, ebx, ecx, edx);
                 break;
             case 1: /* L1 icache info */
                 encode_cache_cpuid4(env->cache_info_cpuid4.l1i_cache,
                                     1, cs->nr_cores,
                                     eax, ebx, ecx, edx);
                 break;
             case 2: /* L2 cache info */
                 encode_cache_cpuid4(env->cache_info_cpuid4.l2_cache,
                                     cs->nr_threads, cs->nr_cores,
                                     eax, ebx, ecx, edx);
                 break;
             case 3: /* L3 cache info */
                 die_offset = apicid_die_offset(&topo_info);
                 if (cpu->enable_l3_cache) {
                     encode_cache_cpuid4(env->cache_info_cpuid4.l3_cache,
                                         (1 << die_offset), cs->nr_cores,
                                         eax, ebx, ecx, edx);
                     break;
                 }
-                /* fall through */
+                fallthrough;
             default: /* end of info */
                 *eax = *ebx = *ecx = *edx = 0;
                 break;
             }
         }
         break;
     case 5:
         /* MONITOR/MWAIT Leaf */
         *eax = cpu->mwait.eax; /* Smallest monitor-line size in bytes */
         *ebx = cpu->mwait.ebx; /* Largest monitor-line size in bytes */
         *ecx = cpu->mwait.ecx; /* flags */
         *edx = cpu->mwait.edx; /* mwait substates */
         break;
     case 6:
         /* Thermal and Power Leaf */
         *eax = env->features[FEAT_6_EAX];
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
         break;
     case 7:
         /* Structured Extended Feature Flags Enumeration Leaf */
         if (count == 0) {
             uint32_t eax_0_unused, ebx_0, ecx_0, edx_0_unused;
 
             /* Maximum ECX value for sub-leaves */
             *eax = env->cpuid_level_func7;
             *ebx = env->features[FEAT_7_0_EBX]; /* Feature flags */
             *ecx = env->features[FEAT_7_0_ECX]; /* Feature flags */
             if ((*ecx & CPUID_7_0_ECX_PKU) && env->cr[4] & CR4_PKE_MASK) {
                 *ecx |= CPUID_7_0_ECX_OSPKE;
             }
             *edx = env->features[FEAT_7_0_EDX]; /* Feature flags */
 
             /*
              * SGX cannot be emulated in software.  If hardware does not
              * support enabling SGX and/or SGX flexible launch control,
              * then we need to update the VM's CPUID values accordingly.
              */
             x86_cpu_get_supported_cpuid(0x7, 0,
                                         &eax_0_unused, &ebx_0,
                                         &ecx_0, &edx_0_unused);
             if ((*ebx & CPUID_7_0_EBX_SGX) && !(ebx_0 & CPUID_7_0_EBX_SGX)) {
                 *ebx &= ~CPUID_7_0_EBX_SGX;
             }
 
             if ((*ecx & CPUID_7_0_ECX_SGX_LC)
                     && (!(*ebx & CPUID_7_0_EBX_SGX) || !(ecx_0 & CPUID_7_0_ECX_SGX_LC))) {
                 *ecx &= ~CPUID_7_0_ECX_SGX_LC;
             }
         } else if (count == 1) {
             *eax = env->features[FEAT_7_1_EAX];
             *edx = env->features[FEAT_7_1_EDX];
             *ebx = 0;
             *ecx = 0;
         } else if (count == 2) {
             *edx = env->features[FEAT_7_2_EDX];
             *eax = 0;
             *ebx = 0;
             *ecx = 0;
         } else {
             *eax = 0;
             *ebx = 0;
             *ecx = 0;
             *edx = 0;
         }
         break;
     case 9:
         /* Direct Cache Access Information Leaf */
         *eax = 0; /* Bits 0-31 in DCA_CAP MSR */
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
         break;
     case 0xA:
         /* Architectural Performance Monitoring Leaf */
         if (cpu->enable_pmu) {
             x86_cpu_get_supported_cpuid(0xA, count, eax, ebx, ecx, edx);
         } else {
             *eax = 0;
             *ebx = 0;
             *ecx = 0;
             *edx = 0;
         }
         break;
     case 0xB:
         /* Extended Topology Enumeration Leaf */
         if (!cpu->enable_cpuid_0xb) {
                 *eax = *ebx = *ecx = *edx = 0;
                 break;
         }
 
         *ecx = count & 0xff;
         *edx = cpu->apic_id;
 
         switch (count) {
         case 0:
             *eax = apicid_core_offset(&topo_info);
             *ebx = cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
             *eax = apicid_pkg_offset(&topo_info);
             *ebx = cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         default:
             *eax = 0;
             *ebx = 0;
             *ecx |= CPUID_TOPOLOGY_LEVEL_INVALID;
         }
 
         assert(!(*eax & ~0x1f));
         *ebx &= 0xffff; /* The count doesn't need to be reliable. */
         break;
     case 0x1C:
         if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
             x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);
             *edx = 0;
         }
         break;
     case 0x1F:
         /* V2 Extended Topology Enumeration Leaf */
         if (env->nr_dies < 2) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
 
         *ecx = count & 0xff;
         *edx = cpu->apic_id;
         switch (count) {
         case 0:
             *eax = apicid_core_offset(&topo_info);
             *ebx = cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_SMT;
             break;
         case 1:
             *eax = apicid_die_offset(&topo_info);
             *ebx = cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_CORE;
             break;
         case 2:
             *eax = apicid_pkg_offset(&topo_info);
             *ebx = env->nr_dies * cs->nr_cores * cs->nr_threads;
             *ecx |= CPUID_TOPOLOGY_LEVEL_DIE;
             break;
         default:
             *eax = 0;
             *ebx = 0;
             *ecx |= CPUID_TOPOLOGY_LEVEL_INVALID;
         }
         assert(!(*eax & ~0x1f));
         *ebx &= 0xffff; /* The count doesn't need to be reliable. */
         break;
     case 0xD: {
         /* Processor Extended State */
         *eax = 0;
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
         if (!(env->features[FEAT_1_ECX] & CPUID_EXT_XSAVE)) {
             break;
         }
 
         if (count == 0) {
             *ecx = xsave_area_size(x86_cpu_xsave_xcr0_components(cpu), false);
             *eax = env->features[FEAT_XSAVE_XCR0_LO];
             *edx = env->features[FEAT_XSAVE_XCR0_HI];
             /*
              * The initial value of xcr0 and ebx == 0, On host without kvm
              * commit 412a3c41(e.g., CentOS 6), the ebx's value always == 0
              * even through guest update xcr0, this will crash some legacy guest
              * (e.g., CentOS 6), So set ebx == ecx to workaround it.
              */
             *ebx = kvm_enabled() ? *ecx : xsave_area_size(env->xcr0, false);
         } else if (count == 1) {
             uint64_t xstate = x86_cpu_xsave_xcr0_components(cpu) |
                               x86_cpu_xsave_xss_components(cpu);
 
             *eax = env->features[FEAT_XSAVE];
             *ebx = xsave_area_size(xstate, true);
             *ecx = env->features[FEAT_XSAVE_XSS_LO];
             *edx = env->features[FEAT_XSAVE_XSS_HI];
             if (kvm_enabled() && cpu->enable_pmu &&
                 (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR) &&
                 (*eax & CPUID_XSAVE_XSAVES)) {
                 *ecx |= XSTATE_ARCH_LBR_MASK;
             } else {
                 *ecx &= ~XSTATE_ARCH_LBR_MASK;
             }
         } else if (count == 0xf && cpu->enable_pmu
                    && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
             x86_cpu_get_supported_cpuid(0xD, count, eax, ebx, ecx, edx);
         } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
             const ExtSaveArea *esa = &x86_ext_save_areas[count];
 
             if (x86_cpu_xsave_xcr0_components(cpu) & (1ULL << count)) {
                 *eax = esa->size;
                 *ebx = esa->offset;
                 *ecx = esa->ecx &
                        (ESA_FEATURE_ALIGN64_MASK | ESA_FEATURE_XFD_MASK);
             } else if (x86_cpu_xsave_xss_components(cpu) & (1ULL << count)) {
                 *eax = esa->size;
                 *ebx = 0;
                 *ecx = 1;
             }
         }
         break;
     }
     case 0x12:
 #ifndef CONFIG_USER_ONLY
         if (!kvm_enabled() ||
             !(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_SGX)) {
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
 
         /*
          * SGX sub-leafs CPUID.0x12.{0x2..N} enumerate EPC sections.  Retrieve
          * the EPC properties, e.g. confidentiality and integrity, from the
          * host's first EPC section, i.e. assume there is one EPC section or
          * that all EPC sections have the same security properties.
          */
         if (count > 1) {
             uint64_t epc_addr, epc_size;
 
             if (sgx_epc_get_section(count - 2, &epc_addr, &epc_size)) {
                 *eax = *ebx = *ecx = *edx = 0;
                 break;
             }
             host_cpuid(index, 2, eax, ebx, ecx, edx);
             *eax = (uint32_t)(epc_addr & 0xfffff000) | 0x1;
             *ebx = (uint32_t)(epc_addr >> 32);
             *ecx = (uint32_t)(epc_size & 0xfffff000) | (*ecx & 0xf);
             *edx = (uint32_t)(epc_size >> 32);
             break;
         }
 
         /*
          * SGX sub-leafs CPUID.0x12.{0x0,0x1} are heavily dependent on hardware
          * and KVM, i.e. QEMU cannot emulate features to override what KVM
          * supports.  Features can be further restricted by userspace, but not
          * made more permissive.
          */
         x86_cpu_get_supported_cpuid(0x12, count, eax, ebx, ecx, edx);
 
         if (count == 0) {
             *eax &= env->features[FEAT_SGX_12_0_EAX];
             *ebx &= env->features[FEAT_SGX_12_0_EBX];
         } else {
             *eax &= env->features[FEAT_SGX_12_1_EAX];
             *ebx &= 0; /* ebx reserve */
             *ecx &= env->features[FEAT_XSAVE_XCR0_LO];
             *edx &= env->features[FEAT_XSAVE_XCR0_HI];
 
             /* FP and SSE are always allowed regardless of XSAVE/XCR0. */
             *ecx |= XSTATE_FP_MASK | XSTATE_SSE_MASK;
 
             /* Access to PROVISIONKEY requires additional credentials. */
             if ((*eax & (1U << 4)) &&
                 !kvm_enable_sgx_provisioning(cs->kvm_state)) {
                 *eax &= ~(1U << 4);
             }
         }
 #endif
         break;
     case 0x14: {
         /* Intel Processor Trace Enumeration */
         *eax = 0;
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
         if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) ||
             !kvm_enabled()) {
             break;
         }
 
         if (count == 0) {
             *eax = INTEL_PT_MAX_SUBLEAF;
             *ebx = INTEL_PT_MINIMAL_EBX;
             *ecx = INTEL_PT_MINIMAL_ECX;
             if (env->features[FEAT_14_0_ECX] & CPUID_14_0_ECX_LIP) {
                 *ecx |= CPUID_14_0_ECX_LIP;
             }
         } else if (count == 1) {
             *eax = INTEL_PT_MTC_BITMAP | INTEL_PT_ADDR_RANGES_NUM;
             *ebx = INTEL_PT_PSB_BITMAP | INTEL_PT_CYCLE_BITMAP;
         }
         break;
     }
     case 0x1D: {
         /* AMX TILE, for now hardcoded for Sapphire Rapids*/
         *eax = 0;
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
         if (!(env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_AMX_TILE)) {
             break;
         }
 
         if (count == 0) {
             /* Highest numbered palette subleaf */
             *eax = INTEL_AMX_TILE_MAX_SUBLEAF;
         } else if (count == 1) {
             *eax = INTEL_AMX_TOTAL_TILE_BYTES |
                    (INTEL_AMX_BYTES_PER_TILE << 16);
             *ebx = INTEL_AMX_BYTES_PER_ROW | (INTEL_AMX_TILE_MAX_NAMES << 16);
             *ecx = INTEL_AMX_TILE_MAX_ROWS;
         }
         break;
     }
     case 0x1E: {
         /* AMX TMUL, for now hardcoded for Sapphire Rapids */
         *eax = 0;
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
         if (!(env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_AMX_TILE)) {
             break;
         }
 
         if (count == 0) {
             /* Highest numbered palette subleaf */
             *ebx = INTEL_AMX_TMUL_MAX_K | (INTEL_AMX_TMUL_MAX_N << 8);
         }
         break;
     }
     case 0x40000000:
         /*
          * CPUID code in kvm_arch_init_vcpu() ignores stuff
          * set here, but we restrict to TCG none the less.
          */
         if (tcg_enabled() && cpu->expose_tcg) {
             memcpy(signature, "TCGTCGTCGTCG", 12);
             *eax = 0x40000001;
             *ebx = signature[0];
             *ecx = signature[1];
             *edx = signature[2];
         } else {
             *eax = 0;
             *ebx = 0;
             *ecx = 0;
             *edx = 0;
         }
         break;
     case 0x40000001:
         *eax = 0;
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
         break;
     case 0x80000000:
         *eax = env->cpuid_xlevel;
         *ebx = env->cpuid_vendor1;
         *edx = env->cpuid_vendor2;
         *ecx = env->cpuid_vendor3;
         break;
     case 0x80000001:
         *eax = env->cpuid_version;
         *ebx = 0;
         *ecx = env->features[FEAT_8000_0001_ECX];
         *edx = env->features[FEAT_8000_0001_EDX];
 
         /* The Linux kernel checks for the CMPLegacy bit and
          * discards multiple thread information if it is set.
          * So don't set it here for Intel to make Linux guests happy.
          */
         if (cs->nr_cores * cs->nr_threads > 1) {
             if (env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1 ||
                 env->cpuid_vendor2 != CPUID_VENDOR_INTEL_2 ||
                 env->cpuid_vendor3 != CPUID_VENDOR_INTEL_3) {
                 *ecx |= 1 << 1;    /* CmpLegacy bit */
             }
         }
         if (tcg_enabled() && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1 &&
             !(env->hflags & HF_LMA_MASK)) {
             *edx &= ~CPUID_EXT2_SYSCALL;
         }
         break;
     case 0x80000002:
     case 0x80000003:
     case 0x80000004:
         *eax = env->cpuid_model[(index - 0x80000002) * 4 + 0];
         *ebx = env->cpuid_model[(index - 0x80000002) * 4 + 1];
         *ecx = env->cpuid_model[(index - 0x80000002) * 4 + 2];
         *edx = env->cpuid_model[(index - 0x80000002) * 4 + 3];
         break;
     case 0x80000005:
         /* cache info (L1 cache) */
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
         }
         *eax = (L1_DTLB_2M_ASSOC << 24) | (L1_DTLB_2M_ENTRIES << 16) |
                (L1_ITLB_2M_ASSOC <<  8) | (L1_ITLB_2M_ENTRIES);
         *ebx = (L1_DTLB_4K_ASSOC << 24) | (L1_DTLB_4K_ENTRIES << 16) |
                (L1_ITLB_4K_ASSOC <<  8) | (L1_ITLB_4K_ENTRIES);
         *ecx = encode_cache_cpuid80000005(env->cache_info_amd.l1d_cache);
         *edx = encode_cache_cpuid80000005(env->cache_info_amd.l1i_cache);
         break;
     case 0x80000006:
         /* cache info (L2 cache) */
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, 0, eax, ebx, ecx, edx);
             break;
         }
         *eax = (AMD_ENC_ASSOC(L2_DTLB_2M_ASSOC) << 28) |
                (L2_DTLB_2M_ENTRIES << 16) |
                (AMD_ENC_ASSOC(L2_ITLB_2M_ASSOC) << 12) |
                (L2_ITLB_2M_ENTRIES);
         *ebx = (AMD_ENC_ASSOC(L2_DTLB_4K_ASSOC) << 28) |
                (L2_DTLB_4K_ENTRIES << 16) |
                (AMD_ENC_ASSOC(L2_ITLB_4K_ASSOC) << 12) |
                (L2_ITLB_4K_ENTRIES);
         encode_cache_cpuid80000006(env->cache_info_amd.l2_cache,
                                    cpu->enable_l3_cache ?
                                    env->cache_info_amd.l3_cache : NULL,
                                    ecx, edx);
         break;
     case 0x80000007:
         *eax = 0;
         *ebx = 0;
         *ecx = 0;
         *edx = env->features[FEAT_8000_0007_EDX];
         break;
     case 0x80000008:
         /* virtual & phys address size in low 2 bytes. */
         *eax = cpu->phys_bits;
         if (env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_LM) {
             /* 64 bit processor */
              *eax |= (cpu_x86_virtual_addr_width(env) << 8);
         }
         *ebx = env->features[FEAT_8000_0008_EBX];
         if (cs->nr_cores * cs->nr_threads > 1) {
             /*
              * Bits 15:12 is "The number of bits in the initial
              * Core::X86::Apic::ApicId[ApicId] value that indicate
              * thread ID within a package".
              * Bits 7:0 is "The number of threads in the package is NC+1"
              */
             *ecx = (apicid_pkg_offset(&topo_info) << 12) |
                    ((cs->nr_cores * cs->nr_threads) - 1);
         } else {
             *ecx = 0;
         }
         *edx = 0;
         break;
     case 0x8000000A:
         if (env->features[FEAT_8000_0001_ECX] & CPUID_EXT3_SVM) {
             *eax = 0x00000001; /* SVM Revision */
             *ebx = 0x00000010; /* nr of ASIDs */
             *ecx = 0;
             *edx = env->features[FEAT_SVM]; /* optional features */
         } else {
             *eax = 0;
             *ebx = 0;
             *ecx = 0;
             *edx = 0;
         }
         break;
     case 0x8000001D:
         *eax = 0;
         if (cpu->cache_info_passthrough) {
             x86_cpu_get_cache_cpuid(index, count, eax, ebx, ecx, edx);
             break;
         }
         switch (count) {
         case 0: /* L1 dcache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
                                        &topo_info, eax, ebx, ecx, edx);
             break;
         case 1: /* L1 icache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
                                        &topo_info, eax, ebx, ecx, edx);
             break;
         case 2: /* L2 cache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
                                        &topo_info, eax, ebx, ecx, edx);
             break;
         case 3: /* L3 cache info */
             encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
                                        &topo_info, eax, ebx, ecx, edx);
             break;
         default: /* end of info */
             *eax = *ebx = *ecx = *edx = 0;
             break;
         }
         break;
     case 0x8000001E:
         if (cpu->core_id <= 255) {
             encode_topo_cpuid8000001e(cpu, &topo_info, eax, ebx, ecx, edx);
         } else {
             *eax = 0;
             *ebx = 0;
             *ecx = 0;
             *edx = 0;
         }
         break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
         break;
     case 0xC0000001:
         /* Support for VIA CPU's CPUID instruction */
         *eax = env->cpuid_version;
         *ebx = 0;
         *ecx = 0;
         *edx = env->features[FEAT_C000_0001_EDX];
         break;
     case 0xC0000002:
     case 0xC0000003:
     case 0xC0000004:
         /* Reserved for the future, and now filled with zero */
         *eax = 0;
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
         break;
     case 0x8000001F:
         *eax = *ebx = *ecx = *edx = 0;
         if (sev_enabled()) {
             *eax = 0x2;
             *eax |= sev_es_enabled() ? 0x8 : 0;
             *ebx = sev_get_cbit_position() & 0x3f; /* EBX[5:0] */
             *ebx |= (sev_get_reduced_phys_bits() & 0x3f) << 6; /* EBX[11:6] */
         }
         break;
     case 0x80000021:
         *eax = env->features[FEAT_8000_0021_EAX];
         *ebx = *ecx = *edx = 0;
         break;
     default:
         /* reserved values: zero */
         *eax = 0;
         *ebx = 0;
         *ecx = 0;
         *edx = 0;
         break;
     }
 }
diff --git a/target/i386/hvf/x86_decode.c b/target/i386/hvf/x86_decode.c
index 3728d7705e..7c2e3dab8d 100644
--- a/target/i386/hvf/x86_decode.c
+++ b/target/i386/hvf/x86_decode.c
@@ -1847,48 +1847,49 @@ void calc_modrm_operand(CPUX86State *env, struct x86_decode *decode,
 static void decode_prefix(CPUX86State *env, struct x86_decode *decode)
 {
     while (1) {
         /*
          * REX prefix must come after legacy prefixes.
          * REX before legacy is ignored.
          * Clear rex to simulate this.
          */
         uint8_t byte = decode_byte(env, decode);
         switch (byte) {
         case PREFIX_LOCK:
             decode->lock = byte;
             decode->rex.rex = 0;
             break;
         case PREFIX_REPN:
         case PREFIX_REP:
             decode->rep = byte;
             decode->rex.rex = 0;
             break;
         case PREFIX_CS_SEG_OVERRIDE:
         case PREFIX_SS_SEG_OVERRIDE:
         case PREFIX_DS_SEG_OVERRIDE:
         case PREFIX_ES_SEG_OVERRIDE:
         case PREFIX_FS_SEG_OVERRIDE:
         case PREFIX_GS_SEG_OVERRIDE:
             decode->segment_override = byte;
             decode->rex.rex = 0;
             break;
         case PREFIX_OP_SIZE_OVERRIDE:
             decode->op_size_override = byte;
             decode->rex.rex = 0;
             break;
         case PREFIX_ADDR_SIZE_OVERRIDE:
             decode->addr_size_override = byte;
             decode->rex.rex = 0;
             break;
         case PREFIX_REX ... (PREFIX_REX + 0xf):
             if (x86_is_long_mode(env_cpu(env))) {
                 decode->rex.rex = byte;
                 break;
             }
             /* fall through when not in long mode */
+            fallthrough;
         default:
             decode->len--;
             return;
         }
     }
 }
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index f6c7f7e268..d283d56aa9 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -497,77 +497,77 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
 uint64_t kvm_arch_get_supported_msr_feature(KVMState *s, uint32_t index)
 {
     struct {
         struct kvm_msrs info;
         struct kvm_msr_entry entries[1];
     } msr_data = {};
     uint64_t value;
     uint32_t ret, can_be_one, must_be_one;
 
     if (kvm_feature_msrs == NULL) { /* Host doesn't support feature MSRs */
         return 0;
     }
 
     /* Check if requested MSR is supported feature MSR */
     int i;
     for (i = 0; i < kvm_feature_msrs->nmsrs; i++)
         if (kvm_feature_msrs->indices[i] == index) {
             break;
         }
     if (i == kvm_feature_msrs->nmsrs) {
         return 0; /* if the feature MSR is not supported, simply return 0 */
     }
 
     msr_data.info.nmsrs = 1;
     msr_data.entries[0].index = index;
 
     ret = kvm_ioctl(s, KVM_GET_MSRS, &msr_data);
     if (ret != 1) {
         error_report("KVM get MSR (index=0x%x) feature failed, %s",
             index, strerror(-ret));
         exit(1);
     }
 
     value = msr_data.entries[0].data;
     switch (index) {
     case MSR_IA32_VMX_PROCBASED_CTLS2:
         if (!has_msr_vmx_procbased_ctls2) {
             /* KVM forgot to add these bits for some time, do this ourselves. */
             if (kvm_arch_get_supported_cpuid(s, 0xD, 1, R_ECX) &
                 CPUID_XSAVE_XSAVES) {
                 value |= (uint64_t)VMX_SECONDARY_EXEC_XSAVES << 32;
             }
             if (kvm_arch_get_supported_cpuid(s, 1, 0, R_ECX) &
                 CPUID_EXT_RDRAND) {
                 value |= (uint64_t)VMX_SECONDARY_EXEC_RDRAND_EXITING << 32;
             }
             if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &
                 CPUID_7_0_EBX_INVPCID) {
                 value |= (uint64_t)VMX_SECONDARY_EXEC_ENABLE_INVPCID << 32;
             }
             if (kvm_arch_get_supported_cpuid(s, 7, 0, R_EBX) &
                 CPUID_7_0_EBX_RDSEED) {
                 value |= (uint64_t)VMX_SECONDARY_EXEC_RDSEED_EXITING << 32;
             }
             if (kvm_arch_get_supported_cpuid(s, 0x80000001, 0, R_EDX) &
                 CPUID_EXT2_RDTSCP) {
                 value |= (uint64_t)VMX_SECONDARY_EXEC_RDTSCP << 32;
             }
         }
-        /* fall through */
+        fallthrough;
     case MSR_IA32_VMX_TRUE_PINBASED_CTLS:
     case MSR_IA32_VMX_TRUE_PROCBASED_CTLS:
     case MSR_IA32_VMX_TRUE_ENTRY_CTLS:
     case MSR_IA32_VMX_TRUE_EXIT_CTLS:
         /*
          * Return true for bits that can be one, but do not have to be one.
          * The SDM tells us which bits could have a "must be one" setting,
          * so we can do the opposite transformation in make_vmx_msr_value.
          */
         must_be_one = (uint32_t)value;
         can_be_one = (uint32_t)(value >> 32);
         return can_be_one & ~must_be_one;
 
     default:
         return value;
     }
 }
@@ -1752,524 +1752,524 @@ static void kvm_init_nested_state(CPUX86State *env)
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     struct {
         struct kvm_cpuid2 cpuid;
         struct kvm_cpuid_entry2 entries[KVM_MAX_CPUID_ENTRIES];
     } cpuid_data;
     /*
      * The kernel defines these structs with padding fields so there
      * should be no extra padding in our cpuid_data struct.
      */
     QEMU_BUILD_BUG_ON(sizeof(cpuid_data) !=
                       sizeof(struct kvm_cpuid2) +
                       sizeof(struct kvm_cpuid_entry2) * KVM_MAX_CPUID_ENTRIES);
 
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
     uint32_t limit, i, j, cpuid_i;
     uint32_t unused;
     struct kvm_cpuid_entry2 *c;
     uint32_t signature[3];
     int kvm_base = KVM_CPUID_SIGNATURE;
     int max_nested_state_len;
     int r;
     Error *local_err = NULL;
 
     memset(&cpuid_data, 0, sizeof(cpuid_data));
 
     cpuid_i = 0;
 
     has_xsave2 = kvm_check_extension(cs->kvm_state, KVM_CAP_XSAVE2);
 
     r = kvm_arch_set_tsc_khz(cs);
     if (r < 0) {
         return r;
     }
 
     /* vcpu's TSC frequency is either specified by user, or following
      * the value used by KVM if the former is not present. In the
      * latter case, we query it from KVM and record in env->tsc_khz,
      * so that vcpu's TSC frequency can be migrated later via this field.
      */
     if (!env->tsc_khz) {
         r = kvm_check_extension(cs->kvm_state, KVM_CAP_GET_TSC_KHZ) ?
             kvm_vcpu_ioctl(cs, KVM_GET_TSC_KHZ) :
             -ENOTSUP;
         if (r > 0) {
             env->tsc_khz = r;
         }
     }
 
     env->apic_bus_freq = KVM_APIC_BUS_FREQUENCY;
 
     /*
      * kvm_hyperv_expand_features() is called here for the second time in case
      * KVM_CAP_SYS_HYPERV_CPUID is not supported. While we can't possibly handle
      * 'query-cpu-model-expansion' in this case as we don't have a KVM vCPU to
      * check which Hyper-V enlightenments are supported and which are not, we
      * can still proceed and check/expand Hyper-V enlightenments here so legacy
      * behavior is preserved.
      */
     if (!kvm_hyperv_expand_features(cpu, &local_err)) {
         error_report_err(local_err);
         return -ENOSYS;
     }
 
     if (hyperv_enabled(cpu)) {
         r = hyperv_init_vcpu(cpu);
         if (r) {
             return r;
         }
 
         cpuid_i = hyperv_fill_cpuids(cs, cpuid_data.entries);
         kvm_base = KVM_CPUID_SIGNATURE_NEXT;
         has_msr_hv_hypercall = true;
     }
 
     if (cs->kvm_state->xen_version) {
 #ifdef CONFIG_XEN_EMU
         struct kvm_cpuid_entry2 *xen_max_leaf;
 
         memcpy(signature, "XenVMMXenVMM", 12);
 
         xen_max_leaf = c = &cpuid_data.entries[cpuid_i++];
         c->function = kvm_base + XEN_CPUID_SIGNATURE;
         c->eax = kvm_base + XEN_CPUID_TIME;
         c->ebx = signature[0];
         c->ecx = signature[1];
         c->edx = signature[2];
 
         c = &cpuid_data.entries[cpuid_i++];
         c->function = kvm_base + XEN_CPUID_VENDOR;
         c->eax = cs->kvm_state->xen_version;
         c->ebx = 0;
         c->ecx = 0;
         c->edx = 0;
 
         c = &cpuid_data.entries[cpuid_i++];
         c->function = kvm_base + XEN_CPUID_HVM_MSR;
         /* Number of hypercall-transfer pages */
         c->eax = 1;
         /* Hypercall MSR base address */
         if (hyperv_enabled(cpu)) {
             c->ebx = XEN_HYPERCALL_MSR_HYPERV;
             kvm_xen_init(cs->kvm_state, c->ebx);
         } else {
             c->ebx = XEN_HYPERCALL_MSR;
         }
         c->ecx = 0;
         c->edx = 0;
 
         c = &cpuid_data.entries[cpuid_i++];
         c->function = kvm_base + XEN_CPUID_TIME;
         c->eax = ((!!tsc_is_stable_and_known(env) << 1) |
             (!!(env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_RDTSCP) << 2));
         /* default=0 (emulate if necessary) */
         c->ebx = 0;
         /* guest tsc frequency */
         c->ecx = env->user_tsc_khz;
         /* guest tsc incarnation (migration count) */
         c->edx = 0;
 
         c = &cpuid_data.entries[cpuid_i++];
         c->function = kvm_base + XEN_CPUID_HVM;
         xen_max_leaf->eax = kvm_base + XEN_CPUID_HVM;
         if (cs->kvm_state->xen_version >= XEN_VERSION(4, 5)) {
             c->function = kvm_base + XEN_CPUID_HVM;
 
             if (cpu->xen_vapic) {
                 c->eax |= XEN_HVM_CPUID_APIC_ACCESS_VIRT;
                 c->eax |= XEN_HVM_CPUID_X2APIC_VIRT;
             }
 
             c->eax |= XEN_HVM_CPUID_IOMMU_MAPPINGS;
 
             if (cs->kvm_state->xen_version >= XEN_VERSION(4, 6)) {
                 c->eax |= XEN_HVM_CPUID_VCPU_ID_PRESENT;
                 c->ebx = cs->cpu_index;
             }
         }
 
         r = kvm_xen_init_vcpu(cs);
         if (r) {
             return r;
         }
 
         kvm_base += 0x100;
 #else /* CONFIG_XEN_EMU */
         /* This should never happen as kvm_arch_init() would have died first. */
         fprintf(stderr, "Cannot enable Xen CPUID without Xen support\n");
         abort();
 #endif
     } else if (cpu->expose_kvm) {
         memcpy(signature, "KVMKVMKVM\0\0\0", 12);
         c = &cpuid_data.entries[cpuid_i++];
         c->function = KVM_CPUID_SIGNATURE | kvm_base;
         c->eax = KVM_CPUID_FEATURES | kvm_base;
         c->ebx = signature[0];
         c->ecx = signature[1];
         c->edx = signature[2];
 
         c = &cpuid_data.entries[cpuid_i++];
         c->function = KVM_CPUID_FEATURES | kvm_base;
         c->eax = env->features[FEAT_KVM];
         c->edx = env->features[FEAT_KVM_HINTS];
     }
 
     cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
 
     if (cpu->kvm_pv_enforce_cpuid) {
         r = kvm_vcpu_enable_cap(cs, KVM_CAP_ENFORCE_PV_FEATURE_CPUID, 0, 1);
         if (r < 0) {
             fprintf(stderr,
                     "failed to enable KVM_CAP_ENFORCE_PV_FEATURE_CPUID: %s",
                     strerror(-r));
             abort();
         }
     }
 
     for (i = 0; i <= limit; i++) {
         if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
             fprintf(stderr, "unsupported level value: 0x%x\n", limit);
             abort();
         }
         c = &cpuid_data.entries[cpuid_i++];
 
         switch (i) {
         case 2: {
             /* Keep reading function 2 till all the input is received */
             int times;
 
             c->function = i;
             c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC |
                        KVM_CPUID_FLAG_STATE_READ_NEXT;
             cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
             times = c->eax & 0xff;
 
             for (j = 1; j < times; ++j) {
                 if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
                     fprintf(stderr, "cpuid_data is full, no space for "
                             "cpuid(eax:2):eax & 0xf = 0x%x\n", times);
                     abort();
                 }
                 c = &cpuid_data.entries[cpuid_i++];
                 c->function = i;
                 c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC;
                 cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
             }
             break;
         }
         case 0x1f:
             if (env->nr_dies < 2) {
                 break;
             }
-            /* fallthrough */
+            fallthrough;
         case 4:
         case 0xb:
         case 0xd:
             for (j = 0; ; j++) {
                 if (i == 0xd && j == 64) {
                     break;
                 }
 
                 if (i == 0x1f && j == 64) {
                     break;
                 }
 
                 c->function = i;
                 c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
                 c->index = j;
                 cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
 
                 if (i == 4 && c->eax == 0) {
                     break;
                 }
                 if (i == 0xb && !(c->ecx & 0xff00)) {
                     break;
                 }
                 if (i == 0x1f && !(c->ecx & 0xff00)) {
                     break;
                 }
                 if (i == 0xd && c->eax == 0) {
                     continue;
                 }
                 if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
                     fprintf(stderr, "cpuid_data is full, no space for "
                             "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
                     abort();
                 }
                 c = &cpuid_data.entries[cpuid_i++];
             }
             break;
         case 0x7:
         case 0x12:
             for (j = 0; ; j++) {
                 c->function = i;
                 c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
                 c->index = j;
                 cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
 
                 if (j > 1 && (c->eax & 0xf) != 1) {
                     break;
                 }
 
                 if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
                     fprintf(stderr, "cpuid_data is full, no space for "
                                 "cpuid(eax:0x12,ecx:0x%x)\n", j);
                     abort();
                 }
                 c = &cpuid_data.entries[cpuid_i++];
             }
             break;
         case 0x14:
         case 0x1d:
         case 0x1e: {
             uint32_t times;
 
             c->function = i;
             c->index = 0;
             c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
             cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
             times = c->eax;
 
             for (j = 1; j <= times; ++j) {
                 if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
                     fprintf(stderr, "cpuid_data is full, no space for "
                                 "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
                     abort();
                 }
                 c = &cpuid_data.entries[cpuid_i++];
                 c->function = i;
                 c->index = j;
                 c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
                 cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
             }
             break;
         }
         default:
             c->function = i;
             c->flags = 0;
             cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
             if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
                 /*
                  * KVM already returns all zeroes if a CPUID entry is missing,
                  * so we can omit it and avoid hitting KVM's 80-entry limit.
                  */
                 cpuid_i--;
             }
             break;
         }
     }
 
     if (limit >= 0x0a) {
         uint32_t eax, edx;
 
         cpu_x86_cpuid(env, 0x0a, 0, &eax, &unused, &unused, &edx);
 
         has_architectural_pmu_version = eax & 0xff;
         if (has_architectural_pmu_version > 0) {
             num_architectural_pmu_gp_counters = (eax & 0xff00) >> 8;
 
             /* Shouldn't be more than 32, since that's the number of bits
              * available in EBX to tell us _which_ counters are available.
              * Play it safe.
              */
             if (num_architectural_pmu_gp_counters > MAX_GP_COUNTERS) {
                 num_architectural_pmu_gp_counters = MAX_GP_COUNTERS;
             }
 
             if (has_architectural_pmu_version > 1) {
                 num_architectural_pmu_fixed_counters = edx & 0x1f;
 
                 if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
                     num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
                 }
             }
         }
     }
 
     cpu_x86_cpuid(env, 0x80000000, 0, &limit, &unused, &unused, &unused);
 
     for (i = 0x80000000; i <= limit; i++) {
         if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
             fprintf(stderr, "unsupported xlevel value: 0x%x\n", limit);
             abort();
         }
         c = &cpuid_data.entries[cpuid_i++];
 
         switch (i) {
         case 0x8000001d:
             /* Query for all AMD cache information leaves */
             for (j = 0; ; j++) {
                 c->function = i;
                 c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
                 c->index = j;
                 cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
 
                 if (c->eax == 0) {
                     break;
                 }
                 if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
                     fprintf(stderr, "cpuid_data is full, no space for "
                             "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
                     abort();
                 }
                 c = &cpuid_data.entries[cpuid_i++];
             }
             break;
         default:
             c->function = i;
             c->flags = 0;
             cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
             if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
                 /*
                  * KVM already returns all zeroes if a CPUID entry is missing,
                  * so we can omit it and avoid hitting KVM's 80-entry limit.
                  */
                 cpuid_i--;
             }
             break;
         }
     }
 
     /* Call Centaur's CPUID instructions they are supported. */
     if (env->cpuid_xlevel2 > 0) {
         cpu_x86_cpuid(env, 0xC0000000, 0, &limit, &unused, &unused, &unused);
 
         for (i = 0xC0000000; i <= limit; i++) {
             if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
                 fprintf(stderr, "unsupported xlevel2 value: 0x%x\n", limit);
                 abort();
             }
             c = &cpuid_data.entries[cpuid_i++];
 
             c->function = i;
             c->flags = 0;
             cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
         }
     }
 
     cpuid_data.cpuid.nent = cpuid_i;
 
     if (((env->cpuid_version >> 8)&0xF) >= 6
         && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
            (CPUID_MCE | CPUID_MCA)
         && kvm_check_extension(cs->kvm_state, KVM_CAP_MCE) > 0) {
         uint64_t mcg_cap, unsupported_caps;
         int banks;
         int ret;
 
         ret = kvm_get_mce_cap_supported(cs->kvm_state, &mcg_cap, &banks);
         if (ret < 0) {
             fprintf(stderr, "kvm_get_mce_cap_supported: %s", strerror(-ret));
             return ret;
         }
 
         if (banks < (env->mcg_cap & MCG_CAP_BANKS_MASK)) {
             error_report("kvm: Unsupported MCE bank count (QEMU = %d, KVM = %d)",
                          (int)(env->mcg_cap & MCG_CAP_BANKS_MASK), banks);
             return -ENOTSUP;
         }
 
         unsupported_caps = env->mcg_cap & ~(mcg_cap | MCG_CAP_BANKS_MASK);
         if (unsupported_caps) {
             if (unsupported_caps & MCG_LMCE_P) {
                 error_report("kvm: LMCE not supported");
                 return -ENOTSUP;
             }
             warn_report("Unsupported MCG_CAP bits: 0x%" PRIx64,
                         unsupported_caps);
         }
 
         env->mcg_cap &= mcg_cap | MCG_CAP_BANKS_MASK;
         ret = kvm_vcpu_ioctl(cs, KVM_X86_SETUP_MCE, &env->mcg_cap);
         if (ret < 0) {
             fprintf(stderr, "KVM_X86_SETUP_MCE: %s", strerror(-ret));
             return ret;
         }
     }
 
     cpu->vmsentry = qemu_add_vm_change_state_handler(cpu_update_state, env);
 
     c = cpuid_find_entry(&cpuid_data.cpuid, 1, 0);
     if (c) {
         has_msr_feature_control = !!(c->ecx & CPUID_EXT_VMX) ||
                                   !!(c->ecx & CPUID_EXT_SMX);
     }
 
     c = cpuid_find_entry(&cpuid_data.cpuid, 7, 0);
     if (c && (c->ebx & CPUID_7_0_EBX_SGX)) {
         has_msr_feature_control = true;
     }
 
     if (env->mcg_cap & MCG_LMCE_P) {
         has_msr_mcg_ext_ctl = has_msr_feature_control = true;
     }
 
     if (!env->user_tsc_khz) {
         if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
             invtsc_mig_blocker == NULL) {
             error_setg(&invtsc_mig_blocker,
                        "State blocked by non-migratable CPU device"
                        " (invtsc flag)");
             r = migrate_add_blocker(invtsc_mig_blocker, &local_err);
             if (r < 0) {
                 error_report_err(local_err);
                 return r;
             }
         }
     }
 
     if (cpu->vmware_cpuid_freq
         /* Guests depend on 0x40000000 to detect this feature, so only expose
          * it if KVM exposes leaf 0x40000000. (Conflicts with Hyper-V) */
         && cpu->expose_kvm
         && kvm_base == KVM_CPUID_SIGNATURE
         /* TSC clock must be stable and known for this feature. */
         && tsc_is_stable_and_known(env)) {
 
         c = &cpuid_data.entries[cpuid_i++];
         c->function = KVM_CPUID_SIGNATURE | 0x10;
         c->eax = env->tsc_khz;
         c->ebx = env->apic_bus_freq / 1000; /* Hz to KHz */
         c->ecx = c->edx = 0;
 
         c = cpuid_find_entry(&cpuid_data.cpuid, kvm_base, 0);
         c->eax = MAX(c->eax, KVM_CPUID_SIGNATURE | 0x10);
     }
 
     cpuid_data.cpuid.nent = cpuid_i;
 
     cpuid_data.cpuid.padding = 0;
     r = kvm_vcpu_ioctl(cs, KVM_SET_CPUID2, &cpuid_data);
     if (r) {
         goto fail;
     }
     kvm_init_xsave(env);
 
     max_nested_state_len = kvm_max_nested_state_length();
     if (max_nested_state_len > 0) {
         assert(max_nested_state_len >= offsetof(struct kvm_nested_state, data));
 
         if (cpu_has_vmx(env) || cpu_has_svm(env)) {
             env->nested_state = g_malloc0(max_nested_state_len);
             env->nested_state->size = max_nested_state_len;
 
             kvm_init_nested_state(env);
         }
     }
 
     cpu->kvm_msr_buf = g_malloc0(MSR_BUF_SIZE);
 
     if (!(env->features[FEAT_8000_0001_EDX] & CPUID_EXT2_RDTSCP)) {
         has_msr_tsc_aux = false;
     }
 
     kvm_init_msrs(cpu);
 
     return 0;
 
  fail:
     migrate_del_blocker(invtsc_mig_blocker);
 
     return r;
 }
diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 7d76f15275..0e663e9124 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1050,84 +1050,84 @@ static int decode_modrm(DisasContext *s, CPUX86State *env, X86DecodedInsn *decod
 static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp *ot)
 {
     switch (size) {
     case X86_SIZE_b:  /* byte */
         *ot = MO_8;
         return true;
 
     case X86_SIZE_d:  /* 32-bit */
     case X86_SIZE_ss: /* SSE/AVX scalar single precision */
         *ot = MO_32;
         return true;
 
     case X86_SIZE_p:  /* Far pointer, return offset size */
     case X86_SIZE_s:  /* Descriptor, return offset size */
     case X86_SIZE_v:  /* 16/32/64-bit, based on operand size */
         *ot = s->dflag;
         return true;
 
     case X86_SIZE_pi: /* MMX */
     case X86_SIZE_q:  /* 64-bit */
     case X86_SIZE_sd: /* SSE/AVX scalar double precision */
         *ot = MO_64;
         return true;
 
     case X86_SIZE_w:  /* 16-bit */
         *ot = MO_16;
         return true;
 
     case X86_SIZE_y:  /* 32/64-bit, based on operand size */
         *ot = s->dflag == MO_16 ? MO_32 : s->dflag;
         return true;
 
     case X86_SIZE_z:  /* 16-bit for 16-bit operand size, else 32-bit */
         *ot = s->dflag == MO_16 ? MO_16 : MO_32;
         return true;
 
     case X86_SIZE_dq: /* SSE/AVX 128-bit */
         if (e->special == X86_SPECIAL_MMX &&
             !(s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
             *ot = MO_64;
             return true;
         }
         if (s->vex_l && e->s0 != X86_SIZE_qq && e->s1 != X86_SIZE_qq) {
             return false;
         }
         *ot = MO_128;
         return true;
 
     case X86_SIZE_qq: /* AVX 256-bit */
         if (!s->vex_l) {
             return false;
         }
         *ot = MO_256;
         return true;
 
     case X86_SIZE_x:  /* 128/256-bit, based on operand size */
         if (e->special == X86_SPECIAL_MMX &&
             !(s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
             *ot = MO_64;
             return true;
         }
-        /* fall through */
+        fallthrough;
     case X86_SIZE_ps: /* SSE/AVX packed single precision */
     case X86_SIZE_pd: /* SSE/AVX packed double precision */
         *ot = s->vex_l ? MO_256 : MO_128;
         return true;
 
     case X86_SIZE_xh: /* SSE/AVX packed half register */
         *ot = s->vex_l ? MO_128 : MO_64;
         return true;
 
     case X86_SIZE_d64:  /* Default to 64-bit in 64-bit mode */
         *ot = CODE64(s) && s->dflag == MO_32 ? MO_64 : s->dflag;
         return true;
 
     case X86_SIZE_f64:  /* Ignore size override prefix in 64-bit mode */
         *ot = CODE64(s) ? MO_64 : s->dflag;
         return true;
 
     default:
         *ot = -1;
         return true;
     }
 }
@@ -1135,183 +1135,183 @@ static bool decode_op_size(DisasContext *s, X86OpEntry *e, X86OpSize size, MemOp
 static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
                       X86DecodedOp *op, X86OpType type, int b)
 {
     int modrm;
 
     switch (type) {
     case X86_TYPE_None:  /* Implicit or absent */
     case X86_TYPE_A:  /* Implicit */
     case X86_TYPE_F:  /* EFLAGS/RFLAGS */
         break;
 
     case X86_TYPE_B:  /* VEX.vvvv selects a GPR */
         op->unit = X86_OP_INT;
         op->n = s->vex_v;
         break;
 
     case X86_TYPE_C:  /* REG in the modrm byte selects a control register */
         op->unit = X86_OP_CR;
         goto get_reg;
 
     case X86_TYPE_D:  /* REG in the modrm byte selects a debug register */
         op->unit = X86_OP_DR;
         goto get_reg;
 
     case X86_TYPE_G:  /* REG in the modrm byte selects a GPR */
         op->unit = X86_OP_INT;
         goto get_reg;
 
     case X86_TYPE_S:  /* reg selects a segment register */
         op->unit = X86_OP_SEG;
         goto get_reg;
 
     case X86_TYPE_P:
         op->unit = X86_OP_MMX;
         goto get_reg;
 
     case X86_TYPE_V:  /* reg in the modrm byte selects an XMM/YMM register */
         if (decode->e.special == X86_SPECIAL_MMX &&
             !(s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
             op->unit = X86_OP_MMX;
         } else {
             op->unit = X86_OP_SSE;
         }
     get_reg:
         op->n = ((get_modrm(s, env) >> 3) & 7) | REX_R(s);
         break;
 
     case X86_TYPE_E:  /* ALU modrm operand */
         op->unit = X86_OP_INT;
         goto get_modrm;
 
     case X86_TYPE_Q:  /* MMX modrm operand */
         op->unit = X86_OP_MMX;
         goto get_modrm;
 
     case X86_TYPE_W:  /* XMM/YMM modrm operand */
         if (decode->e.special == X86_SPECIAL_MMX &&
             !(s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
             op->unit = X86_OP_MMX;
         } else {
             op->unit = X86_OP_SSE;
         }
         goto get_modrm;
 
     case X86_TYPE_N:  /* R/M in the modrm byte selects an MMX register */
         op->unit = X86_OP_MMX;
         goto get_modrm_reg;
 
     case X86_TYPE_U:  /* R/M in the modrm byte selects an XMM/YMM register */
         if (decode->e.special == X86_SPECIAL_MMX &&
             !(s->prefix & (PREFIX_DATA | PREFIX_REPZ | PREFIX_REPNZ))) {
             op->unit = X86_OP_MMX;
         } else {
             op->unit = X86_OP_SSE;
         }
         goto get_modrm_reg;
 
     case X86_TYPE_R:  /* R/M in the modrm byte selects a register */
         op->unit = X86_OP_INT;
     get_modrm_reg:
         modrm = get_modrm(s, env);
         if ((modrm >> 6) != 3) {
             return false;
         }
         goto get_modrm;
 
     case X86_TYPE_WM:  /* modrm byte selects an XMM/YMM memory operand */
         op->unit = X86_OP_SSE;
-        /* fall through */
+        fallthrough;
     case X86_TYPE_M:  /* modrm byte selects a memory operand */
         modrm = get_modrm(s, env);
         if ((modrm >> 6) == 3) {
             return false;
         }
     get_modrm:
         decode_modrm(s, env, decode, op, type);
         break;
 
     case X86_TYPE_O:  /* Absolute address encoded in the instruction */
         op->unit = X86_OP_INT;
         op->has_ea = true;
         op->n = -1;
         decode->mem = (AddressParts) {
             .def_seg = R_DS,
             .base = -1,
             .index = -1,
             .disp = insn_get_addr(env, s, s->aflag)
         };
         break;
 
     case X86_TYPE_H:  /* For AVX, VEX.vvvv selects an XMM/YMM register */
         if ((s->prefix & PREFIX_VEX)) {
             op->unit = X86_OP_SSE;
             op->n = s->vex_v;
             break;
         }
         if (op == &decode->op[0]) {
             /* shifts place the destination in VEX.vvvv, use modrm */
             return decode_op(s, env, decode, op, decode->e.op1, b);
         } else {
             return decode_op(s, env, decode, op, decode->e.op0, b);
         }
 
     case X86_TYPE_I:  /* Immediate */
         op->unit = X86_OP_IMM;
         decode->immediate = insn_get_signed(env, s, op->ot);
         break;
 
     case X86_TYPE_J:  /* Relative offset for a jump */
         op->unit = X86_OP_IMM;
         decode->immediate = insn_get_signed(env, s, op->ot);
         decode->immediate += s->pc - s->cs_base;
         if (s->dflag == MO_16) {
             decode->immediate &= 0xffff;
         } else if (!CODE64(s)) {
             decode->immediate &= 0xffffffffu;
         }
         break;
 
     case X86_TYPE_L:  /* The upper 4 bits of the immediate select a 128-bit register */
         op->n = insn_get(env, s, op->ot) >> 4;
         break;
 
     case X86_TYPE_X:  /* string source */
         op->n = -1;
         decode->mem = (AddressParts) {
             .def_seg = R_DS,
             .base = R_ESI,
             .index = -1,
         };
         break;
 
     case X86_TYPE_Y:  /* string destination */
         op->n = -1;
         decode->mem = (AddressParts) {
             .def_seg = R_ES,
             .base = R_EDI,
             .index = -1,
         };
         break;
 
     case X86_TYPE_2op:
         *op = decode->op[0];
         break;
 
     case X86_TYPE_LoBits:
         op->n = (b & 7) | REX_B(s);
         op->unit = X86_OP_INT;
         break;
 
     case X86_TYPE_0 ... X86_TYPE_7:
         op->n = type - X86_TYPE_0;
         op->unit = X86_OP_INT;
         break;
 
     case X86_TYPE_ES ... X86_TYPE_GS:
         op->n = type - X86_TYPE_ES;
         op->unit = X86_OP_SEG;
         break;
     }
 
     return true;
 }
@@ -1463,120 +1463,120 @@ static bool has_cpuid_feature(DisasContext *s, X86CPUIDFeature cpuid)
 static bool validate_vex(DisasContext *s, X86DecodedInsn *decode)
 {
     X86OpEntry *e = &decode->e;
 
     switch (e->vex_special) {
     case X86_VEX_REPScalar:
         /*
          * Instructions which differ between 00/66 and F2/F3 in the
          * exception classification and the size of the memory operand.
          */
         assert(e->vex_class == 1 || e->vex_class == 2 || e->vex_class == 4);
         if (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ)) {
             e->vex_class = e->vex_class < 4 ? 3 : 5;
             if (s->vex_l) {
                 goto illegal;
             }
             assert(decode->e.s2 == X86_SIZE_x);
             if (decode->op[2].has_ea) {
                 decode->op[2].ot = s->prefix & PREFIX_REPZ ? MO_32 : MO_64;
             }
         }
         break;
 
     case X86_VEX_SSEUnaligned:
         /* handled in sse_needs_alignment.  */
         break;
 
     case X86_VEX_AVX2_256:
         if ((s->prefix & PREFIX_VEX) && s->vex_l && !has_cpuid_feature(s, X86_FEAT_AVX2)) {
             goto illegal;
         }
     }
 
     /* TODO: instructions that require VEX.W=0 (Table 2-16) */
 
     switch (e->vex_class) {
     case 0:
         if (s->prefix & PREFIX_VEX) {
             goto illegal;
         }
         return true;
     case 1:
     case 2:
     case 3:
     case 4:
     case 5:
     case 7:
         if (s->prefix & PREFIX_VEX) {
             if (!(s->flags & HF_AVX_EN_MASK)) {
                 goto illegal;
             }
         } else if (e->special != X86_SPECIAL_MMX ||
                    (s->prefix & (PREFIX_REPZ | PREFIX_REPNZ | PREFIX_DATA))) {
             if (!(s->flags & HF_OSFXSR_MASK)) {
                 goto illegal;
             }
         }
         break;
     case 12:
         /* Must have a VSIB byte and no address prefix.  */
         assert(s->has_modrm);
         if ((s->modrm & 7) != 4 || s->aflag == MO_16) {
             goto illegal;
         }
 
         /* Check no overlap between registers.  */
         if (!decode->op[0].has_ea &&
             (decode->op[0].n == decode->mem.index || decode->op[0].n == decode->op[1].n)) {
             goto illegal;
         }
         assert(!decode->op[1].has_ea);
         if (decode->op[1].n == decode->mem.index) {
             goto illegal;
         }
         if (!decode->op[2].has_ea &&
             (decode->op[2].n == decode->mem.index || decode->op[2].n == decode->op[1].n)) {
             goto illegal;
         }
-        /* fall through */
+        fallthrough;
     case 6:
     case 11:
         if (!(s->prefix & PREFIX_VEX)) {
             goto illegal;
         }
         if (!(s->flags & HF_AVX_EN_MASK)) {
             goto illegal;
         }
         break;
     case 8:
         /* Non-VEX case handled in decode_0F77.  */
         assert(s->prefix & PREFIX_VEX);
         if (!(s->flags & HF_AVX_EN_MASK)) {
             goto illegal;
         }
         break;
     case 13:
         if (!(s->prefix & PREFIX_VEX)) {
             goto illegal;
         }
         if (s->vex_l) {
             goto illegal;
         }
         /* All integer instructions use VEX.vvvv, so exit.  */
         return true;
     }
 
     if (s->vex_v != 0 &&
         e->op0 != X86_TYPE_H && e->op0 != X86_TYPE_B &&
         e->op1 != X86_TYPE_H && e->op1 != X86_TYPE_B &&
         e->op2 != X86_TYPE_H && e->op2 != X86_TYPE_B) {
         goto illegal;
     }
 
     if (s->flags & HF_TS_MASK) {
         goto nm_exception;
     }
     if (s->flags & HF_EM_MASK) {
         goto illegal;
     }
     return true;
diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
index 88793ba988..0e0a2efbf9 100644
--- a/target/i386/tcg/emit.c.inc
+++ b/target/i386/tcg/emit.c.inc
@@ -202,18 +202,18 @@ static void gen_load_sse(DisasContext *s, TCGv temp, MemOp ot, int dest_ofs, boo
 static bool sse_needs_alignment(DisasContext *s, X86DecodedInsn *decode, MemOp ot)
 {
     switch (decode->e.vex_class) {
     case 2:
     case 4:
         if ((s->prefix & PREFIX_VEX) ||
             decode->e.vex_special == X86_VEX_SSEUnaligned) {
             /* MOST legacy SSE instructions require aligned memory operands, but not all.  */
             return false;
         }
-        /* fall through */
+        fallthrough;
     case 1:
         return ot >= MO_128;
 
     default:
         return false;
     }
 }
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index e42e3dd653..77a8fcc5e1 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1001,26 +1001,26 @@ static CCPrepare gen_prepare_eflags_p(DisasContext *s, TCGv reg)
 /* compute eflags.S to reg */
 static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
 {
     switch (s->cc_op) {
     case CC_OP_DYNAMIC:
         gen_compute_eflags(s);
-        /* FALLTHRU */
+        fallthrough;
     case CC_OP_EFLAGS:
     case CC_OP_ADCX:
     case CC_OP_ADOX:
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
                              .mask = CC_S };
     case CC_OP_CLR:
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER, .mask = -1 };
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
             TCGv t0 = gen_ext_tl(reg, cpu_cc_dst, size, true);
             return (CCPrepare) { .cond = TCG_COND_LT, .reg = t0, .mask = -1 };
         }
     }
 }
 
 /* compute eflags.O to reg */
@@ -1044,29 +1044,29 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
 /* compute eflags.Z to reg */
 static CCPrepare gen_prepare_eflags_z(DisasContext *s, TCGv reg)
 {
     switch (s->cc_op) {
     case CC_OP_DYNAMIC:
         gen_compute_eflags(s);
-        /* FALLTHRU */
+        fallthrough;
     case CC_OP_EFLAGS:
     case CC_OP_ADCX:
     case CC_OP_ADOX:
     case CC_OP_ADCOX:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
                              .mask = CC_Z };
     case CC_OP_CLR:
         return (CCPrepare) { .cond = TCG_COND_ALWAYS, .mask = -1 };
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_EQ, .reg = cpu_cc_src,
                              .mask = -1 };
     default:
         {
             MemOp size = (s->cc_op - CC_OP_ADDB) & 3;
             TCGv t0 = gen_ext_tl(reg, cpu_cc_dst, size, false);
             return (CCPrepare) { .cond = TCG_COND_EQ, .reg = t0, .mask = -1 };
         }
     }
 }
 
 /* perform a conditional store into register 'reg' according to jump opcode
    value 'b'. In the fast case, T0 is guaranteed not to be used. */
@@ -3079,3751 +3079,3750 @@ static void gen_cmpxchg16b(DisasContext *s, CPUX86State *env, int modrm)
 /* convert one instruction. s->base.is_jmp is set if the translation must
    be stopped. Return the next pc value */
 static bool disas_insn(DisasContext *s, CPUState *cpu)
 {
     CPUX86State *env = cpu_env(cpu);
     int b, prefixes;
     int shift;
     MemOp ot, aflag, dflag;
     int modrm, reg, rm, mod, op, opreg, val;
     bool orig_cc_op_dirty = s->cc_op_dirty;
     CCOp orig_cc_op = s->cc_op;
     target_ulong orig_pc_save = s->pc_save;
 
     s->pc = s->base.pc_next;
     s->override = -1;
 #ifdef TARGET_X86_64
     s->rex_r = 0;
     s->rex_x = 0;
     s->rex_b = 0;
 #endif
     s->rip_offset = 0; /* for relative ip address */
     s->vex_l = 0;
     s->vex_v = 0;
     s->vex_w = false;
     switch (sigsetjmp(s->jmpbuf, 0)) {
     case 0:
         break;
     case 1:
         gen_exception_gpf(s);
         return true;
     case 2:
         /* Restore state that may affect the next instruction. */
         s->pc = s->base.pc_next;
         /*
          * TODO: These save/restore can be removed after the table-based
          * decoder is complete; we will be decoding the insn completely
          * before any code generation that might affect these variables.
          */
         s->cc_op_dirty = orig_cc_op_dirty;
         s->cc_op = orig_cc_op;
         s->pc_save = orig_pc_save;
         /* END TODO */
         s->base.num_insns--;
         tcg_remove_ops_after(s->prev_insn_end);
         s->base.is_jmp = DISAS_TOO_MANY;
         return false;
     default:
         g_assert_not_reached();
     }
 
     prefixes = 0;
 
  next_byte:
     s->prefix = prefixes;
     b = x86_ldub_code(env, s);
     /* Collect prefixes.  */
     switch (b) {
     default:
         break;
     case 0x0f:
         b = x86_ldub_code(env, s) + 0x100;
         break;
     case 0xf3:
         prefixes |= PREFIX_REPZ;
         prefixes &= ~PREFIX_REPNZ;
         goto next_byte;
     case 0xf2:
         prefixes |= PREFIX_REPNZ;
         prefixes &= ~PREFIX_REPZ;
         goto next_byte;
     case 0xf0:
         prefixes |= PREFIX_LOCK;
         goto next_byte;
     case 0x2e:
         s->override = R_CS;
         goto next_byte;
     case 0x36:
         s->override = R_SS;
         goto next_byte;
     case 0x3e:
         s->override = R_DS;
         goto next_byte;
     case 0x26:
         s->override = R_ES;
         goto next_byte;
     case 0x64:
         s->override = R_FS;
         goto next_byte;
     case 0x65:
         s->override = R_GS;
         goto next_byte;
     case 0x66:
         prefixes |= PREFIX_DATA;
         goto next_byte;
     case 0x67:
         prefixes |= PREFIX_ADR;
         goto next_byte;
 #ifdef TARGET_X86_64
     case 0x40 ... 0x4f:
         if (CODE64(s)) {
             /* REX prefix */
             prefixes |= PREFIX_REX;
             s->vex_w = (b >> 3) & 1;
             s->rex_r = (b & 0x4) << 1;
             s->rex_x = (b & 0x2) << 2;
             s->rex_b = (b & 0x1) << 3;
             goto next_byte;
         }
         break;
 #endif
     case 0xc5: /* 2-byte VEX */
     case 0xc4: /* 3-byte VEX */
         if (CODE32(s) && !VM86(s)) {
             int vex2 = x86_ldub_code(env, s);
             s->pc--; /* rewind the advance_pc() x86_ldub_code() did */
 
             if (!CODE64(s) && (vex2 & 0xc0) != 0xc0) {
                 /* 4.1.4.6: In 32-bit mode, bits [7:6] must be 11b,
                    otherwise the instruction is LES or LDS.  */
                 break;
             }
             disas_insn_new(s, cpu, b);
             return s->pc;
         }
         break;
     }
 
     /* Post-process prefixes.  */
     if (CODE64(s)) {
         /* In 64-bit mode, the default data size is 32-bit.  Select 64-bit
            data with rex_w, and 16-bit data with 0x66; rex_w takes precedence
            over 0x66 if both are present.  */
         dflag = (REX_W(s) ? MO_64 : prefixes & PREFIX_DATA ? MO_16 : MO_32);
         /* In 64-bit mode, 0x67 selects 32-bit addressing.  */
         aflag = (prefixes & PREFIX_ADR ? MO_32 : MO_64);
     } else {
         /* In 16/32-bit mode, 0x66 selects the opposite data size.  */
         if (CODE32(s) ^ ((prefixes & PREFIX_DATA) != 0)) {
             dflag = MO_32;
         } else {
             dflag = MO_16;
         }
         /* In 16/32-bit mode, 0x67 selects the opposite addressing.  */
         if (CODE32(s) ^ ((prefixes & PREFIX_ADR) != 0)) {
             aflag = MO_32;
         }  else {
             aflag = MO_16;
         }
     }
 
     s->prefix = prefixes;
     s->aflag = aflag;
     s->dflag = dflag;
 
     /* now check op code */
     switch (b) {
         /**************************/
         /* arith & logic */
     case 0x00 ... 0x05:
     case 0x08 ... 0x0d:
     case 0x10 ... 0x15:
     case 0x18 ... 0x1d:
     case 0x20 ... 0x25:
     case 0x28 ... 0x2d:
     case 0x30 ... 0x35:
     case 0x38 ... 0x3d:
         {
             int f;
             op = (b >> 3) & 7;
             f = (b >> 1) & 3;
 
             ot = mo_b_d(b, dflag);
 
             switch(f) {
             case 0: /* OP Ev, Gv */
                 modrm = x86_ldub_code(env, s);
                 reg = ((modrm >> 3) & 7) | REX_R(s);
                 mod = (modrm >> 6) & 3;
                 rm = (modrm & 7) | REX_B(s);
                 if (mod != 3) {
                     gen_lea_modrm(env, s, modrm);
                     opreg = OR_TMP0;
                 } else if (op == OP_XORL && rm == reg) {
                 xor_zero:
                     /* xor reg, reg optimisation */
                     set_cc_op(s, CC_OP_CLR);
                     tcg_gen_movi_tl(s->T0, 0);
                     gen_op_mov_reg_v(s, ot, reg, s->T0);
                     break;
                 } else {
                     opreg = rm;
                 }
                 gen_op_mov_v_reg(s, ot, s->T1, reg);
                 gen_op(s, op, ot, opreg);
                 break;
             case 1: /* OP Gv, Ev */
                 modrm = x86_ldub_code(env, s);
                 mod = (modrm >> 6) & 3;
                 reg = ((modrm >> 3) & 7) | REX_R(s);
                 rm = (modrm & 7) | REX_B(s);
                 if (mod != 3) {
                     gen_lea_modrm(env, s, modrm);
                     gen_op_ld_v(s, ot, s->T1, s->A0);
                 } else if (op == OP_XORL && rm == reg) {
                     goto xor_zero;
                 } else {
                     gen_op_mov_v_reg(s, ot, s->T1, rm);
                 }
                 gen_op(s, op, ot, reg);
                 break;
             case 2: /* OP A, Iv */
                 val = insn_get(env, s, ot);
                 tcg_gen_movi_tl(s->T1, val);
                 gen_op(s, op, ot, OR_EAX);
                 break;
             }
         }
         break;
 
     case 0x82:
         if (CODE64(s))
             goto illegal_op;
-        /* fall through */
         fallthrough;
     case 0x80: /* GRP1 */
     case 0x81:
     case 0x83:
         {
             ot = mo_b_d(b, dflag);
 
             modrm = x86_ldub_code(env, s);
             mod = (modrm >> 6) & 3;
             rm = (modrm & 7) | REX_B(s);
             op = (modrm >> 3) & 7;
 
             if (mod != 3) {
                 if (b == 0x83)
                     s->rip_offset = 1;
                 else
                     s->rip_offset = insn_const_size(ot);
                 gen_lea_modrm(env, s, modrm);
                 opreg = OR_TMP0;
             } else {
                 opreg = rm;
             }
 
             switch(b) {
             default:
             case 0x80:
             case 0x81:
             case 0x82:
                 val = insn_get(env, s, ot);
                 break;
             case 0x83:
                 val = (int8_t)insn_get(env, s, MO_8);
                 break;
             }
             tcg_gen_movi_tl(s->T1, val);
             gen_op(s, op, ot, opreg);
         }
         break;
 
         /**************************/
         /* inc, dec, and other misc arith */
     case 0x40 ... 0x47: /* inc Gv */
         ot = dflag;
         gen_inc(s, ot, OR_EAX + (b & 7), 1);
         break;
     case 0x48 ... 0x4f: /* dec Gv */
         ot = dflag;
         gen_inc(s, ot, OR_EAX + (b & 7), -1);
         break;
     case 0xf6: /* GRP3 */
     case 0xf7:
         ot = mo_b_d(b, dflag);
 
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         rm = (modrm & 7) | REX_B(s);
         op = (modrm >> 3) & 7;
         if (mod != 3) {
             if (op == 0) {
                 s->rip_offset = insn_const_size(ot);
             }
             gen_lea_modrm(env, s, modrm);
             /* For those below that handle locked memory, don't load here.  */
             if (!(s->prefix & PREFIX_LOCK)
                 || op != 2) {
                 gen_op_ld_v(s, ot, s->T0, s->A0);
             }
         } else {
             gen_op_mov_v_reg(s, ot, s->T0, rm);
         }
 
         switch(op) {
         case 0: /* test */
             val = insn_get(env, s, ot);
             tcg_gen_movi_tl(s->T1, val);
             gen_op_testl_T0_T1_cc(s);
             set_cc_op(s, CC_OP_LOGICB + ot);
             break;
         case 2: /* not */
             if (s->prefix & PREFIX_LOCK) {
                 if (mod == 3) {
                     goto illegal_op;
                 }
                 tcg_gen_movi_tl(s->T0, ~0);
                 tcg_gen_atomic_xor_fetch_tl(s->T0, s->A0, s->T0,
                                             s->mem_index, ot | MO_LE);
             } else {
                 tcg_gen_not_tl(s->T0, s->T0);
                 if (mod != 3) {
                     gen_op_st_v(s, ot, s->T0, s->A0);
                 } else {
                     gen_op_mov_reg_v(s, ot, rm, s->T0);
                 }
             }
             break;
         case 3: /* neg */
             if (s->prefix & PREFIX_LOCK) {
                 TCGLabel *label1;
                 TCGv a0, t0, t1, t2;
 
                 if (mod == 3) {
                     goto illegal_op;
                 }
                 a0 = s->A0;
                 t0 = s->T0;
                 label1 = gen_new_label();
 
                 gen_set_label(label1);
                 t1 = tcg_temp_new();
                 t2 = tcg_temp_new();
                 tcg_gen_mov_tl(t2, t0);
                 tcg_gen_neg_tl(t1, t0);
                 tcg_gen_atomic_cmpxchg_tl(t0, a0, t0, t1,
                                           s->mem_index, ot | MO_LE);
                 tcg_gen_brcond_tl(TCG_COND_NE, t0, t2, label1);
 
                 tcg_gen_neg_tl(s->T0, t0);
             } else {
                 tcg_gen_neg_tl(s->T0, s->T0);
                 if (mod != 3) {
                     gen_op_st_v(s, ot, s->T0, s->A0);
                 } else {
                     gen_op_mov_reg_v(s, ot, rm, s->T0);
                 }
             }
             gen_op_update_neg_cc(s);
             set_cc_op(s, CC_OP_SUBB + ot);
             break;
         case 4: /* mul */
             switch(ot) {
             case MO_8:
                 gen_op_mov_v_reg(s, MO_8, s->T1, R_EAX);
                 tcg_gen_ext8u_tl(s->T0, s->T0);
                 tcg_gen_ext8u_tl(s->T1, s->T1);
                 /* XXX: use 32 bit mul which could be faster */
                 tcg_gen_mul_tl(s->T0, s->T0, s->T1);
                 gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
                 tcg_gen_mov_tl(cpu_cc_dst, s->T0);
                 tcg_gen_andi_tl(cpu_cc_src, s->T0, 0xff00);
                 set_cc_op(s, CC_OP_MULB);
                 break;
             case MO_16:
                 gen_op_mov_v_reg(s, MO_16, s->T1, R_EAX);
                 tcg_gen_ext16u_tl(s->T0, s->T0);
                 tcg_gen_ext16u_tl(s->T1, s->T1);
                 /* XXX: use 32 bit mul which could be faster */
                 tcg_gen_mul_tl(s->T0, s->T0, s->T1);
                 gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
                 tcg_gen_mov_tl(cpu_cc_dst, s->T0);
                 tcg_gen_shri_tl(s->T0, s->T0, 16);
                 gen_op_mov_reg_v(s, MO_16, R_EDX, s->T0);
                 tcg_gen_mov_tl(cpu_cc_src, s->T0);
                 set_cc_op(s, CC_OP_MULW);
                 break;
             default:
             case MO_32:
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 tcg_gen_trunc_tl_i32(s->tmp3_i32, cpu_regs[R_EAX]);
                 tcg_gen_mulu2_i32(s->tmp2_i32, s->tmp3_i32,
                                   s->tmp2_i32, s->tmp3_i32);
                 tcg_gen_extu_i32_tl(cpu_regs[R_EAX], s->tmp2_i32);
                 tcg_gen_extu_i32_tl(cpu_regs[R_EDX], s->tmp3_i32);
                 tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[R_EAX]);
                 tcg_gen_mov_tl(cpu_cc_src, cpu_regs[R_EDX]);
                 set_cc_op(s, CC_OP_MULL);
                 break;
 #ifdef TARGET_X86_64
             case MO_64:
                 tcg_gen_mulu2_i64(cpu_regs[R_EAX], cpu_regs[R_EDX],
                                   s->T0, cpu_regs[R_EAX]);
                 tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[R_EAX]);
                 tcg_gen_mov_tl(cpu_cc_src, cpu_regs[R_EDX]);
                 set_cc_op(s, CC_OP_MULQ);
                 break;
 #endif
             }
             break;
         case 5: /* imul */
             switch(ot) {
             case MO_8:
                 gen_op_mov_v_reg(s, MO_8, s->T1, R_EAX);
                 tcg_gen_ext8s_tl(s->T0, s->T0);
                 tcg_gen_ext8s_tl(s->T1, s->T1);
                 /* XXX: use 32 bit mul which could be faster */
                 tcg_gen_mul_tl(s->T0, s->T0, s->T1);
                 gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
                 tcg_gen_mov_tl(cpu_cc_dst, s->T0);
                 tcg_gen_ext8s_tl(s->tmp0, s->T0);
                 tcg_gen_sub_tl(cpu_cc_src, s->T0, s->tmp0);
                 set_cc_op(s, CC_OP_MULB);
                 break;
             case MO_16:
                 gen_op_mov_v_reg(s, MO_16, s->T1, R_EAX);
                 tcg_gen_ext16s_tl(s->T0, s->T0);
                 tcg_gen_ext16s_tl(s->T1, s->T1);
                 /* XXX: use 32 bit mul which could be faster */
                 tcg_gen_mul_tl(s->T0, s->T0, s->T1);
                 gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
                 tcg_gen_mov_tl(cpu_cc_dst, s->T0);
                 tcg_gen_ext16s_tl(s->tmp0, s->T0);
                 tcg_gen_sub_tl(cpu_cc_src, s->T0, s->tmp0);
                 tcg_gen_shri_tl(s->T0, s->T0, 16);
                 gen_op_mov_reg_v(s, MO_16, R_EDX, s->T0);
                 set_cc_op(s, CC_OP_MULW);
                 break;
             default:
             case MO_32:
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 tcg_gen_trunc_tl_i32(s->tmp3_i32, cpu_regs[R_EAX]);
                 tcg_gen_muls2_i32(s->tmp2_i32, s->tmp3_i32,
                                   s->tmp2_i32, s->tmp3_i32);
                 tcg_gen_extu_i32_tl(cpu_regs[R_EAX], s->tmp2_i32);
                 tcg_gen_extu_i32_tl(cpu_regs[R_EDX], s->tmp3_i32);
                 tcg_gen_sari_i32(s->tmp2_i32, s->tmp2_i32, 31);
                 tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[R_EAX]);
                 tcg_gen_sub_i32(s->tmp2_i32, s->tmp2_i32, s->tmp3_i32);
                 tcg_gen_extu_i32_tl(cpu_cc_src, s->tmp2_i32);
                 set_cc_op(s, CC_OP_MULL);
                 break;
 #ifdef TARGET_X86_64
             case MO_64:
                 tcg_gen_muls2_i64(cpu_regs[R_EAX], cpu_regs[R_EDX],
                                   s->T0, cpu_regs[R_EAX]);
                 tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[R_EAX]);
                 tcg_gen_sari_tl(cpu_cc_src, cpu_regs[R_EAX], 63);
                 tcg_gen_sub_tl(cpu_cc_src, cpu_cc_src, cpu_regs[R_EDX]);
                 set_cc_op(s, CC_OP_MULQ);
                 break;
 #endif
             }
             break;
         case 6: /* div */
             switch(ot) {
             case MO_8:
                 gen_helper_divb_AL(tcg_env, s->T0);
                 break;
             case MO_16:
                 gen_helper_divw_AX(tcg_env, s->T0);
                 break;
             default:
             case MO_32:
                 gen_helper_divl_EAX(tcg_env, s->T0);
                 break;
 #ifdef TARGET_X86_64
             case MO_64:
                 gen_helper_divq_EAX(tcg_env, s->T0);
                 break;
 #endif
             }
             break;
         case 7: /* idiv */
             switch(ot) {
             case MO_8:
                 gen_helper_idivb_AL(tcg_env, s->T0);
                 break;
             case MO_16:
                 gen_helper_idivw_AX(tcg_env, s->T0);
                 break;
             default:
             case MO_32:
                 gen_helper_idivl_EAX(tcg_env, s->T0);
                 break;
 #ifdef TARGET_X86_64
             case MO_64:
                 gen_helper_idivq_EAX(tcg_env, s->T0);
                 break;
 #endif
             }
             break;
         default:
             goto unknown_op;
         }
         break;
 
     case 0xfe: /* GRP4 */
     case 0xff: /* GRP5 */
         ot = mo_b_d(b, dflag);
 
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         rm = (modrm & 7) | REX_B(s);
         op = (modrm >> 3) & 7;
         if (op >= 2 && b == 0xfe) {
             goto unknown_op;
         }
         if (CODE64(s)) {
             if (op == 2 || op == 4) {
                 /* operand size for jumps is 64 bit */
                 ot = MO_64;
             } else if (op == 3 || op == 5) {
                 ot = dflag != MO_16 ? MO_32 + REX_W(s) : MO_16;
             } else if (op == 6) {
                 /* default push size is 64 bit */
                 ot = mo_pushpop(s, dflag);
             }
         }
         if (mod != 3) {
             gen_lea_modrm(env, s, modrm);
             if (op >= 2 && op != 3 && op != 5)
                 gen_op_ld_v(s, ot, s->T0, s->A0);
         } else {
             gen_op_mov_v_reg(s, ot, s->T0, rm);
         }
 
         switch(op) {
         case 0: /* inc Ev */
             if (mod != 3)
                 opreg = OR_TMP0;
             else
                 opreg = rm;
             gen_inc(s, ot, opreg, 1);
             break;
         case 1: /* dec Ev */
             if (mod != 3)
                 opreg = OR_TMP0;
             else
                 opreg = rm;
             gen_inc(s, ot, opreg, -1);
             break;
         case 2: /* call Ev */
             /* XXX: optimize if memory (no 'and' is necessary) */
             if (dflag == MO_16) {
                 tcg_gen_ext16u_tl(s->T0, s->T0);
             }
             gen_push_v(s, eip_next_tl(s));
             gen_op_jmp_v(s, s->T0);
             gen_bnd_jmp(s);
             s->base.is_jmp = DISAS_JUMP;
             break;
         case 3: /* lcall Ev */
             if (mod == 3) {
                 goto illegal_op;
             }
             gen_op_ld_v(s, ot, s->T1, s->A0);
             gen_add_A0_im(s, 1 << ot);
             gen_op_ld_v(s, MO_16, s->T0, s->A0);
         do_lcall:
             if (PE(s) && !VM86(s)) {
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_lcall_protected(tcg_env, s->tmp2_i32, s->T1,
                                            tcg_constant_i32(dflag - 1),
                                            eip_next_tl(s));
             } else {
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
                 gen_helper_lcall_real(tcg_env, s->tmp2_i32, s->tmp3_i32,
                                       tcg_constant_i32(dflag - 1),
                                       eip_next_i32(s));
             }
             s->base.is_jmp = DISAS_JUMP;
             break;
         case 4: /* jmp Ev */
             if (dflag == MO_16) {
                 tcg_gen_ext16u_tl(s->T0, s->T0);
             }
             gen_op_jmp_v(s, s->T0);
             gen_bnd_jmp(s);
             s->base.is_jmp = DISAS_JUMP;
             break;
         case 5: /* ljmp Ev */
             if (mod == 3) {
                 goto illegal_op;
             }
             gen_op_ld_v(s, ot, s->T1, s->A0);
             gen_add_A0_im(s, 1 << ot);
             gen_op_ld_v(s, MO_16, s->T0, s->A0);
         do_ljmp:
             if (PE(s) && !VM86(s)) {
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_ljmp_protected(tcg_env, s->tmp2_i32, s->T1,
                                           eip_next_tl(s));
             } else {
                 gen_op_movl_seg_T0_vm(s, R_CS);
                 gen_op_jmp_v(s, s->T1);
             }
             s->base.is_jmp = DISAS_JUMP;
             break;
         case 6: /* push Ev */
             gen_push_v(s, s->T0);
             break;
         default:
             goto unknown_op;
         }
         break;
 
     case 0x84: /* test Ev, Gv */
     case 0x85:
         ot = mo_b_d(b, dflag);
 
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
 
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
         gen_op_mov_v_reg(s, ot, s->T1, reg);
         gen_op_testl_T0_T1_cc(s);
         set_cc_op(s, CC_OP_LOGICB + ot);
         break;
 
     case 0xa8: /* test eAX, Iv */
     case 0xa9:
         ot = mo_b_d(b, dflag);
         val = insn_get(env, s, ot);
 
         gen_op_mov_v_reg(s, ot, s->T0, OR_EAX);
         tcg_gen_movi_tl(s->T1, val);
         gen_op_testl_T0_T1_cc(s);
         set_cc_op(s, CC_OP_LOGICB + ot);
         break;
 
     case 0x98: /* CWDE/CBW */
         switch (dflag) {
 #ifdef TARGET_X86_64
         case MO_64:
             gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
             tcg_gen_ext32s_tl(s->T0, s->T0);
             gen_op_mov_reg_v(s, MO_64, R_EAX, s->T0);
             break;
 #endif
         case MO_32:
             gen_op_mov_v_reg(s, MO_16, s->T0, R_EAX);
             tcg_gen_ext16s_tl(s->T0, s->T0);
             gen_op_mov_reg_v(s, MO_32, R_EAX, s->T0);
             break;
         case MO_16:
             gen_op_mov_v_reg(s, MO_8, s->T0, R_EAX);
             tcg_gen_ext8s_tl(s->T0, s->T0);
             gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
             break;
         default:
             g_assert_not_reached();
         }
         break;
     case 0x99: /* CDQ/CWD */
         switch (dflag) {
 #ifdef TARGET_X86_64
         case MO_64:
             gen_op_mov_v_reg(s, MO_64, s->T0, R_EAX);
             tcg_gen_sari_tl(s->T0, s->T0, 63);
             gen_op_mov_reg_v(s, MO_64, R_EDX, s->T0);
             break;
 #endif
         case MO_32:
             gen_op_mov_v_reg(s, MO_32, s->T0, R_EAX);
             tcg_gen_ext32s_tl(s->T0, s->T0);
             tcg_gen_sari_tl(s->T0, s->T0, 31);
             gen_op_mov_reg_v(s, MO_32, R_EDX, s->T0);
             break;
         case MO_16:
             gen_op_mov_v_reg(s, MO_16, s->T0, R_EAX);
             tcg_gen_ext16s_tl(s->T0, s->T0);
             tcg_gen_sari_tl(s->T0, s->T0, 15);
             gen_op_mov_reg_v(s, MO_16, R_EDX, s->T0);
             break;
         default:
             g_assert_not_reached();
         }
         break;
     case 0x1af: /* imul Gv, Ev */
     case 0x69: /* imul Gv, Ev, I */
     case 0x6b:
         ot = dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         if (b == 0x69)
             s->rip_offset = insn_const_size(ot);
         else if (b == 0x6b)
             s->rip_offset = 1;
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
         if (b == 0x69) {
             val = insn_get(env, s, ot);
             tcg_gen_movi_tl(s->T1, val);
         } else if (b == 0x6b) {
             val = (int8_t)insn_get(env, s, MO_8);
             tcg_gen_movi_tl(s->T1, val);
         } else {
             gen_op_mov_v_reg(s, ot, s->T1, reg);
         }
         switch (ot) {
 #ifdef TARGET_X86_64
         case MO_64:
             tcg_gen_muls2_i64(cpu_regs[reg], s->T1, s->T0, s->T1);
             tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[reg]);
             tcg_gen_sari_tl(cpu_cc_src, cpu_cc_dst, 63);
             tcg_gen_sub_tl(cpu_cc_src, cpu_cc_src, s->T1);
             break;
 #endif
         case MO_32:
             tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
             tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
             tcg_gen_muls2_i32(s->tmp2_i32, s->tmp3_i32,
                               s->tmp2_i32, s->tmp3_i32);
             tcg_gen_extu_i32_tl(cpu_regs[reg], s->tmp2_i32);
             tcg_gen_sari_i32(s->tmp2_i32, s->tmp2_i32, 31);
             tcg_gen_mov_tl(cpu_cc_dst, cpu_regs[reg]);
             tcg_gen_sub_i32(s->tmp2_i32, s->tmp2_i32, s->tmp3_i32);
             tcg_gen_extu_i32_tl(cpu_cc_src, s->tmp2_i32);
             break;
         default:
             tcg_gen_ext16s_tl(s->T0, s->T0);
             tcg_gen_ext16s_tl(s->T1, s->T1);
             /* XXX: use 32 bit mul which could be faster */
             tcg_gen_mul_tl(s->T0, s->T0, s->T1);
             tcg_gen_mov_tl(cpu_cc_dst, s->T0);
             tcg_gen_ext16s_tl(s->tmp0, s->T0);
             tcg_gen_sub_tl(cpu_cc_src, s->T0, s->tmp0);
             gen_op_mov_reg_v(s, ot, reg, s->T0);
             break;
         }
         set_cc_op(s, CC_OP_MULB + ot);
         break;
     case 0x1c0:
     case 0x1c1: /* xadd Ev, Gv */
         ot = mo_b_d(b, dflag);
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
         gen_op_mov_v_reg(s, ot, s->T0, reg);
         if (mod == 3) {
             rm = (modrm & 7) | REX_B(s);
             gen_op_mov_v_reg(s, ot, s->T1, rm);
             tcg_gen_add_tl(s->T0, s->T0, s->T1);
             gen_op_mov_reg_v(s, ot, reg, s->T1);
             gen_op_mov_reg_v(s, ot, rm, s->T0);
         } else {
             gen_lea_modrm(env, s, modrm);
             if (s->prefix & PREFIX_LOCK) {
                 tcg_gen_atomic_fetch_add_tl(s->T1, s->A0, s->T0,
                                             s->mem_index, ot | MO_LE);
                 tcg_gen_add_tl(s->T0, s->T0, s->T1);
             } else {
                 gen_op_ld_v(s, ot, s->T1, s->A0);
                 tcg_gen_add_tl(s->T0, s->T0, s->T1);
                 gen_op_st_v(s, ot, s->T0, s->A0);
             }
             gen_op_mov_reg_v(s, ot, reg, s->T1);
         }
         gen_op_update2_cc(s);
         set_cc_op(s, CC_OP_ADDB + ot);
         break;
     case 0x1b0:
     case 0x1b1: /* cmpxchg Ev, Gv */
         {
             TCGv oldv, newv, cmpv, dest;
 
             ot = mo_b_d(b, dflag);
             modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | REX_R(s);
             mod = (modrm >> 6) & 3;
             oldv = tcg_temp_new();
             newv = tcg_temp_new();
             cmpv = tcg_temp_new();
             gen_op_mov_v_reg(s, ot, newv, reg);
             tcg_gen_mov_tl(cmpv, cpu_regs[R_EAX]);
             gen_extu(ot, cmpv);
             if (s->prefix & PREFIX_LOCK) {
                 if (mod == 3) {
                     goto illegal_op;
                 }
                 gen_lea_modrm(env, s, modrm);
                 tcg_gen_atomic_cmpxchg_tl(oldv, s->A0, cmpv, newv,
                                           s->mem_index, ot | MO_LE);
             } else {
                 if (mod == 3) {
                     rm = (modrm & 7) | REX_B(s);
                     gen_op_mov_v_reg(s, ot, oldv, rm);
                     gen_extu(ot, oldv);
 
                     /*
                      * Unlike the memory case, where "the destination operand receives
                      * a write cycle without regard to the result of the comparison",
                      * rm must not be touched altogether if the write fails, including
                      * not zero-extending it on 64-bit processors.  So, precompute
                      * the result of a successful writeback and perform the movcond
                      * directly on cpu_regs.  Also need to write accumulator first, in
                      * case rm is part of RAX too.
                      */
                     dest = gen_op_deposit_reg_v(s, ot, rm, newv, newv);
                     tcg_gen_movcond_tl(TCG_COND_EQ, dest, oldv, cmpv, newv, dest);
                 } else {
                     gen_lea_modrm(env, s, modrm);
                     gen_op_ld_v(s, ot, oldv, s->A0);
 
                     /*
                      * Perform an unconditional store cycle like physical cpu;
                      * must be before changing accumulator to ensure
                      * idempotency if the store faults and the instruction
                      * is restarted
                      */
                     tcg_gen_movcond_tl(TCG_COND_EQ, newv, oldv, cmpv, newv, oldv);
                     gen_op_st_v(s, ot, newv, s->A0);
                 }
             }
 	    /*
 	     * Write EAX only if the cmpxchg fails; reuse newv as the destination,
 	     * since it's dead here.
 	     */
             dest = gen_op_deposit_reg_v(s, ot, R_EAX, newv, oldv);
             tcg_gen_movcond_tl(TCG_COND_EQ, dest, oldv, cmpv, dest, newv);
             tcg_gen_mov_tl(cpu_cc_src, oldv);
             tcg_gen_mov_tl(s->cc_srcT, cmpv);
             tcg_gen_sub_tl(cpu_cc_dst, cmpv, oldv);
             set_cc_op(s, CC_OP_SUBB + ot);
         }
         break;
     case 0x1c7: /* cmpxchg8b */
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         switch ((modrm >> 3) & 7) {
         case 1: /* CMPXCHG8, CMPXCHG16 */
             if (mod == 3) {
                 goto illegal_op;
             }
 #ifdef TARGET_X86_64
             if (dflag == MO_64) {
                 if (!(s->cpuid_ext_features & CPUID_EXT_CX16)) {
                     goto illegal_op;
                 }
                 gen_cmpxchg16b(s, env, modrm);
                 break;
             }
 #endif
             if (!(s->cpuid_features & CPUID_CX8)) {
                 goto illegal_op;
             }
             gen_cmpxchg8b(s, env, modrm);
             break;
 
         case 7: /* RDSEED, RDPID with f3 prefix */
             if (mod != 3 ||
                 (s->prefix & (PREFIX_LOCK | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             if (s->prefix & PREFIX_REPZ) {
                 if (!(s->cpuid_ext_features & CPUID_7_0_ECX_RDPID)) {
                     goto illegal_op;
                 }
                 gen_helper_rdpid(s->T0, tcg_env);
                 rm = (modrm & 7) | REX_B(s);
                 gen_op_mov_reg_v(s, dflag, rm, s->T0);
                 break;
             } else {
                 if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_RDSEED)) {
                     goto illegal_op;
                 }
                 goto do_rdrand;
             }
 
         case 6: /* RDRAND */
             if (mod != 3 ||
                 (s->prefix & (PREFIX_LOCK | PREFIX_REPZ | PREFIX_REPNZ)) ||
                 !(s->cpuid_ext_features & CPUID_EXT_RDRAND)) {
                 goto illegal_op;
             }
         do_rdrand:
             translator_io_start(&s->base);
             gen_helper_rdrand(s->T0, tcg_env);
             rm = (modrm & 7) | REX_B(s);
             gen_op_mov_reg_v(s, dflag, rm, s->T0);
             set_cc_op(s, CC_OP_EFLAGS);
             break;
 
         default:
             goto illegal_op;
         }
         break;
 
         /**************************/
         /* push/pop */
     case 0x50 ... 0x57: /* push */
         gen_op_mov_v_reg(s, MO_32, s->T0, (b & 7) | REX_B(s));
         gen_push_v(s, s->T0);
         break;
     case 0x58 ... 0x5f: /* pop */
         ot = gen_pop_T0(s);
         /* NOTE: order is important for pop %sp */
         gen_pop_update(s, ot);
         gen_op_mov_reg_v(s, ot, (b & 7) | REX_B(s), s->T0);
         break;
     case 0x60: /* pusha */
         if (CODE64(s))
             goto illegal_op;
         gen_pusha(s);
         break;
     case 0x61: /* popa */
         if (CODE64(s))
             goto illegal_op;
         gen_popa(s);
         break;
     case 0x68: /* push Iv */
     case 0x6a:
         ot = mo_pushpop(s, dflag);
         if (b == 0x68)
             val = insn_get(env, s, ot);
         else
             val = (int8_t)insn_get(env, s, MO_8);
         tcg_gen_movi_tl(s->T0, val);
         gen_push_v(s, s->T0);
         break;
     case 0x8f: /* pop Ev */
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         ot = gen_pop_T0(s);
         if (mod == 3) {
             /* NOTE: order is important for pop %sp */
             gen_pop_update(s, ot);
             rm = (modrm & 7) | REX_B(s);
             gen_op_mov_reg_v(s, ot, rm, s->T0);
         } else {
             /* NOTE: order is important too for MMU exceptions */
             s->popl_esp_hack = 1 << ot;
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
             s->popl_esp_hack = 0;
             gen_pop_update(s, ot);
         }
         break;
     case 0xc8: /* enter */
         {
             int level;
             val = x86_lduw_code(env, s);
             level = x86_ldub_code(env, s);
             gen_enter(s, val, level);
         }
         break;
     case 0xc9: /* leave */
         gen_leave(s);
         break;
     case 0x06: /* push es */
     case 0x0e: /* push cs */
     case 0x16: /* push ss */
     case 0x1e: /* push ds */
         if (CODE64(s))
             goto illegal_op;
         gen_op_movl_T0_seg(s, b >> 3);
         gen_push_v(s, s->T0);
         break;
     case 0x1a0: /* push fs */
     case 0x1a8: /* push gs */
         gen_op_movl_T0_seg(s, (b >> 3) & 7);
         gen_push_v(s, s->T0);
         break;
     case 0x07: /* pop es */
     case 0x17: /* pop ss */
     case 0x1f: /* pop ds */
         if (CODE64(s))
             goto illegal_op;
         reg = b >> 3;
         ot = gen_pop_T0(s);
         gen_movl_seg_T0(s, reg);
         gen_pop_update(s, ot);
         break;
     case 0x1a1: /* pop fs */
     case 0x1a9: /* pop gs */
         ot = gen_pop_T0(s);
         gen_movl_seg_T0(s, (b >> 3) & 7);
         gen_pop_update(s, ot);
         break;
 
         /**************************/
         /* mov */
     case 0x88:
     case 0x89: /* mov Gv, Ev */
         ot = mo_b_d(b, dflag);
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
 
         /* generate a generic store */
         gen_ldst_modrm(env, s, modrm, ot, reg, 1);
         break;
     case 0xc6:
     case 0xc7: /* mov Ev, Iv */
         ot = mo_b_d(b, dflag);
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         if (mod != 3) {
             s->rip_offset = insn_const_size(ot);
             gen_lea_modrm(env, s, modrm);
         }
         val = insn_get(env, s, ot);
         tcg_gen_movi_tl(s->T0, val);
         if (mod != 3) {
             gen_op_st_v(s, ot, s->T0, s->A0);
         } else {
             gen_op_mov_reg_v(s, ot, (modrm & 7) | REX_B(s), s->T0);
         }
         break;
     case 0x8a:
     case 0x8b: /* mov Ev, Gv */
         ot = mo_b_d(b, dflag);
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
 
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
         gen_op_mov_reg_v(s, ot, reg, s->T0);
         break;
     case 0x8e: /* mov seg, Gv */
         modrm = x86_ldub_code(env, s);
         reg = (modrm >> 3) & 7;
         if (reg >= 6 || reg == R_CS)
             goto illegal_op;
         gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
         gen_movl_seg_T0(s, reg);
         break;
     case 0x8c: /* mov Gv, seg */
         modrm = x86_ldub_code(env, s);
         reg = (modrm >> 3) & 7;
         mod = (modrm >> 6) & 3;
         if (reg >= 6)
             goto illegal_op;
         gen_op_movl_T0_seg(s, reg);
         ot = mod == 3 ? dflag : MO_16;
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
         break;
 
     case 0x1b6: /* movzbS Gv, Eb */
     case 0x1b7: /* movzwS Gv, Eb */
     case 0x1be: /* movsbS Gv, Eb */
     case 0x1bf: /* movswS Gv, Eb */
         {
             MemOp d_ot;
             MemOp s_ot;
 
             /* d_ot is the size of destination */
             d_ot = dflag;
             /* ot is the size of source */
             ot = (b & 1) + MO_8;
             /* s_ot is the sign+size of source */
             s_ot = b & 8 ? MO_SIGN | ot : ot;
 
             modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | REX_R(s);
             mod = (modrm >> 6) & 3;
             rm = (modrm & 7) | REX_B(s);
 
             if (mod == 3) {
                 if (s_ot == MO_SB && byte_reg_is_xH(s, rm)) {
                     tcg_gen_sextract_tl(s->T0, cpu_regs[rm - 4], 8, 8);
                 } else {
                     gen_op_mov_v_reg(s, ot, s->T0, rm);
                     switch (s_ot) {
                     case MO_UB:
                         tcg_gen_ext8u_tl(s->T0, s->T0);
                         break;
                     case MO_SB:
                         tcg_gen_ext8s_tl(s->T0, s->T0);
                         break;
                     case MO_UW:
                         tcg_gen_ext16u_tl(s->T0, s->T0);
                         break;
                     default:
                     case MO_SW:
                         tcg_gen_ext16s_tl(s->T0, s->T0);
                         break;
                     }
                 }
                 gen_op_mov_reg_v(s, d_ot, reg, s->T0);
             } else {
                 gen_lea_modrm(env, s, modrm);
                 gen_op_ld_v(s, s_ot, s->T0, s->A0);
                 gen_op_mov_reg_v(s, d_ot, reg, s->T0);
             }
         }
         break;
 
     case 0x8d: /* lea */
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         if (mod == 3)
             goto illegal_op;
         reg = ((modrm >> 3) & 7) | REX_R(s);
         {
             AddressParts a = gen_lea_modrm_0(env, s, modrm);
             TCGv ea = gen_lea_modrm_1(s, a, false);
             gen_lea_v_seg(s, s->aflag, ea, -1, -1);
             gen_op_mov_reg_v(s, dflag, reg, s->A0);
         }
         break;
 
     case 0xa0: /* mov EAX, Ov */
     case 0xa1:
     case 0xa2: /* mov Ov, EAX */
     case 0xa3:
         {
             target_ulong offset_addr;
 
             ot = mo_b_d(b, dflag);
             offset_addr = insn_get_addr(env, s, s->aflag);
             tcg_gen_movi_tl(s->A0, offset_addr);
             gen_add_A0_ds_seg(s);
             if ((b & 2) == 0) {
                 gen_op_ld_v(s, ot, s->T0, s->A0);
                 gen_op_mov_reg_v(s, ot, R_EAX, s->T0);
             } else {
                 gen_op_mov_v_reg(s, ot, s->T0, R_EAX);
                 gen_op_st_v(s, ot, s->T0, s->A0);
             }
         }
         break;
     case 0xd7: /* xlat */
         tcg_gen_mov_tl(s->A0, cpu_regs[R_EBX]);
         tcg_gen_ext8u_tl(s->T0, cpu_regs[R_EAX]);
         tcg_gen_add_tl(s->A0, s->A0, s->T0);
         gen_extu(s->aflag, s->A0);
         gen_add_A0_ds_seg(s);
         gen_op_ld_v(s, MO_8, s->T0, s->A0);
         gen_op_mov_reg_v(s, MO_8, R_EAX, s->T0);
         break;
     case 0xb0 ... 0xb7: /* mov R, Ib */
         val = insn_get(env, s, MO_8);
         tcg_gen_movi_tl(s->T0, val);
         gen_op_mov_reg_v(s, MO_8, (b & 7) | REX_B(s), s->T0);
         break;
     case 0xb8 ... 0xbf: /* mov R, Iv */
 #ifdef TARGET_X86_64
         if (dflag == MO_64) {
             uint64_t tmp;
             /* 64 bit case */
             tmp = x86_ldq_code(env, s);
             reg = (b & 7) | REX_B(s);
             tcg_gen_movi_tl(s->T0, tmp);
             gen_op_mov_reg_v(s, MO_64, reg, s->T0);
         } else
 #endif
         {
             ot = dflag;
             val = insn_get(env, s, ot);
             reg = (b & 7) | REX_B(s);
             tcg_gen_movi_tl(s->T0, val);
             gen_op_mov_reg_v(s, ot, reg, s->T0);
         }
         break;
 
     case 0x91 ... 0x97: /* xchg R, EAX */
     do_xchg_reg_eax:
         ot = dflag;
         reg = (b & 7) | REX_B(s);
         rm = R_EAX;
         goto do_xchg_reg;
     case 0x86:
     case 0x87: /* xchg Ev, Gv */
         ot = mo_b_d(b, dflag);
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
         if (mod == 3) {
             rm = (modrm & 7) | REX_B(s);
         do_xchg_reg:
             gen_op_mov_v_reg(s, ot, s->T0, reg);
             gen_op_mov_v_reg(s, ot, s->T1, rm);
             gen_op_mov_reg_v(s, ot, rm, s->T0);
             gen_op_mov_reg_v(s, ot, reg, s->T1);
         } else {
             gen_lea_modrm(env, s, modrm);
             gen_op_mov_v_reg(s, ot, s->T0, reg);
             /* for xchg, lock is implicit */
             tcg_gen_atomic_xchg_tl(s->T1, s->A0, s->T0,
                                    s->mem_index, ot | MO_LE);
             gen_op_mov_reg_v(s, ot, reg, s->T1);
         }
         break;
     case 0xc4: /* les Gv */
         /* In CODE64 this is VEX3; see above.  */
         op = R_ES;
         goto do_lxx;
     case 0xc5: /* lds Gv */
         /* In CODE64 this is VEX2; see above.  */
         op = R_DS;
         goto do_lxx;
     case 0x1b2: /* lss Gv */
         op = R_SS;
         goto do_lxx;
     case 0x1b4: /* lfs Gv */
         op = R_FS;
         goto do_lxx;
     case 0x1b5: /* lgs Gv */
         op = R_GS;
     do_lxx:
         ot = dflag != MO_16 ? MO_32 : MO_16;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
         if (mod == 3)
             goto illegal_op;
         gen_lea_modrm(env, s, modrm);
         gen_op_ld_v(s, ot, s->T1, s->A0);
         gen_add_A0_im(s, 1 << ot);
         /* load the segment first to handle exceptions properly */
         gen_op_ld_v(s, MO_16, s->T0, s->A0);
         gen_movl_seg_T0(s, op);
         /* then put the data */
         gen_op_mov_reg_v(s, ot, reg, s->T1);
         break;
 
         /************************/
         /* shifts */
     case 0xc0:
     case 0xc1:
         /* shift Ev,Ib */
         shift = 2;
     grp2:
         {
             ot = mo_b_d(b, dflag);
             modrm = x86_ldub_code(env, s);
             mod = (modrm >> 6) & 3;
             op = (modrm >> 3) & 7;
 
             if (mod != 3) {
                 if (shift == 2) {
                     s->rip_offset = 1;
                 }
                 gen_lea_modrm(env, s, modrm);
                 opreg = OR_TMP0;
             } else {
                 opreg = (modrm & 7) | REX_B(s);
             }
 
             /* simpler op */
             if (shift == 0) {
                 gen_shift(s, op, ot, opreg, OR_ECX);
             } else {
                 if (shift == 2) {
                     shift = x86_ldub_code(env, s);
                 }
                 gen_shifti(s, op, ot, opreg, shift);
             }
         }
         break;
     case 0xd0:
     case 0xd1:
         /* shift Ev,1 */
         shift = 1;
         goto grp2;
     case 0xd2:
     case 0xd3:
         /* shift Ev,cl */
         shift = 0;
         goto grp2;
 
     case 0x1a4: /* shld imm */
         op = 0;
         shift = 1;
         goto do_shiftd;
     case 0x1a5: /* shld cl */
         op = 0;
         shift = 0;
         goto do_shiftd;
     case 0x1ac: /* shrd imm */
         op = 1;
         shift = 1;
         goto do_shiftd;
     case 0x1ad: /* shrd cl */
         op = 1;
         shift = 0;
     do_shiftd:
         ot = dflag;
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         rm = (modrm & 7) | REX_B(s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         if (mod != 3) {
             gen_lea_modrm(env, s, modrm);
             opreg = OR_TMP0;
         } else {
             opreg = rm;
         }
         gen_op_mov_v_reg(s, ot, s->T1, reg);
 
         if (shift) {
             TCGv imm = tcg_constant_tl(x86_ldub_code(env, s));
             gen_shiftd_rm_T1(s, ot, opreg, op, imm);
         } else {
             gen_shiftd_rm_T1(s, ot, opreg, op, cpu_regs[R_ECX]);
         }
         break;
 
         /************************/
         /* floats */
     case 0xd8 ... 0xdf:
         {
             bool update_fip = true;
 
             if (s->flags & (HF_EM_MASK | HF_TS_MASK)) {
                 /* if CR0.EM or CR0.TS are set, generate an FPU exception */
                 /* XXX: what to do if illegal op ? */
                 gen_exception(s, EXCP07_PREX);
                 break;
             }
             modrm = x86_ldub_code(env, s);
             mod = (modrm >> 6) & 3;
             rm = modrm & 7;
             op = ((b & 7) << 3) | ((modrm >> 3) & 7);
             if (mod != 3) {
                 /* memory op */
                 AddressParts a = gen_lea_modrm_0(env, s, modrm);
                 TCGv ea = gen_lea_modrm_1(s, a, false);
                 TCGv last_addr = tcg_temp_new();
                 bool update_fdp = true;
 
                 tcg_gen_mov_tl(last_addr, ea);
                 gen_lea_v_seg(s, s->aflag, ea, a.def_seg, s->override);
 
                 switch (op) {
                 case 0x00 ... 0x07: /* fxxxs */
                 case 0x10 ... 0x17: /* fixxxl */
                 case 0x20 ... 0x27: /* fxxxl */
                 case 0x30 ... 0x37: /* fixxx */
                     {
                         int op1;
                         op1 = op & 7;
 
                         switch (op >> 4) {
                         case 0:
                             tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                                 s->mem_index, MO_LEUL);
                             gen_helper_flds_FT0(tcg_env, s->tmp2_i32);
                             break;
                         case 1:
                             tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                                 s->mem_index, MO_LEUL);
                             gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
                             break;
                         case 2:
                             tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
                                                 s->mem_index, MO_LEUQ);
                             gen_helper_fldl_FT0(tcg_env, s->tmp1_i64);
                             break;
                         case 3:
                         default:
                             tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                                 s->mem_index, MO_LESW);
                             gen_helper_fildl_FT0(tcg_env, s->tmp2_i32);
                             break;
                         }
 
                         gen_helper_fp_arith_ST0_FT0(op1);
                         if (op1 == 3) {
                             /* fcomp needs pop */
                             gen_helper_fpop(tcg_env);
                         }
                     }
                     break;
                 case 0x08: /* flds */
                 case 0x0a: /* fsts */
                 case 0x0b: /* fstps */
                 case 0x18 ... 0x1b: /* fildl, fisttpl, fistl, fistpl */
                 case 0x28 ... 0x2b: /* fldl, fisttpll, fstl, fstpl */
                 case 0x38 ... 0x3b: /* filds, fisttps, fists, fistps */
                     switch (op & 7) {
                     case 0:
                         switch (op >> 4) {
                         case 0:
                             tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                                 s->mem_index, MO_LEUL);
                             gen_helper_flds_ST0(tcg_env, s->tmp2_i32);
                             break;
                         case 1:
                             tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                                 s->mem_index, MO_LEUL);
                             gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
                             break;
                         case 2:
                             tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
                                                 s->mem_index, MO_LEUQ);
                             gen_helper_fldl_ST0(tcg_env, s->tmp1_i64);
                             break;
                         case 3:
                         default:
                             tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                                 s->mem_index, MO_LESW);
                             gen_helper_fildl_ST0(tcg_env, s->tmp2_i32);
                             break;
                         }
                         break;
                     case 1:
                         /* XXX: the corresponding CPUID bit must be tested ! */
                         switch (op >> 4) {
                         case 1:
                             gen_helper_fisttl_ST0(s->tmp2_i32, tcg_env);
                             tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
                                                 s->mem_index, MO_LEUL);
                             break;
                         case 2:
                             gen_helper_fisttll_ST0(s->tmp1_i64, tcg_env);
                             tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
                                                 s->mem_index, MO_LEUQ);
                             break;
                         case 3:
                         default:
                             gen_helper_fistt_ST0(s->tmp2_i32, tcg_env);
                             tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
                                                 s->mem_index, MO_LEUW);
                             break;
                         }
                         gen_helper_fpop(tcg_env);
                         break;
                     default:
                         switch (op >> 4) {
                         case 0:
                             gen_helper_fsts_ST0(s->tmp2_i32, tcg_env);
                             tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
                                                 s->mem_index, MO_LEUL);
                             break;
                         case 1:
                             gen_helper_fistl_ST0(s->tmp2_i32, tcg_env);
                             tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
                                                 s->mem_index, MO_LEUL);
                             break;
                         case 2:
                             gen_helper_fstl_ST0(s->tmp1_i64, tcg_env);
                             tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
                                                 s->mem_index, MO_LEUQ);
                             break;
                         case 3:
                         default:
                             gen_helper_fist_ST0(s->tmp2_i32, tcg_env);
                             tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
                                                 s->mem_index, MO_LEUW);
                             break;
                         }
                         if ((op & 7) == 3) {
                             gen_helper_fpop(tcg_env);
                         }
                         break;
                     }
                     break;
                 case 0x0c: /* fldenv mem */
                     gen_helper_fldenv(tcg_env, s->A0,
                                       tcg_constant_i32(dflag - 1));
                     update_fip = update_fdp = false;
                     break;
                 case 0x0d: /* fldcw mem */
                     tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0,
                                         s->mem_index, MO_LEUW);
                     gen_helper_fldcw(tcg_env, s->tmp2_i32);
                     update_fip = update_fdp = false;
                     break;
                 case 0x0e: /* fnstenv mem */
                     gen_helper_fstenv(tcg_env, s->A0,
                                       tcg_constant_i32(dflag - 1));
                     update_fip = update_fdp = false;
                     break;
                 case 0x0f: /* fnstcw mem */
                     gen_helper_fnstcw(s->tmp2_i32, tcg_env);
                     tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
                                         s->mem_index, MO_LEUW);
                     update_fip = update_fdp = false;
                     break;
                 case 0x1d: /* fldt mem */
                     gen_helper_fldt_ST0(tcg_env, s->A0);
                     break;
                 case 0x1f: /* fstpt mem */
                     gen_helper_fstt_ST0(tcg_env, s->A0);
                     gen_helper_fpop(tcg_env);
                     break;
                 case 0x2c: /* frstor mem */
                     gen_helper_frstor(tcg_env, s->A0,
                                       tcg_constant_i32(dflag - 1));
                     update_fip = update_fdp = false;
                     break;
                 case 0x2e: /* fnsave mem */
                     gen_helper_fsave(tcg_env, s->A0,
                                      tcg_constant_i32(dflag - 1));
                     update_fip = update_fdp = false;
                     break;
                 case 0x2f: /* fnstsw mem */
                     gen_helper_fnstsw(s->tmp2_i32, tcg_env);
                     tcg_gen_qemu_st_i32(s->tmp2_i32, s->A0,
                                         s->mem_index, MO_LEUW);
                     update_fip = update_fdp = false;
                     break;
                 case 0x3c: /* fbld */
                     gen_helper_fbld_ST0(tcg_env, s->A0);
                     break;
                 case 0x3e: /* fbstp */
                     gen_helper_fbst_ST0(tcg_env, s->A0);
                     gen_helper_fpop(tcg_env);
                     break;
                 case 0x3d: /* fildll */
                     tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0,
                                         s->mem_index, MO_LEUQ);
                     gen_helper_fildll_ST0(tcg_env, s->tmp1_i64);
                     break;
                 case 0x3f: /* fistpll */
                     gen_helper_fistll_ST0(s->tmp1_i64, tcg_env);
                     tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0,
                                         s->mem_index, MO_LEUQ);
                     gen_helper_fpop(tcg_env);
                     break;
                 default:
                     goto unknown_op;
                 }
 
                 if (update_fdp) {
                     int last_seg = s->override >= 0 ? s->override : a.def_seg;
 
                     tcg_gen_ld_i32(s->tmp2_i32, tcg_env,
                                    offsetof(CPUX86State,
                                             segs[last_seg].selector));
                     tcg_gen_st16_i32(s->tmp2_i32, tcg_env,
                                      offsetof(CPUX86State, fpds));
                     tcg_gen_st_tl(last_addr, tcg_env,
                                   offsetof(CPUX86State, fpdp));
                 }
             } else {
                 /* register float ops */
                 opreg = rm;
 
                 switch (op) {
                 case 0x08: /* fld sti */
                     gen_helper_fpush(tcg_env);
                     gen_helper_fmov_ST0_STN(tcg_env,
                                             tcg_constant_i32((opreg + 1) & 7));
                     break;
                 case 0x09: /* fxchg sti */
                 case 0x29: /* fxchg4 sti, undocumented op */
                 case 0x39: /* fxchg7 sti, undocumented op */
                     gen_helper_fxchg_ST0_STN(tcg_env, tcg_constant_i32(opreg));
                     break;
                 case 0x0a: /* grp d9/2 */
                     switch (rm) {
                     case 0: /* fnop */
                         /*
                          * check exceptions (FreeBSD FPU probe)
                          * needs to be treated as I/O because of ferr_irq
                          */
                         translator_io_start(&s->base);
                         gen_helper_fwait(tcg_env);
                         update_fip = false;
                         break;
                     default:
                         goto unknown_op;
                     }
                     break;
                 case 0x0c: /* grp d9/4 */
                     switch (rm) {
                     case 0: /* fchs */
                         gen_helper_fchs_ST0(tcg_env);
                         break;
                     case 1: /* fabs */
                         gen_helper_fabs_ST0(tcg_env);
                         break;
                     case 4: /* ftst */
                         gen_helper_fldz_FT0(tcg_env);
                         gen_helper_fcom_ST0_FT0(tcg_env);
                         break;
                     case 5: /* fxam */
                         gen_helper_fxam_ST0(tcg_env);
                         break;
                     default:
                         goto unknown_op;
                     }
                     break;
                 case 0x0d: /* grp d9/5 */
                     {
                         switch (rm) {
                         case 0:
                             gen_helper_fpush(tcg_env);
                             gen_helper_fld1_ST0(tcg_env);
                             break;
                         case 1:
                             gen_helper_fpush(tcg_env);
                             gen_helper_fldl2t_ST0(tcg_env);
                             break;
                         case 2:
                             gen_helper_fpush(tcg_env);
                             gen_helper_fldl2e_ST0(tcg_env);
                             break;
                         case 3:
                             gen_helper_fpush(tcg_env);
                             gen_helper_fldpi_ST0(tcg_env);
                             break;
                         case 4:
                             gen_helper_fpush(tcg_env);
                             gen_helper_fldlg2_ST0(tcg_env);
                             break;
                         case 5:
                             gen_helper_fpush(tcg_env);
                             gen_helper_fldln2_ST0(tcg_env);
                             break;
                         case 6:
                             gen_helper_fpush(tcg_env);
                             gen_helper_fldz_ST0(tcg_env);
                             break;
                         default:
                             goto unknown_op;
                         }
                     }
                     break;
                 case 0x0e: /* grp d9/6 */
                     switch (rm) {
                     case 0: /* f2xm1 */
                         gen_helper_f2xm1(tcg_env);
                         break;
                     case 1: /* fyl2x */
                         gen_helper_fyl2x(tcg_env);
                         break;
                     case 2: /* fptan */
                         gen_helper_fptan(tcg_env);
                         break;
                     case 3: /* fpatan */
                         gen_helper_fpatan(tcg_env);
                         break;
                     case 4: /* fxtract */
                         gen_helper_fxtract(tcg_env);
                         break;
                     case 5: /* fprem1 */
                         gen_helper_fprem1(tcg_env);
                         break;
                     case 6: /* fdecstp */
                         gen_helper_fdecstp(tcg_env);
                         break;
                     default:
                     case 7: /* fincstp */
                         gen_helper_fincstp(tcg_env);
                         break;
                     }
                     break;
                 case 0x0f: /* grp d9/7 */
                     switch (rm) {
                     case 0: /* fprem */
                         gen_helper_fprem(tcg_env);
                         break;
                     case 1: /* fyl2xp1 */
                         gen_helper_fyl2xp1(tcg_env);
                         break;
                     case 2: /* fsqrt */
                         gen_helper_fsqrt(tcg_env);
                         break;
                     case 3: /* fsincos */
                         gen_helper_fsincos(tcg_env);
                         break;
                     case 5: /* fscale */
                         gen_helper_fscale(tcg_env);
                         break;
                     case 4: /* frndint */
                         gen_helper_frndint(tcg_env);
                         break;
                     case 6: /* fsin */
                         gen_helper_fsin(tcg_env);
                         break;
                     default:
                     case 7: /* fcos */
                         gen_helper_fcos(tcg_env);
                         break;
                     }
                     break;
                 case 0x00: case 0x01: case 0x04 ... 0x07: /* fxxx st, sti */
                 case 0x20: case 0x21: case 0x24 ... 0x27: /* fxxx sti, st */
                 case 0x30: case 0x31: case 0x34 ... 0x37: /* fxxxp sti, st */
                     {
                         int op1;
 
                         op1 = op & 7;
                         if (op >= 0x20) {
                             gen_helper_fp_arith_STN_ST0(op1, opreg);
                             if (op >= 0x30) {
                                 gen_helper_fpop(tcg_env);
                             }
                         } else {
                             gen_helper_fmov_FT0_STN(tcg_env,
                                                     tcg_constant_i32(opreg));
                             gen_helper_fp_arith_ST0_FT0(op1);
                         }
                     }
                     break;
                 case 0x02: /* fcom */
                 case 0x22: /* fcom2, undocumented op */
                     gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
                     gen_helper_fcom_ST0_FT0(tcg_env);
                     break;
                 case 0x03: /* fcomp */
                 case 0x23: /* fcomp3, undocumented op */
                 case 0x32: /* fcomp5, undocumented op */
                     gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
                     gen_helper_fcom_ST0_FT0(tcg_env);
                     gen_helper_fpop(tcg_env);
                     break;
                 case 0x15: /* da/5 */
                     switch (rm) {
                     case 1: /* fucompp */
                         gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(1));
                         gen_helper_fucom_ST0_FT0(tcg_env);
                         gen_helper_fpop(tcg_env);
                         gen_helper_fpop(tcg_env);
                         break;
                     default:
                         goto unknown_op;
                     }
                     break;
                 case 0x1c:
                     switch (rm) {
                     case 0: /* feni (287 only, just do nop here) */
                         break;
                     case 1: /* fdisi (287 only, just do nop here) */
                         break;
                     case 2: /* fclex */
                         gen_helper_fclex(tcg_env);
                         update_fip = false;
                         break;
                     case 3: /* fninit */
                         gen_helper_fninit(tcg_env);
                         update_fip = false;
                         break;
                     case 4: /* fsetpm (287 only, just do nop here) */
                         break;
                     default:
                         goto unknown_op;
                     }
                     break;
                 case 0x1d: /* fucomi */
                     if (!(s->cpuid_features & CPUID_CMOV)) {
                         goto illegal_op;
                     }
                     gen_update_cc_op(s);
                     gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
                     gen_helper_fucomi_ST0_FT0(tcg_env);
                     set_cc_op(s, CC_OP_EFLAGS);
                     break;
                 case 0x1e: /* fcomi */
                     if (!(s->cpuid_features & CPUID_CMOV)) {
                         goto illegal_op;
                     }
                     gen_update_cc_op(s);
                     gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
                     gen_helper_fcomi_ST0_FT0(tcg_env);
                     set_cc_op(s, CC_OP_EFLAGS);
                     break;
                 case 0x28: /* ffree sti */
                     gen_helper_ffree_STN(tcg_env, tcg_constant_i32(opreg));
                     break;
                 case 0x2a: /* fst sti */
                     gen_helper_fmov_STN_ST0(tcg_env, tcg_constant_i32(opreg));
                     break;
                 case 0x2b: /* fstp sti */
                 case 0x0b: /* fstp1 sti, undocumented op */
                 case 0x3a: /* fstp8 sti, undocumented op */
                 case 0x3b: /* fstp9 sti, undocumented op */
                     gen_helper_fmov_STN_ST0(tcg_env, tcg_constant_i32(opreg));
                     gen_helper_fpop(tcg_env);
                     break;
                 case 0x2c: /* fucom st(i) */
                     gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
                     gen_helper_fucom_ST0_FT0(tcg_env);
                     break;
                 case 0x2d: /* fucomp st(i) */
                     gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
                     gen_helper_fucom_ST0_FT0(tcg_env);
                     gen_helper_fpop(tcg_env);
                     break;
                 case 0x33: /* de/3 */
                     switch (rm) {
                     case 1: /* fcompp */
                         gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(1));
                         gen_helper_fcom_ST0_FT0(tcg_env);
                         gen_helper_fpop(tcg_env);
                         gen_helper_fpop(tcg_env);
                         break;
                     default:
                         goto unknown_op;
                     }
                     break;
                 case 0x38: /* ffreep sti, undocumented op */
                     gen_helper_ffree_STN(tcg_env, tcg_constant_i32(opreg));
                     gen_helper_fpop(tcg_env);
                     break;
                 case 0x3c: /* df/4 */
                     switch (rm) {
                     case 0:
                         gen_helper_fnstsw(s->tmp2_i32, tcg_env);
                         tcg_gen_extu_i32_tl(s->T0, s->tmp2_i32);
                         gen_op_mov_reg_v(s, MO_16, R_EAX, s->T0);
                         break;
                     default:
                         goto unknown_op;
                     }
                     break;
                 case 0x3d: /* fucomip */
                     if (!(s->cpuid_features & CPUID_CMOV)) {
                         goto illegal_op;
                     }
                     gen_update_cc_op(s);
                     gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
                     gen_helper_fucomi_ST0_FT0(tcg_env);
                     gen_helper_fpop(tcg_env);
                     set_cc_op(s, CC_OP_EFLAGS);
                     break;
                 case 0x3e: /* fcomip */
                     if (!(s->cpuid_features & CPUID_CMOV)) {
                         goto illegal_op;
                     }
                     gen_update_cc_op(s);
                     gen_helper_fmov_FT0_STN(tcg_env, tcg_constant_i32(opreg));
                     gen_helper_fcomi_ST0_FT0(tcg_env);
                     gen_helper_fpop(tcg_env);
                     set_cc_op(s, CC_OP_EFLAGS);
                     break;
                 case 0x10 ... 0x13: /* fcmovxx */
                 case 0x18 ... 0x1b:
                     {
                         int op1;
                         TCGLabel *l1;
                         static const uint8_t fcmov_cc[8] = {
                             (JCC_B << 1),
                             (JCC_Z << 1),
                             (JCC_BE << 1),
                             (JCC_P << 1),
                         };
 
                         if (!(s->cpuid_features & CPUID_CMOV)) {
                             goto illegal_op;
                         }
                         op1 = fcmov_cc[op & 3] | (((op >> 3) & 1) ^ 1);
                         l1 = gen_new_label();
                         gen_jcc1_noeob(s, op1, l1);
                         gen_helper_fmov_ST0_STN(tcg_env,
                                                 tcg_constant_i32(opreg));
                         gen_set_label(l1);
                     }
                     break;
                 default:
                     goto unknown_op;
                 }
             }
 
             if (update_fip) {
                 tcg_gen_ld_i32(s->tmp2_i32, tcg_env,
                                offsetof(CPUX86State, segs[R_CS].selector));
                 tcg_gen_st16_i32(s->tmp2_i32, tcg_env,
                                  offsetof(CPUX86State, fpcs));
                 tcg_gen_st_tl(eip_cur_tl(s),
                               tcg_env, offsetof(CPUX86State, fpip));
             }
         }
         break;
         /************************/
         /* string ops */
 
     case 0xa4: /* movsS */
     case 0xa5:
         ot = mo_b_d(b, dflag);
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_movs(s, ot);
         } else {
             gen_movs(s, ot);
         }
         break;
 
     case 0xaa: /* stosS */
     case 0xab:
         ot = mo_b_d(b, dflag);
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_stos(s, ot);
         } else {
             gen_stos(s, ot);
         }
         break;
     case 0xac: /* lodsS */
     case 0xad:
         ot = mo_b_d(b, dflag);
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_lods(s, ot);
         } else {
             gen_lods(s, ot);
         }
         break;
     case 0xae: /* scasS */
     case 0xaf:
         ot = mo_b_d(b, dflag);
         if (prefixes & PREFIX_REPNZ) {
             gen_repz_scas(s, ot, 1);
         } else if (prefixes & PREFIX_REPZ) {
             gen_repz_scas(s, ot, 0);
         } else {
             gen_scas(s, ot);
         }
         break;
 
     case 0xa6: /* cmpsS */
     case 0xa7:
         ot = mo_b_d(b, dflag);
         if (prefixes & PREFIX_REPNZ) {
             gen_repz_cmps(s, ot, 1);
         } else if (prefixes & PREFIX_REPZ) {
             gen_repz_cmps(s, ot, 0);
         } else {
             gen_cmps(s, ot);
         }
         break;
     case 0x6c: /* insS */
     case 0x6d:
         ot = mo_b_d32(b, dflag);
         tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_EDX]);
         tcg_gen_ext16u_i32(s->tmp2_i32, s->tmp2_i32);
         if (!gen_check_io(s, ot, s->tmp2_i32,
                           SVM_IOIO_TYPE_MASK | SVM_IOIO_STR_MASK)) {
             break;
         }
         translator_io_start(&s->base);
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_ins(s, ot);
         } else {
             gen_ins(s, ot);
         }
         break;
     case 0x6e: /* outsS */
     case 0x6f:
         ot = mo_b_d32(b, dflag);
         tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_EDX]);
         tcg_gen_ext16u_i32(s->tmp2_i32, s->tmp2_i32);
         if (!gen_check_io(s, ot, s->tmp2_i32, SVM_IOIO_STR_MASK)) {
             break;
         }
         translator_io_start(&s->base);
         if (prefixes & (PREFIX_REPZ | PREFIX_REPNZ)) {
             gen_repz_outs(s, ot);
         } else {
             gen_outs(s, ot);
         }
         break;
 
         /************************/
         /* port I/O */
 
     case 0xe4:
     case 0xe5:
         ot = mo_b_d32(b, dflag);
         val = x86_ldub_code(env, s);
         tcg_gen_movi_i32(s->tmp2_i32, val);
         if (!gen_check_io(s, ot, s->tmp2_i32, SVM_IOIO_TYPE_MASK)) {
             break;
         }
         translator_io_start(&s->base);
         gen_helper_in_func(ot, s->T1, s->tmp2_i32);
         gen_op_mov_reg_v(s, ot, R_EAX, s->T1);
         gen_bpt_io(s, s->tmp2_i32, ot);
         break;
     case 0xe6:
     case 0xe7:
         ot = mo_b_d32(b, dflag);
         val = x86_ldub_code(env, s);
         tcg_gen_movi_i32(s->tmp2_i32, val);
         if (!gen_check_io(s, ot, s->tmp2_i32, 0)) {
             break;
         }
         translator_io_start(&s->base);
         gen_op_mov_v_reg(s, ot, s->T1, R_EAX);
         tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
         gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
         gen_bpt_io(s, s->tmp2_i32, ot);
         break;
     case 0xec:
     case 0xed:
         ot = mo_b_d32(b, dflag);
         tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_EDX]);
         tcg_gen_ext16u_i32(s->tmp2_i32, s->tmp2_i32);
         if (!gen_check_io(s, ot, s->tmp2_i32, SVM_IOIO_TYPE_MASK)) {
             break;
         }
         translator_io_start(&s->base);
         gen_helper_in_func(ot, s->T1, s->tmp2_i32);
         gen_op_mov_reg_v(s, ot, R_EAX, s->T1);
         gen_bpt_io(s, s->tmp2_i32, ot);
         break;
     case 0xee:
     case 0xef:
         ot = mo_b_d32(b, dflag);
         tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_EDX]);
         tcg_gen_ext16u_i32(s->tmp2_i32, s->tmp2_i32);
         if (!gen_check_io(s, ot, s->tmp2_i32, 0)) {
             break;
         }
         translator_io_start(&s->base);
         gen_op_mov_v_reg(s, ot, s->T1, R_EAX);
         tcg_gen_trunc_tl_i32(s->tmp3_i32, s->T1);
         gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
         gen_bpt_io(s, s->tmp2_i32, ot);
         break;
 
         /************************/
         /* control */
     case 0xc2: /* ret im */
         val = x86_ldsw_code(env, s);
         ot = gen_pop_T0(s);
         gen_stack_update(s, val + (1 << ot));
         /* Note that gen_pop_T0 uses a zero-extending load.  */
         gen_op_jmp_v(s, s->T0);
         gen_bnd_jmp(s);
         s->base.is_jmp = DISAS_JUMP;
         break;
     case 0xc3: /* ret */
         ot = gen_pop_T0(s);
         gen_pop_update(s, ot);
         /* Note that gen_pop_T0 uses a zero-extending load.  */
         gen_op_jmp_v(s, s->T0);
         gen_bnd_jmp(s);
         s->base.is_jmp = DISAS_JUMP;
         break;
     case 0xca: /* lret im */
         val = x86_ldsw_code(env, s);
     do_lret:
         if (PE(s) && !VM86(s)) {
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             gen_helper_lret_protected(tcg_env, tcg_constant_i32(dflag - 1),
                                       tcg_constant_i32(val));
         } else {
             gen_stack_A0(s);
             /* pop offset */
             gen_op_ld_v(s, dflag, s->T0, s->A0);
             /* NOTE: keeping EIP updated is not a problem in case of
                exception */
             gen_op_jmp_v(s, s->T0);
             /* pop selector */
             gen_add_A0_im(s, 1 << dflag);
             gen_op_ld_v(s, dflag, s->T0, s->A0);
             gen_op_movl_seg_T0_vm(s, R_CS);
             /* add stack offset */
             gen_stack_update(s, val + (2 << dflag));
         }
         s->base.is_jmp = DISAS_EOB_ONLY;
         break;
     case 0xcb: /* lret */
         val = 0;
         goto do_lret;
     case 0xcf: /* iret */
         gen_svm_check_intercept(s, SVM_EXIT_IRET);
         if (!PE(s) || VM86(s)) {
             /* real mode or vm86 mode */
             if (!check_vm86_iopl(s)) {
                 break;
             }
             gen_helper_iret_real(tcg_env, tcg_constant_i32(dflag - 1));
         } else {
             gen_helper_iret_protected(tcg_env, tcg_constant_i32(dflag - 1),
                                       eip_next_i32(s));
         }
         set_cc_op(s, CC_OP_EFLAGS);
         s->base.is_jmp = DISAS_EOB_ONLY;
         break;
     case 0xe8: /* call im */
         {
             int diff = (dflag != MO_16
                         ? (int32_t)insn_get(env, s, MO_32)
                         : (int16_t)insn_get(env, s, MO_16));
             gen_push_v(s, eip_next_tl(s));
             gen_bnd_jmp(s);
             gen_jmp_rel(s, dflag, diff, 0);
         }
         break;
     case 0x9a: /* lcall im */
         {
             unsigned int selector, offset;
 
             if (CODE64(s))
                 goto illegal_op;
             ot = dflag;
             offset = insn_get(env, s, ot);
             selector = insn_get(env, s, MO_16);
 
             tcg_gen_movi_tl(s->T0, selector);
             tcg_gen_movi_tl(s->T1, offset);
         }
         goto do_lcall;
     case 0xe9: /* jmp im */
         {
             int diff = (dflag != MO_16
                         ? (int32_t)insn_get(env, s, MO_32)
                         : (int16_t)insn_get(env, s, MO_16));
             gen_bnd_jmp(s);
             gen_jmp_rel(s, dflag, diff, 0);
         }
         break;
     case 0xea: /* ljmp im */
         {
             unsigned int selector, offset;
 
             if (CODE64(s))
                 goto illegal_op;
             ot = dflag;
             offset = insn_get(env, s, ot);
             selector = insn_get(env, s, MO_16);
 
             tcg_gen_movi_tl(s->T0, selector);
             tcg_gen_movi_tl(s->T1, offset);
         }
         goto do_ljmp;
     case 0xeb: /* jmp Jb */
         {
             int diff = (int8_t)insn_get(env, s, MO_8);
             gen_jmp_rel(s, dflag, diff, 0);
         }
         break;
     case 0x70 ... 0x7f: /* jcc Jb */
         {
             int diff = (int8_t)insn_get(env, s, MO_8);
             gen_bnd_jmp(s);
             gen_jcc(s, b, diff);
         }
         break;
     case 0x180 ... 0x18f: /* jcc Jv */
         {
             int diff = (dflag != MO_16
                         ? (int32_t)insn_get(env, s, MO_32)
                         : (int16_t)insn_get(env, s, MO_16));
             gen_bnd_jmp(s);
             gen_jcc(s, b, diff);
         }
         break;
 
     case 0x190 ... 0x19f: /* setcc Gv */
         modrm = x86_ldub_code(env, s);
         gen_setcc1(s, b, s->T0);
         gen_ldst_modrm(env, s, modrm, MO_8, OR_TMP0, 1);
         break;
     case 0x140 ... 0x14f: /* cmov Gv, Ev */
         if (!(s->cpuid_features & CPUID_CMOV)) {
             goto illegal_op;
         }
         ot = dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         gen_cmovcc1(env, s, ot, b, modrm, reg);
         break;
 
         /************************/
         /* flags */
     case 0x9c: /* pushf */
         gen_svm_check_intercept(s, SVM_EXIT_PUSHF);
         if (check_vm86_iopl(s)) {
             gen_update_cc_op(s);
             gen_helper_read_eflags(s->T0, tcg_env);
             gen_push_v(s, s->T0);
         }
         break;
     case 0x9d: /* popf */
         gen_svm_check_intercept(s, SVM_EXIT_POPF);
         if (check_vm86_iopl(s)) {
             int mask = TF_MASK | AC_MASK | ID_MASK | NT_MASK;
 
             if (CPL(s) == 0) {
                 mask |= IF_MASK | IOPL_MASK;
             } else if (CPL(s) <= IOPL(s)) {
                 mask |= IF_MASK;
             }
             if (dflag == MO_16) {
                 mask &= 0xffff;
             }
 
             ot = gen_pop_T0(s);
             gen_helper_write_eflags(tcg_env, s->T0, tcg_constant_i32(mask));
             gen_pop_update(s, ot);
             set_cc_op(s, CC_OP_EFLAGS);
             /* abort translation because TF/AC flag may change */
             s->base.is_jmp = DISAS_EOB_NEXT;
         }
         break;
     case 0x9e: /* sahf */
         if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM))
             goto illegal_op;
         tcg_gen_shri_tl(s->T0, cpu_regs[R_EAX], 8);
         gen_compute_eflags(s);
         tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, CC_O);
         tcg_gen_andi_tl(s->T0, s->T0, CC_S | CC_Z | CC_A | CC_P | CC_C);
         tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, s->T0);
         break;
     case 0x9f: /* lahf */
         if (CODE64(s) && !(s->cpuid_ext3_features & CPUID_EXT3_LAHF_LM))
             goto illegal_op;
         gen_compute_eflags(s);
         /* Note: gen_compute_eflags() only gives the condition codes */
         tcg_gen_ori_tl(s->T0, cpu_cc_src, 0x02);
         tcg_gen_deposit_tl(cpu_regs[R_EAX], cpu_regs[R_EAX], s->T0, 8, 8);
         break;
     case 0xf5: /* cmc */
         gen_compute_eflags(s);
         tcg_gen_xori_tl(cpu_cc_src, cpu_cc_src, CC_C);
         break;
     case 0xf8: /* clc */
         gen_compute_eflags(s);
         tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, ~CC_C);
         break;
     case 0xf9: /* stc */
         gen_compute_eflags(s);
         tcg_gen_ori_tl(cpu_cc_src, cpu_cc_src, CC_C);
         break;
     case 0xfc: /* cld */
         tcg_gen_movi_i32(s->tmp2_i32, 1);
         tcg_gen_st_i32(s->tmp2_i32, tcg_env, offsetof(CPUX86State, df));
         break;
     case 0xfd: /* std */
         tcg_gen_movi_i32(s->tmp2_i32, -1);
         tcg_gen_st_i32(s->tmp2_i32, tcg_env, offsetof(CPUX86State, df));
         break;
 
         /************************/
         /* bit operations */
     case 0x1ba: /* bt/bts/btr/btc Gv, im */
         ot = dflag;
         modrm = x86_ldub_code(env, s);
         op = (modrm >> 3) & 7;
         mod = (modrm >> 6) & 3;
         rm = (modrm & 7) | REX_B(s);
         if (mod != 3) {
             s->rip_offset = 1;
             gen_lea_modrm(env, s, modrm);
             if (!(s->prefix & PREFIX_LOCK)) {
                 gen_op_ld_v(s, ot, s->T0, s->A0);
             }
         } else {
             gen_op_mov_v_reg(s, ot, s->T0, rm);
         }
         /* load shift */
         val = x86_ldub_code(env, s);
         tcg_gen_movi_tl(s->T1, val);
         if (op < 4)
             goto unknown_op;
         op -= 4;
         goto bt_op;
     case 0x1a3: /* bt Gv, Ev */
         op = 0;
         goto do_btx;
     case 0x1ab: /* bts */
         op = 1;
         goto do_btx;
     case 0x1b3: /* btr */
         op = 2;
         goto do_btx;
     case 0x1bb: /* btc */
         op = 3;
     do_btx:
         ot = dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         mod = (modrm >> 6) & 3;
         rm = (modrm & 7) | REX_B(s);
         gen_op_mov_v_reg(s, MO_32, s->T1, reg);
         if (mod != 3) {
             AddressParts a = gen_lea_modrm_0(env, s, modrm);
             /* specific case: we need to add a displacement */
             gen_exts(ot, s->T1);
             tcg_gen_sari_tl(s->tmp0, s->T1, 3 + ot);
             tcg_gen_shli_tl(s->tmp0, s->tmp0, ot);
             tcg_gen_add_tl(s->A0, gen_lea_modrm_1(s, a, false), s->tmp0);
             gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override);
             if (!(s->prefix & PREFIX_LOCK)) {
                 gen_op_ld_v(s, ot, s->T0, s->A0);
             }
         } else {
             gen_op_mov_v_reg(s, ot, s->T0, rm);
         }
     bt_op:
         tcg_gen_andi_tl(s->T1, s->T1, (1 << (3 + ot)) - 1);
         tcg_gen_movi_tl(s->tmp0, 1);
         tcg_gen_shl_tl(s->tmp0, s->tmp0, s->T1);
         if (s->prefix & PREFIX_LOCK) {
             switch (op) {
             case 0: /* bt */
                 /* Needs no atomic ops; we suppressed the normal
                    memory load for LOCK above so do it now.  */
                 gen_op_ld_v(s, ot, s->T0, s->A0);
                 break;
             case 1: /* bts */
                 tcg_gen_atomic_fetch_or_tl(s->T0, s->A0, s->tmp0,
                                            s->mem_index, ot | MO_LE);
                 break;
             case 2: /* btr */
                 tcg_gen_not_tl(s->tmp0, s->tmp0);
                 tcg_gen_atomic_fetch_and_tl(s->T0, s->A0, s->tmp0,
                                             s->mem_index, ot | MO_LE);
                 break;
             default:
             case 3: /* btc */
                 tcg_gen_atomic_fetch_xor_tl(s->T0, s->A0, s->tmp0,
                                             s->mem_index, ot | MO_LE);
                 break;
             }
             tcg_gen_shr_tl(s->tmp4, s->T0, s->T1);
         } else {
             tcg_gen_shr_tl(s->tmp4, s->T0, s->T1);
             switch (op) {
             case 0: /* bt */
                 /* Data already loaded; nothing to do.  */
                 break;
             case 1: /* bts */
                 tcg_gen_or_tl(s->T0, s->T0, s->tmp0);
                 break;
             case 2: /* btr */
                 tcg_gen_andc_tl(s->T0, s->T0, s->tmp0);
                 break;
             default:
             case 3: /* btc */
                 tcg_gen_xor_tl(s->T0, s->T0, s->tmp0);
                 break;
             }
             if (op != 0) {
                 if (mod != 3) {
                     gen_op_st_v(s, ot, s->T0, s->A0);
                 } else {
                     gen_op_mov_reg_v(s, ot, rm, s->T0);
                 }
             }
         }
 
         /* Delay all CC updates until after the store above.  Note that
            C is the result of the test, Z is unchanged, and the others
            are all undefined.  */
         switch (s->cc_op) {
         case CC_OP_MULB ... CC_OP_MULQ:
         case CC_OP_ADDB ... CC_OP_ADDQ:
         case CC_OP_ADCB ... CC_OP_ADCQ:
         case CC_OP_SUBB ... CC_OP_SUBQ:
         case CC_OP_SBBB ... CC_OP_SBBQ:
         case CC_OP_LOGICB ... CC_OP_LOGICQ:
         case CC_OP_INCB ... CC_OP_INCQ:
         case CC_OP_DECB ... CC_OP_DECQ:
         case CC_OP_SHLB ... CC_OP_SHLQ:
         case CC_OP_SARB ... CC_OP_SARQ:
         case CC_OP_BMILGB ... CC_OP_BMILGQ:
             /* Z was going to be computed from the non-zero status of CC_DST.
                We can get that same Z value (and the new C value) by leaving
                CC_DST alone, setting CC_SRC, and using a CC_OP_SAR of the
                same width.  */
             tcg_gen_mov_tl(cpu_cc_src, s->tmp4);
             set_cc_op(s, ((s->cc_op - CC_OP_MULB) & 3) + CC_OP_SARB);
             break;
         default:
             /* Otherwise, generate EFLAGS and replace the C bit.  */
             gen_compute_eflags(s);
             tcg_gen_deposit_tl(cpu_cc_src, cpu_cc_src, s->tmp4,
                                ctz32(CC_C), 1);
             break;
         }
         break;
     case 0x1bc: /* bsf / tzcnt */
     case 0x1bd: /* bsr / lzcnt */
         ot = dflag;
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
         gen_extu(ot, s->T0);
 
         /* Note that lzcnt and tzcnt are in different extensions.  */
         if ((prefixes & PREFIX_REPZ)
             && (b & 1
                 ? s->cpuid_ext3_features & CPUID_EXT3_ABM
                 : s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_BMI1)) {
             int size = 8 << ot;
             /* For lzcnt/tzcnt, C bit is defined related to the input. */
             tcg_gen_mov_tl(cpu_cc_src, s->T0);
             if (b & 1) {
                 /* For lzcnt, reduce the target_ulong result by the
                    number of zeros that we expect to find at the top.  */
                 tcg_gen_clzi_tl(s->T0, s->T0, TARGET_LONG_BITS);
                 tcg_gen_subi_tl(s->T0, s->T0, TARGET_LONG_BITS - size);
             } else {
                 /* For tzcnt, a zero input must return the operand size.  */
                 tcg_gen_ctzi_tl(s->T0, s->T0, size);
             }
             /* For lzcnt/tzcnt, Z bit is defined related to the result.  */
             gen_op_update1_cc(s);
             set_cc_op(s, CC_OP_BMILGB + ot);
         } else {
             /* For bsr/bsf, only the Z bit is defined and it is related
                to the input and not the result.  */
             tcg_gen_mov_tl(cpu_cc_dst, s->T0);
             set_cc_op(s, CC_OP_LOGICB + ot);
 
             /* ??? The manual says that the output is undefined when the
                input is zero, but real hardware leaves it unchanged, and
                real programs appear to depend on that.  Accomplish this
                by passing the output as the value to return upon zero.  */
             if (b & 1) {
                 /* For bsr, return the bit index of the first 1 bit,
                    not the count of leading zeros.  */
                 tcg_gen_xori_tl(s->T1, cpu_regs[reg], TARGET_LONG_BITS - 1);
                 tcg_gen_clz_tl(s->T0, s->T0, s->T1);
                 tcg_gen_xori_tl(s->T0, s->T0, TARGET_LONG_BITS - 1);
             } else {
                 tcg_gen_ctz_tl(s->T0, s->T0, cpu_regs[reg]);
             }
         }
         gen_op_mov_reg_v(s, ot, reg, s->T0);
         break;
         /************************/
         /* bcd */
     case 0x27: /* daa */
         if (CODE64(s))
             goto illegal_op;
         gen_update_cc_op(s);
         gen_helper_daa(tcg_env);
         set_cc_op(s, CC_OP_EFLAGS);
         break;
     case 0x2f: /* das */
         if (CODE64(s))
             goto illegal_op;
         gen_update_cc_op(s);
         gen_helper_das(tcg_env);
         set_cc_op(s, CC_OP_EFLAGS);
         break;
     case 0x37: /* aaa */
         if (CODE64(s))
             goto illegal_op;
         gen_update_cc_op(s);
         gen_helper_aaa(tcg_env);
         set_cc_op(s, CC_OP_EFLAGS);
         break;
     case 0x3f: /* aas */
         if (CODE64(s))
             goto illegal_op;
         gen_update_cc_op(s);
         gen_helper_aas(tcg_env);
         set_cc_op(s, CC_OP_EFLAGS);
         break;
     case 0xd4: /* aam */
         if (CODE64(s))
             goto illegal_op;
         val = x86_ldub_code(env, s);
         if (val == 0) {
             gen_exception(s, EXCP00_DIVZ);
         } else {
             gen_helper_aam(tcg_env, tcg_constant_i32(val));
             set_cc_op(s, CC_OP_LOGICB);
         }
         break;
     case 0xd5: /* aad */
         if (CODE64(s))
             goto illegal_op;
         val = x86_ldub_code(env, s);
         gen_helper_aad(tcg_env, tcg_constant_i32(val));
         set_cc_op(s, CC_OP_LOGICB);
         break;
         /************************/
         /* misc */
     case 0x90: /* nop */
         /* XXX: correct lock test for all insn */
         if (prefixes & PREFIX_LOCK) {
             goto illegal_op;
         }
         /* If REX_B is set, then this is xchg eax, r8d, not a nop.  */
         if (REX_B(s)) {
             goto do_xchg_reg_eax;
         }
         if (prefixes & PREFIX_REPZ) {
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             gen_helper_pause(tcg_env, cur_insn_len_i32(s));
             s->base.is_jmp = DISAS_NORETURN;
         }
         break;
     case 0x9b: /* fwait */
         if ((s->flags & (HF_MP_MASK | HF_TS_MASK)) ==
             (HF_MP_MASK | HF_TS_MASK)) {
             gen_exception(s, EXCP07_PREX);
         } else {
             /* needs to be treated as I/O because of ferr_irq */
             translator_io_start(&s->base);
             gen_helper_fwait(tcg_env);
         }
         break;
     case 0xcc: /* int3 */
         gen_interrupt(s, EXCP03_INT3);
         break;
     case 0xcd: /* int N */
         val = x86_ldub_code(env, s);
         if (check_vm86_iopl(s)) {
             gen_interrupt(s, val);
         }
         break;
     case 0xce: /* into */
         if (CODE64(s))
             goto illegal_op;
         gen_update_cc_op(s);
         gen_update_eip_cur(s);
         gen_helper_into(tcg_env, cur_insn_len_i32(s));
         break;
 #ifdef WANT_ICEBP
     case 0xf1: /* icebp (undocumented, exits to external debugger) */
         gen_svm_check_intercept(s, SVM_EXIT_ICEBP);
         gen_debug(s);
         break;
 #endif
     case 0xfa: /* cli */
         if (check_iopl(s)) {
             gen_reset_eflags(s, IF_MASK);
         }
         break;
     case 0xfb: /* sti */
         if (check_iopl(s)) {
             gen_set_eflags(s, IF_MASK);
             /* interruptions are enabled only the first insn after sti */
             gen_update_eip_next(s);
             gen_eob_inhibit_irq(s, true);
         }
         break;
     case 0x62: /* bound */
         if (CODE64(s))
             goto illegal_op;
         ot = dflag;
         modrm = x86_ldub_code(env, s);
         reg = (modrm >> 3) & 7;
         mod = (modrm >> 6) & 3;
         if (mod == 3)
             goto illegal_op;
         gen_op_mov_v_reg(s, ot, s->T0, reg);
         gen_lea_modrm(env, s, modrm);
         tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
         if (ot == MO_16) {
             gen_helper_boundw(tcg_env, s->A0, s->tmp2_i32);
         } else {
             gen_helper_boundl(tcg_env, s->A0, s->tmp2_i32);
         }
         break;
     case 0x1c8 ... 0x1cf: /* bswap reg */
         reg = (b & 7) | REX_B(s);
 #ifdef TARGET_X86_64
         if (dflag == MO_64) {
             tcg_gen_bswap64_i64(cpu_regs[reg], cpu_regs[reg]);
             break;
         }
 #endif
         tcg_gen_bswap32_tl(cpu_regs[reg], cpu_regs[reg], TCG_BSWAP_OZ);
         break;
     case 0xd6: /* salc */
         if (CODE64(s))
             goto illegal_op;
         gen_compute_eflags_c(s, s->T0);
         tcg_gen_neg_tl(s->T0, s->T0);
         gen_op_mov_reg_v(s, MO_8, R_EAX, s->T0);
         break;
     case 0xe0: /* loopnz */
     case 0xe1: /* loopz */
     case 0xe2: /* loop */
     case 0xe3: /* jecxz */
         {
             TCGLabel *l1, *l2;
             int diff = (int8_t)insn_get(env, s, MO_8);
 
             l1 = gen_new_label();
             l2 = gen_new_label();
             gen_update_cc_op(s);
             b &= 3;
             switch(b) {
             case 0: /* loopnz */
             case 1: /* loopz */
                 gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
                 gen_op_jz_ecx(s, l2);
                 gen_jcc1(s, (JCC_Z << 1) | (b ^ 1), l1);
                 break;
             case 2: /* loop */
                 gen_op_add_reg_im(s, s->aflag, R_ECX, -1);
                 gen_op_jnz_ecx(s, l1);
                 break;
             default:
             case 3: /* jcxz */
                 gen_op_jz_ecx(s, l1);
                 break;
             }
 
             gen_set_label(l2);
             gen_jmp_rel_csize(s, 0, 1);
 
             gen_set_label(l1);
             gen_jmp_rel(s, dflag, diff, 0);
         }
         break;
     case 0x130: /* wrmsr */
     case 0x132: /* rdmsr */
         if (check_cpl0(s)) {
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             if (b & 2) {
                 gen_helper_rdmsr(tcg_env);
             } else {
                 gen_helper_wrmsr(tcg_env);
                 s->base.is_jmp = DISAS_EOB_NEXT;
             }
         }
         break;
     case 0x131: /* rdtsc */
         gen_update_cc_op(s);
         gen_update_eip_cur(s);
         translator_io_start(&s->base);
         gen_helper_rdtsc(tcg_env);
         break;
     case 0x133: /* rdpmc */
         gen_update_cc_op(s);
         gen_update_eip_cur(s);
         gen_helper_rdpmc(tcg_env);
         s->base.is_jmp = DISAS_NORETURN;
         break;
     case 0x134: /* sysenter */
         /* For AMD SYSENTER is not valid in long mode */
         if (LMA(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1) {
             goto illegal_op;
         }
         if (!PE(s)) {
             gen_exception_gpf(s);
         } else {
             gen_helper_sysenter(tcg_env);
             s->base.is_jmp = DISAS_EOB_ONLY;
         }
         break;
     case 0x135: /* sysexit */
         /* For AMD SYSEXIT is not valid in long mode */
         if (LMA(s) && env->cpuid_vendor1 != CPUID_VENDOR_INTEL_1) {
             goto illegal_op;
         }
         if (!PE(s) || CPL(s) != 0) {
             gen_exception_gpf(s);
         } else {
             gen_helper_sysexit(tcg_env, tcg_constant_i32(dflag - 1));
             s->base.is_jmp = DISAS_EOB_ONLY;
         }
         break;
     case 0x105: /* syscall */
         /* For Intel SYSCALL is only valid in long mode */
         if (!LMA(s) && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1) {
             goto illegal_op;
         }
         gen_update_cc_op(s);
         gen_update_eip_cur(s);
         gen_helper_syscall(tcg_env, cur_insn_len_i32(s));
         /* TF handling for the syscall insn is different. The TF bit is  checked
            after the syscall insn completes. This allows #DB to not be
            generated after one has entered CPL0 if TF is set in FMASK.  */
         gen_eob_worker(s, false, true);
         break;
     case 0x107: /* sysret */
         /* For Intel SYSRET is only valid in long mode */
         if (!LMA(s) && env->cpuid_vendor1 == CPUID_VENDOR_INTEL_1) {
             goto illegal_op;
         }
         if (!PE(s) || CPL(s) != 0) {
             gen_exception_gpf(s);
         } else {
             gen_helper_sysret(tcg_env, tcg_constant_i32(dflag - 1));
             /* condition codes are modified only in long mode */
             if (LMA(s)) {
                 set_cc_op(s, CC_OP_EFLAGS);
             }
             /* TF handling for the sysret insn is different. The TF bit is
                checked after the sysret insn completes. This allows #DB to be
                generated "as if" the syscall insn in userspace has just
                completed.  */
             gen_eob_worker(s, false, true);
         }
         break;
     case 0x1a2: /* cpuid */
         gen_update_cc_op(s);
         gen_update_eip_cur(s);
         gen_helper_cpuid(tcg_env);
         break;
     case 0xf4: /* hlt */
         if (check_cpl0(s)) {
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             gen_helper_hlt(tcg_env, cur_insn_len_i32(s));
             s->base.is_jmp = DISAS_NORETURN;
         }
         break;
     case 0x100:
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         op = (modrm >> 3) & 7;
         switch(op) {
         case 0: /* sldt */
             if (!PE(s) || VM86(s))
                 goto illegal_op;
             if (s->flags & HF_UMIP_MASK && !check_cpl0(s)) {
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_LDTR_READ);
             tcg_gen_ld32u_tl(s->T0, tcg_env,
                              offsetof(CPUX86State, ldt.selector));
             ot = mod == 3 ? dflag : MO_16;
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
             break;
         case 2: /* lldt */
             if (!PE(s) || VM86(s))
                 goto illegal_op;
             if (check_cpl0(s)) {
                 gen_svm_check_intercept(s, SVM_EXIT_LDTR_WRITE);
                 gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_lldt(tcg_env, s->tmp2_i32);
             }
             break;
         case 1: /* str */
             if (!PE(s) || VM86(s))
                 goto illegal_op;
             if (s->flags & HF_UMIP_MASK && !check_cpl0(s)) {
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_TR_READ);
             tcg_gen_ld32u_tl(s->T0, tcg_env,
                              offsetof(CPUX86State, tr.selector));
             ot = mod == 3 ? dflag : MO_16;
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
             break;
         case 3: /* ltr */
             if (!PE(s) || VM86(s))
                 goto illegal_op;
             if (check_cpl0(s)) {
                 gen_svm_check_intercept(s, SVM_EXIT_TR_WRITE);
                 gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
                 tcg_gen_trunc_tl_i32(s->tmp2_i32, s->T0);
                 gen_helper_ltr(tcg_env, s->tmp2_i32);
             }
             break;
         case 4: /* verr */
         case 5: /* verw */
             if (!PE(s) || VM86(s))
                 goto illegal_op;
             gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
             gen_update_cc_op(s);
             if (op == 4) {
                 gen_helper_verr(tcg_env, s->T0);
             } else {
                 gen_helper_verw(tcg_env, s->T0);
             }
             set_cc_op(s, CC_OP_EFLAGS);
             break;
         default:
             goto unknown_op;
         }
         break;
 
     case 0x101:
         modrm = x86_ldub_code(env, s);
         switch (modrm) {
         CASE_MODRM_MEM_OP(0): /* sgdt */
             if (s->flags & HF_UMIP_MASK && !check_cpl0(s)) {
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_GDTR_READ);
             gen_lea_modrm(env, s, modrm);
             tcg_gen_ld32u_tl(s->T0,
                              tcg_env, offsetof(CPUX86State, gdt.limit));
             gen_op_st_v(s, MO_16, s->T0, s->A0);
             gen_add_A0_im(s, 2);
             tcg_gen_ld_tl(s->T0, tcg_env, offsetof(CPUX86State, gdt.base));
             if (dflag == MO_16) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
             gen_op_st_v(s, CODE64(s) + MO_32, s->T0, s->A0);
             break;
 
         case 0xc8: /* monitor */
             if (!(s->cpuid_ext_features & CPUID_EXT_MONITOR) || CPL(s) != 0) {
                 goto illegal_op;
             }
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             tcg_gen_mov_tl(s->A0, cpu_regs[R_EAX]);
             gen_extu(s->aflag, s->A0);
             gen_add_A0_ds_seg(s);
             gen_helper_monitor(tcg_env, s->A0);
             break;
 
         case 0xc9: /* mwait */
             if (!(s->cpuid_ext_features & CPUID_EXT_MONITOR) || CPL(s) != 0) {
                 goto illegal_op;
             }
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             gen_helper_mwait(tcg_env, cur_insn_len_i32(s));
             s->base.is_jmp = DISAS_NORETURN;
             break;
 
         case 0xca: /* clac */
             if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_SMAP)
                 || CPL(s) != 0) {
                 goto illegal_op;
             }
             gen_reset_eflags(s, AC_MASK);
             s->base.is_jmp = DISAS_EOB_NEXT;
             break;
 
         case 0xcb: /* stac */
             if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_SMAP)
                 || CPL(s) != 0) {
                 goto illegal_op;
             }
             gen_set_eflags(s, AC_MASK);
             s->base.is_jmp = DISAS_EOB_NEXT;
             break;
 
         CASE_MODRM_MEM_OP(1): /* sidt */
             if (s->flags & HF_UMIP_MASK && !check_cpl0(s)) {
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_IDTR_READ);
             gen_lea_modrm(env, s, modrm);
             tcg_gen_ld32u_tl(s->T0, tcg_env, offsetof(CPUX86State, idt.limit));
             gen_op_st_v(s, MO_16, s->T0, s->A0);
             gen_add_A0_im(s, 2);
             tcg_gen_ld_tl(s->T0, tcg_env, offsetof(CPUX86State, idt.base));
             if (dflag == MO_16) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
             gen_op_st_v(s, CODE64(s) + MO_32, s->T0, s->A0);
             break;
 
         case 0xd0: /* xgetbv */
             if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
                 || (s->prefix & (PREFIX_LOCK | PREFIX_DATA
                                  | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
             gen_helper_xgetbv(s->tmp1_i64, tcg_env, s->tmp2_i32);
             tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], s->tmp1_i64);
             break;
 
         case 0xd1: /* xsetbv */
             if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
                 || (s->prefix & (PREFIX_LOCK | PREFIX_DATA
                                  | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             if (!check_cpl0(s)) {
                 break;
             }
             tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
                                   cpu_regs[R_EDX]);
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
             gen_helper_xsetbv(tcg_env, s->tmp2_i32, s->tmp1_i64);
             /* End TB because translation flags may change.  */
             s->base.is_jmp = DISAS_EOB_NEXT;
             break;
 
         case 0xd8: /* VMRUN */
             if (!SVME(s) || !PE(s)) {
                 goto illegal_op;
             }
             if (!check_cpl0(s)) {
                 break;
             }
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             gen_helper_vmrun(tcg_env, tcg_constant_i32(s->aflag - 1),
                              cur_insn_len_i32(s));
             tcg_gen_exit_tb(NULL, 0);
             s->base.is_jmp = DISAS_NORETURN;
             break;
 
         case 0xd9: /* VMMCALL */
             if (!SVME(s)) {
                 goto illegal_op;
             }
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             gen_helper_vmmcall(tcg_env);
             break;
 
         case 0xda: /* VMLOAD */
             if (!SVME(s) || !PE(s)) {
                 goto illegal_op;
             }
             if (!check_cpl0(s)) {
                 break;
             }
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             gen_helper_vmload(tcg_env, tcg_constant_i32(s->aflag - 1));
             break;
 
         case 0xdb: /* VMSAVE */
             if (!SVME(s) || !PE(s)) {
                 goto illegal_op;
             }
             if (!check_cpl0(s)) {
                 break;
             }
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             gen_helper_vmsave(tcg_env, tcg_constant_i32(s->aflag - 1));
             break;
 
         case 0xdc: /* STGI */
             if ((!SVME(s) && !(s->cpuid_ext3_features & CPUID_EXT3_SKINIT))
                 || !PE(s)) {
                 goto illegal_op;
             }
             if (!check_cpl0(s)) {
                 break;
             }
             gen_update_cc_op(s);
             gen_helper_stgi(tcg_env);
             s->base.is_jmp = DISAS_EOB_NEXT;
             break;
 
         case 0xdd: /* CLGI */
             if (!SVME(s) || !PE(s)) {
                 goto illegal_op;
             }
             if (!check_cpl0(s)) {
                 break;
             }
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             gen_helper_clgi(tcg_env);
             break;
 
         case 0xde: /* SKINIT */
             if ((!SVME(s) && !(s->cpuid_ext3_features & CPUID_EXT3_SKINIT))
                 || !PE(s)) {
                 goto illegal_op;
             }
             gen_svm_check_intercept(s, SVM_EXIT_SKINIT);
             /* If not intercepted, not implemented -- raise #UD. */
             goto illegal_op;
 
         case 0xdf: /* INVLPGA */
             if (!SVME(s) || !PE(s)) {
                 goto illegal_op;
             }
             if (!check_cpl0(s)) {
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_INVLPGA);
             if (s->aflag == MO_64) {
                 tcg_gen_mov_tl(s->A0, cpu_regs[R_EAX]);
             } else {
                 tcg_gen_ext32u_tl(s->A0, cpu_regs[R_EAX]);
             }
             gen_helper_flush_page(tcg_env, s->A0);
             s->base.is_jmp = DISAS_EOB_NEXT;
             break;
 
         CASE_MODRM_MEM_OP(2): /* lgdt */
             if (!check_cpl0(s)) {
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_GDTR_WRITE);
             gen_lea_modrm(env, s, modrm);
             gen_op_ld_v(s, MO_16, s->T1, s->A0);
             gen_add_A0_im(s, 2);
             gen_op_ld_v(s, CODE64(s) + MO_32, s->T0, s->A0);
             if (dflag == MO_16) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
             tcg_gen_st_tl(s->T0, tcg_env, offsetof(CPUX86State, gdt.base));
             tcg_gen_st32_tl(s->T1, tcg_env, offsetof(CPUX86State, gdt.limit));
             break;
 
         CASE_MODRM_MEM_OP(3): /* lidt */
             if (!check_cpl0(s)) {
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_IDTR_WRITE);
             gen_lea_modrm(env, s, modrm);
             gen_op_ld_v(s, MO_16, s->T1, s->A0);
             gen_add_A0_im(s, 2);
             gen_op_ld_v(s, CODE64(s) + MO_32, s->T0, s->A0);
             if (dflag == MO_16) {
                 tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
             }
             tcg_gen_st_tl(s->T0, tcg_env, offsetof(CPUX86State, idt.base));
             tcg_gen_st32_tl(s->T1, tcg_env, offsetof(CPUX86State, idt.limit));
             break;
 
         CASE_MODRM_OP(4): /* smsw */
             if (s->flags & HF_UMIP_MASK && !check_cpl0(s)) {
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_READ_CR0);
             tcg_gen_ld_tl(s->T0, tcg_env, offsetof(CPUX86State, cr[0]));
             /*
              * In 32-bit mode, the higher 16 bits of the destination
              * register are undefined.  In practice CR0[31:0] is stored
              * just like in 64-bit mode.
              */
             mod = (modrm >> 6) & 3;
             ot = (mod != 3 ? MO_16 : s->dflag);
             gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
             break;
         case 0xee: /* rdpkru */
             if (prefixes & PREFIX_LOCK) {
                 goto illegal_op;
             }
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
             gen_helper_rdpkru(s->tmp1_i64, tcg_env, s->tmp2_i32);
             tcg_gen_extr_i64_tl(cpu_regs[R_EAX], cpu_regs[R_EDX], s->tmp1_i64);
             break;
         case 0xef: /* wrpkru */
             if (prefixes & PREFIX_LOCK) {
                 goto illegal_op;
             }
             tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
                                   cpu_regs[R_EDX]);
             tcg_gen_trunc_tl_i32(s->tmp2_i32, cpu_regs[R_ECX]);
             gen_helper_wrpkru(tcg_env, s->tmp2_i32, s->tmp1_i64);
             break;
 
         CASE_MODRM_OP(6): /* lmsw */
             if (!check_cpl0(s)) {
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_WRITE_CR0);
             gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
             /*
              * Only the 4 lower bits of CR0 are modified.
              * PE cannot be set to zero if already set to one.
              */
             tcg_gen_ld_tl(s->T1, tcg_env, offsetof(CPUX86State, cr[0]));
             tcg_gen_andi_tl(s->T0, s->T0, 0xf);
             tcg_gen_andi_tl(s->T1, s->T1, ~0xe);
             tcg_gen_or_tl(s->T0, s->T0, s->T1);
             gen_helper_write_crN(tcg_env, tcg_constant_i32(0), s->T0);
             s->base.is_jmp = DISAS_EOB_NEXT;
             break;
 
         CASE_MODRM_MEM_OP(7): /* invlpg */
             if (!check_cpl0(s)) {
                 break;
             }
             gen_svm_check_intercept(s, SVM_EXIT_INVLPG);
             gen_lea_modrm(env, s, modrm);
             gen_helper_flush_page(tcg_env, s->A0);
             s->base.is_jmp = DISAS_EOB_NEXT;
             break;
 
         case 0xf8: /* swapgs */
 #ifdef TARGET_X86_64
             if (CODE64(s)) {
                 if (check_cpl0(s)) {
                     tcg_gen_mov_tl(s->T0, cpu_seg_base[R_GS]);
                     tcg_gen_ld_tl(cpu_seg_base[R_GS], tcg_env,
                                   offsetof(CPUX86State, kernelgsbase));
                     tcg_gen_st_tl(s->T0, tcg_env,
                                   offsetof(CPUX86State, kernelgsbase));
                 }
                 break;
             }
 #endif
             goto illegal_op;
 
         case 0xf9: /* rdtscp */
             if (!(s->cpuid_ext2_features & CPUID_EXT2_RDTSCP)) {
                 goto illegal_op;
             }
             gen_update_cc_op(s);
             gen_update_eip_cur(s);
             translator_io_start(&s->base);
             gen_helper_rdtsc(tcg_env);
             gen_helper_rdpid(s->T0, tcg_env);
             gen_op_mov_reg_v(s, dflag, R_ECX, s->T0);
             break;
 
         default:
             goto unknown_op;
         }
         break;
 
     case 0x108: /* invd */
     case 0x109: /* wbinvd; wbnoinvd with REPZ prefix */
         if (check_cpl0(s)) {
             gen_svm_check_intercept(s, (b & 1) ? SVM_EXIT_WBINVD : SVM_EXIT_INVD);
             /* nothing to do */
         }
         break;
     case 0x63: /* arpl or movslS (x86_64) */
 #ifdef TARGET_X86_64
         if (CODE64(s)) {
             int d_ot;
             /* d_ot is the size of destination */
             d_ot = dflag;
 
             modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | REX_R(s);
             mod = (modrm >> 6) & 3;
             rm = (modrm & 7) | REX_B(s);
 
             if (mod == 3) {
                 gen_op_mov_v_reg(s, MO_32, s->T0, rm);
                 /* sign extend */
                 if (d_ot == MO_64) {
                     tcg_gen_ext32s_tl(s->T0, s->T0);
                 }
                 gen_op_mov_reg_v(s, d_ot, reg, s->T0);
             } else {
                 gen_lea_modrm(env, s, modrm);
                 gen_op_ld_v(s, MO_32 | MO_SIGN, s->T0, s->A0);
                 gen_op_mov_reg_v(s, d_ot, reg, s->T0);
             }
         } else
 #endif
         {
             TCGLabel *label1;
             TCGv t0, t1, t2;
 
             if (!PE(s) || VM86(s))
                 goto illegal_op;
             t0 = tcg_temp_new();
             t1 = tcg_temp_new();
             t2 = tcg_temp_new();
             ot = MO_16;
             modrm = x86_ldub_code(env, s);
             reg = (modrm >> 3) & 7;
             mod = (modrm >> 6) & 3;
             rm = modrm & 7;
             if (mod != 3) {
                 gen_lea_modrm(env, s, modrm);
                 gen_op_ld_v(s, ot, t0, s->A0);
             } else {
                 gen_op_mov_v_reg(s, ot, t0, rm);
             }
             gen_op_mov_v_reg(s, ot, t1, reg);
             tcg_gen_andi_tl(s->tmp0, t0, 3);
             tcg_gen_andi_tl(t1, t1, 3);
             tcg_gen_movi_tl(t2, 0);
             label1 = gen_new_label();
             tcg_gen_brcond_tl(TCG_COND_GE, s->tmp0, t1, label1);
             tcg_gen_andi_tl(t0, t0, ~3);
             tcg_gen_or_tl(t0, t0, t1);
             tcg_gen_movi_tl(t2, CC_Z);
             gen_set_label(label1);
             if (mod != 3) {
                 gen_op_st_v(s, ot, t0, s->A0);
            } else {
                 gen_op_mov_reg_v(s, ot, rm, t0);
             }
             gen_compute_eflags(s);
             tcg_gen_andi_tl(cpu_cc_src, cpu_cc_src, ~CC_Z);
             tcg_gen_or_tl(cpu_cc_src, cpu_cc_src, t2);
         }
         break;
     case 0x102: /* lar */
     case 0x103: /* lsl */
         {
             TCGLabel *label1;
             TCGv t0;
             if (!PE(s) || VM86(s))
                 goto illegal_op;
             ot = dflag != MO_16 ? MO_32 : MO_16;
             modrm = x86_ldub_code(env, s);
             reg = ((modrm >> 3) & 7) | REX_R(s);
             gen_ldst_modrm(env, s, modrm, MO_16, OR_TMP0, 0);
             t0 = tcg_temp_new();
             gen_update_cc_op(s);
             if (b == 0x102) {
                 gen_helper_lar(t0, tcg_env, s->T0);
             } else {
                 gen_helper_lsl(t0, tcg_env, s->T0);
             }
             tcg_gen_andi_tl(s->tmp0, cpu_cc_src, CC_Z);
             label1 = gen_new_label();
             tcg_gen_brcondi_tl(TCG_COND_EQ, s->tmp0, 0, label1);
             gen_op_mov_reg_v(s, ot, reg, t0);
             gen_set_label(label1);
             set_cc_op(s, CC_OP_EFLAGS);
         }
         break;
     case 0x118:
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         op = (modrm >> 3) & 7;
         switch(op) {
         case 0: /* prefetchnta */
         case 1: /* prefetchnt0 */
         case 2: /* prefetchnt0 */
         case 3: /* prefetchnt0 */
             if (mod == 3)
                 goto illegal_op;
             gen_nop_modrm(env, s, modrm);
             /* nothing more to do */
             break;
         default: /* nop (multi byte) */
             gen_nop_modrm(env, s, modrm);
             break;
         }
         break;
     case 0x11a:
         modrm = x86_ldub_code(env, s);
         if (s->flags & HF_MPX_EN_MASK) {
             mod = (modrm >> 6) & 3;
             reg = ((modrm >> 3) & 7) | REX_R(s);
             if (prefixes & PREFIX_REPZ) {
                 /* bndcl */
                 if (reg >= 4
                     || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
                 gen_bndck(env, s, modrm, TCG_COND_LTU, cpu_bndl[reg]);
             } else if (prefixes & PREFIX_REPNZ) {
                 /* bndcu */
                 if (reg >= 4
                     || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
                 TCGv_i64 notu = tcg_temp_new_i64();
                 tcg_gen_not_i64(notu, cpu_bndu[reg]);
                 gen_bndck(env, s, modrm, TCG_COND_GTU, notu);
             } else if (prefixes & PREFIX_DATA) {
                 /* bndmov -- from reg/mem */
                 if (reg >= 4 || s->aflag == MO_16) {
                     goto illegal_op;
                 }
                 if (mod == 3) {
                     int reg2 = (modrm & 7) | REX_B(s);
                     if (reg2 >= 4 || (prefixes & PREFIX_LOCK)) {
                         goto illegal_op;
                     }
                     if (s->flags & HF_MPX_IU_MASK) {
                         tcg_gen_mov_i64(cpu_bndl[reg], cpu_bndl[reg2]);
                         tcg_gen_mov_i64(cpu_bndu[reg], cpu_bndu[reg2]);
                     }
                 } else {
                     gen_lea_modrm(env, s, modrm);
                     if (CODE64(s)) {
                         tcg_gen_qemu_ld_i64(cpu_bndl[reg], s->A0,
                                             s->mem_index, MO_LEUQ);
                         tcg_gen_addi_tl(s->A0, s->A0, 8);
                         tcg_gen_qemu_ld_i64(cpu_bndu[reg], s->A0,
                                             s->mem_index, MO_LEUQ);
                     } else {
                         tcg_gen_qemu_ld_i64(cpu_bndl[reg], s->A0,
                                             s->mem_index, MO_LEUL);
                         tcg_gen_addi_tl(s->A0, s->A0, 4);
                         tcg_gen_qemu_ld_i64(cpu_bndu[reg], s->A0,
                                             s->mem_index, MO_LEUL);
                     }
                     /* bnd registers are now in-use */
                     gen_set_hflag(s, HF_MPX_IU_MASK);
                 }
             } else if (mod != 3) {
                 /* bndldx */
                 AddressParts a = gen_lea_modrm_0(env, s, modrm);
                 if (reg >= 4
                     || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
                     || a.base < -1) {
                     goto illegal_op;
                 }
                 if (a.base >= 0) {
                     tcg_gen_addi_tl(s->A0, cpu_regs[a.base], a.disp);
                 } else {
                     tcg_gen_movi_tl(s->A0, 0);
                 }
                 gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override);
                 if (a.index >= 0) {
                     tcg_gen_mov_tl(s->T0, cpu_regs[a.index]);
                 } else {
                     tcg_gen_movi_tl(s->T0, 0);
                 }
                 if (CODE64(s)) {
                     gen_helper_bndldx64(cpu_bndl[reg], tcg_env, s->A0, s->T0);
                     tcg_gen_ld_i64(cpu_bndu[reg], tcg_env,
                                    offsetof(CPUX86State, mmx_t0.MMX_Q(0)));
                 } else {
                     gen_helper_bndldx32(cpu_bndu[reg], tcg_env, s->A0, s->T0);
                     tcg_gen_ext32u_i64(cpu_bndl[reg], cpu_bndu[reg]);
                     tcg_gen_shri_i64(cpu_bndu[reg], cpu_bndu[reg], 32);
                 }
                 gen_set_hflag(s, HF_MPX_IU_MASK);
             }
         }
         gen_nop_modrm(env, s, modrm);
         break;
     case 0x11b:
         modrm = x86_ldub_code(env, s);
         if (s->flags & HF_MPX_EN_MASK) {
             mod = (modrm >> 6) & 3;
             reg = ((modrm >> 3) & 7) | REX_R(s);
             if (mod != 3 && (prefixes & PREFIX_REPZ)) {
                 /* bndmk */
                 if (reg >= 4
                     || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
                 AddressParts a = gen_lea_modrm_0(env, s, modrm);
                 if (a.base >= 0) {
                     tcg_gen_extu_tl_i64(cpu_bndl[reg], cpu_regs[a.base]);
                     if (!CODE64(s)) {
                         tcg_gen_ext32u_i64(cpu_bndl[reg], cpu_bndl[reg]);
                     }
                 } else if (a.base == -1) {
                     /* no base register has lower bound of 0 */
                     tcg_gen_movi_i64(cpu_bndl[reg], 0);
                 } else {
                     /* rip-relative generates #ud */
                     goto illegal_op;
                 }
                 tcg_gen_not_tl(s->A0, gen_lea_modrm_1(s, a, false));
                 if (!CODE64(s)) {
                     tcg_gen_ext32u_tl(s->A0, s->A0);
                 }
                 tcg_gen_extu_tl_i64(cpu_bndu[reg], s->A0);
                 /* bnd registers are now in-use */
                 gen_set_hflag(s, HF_MPX_IU_MASK);
                 break;
             } else if (prefixes & PREFIX_REPNZ) {
                 /* bndcn */
                 if (reg >= 4
                     || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16) {
                     goto illegal_op;
                 }
                 gen_bndck(env, s, modrm, TCG_COND_GTU, cpu_bndu[reg]);
             } else if (prefixes & PREFIX_DATA) {
                 /* bndmov -- to reg/mem */
                 if (reg >= 4 || s->aflag == MO_16) {
                     goto illegal_op;
                 }
                 if (mod == 3) {
                     int reg2 = (modrm & 7) | REX_B(s);
                     if (reg2 >= 4 || (prefixes & PREFIX_LOCK)) {
                         goto illegal_op;
                     }
                     if (s->flags & HF_MPX_IU_MASK) {
                         tcg_gen_mov_i64(cpu_bndl[reg2], cpu_bndl[reg]);
                         tcg_gen_mov_i64(cpu_bndu[reg2], cpu_bndu[reg]);
                     }
                 } else {
                     gen_lea_modrm(env, s, modrm);
                     if (CODE64(s)) {
                         tcg_gen_qemu_st_i64(cpu_bndl[reg], s->A0,
                                             s->mem_index, MO_LEUQ);
                         tcg_gen_addi_tl(s->A0, s->A0, 8);
                         tcg_gen_qemu_st_i64(cpu_bndu[reg], s->A0,
                                             s->mem_index, MO_LEUQ);
                     } else {
                         tcg_gen_qemu_st_i64(cpu_bndl[reg], s->A0,
                                             s->mem_index, MO_LEUL);
                         tcg_gen_addi_tl(s->A0, s->A0, 4);
                         tcg_gen_qemu_st_i64(cpu_bndu[reg], s->A0,
                                             s->mem_index, MO_LEUL);
                     }
                 }
             } else if (mod != 3) {
                 /* bndstx */
                 AddressParts a = gen_lea_modrm_0(env, s, modrm);
                 if (reg >= 4
                     || (prefixes & PREFIX_LOCK)
                     || s->aflag == MO_16
                     || a.base < -1) {
                     goto illegal_op;
                 }
                 if (a.base >= 0) {
                     tcg_gen_addi_tl(s->A0, cpu_regs[a.base], a.disp);
                 } else {
                     tcg_gen_movi_tl(s->A0, 0);
                 }
                 gen_lea_v_seg(s, s->aflag, s->A0, a.def_seg, s->override);
                 if (a.index >= 0) {
                     tcg_gen_mov_tl(s->T0, cpu_regs[a.index]);
                 } else {
                     tcg_gen_movi_tl(s->T0, 0);
                 }
                 if (CODE64(s)) {
                     gen_helper_bndstx64(tcg_env, s->A0, s->T0,
                                         cpu_bndl[reg], cpu_bndu[reg]);
                 } else {
                     gen_helper_bndstx32(tcg_env, s->A0, s->T0,
                                         cpu_bndl[reg], cpu_bndu[reg]);
                 }
             }
         }
         gen_nop_modrm(env, s, modrm);
         break;
     case 0x119: case 0x11c ... 0x11f: /* nop (multi byte) */
         modrm = x86_ldub_code(env, s);
         gen_nop_modrm(env, s, modrm);
         break;
 
     case 0x120: /* mov reg, crN */
     case 0x122: /* mov crN, reg */
         if (!check_cpl0(s)) {
             break;
         }
         modrm = x86_ldub_code(env, s);
         /*
          * Ignore the mod bits (assume (modrm&0xc0)==0xc0).
          * AMD documentation (24594.pdf) and testing of Intel 386 and 486
          * processors all show that the mod bits are assumed to be 1's,
          * regardless of actual values.
          */
         rm = (modrm & 7) | REX_B(s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
         switch (reg) {
         case 0:
             if ((prefixes & PREFIX_LOCK) &&
                 (s->cpuid_ext3_features & CPUID_EXT3_CR8LEG)) {
                 reg = 8;
             }
             break;
         case 2:
         case 3:
         case 4:
         case 8:
             break;
         default:
             goto unknown_op;
         }
         ot  = (CODE64(s) ? MO_64 : MO_32);
 
         translator_io_start(&s->base);
         if (b & 2) {
             gen_svm_check_intercept(s, SVM_EXIT_WRITE_CR0 + reg);
             gen_op_mov_v_reg(s, ot, s->T0, rm);
             gen_helper_write_crN(tcg_env, tcg_constant_i32(reg), s->T0);
             s->base.is_jmp = DISAS_EOB_NEXT;
         } else {
             gen_svm_check_intercept(s, SVM_EXIT_READ_CR0 + reg);
             gen_helper_read_crN(s->T0, tcg_env, tcg_constant_i32(reg));
             gen_op_mov_reg_v(s, ot, rm, s->T0);
         }
         break;
 
     case 0x121: /* mov reg, drN */
     case 0x123: /* mov drN, reg */
         if (check_cpl0(s)) {
             modrm = x86_ldub_code(env, s);
             /* Ignore the mod bits (assume (modrm&0xc0)==0xc0).
              * AMD documentation (24594.pdf) and testing of
              * intel 386 and 486 processors all show that the mod bits
              * are assumed to be 1's, regardless of actual values.
              */
             rm = (modrm & 7) | REX_B(s);
             reg = ((modrm >> 3) & 7) | REX_R(s);
             if (CODE64(s))
                 ot = MO_64;
             else
                 ot = MO_32;
             if (reg >= 8) {
                 goto illegal_op;
             }
             if (b & 2) {
                 gen_svm_check_intercept(s, SVM_EXIT_WRITE_DR0 + reg);
                 gen_op_mov_v_reg(s, ot, s->T0, rm);
                 tcg_gen_movi_i32(s->tmp2_i32, reg);
                 gen_helper_set_dr(tcg_env, s->tmp2_i32, s->T0);
                 s->base.is_jmp = DISAS_EOB_NEXT;
             } else {
                 gen_svm_check_intercept(s, SVM_EXIT_READ_DR0 + reg);
                 tcg_gen_movi_i32(s->tmp2_i32, reg);
                 gen_helper_get_dr(s->T0, tcg_env, s->tmp2_i32);
                 gen_op_mov_reg_v(s, ot, rm, s->T0);
             }
         }
         break;
     case 0x106: /* clts */
         if (check_cpl0(s)) {
             gen_svm_check_intercept(s, SVM_EXIT_WRITE_CR0);
             gen_helper_clts(tcg_env);
             /* abort block because static cpu state changed */
             s->base.is_jmp = DISAS_EOB_NEXT;
         }
         break;
     /* MMX/3DNow!/SSE/SSE2/SSE3/SSSE3/SSE4 support */
     case 0x1c3: /* MOVNTI reg, mem */
         if (!(s->cpuid_features & CPUID_SSE2))
             goto illegal_op;
         ot = mo_64_32(dflag);
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         if (mod == 3)
             goto illegal_op;
         reg = ((modrm >> 3) & 7) | REX_R(s);
         /* generate a generic store */
         gen_ldst_modrm(env, s, modrm, ot, reg, 1);
         break;
     case 0x1ae:
         modrm = x86_ldub_code(env, s);
         switch (modrm) {
         CASE_MODRM_MEM_OP(0): /* fxsave */
             if (!(s->cpuid_features & CPUID_FXSR)
                 || (prefixes & PREFIX_LOCK)) {
                 goto illegal_op;
             }
             if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
                 gen_exception(s, EXCP07_PREX);
                 break;
             }
             gen_lea_modrm(env, s, modrm);
             gen_helper_fxsave(tcg_env, s->A0);
             break;
 
         CASE_MODRM_MEM_OP(1): /* fxrstor */
             if (!(s->cpuid_features & CPUID_FXSR)
                 || (prefixes & PREFIX_LOCK)) {
                 goto illegal_op;
             }
             if ((s->flags & HF_EM_MASK) || (s->flags & HF_TS_MASK)) {
                 gen_exception(s, EXCP07_PREX);
                 break;
             }
             gen_lea_modrm(env, s, modrm);
             gen_helper_fxrstor(tcg_env, s->A0);
             break;
 
         CASE_MODRM_MEM_OP(2): /* ldmxcsr */
             if ((s->flags & HF_EM_MASK) || !(s->flags & HF_OSFXSR_MASK)) {
                 goto illegal_op;
             }
             if (s->flags & HF_TS_MASK) {
                 gen_exception(s, EXCP07_PREX);
                 break;
             }
             gen_lea_modrm(env, s, modrm);
             tcg_gen_qemu_ld_i32(s->tmp2_i32, s->A0, s->mem_index, MO_LEUL);
             gen_helper_ldmxcsr(tcg_env, s->tmp2_i32);
             break;
 
         CASE_MODRM_MEM_OP(3): /* stmxcsr */
             if ((s->flags & HF_EM_MASK) || !(s->flags & HF_OSFXSR_MASK)) {
                 goto illegal_op;
             }
             if (s->flags & HF_TS_MASK) {
                 gen_exception(s, EXCP07_PREX);
                 break;
             }
             gen_helper_update_mxcsr(tcg_env);
             gen_lea_modrm(env, s, modrm);
             tcg_gen_ld32u_tl(s->T0, tcg_env, offsetof(CPUX86State, mxcsr));
             gen_op_st_v(s, MO_32, s->T0, s->A0);
             break;
 
         CASE_MODRM_MEM_OP(4): /* xsave */
             if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
                 || (prefixes & (PREFIX_LOCK | PREFIX_DATA
                                 | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             gen_lea_modrm(env, s, modrm);
             tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
                                   cpu_regs[R_EDX]);
             gen_helper_xsave(tcg_env, s->A0, s->tmp1_i64);
             break;
 
         CASE_MODRM_MEM_OP(5): /* xrstor */
             if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
                 || (prefixes & (PREFIX_LOCK | PREFIX_DATA
                                 | PREFIX_REPZ | PREFIX_REPNZ))) {
                 goto illegal_op;
             }
             gen_lea_modrm(env, s, modrm);
             tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
                                   cpu_regs[R_EDX]);
             gen_helper_xrstor(tcg_env, s->A0, s->tmp1_i64);
             /* XRSTOR is how MPX is enabled, which changes how
                we translate.  Thus we need to end the TB.  */
             s->base.is_jmp = DISAS_EOB_NEXT;
             break;
 
         CASE_MODRM_MEM_OP(6): /* xsaveopt / clwb */
             if (prefixes & PREFIX_LOCK) {
                 goto illegal_op;
             }
             if (prefixes & PREFIX_DATA) {
                 /* clwb */
                 if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_CLWB)) {
                     goto illegal_op;
                 }
                 gen_nop_modrm(env, s, modrm);
             } else {
                 /* xsaveopt */
                 if ((s->cpuid_ext_features & CPUID_EXT_XSAVE) == 0
                     || (s->cpuid_xsave_features & CPUID_XSAVE_XSAVEOPT) == 0
                     || (prefixes & (PREFIX_REPZ | PREFIX_REPNZ))) {
                     goto illegal_op;
                 }
                 gen_lea_modrm(env, s, modrm);
                 tcg_gen_concat_tl_i64(s->tmp1_i64, cpu_regs[R_EAX],
                                       cpu_regs[R_EDX]);
                 gen_helper_xsaveopt(tcg_env, s->A0, s->tmp1_i64);
             }
             break;
 
         CASE_MODRM_MEM_OP(7): /* clflush / clflushopt */
             if (prefixes & PREFIX_LOCK) {
                 goto illegal_op;
             }
             if (prefixes & PREFIX_DATA) {
                 /* clflushopt */
                 if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_CLFLUSHOPT)) {
                     goto illegal_op;
                 }
             } else {
                 /* clflush */
                 if ((s->prefix & (PREFIX_REPZ | PREFIX_REPNZ))
                     || !(s->cpuid_features & CPUID_CLFLUSH)) {
                     goto illegal_op;
                 }
             }
             gen_nop_modrm(env, s, modrm);
             break;
 
         case 0xc0 ... 0xc7: /* rdfsbase (f3 0f ae /0) */
         case 0xc8 ... 0xcf: /* rdgsbase (f3 0f ae /1) */
         case 0xd0 ... 0xd7: /* wrfsbase (f3 0f ae /2) */
         case 0xd8 ... 0xdf: /* wrgsbase (f3 0f ae /3) */
             if (CODE64(s)
                 && (prefixes & PREFIX_REPZ)
                 && !(prefixes & PREFIX_LOCK)
                 && (s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_FSGSBASE)) {
                 TCGv base, treg, src, dst;
 
                 /* Preserve hflags bits by testing CR4 at runtime.  */
                 tcg_gen_movi_i32(s->tmp2_i32, CR4_FSGSBASE_MASK);
                 gen_helper_cr4_testbit(tcg_env, s->tmp2_i32);
 
                 base = cpu_seg_base[modrm & 8 ? R_GS : R_FS];
                 treg = cpu_regs[(modrm & 7) | REX_B(s)];
 
                 if (modrm & 0x10) {
                     /* wr*base */
                     dst = base, src = treg;
                 } else {
                     /* rd*base */
                     dst = treg, src = base;
                 }
 
                 if (s->dflag == MO_32) {
                     tcg_gen_ext32u_tl(dst, src);
                 } else {
                     tcg_gen_mov_tl(dst, src);
                 }
                 break;
             }
             goto unknown_op;
 
         case 0xf8: /* sfence / pcommit */
             if (prefixes & PREFIX_DATA) {
                 /* pcommit */
                 if (!(s->cpuid_7_0_ebx_features & CPUID_7_0_EBX_PCOMMIT)
                     || (prefixes & PREFIX_LOCK)) {
                     goto illegal_op;
                 }
                 break;
             }
-            /* fallthru */
+            fallthrough;
         case 0xf9 ... 0xff: /* sfence */
             if (!(s->cpuid_features & CPUID_SSE)
                 || (prefixes & PREFIX_LOCK)) {
                 goto illegal_op;
             }
             tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
             break;
         case 0xe8 ... 0xef: /* lfence */
             if (!(s->cpuid_features & CPUID_SSE)
                 || (prefixes & PREFIX_LOCK)) {
                 goto illegal_op;
             }
             tcg_gen_mb(TCG_MO_LD_LD | TCG_BAR_SC);
             break;
         case 0xf0 ... 0xf7: /* mfence */
             if (!(s->cpuid_features & CPUID_SSE2)
                 || (prefixes & PREFIX_LOCK)) {
                 goto illegal_op;
             }
             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
             break;
 
         default:
             goto unknown_op;
         }
         break;
 
     case 0x10d: /* 3DNow! prefetch(w) */
         modrm = x86_ldub_code(env, s);
         mod = (modrm >> 6) & 3;
         if (mod == 3)
             goto illegal_op;
         gen_nop_modrm(env, s, modrm);
         break;
     case 0x1aa: /* rsm */
         gen_svm_check_intercept(s, SVM_EXIT_RSM);
         if (!(s->flags & HF_SMM_MASK))
             goto illegal_op;
 #ifdef CONFIG_USER_ONLY
         /* we should not be in SMM mode */
         g_assert_not_reached();
 #else
         gen_update_cc_op(s);
         gen_update_eip_next(s);
         gen_helper_rsm(tcg_env);
 #endif /* CONFIG_USER_ONLY */
         s->base.is_jmp = DISAS_EOB_ONLY;
         break;
     case 0x1b8: /* SSE4.2 popcnt */
         if ((prefixes & (PREFIX_REPZ | PREFIX_LOCK | PREFIX_REPNZ)) !=
              PREFIX_REPZ)
             goto illegal_op;
         if (!(s->cpuid_ext_features & CPUID_EXT_POPCNT))
             goto illegal_op;
 
         modrm = x86_ldub_code(env, s);
         reg = ((modrm >> 3) & 7) | REX_R(s);
 
         if (s->prefix & PREFIX_DATA) {
             ot = MO_16;
         } else {
             ot = mo_64_32(dflag);
         }
 
         gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 0);
         gen_extu(ot, s->T0);
         tcg_gen_mov_tl(cpu_cc_src, s->T0);
         tcg_gen_ctpop_tl(s->T0, s->T0);
         gen_op_mov_reg_v(s, ot, reg, s->T0);
 
         set_cc_op(s, CC_OP_POPCNT);
         break;
     case 0x10e ... 0x117:
     case 0x128 ... 0x12f:
     case 0x138 ... 0x13a:
     case 0x150 ... 0x179:
     case 0x17c ... 0x17f:
     case 0x1c2:
     case 0x1c4 ... 0x1c6:
     case 0x1d0 ... 0x1fe:
         disas_insn_new(s, cpu, b);
         break;
     default:
         goto unknown_op;
     }
     return true;
  illegal_op:
     gen_illegal_opcode(s);
     return true;
  unknown_op:
     gen_unknown_opcode(env, s);
     return true;
 }
@@ -7036,31 +7035,30 @@ static void i386_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
     switch (dc->base.is_jmp) {
     case DISAS_NORETURN:
         break;
     case DISAS_TOO_MANY:
         gen_update_cc_op(dc);
         gen_jmp_rel_csize(dc, 0, 0);
         break;
     case DISAS_EOB_NEXT:
         gen_update_cc_op(dc);
         gen_update_eip_cur(dc);
-        /* fall through */
         fallthrough;
     case DISAS_EOB_ONLY:
         gen_eob(dc);
         break;
     case DISAS_EOB_INHIBIT_IRQ:
         gen_update_cc_op(dc);
         gen_update_eip_cur(dc);
         gen_eob_inhibit_irq(dc, true);
         break;
     case DISAS_JUMP:
         gen_jr(dc);
         break;
     default:
         g_assert_not_reached();
     }
 }
-- 
2.39.2



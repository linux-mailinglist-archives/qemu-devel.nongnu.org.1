Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA1377910A
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 15:52:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUSY4-0000eC-Ma; Fri, 11 Aug 2023 09:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qUSY3-0000e3-Qi
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 09:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qUSY1-00033C-El
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 09:51:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691761884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFUTMXmvEsnamBPyUcPeHy5K4JdEEVddvLoNVqVP9qQ=;
 b=MnX08bk9TilS0PTsem++iusb8DnSfVikuCSEkgHw90NmDIi3G2h6efCzxz/twHhN/7eFnW
 5xmiEi0kOAqEukxjal1RHWNIGo4liC9wVXRCLZw1qJh+C0bYLfYrEPAqzU50jZGGwyQWbq
 3Jgi4MmWgNgPxvtgWczEcztJew1Z+VE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-618-oWRyE8aINQu4Pe9WV4mGeA-1; Fri, 11 Aug 2023 09:50:15 -0400
X-MC-Unique: oWRyE8aINQu4Pe9WV4mGeA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7DF7833949
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 13:50:15 +0000 (UTC)
Received: from work.redhat.com (unknown [10.39.193.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3C252140E96D;
 Fri, 11 Aug 2023 13:50:15 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH 3/4] target/i386: Format feature_word_info.c.inc
Date: Fri, 11 Aug 2023 15:50:10 +0200
Message-Id: <20230811135011.23343-4-twiederh@redhat.com>
In-Reply-To: <20230811135011.23343-1-twiederh@redhat.com>
References: <20230811135011.23343-1-twiederh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=twiederh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Harmonize the formatting: Use trailing commas, fix indentation and
empty line usage, define "cpuid" fields one per line, unwind index-
assignment in arrays, and remove comments. The information in the
comments is preserved in the xml file.

Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
---
 target/i386/feature_word_info.c.inc | 230 ++++++++++++++++------------
 1 file changed, 128 insertions(+), 102 deletions(-)

diff --git a/target/i386/feature_word_info.c.inc b/target/i386/feature_word_info.c.inc
index bba7975eab..040c3c4e56 100644
--- a/target/i386/feature_word_info.c.inc
+++ b/target/i386/feature_word_info.c.inc
@@ -6,47 +6,51 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "tsc", "msr", "pae", "mce",
             "cx8", "apic", NULL, "sep",
             "mtrr", "pge", "mca", "cmov",
-            "pat", "pse36", "pn" /* Intel psn */, "clflush" /* Intel clfsh */,
-            NULL, "ds" /* Intel dts */, "acpi", "mmx",
+            "pat", "pse36", "pn", "clflush",
+            NULL, "ds", "acpi", "mmx",
             "fxsr", "sse", "sse2", "ss",
-            "ht" /* Intel htt */, "tm", "ia64", "pbe",
+            "ht", "tm", "ia64", "pbe",
+        },
+        .cpuid = {
+            .eax = 1,
+            .reg = R_EDX,
         },
-        .cpuid = {.eax = 1, .reg = R_EDX, },
         .tcg_features = TCG_FEATURES,
     },
     [FEAT_1_ECX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            "pni" /* Intel,AMD sse3 */, "pclmulqdq", "dtes64", "monitor",
+            "pni", "pclmulqdq", "dtes64", "monitor",
             "ds-cpl", "vmx", "smx", "est",
             "tm2", "ssse3", "cid", NULL,
             "fma", "cx16", "xtpr", "pdcm",
             NULL, "pcid", "dca", "sse4.1",
             "sse4.2", "x2apic", "movbe", "popcnt",
-            "tsc-deadline", "aes", "xsave", NULL /* osxsave */,
+            "tsc-deadline", "aes", "xsave", NULL,
             "avx", "f16c", "rdrand", "hypervisor",
         },
-        .cpuid = { .eax = 1, .reg = R_ECX, },
+        .cpuid = {
+            .eax = 1,
+            .reg = R_ECX,
+        },
         .tcg_features = TCG_EXT_FEATURES,
     },
-    /* Feature names that are already defined on feature_name[] but
-     * are set on CPUID[8000_0001].EDX on AMD CPUs don't have their
-     * names on feat_names below. They are copied automatically
-     * to features[FEAT_8000_0001_EDX] if and only if CPU vendor is AMD.
-     */
     [FEAT_8000_0001_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            NULL /* fpu */, NULL /* vme */, NULL /* de */, NULL /* pse */,
-            NULL /* tsc */, NULL /* msr */, NULL /* pae */, NULL /* mce */,
-            NULL /* cx8 */, NULL /* apic */, NULL, "syscall",
-            NULL /* mtrr */, NULL /* pge */, NULL /* mca */, NULL /* cmov */,
-            NULL /* pat */, NULL /* pse36 */, NULL, NULL /* Linux mp */,
-            "nx", NULL, "mmxext", NULL /* mmx */,
-            NULL /* fxsr */, "fxsr-opt", "pdpe1gb", "rdtscp",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, "syscall",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            "nx", NULL, "mmxext", NULL,
+            NULL, "fxsr-opt", "pdpe1gb", "rdtscp",
             NULL, "lm", "3dnowext", "3dnow",
         },
-        .cpuid = { .eax = 0x80000001, .reg = R_EDX, },
+        .cpuid = {
+            .eax = 0x80000001,
+            .reg = R_EDX,
+        },
         .tcg_features = TCG_EXT2_FEATURES,
     },
     [FEAT_8000_0001_ECX] = {
@@ -61,13 +65,11 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "perfctr-nb", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 0x80000001, .reg = R_ECX, },
+        .cpuid = {
+            .eax = 0x80000001,
+            .reg = R_ECX,
+        },
         .tcg_features = TCG_EXT3_FEATURES,
-        /*
-         * TOPOEXT is always allowed but can't be enabled blindly by
-         * "-cpu host", as it requires consistent cache topology info
-         * to be provided so it doesn't confuse guests.
-         */
         .no_autoenable_flags = CPUID_EXT3_TOPOEXT,
     },
     [FEAT_C000_0001_EDX] = {
@@ -82,7 +84,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 0xC0000001, .reg = R_EDX, },
+        .cpuid = {
+            .eax = 0xC0000001,
+            .reg = R_EDX,
+        },
         .tcg_features = TCG_EXT4_FEATURES,
     },
     [FEAT_KVM] = {
@@ -97,7 +102,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "kvmclock-stable-bit", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = KVM_CPUID_FEATURES, .reg = R_EAX, },
+        .cpuid = {
+            .eax = KVM_CPUID_FEATURES,
+            .reg = R_EAX,
+        },
         .tcg_features = TCG_KVM_FEATURES,
     },
     [FEAT_KVM_HINTS] = {
@@ -112,19 +120,18 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = KVM_CPUID_FEATURES, .reg = R_EDX, },
+        .cpuid = {
+            .eax = KVM_CPUID_FEATURES,
+            .reg = R_EDX,
+        },
         .tcg_features = TCG_KVM_FEATURES,
-        /*
-         * KVM hints aren't auto-enabled by -cpu host, they need to be
-         * explicitly enabled in the command-line.
-         */
         .no_autoenable_flags = ~0U,
     },
     [FEAT_SVM] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "npt", "lbrv", "svm-lock", "nrip-save",
-            "tsc-scale", "vmcb-clean",  "flushbyasid", "decodeassists",
+            "tsc-scale", "vmcb-clean", "flushbyasid", "decodeassists",
             NULL, NULL, "pause-filter", NULL,
             "pfthreshold", "avic", NULL, "v-vmsave-vmload",
             "vgif", NULL, NULL, NULL,
@@ -132,7 +139,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, "vnmi", NULL, NULL,
             "svme-addr-chk", NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 0x8000000A, .reg = R_EDX, },
+        .cpuid = {
+            .eax = 0x8000000A,
+            .reg = R_EDX,
+        },
         .tcg_features = TCG_SVM_FEATURES,
     },
     [FEAT_7_0_EBX] = {
@@ -149,7 +159,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EBX,
         },
         .tcg_features = TCG_7_0_EBX_FEATURES,
@@ -158,7 +169,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, "avx512vbmi", "umip", "pku",
-            NULL /* ospke */, "waitpkg", "avx512vbmi2", NULL,
+            NULL, "waitpkg", "avx512vbmi2", NULL,
             "gfni", "vaes", "vpclmulqdq", "avx512vnni",
             "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
             "la57", NULL, NULL, NULL,
@@ -168,7 +179,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_ECX,
         },
         .tcg_features = TCG_7_0_ECX_FEATURES,
@@ -180,14 +192,15 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "fsrm", NULL, NULL, NULL,
             "avx512-vp2intersect", NULL, "md-clear", NULL,
             NULL, NULL, "serialize", NULL,
-            "tsx-ldtrk", NULL, NULL /* pconfig */, "arch-lbr",
+            "tsx-ldtrk", NULL, NULL, "arch-lbr",
             NULL, NULL, "amx-bf16", "avx512-fp16",
             "amx-tile", "amx-int8", "spec-ctrl", "stibp",
             "flush-l1d", "arch-capabilities", "core-capability", "ssbd",
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EDX,
         },
         .tcg_features = TCG_7_0_EDX_FEATURES,
@@ -206,7 +219,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 1,
+            .needs_ecx = true,
+            .ecx = 1,
             .reg = R_EAX,
         },
         .tcg_features = TCG_7_1_EAX_FEATURES,
@@ -225,7 +239,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 1,
+            .needs_ecx = true,
+            .ecx = 1,
             .reg = R_EDX,
         },
         .tcg_features = TCG_7_1_EDX_FEATURES,
@@ -244,7 +259,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 2,
+            .needs_ecx = true,
+            .ecx = 2,
             .reg = R_EDX,
         },
         .tcg_features = TCG_7_2_EDX_FEATURES,
@@ -261,7 +277,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 0x80000007, .reg = R_EDX, },
+        .cpuid = {
+            .eax = 0x80000007,
+            .reg = R_EDX,
+        },
         .tcg_features = TCG_APM_FEATURES,
         .unmigratable_flags = CPUID_APM_INVTSC,
     },
@@ -277,7 +296,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "amd-ssbd", "virt-ssbd", "amd-no-ssb", NULL,
             "amd-psfd", NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 0x80000008, .reg = R_EBX, },
+        .cpuid = {
+            .eax = 0x80000008,
+            .reg = R_EBX,
+        },
         .tcg_features = TCG_8000_0008_EBX,
         .unmigratable_flags = 0,
     },
@@ -293,7 +315,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 0x80000021, .reg = R_EAX, },
+        .cpuid = {
+            .eax = 0x80000021,
+            .reg = R_EAX,
+        },
         .tcg_features = 0,
         .unmigratable_flags = 0,
     },
@@ -311,7 +336,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 0xd,
-            .needs_ecx = true, .ecx = 1,
+            .needs_ecx = true,
+            .ecx = 1,
             .reg = R_EAX,
         },
         .tcg_features = TCG_XSAVE_FEATURES,
@@ -341,7 +367,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .eax = 0xD,
             .needs_ecx = true,
             .ecx = 1,
-            .reg = R_EDX
+            .reg = R_EDX,
         },
     },
     [FEAT_6_EAX] = {
@@ -356,32 +382,33 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 6, .reg = R_EAX, },
+        .cpuid = {
+            .eax = 6,
+            .reg = R_EAX,
+        },
         .tcg_features = TCG_6_EAX_FEATURES,
     },
     [FEAT_XSAVE_XCR0_LO] = {
         .type = CPUID_FEATURE_WORD,
         .cpuid = {
             .eax = 0xD,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EAX,
         },
         .tcg_features = ~0U,
-        .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
-            XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
-            XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
-            XSTATE_PKRU_MASK,
+        .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK | XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK | XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK | XSTATE_PKRU_MASK,
     },
     [FEAT_XSAVE_XCR0_HI] = {
         .type = CPUID_FEATURE_WORD,
         .cpuid = {
             .eax = 0xD,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EDX,
         },
         .tcg_features = ~0U,
     },
-    /*Below are MSR exposed features*/
     [FEAT_ARCH_CAPABILITIES] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -397,12 +424,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .msr = {
             .index = MSR_IA32_ARCH_CAPABILITIES,
         },
-        /*
-         * FEAT_ARCH_CAPABILITIES only affects a read-only MSR, which
-         * cannot be read from user mode.  Therefore, it has no impact
-         > on any user-mode operation, and warnings about unsupported
-         * features do not matter.
-         */
         .tcg_features = ~0U,
     },
     [FEAT_CORE_CAPABILITY] = {
@@ -437,7 +458,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .index = MSR_IA32_PERF_CAPABILITIES,
         },
     },
-
     [FEAT_VMX_PROCBASED_CTLS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -452,9 +472,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_PROCBASED_CTLS,
-        }
+        },
     },
-
     [FEAT_VMX_SECONDARY_CTLS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -469,9 +488,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_VMX_PROCBASED_CTLS2,
-        }
+        },
     },
-
     [FEAT_VMX_PINBASED_CTLS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -486,31 +504,24 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_PINBASED_CTLS,
-        }
+        },
     },
-
     [FEAT_VMX_EXIT_CTLS] = {
         .type = MSR_FEATURE_WORD,
-        /*
-         * VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE is copied from
-         * the LM CPUID bit.
-         */
         .feat_names = {
             NULL, NULL, "vmx-exit-nosave-debugctl", NULL,
             NULL, NULL, NULL, NULL,
-            NULL, NULL /* vmx-exit-host-addr-space-size */, NULL, NULL,
+            NULL, NULL, NULL, NULL,
             "vmx-exit-load-perf-global-ctrl", NULL, NULL, "vmx-exit-ack-intr",
             NULL, NULL, "vmx-exit-save-pat", "vmx-exit-load-pat",
-            "vmx-exit-save-efer", "vmx-exit-load-efer",
-                "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
+            "vmx-exit-save-efer", "vmx-exit-load-efer", "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
             NULL, "vmx-exit-clear-rtit-ctl", NULL, NULL,
             NULL, "vmx-exit-load-pkrs", NULL, NULL,
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_EXIT_CTLS,
-        }
+        },
     },
-
     [FEAT_VMX_ENTRY_CTLS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -525,9 +536,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_ENTRY_CTLS,
-        }
+        },
     },
-
     [FEAT_VMX_MISC] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -542,9 +552,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_VMX_MISC,
-        }
+        },
     },
-
     [FEAT_VMX_EPT_VPID_CAPS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -558,8 +567,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             "vmx-invvpid", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            "vmx-invvpid-single-addr", "vmx-invept-single-context",
-                "vmx-invvpid-all-context", "vmx-invept-single-context-noglobals",
+            "vmx-invvpid-single-addr", "vmx-invept-single-context", "vmx-invvpid-all-context", "vmx-invept-single-context-noglobals",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -568,32 +576,49 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_VMX_EPT_VPID_CAP,
-        }
+        },
     },
-
     [FEAT_VMX_BASIC] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
-            [54] = "vmx-ins-outs",
-            [55] = "vmx-true-ctls",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, "vmx-ins-outs", "vmx-true-ctls",
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
         },
         .msr = {
             .index = MSR_IA32_VMX_BASIC,
         },
-        /* Just to be safe - we don't support setting the MSEG version field.  */
         .no_autoenable_flags = MSR_VMX_BASIC_DUAL_MONITOR,
     },
-
     [FEAT_VMX_VMFUNC] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
-            [0] = "vmx-eptp-switching",
+            "vmx-eptp-switching", NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
         },
         .msr = {
             .index = MSR_IA32_VMX_VMFUNC,
-        }
+        },
     },
-
     [FEAT_14_0_ECX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -608,12 +633,12 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 0x14,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_ECX,
         },
         .tcg_features = TCG_14_0_ECX_FEATURES,
-     },
-
+    },
     [FEAT_SGX_12_0_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -628,16 +653,16 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 0x12,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EAX,
         },
         .tcg_features = TCG_SGX_12_0_EAX_FEATURES,
     },
-
     [FEAT_SGX_12_0_EBX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            "sgx-exinfo" , NULL, NULL, NULL,
+            "sgx-exinfo", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -648,12 +673,12 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 0x12,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EBX,
         },
         .tcg_features = TCG_SGX_12_0_EBX_FEATURES,
     },
-
     [FEAT_SGX_12_1_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -668,7 +693,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 0x12,
-            .needs_ecx = true, .ecx = 1,
+            .needs_ecx = true,
+            .ecx = 1,
             .reg = R_EAX,
         },
         .tcg_features = TCG_SGX_12_1_EAX_FEATURES,
-- 
2.39.2



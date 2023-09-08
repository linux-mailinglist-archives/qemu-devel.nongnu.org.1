Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4AB798754
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:47:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeasG-0003jd-JP; Fri, 08 Sep 2023 08:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qeasB-0003h3-B3
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qeas6-0006LA-Tr
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694177145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=drc63C8ZcWUOxriNZ3UVxlK0ByUnKTd46gaXlKxEsI0=;
 b=TdL7W0cnoN6UyrB93NNWrw4jFrZP2vD8MpJ2gMna9SpuVg3qroiLd6zbw/8shOXRWlKVuc
 RUR2mGD5eUoDllPML2jlOPYTJpws8AIXjE3UGaXJVsWbm/X78hyeSm3IF3+0vmtKZipDnn
 i3oYx4rgYThSts5dFuiSoLeXqgdAGy8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-W8X-oejLP4SZ62oYaBIS1Q-1; Fri, 08 Sep 2023 08:45:43 -0400
X-MC-Unique: W8X-oejLP4SZ62oYaBIS1Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 502C9101CA89;
 Fri,  8 Sep 2023 12:45:43 +0000 (UTC)
Received: from work.redhat.com (unknown [10.39.194.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6917A20BAE72;
 Fri,  8 Sep 2023 12:45:42 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH v2 06/10] target/i386: Format feature_word_info.c.inc: Remove
 comments
Date: Fri,  8 Sep 2023 14:45:30 +0200
Message-Id: <20230908124534.25027-7-twiederh@redhat.com>
In-Reply-To: <20230908124534.25027-1-twiederh@redhat.com>
References: <20230908124534.25027-1-twiederh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=twiederh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The comments are preserved in the yaml file.

Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
---
 target/i386/feature_word_info.c.inc | 56 ++++++++---------------------
 1 file changed, 15 insertions(+), 41 deletions(-)

diff --git a/target/i386/feature_word_info.c.inc b/target/i386/feature_word_info.c.inc
index d4462d7b1f..1d7eae9130 100644
--- a/target/i386/feature_word_info.c.inc
+++ b/target/i386/feature_word_info.c.inc
@@ -6,10 +6,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
         },
         .cpuid = {.eax = 1, .reg = R_EDX, },
         .tcg_features = TCG_FEATURES,
@@ -17,33 +17,28 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
         .cpuid = { .eax = 1, .reg = R_ECX, },
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
         .cpuid = { .eax = 0x80000001, .reg = R_EDX, },
@@ -63,11 +58,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = { .eax = 0x80000001, .reg = R_ECX, },
         .tcg_features = TCG_EXT3_FEATURES,
-        /*
-         * TOPOEXT is always allowed but can't be enabled blindly by
-         * "-cpu host", as it requires consistent cache topology info
-         * to be provided so it doesn't confuse guests.
-         */
         .no_autoenable_flags = CPUID_EXT3_TOPOEXT,
     },
     [FEAT_C000_0001_EDX] = {
@@ -114,10 +104,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = { .eax = KVM_CPUID_FEATURES, .reg = R_EDX, },
         .tcg_features = TCG_KVM_FEATURES,
-        /*
-         * KVM hints aren't auto-enabled by -cpu host, they need to be
-         * explicitly enabled in the command-line.
-         */
         .no_autoenable_flags = ~0U,
     },
     [FEAT_SVM] = {
@@ -158,7 +144,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             NULL, "avx512vbmi", "umip", "pku",
-            NULL /* ospke */, "waitpkg", "avx512vbmi2", NULL,
+            NULL, "waitpkg", "avx512vbmi2", NULL,
             "gfni", "vaes", "vpclmulqdq", "avx512vnni",
             "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
             "la57", NULL, NULL, NULL,
@@ -180,7 +166,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "fsrm", NULL, NULL, NULL,
             "avx512-vp2intersect", NULL, "md-clear", NULL,
             NULL, NULL, "serialize", NULL,
-            "tsx-ldtrk", NULL, NULL /* pconfig */, "arch-lbr",
+            "tsx-ldtrk", NULL, NULL, "arch-lbr",
             NULL, NULL, "amx-bf16", "avx512-fp16",
             "amx-tile", "amx-int8", "spec-ctrl", "stibp",
             "flush-l1d", "arch-capabilities", "core-capability", "ssbd",
@@ -381,7 +367,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = ~0U,
     },
-    /*Below are MSR exposed features*/
     [FEAT_ARCH_CAPABILITIES] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -397,12 +382,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
@@ -491,14 +470,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
 
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
             "vmx-exit-save-efer", "vmx-exit-load-efer",
@@ -580,7 +555,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .msr = {
             .index = MSR_IA32_VMX_BASIC,
         },
-        /* Just to be safe - we don't support setting the MSEG version field.  */
         .no_autoenable_flags = MSR_VMX_BASIC_DUAL_MONITOR,
     },
 
-- 
2.39.2



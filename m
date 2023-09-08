Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D54798750
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:47:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeasQ-0003tv-Rf; Fri, 08 Sep 2023 08:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qeasD-0003ig-3y
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qeas6-0006LS-UA
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694177149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Xc+o7+fNdaTWsUTme+0KqsdGzH9ed0FqOKqu4AbJDY=;
 b=F+z2AaWeJDqev8tLIa8vpk6W+pdOX8wh/hJ0M6j01wZ/mSZ9yUbotsZztgc/TDs8EndU3h
 XKzcWagrmHddXDCcVgGAIB0tGz+ml7gTntQyUZR0NkmLEqG75CzmwzM80hafUeK6A1Qfen
 lNrAa8kPQeUkb2f/hLmHPe18jldCXxs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-317-8bLaTEFSNk2A8I_HAopv1A-1; Fri, 08 Sep 2023 08:45:46 -0400
X-MC-Unique: 8bLaTEFSNk2A8I_HAopv1A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4E0B281224A;
 Fri,  8 Sep 2023 12:45:45 +0000 (UTC)
Received: from work.redhat.com (unknown [10.39.194.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B617C21EE56B;
 Fri,  8 Sep 2023 12:45:44 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH v2 08/10] target/i386: Format feature_word_info.c.inc: Unfold
 cpuid member
Date: Fri,  8 Sep 2023 14:45:32 +0200
Message-Id: <20230908124534.25027-9-twiederh@redhat.com>
In-Reply-To: <20230908124534.25027-1-twiederh@redhat.com>
References: <20230908124534.25027-1-twiederh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

Having a consistent formatting minimizes the diff to the generated
code.

Signed-off-by: Tim Wiederhake <twiederh@redhat.com>
---
 target/i386/feature_word_info.c.inc | 101 +++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 26 deletions(-)

diff --git a/target/i386/feature_word_info.c.inc b/target/i386/feature_word_info.c.inc
index 1f28c3f66e..c154a2b0cf 100644
--- a/target/i386/feature_word_info.c.inc
+++ b/target/i386/feature_word_info.c.inc
@@ -19,7 +19,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = {.eax = 1, .reg = R_EDX, },
+        .cpuid = {
+            .eax = 1,
+            .reg = R_EDX,
+        },
         .tcg_features = TCG_FEATURES,
     },
     [FEAT_1_ECX] = {
@@ -42,7 +45,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 1, .reg = R_ECX, },
+        .cpuid = {
+            .eax = 1,
+            .reg = R_ECX,
+        },
         .tcg_features = TCG_EXT_FEATURES,
     },
     [FEAT_8000_0001_EDX] = {
@@ -65,7 +71,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 0x80000001, .reg = R_EDX, },
+        .cpuid = {
+            .eax = 0x80000001,
+            .reg = R_EDX,
+        },
         .tcg_features = TCG_EXT2_FEATURES,
     },
     [FEAT_8000_0001_ECX] = {
@@ -88,7 +97,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 0x80000001, .reg = R_ECX, },
+        .cpuid = {
+            .eax = 0x80000001,
+            .reg = R_ECX,
+        },
         .tcg_features = TCG_EXT3_FEATURES,
         .no_autoenable_flags = CPUID_EXT3_TOPOEXT,
     },
@@ -112,7 +124,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
@@ -135,7 +150,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
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
@@ -158,7 +176,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = KVM_CPUID_FEATURES, .reg = R_EDX, },
+        .cpuid = {
+            .eax = KVM_CPUID_FEATURES,
+            .reg = R_EDX,
+        },
         .tcg_features = TCG_KVM_FEATURES,
         .no_autoenable_flags = ~0U,
     },
@@ -182,7 +203,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 0x8000000A, .reg = R_EDX, },
+        .cpuid = {
+            .eax = 0x8000000A,
+            .reg = R_EDX,
+        },
         .tcg_features = TCG_SVM_FEATURES,
     },
     [FEAT_7_0_EBX] = {
@@ -207,7 +231,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EBX,
         },
         .tcg_features = TCG_7_0_EBX_FEATURES,
@@ -234,7 +259,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_ECX,
         },
         .tcg_features = TCG_7_0_ECX_FEATURES,
@@ -261,7 +287,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EDX,
         },
         .tcg_features = TCG_7_0_EDX_FEATURES,
@@ -288,7 +315,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 1,
+            .needs_ecx = true,
+            .ecx = 1,
             .reg = R_EAX,
         },
         .tcg_features = TCG_7_1_EAX_FEATURES,
@@ -315,7 +343,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 1,
+            .needs_ecx = true,
+            .ecx = 1,
             .reg = R_EDX,
         },
         .tcg_features = TCG_7_1_EDX_FEATURES,
@@ -342,7 +371,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 7,
-            .needs_ecx = true, .ecx = 2,
+            .needs_ecx = true,
+            .ecx = 2,
             .reg = R_EDX,
         },
         .tcg_features = TCG_7_2_EDX_FEATURES,
@@ -367,7 +397,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
@@ -391,7 +424,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
         },
-        .cpuid = { .eax = 0x80000008, .reg = R_EBX, },
+        .cpuid = {
+            .eax = 0x80000008,
+            .reg = R_EBX,
+        },
         .tcg_features = TCG_8000_0008_EBX,
         .unmigratable_flags = 0,
     },
@@ -415,7 +451,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
@@ -441,7 +480,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 0xd,
-            .needs_ecx = true, .ecx = 1,
+            .needs_ecx = true,
+            .ecx = 1,
             .reg = R_EAX,
         },
         .tcg_features = TCG_XSAVE_FEATURES,
@@ -497,7 +537,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .eax = 0xD,
             .needs_ecx = true,
             .ecx = 1,
-            .reg = R_EDX
+            .reg = R_EDX,
         },
     },
     [FEAT_6_EAX] = {
@@ -520,7 +560,10 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
@@ -545,7 +588,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 0xD,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EAX,
         },
         .tcg_features = ~0U,
@@ -576,7 +620,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 0xD,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EDX,
         },
         .tcg_features = ~0U,
@@ -905,7 +950,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 0x14,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_ECX,
         },
         .tcg_features = TCG_14_0_ECX_FEATURES,
@@ -933,7 +979,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 0x12,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EAX,
         },
         .tcg_features = TCG_SGX_12_0_EAX_FEATURES,
@@ -961,7 +1008,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid = {
             .eax = 0x12,
-            .needs_ecx = true, .ecx = 0,
+            .needs_ecx = true,
+            .ecx = 0,
             .reg = R_EBX,
         },
         .tcg_features = TCG_SGX_12_0_EBX_FEATURES,
@@ -989,7 +1037,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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



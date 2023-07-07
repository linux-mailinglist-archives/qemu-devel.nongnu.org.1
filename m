Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8A274B2A9
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 16:06:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHm4u-0007EA-P6; Fri, 07 Jul 2023 10:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHm4n-0007CN-Hg
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHm4l-0006OF-LZ
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688738687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=biETb/bxutU3u9+BoQ/mwaEgl71G5m+SJ1MdIoGr0/o=;
 b=iL5B0TqvFfOOTnGRMzzqy2GKmr+xj+OQsOkjEjQiDAxLx98AqPLCYBw8Exdqbx9jQhCfKU
 KE8nwXuUcK04ONDL9FIZZKeLCwSPyB0jaWMvf34HhcIy6UHCufA8EXX1AsZRSw0r/MbZ+v
 y/KUyvn9bqWCs8xjBNawMaNsBFfmWiw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-Qm-M2ct7MqOw8kA69Ua7vg-1; Fri, 07 Jul 2023 10:04:45 -0400
X-MC-Unique: Qm-M2ct7MqOw8kA69Ua7vg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-98df34aa83aso353872266b.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 07:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688738683; x=1691330683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=biETb/bxutU3u9+BoQ/mwaEgl71G5m+SJ1MdIoGr0/o=;
 b=NlCqoF+ArFVEUNAUscWT3qoPVZ9KxpY07z5CDOMyGg2UwTI3HLSBp2zQ/9SEh08ZOc
 4nlt5qFEP5Aq7ua5czBjykfhMrhlvHXJ5rwX7roG54Etyh3jLU+NU0EBmbH/90Aw3mH9
 enNIOLRDBDKSHhi3v+dYi971ceRIVZ8XOjSD7k6vyVuEBMyVBh+hObTChzk3o6ur68/2
 wH3FVp5xsV6xGX9hqis52kr7HT7dOVOgoGfguniK/0WNj4JW5ZDeQSuHU1HqCucLp83v
 JISCsYwKFOj4YoYxe655t/vL65HEFnW6NSPOeSkY21nTTwpZ5ihJzbfaJq8EaZgJRdBd
 JZTg==
X-Gm-Message-State: ABy/qLaxI1ONcKBD+NN4/NLJXUqTsbFhn/eGB7gtXvWkGoz5HEqwYKbL
 jUDTvJNtvnNNl1ZTgkpnr5QVXKhsIXNaRY5G74PQpRjnLlQ1AyOYq5xvlJ+/chqvRuOQLsSwbgJ
 WLqUnmxkmIVaL+WUOHaRg/5+axqIqBrIlP9WXkiKE+blBBLR2kq3AMqSUta8cfH6c4qvP1qCxxX
 U=
X-Received: by 2002:a17:906:51c8:b0:992:88d2:a6c5 with SMTP id
 v8-20020a17090651c800b0099288d2a6c5mr5819383ejk.11.1688738682977; 
 Fri, 07 Jul 2023 07:04:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHNJ7WRHd4obDhwsVrxpv/4o+YHLrXGqAr6kTArxxsAWASTfbeDkxs9Xso2KdyVHORcdd2j5g==
X-Received: by 2002:a17:906:51c8:b0:992:88d2:a6c5 with SMTP id
 v8-20020a17090651c800b0099288d2a6c5mr5819356ejk.11.1688738682682; 
 Fri, 07 Jul 2023 07:04:42 -0700 (PDT)
Received: from [192.168.122.1] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 gz2-20020a170906f2c200b0098d2d219649sm2251912ejb.174.2023.07.07.07.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 07:04:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 5/9] target/i386: Add support for MCDT_NO in CPUID enumeration
Date: Fri,  7 Jul 2023 16:04:28 +0200
Message-ID: <20230707140432.88073-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707140432.88073-1-pbonzini@redhat.com>
References: <20230707140432.88073-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Tao Su <tao1.su@linux.intel.com>

CPUID.(EAX=7,ECX=2):EDX[bit 5] enumerates MCDT_NO. Processors enumerate
this bit as 1 do not exhibit MXCSR Configuration Dependent Timing (MCDT)
behavior and do not need to be mitigated to avoid data-dependent behavior
for certain instructions.

Since MCDT_NO is in a new sub-leaf, add a new CPUID feature word
FEAT_7_2_EDX. Also update cpuid_level_func7 by FEAT_7_2_EDX.

Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20230706054949.66556-3-tao1.su@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 26 ++++++++++++++++++++++++++
 target/i386/cpu.h |  4 ++++
 2 files changed, 30 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 952744af97c..852c45b9658 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -739,6 +739,7 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_7_1_EAX_FEATURES (CPUID_7_1_EAX_FZRM | CPUID_7_1_EAX_FSRS | \
           CPUID_7_1_EAX_FSRC)
 #define TCG_7_1_EDX_FEATURES 0
+#define TCG_7_2_EDX_FEATURES 0
 #define TCG_APM_FEATURES 0
 #define TCG_6_EAX_FEATURES CPUID_6_EAX_ARAT
 #define TCG_XSAVE_FEATURES (CPUID_XSAVE_XSAVEOPT | CPUID_XSAVE_XGETBV1)
@@ -993,6 +994,25 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_7_1_EDX_FEATURES,
     },
+    [FEAT_7_2_EDX] = {
+        .type = CPUID_FEATURE_WORD,
+        .feat_names = {
+            NULL, NULL, NULL, NULL,
+            NULL, "mcdt-no", NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+            NULL, NULL, NULL, NULL,
+        },
+        .cpuid = {
+            .eax = 7,
+            .needs_ecx = true, .ecx = 2,
+            .reg = R_EDX,
+        },
+        .tcg_features = TCG_7_2_EDX_FEATURES,
+    },
     [FEAT_8000_0007_EDX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -6017,6 +6037,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *edx = env->features[FEAT_7_1_EDX];
             *ebx = 0;
             *ecx = 0;
+        } else if (count == 2) {
+            *edx = env->features[FEAT_7_2_EDX];
+            *eax = 0;
+            *ebx = 0;
+            *ecx = 0;
         } else {
             *eax = 0;
             *ebx = 0;
@@ -6881,6 +6906,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         x86_cpu_adjust_feat_level(cpu, FEAT_7_0_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EAX);
         x86_cpu_adjust_feat_level(cpu, FEAT_7_1_EDX);
+        x86_cpu_adjust_feat_level(cpu, FEAT_7_2_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_EDX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0001_ECX);
         x86_cpu_adjust_feat_level(cpu, FEAT_8000_0007_EDX);
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 2c9b0d2ebcf..c196b0a4826 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -628,6 +628,7 @@ typedef enum FeatureWord {
     FEAT_XSAVE_XSS_LO,     /* CPUID[EAX=0xd,ECX=1].ECX */
     FEAT_XSAVE_XSS_HI,     /* CPUID[EAX=0xd,ECX=1].EDX */
     FEAT_7_1_EDX,       /* CPUID[EAX=7,ECX=1].EDX */
+    FEAT_7_2_EDX,       /* CPUID[EAX=7,ECX=2].EDX */
     FEATURE_WORDS,
 } FeatureWord;
 
@@ -932,6 +933,9 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 /* PREFETCHIT0/1 Instructions */
 #define CPUID_7_1_EDX_PREFETCHITI       (1U << 14)
 
+/* Do not exhibit MXCSR Configuration Dependent Timing (MCDT) behavior */
+#define CPUID_7_2_EDX_MCDT_NO           (1U << 5)
+
 /* XFD Extend Feature Disabled */
 #define CPUID_D_1_EAX_XFD               (1U << 4)
 
-- 
2.41.0



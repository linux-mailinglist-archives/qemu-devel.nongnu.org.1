Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ADB798757
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:48:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeasH-0003lX-Vn; Fri, 08 Sep 2023 08:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qeasE-0003jD-Di
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qeas5-0006Lm-U4
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694177150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8R8sdwErNXOISyu2acerni+tRQFccjE0EjJm6SaSwQ=;
 b=clsT0w9ywSGLL50AFq9HC04YTx+RhJx05XmA/ErLiWEYDxmLloe2/vy0AzaYo6fDmkhlY7
 hiGuYA86Vp82nTxiIdTjcZ7WA1w+oFyIqtSUdpko3xgage+/ENcx9uwQLcSuPxaShCWQrw
 7IHEIjFsjquxmQrJQq9LklGhj/XQsaY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-ydN-sNglOKWKfDPIs9ewvQ-1; Fri, 08 Sep 2023 08:45:47 -0400
X-MC-Unique: ydN-sNglOKWKfDPIs9ewvQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7603917EAC;
 Fri,  8 Sep 2023 12:45:46 +0000 (UTC)
Received: from work.redhat.com (unknown [10.39.194.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E029521EE56A;
 Fri,  8 Sep 2023 12:45:45 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH v2 09/10] target/i386: Format feature_word_info.c.inc:
 Whitespaces and trailing commas
Date: Fri,  8 Sep 2023 14:45:33 +0200
Message-Id: <20230908124534.25027-10-twiederh@redhat.com>
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
 target/i386/feature_word_info.c.inc | 44 +++++++++--------------------
 1 file changed, 13 insertions(+), 31 deletions(-)

diff --git a/target/i386/feature_word_info.c.inc b/target/i386/feature_word_info.c.inc
index c154a2b0cf..5bac4aaeba 100644
--- a/target/i386/feature_word_info.c.inc
+++ b/target/i386/feature_word_info.c.inc
@@ -187,7 +187,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
             "npt", "lbrv", "svm-lock", "nrip-save",
-            "tsc-scale", "vmcb-clean",  "flushbyasid", "decodeassists",
+            "tsc-scale", "vmcb-clean", "flushbyasid", "decodeassists",
             NULL, NULL, "pause-filter", NULL,
             "pfthreshold", "avic", NULL, "v-vmsave-vmload",
             "vgif", NULL, NULL, NULL,
@@ -593,10 +593,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
@@ -699,7 +696,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .index = MSR_IA32_PERF_CAPABILITIES,
         },
     },
-
     [FEAT_VMX_PROCBASED_CTLS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -722,9 +718,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
@@ -747,9 +742,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
@@ -772,9 +766,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .msr = {
             .index = MSR_IA32_VMX_TRUE_PINBASED_CTLS,
-        }
+        },
     },
-
     [FEAT_VMX_EXIT_CTLS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -783,8 +776,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             "vmx-exit-load-perf-global-ctrl", NULL, NULL, "vmx-exit-ack-intr",
             NULL, NULL, "vmx-exit-save-pat", "vmx-exit-load-pat",
-            "vmx-exit-save-efer", "vmx-exit-load-efer",
-                "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
+            "vmx-exit-save-efer", "vmx-exit-load-efer", "vmx-exit-save-preemption-timer", "vmx-exit-clear-bndcfgs",
             NULL, "vmx-exit-clear-rtit-ctl", NULL, NULL,
             NULL, "vmx-exit-load-pkrs", NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -798,9 +790,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
@@ -823,9 +814,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
@@ -848,9 +838,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
@@ -864,8 +853,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             NULL, NULL, NULL, NULL,
             "vmx-invvpid", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-            "vmx-invvpid-single-addr", "vmx-invvpid-single-context",
-                "vmx-invvpid-all-context", "vmx-invvpid-single-context-noglobals",
+            "vmx-invvpid-single-addr", "vmx-invvpid-single-context", "vmx-invvpid-all-context", "vmx-invvpid-single-context-noglobals",
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
@@ -874,9 +862,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
@@ -902,7 +889,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .no_autoenable_flags = MSR_VMX_BASIC_DUAL_MONITOR,
     },
-
     [FEAT_VMX_VMFUNC] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
@@ -925,9 +911,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
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
@@ -955,8 +940,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             .reg = R_ECX,
         },
         .tcg_features = TCG_14_0_ECX_FEATURES,
-     },
-
+    },
     [FEAT_SGX_12_0_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -985,7 +969,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_SGX_12_0_EAX_FEATURES,
     },
-
     [FEAT_SGX_12_0_EBX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
@@ -1014,7 +997,6 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .tcg_features = TCG_SGX_12_0_EBX_FEATURES,
     },
-
     [FEAT_SGX_12_1_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-- 
2.39.2



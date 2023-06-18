Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7A27348BA
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 23:52:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB0JA-0002sw-8l; Sun, 18 Jun 2023 17:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0J8-0002sa-BD
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:51:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0J6-0006XD-M8
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687125096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pwhgzbvG7T4FJXqSfC+4/m2TD+a0zefm3IPCck6mj44=;
 b=WhSpZem96XVRGBzXeNL1bBPEr1Jpjc0YOS/lepbVHbWHqmHZQ0CaWfrzQ4WP2VQA2tr5fq
 XbLb5Ijx3w56ZALB2v9zcgIou8Rb7Pp443w2agwCUWdpu3HyAwq54SgljDqmZd0j6stQhL
 aDcfy4cE4DjkxVzs5EGDlk9NzoZmdM4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-cfaI9g8EP_u3LfjYh_JXrA-1; Sun, 18 Jun 2023 17:51:34 -0400
X-MC-Unique: cfaI9g8EP_u3LfjYh_JXrA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a35b0d4ceso161385666b.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 14:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687125093; x=1689717093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pwhgzbvG7T4FJXqSfC+4/m2TD+a0zefm3IPCck6mj44=;
 b=jV7WHTloz26diSWlZ3GfiH+Y07udO1q1LaE9c1Ghn9IKIfIYdKIGpqzQXIFP4XmMYQ
 EhBgdDy/+tLklFmSfOK0BmApbqoZIgzT4+CGdiVQSRI80vj9sM2KCm+sfex7ZfCxE8AR
 nNG0SD/NeNwESZwcYKriziimri+UhecmMdR6waDqqyH7eyQ0JYQYczRNMr+oNHLer9bq
 JlUNM2UGWWj0SlHUZVT7y1GKJuOZPEzFYUR5C7gWNXvGoSdYKmFHIEzKeLlDLIFlIIog
 HX1ihMeHGmPdenKgJpIqZYgy9+tnQTvl7byg1IPCA/BrN1sLS85iYpyiWuqdsLr+xFfM
 nBHg==
X-Gm-Message-State: AC+VfDwXGEktAT9+DWJnOg11XPQWGDIu8pdVURnfSINRv2hthgXxRo7Z
 vWo6r7Bvi6BS+KvCzxOg07XqGIzpdNqI8wHuy+/OPrJIn1LwY66x8+wZGpkXgXgJIlqw/+WLsnP
 zuIy0JFzX+ygn17Pd8fudND1bkUwWEoyX4x58Ig66YvIR4NOv+VdzbQFoxSVyClRTu952c86naH
 32RA==
X-Received: by 2002:aa7:dcd2:0:b0:51a:5af9:36f6 with SMTP id
 w18-20020aa7dcd2000000b0051a5af936f6mr529033edu.29.1687125092825; 
 Sun, 18 Jun 2023 14:51:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7hCh2qfesAe+3FhUSwah332tL346fJOFTDC5RjhVwTAwgii9DbIyjCNuO4V/ptJCQTB4tPVg==
X-Received: by 2002:aa7:dcd2:0:b0:51a:5af9:36f6 with SMTP id
 w18-20020aa7dcd2000000b0051a5af936f6mr529029edu.29.1687125092484; 
 Sun, 18 Jun 2023 14:51:32 -0700 (PDT)
Received: from [192.168.60.219] (server.hotelpassage.eu. [88.146.207.194])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a50ed13000000b0051a216e7df7sm4252072eds.87.2023.06.18.14.51.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jun 2023 14:51:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] target/i386: implement WBNOINVD in TCG
Date: Sun, 18 Jun 2023 23:51:14 +0200
Message-Id: <20230618215114.107337-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230618215114.107337-1-pbonzini@redhat.com>
References: <20230618215114.107337-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

WBNOINVD is the same as INVD or WBINVD as far as TCG is concerned, but it does
not generate a vmexit if the processor supports it.  If it does not, it is treated
as WBINVD and generates a vmexit.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c           |  3 ++-
 target/i386/tcg/translate.c | 10 +++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 68218103108..dec376ab56d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -686,7 +686,8 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
 #define TCG_SGX_12_0_EBX_FEATURES 0
 #define TCG_SGX_12_1_EAX_FEATURES 0
 
-#define TCG_8000_0008_EBX  CPUID_8000_0008_EBX_XSAVEERPTR
+#define TCG_8000_0008_EBX  (CPUID_8000_0008_EBX_XSAVEERPTR | \
+          CPUID_8000_0008_EBX_WBNOINVD)
 
 FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_1_EDX] = {
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 9023f47fa69..c3d4410cdf1 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -122,6 +122,7 @@ typedef struct DisasContext {
     int cpuid_ext3_features;
     int cpuid_7_0_ebx_features;
     int cpuid_7_0_ecx_features;
+    int cpuid_8000_0008_ebx_features;
     int cpuid_xsave_features;
 
     /* TCG local temps */
@@ -6127,8 +6128,14 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
         }
         break;
 
+    case 0x109: /* wbinvd; wbnoinvd with REPZ prefix */
+        if ((s->cpuid_8000_0008_ebx_features & CPUID_8000_0008_EBX_WBNOINVD) &&
+            s->prefix & PREFIX_REPZ) {
+            check_cpl0(s);
+            break;
+        }
+        /* fallthrough */
     case 0x108: /* invd */
-    case 0x109: /* wbinvd */
         if (check_cpl0(s)) {
             gen_svm_check_intercept(s, (b & 1) ? SVM_EXIT_WBINVD : SVM_EXIT_INVD);
             /* nothing to do */
@@ -6936,6 +6943,7 @@ static void i386_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cpu)
     dc->cpuid_7_0_ebx_features = env->features[FEAT_7_0_EBX];
     dc->cpuid_7_0_ecx_features = env->features[FEAT_7_0_ECX];
     dc->cpuid_xsave_features = env->features[FEAT_XSAVE];
+    dc->cpuid_8000_0008_ebx_features = env->features[FEAT_8000_0008_EBX];
     dc->jmp_opt = !((cflags & CF_NO_GOTO_TB) ||
                     (flags & (HF_TF_MASK | HF_INHIBIT_IRQ_MASK)));
     /*
-- 
2.40.1



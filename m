Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE857AB4F4
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:42:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiIj-0008Kb-Fc; Fri, 22 Sep 2023 11:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIf-0008Jc-W5
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIe-0002nU-I5
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695397355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lyyUffVCCI6wnmLrjN9LYL/D6+d/aBzAyTI/qFrludo=;
 b=f96xwobR2/pGhjhxYcoc80T8GV19wy7cLb3NyYmCV8uQ6Tbzn5NBYUyI5OwfwG87v2ZS0w
 iAsOOe9jKj2ss19EGmaX3PIX29A7Vjlo1grr8D9O7+tOCa/OyaeHsySakPsuG3mnUQAuaf
 G8JF6nC+OPGmL/cdge5O1xgKjxHm2LQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-cnzg_nrdPCystIn41OuDCw-1; Fri, 22 Sep 2023 11:42:34 -0400
X-MC-Unique: cnzg_nrdPCystIn41OuDCw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4054743df06so2207365e9.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:42:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397352; x=1696002152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lyyUffVCCI6wnmLrjN9LYL/D6+d/aBzAyTI/qFrludo=;
 b=UgJgCGLOtq85iUXk2PV4aZ3CT1gB3FbxUbFmcgOTzcSXDmlgefmtpgfIH6KCEsWgWx
 pMlGTLfZ0GkY/7Dr+cN2d29bbUpLe5/cnAGhbroN8lmIFjzJV2UHMxqY8xm5xgtLUnJT
 o/sfoWn2cHEJ/qr9lcvts7OLyhm/OBWGEM6wXG5u8Ni5XxK454YEnoETE0L1V8vccSeI
 hhmu57YKiix9ABUPRsbBmtsoe+h892cxz3DY1WyoymclCXx5KoWB8Qo9CQEe7pc0zPEi
 +oMrnt+bhAy9RwTgFcsXEeHmblNu8hm3RVDaKf7OhYEdooIxioBkOaZeuXELiQBURM3q
 q8OQ==
X-Gm-Message-State: AOJu0YyTpvgUmK/QERKp7vUOins6crFWj3BOEcH6NNIAdURDkQA4fdlK
 XZeqNtrCasENPKaZCrdV7UVZRFeXGCksLDPwVUvbmje+WQyIECOA/jIwnA+8sAPrUUwkAV/ql4c
 w7stK/mqPSZabZLhbGr2CTZYYblelvsYL+VF2ey6Zbiybg483O8xTp4BVDuJAIL0s05CED32Od5
 A=
X-Received: by 2002:a1c:7c1a:0:b0:401:d947:c8a9 with SMTP id
 x26-20020a1c7c1a000000b00401d947c8a9mr9427481wmc.19.1695397352650; 
 Fri, 22 Sep 2023 08:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHo6KSvjxl/p7ksMXoWeOXb9ZIK0hB+5tyZQi2ikqQG6t2qr46NsXufsJwFJubvKL2oP23ZeA==
X-Received: by 2002:a1c:7c1a:0:b0:401:d947:c8a9 with SMTP id
 x26-20020a1c7c1a000000b00401d947c8a9mr9427460wmc.19.1695397352265; 
 Fri, 22 Sep 2023 08:42:32 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a05600c040c00b003fef60005b5sm5065585wmb.9.2023.09.22.08.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:42:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu
Subject: [PULL 1/9] target/i386: enumerate bit 56 of MSR_IA32_VMX_BASIC
Date: Fri, 22 Sep 2023 17:42:20 +0200
Message-ID: <20230922154228.304933-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230922154228.304933-1-pbonzini@redhat.com>
References: <20230922154228.304933-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On parts that enumerate IA32_VMX_BASIC MSR bit as 1, any exception vector
can be delivered with or without an error code if the other consistency
checks are satisfied.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/kvm/vmxcap | 1 +
 target/i386/cpu.c  | 1 +
 target/i386/cpu.h  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/scripts/kvm/vmxcap b/scripts/kvm/vmxcap
index ce27f5e635a..3fb4d5b3425 100755
--- a/scripts/kvm/vmxcap
+++ b/scripts/kvm/vmxcap
@@ -115,6 +115,7 @@ controls = [
             (50, 53): 'VMCS memory type',
             54: 'INS/OUTS instruction information',
             55: 'IA32_VMX_TRUE_*_CTLS support',
+            56: 'Skip checks on event error code',
             },
         msr = MSR_IA32_VMX_BASIC,
         ),
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b2a20365e10..d48607b4e1e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1340,6 +1340,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .feat_names = {
             [54] = "vmx-ins-outs",
             [55] = "vmx-true-ctls",
+            [56] = "vmx-any-errcode",
         },
         .msr = {
             .index = MSR_IA32_VMX_BASIC,
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index fbb05eace57..d1ffadd78be 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1039,6 +1039,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define MSR_VMX_BASIC_DUAL_MONITOR                   (1ULL << 49)
 #define MSR_VMX_BASIC_INS_OUTS                       (1ULL << 54)
 #define MSR_VMX_BASIC_TRUE_CTLS                      (1ULL << 55)
+#define MSR_VMX_BASIC_ANY_ERRCODE                    (1ULL << 56)
 
 #define MSR_VMX_MISC_PREEMPTION_TIMER_SHIFT_MASK     0x1Full
 #define MSR_VMX_MISC_STORE_LMA                       (1ULL << 5)
-- 
2.41.0



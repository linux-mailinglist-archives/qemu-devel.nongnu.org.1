Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D03667F578B
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:49:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61YL-0006br-Fk; Wed, 22 Nov 2023 23:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Y5-0006QL-Mg
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:46 -0500
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Y0-0006EW-Kl
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:45 -0500
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-6d7f665285aso267195a34.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714557; x=1701319357; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z9sYIWas5f3L9LVklxkBAZhldZmGtqlfaE/Pn9tmcPw=;
 b=aJRXV/Ty+5lgI16quwOq0JbaOvc3Qcfp1rJsLB5GCVW1pD+ce52Y50FH3yFgQLZmLR
 Ca0TiuKrNl/5SUpsHnozh1g90bUJd2bxMLKOEsHnDUJCmWSSKw2VCM/GcwOPgWOH61Ba
 IWhNqkQqNzbbf77Hxf6Oxf4bqAOcRcbVrAwSVtJwGih3G3jx1dntz2GM8lnfdBKBUZE7
 CIfBiUYw62axht9dIOJuvzVhE2UBt0zrZWU1pVD9u0SUsTgT7I4tLmT843k/XxrZfxpH
 1JCRbyhHngj9usP3CsGzVUSL+ETkqLPpZET9ls4aumybJ+LaKHc8KSp+26I4QhHy0LSI
 xsOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714557; x=1701319357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z9sYIWas5f3L9LVklxkBAZhldZmGtqlfaE/Pn9tmcPw=;
 b=cAwLQsF6DS8Lb5kNN24juLzqYiRFhj2nA9c79M0NWhv1PSlS016FvZPY47QXSrBhhh
 kklkUXmjBlkTWL2RRlZiwatn/5sNyFricZKix5tXMGR5UrVJyyDu69Lt9JXt4vZc3kuK
 nowohw/fCVOgvZ5SI/1pXRcVzcS3SLiI6OgSNYBqf3DO1E94TmZGJkOPcuC8uLywnuZC
 gfluWyl9IkRbEBy6WanLVnhDGyje44aRR9s5ZDt8eEJFmYyTnF/RgPGQmN7CE96E4Sqv
 czA13O2182esTfz5MOHJ77lOlGTTovTZsnVGdYJpsdyOxX2+IbyATeOndzTS6vfv0mxu
 l9pg==
X-Gm-Message-State: AOJu0Yyecjuu3C4n/QqiejbR16VLnf4K2EdN0AzNGSDg5gLvAwnMzE08
 G16y0duxW+YqpnjTzuxqpoCbderCMvX9HJZHRRFxnr8g
X-Google-Smtp-Source: AGHT+IHS9+o4BIhzXrFSRVN4nMiNZC27R5IhIzR2xLJwrEVTWufOYJ2aas1wPtFceaIRliprcH5I/w==
X-Received: by 2002:a05:6808:209b:b0:3af:a80c:420 with SMTP id
 s27-20020a056808209b00b003afa80c0420mr850846oiw.7.1700714557171; 
 Wed, 22 Nov 2023 20:42:37 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 15/21] target/arm/kvm: Unexport kvm_arm_vcpu_init
Date: Wed, 22 Nov 2023 22:42:13 -0600
Message-Id: <20231123044219.896776-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm_arm.h | 12 ------------
 target/arm/kvm.c     | 12 +++++++++++-
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 1043123cc7..b96ff35e34 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -18,18 +18,6 @@
 #define KVM_ARM_VGIC_V2   (1 << 0)
 #define KVM_ARM_VGIC_V3   (1 << 1)
 
-/**
- * kvm_arm_vcpu_init:
- * @cs: CPUState
- *
- * Initialize (or reinitialize) the VCPU by invoking the
- * KVM_ARM_VCPU_INIT ioctl with the CPU type and feature
- * bitmask specified in the CPUState.
- *
- * Returns: 0 if success else < 0 error code
- */
-int kvm_arm_vcpu_init(CPUState *cs);
-
 /**
  * kvm_arm_vcpu_finalize:
  * @cs: CPUState
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 466b848156..a864d0852f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -58,7 +58,17 @@ typedef struct ARMHostCPUFeatures {
 
 static ARMHostCPUFeatures arm_host_cpu_features;
 
-int kvm_arm_vcpu_init(CPUState *cs)
+/**
+ * kvm_arm_vcpu_init:
+ * @cs: CPUState
+ *
+ * Initialize (or reinitialize) the VCPU by invoking the
+ * KVM_ARM_VCPU_INIT ioctl with the CPU type and feature
+ * bitmask specified in the CPUState.
+ *
+ * Returns: 0 if success else < 0 error code
+ */
+static int kvm_arm_vcpu_init(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     struct kvm_vcpu_init init;
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F96A7F5786
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:48:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61YM-0006cq-8d; Wed, 22 Nov 2023 23:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Y7-0006SZ-1M
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:48 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Y4-0006Hf-0n
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:46 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1f93d0cd2ddso333322fac.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714560; x=1701319360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wiXhFHZySPL8w40Zgeyi5JXzqLc7WVTgj0ZvaUr0XG8=;
 b=ywCYS15PyU22nIUDIkKtESb8OgLZlMnwl+usEz658KivmqVVtWNMIQL92/8XCFpH/9
 yr87NAlwZRb6GdVmTurrpHdlwOq2LM7f3M6+pIIFT+MH9DKrylYeq50UVMr47238TAzL
 Vum/1xl5l67lRecP3ger0tIs6ChCrwHIrJ12zRvKiT8chYb9eQ0f/Ojv1swKGLal/uIr
 BrkyUSFLVFKWyTeASWhEl1jfcPVog3AssvfNj2FIhU5EqPSxNmFkJY6nDbkRCqNi0dXF
 NL7j9rdx4m11ETCgqb/tWU8m7eow5Qr91OrHW5uvygRWof15nU5sc2zPYgSthJ2wUKfc
 uJNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714560; x=1701319360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wiXhFHZySPL8w40Zgeyi5JXzqLc7WVTgj0ZvaUr0XG8=;
 b=tkpjCNjUWZzoGVkLIT/op5Cl+UsCd1qHJA/CV0TxqwfpuWzGLrg9dOgSa0zBHO1QRV
 6/EWEJv0QZ/v8v8dzbRdC502j+kuhVxQMF6L3qNEODILZ4m9vNWu5NgSfcsjAw2W7Cqn
 dLTXHEIFJ4lgyWDRkERQo9lacYzJOOi5EB6j24DMl/Sm7ZaSCnnEFvzq3NA8nBhek7g7
 +dGi7L6b6BXXwQr4ZiRrKL/ZINWjR6VFHb7MomxTINBFieoFJDSinKM16OMVMTSS0zw+
 fUFmA8IObNSlGmqikbyiXc1SpwDK1NxBQZvUx7Jn1XoYt5A/0y1n4G1Xa2nH2qgegqtn
 4dfQ==
X-Gm-Message-State: AOJu0Ywt/2zuTBBQYTFirgsOPm4+WU78J33H06K2qMnmkwY1bFXOniQu
 kduoW9bVjaW1Bd9+KO2hCJEaHNmWxznIMQCUdz8cXOPm
X-Google-Smtp-Source: AGHT+IHeQTz7c0mBxWhpr9qws0e2P2px9tBmaNtEUJyoLPYCy7k6cLOTJx2MXS+k6ioWoYFEowlCLw==
X-Received: by 2002:a05:6871:8791:b0:1f5:cd37:34e with SMTP id
 td17-20020a056871879100b001f5cd37034emr6142861oab.20.1700714560668; 
 Wed, 22 Nov 2023 20:42:40 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 19/21] target/arm/kvm: Unexport kvm_{get,put}_vcpu_events
Date: Wed, 22 Nov 2023 22:42:17 -0600
Message-Id: <20231123044219.896776-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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
 target/arm/kvm_arm.h | 20 --------------------
 target/arm/kvm.c     | 20 ++++++++++++++++++--
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 1ec2476de7..b4339d49d1 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -98,26 +98,6 @@ void kvm_arm_cpu_post_load(ARMCPU *cpu);
  */
 void kvm_arm_reset_vcpu(ARMCPU *cpu);
 
-/**
- * kvm_get_vcpu_events:
- * @cpu: ARMCPU
- *
- * Get VCPU related state from kvm.
- *
- * Returns: 0 if success else < 0 error code
- */
-int kvm_get_vcpu_events(ARMCPU *cpu);
-
-/**
- * kvm_put_vcpu_events:
- * @cpu: ARMCPU
- *
- * Put VCPU related state to kvm.
- *
- * Returns: 0 if success else < 0 error code
- */
-int kvm_put_vcpu_events(ARMCPU *cpu);
-
 #ifdef CONFIG_KVM
 /**
  * kvm_arm_create_scratch_host_vcpu:
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 3250919273..f9aa55b1a0 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1092,7 +1092,15 @@ static void kvm_arm_put_virtual_time(CPUState *cs)
     cpu->kvm_vtime_dirty = false;
 }
 
-int kvm_put_vcpu_events(ARMCPU *cpu)
+/**
+ * kvm_put_vcpu_events:
+ * @cpu: ARMCPU
+ *
+ * Put VCPU related state to kvm.
+ *
+ * Returns: 0 if success else < 0 error code
+ */
+static int kvm_put_vcpu_events(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
     struct kvm_vcpu_events events;
@@ -1121,7 +1129,15 @@ int kvm_put_vcpu_events(ARMCPU *cpu)
     return ret;
 }
 
-int kvm_get_vcpu_events(ARMCPU *cpu)
+/**
+ * kvm_get_vcpu_events:
+ * @cpu: ARMCPU
+ *
+ * Get VCPU related state from kvm.
+ *
+ * Returns: 0 if success else < 0 error code
+ */
+static int kvm_get_vcpu_events(ARMCPU *cpu)
 {
     CPUARMState *env = &cpu->env;
     struct kvm_vcpu_events events;
-- 
2.34.1



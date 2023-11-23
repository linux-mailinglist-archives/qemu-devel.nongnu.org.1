Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A667F5784
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:46:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61YM-0006ck-57; Wed, 22 Nov 2023 23:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Y5-0006PX-2e
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:46 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Y0-0006Eq-Kq
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:44 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1ef36a04931so342164fac.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714558; x=1701319358; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XoNhjamHa23uC1hFwLD47ZBDARlMJkpmLpzYJFJqrbI=;
 b=ei+ILln1SJpymayDqmD50fVEU7Yxr+21oTx6JFJB3DWSnHd09em8ejKrpzuuC7brX3
 dIrRrENXCshKDeGx+W6V8z+Owf44aiKGj70ip/XZH43COduCV/J41T5L1lh0k76bLSIL
 b3qoJ9CehkOJFJoPHoIo+AqtNuW+M0xfP0PiiCmZQXi7Tbfo+LI/KFb4jJnYe5qt+vNo
 3HZLh45WKFQWykKkl8aRGzDbjkvKMl3/OTgZzLZSos+4nzzgS8unZ2085b6fxSLBOt8i
 p1hJzu/8ApWxkmyUwYofoerp+sRvFf5hOyEojDFv4cyrW4I9DDT/xvqElxs15wAigRal
 aOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714558; x=1701319358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XoNhjamHa23uC1hFwLD47ZBDARlMJkpmLpzYJFJqrbI=;
 b=clYWrZPXu8OeVN16hJkRgBBsi4vdrnZ1kJmt3VEP61fjWV9RBFiHAAhP2wpNzDa6iC
 3BTu8pNM+aqPHpsl3emnsGRXtN7w+n+VkOiJLUmO3rKb5WC6fQNio7Zq/FHLW4FoCguh
 cPIQQPp0O4MqazLar7t0q/nVK2+qSEQ3z5svrrBRotqi9Grby2udzl8dYQBHL+W95e4r
 MyCDlWfXw/xninJZYddKRZhqH4aMlnJ6vcyhd0MRWS31xl19KWc7vnQmJudDXaoKcjqk
 /jfVNInP9T+3G21k9LC0vSzM8wX03Ev+gpylNH7qWDm/+0U8SUespV7gRtoZrbf2OlYj
 klqQ==
X-Gm-Message-State: AOJu0YzyPZEBLEUZDEdG/kLq/mAhuOs/vFjsbFLkcNbxn8fR/Ap+uyHe
 kPt6OPRn0LICnuTDMfGjnvwdzOSFrFrmhl0J2Xj4bJpr
X-Google-Smtp-Source: AGHT+IEpW+HZ6DapZSL5u9uJzBb66/sGjP2TPOmY656i5Sr/kyDRuPVwM7NEpOrd+dMS38aOj2urYQ==
X-Received: by 2002:a05:6870:1f1a:b0:1f9:52e2:a8d7 with SMTP id
 pd26-20020a0568701f1a00b001f952e2a8d7mr4751694oab.43.1700714557955; 
 Wed, 22 Nov 2023 20:42:37 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 16/21] target/arm/kvm: Unexport kvm_arm_vcpu_finalize
Date: Wed, 22 Nov 2023 22:42:14 -0600
Message-Id: <20231123044219.896776-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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
 target/arm/kvm_arm.h | 14 --------------
 target/arm/kvm.c     | 14 +++++++++++++-
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index b96ff35e34..9b630a1631 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -18,20 +18,6 @@
 #define KVM_ARM_VGIC_V2   (1 << 0)
 #define KVM_ARM_VGIC_V3   (1 << 1)
 
-/**
- * kvm_arm_vcpu_finalize:
- * @cs: CPUState
- * @feature: feature to finalize
- *
- * Finalizes the configuration of the specified VCPU feature by
- * invoking the KVM_ARM_VCPU_FINALIZE ioctl. Features requiring
- * this are documented in the "KVM_ARM_VCPU_FINALIZE" section of
- * KVM's API documentation.
- *
- * Returns: 0 if success else < 0 error code
- */
-int kvm_arm_vcpu_finalize(CPUState *cs, int feature);
-
 /**
  * kvm_arm_register_device:
  * @mr: memory region for this device
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index a864d0852f..20d8c81667 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -79,7 +79,19 @@ static int kvm_arm_vcpu_init(CPUState *cs)
     return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_INIT, &init);
 }
 
-int kvm_arm_vcpu_finalize(CPUState *cs, int feature)
+/**
+ * kvm_arm_vcpu_finalize:
+ * @cs: CPUState
+ * @feature: feature to finalize
+ *
+ * Finalizes the configuration of the specified VCPU feature by
+ * invoking the KVM_ARM_VCPU_FINALIZE ioctl. Features requiring
+ * this are documented in the "KVM_ARM_VCPU_FINALIZE" section of
+ * KVM's API documentation.
+ *
+ * Returns: 0 if success else < 0 error code
+ */
+static int kvm_arm_vcpu_finalize(CPUState *cs, int feature)
 {
     return kvm_vcpu_ioctl(cs, KVM_ARM_VCPU_FINALIZE, &feature);
 }
-- 
2.34.1



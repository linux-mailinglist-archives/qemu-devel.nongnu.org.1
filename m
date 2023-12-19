Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E83819099
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 20:21:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFfX4-0001y7-BO; Tue, 19 Dec 2023 14:13:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWq-0001pV-MJ
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:20 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rFfWo-0001nj-L6
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 14:13:20 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33664b6d6d5so2378554f8f.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 11:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703013197; x=1703617997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Lk12mN4qFsWUyce/FrUNcsWdUn084yu7ANskjsNphT8=;
 b=V0DnHg+Jy9iND0/rFUNj2Y4D1Py1ILfzZOCZwwwqMr7bM0Biw5M6693PNeO+Kjcx14
 fZBLM7s/bH7TQwKNMnRQkNmLS8C275ZtiIjfJfo14qZvSd+e587T+X8SSWpKfrd11AD8
 vpR7jKq6xuGxWutWluyMlfn/wMaUcIYupcEbt1tJ4jazBOgg3BPKzoETwONp1qK/nd/d
 rWcN9d3MBIcmaoimLhW0P9V+9HkdChCLX+GavI9G4cGNimX33MhApeTz10tSV5dDeTMd
 +2BqlOM0hrSPCoGVmKMrjNWq1q5iDuhwUQie14h5bZlzhU8UE/pu8f3giKO9wCVVXmBa
 /Vrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703013197; x=1703617997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lk12mN4qFsWUyce/FrUNcsWdUn084yu7ANskjsNphT8=;
 b=uSOeMDbIs3bFtR7jU1GMfHwdMxfM7l1jqDjU87To95kORv50MxPkH2dx1WbvU1WWzX
 IOa8lm8uqVYzFaotENcoha2bFGoA2D7eIirNLIly0yWVwJwUmaO1DopFHwFfc/5NQe9i
 mIqU36oj7P+0eT7Dk19dvmzrQUN2v0Zcu5daMtplfSfp1WZm/HEqo1sE//rhel0C5nl7
 fnykdvnYJMBmsse6fsiU/TMt515SQixXirAnoEQKiKJSs1b9z7scLunorqN/Ib9bwYYM
 RVsB84j2/tIg7UOeNI35ga9xJ09A5/3lmcxjZaRPmO1PG56zuqYrhyBqpfOhYEzphxzv
 C8nQ==
X-Gm-Message-State: AOJu0YySbKFpVxo/215p+PBoAhBwFvXBJoMxLmhVkHeejikPxu8QazJh
 PM1HcazHiYm4xj0KEUNThPK/Vm6csAq1hOtnQ60=
X-Google-Smtp-Source: AGHT+IFFUnLZ9e2q7kZDom7bEi4VdGXaEnYMWxap9mqr8peJzQQJJ29UdpT10uRNbvRO+z4gi+uTSQ==
X-Received: by 2002:adf:f708:0:b0:336:780e:b2e3 with SMTP id
 r8-20020adff708000000b00336780eb2e3mr187503wrp.38.1703013197183; 
 Tue, 19 Dec 2023 11:13:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a5d5685000000b0033657376b62sm12007754wrv.105.2023.12.19.11.13.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 11:13:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/43] target/arm/kvm: Unexport kvm_arm_vcpu_finalize
Date: Tue, 19 Dec 2023 19:12:40 +0000
Message-Id: <20231219191307.2895919-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231219191307.2895919-1-peter.maydell@linaro.org>
References: <20231219191307.2895919-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm_arm.h | 14 --------------
 target/arm/kvm.c     | 14 +++++++++++++-
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index b96ff35e34a..9b630a1631e 100644
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
index d1edb9bd67c..5bc96f469e1 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -81,7 +81,19 @@ static int kvm_arm_vcpu_init(CPUState *cs)
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



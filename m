Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9FA7F5778
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 05:44:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r61YM-0006d0-8a; Wed, 22 Nov 2023 23:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Y6-0006Rs-Qp
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:48 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r61Y2-0006FU-A0
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 23:42:45 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3b5714439b3so283742b6e.3
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 20:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700714559; x=1701319359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VkzgPDpougz5Puiw+xECKRO2grc7zzyhXDofA8x6EVo=;
 b=KIsCGMJSLmMU2uh2gWtRGgysQTCHa9m8QvpLIEWYeqXR9IVJRwNqT/eGEoEiMM7wQW
 nsw5K+esvnSmD5rJ8SX+DIAaJaLsNN7C30p3u0O/fniPj+F0srlpIDTe+csmRwnDFfIJ
 bi1jOpO2JdXE0UExME5rCpOLkDasD2eqvJOoUArDZPeV3KcChZCWWbnYBAAghqWtyKEm
 2GGqEcGkTZRXUM3CEWIfe45WUfyyryYoLT+PPxIlszk1qT1SM9ZlT6ozsPUJiNnYnKYR
 iuKcpd1VmcNc3rr9VIs1rdmCL6pygj2HNAod2HvhDAtPJwDD43+y16zljMEo24VIin/0
 qUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700714559; x=1701319359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VkzgPDpougz5Puiw+xECKRO2grc7zzyhXDofA8x6EVo=;
 b=R6zDUa1e4Dd5raPoWc+W1NL6QGs74BUg7kpZJEXYsAI/5UjdPbhNTxHbEIbr0jrC9R
 TsiVrJ++atVSX4vlU925WPTtdL/JFI3ZdYUBXKSrGU1atz9T0kdPhPeUCP16X+umoEjU
 pzuASYizw+JrYl0OJfYuAGOWf4N5TKus2Y9eEXpkx/bxLoGPyp/qsdXJgPY4M78JN80a
 ITo8OMxDRHPGs5H3hbUNiXbVa8UmFgurVHlirXiEYyfq/j4BmZqELmpPWSlzEV1uYtLU
 dlL1ofUADuokl3XeYshGWYW1AgWxDI8/vkY0Auis2vimzyjZ5R2tlvqCA99EMJT5l+xc
 Uf3A==
X-Gm-Message-State: AOJu0YzXfxXEXFx94rnjjlzeHbzp5mWJIdpoWqnqNgDRzwQoILVCz6dH
 BBzykNNVtXwyi3ii29lOe2Y55Tvzb0eSQcaGvUKLLcXN
X-Google-Smtp-Source: AGHT+IGBkqm+ztsr5qsZFIXO+tdzNgpx+w5T+c9jWtSD0KehXU6buZVeSzuKq6pnzfqT3gHcraNnew==
X-Received: by 2002:a05:6808:16ab:b0:3a9:cfb5:462a with SMTP id
 bb43-20020a05680816ab00b003a9cfb5462amr5140144oib.36.1700714558778; 
 Wed, 22 Nov 2023 20:42:38 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 i7-20020a056808030700b003b8347de3c2sm73888oie.19.2023.11.22.20.42.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 20:42:38 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 17/21] target/arm/kvm: Unexport kvm_arm_init_cpreg_list
Date: Wed, 22 Nov 2023 22:42:15 -0600
Message-Id: <20231123044219.896776-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123044219.896776-1-richard.henderson@linaro.org>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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
 target/arm/kvm.c     | 10 ++++++++--
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index 9b630a1631..350ba6cb96 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -39,18 +39,6 @@
 void kvm_arm_register_device(MemoryRegion *mr, uint64_t devid, uint64_t group,
                              uint64_t attr, int dev_fd, uint64_t addr_ormask);
 
-/**
- * kvm_arm_init_cpreg_list:
- * @cpu: ARMCPU
- *
- * Initialize the ARMCPU cpreg list according to the kernel's
- * definition of what CPU registers it knows about (and throw away
- * the previous TCG-created cpreg list).
- *
- * Returns: 0 if success, else < 0 error code
- */
-int kvm_arm_init_cpreg_list(ARMCPU *cpu);
-
 /**
  * write_list_to_kvmstate:
  * @cpu: ARMCPU
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 20d8c81667..bc4ba7628b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -789,11 +789,17 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
     }
 }
 
-/* Initialize the ARMCPU cpreg list according to the kernel's
+/**
+ * kvm_arm_init_cpreg_list:
+ * @cpu: ARMCPU
+ *
+ * Initialize the ARMCPU cpreg list according to the kernel's
  * definition of what CPU registers it knows about (and throw away
  * the previous TCG-created cpreg list).
+ *
+ * Returns: 0 if success, else < 0 error code
  */
-int kvm_arm_init_cpreg_list(ARMCPU *cpu)
+static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
 {
     struct kvm_reg_list rl;
     struct kvm_reg_list *rlp;
-- 
2.34.1



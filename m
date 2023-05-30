Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA22716D09
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 21:03:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q44aA-0000vN-0U; Tue, 30 May 2023 15:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zm-0000qM-Kw
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:11 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q44Zk-00017m-CA
 for qemu-devel@nongnu.org; Tue, 30 May 2023 15:00:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64fec2e0e25so1352886b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 12:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685473206; x=1688065206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=THCpcxyaxIonARB18ZEJU/aEw9sHk0dGbfMhhJCYQDQ=;
 b=PbZOEHJeEsdoDfETLKmDRTcuf4cGXn6944qdU1fEA+aCe5nmBEisLoig0httKIkE9b
 hkxhjnJLwPSNC5f6O0VCgfFE9jmnj0FBdlxhcQZalOe8LaQ5X/DFDBEEYzJEvEnLgFDc
 8PSHTEt+I2xe6vPx2HtEYa9RxmOR3H/17Qqd6QCfhyh5duOfIjCBy7ZrY4Sji10XrjWA
 ECdi0aciXYmFMVP1CieB7DzX1T9pcIeYpBhwMUQmn0W5x4J0p9zJThQRFa+Zh2/ud/XH
 pM8xQeoszFgUPFAscmjCogODSEx+31sA1Afrnqwzx3k/gWI4p6YaNV5DYKJPFVGrVMgY
 Cvaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685473206; x=1688065206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=THCpcxyaxIonARB18ZEJU/aEw9sHk0dGbfMhhJCYQDQ=;
 b=IAriwQQGG3l5FCVo/a5jTkSTRzXIAZc6AHPJdzXMbCxImU8JrFLJR1Atw7g+uWBbDf
 WSRwBh8YsdNErMVzay4DHBghicl7NCzuKpV/7tmCVpqlwxobdLo9EdaRz8sy39ticlgb
 Cu8pQwbvSzxxdu7jTiRdNDoMFGd+XQXJ7O2/QUb53D6kavaX1UKyGXxvNQh4/EKWrEYN
 9wF97Uxn+aIfOVOGT3OWVwFHI0zjgXhUUYVXB5DiHCmim4P1cyV6A/SgX4sqy2jxE3YV
 KOIGlHS9Sjw61cvywReqStBB6ckMeBHGMbT7ay0zuR6n/9VSSGZyaqoCXDinVxvdgpPy
 OzdA==
X-Gm-Message-State: AC+VfDyHH1JGDEggUnZqFrw6HWNQnb1Y83LuULaxL9+iRh2IkgmTT6C3
 qrrVn1Cl1nLx+kVTx713Wq/lDvVJUKfdTXz1474=
X-Google-Smtp-Source: ACHHUZ5IkEiKUIIymQd/95IKq3QUe+Jpgsfx50jxjNiMl4B+EIgLa0xT17poZp5YklMtO9+qi+SAnQ==
X-Received: by 2002:a05:6a21:6d83:b0:10b:b401:8435 with SMTP id
 wl3-20020a056a216d8300b0010bb4018435mr4183426pzb.16.1685473205320; 
 Tue, 30 May 2023 12:00:05 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:35a2:c45d:7485:f488])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a63fa52000000b0051f14839bf3sm9128496pgk.34.2023.05.30.12.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 12:00:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/27] tcg: Remove TCG_TARGET_TLB_DISPLACEMENT_BITS
Date: Tue, 30 May 2023 11:59:39 -0700
Message-Id: <20230530185949.410208-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530185949.410208-1-richard.henderson@linaro.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

The last use was removed by e77c89fb086a.

Fixes: e77c89fb086a ("cputlb: Remove static tlb sizing")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.h | 1 -
 tcg/arm/tcg-target.h     | 1 -
 tcg/i386/tcg-target.h    | 1 -
 tcg/mips/tcg-target.h    | 1 -
 tcg/ppc/tcg-target.h     | 1 -
 tcg/riscv/tcg-target.h   | 1 -
 tcg/s390x/tcg-target.h   | 1 -
 tcg/sparc64/tcg-target.h | 1 -
 tcg/tci/tcg-target.h     | 1 -
 9 files changed, 9 deletions(-)

diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index 192a2758c5..ce64de06e5 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -16,7 +16,6 @@
 #include "host/cpuinfo.h"
 
 #define TCG_TARGET_INSN_UNIT_SIZE  4
-#define TCG_TARGET_TLB_DISPLACEMENT_BITS 24
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
 typedef enum {
diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 65efc538f4..c649db72a6 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -31,7 +31,6 @@ extern int arm_arch;
 #define use_armv7_instructions  (__ARM_ARCH >= 7 || arm_arch >= 7)
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
-#define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
 #define MAX_CODE_GEN_BUFFER_SIZE  UINT32_MAX
 
 typedef enum {
diff --git a/tcg/i386/tcg-target.h b/tcg/i386/tcg-target.h
index b167f1e8d6..1468f8ef25 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -28,7 +28,6 @@
 #include "host/cpuinfo.h"
 
 #define TCG_TARGET_INSN_UNIT_SIZE  1
-#define TCG_TARGET_TLB_DISPLACEMENT_BITS 31
 
 #ifdef __x86_64__
 # define TCG_TARGET_REG_BITS  64
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 8fbb6c6507..e4806f6ff5 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -36,7 +36,6 @@
 #endif
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
-#define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
 #define TCG_TARGET_NB_REGS 32
 
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 204b70f86a..40f20b0c1a 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -34,7 +34,6 @@
 
 #define TCG_TARGET_NB_REGS 64
 #define TCG_TARGET_INSN_UNIT_SIZE 4
-#define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
 
 typedef enum {
     TCG_REG_R0,  TCG_REG_R1,  TCG_REG_R2,  TCG_REG_R3,
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 62fe61af7b..54fdff0caa 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -35,7 +35,6 @@
 #define TCG_TARGET_REG_BITS 64
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
-#define TCG_TARGET_TLB_DISPLACEMENT_BITS 20
 #define TCG_TARGET_NB_REGS 32
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index ec96952172..9a405003b9 100644
--- a/tcg/s390x/tcg-target.h
+++ b/tcg/s390x/tcg-target.h
@@ -26,7 +26,6 @@
 #define S390_TCG_TARGET_H
 
 #define TCG_TARGET_INSN_UNIT_SIZE 2
-#define TCG_TARGET_TLB_DISPLACEMENT_BITS 19
 
 /* We have a +- 4GB range on the branches; leave some slop.  */
 #define MAX_CODE_GEN_BUFFER_SIZE  (3 * GiB)
diff --git a/tcg/sparc64/tcg-target.h b/tcg/sparc64/tcg-target.h
index 31c5537379..d454278811 100644
--- a/tcg/sparc64/tcg-target.h
+++ b/tcg/sparc64/tcg-target.h
@@ -26,7 +26,6 @@
 #define SPARC_TCG_TARGET_H
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
-#define TCG_TARGET_TLB_DISPLACEMENT_BITS 32
 #define TCG_TARGET_NB_REGS 32
 #define MAX_CODE_GEN_BUFFER_SIZE  (2 * GiB)
 
diff --git a/tcg/tci/tcg-target.h b/tcg/tci/tcg-target.h
index 28dc6d5cfc..60a6ed65ce 100644
--- a/tcg/tci/tcg-target.h
+++ b/tcg/tci/tcg-target.h
@@ -42,7 +42,6 @@
 
 #define TCG_TARGET_INTERPRETER 1
 #define TCG_TARGET_INSN_UNIT_SIZE 4
-#define TCG_TARGET_TLB_DISPLACEMENT_BITS 32
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
 #if UINTPTR_MAX == UINT32_MAX
-- 
2.34.1



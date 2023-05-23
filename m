Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF63770DE28
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:54:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SSc-0004zl-Q0; Tue, 23 May 2023 09:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSG-0004Yp-2i
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:36 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSC-00031A-Bv
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:34 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-64d18d772bdso6820798b3a.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850011; x=1687442011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CAPylfyNSJO742tQj+iPp4jcYpwc8G2q6DNOsHZerzM=;
 b=va9uhdjofaMc/DYjKgJeea4ZpJJr/GqeBGli3/cVH6CT9jF+hIvuBYgGNo3dBmFwJn
 OCGmkVSzuPM7k/JDaXiVQtvL5uPXxxbYR6xQl3VP7aGYOpTNepQZkzSDTaYC4oNzw0cO
 Q4tMOEoS0XzDnJcsZ9H9I8M2KaYGfU6DHY/zu2RehoStjgzYG2wfcg5PsaxgyU5DspQ0
 Tk25GKHLNx9mNH9OXOsayrcZjCNk8jjqb4ji1xarNvzfINtBSGyqxrKdSNwMYGFirDJ/
 1lm0ptQDAp7i8GxPMrjUDZyPTaFTz8b52luxpbMS4meJu4aoPeEN0WKTWBVZmXgVlG+M
 uE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850011; x=1687442011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CAPylfyNSJO742tQj+iPp4jcYpwc8G2q6DNOsHZerzM=;
 b=QzRwkusmpSXhoweNsFojAWJN3QbujMgvNmqQNDYCrnYmgpXeLZyIFS6XRR87ZlVPAK
 qr3JxGWHpae8wABegzDVmg9g9sbppkA+eeHU2K0SPQ9CEFpKB7A77Zm1bQEb/xOWgtYq
 jt14Jv7JN1F4c7hW8ejX9RQGkF6UsGUFTCAhl1VogOYni18s5odim9M4lNuNAok+QZll
 grYabfb8eZZ/rFVboUZL14/PkcXFSONhGH2DlCzRK8k5kOC/mGuA/I6V5xVDjsXAz7I8
 h6WGMYL7970vfUQ8zQZD37u5nxH0hVmCo88KVpF56o0696uDNI1i35Tx7jg6e8UUqS1H
 6hJg==
X-Gm-Message-State: AC+VfDy8Ko35GSQQ9U53IWegNQyFTHitqMZogqLMIxqQ5pj5JAV0fbe3
 0E5dPNZ58eV1x/wDI8kv28CF1LbJF9DfFhgZD/s=
X-Google-Smtp-Source: ACHHUZ4ryDY1h6x06Kloj8JDV38DTYpbjdWIvPyTW7zxz7Cm54J/qa+Pu07Yk+vxNM1/EZeyR76U+A==
X-Received: by 2002:a05:6a00:1896:b0:63b:854c:e0f6 with SMTP id
 x22-20020a056a00189600b0063b854ce0f6mr20518336pfh.21.1684850010773; 
 Tue, 23 May 2023 06:53:30 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 08/52] tcg: Remove TCG_TARGET_TLB_DISPLACEMENT_BITS
Date: Tue, 23 May 2023 06:52:38 -0700
Message-Id: <20230523135322.678948-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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
index d5f7614880..cea21234cd 100644
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
index 0106946996..b0922922b3 100644
--- a/tcg/i386/tcg-target.h
+++ b/tcg/i386/tcg-target.h
@@ -28,7 +28,6 @@
 #include "host/cpuinfo.h"
 
 #define TCG_TARGET_INSN_UNIT_SIZE  1
-#define TCG_TARGET_TLB_DISPLACEMENT_BITS 31
 
 #ifdef __x86_64__
 # define TCG_TARGET_REG_BITS  64
diff --git a/tcg/mips/tcg-target.h b/tcg/mips/tcg-target.h
index 7277a117ef..e52cdf0e89 100644
--- a/tcg/mips/tcg-target.h
+++ b/tcg/mips/tcg-target.h
@@ -36,7 +36,6 @@
 #endif
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
-#define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
 #define TCG_TARGET_NB_REGS 32
 
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
diff --git a/tcg/ppc/tcg-target.h b/tcg/ppc/tcg-target.h
index 0914380bd7..d68a65a9bc 100644
--- a/tcg/ppc/tcg-target.h
+++ b/tcg/ppc/tcg-target.h
@@ -34,7 +34,6 @@
 
 #define TCG_TARGET_NB_REGS 64
 #define TCG_TARGET_INSN_UNIT_SIZE 4
-#define TCG_TARGET_TLB_DISPLACEMENT_BITS 16
 
 typedef enum {
     TCG_REG_R0,  TCG_REG_R1,  TCG_REG_R2,  TCG_REG_R3,
diff --git a/tcg/riscv/tcg-target.h b/tcg/riscv/tcg-target.h
index 494c986b49..ffb3d9b5b4 100644
--- a/tcg/riscv/tcg-target.h
+++ b/tcg/riscv/tcg-target.h
@@ -35,7 +35,6 @@
 #define TCG_TARGET_REG_BITS 64
 
 #define TCG_TARGET_INSN_UNIT_SIZE 4
-#define TCG_TARGET_TLB_DISPLACEMENT_BITS 20
 #define TCG_TARGET_NB_REGS 32
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
diff --git a/tcg/s390x/tcg-target.h b/tcg/s390x/tcg-target.h
index 170007bea5..2bbeeae5cd 100644
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



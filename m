Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E117057CA
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 21:46:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0Yk-0006iN-VN; Tue, 16 May 2023 15:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yj-0006hi-Bw
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:09 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0Yh-0002jw-Qz
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:42:09 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64ab2a37812so8109747b3a.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266127; x=1686858127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBJ0o8emlRVNnP9LnknwNquHEepyiJr2UVW8S3DFDz4=;
 b=xAUYy86iAr1xpNnSaXXKfd3jSPyJZQhmcnFDjTgxFCCsigEPOmwiOSid9L/D7p7264
 0VnGcaZmZvRfx4OCcDmOFBmriMw9P3uH6a9B1J1kNpxCQdSRxTm83d0aqffF3g76LEp9
 1u6V5pWd3sKnQI0D+78wzgj3cvzLnbbfPeru5xPxrmmLei5L6YVqS/dFlR2+et3htsgD
 sdGwxDM9gEhkoECh/Ala9u3WFF6gu5GV3qOvavE8CyZXOedO4lujRwVC30hiJzBo23HS
 UeQw7VvgUCZjeolkpbM2ELcDHbwUOQtJe3K+3G2vRZnQyv42atpetHIdal+s+7ymgUPa
 hnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266127; x=1686858127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBJ0o8emlRVNnP9LnknwNquHEepyiJr2UVW8S3DFDz4=;
 b=L8bLRUEvobERWiAPqPhZ3eR21LTQlgnJfXXQarrH5Kvs6whHDhKVrwVXgDSgAnQnQR
 FwVZeKFC7BTgU7d0tU3W3TLuNkxVYPtIRlvF+cgK+OYXa6O+5BZhXe5s3YMYWHzPtmXO
 WJd/wEnP8L46eucVErXbM5jpF+71aj1dDqLZi6vJVOm3MXTf5gO4clKP+g2Y3Giuszhl
 mII2EvK807H25JjxLLq0O68iNoSLIiM7HVSpZt5D1oL8QBubgCjTnvTgcZdE2uDR+aIh
 YR4R5vfE11Et0HQ/kHDive7Y3w936LWGu/iguMA8BlUApqC+RNrjURteYSHBisRd6RBG
 C2hQ==
X-Gm-Message-State: AC+VfDzo3j2RpS7HeTFkA2txGMJRvuiiEymIQy1WnTDdOfmhfDHeCUPi
 DRSE5O3YFXqOPtg0zf31zOagU7G1XyBcAS7vhEw=
X-Google-Smtp-Source: ACHHUZ6jrzoqpkgUIpd7JahR+Sxl8a0Ddsl3OpdqX6+5g89LQgfsGyTlFw3RNnsuPUCGjeg2UfnINQ==
X-Received: by 2002:a05:6a00:1a49:b0:646:24c6:5f9e with SMTP id
 h9-20020a056a001a4900b0064624c65f9emr35391059pfv.16.1684266127071; 
 Tue, 16 May 2023 12:42:07 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 z21-20020aa791d5000000b006260526cf0csm13771165pfa.116.2023.05.16.12.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:42:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 22/80] tcg/sparc64: Allocate %g2 as a third temporary
Date: Tue, 16 May 2023 12:40:47 -0700
Message-Id: <20230516194145.1749305-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index e997db2645..64464ab363 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -83,9 +83,10 @@ static const char * const tcg_target_reg_names[TCG_TARGET_NB_REGS] = {
 #define ALL_GENERAL_REGS     MAKE_64BIT_MASK(0, 32)
 #define ALL_QLDST_REGS       (ALL_GENERAL_REGS & ~SOFTMMU_RESERVE_REGS)
 
-/* Define some temporary registers.  T2 is used for constant generation.  */
+/* Define some temporary registers.  T3 is used for constant generation.  */
 #define TCG_REG_T1  TCG_REG_G1
-#define TCG_REG_T2  TCG_REG_O7
+#define TCG_REG_T2  TCG_REG_G2
+#define TCG_REG_T3  TCG_REG_O7
 
 #ifndef CONFIG_SOFTMMU
 # define TCG_GUEST_BASE_REG TCG_REG_I5
@@ -110,7 +111,6 @@ static const int tcg_target_reg_alloc_order[] = {
     TCG_REG_I4,
     TCG_REG_I5,
 
-    TCG_REG_G2,
     TCG_REG_G3,
     TCG_REG_G4,
     TCG_REG_G5,
@@ -492,8 +492,8 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
 static void tcg_out_movi(TCGContext *s, TCGType type,
                          TCGReg ret, tcg_target_long arg)
 {
-    tcg_debug_assert(ret != TCG_REG_T2);
-    tcg_out_movi_int(s, type, ret, arg, false, TCG_REG_T2);
+    tcg_debug_assert(ret != TCG_REG_T3);
+    tcg_out_movi_int(s, type, ret, arg, false, TCG_REG_T3);
 }
 
 static void tcg_out_ext8s(TCGContext *s, TCGType type, TCGReg rd, TCGReg rs)
@@ -885,10 +885,8 @@ static void tcg_out_jmpl_const(TCGContext *s, const tcg_insn_unit *dest,
 {
     uintptr_t desti = (uintptr_t)dest;
 
-    /* Be careful not to clobber %o7 for a tail call. */
     tcg_out_movi_int(s, TCG_TYPE_PTR, TCG_REG_T1,
-                     desti & ~0xfff, in_prologue,
-                     tail_call ? TCG_REG_G2 : TCG_REG_O7);
+                     desti & ~0xfff, in_prologue, TCG_REG_T2);
     tcg_out_arithi(s, tail_call ? TCG_REG_G0 : TCG_REG_O7,
                    TCG_REG_T1, desti & 0xfff, JMPL);
 }
@@ -1856,6 +1854,7 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_O6); /* stack pointer */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_T1); /* for internal use */
     tcg_regset_set_reg(s->reserved_regs, TCG_REG_T2); /* for internal use */
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_T3); /* for internal use */
 }
 
 #define ELF_HOST_MACHINE  EM_SPARCV9
-- 
2.34.1



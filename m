Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CBC7CEB4F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:31:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzQ-00083Y-1U; Wed, 18 Oct 2023 18:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzM-000825-W5
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:05 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzL-0002S3-99
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:04 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c5cd27b1acso62204985ad.2
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667962; x=1698272762; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3KCQIgln5kN/33Jyz8B+r1A500q3A4Jm4TEcmcp8vS8=;
 b=mVigu8Kp9SA8yT2LI8jyFYPC+KY3z7/tBOTkMPNiA0G6XVF8hVcfPJKj6Ax83ZZbHy
 adMQZMOXWMruGl5kgbvAvIhhwf8Swi2mKEnDAa8EA6pyLpuN4IKtgnm+71g7UdtYRria
 dp6KbGZ8JBmKYd9b+DhJqBxXzJ6Zdyyzh52nzBby4HwDIAAVwdZPkusSjwHAaiouPVAo
 EcSn5amWN6b+EC9U/PsK2G3OJmc+yDec3cvVJ7X6IJNsE3J5CUyX8/ZlYftsz0O7B+iU
 9UIF0oeR7/CWdch0nTkXgKzF5uvfWAktb5zCOsAPUgDMyMF8uVFRVmPUpKEimxdRuGrW
 taKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667962; x=1698272762;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3KCQIgln5kN/33Jyz8B+r1A500q3A4Jm4TEcmcp8vS8=;
 b=UFMB0ziXz5nQdGz3F6QBinVSfEk36kDENGrOOxd0RbaBI8Wta2no3sH/7QzcnLZaUL
 8Jz/r1SBPt1bmuBdyQTBMBqhsm8bJXi9kaQr3ZEaEf3I6hqcWNTlfRZk5Z1H9I1mK5gI
 OWc9C20FPZfwKTCiy7kOnDQYhLD6Lqyec/rnUM8owdBIft6FIK1b3QXXJNM/uw8XVVuy
 5ZO9exznjfS0iONVk1SY/Lvx3Okf/RM/xwFlZu183cxeMI8HaNcG3WcDHgIC7y+uPz05
 uwETyus5+fR+RfoSau/jciQA3wVSoQOKnMLwzIOnwx6qSBUuneTl1sk/OLZoLMLWVRwy
 twyQ==
X-Gm-Message-State: AOJu0YznNYsCegk5nkvToc5WgZ1uY021K1KOSKPa/PMV2w5afZJtiXTz
 boNmM0eCMsoumRNZpjeMXht7TqYlFUxeAWNOpM8=
X-Google-Smtp-Source: AGHT+IGuZ/CzxNXTYxYbO2n8DpimxEgr35tCRESsytN+NO1Vc8WTbRtaZXwDaIywji7hVYVXPdSy0g==
X-Received: by 2002:a17:902:ec85:b0:1b8:954c:1f6 with SMTP id
 x5-20020a170902ec8500b001b8954c01f6mr669586plg.36.1697667961760; 
 Wed, 18 Oct 2023 15:26:01 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/29] tcg/ppc: Reinterpret tb-relative to TB+4
Date: Wed, 18 Oct 2023 15:25:31 -0700
Message-Id: <20231018222557.1562065-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It saves one insn to load the address of TB+4 instead of TB.
Adjust all of the indexing to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 9197cfd6c6..aafbf2db4e 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -215,6 +215,12 @@ static const int tcg_target_callee_save_regs[] = {
     TCG_REG_R31
 };
 
+/* For PPC, we use TB+4 instead of TB as the base. */
+static inline ptrdiff_t ppc_tbrel_diff(TCGContext *s, const void *target)
+{
+    return tcg_tbrel_diff(s, target) - 4;
+}
+
 static inline bool in_range_b(tcg_target_long target)
 {
     return target == sextract64(target, 0, 26);
@@ -991,7 +997,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     }
 
     /* Load addresses within the TB with one insn.  */
-    tb_diff = tcg_tbrel_diff(s, (void *)arg);
+    tb_diff = ppc_tbrel_diff(s, (void *)arg);
     if (!in_prologue && USE_REG_TB && tb_diff == (int16_t)tb_diff) {
         tcg_out32(s, ADDI | TAI(ret, TCG_REG_TB, tb_diff));
         return;
@@ -1044,7 +1050,7 @@ static void tcg_out_movi_int(TCGContext *s, TCGType type, TCGReg ret,
     /* Use the constant pool, if possible.  */
     if (!in_prologue && USE_REG_TB) {
         new_pool_label(s, arg, R_PPC_ADDR16, s->code_ptr,
-                       tcg_tbrel_diff(s, NULL));
+                       ppc_tbrel_diff(s, NULL));
         tcg_out32(s, LD | TAI(ret, TCG_REG_TB, 0));
         return;
     }
@@ -1104,7 +1110,7 @@ static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
      */
     if (USE_REG_TB) {
         rel = R_PPC_ADDR16;
-        add = tcg_tbrel_diff(s, NULL);
+        add = ppc_tbrel_diff(s, NULL);
     } else {
         rel = R_PPC_ADDR32;
         add = 0;
@@ -2531,7 +2537,6 @@ static void tcg_out_tb_start(TCGContext *s)
         /* bcl 20,31,$+4 (preferred form for getting nia) */
         tcg_out32(s, BC | BO_ALWAYS | BI(7, CR_SO) | 0x4 | LK);
         tcg_out32(s, MFSPR | RT(TCG_REG_TB) | LR);
-        tcg_out32(s, ADDI | TAI(TCG_REG_TB, TCG_REG_TB, -4));
     }
 }
 
@@ -2551,7 +2556,7 @@ static void tcg_out_goto_tb(TCGContext *s, int which)
 
     /* When branch is out of range, fall through to indirect. */
     if (USE_REG_TB) {
-        ptrdiff_t offset = tcg_tbrel_diff(s, (void *)ptr);
+        ptrdiff_t offset = ppc_tbrel_diff(s, (void *)ptr);
         tcg_out_mem_long(s, LD, LDX, TCG_REG_TMP1, TCG_REG_TB, offset);
     } else {
         tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_TMP1, ptr - (int16_t)ptr);
-- 
2.34.1



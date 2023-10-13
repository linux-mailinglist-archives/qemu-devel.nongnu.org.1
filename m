Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D83137C8C22
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:12:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLg7-00011V-8E; Fri, 13 Oct 2023 13:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg4-00010y-LA
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:20 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg2-0005Uq-7l
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:20 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-57bca5b9b0aso1247018eaf.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697217017; x=1697821817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3KCQIgln5kN/33Jyz8B+r1A500q3A4Jm4TEcmcp8vS8=;
 b=mSF6ukjJSoI/rQE2HH8nvfZtF3hRdPp8vUVL0pjnYpt/lGz+lkCfFfviRxQlE92U6D
 R14i+F71Fh1jB7Ct7vbl1exkVhkhrJfnaaRE0K7XRzCn7hD9bYJxbH/MP4plfSJGi/PV
 rICu0W6duTowOgOvBCmNVTMUdZYakkEKnvrHiwinJoOA2ftBmIzeQHSlBwxV37o/Hxyq
 drOO/rKpJ4iZaMW1Pn8BqhmA6DZ1WCdOYGCxrNOH9ZIgT9YxIKZkef5dp+YOmbMpDVdb
 U8b1+gGTKCqaSIZ9sLem6+PX2BA7mIS0B6xqgfmoPhTYfpu+Fv/D69iXxSAAJL6D9Mqu
 8R6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697217017; x=1697821817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3KCQIgln5kN/33Jyz8B+r1A500q3A4Jm4TEcmcp8vS8=;
 b=pANTRh6j4iBMde/kZgh/Q1Ko5O2hzPz1g7tLnPBIYzUlV4Png1/a+S/8wPPwbc3Z4t
 T5xa1qhbDTCYlCiEsjlDwa9ZDXZ9ckz6/5XQrCnGltaHsskc8Zw+kOMJwpVOAf4oTdP1
 QA7oz+7HvEurK9vxSqfgFPimiLXMsucIxujlmd6yIO6w3Ro8qIkATpraJrcBZs6ZezDA
 YTADLmXsUkREFqez70BE2jc0N9kLn23reVfIfuEMlM3bYpzkj/rHtwYlPIoMls0v+9zu
 NiERLj3rGSROf7usojJ+o8JRAsZVhafsNSUw5EtPPVc916c1VSU5A8x/lg53tZaBJWz9
 Pkzw==
X-Gm-Message-State: AOJu0Yz/8+gOqFIfJJ0idJ2k4/nzHXG+LlHVDE+hBWEbaRQJYLuS5NKa
 kGnna0/THmlCCmUiBHfFAk+Z86RqOaBDZ8bDXMs=
X-Google-Smtp-Source: AGHT+IFRsdH/oxx7nhtsZlWld4tMAuZOVW+l2rNVWq5/e39nJ51aN9GasOwXzfq/Rz/+gVnkkGNmGQ==
X-Received: by 2002:a05:6358:63a7:b0:14b:d9de:3008 with SMTP id
 k39-20020a05635863a700b0014bd9de3008mr33549136rwh.5.1697217016841; 
 Fri, 13 Oct 2023 10:10:16 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00693411c6c3csm13687926pff.39.2023.10.13.10.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:10:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com
Subject: [PATCH v4 03/13] tcg/ppc: Reinterpret tb-relative to TB+4
Date: Fri, 13 Oct 2023 10:10:02 -0700
Message-Id: <20231013171012.122980-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013171012.122980-1-richard.henderson@linaro.org>
References: <20231013171012.122980-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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



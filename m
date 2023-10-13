Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1027C8C25
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:12:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrLg7-00011e-GN; Fri, 13 Oct 2023 13:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg5-00011A-0U
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:21 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrLg3-0005Vg-58
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:10:20 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-694ed847889so1976285b3a.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697217018; x=1697821818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ll1AHH/tNyWuM8OWYdUz/S/zYn03mj8222BJRAroDbQ=;
 b=kLQarSCAeMa9WTVKBTIjLIAec4jASN83fW3CIlzIqLifl5KA9P1jH5PFBKLO1KOR9p
 sAisUZlqxPsXAJSgQOZN8KvNUWw/W9zOLxWO7Qxt9O3kHm1gEASwj/0F1R0nQrO8f8J9
 lfqoGX6+Q80x93NZZ80ZRq+AFaavdLdmM2c/OvAdfFmpVLxt93FkSqERpEM/E3djkHjj
 /djVQuY4CZMdh31TeO+nKRh5ca5v6c4btCd2diXZ8tw8rwEn4CRH0DWf5bTN0C43a918
 7lcqz5E6mV6VZ7x3FeRa51oWxzWkC6z23A6zRbQRaJaJYSfvNzYoPeucJC1/IFqO53Pb
 rckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697217018; x=1697821818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ll1AHH/tNyWuM8OWYdUz/S/zYn03mj8222BJRAroDbQ=;
 b=GfZ4bj243HPW9GEKZswwtj7pUg8QjqBejtnDpqM7wmYp7W4blEP8NunnVwGcUzHP3Q
 ViHTXMiQ9ehmXweDX32Pmc8kqR3KTbWKGscspmaYc2hwHR5/341/IajG3ZKaylIg4u/P
 4Y1R3uEdRhp1gf2ftdTlKx1GnuCo7bcn6VzgcUCV5UiEzHiyV8Ay07HIM5nDjDRFJL8T
 R2k5c7qKJsAxwFxafctCV5vpb8S3VwmRyAl5BcuYXRwNonXOsCrXcsr1qutF4gIIjtA/
 FGv5XGyyNEGedlICNZ0sXAl0oRuVNRMtK/P+aD0F38bB7lry4R3XIBHmMN2punC7QBg4
 /Isw==
X-Gm-Message-State: AOJu0YyoVDkI+IhHp6UkbTaYLRi2j7y7K6ZEtRUqhRdxq82B7k7EPRF9
 R786T7Xuf3xa82Jsgx6UjXVWZ/zX3jKwhn+2c7A=
X-Google-Smtp-Source: AGHT+IG0q1PTgta9hmhpj2dMph71pc5oG/7YUcYdzQAAAwg9oZXJfYGRqWfSE101u12WbXcB+qwOJw==
X-Received: by 2002:a05:6a00:80f:b0:68e:36b1:3d7f with SMTP id
 m15-20020a056a00080f00b0068e36b13d7fmr30899402pfk.18.1697217017702; 
 Fri, 13 Oct 2023 10:10:17 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 n7-20020a62e507000000b00693411c6c3csm13687926pff.39.2023.10.13.10.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:10:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: jniethe5@gmail.com
Subject: [PATCH v4 04/13] tcg/ppc: Use ADDPCIS in tcg_out_tb_start
Date: Fri, 13 Oct 2023 10:10:03 -0700
Message-Id: <20231013171012.122980-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013171012.122980-1-richard.henderson@linaro.org>
References: <20231013171012.122980-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

With ISA v3.0, we can use ADDPCIS instead of BCL+MFLR to load NIA.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.c.inc | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index aafbf2db4e..b0b8cd2390 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -362,6 +362,7 @@ static bool tcg_target_const_match(int64_t val, TCGType type, int ct, int vece)
 #define CRNAND XO19(225)
 #define CROR   XO19(449)
 #define CRNOR  XO19( 33)
+#define ADDPCIS XO19( 2)
 
 #define EXTSB  XO31(954)
 #define EXTSH  XO31(922)
@@ -859,6 +860,19 @@ static inline void tcg_out_sari64(TCGContext *s, TCGReg dst, TCGReg src, int c)
     tcg_out32(s, SRADI | RA(dst) | RS(src) | SH(c & 0x1f) | ((c >> 4) & 2));
 }
 
+static void tcg_out_addpcis(TCGContext *s, TCGReg dst, intptr_t imm)
+{
+    uint32_t d0, d1, d2;
+
+    tcg_debug_assert((imm & 0xffff) == 0);
+    tcg_debug_assert(imm == (int32_t)imm);
+
+    d2 = extract32(imm, 16, 1);
+    d1 = extract32(imm, 17, 5);
+    d0 = extract32(imm, 22, 10);
+    tcg_out32(s, ADDPCIS | RT(dst) | (d1 << 16) | (d0 << 6) | d2);
+}
+
 static void tcg_out_bswap16(TCGContext *s, TCGReg dst, TCGReg src, int flags)
 {
     TCGReg tmp = dst == src ? TCG_REG_R0 : dst;
@@ -2534,9 +2548,14 @@ static void tcg_out_tb_start(TCGContext *s)
 {
     /* Load TCG_REG_TB. */
     if (USE_REG_TB) {
-        /* bcl 20,31,$+4 (preferred form for getting nia) */
-        tcg_out32(s, BC | BO_ALWAYS | BI(7, CR_SO) | 0x4 | LK);
-        tcg_out32(s, MFSPR | RT(TCG_REG_TB) | LR);
+        if (have_isa_3_00) {
+            /* lnia REG_TB */
+            tcg_out_addpcis(s, TCG_REG_TB, 0);
+        } else {
+            /* bcl 20,31,$+4 (preferred form for getting nia) */
+            tcg_out32(s, BC | BO_ALWAYS | BI(7, CR_SO) | 0x4 | LK);
+            tcg_out32(s, MFSPR | RT(TCG_REG_TB) | LR);
+        }
     }
 }
 
-- 
2.34.1



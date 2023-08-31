Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C519578E4F3
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 05:08:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbY1k-0003YF-K4; Wed, 30 Aug 2023 23:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbY1i-0003Xu-AW
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 23:07:22 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbY1f-00012r-Vq
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 23:07:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c0c6d4d650so2666905ad.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 20:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693451238; x=1694056038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JsBwcmai69DwtSy3p5qDNG9Z2ep35wWirnfrfJquRn4=;
 b=UmFgATo9WF9k871l77mqIW2ZZbBSWt9tfCqrfDwlw/pygMYYqp8KKotscM1PyxwoqU
 CF2Q2tW7d4V9HrIMqBehkwIlQG94vOHQyHGkH+co1AlwP6GQyq55tWH5qrjqlHBqMh8F
 GbuggpoLLh7I2lgQFEk3bjRhJLgARIvcvf2cUGw1aVLa5A2ddwk8hbKzWMN9pOt0lKVU
 8+5DmQj4Zws0U80j50i3hNswfXhkhSmNeXp6jUL4sCYBcxQYRg8v/gJpeZvzOUteo1AE
 LUZ1RCikqisNdbB4hwCVBvBADXIrZAJTCGdmx7ypx1WRYlsZ67P1zzZsyh+UkM7UuqCJ
 4iKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693451238; x=1694056038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JsBwcmai69DwtSy3p5qDNG9Z2ep35wWirnfrfJquRn4=;
 b=gRleVMO6XVpJR6eKIqM8vnrCqpNHerrvKDUuRE9NB/WDb8hIeFbiHCXwAweEHXDlJs
 cJglueMvqnOBeZY/1X2rO9gkIblPY+B56wbWncTIlHUdeBi636/61MU0LlqTBhnw5I1H
 VTs5wYmbBeS/v10MXyJ1ag7Jw3ktv81z73rqz+qNlTGynKFW3z4f0iT3l2eojkK9qPyg
 aaBpSAk6xI2tXn+WKqdJ2NXH7kwlFGNP5Zby2H7KdtaI2GO5SHrTcEUTpcnQuRgzWgG/
 EvZ5G2jjEN5PKlaS1F7nXV388LUWeIXw+2arVR2Qi/PXVoMfhar8H1xFi0UDQlMddkQ4
 fV6g==
X-Gm-Message-State: AOJu0YwwCS0CvrtN2CEhZQG8tPqXGA0fU8egwmcM9fpwcz/E0e8tfliI
 UTkhl9safEC84vD/X3EzH4oihNBMSn/cCNZ4sE4=
X-Google-Smtp-Source: AGHT+IF9I+sBYeBkOR034RQijVb5ZMu/Zkqj9/wRs5gsgCc51QYN2ZRmMIV6K3xGXKeBxkTXZraaig==
X-Received: by 2002:a17:902:cec5:b0:1c0:ec66:f2b2 with SMTP id
 d5-20020a170902cec500b001c0ec66f2b2mr4708049plg.27.1693451238518; 
 Wed, 30 Aug 2023 20:07:18 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 ju19-20020a170903429300b001b8c689060dsm228847plb.28.2023.08.30.20.07.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 20:07:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/i386: Use i128 for 128 and 256-bit loads and stores
Date: Wed, 30 Aug 2023 20:07:14 -0700
Message-Id: <20230831030714.1194595-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831030714.1194595-1-richard.henderson@linaro.org>
References: <20230831030714.1194595-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 61 ++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 90c7b32f36..bbcb81e908 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2919,58 +2919,51 @@ static inline void gen_stq_env_A0(DisasContext *s, int offset)
 static inline void gen_ldo_env_A0(DisasContext *s, int offset, bool align)
 {
     int mem_index = s->mem_index;
-    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0, mem_index,
-                        MO_LEUQ | (align ? MO_ALIGN_16 : 0));
-    tcg_gen_st_i64(s->tmp1_i64, cpu_env, offset + offsetof(XMMReg, XMM_Q(0)));
-    tcg_gen_addi_tl(s->tmp0, s->A0, 8);
-    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
-    tcg_gen_st_i64(s->tmp1_i64, cpu_env, offset + offsetof(XMMReg, XMM_Q(1)));
+    TCGv_i128 t = tcg_temp_new_i128();
+
+    tcg_gen_qemu_ld_i128(t, s->A0, mem_index,
+                         MO_128 | MO_LE | (align ? MO_ALIGN_16 : 0));
+    tcg_gen_st_i128(t, cpu_env, offset);
 }
 
 static inline void gen_sto_env_A0(DisasContext *s, int offset, bool align)
 {
     int mem_index = s->mem_index;
-    tcg_gen_ld_i64(s->tmp1_i64, cpu_env, offset + offsetof(XMMReg, XMM_Q(0)));
-    tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0, mem_index,
-                        MO_LEUQ | (align ? MO_ALIGN_16 : 0));
-    tcg_gen_addi_tl(s->tmp0, s->A0, 8);
-    tcg_gen_ld_i64(s->tmp1_i64, cpu_env, offset + offsetof(XMMReg, XMM_Q(1)));
-    tcg_gen_qemu_st_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
+    TCGv_i128 t = tcg_temp_new_i128();
+
+    tcg_gen_ld_i128(t, cpu_env, offset);
+    tcg_gen_qemu_st_i128(t, s->A0, mem_index,
+                         MO_128 | MO_LE | (align ? MO_ALIGN_16 : 0));
 }
 
 static void gen_ldy_env_A0(DisasContext *s, int offset, bool align)
 {
     int mem_index = s->mem_index;
-    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0, mem_index,
-                        MO_LEUQ | (align ? MO_ALIGN_32 : 0));
-    tcg_gen_st_i64(s->tmp1_i64, cpu_env, offset + offsetof(YMMReg, YMM_Q(0)));
-    tcg_gen_addi_tl(s->tmp0, s->A0, 8);
-    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
-    tcg_gen_st_i64(s->tmp1_i64, cpu_env, offset + offsetof(YMMReg, YMM_Q(1)));
+    TCGv_i128 t0 = tcg_temp_new_i128();
+    TCGv_i128 t1 = tcg_temp_new_i128();
 
+    tcg_gen_qemu_ld_i128(t0, s->A0, mem_index,
+                         MO_128 | MO_LE | (align ? MO_ALIGN_32 : 0));
     tcg_gen_addi_tl(s->tmp0, s->A0, 16);
-    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
-    tcg_gen_st_i64(s->tmp1_i64, cpu_env, offset + offsetof(YMMReg, YMM_Q(2)));
-    tcg_gen_addi_tl(s->tmp0, s->A0, 24);
-    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
-    tcg_gen_st_i64(s->tmp1_i64, cpu_env, offset + offsetof(YMMReg, YMM_Q(3)));
+    tcg_gen_qemu_ld_i128(t1, s->tmp0, mem_index,
+                         MO_128 | MO_LE | (align ? MO_ALIGN_16 : 0));
+
+    tcg_gen_st_i128(t0, cpu_env, offset + offsetof(YMMReg, YMM_X(0)));
+    tcg_gen_st_i128(t1, cpu_env, offset + offsetof(YMMReg, YMM_X(1)));
 }
 
 static void gen_sty_env_A0(DisasContext *s, int offset, bool align)
 {
     int mem_index = s->mem_index;
-    tcg_gen_ld_i64(s->tmp1_i64, cpu_env, offset + offsetof(YMMReg, YMM_Q(0)));
-    tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0, mem_index,
-                        MO_LEUQ | (align ? MO_ALIGN_32 : 0));
-    tcg_gen_addi_tl(s->tmp0, s->A0, 8);
-    tcg_gen_ld_i64(s->tmp1_i64, cpu_env, offset + offsetof(YMMReg, YMM_Q(1)));
-    tcg_gen_qemu_st_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
+    TCGv_i128 t = tcg_temp_new_i128();
+
+    tcg_gen_ld_i128(t, cpu_env, offset + offsetof(YMMReg, YMM_X(0)));
+    tcg_gen_qemu_st_i128(t, s->A0, mem_index,
+                         MO_128 | MO_LE | (align ? MO_ALIGN_32 : 0));
     tcg_gen_addi_tl(s->tmp0, s->A0, 16);
-    tcg_gen_ld_i64(s->tmp1_i64, cpu_env, offset + offsetof(YMMReg, YMM_Q(2)));
-    tcg_gen_qemu_st_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
-    tcg_gen_addi_tl(s->tmp0, s->A0, 24);
-    tcg_gen_ld_i64(s->tmp1_i64, cpu_env, offset + offsetof(YMMReg, YMM_Q(3)));
-    tcg_gen_qemu_st_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
+    tcg_gen_ld_i128(t, cpu_env, offset + offsetof(YMMReg, YMM_X(1)));
+    tcg_gen_qemu_st_i128(t, s->tmp0, mem_index,
+                         MO_128 | MO_LE | (align ? MO_ALIGN_16 : 0));
 }
 
 #include "decode-new.h"
-- 
2.34.1



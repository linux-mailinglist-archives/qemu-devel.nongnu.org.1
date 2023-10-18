Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 860077CEB30
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:27:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEzo-0008Em-5j; Wed, 18 Oct 2023 18:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzk-0008DO-2w
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:28 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEzi-0002XE-82
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 18:26:27 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cab2c24ecdso2579805ad.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 15:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697667984; x=1698272784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VWfRq90wjGAr0oweacpv5OPKCpxjoxKXHInDtElvTJQ=;
 b=Tem9QmnoidsKj8YSLhQTsZr4LvyoGN+FE3T6vlSIJwTk3yhVB3PzUOT0mF/I1pXPmW
 Jw/1kIHChfR78WXZ40HEyUkMGWsb7W0Bw1W2+iCF4p4PK/vox83HVYxXThtUFRPVedpf
 z0ZfAsnjMOzJH/I5pBjqGwvRQ7TkLZ/V5xE2l9w3uEEBvwgCdoBGyVpTZr/VHv7zFiwt
 FvTwBeBkbodhyAhsDTCLrZPIXvPqnTBG78s9VTK2hyOpIPhudXGPczwvuko6QYMHihB6
 JI3x5ysDWZq4oCFEkBuvi0aU8wunpQDnxTAdl6m6FX5qlecEyGkcsa02OoGkMf23lRTI
 24sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697667984; x=1698272784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VWfRq90wjGAr0oweacpv5OPKCpxjoxKXHInDtElvTJQ=;
 b=nQBbbS8hx6XBdF7IHFv7k9gPz1wVLenaeG4Gya0ALQ4dq0VgxNifT6mlcPuuhq6NSs
 sC6mYo1w91SjhRwu2YtGMS/nwsyA6XAUig7u93Gld2LExiTHfYVgSFT6qA3hfEqighyv
 0FfGFF+sdpxRdeKNuFVRTJnyIvrTtseZnZVUFDe6tpbt36uz9n0nRdCwOYWiFEKHrVCu
 3QM/29Nse47AbTE86RZKLv9EcbQy2ySQrw3nJZYElyX7fFEU6K0bdahd+xaKT8n+mzi4
 GTqMCSNdCXsDtKw5L7pxGwcYzOluSg9ZdvW9TVLblotiH1znj48O20ZH2DrmVPKjKd1f
 Sltg==
X-Gm-Message-State: AOJu0YwNJBWq9xKQxJranPGtfoBq/609KOKPYt1RmDqN2XsW8xX6cuOI
 MOgFnMciPj1CCixTOQp+Llr0dCyxFHMvXzL6GEg=
X-Google-Smtp-Source: AGHT+IFiZPrODE08bPiVJo7MjtgYgyVFK/h5lSVdHOfLEmKC8+AjOMw9pGH7WTUwKho6dcmVMghx4Q==
X-Received: by 2002:a17:903:258a:b0:1ca:8a38:38c4 with SMTP id
 jb10-20020a170903258a00b001ca8a3838c4mr597135plb.27.1697667984279; 
 Wed, 18 Oct 2023 15:26:24 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001b9d95945afsm431058plg.155.2023.10.18.15.26.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 15:26:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/29] target/i386: Use i128 for 128 and 256-bit loads and
 stores
Date: Wed, 18 Oct 2023 15:25:57 -0700
Message-Id: <20231018222557.1562065-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018222557.1562065-1-richard.henderson@linaro.org>
References: <20231018222557.1562065-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 target/i386/tcg/translate.c | 63 +++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 34 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d2061ec44a..0c81e066de 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -2918,59 +2918,54 @@ static inline void gen_stq_env_A0(DisasContext *s, int offset)
 
 static inline void gen_ldo_env_A0(DisasContext *s, int offset, bool align)
 {
+    MemOp atom = (s->cpuid_ext_features & CPUID_EXT_AVX
+                  ? MO_ATOM_IFALIGN : MO_ATOM_IFALIGN_PAIR);
+    MemOp mop = MO_128 | MO_LE | atom | (align ? MO_ALIGN_16 : 0);
     int mem_index = s->mem_index;
-    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0, mem_index,
-                        MO_LEUQ | (align ? MO_ALIGN_16 : 0));
-    tcg_gen_st_i64(s->tmp1_i64, tcg_env, offset + offsetof(XMMReg, XMM_Q(0)));
-    tcg_gen_addi_tl(s->tmp0, s->A0, 8);
-    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
-    tcg_gen_st_i64(s->tmp1_i64, tcg_env, offset + offsetof(XMMReg, XMM_Q(1)));
+    TCGv_i128 t = tcg_temp_new_i128();
+
+    tcg_gen_qemu_ld_i128(t, s->A0, mem_index, mop);
+    tcg_gen_st_i128(t, tcg_env, offset);
 }
 
 static inline void gen_sto_env_A0(DisasContext *s, int offset, bool align)
 {
+    MemOp atom = (s->cpuid_ext_features & CPUID_EXT_AVX
+                  ? MO_ATOM_IFALIGN : MO_ATOM_IFALIGN_PAIR);
+    MemOp mop = MO_128 | MO_LE | atom | (align ? MO_ALIGN_16 : 0);
     int mem_index = s->mem_index;
-    tcg_gen_ld_i64(s->tmp1_i64, tcg_env, offset + offsetof(XMMReg, XMM_Q(0)));
-    tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0, mem_index,
-                        MO_LEUQ | (align ? MO_ALIGN_16 : 0));
-    tcg_gen_addi_tl(s->tmp0, s->A0, 8);
-    tcg_gen_ld_i64(s->tmp1_i64, tcg_env, offset + offsetof(XMMReg, XMM_Q(1)));
-    tcg_gen_qemu_st_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
+    TCGv_i128 t = tcg_temp_new_i128();
+
+    tcg_gen_ld_i128(t, tcg_env, offset);
+    tcg_gen_qemu_st_i128(t, s->A0, mem_index, mop);
 }
 
 static void gen_ldy_env_A0(DisasContext *s, int offset, bool align)
 {
+    MemOp mop = MO_128 | MO_LE | MO_ATOM_IFALIGN_PAIR;
     int mem_index = s->mem_index;
-    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->A0, mem_index,
-                        MO_LEUQ | (align ? MO_ALIGN_32 : 0));
-    tcg_gen_st_i64(s->tmp1_i64, tcg_env, offset + offsetof(YMMReg, YMM_Q(0)));
-    tcg_gen_addi_tl(s->tmp0, s->A0, 8);
-    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
-    tcg_gen_st_i64(s->tmp1_i64, tcg_env, offset + offsetof(YMMReg, YMM_Q(1)));
+    TCGv_i128 t0 = tcg_temp_new_i128();
+    TCGv_i128 t1 = tcg_temp_new_i128();
 
+    tcg_gen_qemu_ld_i128(t0, s->A0, mem_index, mop | (align ? MO_ALIGN_32 : 0));
     tcg_gen_addi_tl(s->tmp0, s->A0, 16);
-    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
-    tcg_gen_st_i64(s->tmp1_i64, tcg_env, offset + offsetof(YMMReg, YMM_Q(2)));
-    tcg_gen_addi_tl(s->tmp0, s->A0, 24);
-    tcg_gen_qemu_ld_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
-    tcg_gen_st_i64(s->tmp1_i64, tcg_env, offset + offsetof(YMMReg, YMM_Q(3)));
+    tcg_gen_qemu_ld_i128(t1, s->tmp0, mem_index, mop);
+
+    tcg_gen_st_i128(t0, tcg_env, offset + offsetof(YMMReg, YMM_X(0)));
+    tcg_gen_st_i128(t1, tcg_env, offset + offsetof(YMMReg, YMM_X(1)));
 }
 
 static void gen_sty_env_A0(DisasContext *s, int offset, bool align)
 {
+    MemOp mop = MO_128 | MO_LE | MO_ATOM_IFALIGN_PAIR;
     int mem_index = s->mem_index;
-    tcg_gen_ld_i64(s->tmp1_i64, tcg_env, offset + offsetof(YMMReg, YMM_Q(0)));
-    tcg_gen_qemu_st_i64(s->tmp1_i64, s->A0, mem_index,
-                        MO_LEUQ | (align ? MO_ALIGN_32 : 0));
-    tcg_gen_addi_tl(s->tmp0, s->A0, 8);
-    tcg_gen_ld_i64(s->tmp1_i64, tcg_env, offset + offsetof(YMMReg, YMM_Q(1)));
-    tcg_gen_qemu_st_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
+    TCGv_i128 t = tcg_temp_new_i128();
+
+    tcg_gen_ld_i128(t, tcg_env, offset + offsetof(YMMReg, YMM_X(0)));
+    tcg_gen_qemu_st_i128(t, s->A0, mem_index, mop | (align ? MO_ALIGN_32 : 0));
     tcg_gen_addi_tl(s->tmp0, s->A0, 16);
-    tcg_gen_ld_i64(s->tmp1_i64, tcg_env, offset + offsetof(YMMReg, YMM_Q(2)));
-    tcg_gen_qemu_st_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
-    tcg_gen_addi_tl(s->tmp0, s->A0, 24);
-    tcg_gen_ld_i64(s->tmp1_i64, tcg_env, offset + offsetof(YMMReg, YMM_Q(3)));
-    tcg_gen_qemu_st_i64(s->tmp1_i64, s->tmp0, mem_index, MO_LEUQ);
+    tcg_gen_ld_i128(t, tcg_env, offset + offsetof(YMMReg, YMM_X(1)));
+    tcg_gen_qemu_st_i128(t, s->tmp0, mem_index, mop);
 }
 
 #include "decode-new.h"
-- 
2.34.1



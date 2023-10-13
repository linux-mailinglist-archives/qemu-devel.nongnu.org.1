Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8657C8C95
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 19:51:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrMJq-0001JZ-1C; Fri, 13 Oct 2023 13:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrMJo-0001JG-CH
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:51:24 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrMJf-0004kL-WC
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 13:51:22 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c9de3f66e5so17195705ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697219474; x=1697824274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWfRq90wjGAr0oweacpv5OPKCpxjoxKXHInDtElvTJQ=;
 b=pn68pz0zkxWegzUsDN1HNxef8R5P8CyFcnyQE0b29Ukti/B7x/Bj328I3dFSVx3FXm
 wGMTYgYWjdm+Cci0FLWrYVggSeXQzHsM0cxnHOWWKaJBmDx9yb77joC3qAjV050u5Kqz
 qZDizvrfyIvMVAXJs3ObNy34kIgR0wQBHUBnJCWsm7aMonnQa+YYNXwXRaFE0V5WagYy
 XHRqzwSlpLxY7B489/Gx9gRGp4GUuP1pHEmQ2oa5VQWj7zzYBl/QKBqgAGaf1bgvjhBS
 6m4tor7OuZ027o4c1nAeDogXgeMeld7tju5gWK8iqA1kuMNPf2OHMK7v7GVELphxrVOH
 ROsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697219474; x=1697824274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VWfRq90wjGAr0oweacpv5OPKCpxjoxKXHInDtElvTJQ=;
 b=JKBxPmcWDisI1msvq3iBmcEIWKeC0X7Jp5TKgywMuX31e7U13Tjsi4nAI6ELTam4rP
 HvSsGLvG4I0jAnpU+TARj7opONdBTT327cMiRP8arAJBnRSmedkLMMh7OJVv9X990LRR
 Wy0c2fa3TDGwnyd4gmlfa8dK/0yJD+R4267+FvpRG0PsV2NKbjobhXpe6uOHavMWiUqQ
 JW2FVRNd6ljPHtx5vc1M2MjxvIktdtoGln/ftbiYvRuK7rVabLllx77zUpEPnIuGTse5
 0XTatgV2+MSMtj2k/wN4kZsFRng2uAT71Tl1Jx+LLlSWeIVpme3/l6o+2pJx/ED3aNlv
 sLXA==
X-Gm-Message-State: AOJu0Ywn3w/pIHi1itlCP9d5Ht4v2PLn/KfeLhvpVXjn5w/tCdmFXrfn
 rlNU8cTZr7oDQyRVn2lpQi7xH82abreWcyT8Zl4=
X-Google-Smtp-Source: AGHT+IGUqd1K8FyVw4Yuzux/UA4DD4ciEbJQrQRh7SIxoISMU8uMD3TkYua3pulAJWiY4XBi2G+1tw==
X-Received: by 2002:a17:902:ab82:b0:1c7:443d:7419 with SMTP id
 f2-20020a170902ab8200b001c7443d7419mr25448473plr.29.1697219474462; 
 Fri, 13 Oct 2023 10:51:14 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h24-20020a170902ac9800b001c3be750900sm4164324plr.163.2023.10.13.10.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 10:51:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 2/2] target/i386: Use i128 for 128 and 256-bit loads and
 stores
Date: Fri, 13 Oct 2023 10:51:09 -0700
Message-Id: <20231013175109.124308-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013175109.124308-1-richard.henderson@linaro.org>
References: <20231013175109.124308-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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



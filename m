Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5607D3ECF
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:16:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRG-0005nW-7e; Mon, 23 Oct 2023 14:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRB-0005h7-CF
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:01 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzR8-0008HH-Mq
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:00 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6b9af7d41d2so2967446b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084837; x=1698689637; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/+snroCXssJGe4IIYkDLyy8cs4QbLodfmBU5jWNYWK4=;
 b=XSg1ExP6acc9Vzx3uYkyP4sRL8IiyVW39KX/D32XpG7+qOAFy4rMwoAz9ZPTBsfScL
 THZEtsDSZ0Fsh2aLROPV0piwP2w/6xuSmzxmM31eyL/DxxaZzJLZNOyO2dX1NO4CK9Bj
 qlEPBYeYdNjVgx7956steRX8UprdlzlB5GCqtcBhb5KPMjpbD59vvTPvFzyYlyXr5yk1
 XeWZWSLWb9/f+gwXzMS7eovWHCMiFQnJolmXAfe4aQ/7/vWS2j6amEtJZgKt8Q2ku0aH
 INA/BGBDQDJxqu4tp3DSAY7fdeNF2zKrKR6MKaqMGKtxvDot0DgywNY55kb4S0kfbLkr
 pVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084837; x=1698689637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/+snroCXssJGe4IIYkDLyy8cs4QbLodfmBU5jWNYWK4=;
 b=Sbe4Xp9lyiXJ+Tq/TVwh9YGLa4fWkpojrYK3exNPXW+jxH39fZ0ah1fQ8oeQRRAOu7
 822NsRIo+n/rdNphJhgIXMOWNESlAkwkdU+YgjGHwFx+4EKznloBicn9PJ4uiUAMHmN0
 1NY0aKsw0yolHI92xAjatKJfDQsh+vfnj9wD3+ogL1D4HnmGKWMnq4CseC5zvlMDV7RZ
 0n4S74Fm78ybFhbf25A+zwTZx6+ydIkNLRZQxfbC2roE2C8XjHhJ+TGCir5HEvahSlJk
 7xv86WMROlZOyP56K34UUw7j/69wSQAcshjVCNQldtKSUfF3kEt9sNWjgriG+OtZ6RBt
 tB0w==
X-Gm-Message-State: AOJu0YwQF3OCuwWLTOmVBgmfK05w9weox15+KZAs+jfqFb/HUJP6aklH
 1dw0HAsGtL1MO8p/qWh7i5GOYEqCr1zceMnk/i4=
X-Google-Smtp-Source: AGHT+IEIIeZL57lAHkc7efbkYWAL4qEdGOElPcH5sUwm6QdOSaoes+jLALUCrYI5dHZwL9iGaHR+Cw==
X-Received: by 2002:a05:6a21:3e0a:b0:14b:f9b2:eb7 with SMTP id
 bk10-20020a056a213e0a00b0014bf9b20eb7mr316254pzc.59.1698084836703; 
 Mon, 23 Oct 2023 11:13:56 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 29/38] target/i386: Use i128 for 128 and 256-bit loads and
 stores
Date: Mon, 23 Oct 2023 11:13:20 -0700
Message-Id: <20231023181329.171490-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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
index 4f6f9fa7e5..18d06ab247 100644
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



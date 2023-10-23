Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DD57D3EF8
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:18:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzQv-0005VF-2x; Mon, 23 Oct 2023 14:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQr-0005UG-U2
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:42 -0400
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzQl-00085D-Pq
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:13:41 -0400
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-584042a01eeso2273662eaf.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084814; x=1698689614; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ll1AHH/tNyWuM8OWYdUz/S/zYn03mj8222BJRAroDbQ=;
 b=rAPdpyopiZmJ2FUfdY8NebQOYujXwtkbtENSi+g55xn509DqYjRhcx9quHBf1DYA2B
 KAHdOe2yk7c3NbE67xcpVR81ZZZEBSu0tGWkpDg8phP2kZRo8fjPiMAEobBCRKFHJl6q
 oqu/qNu2nbL15m6v4YolLLxws+01mmvcXGTbWhXbUd0eB5oSMzmtkN1JyEzET3s8w01K
 W1RvLigr26T1hVOvGD6V7YB00s/RBx4CVoJmhdXJvH8HXQ/igiKm5NSnidlO4Ex4Z+3l
 fC/Sul2cVoMiLTSiW8E5p2h+77F6XywbeKTmjmg5e2EUWLC/dxuFKEuEunuIq79TA+St
 r3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084814; x=1698689614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ll1AHH/tNyWuM8OWYdUz/S/zYn03mj8222BJRAroDbQ=;
 b=CJ7iJr/TRmUv/Sy+wO2wNNsjNcZH/V13zvUbm3wysButhC3VD/zxV4EyrXsIevAuvJ
 FN90bXVAFe03CHX3eAgYNI5xGet746eAj+jIsVla2bIs5abVAYeD7ZXM4AZ/lpf5rqS/
 d5pvWKV26JgxVaw+Mttzipnmh41/jHJYy42WMR9wyT1mgWTmpsSrdAYKy6+0nhe9G/v/
 Y/eZH/JsZ9iOZMEn8ujCo90lSVLBpbEfMw30zvK9DhAZ39Iyw4HLBkps1pMWjoeGFZJk
 J7375p7coUHT2sQoWJ+koKlCTcyvrRiZ1X3ert1H4u88NrD66Iw5KBVqoNiyZT3hgJ0B
 bw2g==
X-Gm-Message-State: AOJu0Yy97Fx+Fz0QCwdWS0DkT6c1FOVlVJGgPkUoA5CwepkiCyunnosI
 ES988kv2Xn68xRjCQaZjnQRq1ykm4y8I/6eYYA0=
X-Google-Smtp-Source: AGHT+IFi1ZMr2HXhQHCpALqu+SOt0uQpXyGGBmHs6mHL+1QibLOI4ZUV/lbxIDKwrWjeMXnKDBSL+A==
X-Received: by 2002:a05:6358:3517:b0:168:ba46:d9dd with SMTP id
 m23-20020a056358351700b00168ba46d9ddmr8966192rwd.17.1698084814586; 
 Mon, 23 Oct 2023 11:13:34 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 04/38] tcg/ppc: Use ADDPCIS in tcg_out_tb_start
Date: Mon, 23 Oct 2023 11:12:55 -0700
Message-Id: <20231023181329.171490-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc35.google.com
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



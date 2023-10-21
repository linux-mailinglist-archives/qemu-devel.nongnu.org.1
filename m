Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBA47D1B05
	for <lists+qemu-devel@lfdr.de>; Sat, 21 Oct 2023 07:40:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qu4eP-0002hj-G3; Sat, 21 Oct 2023 01:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eF-0002Uu-Gm
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:43 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qu4eC-00015u-K2
 for qemu-devel@nongnu.org; Sat, 21 Oct 2023 01:35:43 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6b36e1fcea0so1267215b3a.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 22:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697866539; x=1698471339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/wGFAbPufE9eZO30bcVplOZLJm6CdeBX9tGD3Qp0uA=;
 b=G5uNBH1RsUttr30ysje2H3aEYHai6niLXECRdK7PWMEdBeRmL9AXgnieoFe2Hv+W7V
 potC6nVzE7M18VzsR4ux2hV4mKxYXncnQT8R7kSEgyO6+0B3pvG3HuVYm+PKZbJMfbBx
 gZetXtRB1TZ7LSyG4degUxW6yOAhiesJdHfc7ZOnJdz1k/V+p0pyO/tX6WMYSG4HMb3S
 BrjjebO+yLOLBZpxo2kN/4ubyPlUatAREaiTV0tN/CQnPtwWmG0mdyNnjzj9U53Pi5Rl
 tEgOAVROtuGqvq5Rv4Tf6Cic3hMOK+a4aY/mc4oXXoQtgt3wyjORrxpIB32OumwWlpkK
 FWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697866539; x=1698471339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/wGFAbPufE9eZO30bcVplOZLJm6CdeBX9tGD3Qp0uA=;
 b=sRamfEjLUmOBCcHceyfUcAcuFy0TVrJKNCDLbU7sGSpPUEGuyy9O+8djIvm3aTW8Us
 PH963fqN2129XYYjvlnZesndm5DoB+LHrcpIao9v9pOS6OJLKwYN3Ws7OOmyBCiJfIZy
 72Za4VpQgFkEK4MsmZ1tr1a1Z98HDfCO+/7p60Q0iOA9TnlpQ8LcDLZG/3kODRwAG0Ld
 XBSb1hbei8iKs1+ExV88VvEi97XTidpNv7g2voh1D6ICJ16Xc0Shok2AKiMvpr42+O4h
 2Mk1xenoRHfBU7NJ7wPPoKqem6UBDa6gJH57ctrTba6BPjahfRURMIMeUHtsjAk4qunQ
 mJwQ==
X-Gm-Message-State: AOJu0YxrIf6jLJm6Tio/xDc1Xa1qF+XE/BMgKDAno7cN/T90h9q66Bsp
 LpDSYAggazwJoNMBhAzREGLX8b6Hmr2yjHzwH/o=
X-Google-Smtp-Source: AGHT+IEll1IMY28fA7YakN4f7VqB1AalxUP9/+4E2sjrMC7WR0IAYNPvz+2WwrbxkJLhhL/N1uwNww==
X-Received: by 2002:a62:f245:0:b0:6bd:b4f1:49e8 with SMTP id
 y5-20020a62f245000000b006bdb4f149e8mr3104339pfl.2.1697866539088; 
 Fri, 20 Oct 2023 22:35:39 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h1-20020a62b401000000b00690d255b5a1sm2427978pfn.217.2023.10.20.22.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:35:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 47/90] target/sparc: Use tcg_gen_qemu_{ld,
 st}_i128 for GET_ASI_DTWINX
Date: Fri, 20 Oct 2023 22:31:15 -0700
Message-Id: <20231021053158.278135-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231021053158.278135-1-richard.henderson@linaro.org>
References: <20231021053158.278135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

Perform one atomic 16-byte operation.
The atomicity is required for the LDTXA instructions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 48 +++++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 7d834ae8a0..6f8f279508 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2579,11 +2579,27 @@ static void gen_ldda_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
         return;
 
     case GET_ASI_DTWINX:
-        assert(TARGET_LONG_BITS == 64);
-        tcg_gen_qemu_ld_tl(hi, addr, da->mem_idx, da->memop | MO_ALIGN_16);
-        tcg_gen_addi_tl(addr, addr, 8);
-        tcg_gen_qemu_ld_tl(lo, addr, da->mem_idx, da->memop);
+#ifdef TARGET_SPARC64
+        {
+            MemOp mop = (da->memop & MO_BSWAP) | MO_128 | MO_ALIGN_16;
+            TCGv_i128 t = tcg_temp_new_i128();
+
+            tcg_gen_qemu_ld_i128(t, addr, da->mem_idx, mop);
+            /*
+             * Note that LE twinx acts as if each 64-bit register result is
+             * byte swapped.  We perform one 128-bit LE load, so must swap
+             * the order of the writebacks.
+             */
+            if ((mop & MO_BSWAP) == MO_TE) {
+                tcg_gen_extr_i128_i64(lo, hi, t);
+            } else {
+                tcg_gen_extr_i128_i64(hi, lo, t);
+            }
+        }
         break;
+#else
+        g_assert_not_reached();
+#endif
 
     case GET_ASI_DIRECT:
         {
@@ -2648,11 +2664,27 @@ static void gen_stda_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
         break;
 
     case GET_ASI_DTWINX:
-        assert(TARGET_LONG_BITS == 64);
-        tcg_gen_qemu_st_tl(hi, addr, da->mem_idx, da->memop | MO_ALIGN_16);
-        tcg_gen_addi_tl(addr, addr, 8);
-        tcg_gen_qemu_st_tl(lo, addr, da->mem_idx, da->memop);
+#ifdef TARGET_SPARC64
+        {
+            MemOp mop = (da->memop & MO_BSWAP) | MO_128 | MO_ALIGN_16;
+            TCGv_i128 t = tcg_temp_new_i128();
+
+            /*
+             * Note that LE twinx acts as if each 64-bit register result is
+             * byte swapped.  We perform one 128-bit LE store, so must swap
+             * the order of the construction.
+             */
+            if ((mop & MO_BSWAP) == MO_TE) {
+                tcg_gen_concat_i64_i128(t, lo, hi);
+            } else {
+                tcg_gen_concat_i64_i128(t, hi, lo);
+            }
+            tcg_gen_qemu_st_i128(t, addr, da->mem_idx, mop);
+        }
         break;
+#else
+        g_assert_not_reached();
+#endif
 
     case GET_ASI_DIRECT:
         {
-- 
2.34.1



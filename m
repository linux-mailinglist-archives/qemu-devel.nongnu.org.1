Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBF57D2180
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 08:14:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quRaL-0001l1-O4; Sun, 22 Oct 2023 02:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRZx-0000KO-2N
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:49 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quRZr-0002EC-Bg
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 02:04:47 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b89ab5ddb7so2209171b3a.0
 for <qemu-devel@nongnu.org>; Sat, 21 Oct 2023 23:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697954681; x=1698559481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n4gVY2mbOcElI1vUEaatHV71uTw57mIjZRVd7BNlWrY=;
 b=GWnva+CKbZMhj45NzKQ8ufWEMhZ1zUepkcf3OkA6Twics1KAGtqxg/AFcmuoyuAYKO
 tz02rQWFjA0xr7spfTRqvIx2/FSVVO0qOphI6UAOYZBSaYhawvKHIi5D3gBFYD2PJlr5
 B55KSHJLLobsS4BQYuzKy4ZcFiibAQvXWXQxxbPkAFjpkCWk6HSwj5ZGOP1RtxQ4ym7i
 iwnIkeamZZvDHoNrwxd/vAawBd9YgdbpqNZVe8iyG2AvBjNPvIz/sq9/YvgeX+erva7Z
 qWiUIi4xhai9992cLST7dNWZd5OtK+VCPWXCzaoM2vpyYfCyviEZgxs1SWZ3xrwvpQfw
 GNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697954681; x=1698559481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n4gVY2mbOcElI1vUEaatHV71uTw57mIjZRVd7BNlWrY=;
 b=XuPj47bm/pOT1lxupzV+K20aWMEHpJnFw1Lc2w+p2M989OxpNI/g5kQtUb1pb4vSqV
 NqWtH0hTghz6k4KrOGaoP0K0HwVshW1RtDvYT05r1CprKa0h5plsSfyy4QcPmy9X0F3D
 rsctkelbU6jxemMhx8tFKzYcMFf0zOwLnV4TusgsFeq3eS0un49La3KiTdHq9E63+fHm
 06eiwt/wQUzvshA1wBUfBB6W1ZTYy3eH+4OVhYsTgu3ypWDOJlW3EcaxcU7ANkq5YOSE
 nlbgc+TZPsL/R5EUZu3sUvsS/tzOpQciXYKB57D9Z7L/EhclZo8sjHwFXAEzYHP71HzC
 U02w==
X-Gm-Message-State: AOJu0YxYL8zIZCjys65ck6UglKywkVOQE2LZDegZa84l6Y1QEusRftId
 lh2VcOffwIAX+1kLsdpH8vNlCR2Ng5YSret4670=
X-Google-Smtp-Source: AGHT+IGmfLStXddeLXQxhsyEstdz1jfyFjNUMJQPDJI9VKS7O19RbbtcHUOIMpwch/8OTMIeRMPnZA==
X-Received: by 2002:a05:6a00:248d:b0:6b2:5992:9e89 with SMTP id
 c13-20020a056a00248d00b006b259929e89mr7517000pfv.9.1697954681529; 
 Sat, 21 Oct 2023 23:04:41 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fb13-20020a056a002d8d00b0068a46cd4120sm4007373pfb.199.2023.10.21.23.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Oct 2023 23:04:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 47/90] target/sparc: Use tcg_gen_qemu_{ld,
 st}_i128 for GET_ASI_DTWINX
Date: Sat, 21 Oct 2023 22:59:48 -0700
Message-Id: <20231022060031.490251-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022060031.490251-1-richard.henderson@linaro.org>
References: <20231022060031.490251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
index dbadc860c3..f0284ac87b 100644
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



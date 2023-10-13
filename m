Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D93027C8F4C
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:36:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPlt-0007wu-Kp; Fri, 13 Oct 2023 17:32:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPlp-0007jK-Lz
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:33 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPll-0001La-VV
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:32:33 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3b2b1a7874dso609648b6e.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232748; x=1697837548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P7hT99jw70DDMxbLpts3548Thfd5tuVnsMrHlwXOdD8=;
 b=RKwSyc8zmE2ur4hIS8qVrw0/ZgrBBGZj7zSwXsoCY0NKOc5pvaVmQPbARE9kMoKwm+
 91mDiTLsOrKbYbVDWKSgODoxn/PTZ1dNH8U5oHOmNgwr3SYZHlUz2MtKuWqPTCOLO4vv
 HbBZdJCiUMCJQ70edegCAZj7VLF2IFFGH++MuV1VA/PL8BLOXVaFhakbrhbhlgeBz3Pz
 k3hzRwJQ2pHMgZZAIcAcznNDBjFFmfPlBluDKFDLYctMje0eOzdkYjLaw7w2nuWtYrMg
 URn1IlAFw1AD6AN6KM8NUOAv3L4v9w1ub/6tVtFVKVm2wYLTi5SYJHO088/79xsj0nfs
 VAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232748; x=1697837548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P7hT99jw70DDMxbLpts3548Thfd5tuVnsMrHlwXOdD8=;
 b=qx+CtPQwUCqQ+9K9yw6Ey6dIfG5chQZbIEdamc87R7A+Mtd/HEClyi9i2ojQ4mOouX
 zsG7Jt5YfbjbVxzh18v17u6e3g2zg7oLgK/7v3r16sDZoOTyKTCvyVTpB9GPdjnCxOTZ
 bpvLODItl6Cru9ddj1DGwA0ITa8ur3k1iDyLXcysyxrhNigOEzoavo1d15NUOUivVl+V
 rGkirqKMUrRynKcKa7DxzGPIAeVMSnpldz9NWlooprfsyDQ7GfrjRxsS8j9T93QTaCFB
 lrMpcwkgpq4TJbW9X1qFc64yJ6zGac9kgoRfY6eJxXECsUnAHRBWscEIFLpjrp7b1Oa3
 iQiQ==
X-Gm-Message-State: AOJu0YzKF4XZ9OJmeBk7aOlwQi4mOePtTjuPL3rf8qPYzxCmTiDGI0/7
 Zpz3AtvdwCLK3s5sVaQiSdyF248dqv4CoJCzgLE=
X-Google-Smtp-Source: AGHT+IHbIphvQbaLRA+PLVQc+c8aLZl2ATytfMBu9VIXxrUFrdNTl7M0YeY9MvKqDXzWV26ntdl4/g==
X-Received: by 2002:a05:6808:2382:b0:3a4:ccf:6a63 with SMTP id
 bp2-20020a056808238200b003a40ccf6a63mr33332768oib.55.1697232747774; 
 Fri, 13 Oct 2023 14:32:27 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 j5-20020aa78d05000000b0068842ebfd10sm13977191pfe.160.2023.10.13.14.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:32:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 42/85] target/sparc: Use tcg_gen_qemu_{ld,
 st}_i128 for GET_ASI_DTWINX
Date: Fri, 13 Oct 2023 14:28:03 -0700
Message-Id: <20231013212846.165724-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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
index 696e60bd30..1b993d3c4f 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2488,11 +2488,27 @@ static void gen_ldda_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
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
@@ -2557,11 +2573,27 @@ static void gen_stda_asi0(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
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



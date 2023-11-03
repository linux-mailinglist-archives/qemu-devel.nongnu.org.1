Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD00E7E07A9
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 18:41:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyy8q-0005MK-9z; Fri, 03 Nov 2023 13:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy87-0005Ca-Nn
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:51 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qyy85-0003PV-LT
 for qemu-devel@nongnu.org; Fri, 03 Nov 2023 13:38:47 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1cc34c3420bso24362375ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Nov 2023 10:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699033124; x=1699637924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UnxzRLyh1Ovb0jBBq5BLp/EkhnbEZyAfrEjqimnt3ZM=;
 b=x/RnFx/IZ0gP6HY01H2UiE2ty/rHcv0DOt02Agam+WY8OkXdK8ZzRjQZLcGzwVjZam
 7V1bzFwPWxvjPPBhig/NN6lgG3uWV7brjlofNTS+ugvfjFmzJHG6mNlhIkh1ZWWQJalT
 vbadnbFiel7mcpmLX6Qw7kLBfVHyx+MT3q63bZYbk1vmmAwiVlSCZ3ePVDFxpVhrHEYN
 m70hVnToLrUmgygsfh5uYtd+D/2waNc6j/imqbgedWb+DWTNlziu36Ax0677HyGXyEnU
 xW0LiZ+MpaMF8+gekhIH128cCLg7hup9hxt1S72XUYGyP9w6jNkkbre7kOQu9JyKOWci
 mOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699033124; x=1699637924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UnxzRLyh1Ovb0jBBq5BLp/EkhnbEZyAfrEjqimnt3ZM=;
 b=Jh3Megmy5qdJ5u6hA0mWMDLBUsD2asSm0Kp0WgcbUv2SywAQkLuimZvfAjjejs9ojQ
 pa5GZ7HTJcXHK1g17WPnWGOjbGpR2PfIpn8xZ4iCWLeJ4H0FsyoP9BMUg6WOd3LHE8oq
 /EQFr5dY1euEDTN7gLadSqt4pMt/MYXSo3BgGk/rWPs79xocpmMI8VFrbE8YnIGal8J0
 lI119EjfRFq0c2yrNEcSfj0FQlGGxGGKz+6hZwvbfmhcqgCweVw6R4jf/Ys/falPTUmM
 Aa6hCjVf3kybuV00dnJuSXwHDbW6Ev0Q4kbXoVn+/yWyLGmVDXnOezvkzyvdTNfA/47B
 0vDg==
X-Gm-Message-State: AOJu0YzlSLbvlur2PAEixInqhwV34OVnqlEwl9TFDO47hPnovBc1ZfqT
 83bxshT6qPCyR/PZ1RuTIGwWj8Tkj2OTo2GdRm0=
X-Google-Smtp-Source: AGHT+IE0fbr/IquvHWA6L8JLVIyzFAD33QMtAZ0baPC7fHOHEBugHgy4g5kw7gXU5AR/3yY+atq/UQ==
X-Received: by 2002:a17:903:246:b0:1cc:b09a:b811 with SMTP id
 j6-20020a170903024600b001ccb09ab811mr1113486plh.14.1699033124065; 
 Fri, 03 Nov 2023 10:38:44 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 c10-20020a170902c1ca00b001c0cb2aa2easm1628267plc.121.2023.11.03.10.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Nov 2023 10:38:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 02/22] target/sparc: Use tcg_gen_qemu_{ld,
 st}_i128 for ASI_M_BFILL
Date: Fri,  3 Nov 2023 10:38:21 -0700
Message-Id: <20231103173841.33651-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103173841.33651-1-richard.henderson@linaro.org>
References: <20231103173841.33651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Align the operation to the 32-byte cacheline.
Use 2 i128 instead of 4 i64.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5d55856a54..713ac5bbae 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2172,23 +2172,22 @@ static void gen_stda_asi(DisasContext *dc, DisasASI *da, TCGv addr, int rd)
 
     case GET_ASI_BFILL:
         assert(TARGET_LONG_BITS == 32);
-        /* Store 32 bytes of T64 to ADDR.  */
-        /* ??? The original qemu code suggests 8-byte alignment, dropping
-           the low bits, but the only place I can see this used is in the
-           Linux kernel with 32 byte alignment, which would make more sense
-           as a cacheline-style operation.  */
+        /*
+         * Store 32 bytes of [rd:rd+1] to ADDR.
+         * See comments for GET_ASI_COPY above.
+         */
         {
-            TCGv_i64 t64 = tcg_temp_new_i64();
-            TCGv d_addr = tcg_temp_new();
-            TCGv eight = tcg_constant_tl(8);
-            int i;
+            MemOp mop = MO_TE | MO_128 | MO_ATOM_IFALIGN_PAIR;
+            TCGv_i64 t8 = tcg_temp_new_i64();
+            TCGv_i128 t16 = tcg_temp_new_i128();
+            TCGv daddr = tcg_temp_new();
 
-            tcg_gen_concat_tl_i64(t64, lo, hi);
-            tcg_gen_andi_tl(d_addr, addr, -8);
-            for (i = 0; i < 32; i += 8) {
-                tcg_gen_qemu_st_i64(t64, d_addr, da->mem_idx, da->memop);
-                tcg_gen_add_tl(d_addr, d_addr, eight);
-            }
+            tcg_gen_concat_tl_i64(t8, lo, hi);
+            tcg_gen_concat_i64_i128(t16, t8, t8);
+            tcg_gen_andi_tl(daddr, addr, -32);
+            tcg_gen_qemu_st_i128(t16, daddr, da->mem_idx, mop);
+            tcg_gen_addi_tl(daddr, daddr, 16);
+            tcg_gen_qemu_st_i128(t16, daddr, da->mem_idx, mop);
         }
         break;
 
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB3D9ED254
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Dec 2024 17:42:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPgq-0005yn-So; Wed, 11 Dec 2024 11:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPgi-0005i6-2E
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:35:48 -0500
Received: from mail-qv1-xf2e.google.com ([2607:f8b0:4864:20::f2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPgg-00022P-9s
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:35:47 -0500
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6d89dc50927so47773946d6.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934945; x=1734539745; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9vxeDIctRiBwukT9gf1lhbMnRkKmeObVDVZhD+CWIRg=;
 b=pSks+0MSNeC7hJJtc/zMOijF43MuD1zRvF82IMywSux4SLjExq18GMPNDvl4ewULXS
 fJij0QEGF7oQdOinP9o639dvTQGKLe8mY7T8n/PW72B5LSiXYbcZQM4eREV31+zl1QYS
 jB3flPywm/nTMyE2Wo0bBR9fAGLK47CzzHqdVWnwovKOlPoBjOV7MaceYxZNRAGfbmIT
 y5ka5NQ7KLlOWIfK8dFJCiiGFOTgtuI1J3XiJX8MA2wvjcjxAgtu0oo5KWWSRSR0FrH/
 pi+XDTDoQ+RwWF06v1c0xqcsgytlrA/B8nZRLkmepi8Z4jd9ed7/4+R5RfSvCebdiwo/
 E98Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934945; x=1734539745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9vxeDIctRiBwukT9gf1lhbMnRkKmeObVDVZhD+CWIRg=;
 b=UmVe1yMk5ja6QcKGcqEEj9L72rZwMPIEnb4k/cE+NJEk98N/W2uTsmQ0UF4y7KphMq
 HVpuoJWVHWoMQN8hQtHetU9Bjrk0yZQdMHQIlOvgqq/65ZBDCBzZ6LNv1XYLuusb2brS
 E4tNA460uo8QnMM/fi0sIcRqY3I8c6A5tU9QDCBkSlHmUuxnxQER9U9S6IzFuH2qPahQ
 sPCk0L/FwgMOIoR+21fNwvYjPJtMTRbE+VL231XyduABJf3dmqCQZfhbVdQ8FkiZxg6W
 X8cIX/1+mol//tu5Uh86t5Tiu4r3W8lrrp1iz93upwZKbBift/RjBJJby+RdT0SQkWNw
 Ch7Q==
X-Gm-Message-State: AOJu0YyBPlJqUFKM5njzubioVPECsqiRtiMgE5VX5MxbjDV2IPKESx4/
 Ahxm48AMUZ+8KNKw7a7F3z+fiOiyB03kUOcPoLcB7CexS90WIx3EKi6aQk/covjFstbyClD6peI
 +y+MPYsje
X-Gm-Gg: ASbGncvuqTid76/KvJoEq2wFcGXx21c0MiDYzn7mJeFhkVIcNK41o/OIpBSqPtey7WR
 83zd8g8WWlYErWlvxJjT9IgqyPTB8YlDSZ8JB5Wr4pSWnq975qne0lgkjOtxdzRfcrMX+jgE29U
 UnA5iKRt7GZLw5Uag9HQ/JTJenW/miQr8pWLnpY8lfe7s3Lce7vDE0XJjwumkqKENzivPqiJYQ6
 bT8tu7UK5NR40pSGFqkaLU+YMF2i/NSocPPQRIwXOmoOVmB3fIEm0LOqSFkBg==
X-Google-Smtp-Source: AGHT+IFq6VmFVu0yb8fuls5VypjLMx0RsnpPC91l4cPZOd7zpm121mss7LTuf5PTGN6JTvCVg66irQ==
X-Received: by 2002:a05:6214:5004:b0:6d8:e641:da29 with SMTP id
 6a1803df08f44-6d9348c98demr60573866d6.6.1733934945379; 
 Wed, 11 Dec 2024 08:35:45 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:35:45 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 43/69] target/arm: Convert handle_rev to decodetree
Date: Wed, 11 Dec 2024 10:30:10 -0600
Message-ID: <20241211163036.2297116-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2e.google.com
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

This includes REV16, REV32, REV64.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 79 +++-------------------------------
 target/arm/tcg/a64.decode      |  5 +++
 2 files changed, 10 insertions(+), 74 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 547c6dc5cc..f57b5e2855 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8939,6 +8939,8 @@ TRANS(CMGE0_v, do_gvec_fn2, a, gen_gvec_cge0)
 TRANS(CMLT0_v, do_gvec_fn2, a, gen_gvec_clt0)
 TRANS(CMLE0_v, do_gvec_fn2, a, gen_gvec_cle0)
 TRANS(CMEQ0_v, do_gvec_fn2, a, gen_gvec_ceq0)
+TRANS(REV16_v, do_gvec_fn2, a, gen_gvec_rev16)
+TRANS(REV32_v, do_gvec_fn2, a, gen_gvec_rev32)
 
 static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 {
@@ -8953,6 +8955,7 @@ static bool do_gvec_fn2_bhs(DisasContext *s, arg_qrr_e *a, GVecGen2Fn *fn)
 
 TRANS(CLS_v, do_gvec_fn2_bhs, a, gen_gvec_cls)
 TRANS(CLZ_v, do_gvec_fn2_bhs, a, gen_gvec_clz)
+TRANS(REV64_v, do_gvec_fn2_bhs, a, gen_gvec_rev64)
 
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
@@ -9882,76 +9885,6 @@ static void handle_2misc_widening(DisasContext *s, int opcode, bool is_q,
     }
 }
 
-static void handle_rev(DisasContext *s, int opcode, bool u,
-                       bool is_q, int size, int rn, int rd)
-{
-    int op = (opcode << 1) | u;
-    int opsz = op + size;
-    int grp_size = 3 - opsz;
-    int dsize = is_q ? 128 : 64;
-    int i;
-
-    if (opsz >= 3) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    if (size == 0) {
-        /* Special case bytes, use bswap op on each group of elements */
-        int groups = dsize / (8 << grp_size);
-
-        for (i = 0; i < groups; i++) {
-            TCGv_i64 tcg_tmp = tcg_temp_new_i64();
-
-            read_vec_element(s, tcg_tmp, rn, i, grp_size);
-            switch (grp_size) {
-            case MO_16:
-                tcg_gen_bswap16_i64(tcg_tmp, tcg_tmp, TCG_BSWAP_IZ);
-                break;
-            case MO_32:
-                tcg_gen_bswap32_i64(tcg_tmp, tcg_tmp, TCG_BSWAP_IZ);
-                break;
-            case MO_64:
-                tcg_gen_bswap64_i64(tcg_tmp, tcg_tmp);
-                break;
-            default:
-                g_assert_not_reached();
-            }
-            write_vec_element(s, tcg_tmp, rd, i, grp_size);
-        }
-        clear_vec_high(s, is_q, rd);
-    } else {
-        int revmask = (1 << grp_size) - 1;
-        int esize = 8 << size;
-        int elements = dsize / esize;
-        TCGv_i64 tcg_rn = tcg_temp_new_i64();
-        TCGv_i64 tcg_rd[2];
-
-        for (i = 0; i < 2; i++) {
-            tcg_rd[i] = tcg_temp_new_i64();
-            tcg_gen_movi_i64(tcg_rd[i], 0);
-        }
-
-        for (i = 0; i < elements; i++) {
-            int e_rev = (i & 0xf) ^ revmask;
-            int w = (e_rev * esize) / 64;
-            int o = (e_rev * esize) % 64;
-
-            read_vec_element(s, tcg_rn, rn, i, size);
-            tcg_gen_deposit_i64(tcg_rd[w], tcg_rd[w], tcg_rn, o, esize);
-        }
-
-        for (i = 0; i < 2; i++) {
-            write_vec_element(s, tcg_rd[i], rd, i, MO_64);
-        }
-        clear_vec_high(s, true, rd);
-    }
-}
-
 static void handle_2misc_pairwise(DisasContext *s, int opcode, bool u,
                                   bool is_q, int size, int rn, int rd)
 {
@@ -10066,10 +9999,6 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     TCGv_ptr tcg_fpstatus;
 
     switch (opcode) {
-    case 0x0: /* REV64, REV32 */
-    case 0x1: /* REV16 */
-        handle_rev(s, opcode, u, is_q, size, rn, rd);
-        return;
     case 0x12: /* XTN, XTN2, SQXTUN, SQXTUN2 */
     case 0x14: /* SQXTN, SQXTN2, UQXTN, UQXTN2 */
         if (size == 3) {
@@ -10272,6 +10201,8 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         break;
     }
     default:
+    case 0x0: /* REV64, REV32 */
+    case 0x1: /* REV16 */
     case 0x3: /* SUQADD, USQADD */
     case 0x4: /* CLS, CLZ */
     case 0x5: /* CNT, NOT, RBIT */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 247d3a7bda..05f1bc99b5 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -73,6 +73,7 @@
 
 @qrr_b          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=0
 @qrr_h          . q:1 ...... .. ...... ...... rn:5 rd:5  &qrr_e esz=1
+@qrr_bh         . q:1 ...... . esz:1 ...... ...... rn:5 rd:5  &qrr_e
 @qrr_e          . q:1 ...... esz:2 ...... ...... rn:5 rd:5  &qrr_e
 
 @qrrr_b         . q:1 ...... ... rm:5 ...... rn:5 rd:5  &qrrr_e esz=0
@@ -1657,3 +1658,7 @@ CMGE0_v         0.10 1110 ..1 00000 10001 0 ..... .....     @qrr_e
 CMEQ0_v         0.00 1110 ..1 00000 10011 0 ..... .....     @qrr_e
 CMLE0_v         0.10 1110 ..1 00000 10011 0 ..... .....     @qrr_e
 CMLT0_v         0.00 1110 ..1 00000 10101 0 ..... .....     @qrr_e
+
+REV16_v         0.00 1110 001 00000 00011 0 ..... .....     @qrr_b
+REV32_v         0.10 1110 0.1 00000 00001 0 ..... .....     @qrr_bh
+REV64_v         0.00 1110 ..1 00000 00001 0 ..... .....     @qrr_e
-- 
2.43.0



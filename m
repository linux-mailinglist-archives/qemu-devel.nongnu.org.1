Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D5C9ED2A2
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Dec 2024 17:49:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPi8-0002V8-5u; Wed, 11 Dec 2024 11:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhY-0000ju-EF
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:40 -0500
Received: from mail-qv1-xf2b.google.com ([2607:f8b0:4864:20::f2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPhW-0002FZ-4I
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:36:40 -0500
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6d933736380so14627516d6.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934997; x=1734539797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dn+oPG8iCaoQw0cP17ZB2UufuSUcPmfb3W6rznKLWtE=;
 b=JoB5Qm1HT75LLrUC5GstTfOmFN6hBXcTsncg3QqZS8vPH8lVaONkqojoDsJIV1x5eL
 StxBaNLTKn8HvNGGyfGTT40wHGRM1BN25XIz7ZBR3XjtD2HF5MMRCYrMrgj/24zXqnm/
 QlDHemFvbVGAyxxuFr22aDNthcsseOrfvgX6OlCjmLzv/sprDT6WVeIWe1y7BD6+997s
 Ihsve5nXcUX3sbFjLQxHmE6wwbUw17wDNtERkGORuqMYQUr/RsaP4W9U/xOBqZoRzF9g
 5s7whzHrgnYG7wMCb0QJIhhx2yz0duADfU0yEGvnnNoPOynOqag21SEAe1W16y+U2sJJ
 MrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934997; x=1734539797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dn+oPG8iCaoQw0cP17ZB2UufuSUcPmfb3W6rznKLWtE=;
 b=U4MQzSiHzjV2+nMZDJ3DRFX+Q8nhey+LngsEStOTEuejL+okBR8IY/mhXYMX0VRfFE
 x9iVF/2OK0Ap8zNcIvYRFhJE8HT2eRdWZsn5aqzsMZE75QgK/q82gdCB6JAXQKfNVpL/
 BgUMSuRUvGOTUAB5IRDY8H5ZvnbcrQN7fx6Zm3m5Z8XjabEZTiNwdu6l0Sqr4GgZ5/5P
 fxHM+x2INb1TaXMpw6sC6eMFmtrIYECKwgrrChMQKolUHbX6MczX5bPiYjCGcNbheTm4
 NFzeqXqhwzx0R+Rsuzhw4kxcfe5zuCHUrCxiql052VsrV2xMqPJ2SXoTt57u9QQf1yCQ
 bRKA==
X-Gm-Message-State: AOJu0YyiKQxQBK0UQ5VOafwspz10tGSHraW4FiQk2cfXCAP6paC8AxsC
 1ABJ3QUlVV0XpRv+j2qicPelK8By8q+Ij2IjRfbCKD+ixg5ZLyoP5YmTi22dO8eMhdz+VY8cIzp
 wu15AL6b4
X-Gm-Gg: ASbGncvf8BRd8Cg+YNPdvb71t+UOOlREBL8Vj6An8AwgItGEP2jHNnkGFiqkgfvH5GE
 3USkcE3OIubX/Qyayw4F8nJTR3kB6asl81T8M/6mO3db6xI8A9/LFTeU/sQHXdfkUsyMrA6JL/2
 BxSiT055NODmwZ0jZ40f9Fj3toQx+kEW59kyWYxPk6E/B0Ae9l9wejw2EIDVUhzCEbTEqEMXBUp
 kbtAcRgZ9L6/E4RHTZblNkBSUQrN+ATcJJQhtcKk+UuRWy6QXHDnvSOC1k4PQ==
X-Google-Smtp-Source: AGHT+IEhodqSJRO9Q2+IS2j7QuwyVGvs7kqcA3AeSWC/7bG7JnNICjbDam+mDqyxiYs0dZ465P4Vdg==
X-Received: by 2002:a05:6214:240a:b0:6d8:8d87:e5b4 with SMTP id
 6a1803df08f44-6d934aec2f9mr67655706d6.19.1733934996819; 
 Wed, 11 Dec 2024 08:36:36 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da675214sm71856276d6.11.2024.12.11.08.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:36:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 56/69] target/arm: Convert FRINT* (vector) to decodetree
Date: Wed, 11 Dec 2024 10:30:23 -0600
Message-ID: <20241211163036.2297116-57-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2b.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 176 ++++++++++++---------------------
 target/arm/tcg/a64.decode      |  26 +++++
 2 files changed, 88 insertions(+), 114 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 287e9338a4..0f924b07dc 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9209,6 +9209,21 @@ static bool do_fp1_vector(DisasContext *s, arg_qrr_e *a,
 
 TRANS(FSQRT_v, do_fp1_vector, a, &f_scalar_fsqrt, -1)
 
+TRANS(FRINTN_v, do_fp1_vector, a, &f_scalar_frint, FPROUNDING_TIEEVEN)
+TRANS(FRINTP_v, do_fp1_vector, a, &f_scalar_frint, FPROUNDING_POSINF)
+TRANS(FRINTM_v, do_fp1_vector, a, &f_scalar_frint, FPROUNDING_NEGINF)
+TRANS(FRINTZ_v, do_fp1_vector, a, &f_scalar_frint, FPROUNDING_ZERO)
+TRANS(FRINTA_v, do_fp1_vector, a, &f_scalar_frint, FPROUNDING_TIEAWAY)
+TRANS(FRINTI_v, do_fp1_vector, a, &f_scalar_frint, -1)
+TRANS(FRINTX_v, do_fp1_vector, a, &f_scalar_frintx, -1)
+
+TRANS_FEAT(FRINT32Z_v, aa64_frint, do_fp1_vector, a,
+           &f_scalar_frint32, FPROUNDING_ZERO)
+TRANS_FEAT(FRINT32X_v, aa64_frint, do_fp1_vector, a, &f_scalar_frint32, -1)
+TRANS_FEAT(FRINT64Z_v, aa64_frint, do_fp1_vector, a,
+           &f_scalar_frint64, FPROUNDING_ZERO)
+TRANS_FEAT(FRINT64X_v, aa64_frint, do_fp1_vector, a, &f_scalar_frint64, -1)
+
 /* Common vector code for handling integer to FP conversion */
 static void handle_simd_intfp_conv(DisasContext *s, int rd, int rn,
                                    int elements, int is_signed,
@@ -9520,25 +9535,6 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     case 0x7b: /* FCVTZU */
         gen_helper_vfp_touqd(tcg_rd, tcg_rn, tcg_constant_i32(0), tcg_fpstatus);
         break;
-    case 0x18: /* FRINTN */
-    case 0x19: /* FRINTM */
-    case 0x38: /* FRINTP */
-    case 0x39: /* FRINTZ */
-    case 0x58: /* FRINTA */
-    case 0x79: /* FRINTI */
-        gen_helper_rintd(tcg_rd, tcg_rn, tcg_fpstatus);
-        break;
-    case 0x59: /* FRINTX */
-        gen_helper_rintd_exact(tcg_rd, tcg_rn, tcg_fpstatus);
-        break;
-    case 0x1e: /* FRINT32Z */
-    case 0x5e: /* FRINT32X */
-        gen_helper_frint32_d(tcg_rd, tcg_rn, tcg_fpstatus);
-        break;
-    case 0x1f: /* FRINT64Z */
-    case 0x5f: /* FRINT64X */
-        gen_helper_frint64_d(tcg_rd, tcg_rn, tcg_fpstatus);
-        break;
     default:
     case 0x4: /* CLS, CLZ */
     case 0x5: /* NOT */
@@ -9550,6 +9546,17 @@ static void handle_2misc_64(DisasContext *s, int opcode, bool u,
     case 0x2f: /* FABS */
     case 0x6f: /* FNEG */
     case 0x7f: /* FSQRT */
+    case 0x18: /* FRINTN */
+    case 0x19: /* FRINTM */
+    case 0x38: /* FRINTP */
+    case 0x39: /* FRINTZ */
+    case 0x58: /* FRINTA */
+    case 0x79: /* FRINTI */
+    case 0x59: /* FRINTX */
+    case 0x1e: /* FRINT32Z */
+    case 0x5e: /* FRINT32X */
+    case 0x1f: /* FRINT64Z */
+    case 0x5f: /* FRINT64X */
         g_assert_not_reached();
     }
 }
@@ -10094,46 +10101,12 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
             }
             handle_2misc_widening(s, opcode, is_q, size, rn, rd);
             return;
-        case 0x18: /* FRINTN */
-        case 0x19: /* FRINTM */
-        case 0x38: /* FRINTP */
-        case 0x39: /* FRINTZ */
-            rmode = extract32(opcode, 5, 1) | (extract32(opcode, 0, 1) << 1);
-            /* fall through */
-        case 0x59: /* FRINTX */
-        case 0x79: /* FRINTI */
-            need_fpstatus = true;
-            if (size == 3 && !is_q) {
-                unallocated_encoding(s);
-                return;
-            }
-            break;
-        case 0x58: /* FRINTA */
-            rmode = FPROUNDING_TIEAWAY;
-            need_fpstatus = true;
-            if (size == 3 && !is_q) {
-                unallocated_encoding(s);
-                return;
-            }
-            break;
         case 0x7c: /* URSQRTE */
             if (size == 3) {
                 unallocated_encoding(s);
                 return;
             }
             break;
-        case 0x1e: /* FRINT32Z */
-        case 0x1f: /* FRINT64Z */
-            rmode = FPROUNDING_ZERO;
-            /* fall through */
-        case 0x5e: /* FRINT32X */
-        case 0x5f: /* FRINT64X */
-            need_fpstatus = true;
-            if ((size == 3 && !is_q) || !dc_isar_feature(aa64_frint, s)) {
-                unallocated_encoding(s);
-                return;
-            }
-            break;
         default:
         case 0x16: /* FCVTN, FCVTN2 */
         case 0x36: /* BFCVTN, BFCVTN2 */
@@ -10141,6 +10114,17 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
         case 0x2f: /* FABS */
         case 0x6f: /* FNEG */
         case 0x7f: /* FSQRT */
+        case 0x18: /* FRINTN */
+        case 0x19: /* FRINTM */
+        case 0x38: /* FRINTP */
+        case 0x39: /* FRINTZ */
+        case 0x59: /* FRINTX */
+        case 0x79: /* FRINTI */
+        case 0x58: /* FRINTA */
+        case 0x1e: /* FRINT32Z */
+        case 0x1f: /* FRINT64Z */
+        case 0x5e: /* FRINT32X */
+        case 0x5f: /* FRINT64X */
             unallocated_encoding(s);
             return;
         }
@@ -10229,33 +10213,25 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
                     gen_helper_vfp_touls(tcg_res, tcg_op,
                                          tcg_constant_i32(0), tcg_fpstatus);
                     break;
-                case 0x18: /* FRINTN */
-                case 0x19: /* FRINTM */
-                case 0x38: /* FRINTP */
-                case 0x39: /* FRINTZ */
-                case 0x58: /* FRINTA */
-                case 0x79: /* FRINTI */
-                    gen_helper_rints(tcg_res, tcg_op, tcg_fpstatus);
-                    break;
-                case 0x59: /* FRINTX */
-                    gen_helper_rints_exact(tcg_res, tcg_op, tcg_fpstatus);
-                    break;
                 case 0x7c: /* URSQRTE */
                     gen_helper_rsqrte_u32(tcg_res, tcg_op);
                     break;
-                case 0x1e: /* FRINT32Z */
-                case 0x5e: /* FRINT32X */
-                    gen_helper_frint32_s(tcg_res, tcg_op, tcg_fpstatus);
-                    break;
-                case 0x1f: /* FRINT64Z */
-                case 0x5f: /* FRINT64X */
-                    gen_helper_frint64_s(tcg_res, tcg_op, tcg_fpstatus);
-                    break;
                 default:
                 case 0x7: /* SQABS, SQNEG */
                 case 0x2f: /* FABS */
                 case 0x6f: /* FNEG */
                 case 0x7f: /* FSQRT */
+                case 0x18: /* FRINTN */
+                case 0x19: /* FRINTM */
+                case 0x38: /* FRINTP */
+                case 0x39: /* FRINTZ */
+                case 0x58: /* FRINTA */
+                case 0x79: /* FRINTI */
+                case 0x59: /* FRINTX */
+                case 0x1e: /* FRINT32Z */
+                case 0x5e: /* FRINT32X */
+                case 0x1f: /* FRINT64Z */
+                case 0x5f: /* FRINT64X */
                     g_assert_not_reached();
                 }
             }
@@ -10289,7 +10265,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     int rn, rd;
     bool is_q;
     bool is_scalar;
-    bool only_in_vector = false;
 
     int pass;
     TCGv_i32 tcg_rmode = NULL;
@@ -10343,31 +10318,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     case 0x3d: /* FRECPE */
     case 0x3f: /* FRECPX */
         break;
-    case 0x18: /* FRINTN */
-        only_in_vector = true;
-        rmode = FPROUNDING_TIEEVEN;
-        break;
-    case 0x19: /* FRINTM */
-        only_in_vector = true;
-        rmode = FPROUNDING_NEGINF;
-        break;
-    case 0x38: /* FRINTP */
-        only_in_vector = true;
-        rmode = FPROUNDING_POSINF;
-        break;
-    case 0x39: /* FRINTZ */
-        only_in_vector = true;
-        rmode = FPROUNDING_ZERO;
-        break;
-    case 0x58: /* FRINTA */
-        only_in_vector = true;
-        rmode = FPROUNDING_TIEAWAY;
-        break;
-    case 0x59: /* FRINTX */
-    case 0x79: /* FRINTI */
-        only_in_vector = true;
-        /* current rounding mode */
-        break;
     case 0x1a: /* FCVTNS */
         rmode = FPROUNDING_TIEEVEN;
         break;
@@ -10404,6 +10354,13 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
     case 0x2f: /* FABS */
     case 0x6f: /* FNEG */
     case 0x7f: /* FSQRT (vector) */
+    case 0x18: /* FRINTN */
+    case 0x19: /* FRINTM */
+    case 0x38: /* FRINTP */
+    case 0x39: /* FRINTZ */
+    case 0x58: /* FRINTA */
+    case 0x59: /* FRINTX */
+    case 0x79: /* FRINTI */
         unallocated_encoding(s);
         return;
     }
@@ -10415,11 +10372,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
-        /* FRINTxx is only in the vector form */
-        if (only_in_vector) {
-            unallocated_encoding(s);
-            return;
-        }
     }
 
     if (!fp_access_check(s)) {
@@ -10494,17 +10446,6 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             case 0x7b: /* FCVTZU */
                 gen_helper_advsimd_f16touinth(tcg_res, tcg_op, tcg_fpstatus);
                 break;
-            case 0x18: /* FRINTN */
-            case 0x19: /* FRINTM */
-            case 0x38: /* FRINTP */
-            case 0x39: /* FRINTZ */
-            case 0x58: /* FRINTA */
-            case 0x79: /* FRINTI */
-                gen_helper_advsimd_rinth(tcg_res, tcg_op, tcg_fpstatus);
-                break;
-            case 0x59: /* FRINTX */
-                gen_helper_advsimd_rinth_exact(tcg_res, tcg_op, tcg_fpstatus);
-                break;
             case 0x7d: /* FRSQRTE */
                 gen_helper_rsqrte_f16(tcg_res, tcg_op, tcg_fpstatus);
                 break;
@@ -10512,6 +10453,13 @@ static void disas_simd_two_reg_misc_fp16(DisasContext *s, uint32_t insn)
             case 0x2f: /* FABS */
             case 0x6f: /* FNEG */
             case 0x7f: /* FSQRT */
+            case 0x18: /* FRINTN */
+            case 0x19: /* FRINTM */
+            case 0x38: /* FRINTP */
+            case 0x39: /* FRINTZ */
+            case 0x58: /* FRINTA */
+            case 0x79: /* FRINTI */
+            case 0x59: /* FRINTX */
                 g_assert_not_reached();
             }
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 1e0eb4a748..5e02144f65 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1697,3 +1697,29 @@ FNEG_v          0.10 1110 1.1 00000 11111 0 ..... .....     @qrr_sd
 
 FSQRT_v         0.10 1110 111 11001 11111 0 ..... .....     @qrr_h
 FSQRT_v         0.10 1110 1.1 00001 11111 0 ..... .....     @qrr_sd
+
+FRINTN_v        0.00 1110 011 11001 10001 0 ..... .....     @qrr_h
+FRINTN_v        0.00 1110 0.1 00001 10001 0 ..... .....     @qrr_sd
+
+FRINTM_v        0.00 1110 011 11001 10011 0 ..... .....     @qrr_h
+FRINTM_v        0.00 1110 0.1 00001 10011 0 ..... .....     @qrr_sd
+
+FRINTP_v        0.00 1110 111 11001 10001 0 ..... .....     @qrr_h
+FRINTP_v        0.00 1110 1.1 00001 10001 0 ..... .....     @qrr_sd
+
+FRINTZ_v        0.00 1110 111 11001 10011 0 ..... .....     @qrr_h
+FRINTZ_v        0.00 1110 1.1 00001 10011 0 ..... .....     @qrr_sd
+
+FRINTA_v        0.10 1110 011 11001 10001 0 ..... .....     @qrr_h
+FRINTA_v        0.10 1110 0.1 00001 10001 0 ..... .....     @qrr_sd
+
+FRINTX_v        0.10 1110 011 11001 10011 0 ..... .....     @qrr_h
+FRINTX_v        0.10 1110 0.1 00001 10011 0 ..... .....     @qrr_sd
+
+FRINTI_v        0.10 1110 111 11001 10011 0 ..... .....     @qrr_h
+FRINTI_v        0.10 1110 1.1 00001 10011 0 ..... .....     @qrr_sd
+
+FRINT32Z_v      0.00 1110 0.1 00001 11101 0 ..... .....     @qrr_sd
+FRINT32X_v      0.10 1110 0.1 00001 11101 0 ..... .....     @qrr_sd
+FRINT64Z_v      0.00 1110 0.1 00001 11111 0 ..... .....     @qrr_sd
+FRINT64X_v      0.10 1110 0.1 00001 11111 0 ..... .....     @qrr_sd
-- 
2.43.0



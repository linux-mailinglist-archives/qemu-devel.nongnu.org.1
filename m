Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5826CAF959D
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Jul 2025 16:34:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhR8-0005pz-N1; Fri, 04 Jul 2025 10:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM0-0004Mf-SP
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:32 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLu-00081g-9Q
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:28 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60f0a92391bso558927eaf.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639120; x=1752243920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tf60mUQtgR/yZMmICL9C93f1NUzvXbd+D0K+j9YzN7Y=;
 b=FQDd99NnLkjam5+8HKs211vB45ieYJHWGkHWhis9we8alZYFPb4J7izWCuZVQHFvTz
 IcE1F7sICaEOyp6aKLqo6F8+3Z4xheY3/1MVniqiaekhcwleK/k5OCtNZtSoaHA+Vjnr
 Sq4+VixwZ3DoMq1QxY/YMSxE57VnOFCpa6T/3Afy5ICJTadBYSrBLef6W2donCdOjaJd
 b6/+NWsog3mfUIFW1vpHlqXY98wn9te8kR3mVGDi4pGD5Y22cxdFnpdn+fc5bC0lfhxc
 XeFyURr/u1dF2FFjU5DAL113A86oKMdv6S1VILSGW+3zoILjnzHmbo3+Zdcpl1B6oky1
 YJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639120; x=1752243920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tf60mUQtgR/yZMmICL9C93f1NUzvXbd+D0K+j9YzN7Y=;
 b=go6q3a650Ofh54cdFwAC7eaTQOBCyLrc0q/oieUOElTAk2Zi4adtB/X4bxGXbNr7+l
 W9iSxN1kJM2vfk1/Qz/PnoZuuwx6/hzNHY+dvBJLnxJDbsyTouoosRLJVO2dLt1oEqC8
 mfEuDT2hNcmvKERLmCSXjU+1EpTdbCOgiTocHCJ1eyIehD3sfg4kfru6ewOidJmIDBxi
 N/+M44i+dwB4tXfTQRpcI6bB7uq8ZwS9XWad//6Ne/vRurLtUjHN1Gd4ieHdP3iLBZB1
 XujS7DQCgXo4Oo9kfAoX0G1/b4YofDjmnfVTzvIDw2EyRkKzO7UKi8O34pvgfb60LOgA
 dJ2A==
X-Gm-Message-State: AOJu0Yyor/iyFKfQi0AtuBVqVMmKR0VQ1eq6ucF4z3XnnwqSwlEXv+h0
 CPCjvQBqhQT6jIZ2f77hdyquLTU+DcEwkiLM884LhW7hUhM6ryhjPzMkg0N9SCGJv0xUXThTRU1
 InX8kct0=
X-Gm-Gg: ASbGncv7XD+bLNcS2+OEohPt5BSvu7ReTtej9HkdaXDvrX+c5KS+lLq/zJJ8URypd1f
 ZtIvPdOYTOpruz9TCS734rJG7E42P0R1Km+GDZsHBDZ7M0FGIFEoemWaSPARo8VVjU2ezVAyZvF
 QTgDSfzeYoVJYaa5588SwXxJnboyGPNU1qqlwPfayximct/1hkdtWrQoPVd7zXt+BKe4wcMe/C6
 shXOrKSdxGUuT/ehDt/KbR0Xocfmhl8qQRKPi9U6ta6PHvkNorUl0l/Oz5w5OAQ54Q7eJisnEjp
 VdBnLspPJZJgGZHqK51tD/yuF9bhU+Xr262sQwz9+H3kWGxPQOlUAO4vA9Oqs0SdTZXAF1Qu+tc
 udlBJ2RtPKhpyVoSScLDTuci+cAwPkhsnkI5birQQ2TW9Mp23
X-Google-Smtp-Source: AGHT+IGVhKNE2nUcnWlop+1e+jW8vwhxSX/wFu88PLyuI/LjDbaVSfm1iuOVHHCwfiwAMjD0wiHGzw==
X-Received: by 2002:a05:6820:188a:b0:611:a921:bfef with SMTP id
 006d021491bc7-6138fdea0f0mr2095483eaf.8.1751639119909; 
 Fri, 04 Jul 2025 07:25:19 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 061/108] target/arm: Implement SME2 SUNPK, UUNPK
Date: Fri,  4 Jul 2025 08:20:24 -0600
Message-ID: <20250704142112.1018902-62-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/helper-sme.h    | 13 ++++++++++++
 target/arm/tcg/sme_helper.c    | 38 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sme.c | 16 ++++++++++++++
 target/arm/tcg/sme.decode      | 18 ++++++++++++++++
 4 files changed, 85 insertions(+)

diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme.h
index 792b993695..893b23aa3b 100644
--- a/target/arm/tcg/helper-sme.h
+++ b/target/arm/tcg/helper-sme.h
@@ -241,3 +241,16 @@ DEF_HELPER_FLAGS_3(sme2_sqcvtun_sh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_sqcvtn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_uqcvtn_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sme2_sqcvtun_dh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+
+DEF_HELPER_FLAGS_3(sme2_sunpk2_bh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sunpk2_hs, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sunpk2_sd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sunpk4_bh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sunpk4_hs, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_sunpk4_sd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uunpk2_bh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uunpk2_hs, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uunpk2_sd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uunpk4_bh, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uunpk4_hs, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
+DEF_HELPER_FLAGS_3(sme2_uunpk4_sd, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 094a1e57f3..ee4596e066 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1737,6 +1737,44 @@ void HELPER(sme2_fcvt_w)(void *vd, void *vs, float_status *fpst, uint32_t desc)
     }
 }
 
+#define UNPK(NAME, SREG, TW, TN, HW, HN)                        \
+void HELPER(NAME)(void *vd, void *vs, uint32_t desc)            \
+{                                                               \
+    ARMVectorReg scratch[SREG];                                 \
+    size_t oprsz = simd_oprsz(desc);                            \
+    size_t n = oprsz / sizeof(TW);                              \
+    if (vectors_overlap(vd, 2 * SREG, vs, SREG)) {              \
+        vs = memcpy(scratch, vs, sizeof(scratch));              \
+    }                                                           \
+    for (size_t r = 0; r < SREG; ++r) {                         \
+        TN *s = vs + r * sizeof(ARMVectorReg);                  \
+        for (size_t i = 0; i < 2; ++i) {                        \
+            TW *d = vd + (2 * r + i) * sizeof(ARMVectorReg);    \
+            for (size_t e = 0; e < n; ++e) {                    \
+                d[HW(e)] = s[HN(i * n + e)];                    \
+            }                                                   \
+        }                                                       \
+    }                                                           \
+}
+
+UNPK(sme2_sunpk2_bh, 1, int16_t, int8_t, H2, H1)
+UNPK(sme2_sunpk2_hs, 1, int32_t, int16_t, H4, H2)
+UNPK(sme2_sunpk2_sd, 1, int64_t, int32_t, H8, H4)
+
+UNPK(sme2_sunpk4_bh, 2, int16_t, int8_t, H2, H1)
+UNPK(sme2_sunpk4_hs, 2, int32_t, int16_t, H4, H2)
+UNPK(sme2_sunpk4_sd, 2, int64_t, int32_t, H8, H4)
+
+UNPK(sme2_uunpk2_bh, 1, uint16_t, uint8_t, H2, H1)
+UNPK(sme2_uunpk2_hs, 1, uint32_t, uint16_t, H4, H2)
+UNPK(sme2_uunpk2_sd, 1, uint64_t, uint32_t, H8, H4)
+
+UNPK(sme2_uunpk4_bh, 2, uint16_t, uint8_t, H2, H1)
+UNPK(sme2_uunpk4_hs, 2, uint32_t, uint16_t, H4, H2)
+UNPK(sme2_uunpk4_sd, 2, uint64_t, uint32_t, H8, H4)
+
+#undef UNPK
+
 /* Deinterleave and convert. */
 void HELPER(sme2_fcvtl)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index dd1a6668fb..b45e68750d 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1419,3 +1419,19 @@ TRANS_FEAT(SQCVTUN_sb, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtun_sb)
 TRANS_FEAT(SQCVTN_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtn_dh)
 TRANS_FEAT(UQCVTN_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uqcvtn_dh)
 TRANS_FEAT(SQCVTUN_dh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sqcvtun_dh)
+
+TRANS_FEAT(SUNPK_2bh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sunpk2_bh)
+TRANS_FEAT(SUNPK_2hs, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sunpk2_hs)
+TRANS_FEAT(SUNPK_2sd, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sunpk2_sd)
+
+TRANS_FEAT(SUNPK_4bh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sunpk4_bh)
+TRANS_FEAT(SUNPK_4hs, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sunpk4_hs)
+TRANS_FEAT(SUNPK_4sd, aa64_sme2, do_zz, a, 0, gen_helper_sme2_sunpk4_sd)
+
+TRANS_FEAT(UUNPK_2bh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk2_bh)
+TRANS_FEAT(UUNPK_2hs, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk2_hs)
+TRANS_FEAT(UUNPK_2sd, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk2_sd)
+
+TRANS_FEAT(UUNPK_4bh, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_bh)
+TRANS_FEAT(UUNPK_4hs, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_hs)
+TRANS_FEAT(UUNPK_4sd, aa64_sme2, do_zz, a, 0, gen_helper_sme2_uunpk4_sd)
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index e005f6e6ed..38c210cd4f 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -734,6 +734,8 @@ SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
                 &zz_n n=2 zd=%zd_ax2 zn=%zn_ax2
 @zz_4x4         ........ ... ..... ...... .... . .....      \
                 &zz_n n=4 zd=%zd_ax4 zn=%zn_ax4
+@zz_4x2_n1      ........ ... ..... ...... .... . .....      \
+                &zz_n n=1 zd=%zd_ax4 zn=%zn_ax2
 
 BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
 BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
@@ -782,3 +784,19 @@ SQCVTUN_sb      11000001 011 10011 111000 ...10 .....       @zz_1x4
 SQCVTN_dh       11000001 101 10011 111000 ...10 .....       @zz_1x4
 UQCVTN_dh       11000001 101 10011 111000 ...11 .....       @zz_1x4
 SQCVTUN_dh      11000001 111 10011 111000 ...10 .....       @zz_1x4
+
+SUNPK_2bh       11000001 011 00101 111000 ..... ....0       @zz_2x1
+SUNPK_2hs       11000001 101 00101 111000 ..... ....0       @zz_2x1
+SUNPK_2sd       11000001 111 00101 111000 ..... ....0       @zz_2x1
+
+UUNPK_2bh       11000001 011 00101 111000 ..... ....1       @zz_2x1
+UUNPK_2hs       11000001 101 00101 111000 ..... ....1       @zz_2x1
+UUNPK_2sd       11000001 111 00101 111000 ..... ....1       @zz_2x1
+
+SUNPK_4bh       11000001 011 10101 111000 ....0 ...00       @zz_4x2_n1
+SUNPK_4hs       11000001 101 10101 111000 ....0 ...00       @zz_4x2_n1
+SUNPK_4sd       11000001 111 10101 111000 ....0 ...00       @zz_4x2_n1
+
+UUNPK_4bh       11000001 011 10101 111000 ....0 ...01       @zz_4x2_n1
+UUNPK_4hs       11000001 101 10101 111000 ....0 ...01       @zz_4x2_n1
+UUNPK_4sd       11000001 111 10101 111000 ....0 ...01       @zz_4x2_n1
-- 
2.43.0



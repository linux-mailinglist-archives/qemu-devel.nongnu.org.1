Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F5A791B31
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:14:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCC6-0002It-VR; Mon, 04 Sep 2023 12:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCC5-0002Hb-B4
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:12:53 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCC2-0007S5-Ty
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:12:53 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so5254266a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693843969; x=1694448769; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dNCHoIP34uA/E3xOU1iH9Qlj7WL1hYi8hhHkGEO0aL4=;
 b=xWrDzV6l/c6Uq2QfWPV3VaXF9hBfdn2TAaxDxsPu8/Fbju74p4WEGQ+YEesLj/9wmp
 n+WcexhrykMAcnuR1R0g0xFPXvjuLfOuZ5Tirc9jb21gFbCf17uAPkWvMSz67B3g3uDl
 xk83gzpIBvsR+PStSOlbs6N0oqGucQD3XyvxA7nXn/lqblSy6TngW5nQFfFfaEpLxi8t
 RXd7hFDFYEvedfEtku9E0hI/Kbp84/XaFaseHArkYInfmiwsohQihLJLyHRQMkEFjNEv
 JOcjz8m7Q58uTLAMzsm17kpliMNBuvW0rYkWxejhTzAkkaR20g6j7UKLEpvlScA4sbTD
 mVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693843969; x=1694448769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dNCHoIP34uA/E3xOU1iH9Qlj7WL1hYi8hhHkGEO0aL4=;
 b=Rg55DZaK09cuDXbEVWjWjsa9I20feqfN+ZQTZdyjwBAQ5kygTAMHcE3BLC/5cr446E
 a210Y7EwvrcA10QNd/Ofx+sbv22GeO4BTqNiJQ7KMGhfHx+DfJNK9kxRNamzpD6fXo40
 kSvfKtasDy9ChV7BDLB/X3gIGyOGwaIvDMlOq/sXsyGN1b3lRP2pBq3m30kO2DPjarWG
 vdHTf1AAAnb2OLqxVV1TMYHSPi8wNp7TopyAgRPmBLcRcz6hXkEJL6BTpiIGnGtnLHz4
 13rQUl4PNwXibmuYvhugz5V5vspTL8VG3NRLCLJqD6uInHbW7R2CGyAlBsoSnfa7JyMr
 1DmQ==
X-Gm-Message-State: AOJu0Yx+nINlCPMRwwkt7xWuRM6nYFc2Atdx1ANFCW42wBYcoMFsijNJ
 KZjm/qCC5A4GqYTxGhtvVby4Aw==
X-Google-Smtp-Source: AGHT+IGwqAMNchVebq/zOxtW9LDcET/cw58V9jehacMEp6DXzVFU/O8GYM3VjC9Mf10oTQiHwmgLKw==
X-Received: by 2002:a17:907:97d0:b0:9a1:c69c:9388 with SMTP id
 js16-20020a17090797d000b009a1c69c9388mr13151391ejc.37.1693843969442; 
 Mon, 04 Sep 2023 09:12:49 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 jj27-20020a170907985b00b009a16975ee5asm6274155ejc.169.2023.09.04.09.12.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:12:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 02/22] target/arm/tcg: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:12:14 +0200
Message-ID: <20230904161235.84651-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

Fix:

  target/arm/tcg/translate-m-nocp.c: In function ‘gen_M_fp_sysreg_read’:
  target/arm/tcg/translate-m-nocp.c:509:18: warning: declaration of ‘tmp’ shadows a previous local [-Wshadow=compatible-local]
    509 |         TCGv_i32 tmp = load_cpu_field(v7m.fpdscr[M_REG_NS]);
        |                  ^~~
  target/arm/tcg/translate-m-nocp.c:433:14: note: shadowed declaration is here
    433 |     TCGv_i32 tmp;
        |              ^~~
       ---

  target/arm/tcg/mve_helper.c: In function ‘helper_mve_vqshlsb’:
  target/arm/tcg/mve_helper.c:1259:19: warning: declaration of ‘r’ shadows a previous local [-Wshadow=compatible-local]
   1259 |         typeof(N) r = FN(N, (int8_t)(M), sizeof(N) * 8, ROUND, &su32);  \
        |                   ^
  target/arm/tcg/mve_helper.c:1267:5: note: in expansion of macro ‘WRAP_QRSHL_HELPER’
   1267 |     WRAP_QRSHL_HELPER(do_sqrshl_bhs, N, M, false, satp)
        |     ^~~~~~~~~~~~~~~~~
  target/arm/tcg/mve_helper.c:927:22: note: in expansion of macro ‘DO_SQSHL_OP’
    927 |             TYPE r = FN(n[H##ESIZE(e)], m[H##ESIZE(e)], &sat);          \
        |                      ^~
  target/arm/tcg/mve_helper.c:945:5: note: in expansion of macro ‘DO_2OP_SAT’
    945 |     DO_2OP_SAT(OP##b, 1, int8_t, FN)            \
        |     ^~~~~~~~~~
  target/arm/tcg/mve_helper.c:1277:1: note: in expansion of macro ‘DO_2OP_SAT_S’
   1277 | DO_2OP_SAT_S(vqshls, DO_SQSHL_OP)
        | ^~~~~~~~~~~~
       ---

  target/arm/tcg/mve_helper.c: In function ‘do_sqrshl48_d’:
  target/arm/tcg/mve_helper.c:2463:17: warning: declaration of ‘extval’ shadows a previous local [-Wshadow=compatible-local]
   2463 |         int64_t extval = sextract64(src << shift, 0, 48);
        |                 ^~~~~~
  target/arm/tcg/mve_helper.c:2443:18: note: shadowed declaration is here
   2443 |     int64_t val, extval;
        |                  ^~~~~~
       ---

  target/arm/tcg/mve_helper.c: In function ‘do_uqrshl48_d’:
  target/arm/tcg/mve_helper.c:2495:18: warning: declaration of ‘extval’ shadows a previous local [-Wshadow=compatible-local]
   2495 |         uint64_t extval = extract64(src << shift, 0, 48);
        |                  ^~~~~~
  target/arm/tcg/mve_helper.c:2479:19: note: shadowed declaration is here
   2479 |     uint64_t val, extval;
        |                   ^~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/mve_helper.c       | 16 ++++++++--------
 target/arm/tcg/translate-m-nocp.c |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 403b345ea3..7f5b6533cd 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -924,8 +924,8 @@ DO_1OP_IMM(vorri, DO_ORRI)
         bool qc = false;                                                \
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {              \
             bool sat = false;                                           \
-            TYPE r = FN(n[H##ESIZE(e)], m[H##ESIZE(e)], &sat);          \
-            mergemask(&d[H##ESIZE(e)], r, mask);                        \
+            TYPE r_ = FN(n[H##ESIZE(e)], m[H##ESIZE(e)], &sat);         \
+            mergemask(&d[H##ESIZE(e)], r_, mask);                       \
             qc |= sat & mask & 1;                                       \
         }                                                               \
         if (qc) {                                                       \
@@ -1256,11 +1256,11 @@ DO_2OP_SAT(vqsubsw, 4, int32_t, DO_SQSUB_W)
 #define WRAP_QRSHL_HELPER(FN, N, M, ROUND, satp)                        \
     ({                                                                  \
         uint32_t su32 = 0;                                              \
-        typeof(N) r = FN(N, (int8_t)(M), sizeof(N) * 8, ROUND, &su32);  \
+        typeof(N) qrshl_ret = FN(N, (int8_t)(M), sizeof(N) * 8, ROUND, &su32); \
         if (su32) {                                                     \
             *satp = true;                                               \
         }                                                               \
-        r;                                                              \
+        qrshl_ret;                                                      \
     })
 
 #define DO_SQSHL_OP(N, M, satp) \
@@ -1298,12 +1298,12 @@ DO_2OP_SAT_U(vqrshlu, DO_UQRSHL_OP)
         for (e = 0; e < 16 / ESIZE; e++, mask >>= ESIZE) {              \
             bool sat = false;                                           \
             if ((e & 1) == XCHG) {                                      \
-                TYPE r = FN(n[H##ESIZE(e)],                             \
+                TYPE vqdmladh_ret = FN(n[H##ESIZE(e)],                  \
                             m[H##ESIZE(e - XCHG)],                      \
                             n[H##ESIZE(e + (1 - 2 * XCHG))],            \
                             m[H##ESIZE(e + (1 - XCHG))],                \
                             ROUND, &sat);                               \
-                mergemask(&d[H##ESIZE(e)], r, mask);                    \
+                mergemask(&d[H##ESIZE(e)], vqdmladh_ret, mask);         \
                 qc |= sat & mask & 1;                                   \
             }                                                           \
         }                                                               \
@@ -2460,7 +2460,7 @@ static inline int64_t do_sqrshl48_d(int64_t src, int64_t shift,
             return extval;
         }
     } else if (shift < 48) {
-        int64_t extval = sextract64(src << shift, 0, 48);
+        extval = sextract64(src << shift, 0, 48);
         if (!sat || src == (extval >> shift)) {
             return extval;
         }
@@ -2492,7 +2492,7 @@ static inline uint64_t do_uqrshl48_d(uint64_t src, int64_t shift,
             return extval;
         }
     } else if (shift < 48) {
-        uint64_t extval = extract64(src << shift, 0, 48);
+        extval = extract64(src << shift, 0, 48);
         if (!sat || src == (extval >> shift)) {
             return extval;
         }
diff --git a/target/arm/tcg/translate-m-nocp.c b/target/arm/tcg/translate-m-nocp.c
index 33f6478bb9..42308c4db5 100644
--- a/target/arm/tcg/translate-m-nocp.c
+++ b/target/arm/tcg/translate-m-nocp.c
@@ -506,7 +506,7 @@ static bool gen_M_fp_sysreg_read(DisasContext *s, int regno,
 
         gen_branch_fpInactive(s, TCG_COND_EQ, lab_active);
         /* fpInactive case: reads as FPDSCR_NS */
-        TCGv_i32 tmp = load_cpu_field(v7m.fpdscr[M_REG_NS]);
+        tmp = load_cpu_field(v7m.fpdscr[M_REG_NS]);
         storefn(s, opaque, tmp, true);
         lab_end = gen_new_label();
         tcg_gen_br(lab_end);
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C2970DD3E
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:11:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RnM-0002G1-QR; Tue, 23 May 2023 09:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RnI-0002FU-P6
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:11:16 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1RnG-0001nD-Tm
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:11:16 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f607839b89so14481025e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684847473; x=1687439473;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C57svFkKes9NwdaXS0ZScXex1YkRfVJ4tVoU6xmVn+4=;
 b=fqqPc154b+NjCa2MZTGZCn4m2YNJpNijA4msH1lo5kXHKxyjyZWO1V1KjqlbsMAap7
 XATV+5igq3XzHNZZJH1bzmR92MloED2P9wKiXKKvkoM1e6GxYNL7SwEsGMmamv2kQOPB
 ot8j7aj8K4fa2i70//sTZsa39ddHSqLoqydrynIDxLGhfdMISRj/hAAVsfTLEeJkDqTE
 1wGAD8rMWWQ2jMFXw5i6NtJkV0Eew+3jVXyDReMtDoeW31rlh6HpdJ70gXUz5uKtWQVY
 dz98HXf/L+7P76NEJ3Fg/TRfopkQFe6Co1c8a7f7HYUxrE12eyT/734PT/oKyXQQ/YYM
 GTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684847473; x=1687439473;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C57svFkKes9NwdaXS0ZScXex1YkRfVJ4tVoU6xmVn+4=;
 b=SHhjQgNHyjabDcH0+GYJIDgxIwjrRfFG0LjlHZRo18wAb9oleMAML+ROvMWn3ZdXQ/
 5Kj/lgxEKrrsTxh0lQIkPp4/dt8F5zk9eznqs1RidoJOi4Pqqw7fl27lwjWe+8C25PGg
 prFZ7sMkIwHRf56LEKg6PEnXAgIZYYfHlc5fk11aykMeB+Od/s5LjVT85P8Zp7IJSAkW
 V+wEuLn4JaDRa39zkdYajYijGHN4TQojVs0AyIDWr9gvUqroUauOhtmHGczUAEqs2ohr
 QyCpHY9BbX6JQ9BE7UzS0ad8XiCqHS2a0TdP6wleYXGkJcP9Mt2ZzQPfkCrGOpnbhXPI
 i1wA==
X-Gm-Message-State: AC+VfDyuJpGxP9jcbVLiK5Z3ceZnd8vgosPY48rD4Q43HH2CfuHUuDIh
 hSzRC1iFlYs/JlwFvPoEWbCTuw==
X-Google-Smtp-Source: ACHHUZ7MoLBhFMl+AOBFDHwJupeTrQ00SgE3ik3kJzP/vaiUe4ErVYrWYuEE90cRnaHp1IDdit/mVA==
X-Received: by 2002:a05:600c:22d1:b0:3f5:ffe3:46a7 with SMTP id
 17-20020a05600c22d100b003f5ffe346a7mr6433320wmg.9.1684847473256; 
 Tue, 23 May 2023 06:11:13 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n21-20020a7bc5d5000000b003f42a75ac2asm11773335wmk.23.2023.05.23.06.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:11:13 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8827C1FFBB;
 Tue, 23 May 2023 14:11:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [RFC PATCH] softfloat: use QEMU_FLATTEN to avoid mistaken isra
 inlining
Date: Tue, 23 May 2023 14:11:07 +0100
Message-Id: <20230523131107.3680641-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Balton discovered that asserts for the extract/deposit calls had a
significant impact on a lame benchmark on qemu-ppc. Replicating with:

  ./qemu-ppc64 ~/lsrc/tests/lame.git-svn/builds/ppc64/frontend/lame \
    -h pts-trondheim-3.wav pts-trondheim-3.mp3

showed up the pack/unpack routines not eliding the assert checks as it
should have done causing them to prominently figure in the profile:

  11.44%  qemu-ppc64  qemu-ppc64               [.] unpack_raw64.isra.0
  11.03%  qemu-ppc64  qemu-ppc64               [.] parts64_uncanon_normal
   8.26%  qemu-ppc64  qemu-ppc64               [.] helper_compute_fprf_float64
   6.75%  qemu-ppc64  qemu-ppc64               [.] do_float_check_status
   5.34%  qemu-ppc64  qemu-ppc64               [.] parts64_muladd
   4.75%  qemu-ppc64  qemu-ppc64               [.] pack_raw64.isra.0
   4.38%  qemu-ppc64  qemu-ppc64               [.] parts64_canonicalize
   3.62%  qemu-ppc64  qemu-ppc64               [.] float64r32_round_pack_canonical

After this patch the same test runs 31 seconds faster with a profile
where the generated code dominates more:

+   14.12%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000619420
+   13.30%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000616850
+   12.58%    12.19%  qemu-ppc64  qemu-ppc64               [.] parts64_uncanon_normal
+   10.62%     0.00%  qemu-ppc64  [unknown]                [.] 0x000000400061bf70
+    9.91%     9.73%  qemu-ppc64  qemu-ppc64               [.] helper_compute_fprf_float64
+    7.84%     7.82%  qemu-ppc64  qemu-ppc64               [.] do_float_check_status
+    6.47%     5.78%  qemu-ppc64  qemu-ppc64               [.] parts64_canonicalize.constprop.0
+    6.46%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000620130
+    6.42%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000004000619400
+    6.17%     6.04%  qemu-ppc64  qemu-ppc64               [.] parts64_muladd
+    5.85%     0.00%  qemu-ppc64  [unknown]                [.] 0x00000040006167e0
+    5.74%     0.00%  qemu-ppc64  [unknown]                [.] 0x0000b693fcffffd3
+    5.45%     4.78%  qemu-ppc64  qemu-ppc64               [.] float64r32_round_pack_canonical

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <ec9cfe5a-d5f2-466d-34dc-c35817e7e010@linaro.org>
[AJB: Patchified rth's suggestion]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>
---
 fpu/softfloat.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 108f9cb224..42e6c188b4 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -593,27 +593,27 @@ static void unpack_raw64(FloatParts64 *r, const FloatFmt *fmt, uint64_t raw)
     };
 }
 
-static inline void float16_unpack_raw(FloatParts64 *p, float16 f)
+static void QEMU_FLATTEN float16_unpack_raw(FloatParts64 *p, float16 f)
 {
     unpack_raw64(p, &float16_params, f);
 }
 
-static inline void bfloat16_unpack_raw(FloatParts64 *p, bfloat16 f)
+static void QEMU_FLATTEN bfloat16_unpack_raw(FloatParts64 *p, bfloat16 f)
 {
     unpack_raw64(p, &bfloat16_params, f);
 }
 
-static inline void float32_unpack_raw(FloatParts64 *p, float32 f)
+static void QEMU_FLATTEN float32_unpack_raw(FloatParts64 *p, float32 f)
 {
     unpack_raw64(p, &float32_params, f);
 }
 
-static inline void float64_unpack_raw(FloatParts64 *p, float64 f)
+static void QEMU_FLATTEN float64_unpack_raw(FloatParts64 *p, float64 f)
 {
     unpack_raw64(p, &float64_params, f);
 }
 
-static void floatx80_unpack_raw(FloatParts128 *p, floatx80 f)
+static void QEMU_FLATTEN floatx80_unpack_raw(FloatParts128 *p, floatx80 f)
 {
     *p = (FloatParts128) {
         .cls = float_class_unclassified,
@@ -623,7 +623,7 @@ static void floatx80_unpack_raw(FloatParts128 *p, floatx80 f)
     };
 }
 
-static void float128_unpack_raw(FloatParts128 *p, float128 f)
+static void QEMU_FLATTEN float128_unpack_raw(FloatParts128 *p, float128 f)
 {
     const int f_size = float128_params.frac_size - 64;
     const int e_size = float128_params.exp_size;
@@ -650,27 +650,27 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
-static inline float16 float16_pack_raw(const FloatParts64 *p)
+static float16 QEMU_FLATTEN float16_pack_raw(const FloatParts64 *p)
 {
     return make_float16(pack_raw64(p, &float16_params));
 }
 
-static inline bfloat16 bfloat16_pack_raw(const FloatParts64 *p)
+static bfloat16 QEMU_FLATTEN bfloat16_pack_raw(const FloatParts64 *p)
 {
     return pack_raw64(p, &bfloat16_params);
 }
 
-static inline float32 float32_pack_raw(const FloatParts64 *p)
+static float32 QEMU_FLATTEN float32_pack_raw(const FloatParts64 *p)
 {
     return make_float32(pack_raw64(p, &float32_params));
 }
 
-static inline float64 float64_pack_raw(const FloatParts64 *p)
+static float64 QEMU_FLATTEN float64_pack_raw(const FloatParts64 *p)
 {
     return make_float64(pack_raw64(p, &float64_params));
 }
 
-static float128 float128_pack_raw(const FloatParts128 *p)
+static float128 QEMU_FLATTEN float128_pack_raw(const FloatParts128 *p)
 {
     const int f_size = float128_params.frac_size - 64;
     const int e_size = float128_params.exp_size;
-- 
2.39.2



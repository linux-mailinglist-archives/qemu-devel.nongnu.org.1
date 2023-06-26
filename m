Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A63173E3E4
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:48:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoLM-0002JW-8B; Mon, 26 Jun 2023 11:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJr-0000Im-Pc
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:59 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJn-0002qk-65
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:39:59 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3113dabc549so5071517f8f.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793994; x=1690385994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SfkiVCmLUBJ6DWFjAcx87ywe0kXi0048sFqWxzKvJ7o=;
 b=Hq9hOLZeCglFzMEbtnY/zBnN43sfJCJyXgKk+bSvNvswG43KSj2OCpvyAv7phpfhpC
 +aCX6FAIHSX9SUz07e1eeXQsKEieJ4ETQHKTclLbylhEJy/omuodM65YfMXdS5W3doiw
 ISmSaj7blMLAa4cYpwPdN7OASzrQsS4WCresamI50C5JkdHvFva6KbjfXoET0nHfBy4U
 aEj34QBnus71dDvHe5nFckYhYNhKv/zNZR5VAK56JECrAM3U+3LlhhcCGR3YmaXk3hVr
 BNFDtmtXBNZZ6te89cqZJusO8IOzCbGQOOXRNhhQp8dPlc+Y1Cn1AtxSIMGfQINhDlf2
 hJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793994; x=1690385994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SfkiVCmLUBJ6DWFjAcx87ywe0kXi0048sFqWxzKvJ7o=;
 b=W0nU2NHyp1YEQ2PsXO2yNrDKAOBUzb6r63o0+h/920pfBgcymFcrvJHtE7aCy08NVG
 8RwH9bANg2svx5VDy5eDnxqptdUM1XnDv9muJBCRj1TVSO2UT3bOFyUuLLEdMXQ9JWiO
 0WWBjxSU4EqRjlxLIVjYmhpnQkV9cOjlNkvzv2zBb/pxv+MI1tGpiRK/bVmOnwq/MK+q
 d75uura8yZB4LbF4xAZte5ZmTPEFxAbDJcsTDY6LOIq7DmOqJmUUbpAeNG2JmaF8uX+t
 Mgr6UCQEAThYfrwKpV+35P8AOuxHo49qzC1Fimhq846rJzVhkn79hA5Ocwb4VqrvIXhs
 T6vQ==
X-Gm-Message-State: AC+VfDwGE6GAXFz26iqfzRfOKm3gx4O6OXErxWy0etTaCXbqgon2hcmE
 QwSUTVH/V2pkpqhpwzDcGYHdIIinZvEOyvRXCt5NuI7/
X-Google-Smtp-Source: ACHHUZ7Mranafy+xK0NXgei2ToUcpqYiuZBTnwUSPWOChMBfwagBN8DK+nJX+ufDv+Gdl36BSGZO1A==
X-Received: by 2002:adf:f4cf:0:b0:313:f68d:acf9 with SMTP id
 h15-20020adff4cf000000b00313f68dacf9mr1397799wrp.10.1687793993960; 
 Mon, 26 Jun 2023 08:39:53 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/22] softfloat: use QEMU_FLATTEN to avoid mistaken isra
 inlining
Date: Mon, 26 Jun 2023 17:39:35 +0200
Message-Id: <20230626153945.76180-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20230523131107.3680641-1-alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.34.1



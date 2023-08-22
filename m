Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 460F1783E88
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 13:03:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYP9i-0006S3-O8; Tue, 22 Aug 2023 07:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYP9T-0006N4-Ti
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:02:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYP9P-0003OY-0w
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:02:22 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3fef5809999so11877005e9.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 04:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692702137; x=1693306937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEM3PfJxI/aPPc1i3tV/XEA6n73WFfBj06/t4sKpaao=;
 b=nBsXcbcvOtoGhumKewU1elFD1KRIs/anotvQ08PGmWuTeqEJwCThrSWGBHVsmkHgBe
 /uEE/7TDC969ZHn3s1Gc21FVS7h/JtJGeQAWzGNJBcM18g52OoZueTz2urGBMVZ5nz4w
 aU0a1Fj+OyQXHD3Brej6Z+eo6RsTYC1dVzu2IZjkCfbp9opMEN+9GuTfoVFlAbeLkpQq
 73NWKWrADLFikStDJGdMmE4yO9AmIsnwAdPH24cl9+IG+/lLwrfK3RSPfo/NfGhp+anj
 E9FHVoXnimo8ZsXFG9o6NrLiKki+0NC7ZcPVl9PoKy5GSjJLQYiTwUDy1cpSIwWbeqM8
 YBmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692702137; x=1693306937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LEM3PfJxI/aPPc1i3tV/XEA6n73WFfBj06/t4sKpaao=;
 b=aPe2dgQigykqF9BGEbU2TlFDRqRWzNOC2rEUxkS9vPYbm71HxKpBpqi7pZlCqToBYm
 L/aXKD0uZszyNinEZIlpjF0t2FFU3POsnnvROsbMnq6P6EztZfiN8k4gDwTMYJ0naN3N
 r8CShSM6dAa62Zeo0wZ9Aa1R1752DityVLW61zZTKTcvJu7L9u8mriE0IhQGzyiDFhcV
 RC/gsynL+aHiLiexx6F9BRrv7PeklnlI9if5CZTA0Rhs07tkK5Iw1ZGPAdahgTGGYAMX
 +nNYbs8V/kF0cjP+jlvEpnT9JMqEZQoGRsFJIzLSEESyPU75TjCrZp5ZrFdp2PLmK1tn
 u3yA==
X-Gm-Message-State: AOJu0Yw0GEkacBigUY8qKuFJ15o2ql639IYZrloxHyzACYre6kKWN7ft
 M9YWLGm2otoKLyyIHdSIZmV4tflhxxi00ojzM/2wcA==
X-Google-Smtp-Source: AGHT+IH78J9CJh6arRxgwqdUliOdq3ljgj9ofuS3RJMKaYbZ/eDXQPayjQOz2QsotixUgr6QqrXdDg==
X-Received: by 2002:a1c:770b:0:b0:3fe:2109:b9ff with SMTP id
 t11-20020a1c770b000000b003fe2109b9ffmr6993689wmi.0.1692702137029; 
 Tue, 22 Aug 2023 04:02:17 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 z26-20020a1c4c1a000000b003fed1ba0b8esm14604106wmf.8.2023.08.22.04.02.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 04:02:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
Subject: [PATCH 6/6] target/loongarch: Use hswap_i64() in REVH.D opcode
Date: Tue, 22 Aug 2023 13:01:29 +0200
Message-ID: <20230822110129.41022-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822110129.41022-1-philmd@linaro.org>
References: <20230822110129.41022-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Commit 46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}")
introduced the generic hswap_i32(). Use it instead of open-coding
it as gen_revh_d().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/insn_trans/trans_bit.c.inc | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/target/loongarch/insn_trans/trans_bit.c.inc b/target/loongarch/insn_trans/trans_bit.c.inc
index 25b4d7858b..95b4ee5bc8 100644
--- a/target/loongarch/insn_trans/trans_bit.c.inc
+++ b/target/loongarch/insn_trans/trans_bit.c.inc
@@ -150,20 +150,6 @@ static void gen_revh_2w(TCGv dest, TCGv src1)
     tcg_gen_or_i64(dest, t1, t0);
 }
 
-static void gen_revh_d(TCGv dest, TCGv src1)
-{
-    TCGv t0 = tcg_temp_new();
-    TCGv t1 = tcg_temp_new();
-    TCGv mask = tcg_constant_tl(0x0000FFFF0000FFFFULL);
-
-    tcg_gen_shri_tl(t1, src1, 16);
-    tcg_gen_and_tl(t1, t1, mask);
-    tcg_gen_and_tl(t0, src1, mask);
-    tcg_gen_shli_tl(t0, t0, 16);
-    tcg_gen_or_tl(t0, t0, t1);
-    tcg_gen_rotri_tl(dest, t0, 32);
-}
-
 static void gen_maskeqz(TCGv dest, TCGv src1, TCGv src2)
 {
     TCGv zero = tcg_constant_tl(0);
@@ -193,7 +179,7 @@ TRANS(revb_4h, gen_rr, EXT_NONE, EXT_NONE, gen_revb_4h)
 TRANS(revb_2w, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
 TRANS(revb_d, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
 TRANS(revh_2w, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
-TRANS(revh_d, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
+TRANS(revh_d, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_hswap_i64)
 TRANS(bitrev_4b, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_bitswap)
 TRANS(bitrev_8b, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
 TRANS(bitrev_w, gen_rr, EXT_NONE, EXT_SIGN, gen_helper_bitrev_w)
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A51079A3E0
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 08:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfagg-0004yT-O4; Mon, 11 Sep 2023 02:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagd-0004jq-V2
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:19 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfagb-0005Gm-LY
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 02:46:19 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3ab244e7113so2959524b6e.3
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 23:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694414776; x=1695019576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sm5kdR4zPqERpHwNfrDrMNoNCsEGBcjXZveAeFuP0TY=;
 b=WCweJ4wM70UV/yCzNhhxJ/g1u9zbmT3ncmqaTN59+xDVBLo82D7Ww5GaWXjG4O4nJ4
 T/rbK+wlaaTNu9FCdNLK5s1LQlozDH9eTHKS2DMrSuCUojwgRKVcpPidamDFwDlqO0YW
 GuxqP2ad3FWPK9/eiqJ1rf8q/uEhAheALcg/v86rqFTKL4RB3c0HHAlbkfbjOyaRzUsU
 pM5IGt0uiS9ufn9wGeYHI7sTyH2CsVo1a+HeoRwwZvP8x+Ah22oloktRNg7iDlA5QemZ
 P1jlKHwdbr/A28nn4zbYoapcTYXxdt4kja+Z2SulZbgrU7c9/IAI+81md+xEKwO7pKjv
 aHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694414776; x=1695019576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sm5kdR4zPqERpHwNfrDrMNoNCsEGBcjXZveAeFuP0TY=;
 b=o8QV3f8gAVY4GPEgKKHyg0WHTKx4NhoEgDPMMBktIEGDJJ14B5q+ztr5Gh2ppoJX1t
 dmFL3SBLvgPR1iK+BQf/7bgDCABmkYoTVoXPSl2SunDE12RHbwpyN6Xcaq13VedcplCx
 aGZCZUirRos9kb1JICffioqMSIqdlOn26/Nl1JSKjLFOHhnO8Hr3IjVGmi9Uym92HkoD
 rpJ4a1HtAOuW8o4t9KDv0B5UyitLnrSALNa/8/8M6IQHdlAbs/sPoV5CbD3sUNqm296m
 FsNRr3wdULiIy0v9UmTj5vyP7IdpgI5D4uNU/6jBnN+mWG7GTV4eSiha/g0fogJKf62N
 6tGw==
X-Gm-Message-State: AOJu0YxOjh1U8GczSjIhwTxUuXxSTZJpVn5u6c81vnOqaR84VdiNHJNb
 n/EY1nEGe3KNrrk58vq6mMsELovZO/wesg==
X-Google-Smtp-Source: AGHT+IFD4EsUUvvDSVGoCUoA5YLxY24f8nnIyIhWXbjdOdWdqjNSz+rFfnUhSZV8wKwjWDiVs2mrog==
X-Received: by 2002:a05:6870:a10b:b0:1bf:80f2:8429 with SMTP id
 m11-20020a056870a10b00b001bf80f28429mr10852107oae.40.1694414776271; 
 Sun, 10 Sep 2023 23:46:16 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a656a8c000000b00553dcfc2179sm4264606pgu.52.2023.09.10.23.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Sep 2023 23:46:15 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Ard Biesheuvel <ardb@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 41/45] target/riscv: Use accelerated helper for AES64KS1I
Date: Mon, 11 Sep 2023 16:43:16 +1000
Message-ID: <20230911064320.939791-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911064320.939791-1-alistair.francis@wdc.com>
References: <20230911064320.939791-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=alistair23@gmail.com; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Ard Biesheuvel <ardb@kernel.org>

Use the accelerated SubBytes/ShiftRows/AddRoundKey AES helper to
implement the first half of the key schedule derivation. This does not
actually involve shifting rows, so clone the same value into all four
columns of the AES vector to counter that operation.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20230831154118.138727-1-ardb@kernel.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/crypto_helper.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index 4d65945429..bb084e00ef 100644
--- a/target/riscv/crypto_helper.c
+++ b/target/riscv/crypto_helper.c
@@ -148,24 +148,17 @@ target_ulong HELPER(aes64ks1i)(target_ulong rs1, target_ulong rnum)
 
     uint8_t enc_rnum = rnum;
     uint32_t temp = (RS1 >> 32) & 0xFFFFFFFF;
-    uint8_t rcon_ = 0;
-    target_ulong result;
+    AESState t, rc = {};
 
     if (enc_rnum != 0xA) {
         temp = ror32(temp, 8); /* Rotate right by 8 */
-        rcon_ = round_consts[enc_rnum];
+        rc.w[0] = rc.w[1] = round_consts[enc_rnum];
     }
 
-    temp = ((uint32_t)AES_sbox[(temp >> 24) & 0xFF] << 24) |
-           ((uint32_t)AES_sbox[(temp >> 16) & 0xFF] << 16) |
-           ((uint32_t)AES_sbox[(temp >> 8) & 0xFF] << 8) |
-           ((uint32_t)AES_sbox[(temp >> 0) & 0xFF] << 0);
+    t.w[0] = t.w[1] = t.w[2] = t.w[3] = temp;
+    aesenc_SB_SR_AK(&t, &t, &rc, false);
 
-    temp ^= rcon_;
-
-    result = ((uint64_t)temp << 32) | temp;
-
-    return result;
+    return t.d[0];
 }
 
 target_ulong HELPER(aes64im)(target_ulong rs1)
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEE67981ED
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 08:09:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeUee-0008IL-1A; Fri, 08 Sep 2023 02:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUeb-000891-D3
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:41 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qeUeV-0007p5-NO
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 02:07:40 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1c0db66af1bso12627095ad.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 23:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694153253; x=1694758053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sm5kdR4zPqERpHwNfrDrMNoNCsEGBcjXZveAeFuP0TY=;
 b=sqGmyToYWjbr7YcKfKgBYVl0VBtkPFsKrX1MrtQCPovpVenDJGjfLwJoVmgYq5eFcC
 W9nrm2NadyL7HG9sQaAbUaLNBvZtBES/dpZ6cKbhXWmHY1TRmqMiN25fgyLy6YGWxsVS
 6AcImHUOEcTfNIiotyosOQGxTjI/Yxa3BzNHsapt5BdxJFlPIwu72SLmJQuXj3ApiOGS
 ujh7q27Vk97ABqFNixmxWU+Yzdv8QStvDuBqVAUrTZgVmtMIIDOFIhlPINgLagwn8xvt
 kobgcjnGjQDZaZM6QKlFol/rigUvOcz5Ao7dkNqS3invd3bxAxLphoP1ybVsIUO7Fhb3
 osVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694153253; x=1694758053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sm5kdR4zPqERpHwNfrDrMNoNCsEGBcjXZveAeFuP0TY=;
 b=enZNsMrFeDngow2/RZWp9kMYoPpEcfgW59V7bKlcR5WqoDILFJO9o7CyDfI1XD3mM4
 /efbtwxVXF/iWsiPw6V+SoB0gQOSMD3XNM+YwUVkFbWJqJjEhodd4FvuClaKzPbMXDzB
 cfts4facvHCleOHwa4TygvT12Pjd1eZILHQVD7igIcVHoeUhy3nnbT7z1SFh4wyGAbfo
 rw+eKPIkscgVi6CHMo1E9UJisStb3BmEsnvgRvR3TI/6wMH0NYq5rY4V5VvbncSomXPi
 5SIYn9L8Q7efE0OmaC2m7XDz1N5bnEYhT0PGUbUjucAqY47yNPLP36m0P3PvfC4JWOvV
 USVQ==
X-Gm-Message-State: AOJu0YxWxjya+8HNhMwS5c9jtaECB01ZoEInyEAQLb36TSd7GS2Ahw2G
 v0YNXKJpN6BhqyB6wRF3eduzZWcZhw7kqs40
X-Google-Smtp-Source: AGHT+IF4iDlPLdiu4Jcis6dnXVE5fmlBYh0DPyl7ZdL15Xkz/OFXXG/E7jxXFh9Q56bRVxZA+88kew==
X-Received: by 2002:a17:902:f7c7:b0:1b8:7fd7:e022 with SMTP id
 h7-20020a170902f7c700b001b87fd7e022mr1737965plw.28.1694153252826; 
 Thu, 07 Sep 2023 23:07:32 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 q1-20020a170902dac100b001c3267ae31bsm715231plx.301.2023.09.07.23.07.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 23:07:31 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Ard Biesheuvel <ardb@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 41/65] target/riscv: Use accelerated helper for AES64KS1I
Date: Fri,  8 Sep 2023 16:04:07 +1000
Message-ID: <20230908060431.1903919-42-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908060431.1903919-1-alistair.francis@wdc.com>
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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



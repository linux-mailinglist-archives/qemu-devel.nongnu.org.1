Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E86B27459B9
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:10:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGRN-0002is-Hs; Mon, 03 Jul 2023 06:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRF-0002ar-FA
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:45 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGR3-0005hG-6e
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:05:39 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3143798f542so823291f8f.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378725; x=1690970725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oDegPUeqJ78xBO4pGFYHur8C+Wi6RpRKy5K2/MXINzU=;
 b=vLG7COb8BBsN/lRZMi0b6txxnJqZ6kNs6ajuT/9Hzc9VVDDc7li9k4BjYbRAt+hDqO
 ChX2RUhbRDHzacelzbGmuVicwW82ZnxPqqiS641kidNGlX/1tq2l9q5YfLSs5Bj2U99Y
 3dFeaK+lMc9Yj8qp09d4DRgavzyxQAXK4gt3yssLUB5RjQrbth+zUur9KXt5qLk6Wbv9
 fADUv4OTmnW+uBjAAQ0/f8huoqK74/biTwuWwf477OOMn91Fnmp2lhpYMju8BmQTfkE4
 VYVsj1OtajwI/umIP/CTM3i15GOYKO79sc3dQpXLKxytEVUV9nN5/X66vS6qx3ARYT0S
 4iLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378725; x=1690970725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oDegPUeqJ78xBO4pGFYHur8C+Wi6RpRKy5K2/MXINzU=;
 b=eXDI364tcFDJa2ecdfVKS9SE7MXt7kNkV7MO+9++jxhOPPvxwhkg7+q7PbMgOt0E5Y
 1wBKTIqD5PUQJpmeAEqX2JGOMHht5ZhmFA0+5DEbSL6XeMSiUcMVzM8M4QR9CIGuIFov
 /TZcfJCZbsXLL15GFILhu8jRIzDdjyggOugT9l+JC+bZgSwCZRSmJD5zvjG9qIsFH2BJ
 lfrA6gwEiwqLuaR//hyx+7rv5EznvwedOue+FPH1t37D831Qv3o55DPSN9I2mMfrmm42
 d+Bfy8LDugxH2MIlNetdo0wQDY5YIkftHbYelcuMLRJRbT27ls8i0aUlKk4uu+4RZ47X
 6AaA==
X-Gm-Message-State: ABy/qLbXBXE6wpvMq6tYCgPBiSayxkf/uuzeToD5gnNtVMs+C8xcusBY
 oDtDi4x3qeo2mtTphlooJdy5qQ3+1CcFZ3gGpOS/mg==
X-Google-Smtp-Source: APBJJlH8e7tEnJKo8/91eyVR/cBCFJ/Ja5FdJAWUu0Vy0rAQfBmK3sQJ9VZbyFiM7PrIYjHz8HK2VQ==
X-Received: by 2002:adf:f0d2:0:b0:314:dc0:2fca with SMTP id
 x18-20020adff0d2000000b003140dc02fcamr8863687wro.29.1688378725661; 
 Mon, 03 Jul 2023 03:05:25 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 03/37] target/arm: Move aesmc and aesimc tables to
 crypto/aes.c
Date: Mon,  3 Jul 2023 12:04:46 +0200
Message-Id: <20230703100520.68224-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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

We do not currently have a table in crypto/ for just MixColumns.
Move both tables for consistency.

Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/crypto/aes.h           |   6 ++
 crypto/aes.c                   | 140 ++++++++++++++++++++++++++++++++
 target/arm/tcg/crypto_helper.c | 143 ++-------------------------------
 3 files changed, 151 insertions(+), 138 deletions(-)

diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 822d64588c..24b073d569 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -34,6 +34,12 @@ extern const uint8_t AES_isbox[256];
 extern const uint8_t AES_shifts[16];
 extern const uint8_t AES_ishifts[16];
 
+/* AES MixColumns, for use with rot32. */
+extern const uint32_t AES_mc_rot[256];
+
+/* AES InvMixColumns, for use with rot32. */
+extern const uint32_t AES_imc_rot[256];
+
 /* AES InvMixColumns */
 /* AES_imc[x][0] = [x].[0e, 09, 0d, 0b]; */
 /* AES_imc[x][1] = [x].[0b, 0e, 09, 0d]; */
diff --git a/crypto/aes.c b/crypto/aes.c
index af72ff7779..67bb74b8e3 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -116,6 +116,146 @@ const uint8_t AES_ishifts[16] = {
     0, 13, 10, 7, 4, 1, 14, 11, 8, 5, 2, 15, 12, 9, 6, 3
 };
 
+/*
+ * MixColumns lookup table, for use with rot32.
+ */
+const uint32_t AES_mc_rot[256] = {
+    0x00000000, 0x03010102, 0x06020204, 0x05030306,
+    0x0c040408, 0x0f05050a, 0x0a06060c, 0x0907070e,
+    0x18080810, 0x1b090912, 0x1e0a0a14, 0x1d0b0b16,
+    0x140c0c18, 0x170d0d1a, 0x120e0e1c, 0x110f0f1e,
+    0x30101020, 0x33111122, 0x36121224, 0x35131326,
+    0x3c141428, 0x3f15152a, 0x3a16162c, 0x3917172e,
+    0x28181830, 0x2b191932, 0x2e1a1a34, 0x2d1b1b36,
+    0x241c1c38, 0x271d1d3a, 0x221e1e3c, 0x211f1f3e,
+    0x60202040, 0x63212142, 0x66222244, 0x65232346,
+    0x6c242448, 0x6f25254a, 0x6a26264c, 0x6927274e,
+    0x78282850, 0x7b292952, 0x7e2a2a54, 0x7d2b2b56,
+    0x742c2c58, 0x772d2d5a, 0x722e2e5c, 0x712f2f5e,
+    0x50303060, 0x53313162, 0x56323264, 0x55333366,
+    0x5c343468, 0x5f35356a, 0x5a36366c, 0x5937376e,
+    0x48383870, 0x4b393972, 0x4e3a3a74, 0x4d3b3b76,
+    0x443c3c78, 0x473d3d7a, 0x423e3e7c, 0x413f3f7e,
+    0xc0404080, 0xc3414182, 0xc6424284, 0xc5434386,
+    0xcc444488, 0xcf45458a, 0xca46468c, 0xc947478e,
+    0xd8484890, 0xdb494992, 0xde4a4a94, 0xdd4b4b96,
+    0xd44c4c98, 0xd74d4d9a, 0xd24e4e9c, 0xd14f4f9e,
+    0xf05050a0, 0xf35151a2, 0xf65252a4, 0xf55353a6,
+    0xfc5454a8, 0xff5555aa, 0xfa5656ac, 0xf95757ae,
+    0xe85858b0, 0xeb5959b2, 0xee5a5ab4, 0xed5b5bb6,
+    0xe45c5cb8, 0xe75d5dba, 0xe25e5ebc, 0xe15f5fbe,
+    0xa06060c0, 0xa36161c2, 0xa66262c4, 0xa56363c6,
+    0xac6464c8, 0xaf6565ca, 0xaa6666cc, 0xa96767ce,
+    0xb86868d0, 0xbb6969d2, 0xbe6a6ad4, 0xbd6b6bd6,
+    0xb46c6cd8, 0xb76d6dda, 0xb26e6edc, 0xb16f6fde,
+    0x907070e0, 0x937171e2, 0x967272e4, 0x957373e6,
+    0x9c7474e8, 0x9f7575ea, 0x9a7676ec, 0x997777ee,
+    0x887878f0, 0x8b7979f2, 0x8e7a7af4, 0x8d7b7bf6,
+    0x847c7cf8, 0x877d7dfa, 0x827e7efc, 0x817f7ffe,
+    0x9b80801b, 0x98818119, 0x9d82821f, 0x9e83831d,
+    0x97848413, 0x94858511, 0x91868617, 0x92878715,
+    0x8388880b, 0x80898909, 0x858a8a0f, 0x868b8b0d,
+    0x8f8c8c03, 0x8c8d8d01, 0x898e8e07, 0x8a8f8f05,
+    0xab90903b, 0xa8919139, 0xad92923f, 0xae93933d,
+    0xa7949433, 0xa4959531, 0xa1969637, 0xa2979735,
+    0xb398982b, 0xb0999929, 0xb59a9a2f, 0xb69b9b2d,
+    0xbf9c9c23, 0xbc9d9d21, 0xb99e9e27, 0xba9f9f25,
+    0xfba0a05b, 0xf8a1a159, 0xfda2a25f, 0xfea3a35d,
+    0xf7a4a453, 0xf4a5a551, 0xf1a6a657, 0xf2a7a755,
+    0xe3a8a84b, 0xe0a9a949, 0xe5aaaa4f, 0xe6abab4d,
+    0xefacac43, 0xecadad41, 0xe9aeae47, 0xeaafaf45,
+    0xcbb0b07b, 0xc8b1b179, 0xcdb2b27f, 0xceb3b37d,
+    0xc7b4b473, 0xc4b5b571, 0xc1b6b677, 0xc2b7b775,
+    0xd3b8b86b, 0xd0b9b969, 0xd5baba6f, 0xd6bbbb6d,
+    0xdfbcbc63, 0xdcbdbd61, 0xd9bebe67, 0xdabfbf65,
+    0x5bc0c09b, 0x58c1c199, 0x5dc2c29f, 0x5ec3c39d,
+    0x57c4c493, 0x54c5c591, 0x51c6c697, 0x52c7c795,
+    0x43c8c88b, 0x40c9c989, 0x45caca8f, 0x46cbcb8d,
+    0x4fcccc83, 0x4ccdcd81, 0x49cece87, 0x4acfcf85,
+    0x6bd0d0bb, 0x68d1d1b9, 0x6dd2d2bf, 0x6ed3d3bd,
+    0x67d4d4b3, 0x64d5d5b1, 0x61d6d6b7, 0x62d7d7b5,
+    0x73d8d8ab, 0x70d9d9a9, 0x75dadaaf, 0x76dbdbad,
+    0x7fdcdca3, 0x7cdddda1, 0x79dedea7, 0x7adfdfa5,
+    0x3be0e0db, 0x38e1e1d9, 0x3de2e2df, 0x3ee3e3dd,
+    0x37e4e4d3, 0x34e5e5d1, 0x31e6e6d7, 0x32e7e7d5,
+    0x23e8e8cb, 0x20e9e9c9, 0x25eaeacf, 0x26ebebcd,
+    0x2fececc3, 0x2cededc1, 0x29eeeec7, 0x2aefefc5,
+    0x0bf0f0fb, 0x08f1f1f9, 0x0df2f2ff, 0x0ef3f3fd,
+    0x07f4f4f3, 0x04f5f5f1, 0x01f6f6f7, 0x02f7f7f5,
+    0x13f8f8eb, 0x10f9f9e9, 0x15fafaef, 0x16fbfbed,
+    0x1ffcfce3, 0x1cfdfde1, 0x19fefee7, 0x1affffe5,
+};
+
+/*
+ * Inverse MixColumns lookup table, for use with rot32.
+ */
+const uint32_t AES_imc_rot[256] = {
+    0x00000000, 0x0b0d090e, 0x161a121c, 0x1d171b12,
+    0x2c342438, 0x27392d36, 0x3a2e3624, 0x31233f2a,
+    0x58684870, 0x5365417e, 0x4e725a6c, 0x457f5362,
+    0x745c6c48, 0x7f516546, 0x62467e54, 0x694b775a,
+    0xb0d090e0, 0xbbdd99ee, 0xa6ca82fc, 0xadc78bf2,
+    0x9ce4b4d8, 0x97e9bdd6, 0x8afea6c4, 0x81f3afca,
+    0xe8b8d890, 0xe3b5d19e, 0xfea2ca8c, 0xf5afc382,
+    0xc48cfca8, 0xcf81f5a6, 0xd296eeb4, 0xd99be7ba,
+    0x7bbb3bdb, 0x70b632d5, 0x6da129c7, 0x66ac20c9,
+    0x578f1fe3, 0x5c8216ed, 0x41950dff, 0x4a9804f1,
+    0x23d373ab, 0x28de7aa5, 0x35c961b7, 0x3ec468b9,
+    0x0fe75793, 0x04ea5e9d, 0x19fd458f, 0x12f04c81,
+    0xcb6bab3b, 0xc066a235, 0xdd71b927, 0xd67cb029,
+    0xe75f8f03, 0xec52860d, 0xf1459d1f, 0xfa489411,
+    0x9303e34b, 0x980eea45, 0x8519f157, 0x8e14f859,
+    0xbf37c773, 0xb43ace7d, 0xa92dd56f, 0xa220dc61,
+    0xf66d76ad, 0xfd607fa3, 0xe07764b1, 0xeb7a6dbf,
+    0xda595295, 0xd1545b9b, 0xcc434089, 0xc74e4987,
+    0xae053edd, 0xa50837d3, 0xb81f2cc1, 0xb31225cf,
+    0x82311ae5, 0x893c13eb, 0x942b08f9, 0x9f2601f7,
+    0x46bde64d, 0x4db0ef43, 0x50a7f451, 0x5baafd5f,
+    0x6a89c275, 0x6184cb7b, 0x7c93d069, 0x779ed967,
+    0x1ed5ae3d, 0x15d8a733, 0x08cfbc21, 0x03c2b52f,
+    0x32e18a05, 0x39ec830b, 0x24fb9819, 0x2ff69117,
+    0x8dd64d76, 0x86db4478, 0x9bcc5f6a, 0x90c15664,
+    0xa1e2694e, 0xaaef6040, 0xb7f87b52, 0xbcf5725c,
+    0xd5be0506, 0xdeb30c08, 0xc3a4171a, 0xc8a91e14,
+    0xf98a213e, 0xf2872830, 0xef903322, 0xe49d3a2c,
+    0x3d06dd96, 0x360bd498, 0x2b1ccf8a, 0x2011c684,
+    0x1132f9ae, 0x1a3ff0a0, 0x0728ebb2, 0x0c25e2bc,
+    0x656e95e6, 0x6e639ce8, 0x737487fa, 0x78798ef4,
+    0x495ab1de, 0x4257b8d0, 0x5f40a3c2, 0x544daacc,
+    0xf7daec41, 0xfcd7e54f, 0xe1c0fe5d, 0xeacdf753,
+    0xdbeec879, 0xd0e3c177, 0xcdf4da65, 0xc6f9d36b,
+    0xafb2a431, 0xa4bfad3f, 0xb9a8b62d, 0xb2a5bf23,
+    0x83868009, 0x888b8907, 0x959c9215, 0x9e919b1b,
+    0x470a7ca1, 0x4c0775af, 0x51106ebd, 0x5a1d67b3,
+    0x6b3e5899, 0x60335197, 0x7d244a85, 0x7629438b,
+    0x1f6234d1, 0x146f3ddf, 0x097826cd, 0x02752fc3,
+    0x335610e9, 0x385b19e7, 0x254c02f5, 0x2e410bfb,
+    0x8c61d79a, 0x876cde94, 0x9a7bc586, 0x9176cc88,
+    0xa055f3a2, 0xab58faac, 0xb64fe1be, 0xbd42e8b0,
+    0xd4099fea, 0xdf0496e4, 0xc2138df6, 0xc91e84f8,
+    0xf83dbbd2, 0xf330b2dc, 0xee27a9ce, 0xe52aa0c0,
+    0x3cb1477a, 0x37bc4e74, 0x2aab5566, 0x21a65c68,
+    0x10856342, 0x1b886a4c, 0x069f715e, 0x0d927850,
+    0x64d90f0a, 0x6fd40604, 0x72c31d16, 0x79ce1418,
+    0x48ed2b32, 0x43e0223c, 0x5ef7392e, 0x55fa3020,
+    0x01b79aec, 0x0aba93e2, 0x17ad88f0, 0x1ca081fe,
+    0x2d83bed4, 0x268eb7da, 0x3b99acc8, 0x3094a5c6,
+    0x59dfd29c, 0x52d2db92, 0x4fc5c080, 0x44c8c98e,
+    0x75ebf6a4, 0x7ee6ffaa, 0x63f1e4b8, 0x68fcedb6,
+    0xb1670a0c, 0xba6a0302, 0xa77d1810, 0xac70111e,
+    0x9d532e34, 0x965e273a, 0x8b493c28, 0x80443526,
+    0xe90f427c, 0xe2024b72, 0xff155060, 0xf418596e,
+    0xc53b6644, 0xce366f4a, 0xd3217458, 0xd82c7d56,
+    0x7a0ca137, 0x7101a839, 0x6c16b32b, 0x671bba25,
+    0x5638850f, 0x5d358c01, 0x40229713, 0x4b2f9e1d,
+    0x2264e947, 0x2969e049, 0x347efb5b, 0x3f73f255,
+    0x0e50cd7f, 0x055dc471, 0x184adf63, 0x1347d66d,
+    0xcadc31d7, 0xc1d138d9, 0xdcc623cb, 0xd7cb2ac5,
+    0xe6e815ef, 0xede51ce1, 0xf0f207f3, 0xfbff0efd,
+    0x92b479a7, 0x99b970a9, 0x84ae6bbb, 0x8fa362b5,
+    0xbe805d9f, 0xb58d5491, 0xa89a4f83, 0xa397468d,
+};
+
 /* AES_imc[x][0] = [x].[0e, 09, 0d, 0b]; */
 /* AES_imc[x][1] = [x].[0b, 0e, 09, 0d]; */
 /* AES_imc[x][2] = [x].[0d, 0b, 0e, 09]; */
diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index d28690321f..06254939d2 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -80,149 +80,16 @@ void HELPER(crypto_aese)(void *vd, void *vn, void *vm, uint32_t desc)
 
 static void do_crypto_aesmc(uint64_t *rd, uint64_t *rm, bool decrypt)
 {
-    static uint32_t const mc[][256] = { {
-        /* MixColumns lookup table */
-        0x00000000, 0x03010102, 0x06020204, 0x05030306,
-        0x0c040408, 0x0f05050a, 0x0a06060c, 0x0907070e,
-        0x18080810, 0x1b090912, 0x1e0a0a14, 0x1d0b0b16,
-        0x140c0c18, 0x170d0d1a, 0x120e0e1c, 0x110f0f1e,
-        0x30101020, 0x33111122, 0x36121224, 0x35131326,
-        0x3c141428, 0x3f15152a, 0x3a16162c, 0x3917172e,
-        0x28181830, 0x2b191932, 0x2e1a1a34, 0x2d1b1b36,
-        0x241c1c38, 0x271d1d3a, 0x221e1e3c, 0x211f1f3e,
-        0x60202040, 0x63212142, 0x66222244, 0x65232346,
-        0x6c242448, 0x6f25254a, 0x6a26264c, 0x6927274e,
-        0x78282850, 0x7b292952, 0x7e2a2a54, 0x7d2b2b56,
-        0x742c2c58, 0x772d2d5a, 0x722e2e5c, 0x712f2f5e,
-        0x50303060, 0x53313162, 0x56323264, 0x55333366,
-        0x5c343468, 0x5f35356a, 0x5a36366c, 0x5937376e,
-        0x48383870, 0x4b393972, 0x4e3a3a74, 0x4d3b3b76,
-        0x443c3c78, 0x473d3d7a, 0x423e3e7c, 0x413f3f7e,
-        0xc0404080, 0xc3414182, 0xc6424284, 0xc5434386,
-        0xcc444488, 0xcf45458a, 0xca46468c, 0xc947478e,
-        0xd8484890, 0xdb494992, 0xde4a4a94, 0xdd4b4b96,
-        0xd44c4c98, 0xd74d4d9a, 0xd24e4e9c, 0xd14f4f9e,
-        0xf05050a0, 0xf35151a2, 0xf65252a4, 0xf55353a6,
-        0xfc5454a8, 0xff5555aa, 0xfa5656ac, 0xf95757ae,
-        0xe85858b0, 0xeb5959b2, 0xee5a5ab4, 0xed5b5bb6,
-        0xe45c5cb8, 0xe75d5dba, 0xe25e5ebc, 0xe15f5fbe,
-        0xa06060c0, 0xa36161c2, 0xa66262c4, 0xa56363c6,
-        0xac6464c8, 0xaf6565ca, 0xaa6666cc, 0xa96767ce,
-        0xb86868d0, 0xbb6969d2, 0xbe6a6ad4, 0xbd6b6bd6,
-        0xb46c6cd8, 0xb76d6dda, 0xb26e6edc, 0xb16f6fde,
-        0x907070e0, 0x937171e2, 0x967272e4, 0x957373e6,
-        0x9c7474e8, 0x9f7575ea, 0x9a7676ec, 0x997777ee,
-        0x887878f0, 0x8b7979f2, 0x8e7a7af4, 0x8d7b7bf6,
-        0x847c7cf8, 0x877d7dfa, 0x827e7efc, 0x817f7ffe,
-        0x9b80801b, 0x98818119, 0x9d82821f, 0x9e83831d,
-        0x97848413, 0x94858511, 0x91868617, 0x92878715,
-        0x8388880b, 0x80898909, 0x858a8a0f, 0x868b8b0d,
-        0x8f8c8c03, 0x8c8d8d01, 0x898e8e07, 0x8a8f8f05,
-        0xab90903b, 0xa8919139, 0xad92923f, 0xae93933d,
-        0xa7949433, 0xa4959531, 0xa1969637, 0xa2979735,
-        0xb398982b, 0xb0999929, 0xb59a9a2f, 0xb69b9b2d,
-        0xbf9c9c23, 0xbc9d9d21, 0xb99e9e27, 0xba9f9f25,
-        0xfba0a05b, 0xf8a1a159, 0xfda2a25f, 0xfea3a35d,
-        0xf7a4a453, 0xf4a5a551, 0xf1a6a657, 0xf2a7a755,
-        0xe3a8a84b, 0xe0a9a949, 0xe5aaaa4f, 0xe6abab4d,
-        0xefacac43, 0xecadad41, 0xe9aeae47, 0xeaafaf45,
-        0xcbb0b07b, 0xc8b1b179, 0xcdb2b27f, 0xceb3b37d,
-        0xc7b4b473, 0xc4b5b571, 0xc1b6b677, 0xc2b7b775,
-        0xd3b8b86b, 0xd0b9b969, 0xd5baba6f, 0xd6bbbb6d,
-        0xdfbcbc63, 0xdcbdbd61, 0xd9bebe67, 0xdabfbf65,
-        0x5bc0c09b, 0x58c1c199, 0x5dc2c29f, 0x5ec3c39d,
-        0x57c4c493, 0x54c5c591, 0x51c6c697, 0x52c7c795,
-        0x43c8c88b, 0x40c9c989, 0x45caca8f, 0x46cbcb8d,
-        0x4fcccc83, 0x4ccdcd81, 0x49cece87, 0x4acfcf85,
-        0x6bd0d0bb, 0x68d1d1b9, 0x6dd2d2bf, 0x6ed3d3bd,
-        0x67d4d4b3, 0x64d5d5b1, 0x61d6d6b7, 0x62d7d7b5,
-        0x73d8d8ab, 0x70d9d9a9, 0x75dadaaf, 0x76dbdbad,
-        0x7fdcdca3, 0x7cdddda1, 0x79dedea7, 0x7adfdfa5,
-        0x3be0e0db, 0x38e1e1d9, 0x3de2e2df, 0x3ee3e3dd,
-        0x37e4e4d3, 0x34e5e5d1, 0x31e6e6d7, 0x32e7e7d5,
-        0x23e8e8cb, 0x20e9e9c9, 0x25eaeacf, 0x26ebebcd,
-        0x2fececc3, 0x2cededc1, 0x29eeeec7, 0x2aefefc5,
-        0x0bf0f0fb, 0x08f1f1f9, 0x0df2f2ff, 0x0ef3f3fd,
-        0x07f4f4f3, 0x04f5f5f1, 0x01f6f6f7, 0x02f7f7f5,
-        0x13f8f8eb, 0x10f9f9e9, 0x15fafaef, 0x16fbfbed,
-        0x1ffcfce3, 0x1cfdfde1, 0x19fefee7, 0x1affffe5,
-    }, {
-        /* Inverse MixColumns lookup table */
-        0x00000000, 0x0b0d090e, 0x161a121c, 0x1d171b12,
-        0x2c342438, 0x27392d36, 0x3a2e3624, 0x31233f2a,
-        0x58684870, 0x5365417e, 0x4e725a6c, 0x457f5362,
-        0x745c6c48, 0x7f516546, 0x62467e54, 0x694b775a,
-        0xb0d090e0, 0xbbdd99ee, 0xa6ca82fc, 0xadc78bf2,
-        0x9ce4b4d8, 0x97e9bdd6, 0x8afea6c4, 0x81f3afca,
-        0xe8b8d890, 0xe3b5d19e, 0xfea2ca8c, 0xf5afc382,
-        0xc48cfca8, 0xcf81f5a6, 0xd296eeb4, 0xd99be7ba,
-        0x7bbb3bdb, 0x70b632d5, 0x6da129c7, 0x66ac20c9,
-        0x578f1fe3, 0x5c8216ed, 0x41950dff, 0x4a9804f1,
-        0x23d373ab, 0x28de7aa5, 0x35c961b7, 0x3ec468b9,
-        0x0fe75793, 0x04ea5e9d, 0x19fd458f, 0x12f04c81,
-        0xcb6bab3b, 0xc066a235, 0xdd71b927, 0xd67cb029,
-        0xe75f8f03, 0xec52860d, 0xf1459d1f, 0xfa489411,
-        0x9303e34b, 0x980eea45, 0x8519f157, 0x8e14f859,
-        0xbf37c773, 0xb43ace7d, 0xa92dd56f, 0xa220dc61,
-        0xf66d76ad, 0xfd607fa3, 0xe07764b1, 0xeb7a6dbf,
-        0xda595295, 0xd1545b9b, 0xcc434089, 0xc74e4987,
-        0xae053edd, 0xa50837d3, 0xb81f2cc1, 0xb31225cf,
-        0x82311ae5, 0x893c13eb, 0x942b08f9, 0x9f2601f7,
-        0x46bde64d, 0x4db0ef43, 0x50a7f451, 0x5baafd5f,
-        0x6a89c275, 0x6184cb7b, 0x7c93d069, 0x779ed967,
-        0x1ed5ae3d, 0x15d8a733, 0x08cfbc21, 0x03c2b52f,
-        0x32e18a05, 0x39ec830b, 0x24fb9819, 0x2ff69117,
-        0x8dd64d76, 0x86db4478, 0x9bcc5f6a, 0x90c15664,
-        0xa1e2694e, 0xaaef6040, 0xb7f87b52, 0xbcf5725c,
-        0xd5be0506, 0xdeb30c08, 0xc3a4171a, 0xc8a91e14,
-        0xf98a213e, 0xf2872830, 0xef903322, 0xe49d3a2c,
-        0x3d06dd96, 0x360bd498, 0x2b1ccf8a, 0x2011c684,
-        0x1132f9ae, 0x1a3ff0a0, 0x0728ebb2, 0x0c25e2bc,
-        0x656e95e6, 0x6e639ce8, 0x737487fa, 0x78798ef4,
-        0x495ab1de, 0x4257b8d0, 0x5f40a3c2, 0x544daacc,
-        0xf7daec41, 0xfcd7e54f, 0xe1c0fe5d, 0xeacdf753,
-        0xdbeec879, 0xd0e3c177, 0xcdf4da65, 0xc6f9d36b,
-        0xafb2a431, 0xa4bfad3f, 0xb9a8b62d, 0xb2a5bf23,
-        0x83868009, 0x888b8907, 0x959c9215, 0x9e919b1b,
-        0x470a7ca1, 0x4c0775af, 0x51106ebd, 0x5a1d67b3,
-        0x6b3e5899, 0x60335197, 0x7d244a85, 0x7629438b,
-        0x1f6234d1, 0x146f3ddf, 0x097826cd, 0x02752fc3,
-        0x335610e9, 0x385b19e7, 0x254c02f5, 0x2e410bfb,
-        0x8c61d79a, 0x876cde94, 0x9a7bc586, 0x9176cc88,
-        0xa055f3a2, 0xab58faac, 0xb64fe1be, 0xbd42e8b0,
-        0xd4099fea, 0xdf0496e4, 0xc2138df6, 0xc91e84f8,
-        0xf83dbbd2, 0xf330b2dc, 0xee27a9ce, 0xe52aa0c0,
-        0x3cb1477a, 0x37bc4e74, 0x2aab5566, 0x21a65c68,
-        0x10856342, 0x1b886a4c, 0x069f715e, 0x0d927850,
-        0x64d90f0a, 0x6fd40604, 0x72c31d16, 0x79ce1418,
-        0x48ed2b32, 0x43e0223c, 0x5ef7392e, 0x55fa3020,
-        0x01b79aec, 0x0aba93e2, 0x17ad88f0, 0x1ca081fe,
-        0x2d83bed4, 0x268eb7da, 0x3b99acc8, 0x3094a5c6,
-        0x59dfd29c, 0x52d2db92, 0x4fc5c080, 0x44c8c98e,
-        0x75ebf6a4, 0x7ee6ffaa, 0x63f1e4b8, 0x68fcedb6,
-        0xb1670a0c, 0xba6a0302, 0xa77d1810, 0xac70111e,
-        0x9d532e34, 0x965e273a, 0x8b493c28, 0x80443526,
-        0xe90f427c, 0xe2024b72, 0xff155060, 0xf418596e,
-        0xc53b6644, 0xce366f4a, 0xd3217458, 0xd82c7d56,
-        0x7a0ca137, 0x7101a839, 0x6c16b32b, 0x671bba25,
-        0x5638850f, 0x5d358c01, 0x40229713, 0x4b2f9e1d,
-        0x2264e947, 0x2969e049, 0x347efb5b, 0x3f73f255,
-        0x0e50cd7f, 0x055dc471, 0x184adf63, 0x1347d66d,
-        0xcadc31d7, 0xc1d138d9, 0xdcc623cb, 0xd7cb2ac5,
-        0xe6e815ef, 0xede51ce1, 0xf0f207f3, 0xfbff0efd,
-        0x92b479a7, 0x99b970a9, 0x84ae6bbb, 0x8fa362b5,
-        0xbe805d9f, 0xb58d5491, 0xa89a4f83, 0xa397468d,
-    } };
-
     union CRYPTO_STATE st = { .l = { rm[0], rm[1] } };
+    const uint32_t *mc = decrypt ? AES_imc_rot : AES_mc_rot;
     int i;
 
     for (i = 0; i < 16; i += 4) {
         CR_ST_WORD(st, i >> 2) =
-            mc[decrypt][CR_ST_BYTE(st, i)] ^
-            rol32(mc[decrypt][CR_ST_BYTE(st, i + 1)], 8) ^
-            rol32(mc[decrypt][CR_ST_BYTE(st, i + 2)], 16) ^
-            rol32(mc[decrypt][CR_ST_BYTE(st, i + 3)], 24);
+            mc[CR_ST_BYTE(st, i)] ^
+            rol32(mc[CR_ST_BYTE(st, i + 1)], 8) ^
+            rol32(mc[CR_ST_BYTE(st, i + 2)], 16) ^
+            rol32(mc[CR_ST_BYTE(st, i + 3)], 24);
     }
 
     rd[0] = st.l[0];
-- 
2.34.1



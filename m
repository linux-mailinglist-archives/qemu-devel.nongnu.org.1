Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFA374C724
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:34:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEF-0005Jb-Vg; Sun, 09 Jul 2023 14:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDz-0003aF-T1
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:35 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDx-0004H1-T2
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc244d384so38097945e9.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927612; x=1691519612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UNvrPJBGJx5dGrfGxip7sDDn/+xiNFreEIZcy5LuLWI=;
 b=tWw1yDr184gNGbHwm5grNX7bEX6MfUXs9/p9iqJGvW3lz972IUH9JKjCgGN66O/cx0
 nZe6TWtt+lhMpU26GDt/gftrlSdT+pkrPStCYTbOiUYNeyBVn///o69CheonPMTeljdY
 b0L6K+f1RZyv3brTmOJYku4lFUzWWlDOh9eg3V+s62gOjxkW/chKe7O+YK+A1blyxx06
 pddD4bUnzEonYtKVz0+EqWssMoPe7SsPGnXlouuVa6F1eIwkPme+wwY1Y8ZTqnDW5GQH
 p9LZThqdsQPDG2/c3gyFVZ0i/eYVXP7rGNoQPGhVK6D48/sxi4EYFlfLzgcggJU3s77N
 ggZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927612; x=1691519612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UNvrPJBGJx5dGrfGxip7sDDn/+xiNFreEIZcy5LuLWI=;
 b=TqJcwprWDwKjqSvTPVSjPKurDD9QQmrwO18idsJZBO/Wfqwh+DGJErhSWvxxXQPJXY
 aloWBhNwKM54YZkBLFyW2u4phf1d/zLXBfKTb8dEs/dOb2NzDqdmg3dwiCZI4GkU0HBL
 AdvtJ6jYFyqL/Lm3mzvk3HCQPiVxDmxGUKISzOgsG/b95s3CA2IvddvvxJCK1iRQEHxx
 tc2524Us6t45FesapTmwalVdBRDpSFST/fijJVnum5O1mkPUXrHD7vpQJSw+53bCB084
 ov758089t26rs3ojLHbVBeR5bZ7YkCEl0lC/MZKPprONqxjz4YdocRiri83LclRKHkxD
 Lxsg==
X-Gm-Message-State: ABy/qLZMmR9LCEfw2H6X7bt8agtIVGi0vkXkd3nSK5eWAZCgla3kIQ7x
 VYSaSW7hXc6zqtqKB/M9cDvk4ywHImoZnW74ScVXtg==
X-Google-Smtp-Source: APBJJlGZdIFgtU/4UC0PLsVVf+IQKkKqxBlOX8PLFEDzad6iaJWA/V/CiSQFmWPkNquP+9S+EFQRhw==
X-Received: by 2002:adf:ee4a:0:b0:314:11d7:c919 with SMTP id
 w10-20020adfee4a000000b0031411d7c919mr8866085wro.49.1688927612628; 
 Sun, 09 Jul 2023 11:33:32 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/37] target/riscv: Use aesdec_ISB_ISR_IMC_AK
Date: Sun,  9 Jul 2023 19:29:18 +0100
Message-Id: <20230709182934.309468-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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

This implements the AES64DSM instruction.  This was the last use
of aes64_operation and its support macros, so remove them all.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/crypto_helper.c | 101 ++++-------------------------------
 1 file changed, 10 insertions(+), 91 deletions(-)

diff --git a/target/riscv/crypto_helper.c b/target/riscv/crypto_helper.c
index c036fe8632..99d85a6188 100644
--- a/target/riscv/crypto_helper.c
+++ b/target/riscv/crypto_helper.c
@@ -104,98 +104,8 @@ target_ulong HELPER(aes32dsi)(target_ulong rs1, target_ulong rs2,
     return aes32_operation(shamt, rs1, rs2, false, false);
 }
 
-#define BY(X, I) ((X >> (8 * I)) & 0xFF)
-
-#define AES_SHIFROWS_LO(RS1, RS2) ( \
-    (((RS1 >> 24) & 0xFF) << 56) | (((RS2 >> 48) & 0xFF) << 48) | \
-    (((RS2 >> 8) & 0xFF) << 40) | (((RS1 >> 32) & 0xFF) << 32) | \
-    (((RS2 >> 56) & 0xFF) << 24) | (((RS2 >> 16) & 0xFF) << 16) | \
-    (((RS1 >> 40) & 0xFF) << 8) | (((RS1 >> 0) & 0xFF) << 0))
-
-#define AES_INVSHIFROWS_LO(RS1, RS2) ( \
-    (((RS2 >> 24) & 0xFF) << 56) | (((RS2 >> 48) & 0xFF) << 48) | \
-    (((RS1 >> 8) & 0xFF) << 40) | (((RS1 >> 32) & 0xFF) << 32) | \
-    (((RS1 >> 56) & 0xFF) << 24) | (((RS2 >> 16) & 0xFF) << 16) | \
-    (((RS2 >> 40) & 0xFF) << 8) | (((RS1 >> 0) & 0xFF) << 0))
-
-#define AES_MIXBYTE(COL, B0, B1, B2, B3) ( \
-    BY(COL, B3) ^ BY(COL, B2) ^ AES_GFMUL(BY(COL, B1), 3) ^ \
-    AES_GFMUL(BY(COL, B0), 2))
-
-#define AES_MIXCOLUMN(COL) ( \
-    AES_MIXBYTE(COL, 3, 0, 1, 2) << 24 | \
-    AES_MIXBYTE(COL, 2, 3, 0, 1) << 16 | \
-    AES_MIXBYTE(COL, 1, 2, 3, 0) << 8 | AES_MIXBYTE(COL, 0, 1, 2, 3) << 0)
-
-#define AES_INVMIXBYTE(COL, B0, B1, B2, B3) ( \
-    AES_GFMUL(BY(COL, B3), 0x9) ^ AES_GFMUL(BY(COL, B2), 0xd) ^ \
-    AES_GFMUL(BY(COL, B1), 0xb) ^ AES_GFMUL(BY(COL, B0), 0xe))
-
-#define AES_INVMIXCOLUMN(COL) ( \
-    AES_INVMIXBYTE(COL, 3, 0, 1, 2) << 24 | \
-    AES_INVMIXBYTE(COL, 2, 3, 0, 1) << 16 | \
-    AES_INVMIXBYTE(COL, 1, 2, 3, 0) << 8 | \
-    AES_INVMIXBYTE(COL, 0, 1, 2, 3) << 0)
-
 static const AESState aes_zero = { };
 
-static inline target_ulong aes64_operation(target_ulong rs1, target_ulong rs2,
-                                           bool enc, bool mix)
-{
-    uint64_t RS1 = rs1;
-    uint64_t RS2 = rs2;
-    uint64_t result;
-    uint64_t temp;
-    uint32_t col_0;
-    uint32_t col_1;
-
-    if (enc) {
-        temp = AES_SHIFROWS_LO(RS1, RS2);
-        temp = (((uint64_t)AES_sbox[(temp >> 0) & 0xFF] << 0) |
-                ((uint64_t)AES_sbox[(temp >> 8) & 0xFF] << 8) |
-                ((uint64_t)AES_sbox[(temp >> 16) & 0xFF] << 16) |
-                ((uint64_t)AES_sbox[(temp >> 24) & 0xFF] << 24) |
-                ((uint64_t)AES_sbox[(temp >> 32) & 0xFF] << 32) |
-                ((uint64_t)AES_sbox[(temp >> 40) & 0xFF] << 40) |
-                ((uint64_t)AES_sbox[(temp >> 48) & 0xFF] << 48) |
-                ((uint64_t)AES_sbox[(temp >> 56) & 0xFF] << 56));
-        if (mix) {
-            col_0 = temp & 0xFFFFFFFF;
-            col_1 = temp >> 32;
-
-            col_0 = AES_MIXCOLUMN(col_0);
-            col_1 = AES_MIXCOLUMN(col_1);
-
-            result = ((uint64_t)col_1 << 32) | col_0;
-        } else {
-            result = temp;
-        }
-    } else {
-        temp = AES_INVSHIFROWS_LO(RS1, RS2);
-        temp = (((uint64_t)AES_isbox[(temp >> 0) & 0xFF] << 0) |
-                ((uint64_t)AES_isbox[(temp >> 8) & 0xFF] << 8) |
-                ((uint64_t)AES_isbox[(temp >> 16) & 0xFF] << 16) |
-                ((uint64_t)AES_isbox[(temp >> 24) & 0xFF] << 24) |
-                ((uint64_t)AES_isbox[(temp >> 32) & 0xFF] << 32) |
-                ((uint64_t)AES_isbox[(temp >> 40) & 0xFF] << 40) |
-                ((uint64_t)AES_isbox[(temp >> 48) & 0xFF] << 48) |
-                ((uint64_t)AES_isbox[(temp >> 56) & 0xFF] << 56));
-        if (mix) {
-            col_0 = temp & 0xFFFFFFFF;
-            col_1 = temp >> 32;
-
-            col_0 = AES_INVMIXCOLUMN(col_0);
-            col_1 = AES_INVMIXCOLUMN(col_1);
-
-            result = ((uint64_t)col_1 << 32) | col_0;
-        } else {
-            result = temp;
-        }
-    }
-
-    return result;
-}
-
 target_ulong HELPER(aes64esm)(target_ulong rs1, target_ulong rs2)
 {
     AESState t;
@@ -228,7 +138,16 @@ target_ulong HELPER(aes64ds)(target_ulong rs1, target_ulong rs2)
 
 target_ulong HELPER(aes64dsm)(target_ulong rs1, target_ulong rs2)
 {
-    return aes64_operation(rs1, rs2, false, true);
+    AESState t, z = { };
+
+    /*
+     * This instruction does not include a round key,
+     * so supply a zero to our primitive.
+     */
+    t.d[HOST_BIG_ENDIAN] = rs1;
+    t.d[!HOST_BIG_ENDIAN] = rs2;
+    aesdec_ISB_ISR_IMC_AK(&t, &t, &z, false);
+    return t.d[HOST_BIG_ENDIAN];
 }
 
 target_ulong HELPER(aes64ks2)(target_ulong rs1, target_ulong rs2)
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0BF74C725
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:34:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZEB-0004ak-Ae; Sun, 09 Jul 2023 14:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZE1-0003fr-9s
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:38 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDz-0004Hn-Mu
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:37 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-313fb7f0f80so3705621f8f.2
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927614; x=1691519614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LO6Chl8aQYLOaHq+kw102b8WCIYofNouZUqxF+V9shk=;
 b=YUquXa/bAZ/dDSgopJMyVJK4PI5dw/yTfgXIQr7FcTnqAXPegY+ZqIUMXVXi1NumoK
 wBoVhjMxCesXNJ2iUhBQbvECh73CY3U1P4gc8Dw79xBboDIE9ZBiDqyAqZ+3NZbVnQMz
 JzCqGcK2/0WAdTeGfRb1CQ2SjFjSlmSQjbXMb9iXbx7rCWnlxYiwYODOHWG8qRcIF0wm
 JtWFDCI7ke0G5UmDKShKkkv+JZcia2sZrMBhNALBvN4w10OCqhD2o+pQjFevNqK7F0Ab
 KeiR33tg5WNvVgi/ezf10PPm39bsZX/9PmJugMnHzZluhdP8pUbdwsV5hzJz/DiJV26j
 y/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927614; x=1691519614;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LO6Chl8aQYLOaHq+kw102b8WCIYofNouZUqxF+V9shk=;
 b=dO1rKYlppjmzO3D0wnHHXAWDJ/ohAWVG/0F8vSVx3IeSXiTdgftSkJLo0odwOkYXSn
 x3DmN5y3aO58EGuSjir13cdWIExM+1jDXMrV4l7Ujubg3QySVUn01JniqYX+UaVQaZ8H
 Yi6/F0zu9847cuJ1Y9LmSW0L8p5FE964dVHIkzKgOdpIN39DlNZ3KtETNH31jreDaiy6
 Z8LkaZmgumEHdkRt00RilRboKxJvBffcVzF8m6AC8u2ecZiTt1mbw8qByThSfokoLjiA
 uz6kA1kps21V4jHC6UERsOp4JIecsrvnWJ5N0GX2mM27x0Iij1FMfeb/sqw+CsJRivKT
 /WZA==
X-Gm-Message-State: ABy/qLaaqYveHH9eMdLHSiDgkL0aCjHKFSUxeszNqNei3HGtUdBiLnv5
 wxUkOYbrogy5pct07oSUSP44PDAtTd//mUhP3TFMoQ==
X-Google-Smtp-Source: APBJJlFPPPAbjvXgjiD/LU1+OqRWDnjqsd3ZyPh45leyHL/RazZvVaU7Rv/VhGe+dFUUApxIJKbK1Q==
X-Received: by 2002:a5d:528e:0:b0:30f:ca58:a00d with SMTP id
 c14-20020a5d528e000000b0030fca58a00dmr7873346wrv.45.1688927614386; 
 Sun, 09 Jul 2023 11:33:34 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 34/37] crypto: Remove AES_shifts, AES_ishifts
Date: Sun,  9 Jul 2023 19:29:20 +0100
Message-Id: <20230709182934.309468-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x431.google.com
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

These arrays are no longer used, replaced by AES_SH_*, AES_ISH_*.

Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/crypto/aes.h |  4 ----
 crypto/aes.c         | 14 --------------
 2 files changed, 18 deletions(-)

diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index 24b073d569..aa8b54065d 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -30,10 +30,6 @@ void AES_decrypt(const unsigned char *in, unsigned char *out,
 extern const uint8_t AES_sbox[256];
 extern const uint8_t AES_isbox[256];
 
-/* AES ShiftRows and InvShiftRows */
-extern const uint8_t AES_shifts[16];
-extern const uint8_t AES_ishifts[16];
-
 /* AES MixColumns, for use with rot32. */
 extern const uint32_t AES_mc_rot[256];
 
diff --git a/crypto/aes.c b/crypto/aes.c
index c765f11c1e..00e16d3f92 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -114,23 +114,9 @@ const uint8_t AES_isbox[256] = {
 /* AES ShiftRows, for complete unrolling. */
 #define AES_SH(X)   (((X) * 5) & 15)
 
-const uint8_t AES_shifts[16] = {
-    AES_SH(0x0), AES_SH(0x1), AES_SH(0x2), AES_SH(0x3),
-    AES_SH(0x4), AES_SH(0x5), AES_SH(0x6), AES_SH(0x7),
-    AES_SH(0x8), AES_SH(0x9), AES_SH(0xA), AES_SH(0xB),
-    AES_SH(0xC), AES_SH(0xD), AES_SH(0xE), AES_SH(0xF),
-};
-
 /* AES InvShiftRows, for complete unrolling. */
 #define AES_ISH(X)  (((X) * 13) & 15)
 
-const uint8_t AES_ishifts[16] = {
-    AES_ISH(0x0), AES_ISH(0x1), AES_ISH(0x2), AES_ISH(0x3),
-    AES_ISH(0x4), AES_ISH(0x5), AES_ISH(0x6), AES_ISH(0x7),
-    AES_ISH(0x8), AES_ISH(0x9), AES_ISH(0xA), AES_ISH(0xB),
-    AES_ISH(0xC), AES_ISH(0xD), AES_ISH(0xE), AES_ISH(0xF),
-};
-
 /*
  * MixColumns lookup table, for use with rot32.
  */
-- 
2.34.1



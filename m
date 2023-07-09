Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB6474C47D
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 16:01:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIUxB-0000L6-Sk; Sun, 09 Jul 2023 09:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUx9-0000Fa-EO
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 09:59:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIUx7-0000Mc-9g
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 09:59:55 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3144bf65ce9so3656608f8f.3
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688911191; x=1691503191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gLgfXZyf9aATX9TfQItUdKukGg6cdQDyWQ8EagJh33A=;
 b=RXcbdHlpK9Er6yTyJfRDGUnb17ZmAkVa3t3W6p3t8wTuAypGbqegPgPyaDnKvh0uyx
 hK/QC5NAoUqheeEdO6coEbF0UbfAN18aXOzopDRHRJTuVHc9uSGJ8DMfMWW3iAgtusyn
 4GFa9MSOD22v2J17/I3s+OnJWI2fyhLCPs1koVLKvMCFiPiH+syeJWtLIGcrb41gAAoq
 gVvJpwEggInGAYeXWxPZ7gAKaikJcq1VB1AJL7uPNjbhpkr/s1Yu6kiJ0BUGrPNDdvGr
 zRlo9JC8hkKDLpaKzOTkkEhJLo+uAnkT036CIKAqLSpy2b0HJ8MZTejvveLUsGO2mTAc
 VKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688911191; x=1691503191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gLgfXZyf9aATX9TfQItUdKukGg6cdQDyWQ8EagJh33A=;
 b=BXlJITHDOT65Vk2+p4W+BvEjBXHDrBMIiZh88gwa72c1D7UnIMOt7GrIobmULPjPfW
 Kcquir1voDWrAF8HF9rG7p6rEdl3QgiwzmIYS/sTePv9g5db1bZBp5fk5+0w7parEpiy
 Gba42fnoV+6aeR0eR7fQD8nFJxSwzTTJiXwECRtmws/XyFcXQCjpJuECQKA+hCViBpmu
 mcrMkVIuytX1Ro+h4mRHO3p4RxjE9iAR6oBrBwc0NkxBpGd+OLvfL972YFsKyUaiF2M/
 QRV8QJGXchuC6PEKiiCWo/6ID7sal4rsIaqQ8sBKhp88k+lx3BctWcTw/h+N878Np22i
 QdNg==
X-Gm-Message-State: ABy/qLbxDE66LemnbtuM2LiiB1llv9jVZ4tWaQsQnFWA475UGaIMnRau
 Uvx6Cfsboe3L9ZxFwnsNizN3LsUjsEDaY5sTzpuK9A==
X-Google-Smtp-Source: APBJJlGA711fuM+6/RkOAFdjV/IMk21ci+H67mNk0w1I9Pnmhe8ruUpeliA9BUywsqirBiRYGYBNaA==
X-Received: by 2002:a5d:66c9:0:b0:313:f990:c631 with SMTP id
 k9-20020a5d66c9000000b00313f990c631mr8340848wrw.44.1688911190964; 
 Sun, 09 Jul 2023 06:59:50 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 v18-20020a5d6792000000b003063a92bbf5sm9239422wru.70.2023.07.09.06.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 06:59:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/37] crypto/aes: Add AES_SH, AES_ISH macros
Date: Sun,  9 Jul 2023 14:59:12 +0100
Message-Id: <20230709135945.250311-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709135945.250311-1-richard.henderson@linaro.org>
References: <20230709135945.250311-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

These macros will constant fold and avoid the indirection through
memory when fully unrolling some new primitives.

Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/aes.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/crypto/aes.c b/crypto/aes.c
index 67bb74b8e3..e65c97e0c1 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -108,12 +108,24 @@ const uint8_t AES_isbox[256] = {
     0xE1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0C, 0x7D,
 };
 
+/* AES ShiftRows, for complete unrolling. */
+#define AES_SH(X)   (((X) * 5) & 15)
+
 const uint8_t AES_shifts[16] = {
-    0, 5, 10, 15, 4, 9, 14, 3, 8, 13, 2, 7, 12, 1, 6, 11
+    AES_SH(0x0), AES_SH(0x1), AES_SH(0x2), AES_SH(0x3),
+    AES_SH(0x4), AES_SH(0x5), AES_SH(0x6), AES_SH(0x7),
+    AES_SH(0x8), AES_SH(0x9), AES_SH(0xA), AES_SH(0xB),
+    AES_SH(0xC), AES_SH(0xD), AES_SH(0xE), AES_SH(0xF),
 };
 
+/* AES InvShiftRows, for complete unrolling. */
+#define AES_ISH(X)  (((X) * 13) & 15)
+
 const uint8_t AES_ishifts[16] = {
-    0, 13, 10, 7, 4, 1, 14, 11, 8, 5, 2, 15, 12, 9, 6, 3
+    AES_ISH(0x0), AES_ISH(0x1), AES_ISH(0x2), AES_ISH(0x3),
+    AES_ISH(0x4), AES_ISH(0x5), AES_ISH(0x6), AES_ISH(0x7),
+    AES_ISH(0x8), AES_ISH(0x9), AES_ISH(0xA), AES_ISH(0xB),
+    AES_ISH(0xC), AES_ISH(0xD), AES_ISH(0xE), AES_ISH(0xF),
 };
 
 /*
-- 
2.34.1



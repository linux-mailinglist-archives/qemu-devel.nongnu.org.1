Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA3D7459C4
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:11:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGSt-0005OR-Cr; Mon, 03 Jul 2023 06:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRp-0003Cl-8o
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qGGRU-0005zw-6j
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 06:06:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbc54caad5so35868595e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 03:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688378757; x=1690970757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LO6Chl8aQYLOaHq+kw102b8WCIYofNouZUqxF+V9shk=;
 b=Wfoj7yBvoE2rJiaUip7aBTpzIk5X8EPJzvFr5SdfrtuOrbdaeKRFsVVP3QF6HhXIyB
 Qu1xnx8xtXPVvKAF2KQ3Iy+iOkv/q6mP4EmBKk5mJfaf5mgdfGexmNYusfCnl6r/dCSR
 8JAp7gR6lxrfuJnwstFCnbe8F4Utnrj+O5M26Y/2Enh2r9V89BO8ThgockIqvf9Sfy02
 tp+sOJMcG5EwJHhaVU7lDKOWpymMwxrj/rD+iHHRW4OgiCWc6jCTRq9ZyI4fegHAH2sl
 1LF9mBIvD7TaN9MbuieG/oTH2PcjlaMKC0DL3usNsZ2p5Au93viQYW9FpAl/0kzaBEum
 p4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378757; x=1690970757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LO6Chl8aQYLOaHq+kw102b8WCIYofNouZUqxF+V9shk=;
 b=MVzjKC1a/CsuEcxjKyP42uwliF/cLzDYR8ZWJRrpX1IZOczSGb/n3okyhvMF1vpF9Q
 ek5Dm4ur4VSh+DC7J8GDtNhliCL7OfNcUnRRXVQeElIMRe2DkaDRSe0EEGMgVlCzZ+80
 dIpmMi/teObOTBXbuvCpCK+1hiShmGS7tM8/uosZrKOLasD+cVjLFanv8EjQD/MRFFos
 x1l60hzWyrHupi74+O60gKUVmPZJvKxDwLJE818i5mIhBYfJf4SloXrRnhKM3DIwsd/M
 s/mjGYo5wfaLY/toKrBVLwz0U/yBpmNiBGhFwHf4EXKroGACEngerXfK/Hsk3yuFIWuF
 KNjA==
X-Gm-Message-State: AC+VfDzVMC6OCKYy/GWBhe2H5GW0i0kwTaKUwYYh9ezU+QuyhLoikT9r
 ssu+DfMU10ay5xtshcIm1gAGUbwOqNILYS4kCBICkA==
X-Google-Smtp-Source: ACHHUZ5DLiGqROsPlg5CaaKoUVLHiEOqYbSPc0Q8fauPGnMxlfLK/nH9WXTPVG+3qAMqtOmUOyLcTw==
X-Received: by 2002:a05:600c:22da:b0:3fb:31b:d516 with SMTP id
 26-20020a05600c22da00b003fb031bd516mr7612148wmg.29.1688378757576; 
 Mon, 03 Jul 2023 03:05:57 -0700 (PDT)
Received: from stoup.home (91.232.79.188.dynamic.jazztel.es. [188.79.232.91])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a05600001c500b00313f7b077fesm18446562wrx.59.2023.07.03.03.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 03:05:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 eduardo@habkost.net, alistair.francis@wdc.com, danielhb413@gmail.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 34/37] crypto: Remove AES_shifts, AES_ishifts
Date: Mon,  3 Jul 2023 12:05:17 +0200
Message-Id: <20230703100520.68224-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230703100520.68224-1-richard.henderson@linaro.org>
References: <20230703100520.68224-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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



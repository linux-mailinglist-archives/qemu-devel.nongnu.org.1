Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAAE720D6F
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 04:40:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5H7p-00045T-2w; Fri, 02 Jun 2023 22:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6z-0000vG-N7
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:35:27 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5H6Z-0004hU-4Q
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 22:35:25 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5585f2f070bso1976148eaf.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 19:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685759698; x=1688351698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mv65yNQBKfmXk/1RwKfHXFoTLsAO9uOSejtwcDxftk=;
 b=xFjVBowNsUokOTOx0vKDL21/yd7TvEYnuulS2RLvbeWbtteiUgQDR3Gvwlbb+LgiKE
 7QK+3Q2eHM0/o9/Vpb06aexLd6GzW93iOPnjIgnCaWNy92mCZ0AFqOoztavJlztTTO32
 2jyXUSwgSPIpaUJLfSnChosuoRnkS6HBMQpLi4F6DQLRoH4JRGWx7xYjR6QQIu6+rrLd
 1iL9GMAx1MxzWKb/nmsxksP928Rk/5J8kynkv8punKQzX3OGlBHOqPvhplnzsjRpj1Wx
 uz9LQNPGC6XfNy7Ndsj8tyI/uKd2WPbB31O2ydwquAgOPmNhiG6OXwN3lHL+g4jUhEX4
 TIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685759698; x=1688351698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1mv65yNQBKfmXk/1RwKfHXFoTLsAO9uOSejtwcDxftk=;
 b=F+fbtyXvoLCbt4rHgi3uFhggGBI+FzGoJw9w5k9er1Uj3lHNcbpvf0eI1UTsGfoOpn
 0LKjYla4i70bA7GfiG4bG6F5Rd5Lo+YqA89GJ/BRAxZyFg59Cym+xHsUzxuhYY0tJuyd
 I1DWRGK5JlZ+/S0RRFNyG8823iBcR571fYLdVceSNUDrPyAlVEh7h8V2A8TVIw275BNu
 H7oE+Oirjos2NHp7F6MjorUFJC3+LlEDF1ax82fHJdD+m8txETeLd6EX306bURwZxf+l
 pxlF1GausmJSPsNrCPUtA32TrQC6AesXBVjOJzf9y+iw40c4SxC6HJvIXYc6wLJaoaaD
 JxHQ==
X-Gm-Message-State: AC+VfDwKSaZ41gArV0cj6r8crXCx9M5LH/ELDLJ58sBBg/RF/jJk9My8
 JzZlQEyf7xpxCOjXiCGi/xIunQqGL+gSHXHlZvY=
X-Google-Smtp-Source: ACHHUZ6b7rPsIc0Xsuz9ezjJe35Jlwoys51qYU7deD6jVYX6rmFU285siak+YOvgmmxMaMzor1Eq0w==
X-Received: by 2002:a05:6358:e497:b0:123:1637:45d1 with SMTP id
 by23-20020a056358e49700b00123163745d1mr13082108rwb.14.1685759698318; 
 Fri, 02 Jun 2023 19:34:58 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:66a6:82c2:d794:68f6])
 by smtp.gmail.com with ESMTPSA id
 e91-20020a17090a6fe400b002508d73f4e8sm3914289pjk.57.2023.06.02.19.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jun 2023 19:34:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ardb@kernel.org, berrange@redhat.com, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com
Subject: [PATCH 33/35] crypto: Implement aesdec_IMC with AES_imc_rot
Date: Fri,  2 Jun 2023 19:34:24 -0700
Message-Id: <20230603023426.1064431-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603023426.1064431-1-richard.henderson@linaro.org>
References: <20230603023426.1064431-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

This method uses one uint32_t * 256 table instead of 4,
which means its data cache overhead is less.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/aes.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/crypto/aes.c b/crypto/aes.c
index 4438d4dcdc..914ccf38ef 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -1453,39 +1453,38 @@ aesdec_IMC_swap(AESState *r, const AESState *st, bool swap)
     bool be = HOST_BIG_ENDIAN ^ swap;
     uint32_t t;
 
-    /* Note that AES_imc is encoded for big-endian. */
-    t = (AES_imc[st->b[swap_b ^ 0x0]][0] ^
-         AES_imc[st->b[swap_b ^ 0x1]][1] ^
-         AES_imc[st->b[swap_b ^ 0x2]][2] ^
-         AES_imc[st->b[swap_b ^ 0x3]][3]);
-    if (!be) {
+    t = (      AES_imc_rot[st->b[swap_b ^ 0x0]] ^
+         rol32(AES_imc_rot[st->b[swap_b ^ 0x1]], 8) ^
+         rol32(AES_imc_rot[st->b[swap_b ^ 0x2]], 16) ^
+         rol32(AES_imc_rot[st->b[swap_b ^ 0x3]], 24));
+    if (be) {
         t = bswap32(t);
     }
     r->w[swap_w ^ 0] = t;
 
-    t = (AES_imc[st->b[swap_b ^ 0x4]][0] ^
-         AES_imc[st->b[swap_b ^ 0x5]][1] ^
-         AES_imc[st->b[swap_b ^ 0x6]][2] ^
-         AES_imc[st->b[swap_b ^ 0x7]][3]);
-    if (!be) {
+    t = (      AES_imc_rot[st->b[swap_b ^ 0x4]] ^
+         rol32(AES_imc_rot[st->b[swap_b ^ 0x5]], 8) ^
+         rol32(AES_imc_rot[st->b[swap_b ^ 0x6]], 16) ^
+         rol32(AES_imc_rot[st->b[swap_b ^ 0x7]], 24));
+    if (be) {
         t = bswap32(t);
     }
     r->w[swap_w ^ 1] = t;
 
-    t = (AES_imc[st->b[swap_b ^ 0x8]][0] ^
-         AES_imc[st->b[swap_b ^ 0x9]][1] ^
-         AES_imc[st->b[swap_b ^ 0xA]][2] ^
-         AES_imc[st->b[swap_b ^ 0xB]][3]);
-    if (!be) {
+    t = (      AES_imc_rot[st->b[swap_b ^ 0x8]] ^
+         rol32(AES_imc_rot[st->b[swap_b ^ 0x9]], 8) ^
+         rol32(AES_imc_rot[st->b[swap_b ^ 0xA]], 16) ^
+         rol32(AES_imc_rot[st->b[swap_b ^ 0xB]], 24));
+    if (be) {
         t = bswap32(t);
     }
     r->w[swap_w ^ 2] = t;
 
-    t = (AES_imc[st->b[swap_b ^ 0xC]][0] ^
-         AES_imc[st->b[swap_b ^ 0xD]][1] ^
-         AES_imc[st->b[swap_b ^ 0xE]][2] ^
-         AES_imc[st->b[swap_b ^ 0xF]][3]);
-    if (!be) {
+    t = (      AES_imc_rot[st->b[swap_b ^ 0xC]] ^
+         rol32(AES_imc_rot[st->b[swap_b ^ 0xD]], 8) ^
+         rol32(AES_imc_rot[st->b[swap_b ^ 0xE]], 16) ^
+         rol32(AES_imc_rot[st->b[swap_b ^ 0xF]], 24));
+    if (be) {
         t = bswap32(t);
     }
     r->w[swap_w ^ 3] = t;
-- 
2.34.1



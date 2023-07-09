Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA94B74C74D
	for <lists+qemu-devel@lfdr.de>; Sun,  9 Jul 2023 20:40:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIZE9-0004Ls-Cj; Sun, 09 Jul 2023 14:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDs-0003WP-EI
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:33 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIZDp-0004Dv-1X
 for qemu-devel@nongnu.org; Sun, 09 Jul 2023 14:33:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbdfda88f4so37720685e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Jul 2023 11:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688927603; x=1691519603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8HOx1ZLKzsBUTcaboEy/mBqeLFtnDXaBWlHTAqwIG7M=;
 b=bC7HqoJUdK/9jTD+nPvdkdjxFlWyq7W3M3OKwNVoT1egDBw1IvPhgHPcZiXgMoTZEl
 yFptIoshhgvv11Z8HHJyPI2tDkFJuD2Ysg+6qi1CJAtpPOcdU04bBvJs9yIWDqHlXeGz
 Aiyx7vu1PCCSYvjDkEuPpTEvjJt7H4bftFt66BXwCWRTIlLggrmEV2/PJL1R+LziExuM
 dSF04n+dhTJ5uwvhJ/qUAvq1X7BPgbk/xIMkp4Q0adDck+1YkTyJWLyyicaLpfFy9yWd
 h2h0St7E6cSi8TYRyPngw8mtb9NFLN2yxXHknWvRsl7nUvV3+IjfJoTAjGjzytQ3W1C+
 uauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688927603; x=1691519603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8HOx1ZLKzsBUTcaboEy/mBqeLFtnDXaBWlHTAqwIG7M=;
 b=YQtF7yt6px6G27VGovtK3GlHOrUcCHMQNuW75/q5PhClcFxxzjz0EiW4WT+DDuT1q8
 PNL45OvageuAfn6lsUcHiy4PlCxbpuRrB64hvQkQKtAPDzLcNyo5mi4gkRzv1jDsx9xG
 zpiUlWFE0d23B3J+XF5Jo1ajy7nAX3Ue/hCgWV1gPx08oMHy9odPO1ChJ9/hA9NvOXTu
 BVn+wo11/AH6qDCiBCUeROVO/2wu9g43aN0VDserSQckehFAsXl9OAenk3iCBeigslbo
 fR9dca6aBJyiZTjJ5fx6waev21bWrZQh54uhLA9qSnIiDOqXeTcmTky1Eq23K2Spub63
 MX8w==
X-Gm-Message-State: ABy/qLZ6YkNgRRjEoI6f67hF4Q5qY5oDO/g/gzNwMpUw1+UKV8ZBk9/i
 c9YPV9ZYMM8aFsxP8DkObeJRThAV2sBvLtQGHOL/ag==
X-Google-Smtp-Source: APBJJlHf+w7ZKrSmkucTux4TUZBdnfk3uLGw0prQ3VKAKLN6dwu3afcPYhcSz/kIO4tE7+JphakrbA==
X-Received: by 2002:a7b:cd96:0:b0:3fc:443:3773 with SMTP id
 y22-20020a7bcd96000000b003fc04433773mr4435572wmj.30.1688927603172; 
 Sun, 09 Jul 2023 11:33:23 -0700 (PDT)
Received: from stoup.. ([148.252.133.210]) by smtp.gmail.com with ESMTPSA id
 e17-20020a5d4e91000000b0031433760a92sm9635256wru.115.2023.07.09.11.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Jul 2023 11:33:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 27/37] target/arm: Use aesenc_MC
Date: Sun,  9 Jul 2023 19:29:06 +0100
Message-Id: <20230709182934.309468-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230709182934.309468-1-richard.henderson@linaro.org>
References: <20230709182934.309468-1-richard.henderson@linaro.org>
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

This implements the AESMC instruction.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/crypto_helper.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/crypto_helper.c b/target/arm/tcg/crypto_helper.c
index d2cb74e7fc..1952aaac58 100644
--- a/target/arm/tcg/crypto_helper.c
+++ b/target/arm/tcg/crypto_helper.c
@@ -124,7 +124,20 @@ void HELPER(crypto_aesmc)(void *vd, void *vm, uint32_t desc)
     intptr_t i, opr_sz = simd_oprsz(desc);
 
     for (i = 0; i < opr_sz; i += 16) {
-        do_crypto_aesmc(vd + i, vm + i, AES_mc_rot);
+        AESState *ad = (AESState *)(vd + i);
+        AESState *st = (AESState *)(vm + i);
+        AESState t;
+
+        /* Our uint64_t are in the wrong order for big-endian. */
+        if (HOST_BIG_ENDIAN) {
+            t.d[0] = st->d[1];
+            t.d[1] = st->d[0];
+            aesenc_MC(&t, &t, false);
+            ad->d[0] = t.d[1];
+            ad->d[1] = t.d[0];
+        } else {
+            aesenc_MC(ad, st, false);
+        }
     }
     clear_tail(vd, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1



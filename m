Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CE7749D91
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 15:27:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHOzb-00057s-J4; Thu, 06 Jul 2023 09:25:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzK-0004r3-77
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:38 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHOzD-0000sN-Ra
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 09:25:34 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-314172bb818so621315f8f.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688649918; x=1691241918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ljXuz5WdOwWpxwvCuXAlprlm5SQ6d0e/c1sdlk1yWik=;
 b=phB3Kw/HaZcD6DKkUoFE+qI5nY9OXcPllIFb0eekj2xo7bO2ykUpxaAhSlGJZMldkB
 MPBQNP1+NdKV3ga3DUVcLhi2pKKXYhd1acwVLrCpBZ7xs7isf+GcBqO3MltkojHTYxTA
 1f23mKz4j+IJsNdj0U1MPY+i6OSBK8ZChaPoi6Ht5GTlomSK/yf5xYVIP92bR5v/xB22
 FGbkcnCMf94PjSLwiY09NCLioL2XKHtQvuGJoPMGDLD549JwzBXef6N9F0TwS9VOdNfX
 xzLt/NF7ArktHYMfMqUZc0T+ojdgua+om4TlIZTlwoNl4RCQK3Rf0YCXk94mldUu8w20
 OMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688649918; x=1691241918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ljXuz5WdOwWpxwvCuXAlprlm5SQ6d0e/c1sdlk1yWik=;
 b=Rq/rKVJfbzquT8TQ66JJh5jnXuON+3C4zUJib59C9vxPwdb5Wz4youDSl42Sl0573u
 je5DrFk2jxCg5aDzBV5qSOvER/+YTyaUtT1/sbQJTwyil9bALpBhKH8I26tTSIE99brF
 u2lzwgzSZ8c/gA5J2Bss0Cx55LMDT4Lu91AIet9HDAtoQy6+45odyucYlNdgi1dSXbai
 wKDMiLXESqyLGv1t32IRtgH4PNrHGtoO1Ae0ZInUg04R/MXh2Eb+0uzR/QHhGH73wz0e
 xVSJwcvuNCcYIj1OFjsSq92RsgLFVM0zuNrfytZ0Q9fbPzs+TUpWHH66A1IeHPbNvurq
 iBXQ==
X-Gm-Message-State: ABy/qLaAeQIcpWJiLiAx0qMH7lmEPy+wc0nAJksxYz1aoMvTdjC4QOyo
 2bDyqUM7onnHbv3Bp8wB3wzVLrW2JJAPTvxMruA=
X-Google-Smtp-Source: APBJJlGeH4+NJDxIXz7gAMlKtbUotvq0+Km427GPsz9hvflSx7Y9Fs53Kh8tKeM0zhnqVd0Z58xnkw==
X-Received: by 2002:a5d:5913:0:b0:314:350a:6912 with SMTP id
 v19-20020a5d5913000000b00314350a6912mr1384321wrd.36.1688649918606; 
 Thu, 06 Jul 2023 06:25:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a5d510f000000b00304adbeeabbsm1856170wrt.99.2023.07.06.06.25.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 06:25:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/14] hw: arm: allwinner-sramc: Set class_size
Date: Thu,  6 Jul 2023 14:25:08 +0100
Message-Id: <20230706132512.3534397-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706132512.3534397-1-peter.maydell@linaro.org>
References: <20230706132512.3534397-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

AwSRAMCClass is larger than SysBusDeviceClass so the class size must be
advertised accordingly.

Fixes: 05def917e1 ("hw: arm: allwinner-sramc: Add SRAM Controller support for R40")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20230628110905.38125-1-akihiko.odaki@daynix.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/allwinner-sramc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/misc/allwinner-sramc.c b/hw/misc/allwinner-sramc.c
index a8b731f8f28..d76c24d081f 100644
--- a/hw/misc/allwinner-sramc.c
+++ b/hw/misc/allwinner-sramc.c
@@ -159,6 +159,7 @@ static const TypeInfo allwinner_sramc_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_init = allwinner_sramc_init,
     .instance_size = sizeof(AwSRAMCState),
+    .class_size    = sizeof(AwSRAMCClass),
     .class_init    = allwinner_sramc_class_init,
 };
 
-- 
2.34.1



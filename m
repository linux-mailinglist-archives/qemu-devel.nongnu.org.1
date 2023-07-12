Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1D574FF0C
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 08:09:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJT1W-0000Z1-Dy; Wed, 12 Jul 2023 02:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJT1N-0000YO-LI
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 02:08:19 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qJT1M-0007Ad-67
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 02:08:17 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so847340a12.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 23:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689142094; x=1691734094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GS0NAFoYmodsd+bnZXz/vhH/Pb85MlJHayRsbvu1zWo=;
 b=johqK0BgGk1RALTvmpHMWxHHDmwvH51EXfVsu7J72qvNUINYJIca1/FNFYpouGjuCg
 LlcmcanRY/dAp3pCZC+y9rx4gluC9dmkGFRdL4o2z0wjnlXLsSMEn4mff5dF/Xx2Z9XT
 xHOvFC9ZwGyEkb12SD4gE6YHHc9a6W2RllLIpckkQynZr8XOvKN/IDbjT6QWmVrFKHWG
 QtZDJECh2//pjWmeYHTNGtjYnO7jO6+cnD2kZlo8BxCZj7zyZOvKuhOmyIHZqQuXaN4T
 OAwuGPoCbBTgzV810RTzAjR0ntO5DzjaplfcdPjzJ/yDiS2fU0L5C2f50+ktw9YQQH2f
 x80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689142094; x=1691734094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GS0NAFoYmodsd+bnZXz/vhH/Pb85MlJHayRsbvu1zWo=;
 b=dleZ4+lvXoEfpeWNIGUmAY5RvAUamY30kOFszKT7xiVPqUKaTDmDOtLgJF1D6Aftlx
 2KuvvZuy3DtCxHSmPq88apGphl6xAP5kWKj3kbuAdK4nelcfrNhS13USenZfHsch/7v2
 IKrMBRgeXaPy92OI1gTpcMZLIKLsL3U0XO55SQT0hWOnkuX8RPf9L7S2SRBRsYyoLhyI
 GPl7/th/B8g/FusHLy4+BLZahentKtHLWHkveaET6zu1EjggHSQv4ZH+Ln3UFzjW2489
 qRF1XOfz351KPXN168ERSOkQ9O7vU6ggzWyA6y4eNw94fvoZqARJyj03ZILVNunRsL3G
 ty6w==
X-Gm-Message-State: ABy/qLaFAOW5MZ2BfvzUs7WDEfUHT8dDsMyX0kgA/fyDPHsAxWvdZKXC
 cc5H5li4b/NWksOvB0cF4nn/tMbHrC27D8JSiLs=
X-Google-Smtp-Source: APBJJlE69iLa4F4eokqbXTQdKEAr4n6s2/CgR4JXlp8vWkLQy1KNOY1Xfd1BcB7GR5SKfzLlc3q1sg==
X-Received: by 2002:aa7:c98a:0:b0:51e:227c:9492 with SMTP id
 c10-20020aa7c98a000000b0051e227c9492mr1045019edt.20.1689142094464; 
 Tue, 11 Jul 2023 23:08:14 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.194.156])
 by smtp.gmail.com with ESMTPSA id
 k2-20020aa7d8c2000000b0051e2809395bsm2216138eds.63.2023.07.11.23.08.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jul 2023 23:08:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Siarhei Volkau <lis8215@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Craig Janeczek <jancraig@amazon.com>
Subject: [PATCH-for-8.1 1/3] target/mips/mxu: Replace magic array size by its
 definition
Date: Wed, 12 Jul 2023 08:08:04 +0200
Message-Id: <20230712060806.82323-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230712060806.82323-1-philmd@linaro.org>
References: <20230712060806.82323-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index deb8060a17..b007948a73 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -609,7 +609,7 @@ enum {
 static TCGv mxu_gpr[NUMBER_OF_MXU_REGISTERS - 1];
 static TCGv mxu_CR;
 
-static const char mxuregnames[][4] = {
+static const char mxuregnames[NUMBER_OF_MXU_REGISTERS][4] = {
     "XR1",  "XR2",  "XR3",  "XR4",  "XR5",  "XR6",  "XR7",  "XR8",
     "XR9",  "XR10", "XR11", "XR12", "XR13", "XR14", "XR15", "XCR",
 };
-- 
2.38.1



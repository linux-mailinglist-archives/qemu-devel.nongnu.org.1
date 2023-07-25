Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEABE761C8B
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:59:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJV6-0002Xb-3v; Tue, 25 Jul 2023 10:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJV4-0002Sx-Jd
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:58:58 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJV3-0001AA-2Q
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:58:58 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2b93fba1f62so81524491fa.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690297135; x=1690901935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3kaAuYnsnnMWtTSiYZvwlvHyAf+VE1JNjcN8fmFo6ns=;
 b=AFM4mtYd7EGukXFTJv1Uis88MT/Ui7yMn7/8Pmpm7xJ149rk7fKyiQJOyWEOcBzcqe
 xDOvgmjMr/YvRNnTQc7PWLzDV+ZCrscitBflofwfafIAHWI4fcZXMfmLHaOqwe+ZJZVA
 HxH0JD0Neo3TBohPC7IEgIkjTxZa5kMyfLA9FDG6xDfdvbTFvRjgnn4C1I3mNFdLAjo7
 Z3YjWdGqo78QplyFf4ViWhrbCkyTEEydv90y1PFFwvawO4+OmQprTsgmECc02HaCXzGS
 6N5Aw9VNeYQeV/8x27ldo4IKGEPdvQ9N/iU+0XAspsOhXfQg5xikZjWxzfOuynZzj3cT
 Jesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690297135; x=1690901935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3kaAuYnsnnMWtTSiYZvwlvHyAf+VE1JNjcN8fmFo6ns=;
 b=XPpEQPie/PdcsT7hD416ctbItILEcNC8O4+RwDlgpok0tz71/qM6K7n2MPg4yFTUT7
 BF4WbK8A3v8Rc1vNGlSNIVj/onvlI2HR8CUZcO7wWBplMCCgICtnYFgo/tL/WHOo3ERS
 aQKKvGTRLPPfziq6q+maJieOCF8zonZLIx0gOqlJzpq17ZgcDZckz44tFJu+2o+OsvPZ
 7lZYCdfHIc70tJhx3vCmdm9lBzpXyQROPjg3RQwicg4Dg4k39FfZcQducorDNH3XsuF7
 zn1PKP5yw9UDCyShxl+D1W/O5TMqEoutnekZLPSQKngUNUjz3Ymjvh4Sia6kbC11PalD
 5XWA==
X-Gm-Message-State: ABy/qLY/7Fn+qlMbiUB0FQMLcwqHg/Js8FpQu6Chd+cux2xdvN2f0n/g
 SWnAJfVp6ngWJm83LacrmonH9BZ5lFa4TD0Wk6k=
X-Google-Smtp-Source: APBJJlFhUC5rpO+uNquta1fDnlhQHWjoMlSQHLqKcZiuWdrPbO06BAMaYMobGmVIMP4iEzmbNay7rw==
X-Received: by 2002:a2e:7312:0:b0:2b8:377a:22f1 with SMTP id
 o18-20020a2e7312000000b002b8377a22f1mr9005520ljc.32.1690297134970; 
 Tue, 25 Jul 2023 07:58:54 -0700 (PDT)
Received: from localhost.localdomain ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 z5-20020a7bc7c5000000b003fbe4cecc3bsm16245610wmk.16.2023.07.25.07.58.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jul 2023 07:58:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/10] target/mips/mxu: Replace magic array size by its
 definition
Date: Tue, 25 Jul 2023 16:58:23 +0200
Message-Id: <20230725145829.37782-5-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230725145829.37782-1-philmd@linaro.org>
References: <20230725145829.37782-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230712060806.82323-2-philmd@linaro.org>
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



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD96D7D594C
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 19:02:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvKkV-0008Tz-E6; Tue, 24 Oct 2023 12:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKkT-0008Sw-0u
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:21 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvKkR-0002gm-E7
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 12:59:20 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9ad8a822508so707960166b.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 09:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698166757; x=1698771557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97B3jUFIyL98Y73J6mNGIo1KYIZg9jDlgc8fhF7w5XY=;
 b=KnEO4bkydynpVIxuxAQabK1ciZqfU6drQm9IIOew8x4hZuWIM89OwV/3Rcir4+kMC2
 tM+UyoSTavA5q/OiL5oKP29m8rS9XNJO/lZV57JQxwQtPQ0XoSpe3iQm0K/PDYYVVzQW
 J2lx89Br3N2Rkts1L3kD6+E1xRFMcAov4RWm8pngMqqdMRP4sRNf++Vx/+6x2yQjKWMq
 q/WlOSxmQMckkKdtIuyLp+ufYq5a11enb1ou+rJnWeULpASVWS+OgXpPG3STDnDUQIaX
 IQVZKPPBc3XMsjiYh7FD1JzyVVdhYeGgBzzSvM9OMbDq0O+eFqci9BG73MYnQMtFfERE
 Q0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698166757; x=1698771557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97B3jUFIyL98Y73J6mNGIo1KYIZg9jDlgc8fhF7w5XY=;
 b=AOwUVOqoo3aCrNSKcY1kWINxdXehjvgnFflO+BRWhFTkzyq08b9BOc/dvCSEtut72m
 zPuConlNkVxxaj89KH8wzX2ZKzcKyK109wrCHgykJG8zrBd/hplNoI6/uhE4La62gikC
 N1QsigDJldAU95oxqaNq9UhmaZn7po1vxEpqTjJG5NOKqg47YOmC/OkuL8hNTkylM9br
 gjhJcpQthnU/FwQvMuSJ6PA2Joy6w2D/cF5JFhnxkAWfNR0layaw3kFZB3OxB7uVvZge
 LCp8ff0zmkE3IpyEEXMnRkGyUJnV0RHZpHb+zT7wG+JvC4wA3FKWoKTtdA6ltfExuLgR
 7FlA==
X-Gm-Message-State: AOJu0YxwVCjWjj0D7Fw1aJLx6XCyayCnWvuiL6yvQZTxEUJFj43YBMf6
 ubDMntssNb5NXQkKiDshlJFGjFAivAt0YEFelpk=
X-Google-Smtp-Source: AGHT+IFCfjKUb4nF79z43YSamLZQxHl6G9ukUs4H/vsjfu5Mu7B5shceHda2xPMjtyPP7vfL1SiF6g==
X-Received: by 2002:a17:907:c1f:b0:9ba:65e:752b with SMTP id
 ga31-20020a1709070c1f00b009ba065e752bmr9657901ejc.39.1698166757613; 
 Tue, 24 Oct 2023 09:59:17 -0700 (PDT)
Received: from m1x-phil.lan (sem44-h01-176-172-55-165.dsl.sta.abo.bbox.fr.
 [176.172.55.165]) by smtp.gmail.com with ESMTPSA id
 20-20020a170906019400b00992b8d56f3asm8567029ejb.105.2023.10.24.09.59.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Oct 2023 09:59:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar@zeroasic.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 2/9] target/cris: Use tcg_gen_extract_tl
Date: Tue, 24 Oct 2023 18:58:55 +0200
Message-ID: <20231024165903.40861-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024165903.40861-1-philmd@linaro.org>
References: <20231024165903.40861-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Inspired-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar@zeroasic.com>
---
 target/cris/translate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index b3974ba0bb..65b07e1d80 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -871,8 +871,7 @@ static void gen_tst_cc (DisasContext *dc, TCGv cc, int cond)
                 bits = 15;
             }
 
-            tcg_gen_shri_tl(cc, cc_result, bits);
-            tcg_gen_andi_tl(cc, cc, 1);
+            tcg_gen_extract_tl(cc, cc_result, bits, 1);
         } else {
             cris_evaluate_flags(dc);
             tcg_gen_andi_tl(cc, cpu_PR[PR_CCS],
-- 
2.41.0



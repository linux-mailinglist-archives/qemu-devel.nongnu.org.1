Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCE1784108
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:42:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQhN-0006S9-AI; Tue, 22 Aug 2023 08:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQhK-0006Qf-F5
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:41:26 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQhG-0005ht-47
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:41:25 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5007616b756so4017058e87.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 05:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692708080; x=1693312880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9tgWMGPDbie9fGcPGgyVFDHFkfBvE8l4uEI9SosXl90=;
 b=J2KXBdxWDWdANzQcdikqJUwhVtE7/Nllc+n7/YFoh3p0JuFSWJQopQndpCNIwd1VoQ
 CI/ijojr4tMS8Q3f966G9CFxyR5PJ8nApvFVWpmf0c2LE2FYcTZDaC0h5HAlj/ti0b3L
 SH5oHa1fXTjiwpGjI/u0aTVSR7z5hi3SPLtdRIxtUBL468SEU9xtBL7yJadl8JHy5FI7
 nHMSMGePSDsAoNbZNEE6GUZ7vUlGI0NCI1yAN9Q5ZL47THjZ7DZVPDmKc7tGxl0qNuL3
 9kzSzVy8w56R6irL44cQsgJoV26s7viCHY9YLks8OZFwHPLn1Wj+0lHYOtFCQZwkwcdT
 5kPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692708080; x=1693312880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9tgWMGPDbie9fGcPGgyVFDHFkfBvE8l4uEI9SosXl90=;
 b=HjmJJlbpIOUlmhd6vs2DET0lE99K4wWwT/SxuR8eQ+cK5CW9hrqvgUZGSY00oNWMHZ
 9JleykE/7LudxnSusMjCS+uW4ud99O2fx9vJyBahLDFhVzXe9x496ha5VTJuAAv3yVp+
 UAjpJHQBUHqJ+kRzFy52AFEwYSd3nwNTBSp5nK/dDqmf44AZPfbXBsZWIjRR8bD0mAd+
 4Bb+AeNvH+A8pZpj1KAd+gZnPP1Ayy3nsnF7JWaAT/j3s9qH3hUXiRiHjszyyTTgPXkJ
 F+YZcgwPaUOUkJOvKZjOd9/IRBRPW0ejEgEpixezPSg37ROS5kvaMyB7tmi5JnT2FYJe
 fEnw==
X-Gm-Message-State: AOJu0YyQypuDljFvcSlzbPIRrR/ZDazWt6Q4E8cgIeXzOI7O+pPevYu2
 bGTobmaxlwJvKjB1ZVm8aRpPqSyLuuD7FqcKpvk5DA==
X-Google-Smtp-Source: AGHT+IGwxwyY1da7V7F4FfgAzkBqCYrNVKYze6hMNNqx49aLQBU+LdRcs/YqJ2Hm8hcp61ZA8fyxIQ==
X-Received: by 2002:ac2:4db9:0:b0:500:8723:e457 with SMTP id
 h25-20020ac24db9000000b005008723e457mr2168739lfe.30.1692708079891; 
 Tue, 22 Aug 2023 05:41:19 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 u24-20020a05600c00d800b003fbe791a0e8sm15956575wmm.0.2023.08.22.05.41.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 05:41:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Greg Kurz <groug@kaod.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-arm@nongnu.org
Subject: [PATCH 04/12] target/rx: Use generic hrev32_i32() in REVW opcode
Date: Tue, 22 Aug 2023 14:40:34 +0200
Message-ID: <20230822124042.54739-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822124042.54739-1-philmd@linaro.org>
References: <20230822124042.54739-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 target/rx/translate.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/rx/translate.c b/target/rx/translate.c
index f552a0319a..75590ae05e 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -1513,13 +1513,7 @@ static bool trans_REVL(DisasContext *ctx, arg_REVL *a)
 /* revw rs, rd */
 static bool trans_REVW(DisasContext *ctx, arg_REVW *a)
 {
-    TCGv tmp;
-    tmp = tcg_temp_new();
-    tcg_gen_andi_i32(tmp, cpu_regs[a->rs], 0x00ff00ff);
-    tcg_gen_shli_i32(tmp, tmp, 8);
-    tcg_gen_shri_i32(cpu_regs[a->rd], cpu_regs[a->rs], 8);
-    tcg_gen_andi_i32(cpu_regs[a->rd], cpu_regs[a->rd], 0x00ff00ff);
-    tcg_gen_or_i32(cpu_regs[a->rd], cpu_regs[a->rd], tmp);
+    tcg_gen_hrev32_i32(cpu_regs[a->rd], cpu_regs[a->rs]);
     return true;
 }
 
-- 
2.41.0



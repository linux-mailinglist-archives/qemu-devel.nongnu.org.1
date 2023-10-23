Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 776C77D3BE5
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 18:11:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quxVV-0001VC-P1; Mon, 23 Oct 2023 12:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxVP-00013s-2l
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:15 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1quxVN-0001g2-Hj
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 12:10:14 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40839807e82so20266405e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 09:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698077412; x=1698682212; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2HdF9ypEYHp2YFU11iLO4WAj8FlGyWoVdlHbB5VsvS0=;
 b=llbzwJRhN0rWNp42KhzFR5sZcqcGxGCqtwmQRQ695q+QSfVHHsIs8efQHojJgnTo/Q
 UuocJSJ8Cun2Kaj5p6MzC/4ce5HaMufzY7c08Mnr62H7Gr6RAhGaULgYYxCcop+/LkKC
 SzuatCPXtEAjCqgUg29p0+f/imXWml6/LsbA2KpjET8rRL1Bg9vKpL80NRCpByGExW2P
 tTLlPhr+taHTqC8smOnO0Z28JnKfvM/euxGO3CLdbHs3I1WLqzxeSBzkZDH1NOHRXsZc
 JuG4INlAi+HIHPCWM0zWJSuMpD6XzBpiaoYq+mv4MmGF1+J4qyyr6T5T8rUlVDSadOIc
 +9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698077412; x=1698682212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2HdF9ypEYHp2YFU11iLO4WAj8FlGyWoVdlHbB5VsvS0=;
 b=C9onkH3Y729UVgJL/3kKYy000IoOxRCTv9X9ZU7DxntDQ+sWLWM/NzHdV/dBAtIT49
 /3IqTAlsLVoYWp7QSRNSjLkEUx2jC3beVk+H78O0RAA0GXYLhARPWvFttoIa6OaZRCPI
 BAU44n9WlObV4bbMlT9FKLsJ/Z254LwaBn8EOZargyzz184lBhWTvXbefKc01tHUnskL
 fbQvUCsUNq6E7mImbiDukTVR2FaVfyAJOEIpUR2VoBs+C6aGoHSY22nZH8jOG9jeWFXf
 XoWpz3cZG3rWEPdxMUhTZDxBYtRB8GoQf1ppzMUZ+R9mWi7fDYaAA5ioVPMgIej5DKXU
 YSyA==
X-Gm-Message-State: AOJu0Yyu/+uaRctY4sVilaKBcW+Y2SDbv8/a7cNSGc3sKziX01AMpY0+
 xcsYRdzx5crbOgH6Z6WarAiNEF7o8B6YZ9ejb/I=
X-Google-Smtp-Source: AGHT+IEWsWumBz8Q/X63j83oIt7h0KobF591A6ix5UVFcv/6GdvbjdNZzybAzaatkpxslpwi9BzOTQ==
X-Received: by 2002:a05:600c:450d:b0:405:409e:1fcb with SMTP id
 t13-20020a05600c450d00b00405409e1fcbmr9962058wmo.5.1698077411797; 
 Mon, 23 Oct 2023 09:10:11 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-216-159.dsl.sta.abo.bbox.fr.
 [176.170.216.159]) by smtp.gmail.com with ESMTPSA id
 h2-20020a5d5042000000b0032d886039easm8064986wrt.14.2023.10.23.09.10.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Oct 2023 09:10:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 4/9] target/ppc: Use tcg_gen_extract_i32
Date: Mon, 23 Oct 2023 18:09:39 +0200
Message-ID: <20231023160944.10692-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023160944.10692-1-philmd@linaro.org>
References: <20231023160944.10692-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
---
 target/ppc/translate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 329da4d518..c6e1f7c2ca 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4802,16 +4802,14 @@ static void gen_mtcrf(DisasContext *ctx)
             TCGv_i32 temp = tcg_temp_new_i32();
             crn = ctz32(crm);
             tcg_gen_trunc_tl_i32(temp, cpu_gpr[rS(ctx->opcode)]);
-            tcg_gen_shri_i32(temp, temp, crn * 4);
-            tcg_gen_andi_i32(cpu_crf[7 - crn], temp, 0xf);
+            tcg_gen_extract_i32(cpu_crf[7 - crn], temp, crn * 4, 4);
         }
     } else {
         TCGv_i32 temp = tcg_temp_new_i32();
         tcg_gen_trunc_tl_i32(temp, cpu_gpr[rS(ctx->opcode)]);
         for (crn = 0 ; crn < 8 ; crn++) {
             if (crm & (1 << crn)) {
-                    tcg_gen_shri_i32(cpu_crf[7 - crn], temp, crn * 4);
-                    tcg_gen_andi_i32(cpu_crf[7 - crn], cpu_crf[7 - crn], 0xf);
+                    tcg_gen_extract_i32(cpu_crf[7 - crn], temp, crn * 4, 4);
             }
         }
     }
-- 
2.41.0



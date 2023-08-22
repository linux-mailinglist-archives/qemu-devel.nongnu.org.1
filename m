Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5818878412A
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:48:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQmP-0005O9-Iv; Tue, 22 Aug 2023 08:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQmN-0005Nl-0H
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:46:39 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQmI-0007JB-SY
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:46:37 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5007f3d3235so3481413e87.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 05:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692708386; x=1693313186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3CvejP1SPWKY/vo0PkTSUlRcOk/R6PHI3gbd8lW0JWk=;
 b=F9aGn+McmTleL0Oc26hFNmWY8lYtYrL/tLJ3J8c2prORtmV7052GRh0OnHCKIy3XpF
 f+V/8ibJ6xAXPhSUKA0y746fcWfpRdYvm1et+zDXrgcGSDqANDYOKgKY7bXHN9c6cqRN
 tNo/uHuqGPsyJ7tvvlck9rBH/t1Zw450N+phEbF9SMfSuRTxesJDRS9jTMmpxbBXEUwh
 6i8S2yMa+U8t4rEr4LWm9q2tBQ+6gJ2qB1Z8OUV+Otoj74Z/5jZ5R9jF+zlJBnyBH5N4
 vcQk42X9Z9L34SyPQjiv2fyL0rbCnuDyUx0tdf9CwN/K3uqE93EBh+l/5YequWE8OGBH
 GFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692708386; x=1693313186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3CvejP1SPWKY/vo0PkTSUlRcOk/R6PHI3gbd8lW0JWk=;
 b=XGaPagZYHprJoHr6zwUrNLK2WrAtMCXvNTeZmALXDe0DvY0PyuQy6/VcZbI5VTU0n4
 lhrvBn/UB6smPf/ugiZDxd1h108828cVr9yIYHf0oOrLWvheG07KBYvhQzxvDWaDaTSZ
 MoT2sK6Wp0GeVkP5zQNfWmUYm8N0/TFxaKfDuK8zOTL3mln03hLhanPPax0MmBXkxBEo
 5QJaci3yRTicT8CTUWjXcEJD01wu6qEZTXuOlAWVrap+ObP9apXVX76F6Whp8+9YXnPQ
 /8bG7TZK8YSpcODMNNNKpv27gRCdJUTRb8LHgGNlddwi9UZUkY73jXKpVfaYOgr3H5ho
 SfbQ==
X-Gm-Message-State: AOJu0YwifFLp7OvId4lBXuNTvKGnKiAW3NBIyitbPnhZMG1Y6OM/Kik2
 rLrYlxIC/FvDCEjCnhQkRltbeeYl7Hkmnej+ZrQ/1Q==
X-Google-Smtp-Source: AGHT+IFzLql3J6IBpa6M4SYUwhBgcYjbNb5zbTKteVAPCzK7imRgfaKaHy3AoncH/cBbtsmukvUhkA==
X-Received: by 2002:a05:6512:340c:b0:4fb:7592:7e03 with SMTP id
 i12-20020a056512340c00b004fb75927e03mr7569000lfr.20.1692708385982; 
 Tue, 22 Aug 2023 05:46:25 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a1c4c0a000000b003fef5402d2dsm3982597wmf.8.2023.08.22.05.46.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 05:46:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Greg Kurz <groug@kaod.org>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Nicholas Piggin <npiggin@gmail.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/12] target/arm: Use generic hrev_i64() in Aarch64 REV16
 opcode
Date: Tue, 22 Aug 2023 14:46:18 +0200
Message-ID: <20230822124618.54873-1-philmd@linaro.org>
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
 target/arm/tcg/translate-a64.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5fa1257d32..2973831b38 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -5040,16 +5040,7 @@ static void handle_rev32(DisasContext *s, unsigned int sf,
 static void handle_rev16(DisasContext *s, unsigned int sf,
                          unsigned int rn, unsigned int rd)
 {
-    TCGv_i64 tcg_rd = cpu_reg(s, rd);
-    TCGv_i64 tcg_tmp = tcg_temp_new_i64();
-    TCGv_i64 tcg_rn = read_cpu_reg(s, rn, sf);
-    TCGv_i64 mask = tcg_constant_i64(sf ? 0x00ff00ff00ff00ffull : 0x00ff00ff);
-
-    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 8);
-    tcg_gen_and_i64(tcg_rd, tcg_rn, mask);
-    tcg_gen_and_i64(tcg_tmp, tcg_tmp, mask);
-    tcg_gen_shli_i64(tcg_rd, tcg_rd, 8);
-    tcg_gen_or_i64(tcg_rd, tcg_rd, tcg_tmp);
+    tcg_gen_hrev_i64(cpu_reg(s, rd), read_cpu_reg(s, rn, sf), sf);
 }
 
 /* Data-processing (1 source)
-- 
2.41.0



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E20784160
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 14:58:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYQxa-0004ZH-Vc; Tue, 22 Aug 2023 08:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQxY-0004Ww-Qf
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:58:12 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYQxV-0003Ti-Be
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 08:58:12 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-31c4d5bd69cso1892528f8f.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692709087; x=1693313887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HoqVbo91wPVgF5r48rM5Dy0YT51miWRNDAkstIMzJy4=;
 b=x84rpRuUKtihEm90d8RKSO3l2JCiyV88QdRZioX4EdIG1VliKN3Se4EAiebdlsOnUx
 uTJc8j8TYNpzC4CPse1uxEF82ygg7nI8KTAJKfviHBRDntg54AQPgah3HBDOcNqvH5Rs
 HLU9zSSL7oiI74ft2yihnnwZEYRpLaLOtWSLSm9/qBwnONXostSNNeWXrVd2i2SU6FKI
 hTFftd2RoNSr1wVj8YU/SSSGyvc9OKyZ+W7G2xpWaggDzTFsFPYE23TViB2uV25It298
 Xifcelv/XLziQqYDKyfEffmKcjj1sHcA0xaVnFDPRtLKtr9a6Hfm3cm0J6xXorruT6AE
 h9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692709087; x=1693313887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HoqVbo91wPVgF5r48rM5Dy0YT51miWRNDAkstIMzJy4=;
 b=Ccoukn17+qD39w0Ft1HIdCkL85osjPBpLTUG+Z2ad1kzX/9lJ/Bni7Bt2fJw5cPcg9
 BI6bNRK6NhGCbBnW2auf+P/GpZo8d1xyAe8ry9jTlM4jNgrT6Vi3lxzRioB+FjEdKEy1
 5PMS1sw/VJ6udQx8j64tIFD3Zm9J8SASx1eHQU/mrNCDtCkybaz4P1tya+oSVsJwNT+P
 M1umM+Fnnf00jDbemhBYugZDcMmyDojRwNQv67jc4UBlW0F0shcUGT6p9QkpM8tk70bX
 uCoMmmv+y5DwADqHt1f2GKOUuixhr6M/PMLFT6GvslRhgdB0EI/njfeysEtRzppZZ58T
 DsHw==
X-Gm-Message-State: AOJu0YxYB13jfg77GuWHXpUVqdbD1LFAQ1vVPAUNDXtoz7Va1wcL7zDQ
 OJz0GQFD/dGbq90xDzwA9WKW15GB2gHZShPHcUco7A==
X-Google-Smtp-Source: AGHT+IGxO1Ypid1Vj6SZW4PVOM/kHL7inRHfC4X4YcLDq4XWS0j00izoaA8eHNJs9dp4QAp0EBCYow==
X-Received: by 2002:a5d:4586:0:b0:31a:dbe0:ca7d with SMTP id
 p6-20020a5d4586000000b0031adbe0ca7dmr6637694wrq.8.1692709087351; 
 Tue, 22 Aug 2023 05:58:07 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 19-20020a05600c249300b003fe2f3a89d4sm15855430wms.7.2023.08.22.05.58.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 05:58:06 -0700 (PDT)
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
Subject: [PATCH 12/12] target/mips: Use generic hrev32_tl() in WSBH opcode
Date: Tue, 22 Aug 2023 14:57:52 +0200
Message-ID: <20230822125752.55328-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822124042.54739-1-philmd@linaro.org>
References: <20230822124042.54739-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
 target/mips/tcg/translate.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 08ee745a6d..822b932262 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -4916,17 +4916,8 @@ static void gen_bshfl(DisasContext *ctx, uint32_t op2, int rt, int rd)
     gen_load_gpr(t0, rt);
     switch (op2) {
     case OPC_WSBH:
-        {
-            TCGv t1 = tcg_temp_new();
-            TCGv t2 = tcg_constant_tl(0x00FF00FF);
-
-            tcg_gen_shri_tl(t1, t0, 8);
-            tcg_gen_and_tl(t1, t1, t2);
-            tcg_gen_and_tl(t0, t0, t2);
-            tcg_gen_shli_tl(t0, t0, 8);
-            tcg_gen_or_tl(t0, t0, t1);
-            tcg_gen_ext32s_tl(cpu_gpr[rd], t0);
-        }
+        tcg_gen_hrev32_tl(t0, t0);
+        tcg_gen_ext32s_tl(cpu_gpr[rd], t0);
         break;
     case OPC_SEB:
         tcg_gen_ext8s_tl(cpu_gpr[rd], t0);
-- 
2.41.0



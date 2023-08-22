Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4FB783E8B
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 13:04:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYP9j-0006Se-Pd; Tue, 22 Aug 2023 07:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYP9H-0006Hl-8f
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:02:12 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYP99-0003L4-E4
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 07:02:10 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fef56f7223so11877955e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 04:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692702115; x=1693306915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Atmx7i5fRW8XnKx5xE4DtcYf6nuKJy8oiwMSi9RhaeI=;
 b=DYorDiCC6zDmH3rqFYk/9pwrsrWWNUjRA/ght3xwkjFklcnQdpYFWvL+qkFjyrpzOR
 bK1c5yfkEibRK7NpzfOAI7nh64VO0CYbMTXp6fTu7y+Flpp3/QU3p+LHxGYrKwedSzl7
 zJiSiIHsiTVcETt2Yp96OddYsq4Qk/K9Zy2r/loZVCvWOV2ARk87BXNCru4ne7gqBENU
 CZmxnReZEM+cNSaQjFpYDUvWxFjqs4vvIOzQlUPGeRC5hvaqiijEnphH1Kr9cU16yaYh
 s5iBTFDwesNDNGKLT+EmYmZ0ymSc8Mic+yi84AlnpV6X5WXPnNiHvKuuO0OcJLGzJnir
 c3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692702115; x=1693306915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Atmx7i5fRW8XnKx5xE4DtcYf6nuKJy8oiwMSi9RhaeI=;
 b=KzavGQYGo+sGAwDXXwpqDu7dNg/reMyPVCXxOjz0YUxmI9UlephBVsvF5qh28yxp3s
 N9mjCVCpA/XSO8nLA0kP14T1pwPKJkJcBhDorxPzWew6QjUHWA1D6m+WFg8i0G2kvow2
 5llknSlFBasWD2Pkn3R7aIESmju0IcexYIsqskiOsIIZBtDoFgp8YtFk8hVpOQTKKfKk
 wSMsuIexI9ag0X10O1qqp/ZF8FM6bbOq9jRfeQwGVZP1b+Otttrm57TpsqtyhcR0IqSp
 kD0iRffhx12F7Va3obqZJRU0M042Eopy0Fl9J318IhxUgLDS5od4kkpBYz3GwPphmprK
 AHsQ==
X-Gm-Message-State: AOJu0Yx2qJ21wTCwBsOOtUKX79ZAJM8uaVvB5aZa2mpw8n0cUoFy02MF
 HT7h7/cWZdw62ENIOfsbcoUtdXdBeWsIx1EZTGU6GQ==
X-Google-Smtp-Source: AGHT+IGJUYtIeYKsfokZb3Se5q3jAInTSdTY7Yu1hNaa7oXiZsGKJb2sOQe7gbabkOC4pUH2zvenMQ==
X-Received: by 2002:a1c:7303:0:b0:3fb:f0ef:4669 with SMTP id
 d3-20020a1c7303000000b003fbf0ef4669mr7074980wmb.17.1692702115000; 
 Tue, 22 Aug 2023 04:01:55 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a7bcb46000000b003fbb25da65bsm15668820wmj.30.2023.08.22.04.01.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 04:01:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
Subject: [PATCH 3/6] target/microblaze: Use hswap_i32() in SWAPH opcode
Date: Tue, 22 Aug 2023 13:01:26 +0200
Message-ID: <20230822110129.41022-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822110129.41022-1-philmd@linaro.org>
References: <20230822110129.41022-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Commit 46be8425ff ("tcg: Implement tcg_gen_{h,w}swap_{i32,i64}")
introduced the generic hswap_i32(). Use it instead of open-coding
it as gen_swaph().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/translate.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 7e7f837c63..83fd1161f0 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -608,13 +608,8 @@ DO_TYPEA0(sra, false, gen_sra)
 DO_TYPEA0(src, false, gen_src)
 DO_TYPEA0(srl, false, gen_srl)
 
-static void gen_swaph(TCGv_i32 out, TCGv_i32 ina)
-{
-    tcg_gen_rotri_i32(out, ina, 16);
-}
-
 DO_TYPEA0(swapb, false, tcg_gen_bswap32_i32)
-DO_TYPEA0(swaph, false, gen_swaph)
+DO_TYPEA0(swaph, false, tcg_gen_hswap_i32)
 
 static bool trans_wdic(DisasContext *dc, arg_wdic *a)
 {
-- 
2.41.0



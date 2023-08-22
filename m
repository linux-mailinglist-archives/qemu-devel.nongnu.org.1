Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE48783AC0
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 09:20:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYLgd-0006xj-F0; Tue, 22 Aug 2023 03:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLgW-0006xY-04
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:20:16 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYLgS-0004cY-74
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 03:20:14 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31aeee69de0so2341457f8f.2
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 00:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692688810; x=1693293610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MhjR1Tf2TeBu860wg/l8a21u7QsD4djihIlF5A0hbsE=;
 b=TxFtfTqfzuP86TULQjBP9Fc9LyCmXjZfx39IvEUzYF/HziXdHqK7ZTJAlKSF+W1YF9
 6hi+MwW63lcpE4iwjOvfE9eCrEGOREHnAP7z8zboMW0TdwzZc4uto1doQ1Kr1KeDplfV
 LjZlQCRu3bMrSjLgghLC9hc9Vu4wLRD3wljyjrL/ynVILJbTe7AsERNOHpwpbDmqxbUU
 XGD9DjFYDdGEwIh2d7nmwmTAQFpREB5ZvCCm5yc0YmSeeh1g4FWtDYd6iKnsC/G2FABL
 Crdkb2vl8casZLfuWfofEEsEn0FxyizV1DwroDbtgTvZUGdXlC9z+ww9JqUyKPU9g0ox
 AzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692688810; x=1693293610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MhjR1Tf2TeBu860wg/l8a21u7QsD4djihIlF5A0hbsE=;
 b=MsXcaud7dl8lSLFCSJxm8d7OUZSR2gaOgEsZ4MtHz3duC9eWi+1Jkg450q8raP/lUM
 VvU0iNVqwUTA9a6W+d0ZFRC+Ezu4AiLrTf8SqB5ZAXkDy0Xvv8/Md/b3glkOZxV6vanp
 S8GYhYna9GPek6R+tO5c3K1k5MDhiKPV/KpKuBzMj8V0F+0HkK5wzIG/fI0iIvIXshMN
 fJff700r88bsL3V6YAXvonyQyF2aYcyUh5yZlXCbEZXfpjxBCInR5w2TIJWxokcdyY0t
 X93hspfiL9/0djQh4gNpAV5DwIO0ja9aUcFPxK/lUERz5sCbog63wsGoaUHm5z214qAu
 lTUw==
X-Gm-Message-State: AOJu0YyDdy3q/mXuVB4DDpBJMFKkQ/Dnnr8wy2d5OFLbI6gMpFlR5ger
 MxiOgsONSdvJhZAAySTtuvP9fxJnV/xJ6xi9wkMLkg==
X-Google-Smtp-Source: AGHT+IFm/EP6qixCmXFmWKRXAMOFRCsyKPoR8cwPVdOYqM6fnYSlCX+8acyytu5D5IV9hcUpY2HrZw==
X-Received: by 2002:adf:fed1:0:b0:317:5b5f:2328 with SMTP id
 q17-20020adffed1000000b003175b5f2328mr6828132wrs.24.1692688810034; 
 Tue, 22 Aug 2023 00:20:10 -0700 (PDT)
Received: from localhost.localdomain ([37.19.214.4])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a5d5552000000b003142ea7a661sm14807924wrw.21.2023.08.22.00.20.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 22 Aug 2023 00:20:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Song Gao <gaosong@loongson.cn>
Cc: Jiajie Chen <c@jia.je>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH RESEND v5 10/19] target/loongarch: Sign extend results in VA32
 mode
Date: Tue, 22 Aug 2023 09:19:50 +0200
Message-ID: <20230822071959.35620-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822071405.35386-1-philmd@linaro.org>
References: <20230822071405.35386-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

From: Jiajie Chen <c@jia.je>

In VA32 mode, BL, JIRL and PC* instructions should sign-extend the low
32 bit result to 64 bits.

Signed-off-by: Jiajie Chen <c@jia.je>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230822032724.1353391-7-gaosong@loongson.cn>
---
 target/loongarch/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 9a23ec786d..de7c1c5d1f 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -238,6 +238,9 @@ static TCGv make_address_i(DisasContext *ctx, TCGv base, target_long ofs)
 
 static uint64_t make_address_pc(DisasContext *ctx, uint64_t addr)
 {
+    if (ctx->va32) {
+        addr = (int32_t)addr;
+    }
     return addr;
 }
 
-- 
2.41.0



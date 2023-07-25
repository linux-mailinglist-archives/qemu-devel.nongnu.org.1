Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46300761C7F
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:59:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJVB-0002wM-Tp; Tue, 25 Jul 2023 10:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJV9-0002sE-N3
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:59:03 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qOJV8-0001BW-6W
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:59:03 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31297125334so3671920f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690297140; x=1690901940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPH7ythNpojxEEqzURXeFxVEUkiCc46BFyGsLCbiaqo=;
 b=KYfsELiAwrTyUqIo8zERZv2OdU9ogs7+kAJWnJYxc7hf3Gj4v3cAkX3oMlQWhuwLyR
 Sg9u2gQiLc6ECHQtwJDj4ZuwaEIU0Jw0e04iEzblsN1ohnzh3119cwC+O4R0RcHmcF7S
 HX4Py4vUDBXET3gsp2Q5mwW0CkGGP4xkr/1kiAVbl5PjK9w93/aOQouRQHkoZCaPz8mu
 wWkH4IyqqOE8Tz7YxRJepmHAJ/08enuiocM6+SaX5Gebc7v5VHI81oUxFZNpX/BI4F4O
 a/JleMFwEPqPz+xfItmmvk/oRGMrlVAHVGvaBq2Ch+jPCMFcAYrBNLt5j5WV3rU2ZMhk
 Zqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690297140; x=1690901940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kPH7ythNpojxEEqzURXeFxVEUkiCc46BFyGsLCbiaqo=;
 b=IaxtOik8JDOriA1exqiD1DwKVOe4RptXhkeR+DLuQbsnYxY+9lql8j763F92wSFxaq
 00aqRiU+i2XwxkjVeuTvnhIyWVxxXJOS9aiIgrOlpqaqS+1FGRSJQpWw+pjDvmlZzewp
 tkrDJ1KiXLXI+JmdzOnSL+ovU3drs+hklHGoLYfLGtfnTJApLF+Pr/tXxhOjoesgJc74
 ZcQjOB4CPqEkr6h8Ka/aB4dy0fbiX916qT2JNT4tINGj+XEYitkvPXSeJ4tpbCJ1737z
 oHVzpkCeUSEkceUiQn8qSRctBAmq6q2gSkoIZKfGiyh2cryMs13eXKmlW8ZtVRutdsfv
 esyw==
X-Gm-Message-State: ABy/qLYQBAeuddM04P48FvQlcV02uFymavhQVveDtXnVHvm201VwhaMx
 HK7vYElTiZjVJuwhgCfKFRzYKZ/YxaxT6mCEflE=
X-Google-Smtp-Source: APBJJlE376kjTMLi1h4UlpUDSku67Epo0l0gheAnpP9SNgWGbwQ3tXUpo/4dWBIsS9TrtbUUudHm+g==
X-Received: by 2002:a5d:69cd:0:b0:315:7f1d:7790 with SMTP id
 s13-20020a5d69cd000000b003157f1d7790mr2097576wrw.6.1690297140648; 
 Tue, 25 Jul 2023 07:59:00 -0700 (PDT)
Received: from localhost.localdomain ([176.187.203.142])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a5d4709000000b003143801f8d8sm16535769wrq.103.2023.07.25.07.58.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Jul 2023 07:59:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/10] target/mips/mxu: Avoid overrun in gen_mxu_S32SLT()
Date: Tue, 25 Jul 2023 16:58:24 +0200
Message-Id: <20230725145829.37782-6-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230725145829.37782-1-philmd@linaro.org>
References: <20230725145829.37782-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Coverity reports a potential overrun (CID 1517769):

  Overrunning array "mxu_gpr" of 15 8-byte elements at
  element index 4294967295 (byte offset 34359738367)
  using index "XRb - 1U" (which evaluates to 4294967295).

Use gen_load_mxu_gpr() to safely load MXU registers.

Fixes: ff7936f009 ("target/mips/mxu: Add S32SLT ... insns")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230712060806.82323-3-philmd@linaro.org>
---
 target/mips/tcg/mxu_translate.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/mxu_translate.c b/target/mips/tcg/mxu_translate.c
index b007948a73..520747a597 100644
--- a/target/mips/tcg/mxu_translate.c
+++ b/target/mips/tcg/mxu_translate.c
@@ -2434,8 +2434,12 @@ static void gen_mxu_S32SLT(DisasContext *ctx)
         tcg_gen_movi_tl(mxu_gpr[XRa - 1], 0);
     } else {
         /* the most general case */
-        tcg_gen_setcond_tl(TCG_COND_LT, mxu_gpr[XRa - 1],
-                           mxu_gpr[XRb - 1], mxu_gpr[XRc - 1]);
+        TCGv t0 = tcg_temp_new();
+        TCGv t1 = tcg_temp_new();
+
+        gen_load_mxu_gpr(t0, XRb);
+        gen_load_mxu_gpr(t1, XRc);
+        tcg_gen_setcond_tl(TCG_COND_LT, mxu_gpr[XRa - 1], t0, t1);
     }
 }
 
-- 
2.38.1



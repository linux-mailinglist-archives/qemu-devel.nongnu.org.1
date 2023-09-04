Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACA9791B5D
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:17:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCCO-0002Ns-9z; Mon, 04 Sep 2023 12:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCCM-0002N6-Bl
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:10 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdCCK-0007Uf-0Q
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:13:09 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99bc9e3cbf1so348967566b.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 09:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693843986; x=1694448786; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ydRFdPTad34foOKByxz/L8A5535uYhpZFQ3Nd9iHtU=;
 b=aKxwAC2LMNhxgnyaVkjMufgvx1SR/zA+KbMnu0NGLDzLO4F9Owdx55w5Rk07GEbpyk
 Qfkpfg8g9roNYsYhXg+5Jxt9oU4eraDn7QwdYhLir6UG8zL/5W5qmxSpM4ZMvGsUccmv
 BURTrI+4jkDGx5ZnEw8/Y9vjhPH0UGFX/4i/G7LyiBQPc+nlMu7JPdRkRSIBBxeRtZom
 tAnR57P0Vqs4gjhJDF1RcS46l9lk+NcpUAVadULHbSGaOgDmky2iULqcypirvdjKQQLu
 vVHQOo9Mixg1OaAlMjrPxO1sIPtp6Y+oOAKo8PSmnVR2L9LTD6ZR5wvpzjn/mfOT/t/z
 iIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693843986; x=1694448786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ydRFdPTad34foOKByxz/L8A5535uYhpZFQ3Nd9iHtU=;
 b=REAJBAM5eD8q8NvWolyRcZSwYA+9lPX0p2yJ2jb3+0Bm1d7CWc+OXqw+SEh6gQxdk2
 wqkgxRyKuBtGRElNbqvQH2GAdTKxt+7VT2mFdNH9Ys5womGgv1GDgHMIRKK1QPnRVz4w
 DvAB/NRHrs5zX3ncYjOcjkvoyHk+xSshkCVIQOxIoNQwEzy3bu6tA/QKXod5ZY+oMUCZ
 vFpqTzsdKFWOpZZtdPpVNN+kkX6014gc3VhmrBI/x/q5RiTIYf2F1FFwke92MzAyX1J1
 AMA/QuDCEaO02lOHNNKsGLF0ORKkzzZK6kSLjnje+oUlN4M0vT9g1FsEPbLs3nrmu7Zh
 I4wA==
X-Gm-Message-State: AOJu0YzcrDA6xF3oC8ewCYFMuhsWqmXpZs+GrxH78B+7vMOBvyDy6deu
 iNhdyp4cLl3p3cXSMfIkdZ9qQA==
X-Google-Smtp-Source: AGHT+IF3p567zIxW/ge+4W9x1XxVVwydDPi5HtS9oCLXi+ZGnlIJ+8D3esiTAxgEykwouWTv+0I3lA==
X-Received: by 2002:a17:907:a050:b0:9a2:26e4:a5e2 with SMTP id
 gz16-20020a170907a05000b009a226e4a5e2mr10399094ejc.25.1693843986760; 
 Mon, 04 Sep 2023 09:13:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.227])
 by smtp.gmail.com with ESMTPSA id
 g2-20020a1709064e4200b009a5f7fb51d1sm6294014ejw.40.2023.09.04.09.13.05
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Sep 2023 09:13:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 05/22] target/m68k: Clean up local variable shadowing
Date: Mon,  4 Sep 2023 18:12:17 +0200
Message-ID: <20230904161235.84651-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904161235.84651-1-philmd@linaro.org>
References: <20230904161235.84651-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

Fix:

  target/m68k/translate.c:828:18: error: declaration shadows a local variable [-Werror,-Wshadow]
            TCGv tmp = tcg_temp_new();
                 ^
  target/m68k/translate.c:801:15: note: previous declaration is here
    TCGv reg, tmp, result;
              ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/m68k/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 15b3701b8f..f69ae0e3b0 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -825,7 +825,7 @@ static TCGv gen_ea_mode(CPUM68KState *env, DisasContext *s, int mode, int reg0,
         reg = get_areg(s, reg0);
         result = gen_ldst(s, opsize, reg, val, what, index);
         if (what == EA_STORE || !addrp) {
-            TCGv tmp = tcg_temp_new();
+            tmp = tcg_temp_new();
             if (reg0 == 7 && opsize == OS_BYTE &&
                 m68k_feature(s->env, M68K_FEATURE_M68K)) {
                 tcg_gen_addi_i32(tmp, reg, 2);
-- 
2.41.0



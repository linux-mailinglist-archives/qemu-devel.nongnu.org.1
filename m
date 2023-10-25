Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F41F87D62A6
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 09:29:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvYIo-0000Mh-Sd; Wed, 25 Oct 2023 03:27:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIk-0000Lb-Fn
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:38 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvYIi-0004kK-JP
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 03:27:38 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so46051715ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 00:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698218855; x=1698823655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHAeumhj/k6eiqLtdrKjjL6mwObgsX5DY/BFSjKBF5I=;
 b=hqL4JFUcAZ9mdDvZOmpFY8ZMvNi4kHw6laQZnttTO2EfDRr297Sc5C9lO++yNupzlK
 kdxCI2yDwUl5K6Ozo8tD412w5hzHUO3KA1nSit9PIlHSy6BtbjLo91FH3joajhSzNAql
 jiP65pzeFdp7C1lune5CWNEgD+YNb8khhcqHkgIOcVDAkoL7Ol91R+9vtkG1WJwwyQYf
 g8tvNoH88865zLhGKaM5UBi3fMQ7Ii36BvfCXSycDuseS+rUXx4WDy/NNOnG91Ce+d3N
 Lltn4MvheatJyVM68T1rR8MXMa46gt4ax6L8ugvfKSx8ihvFmkgd6jMSNhmmAqPLs+sQ
 1TYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698218855; x=1698823655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EHAeumhj/k6eiqLtdrKjjL6mwObgsX5DY/BFSjKBF5I=;
 b=qGgF8hjiOZ2dUvPgVvdHzL66KNMh/9rwk3fC8GWIBYLFa1N8Lyxym47+FxlAXS31Ab
 /ciY7Vw5u2AD1jT3FgOI/F2wA4i9Qwb538q0omk0kaQLhfkcOCUp8LWFwJygpVQLlL1b
 hpLETXUuhVaD62CRVM8vY/trD0ZKkHO5+U2sHUAqxsm6Z/IFhwKPmphNMusx56PNLC11
 eNIIyymcS5CzLQB2wdMcvG9AhyrjZALFq9jST/fNeoeCn1TEiGoI/Ih3fgrZWf0kgCfz
 OM1h5rpcmGpvYJlzJpcu7xmovpgvT5P+7e2VK+HmF3z1uuXT6mUT7go9LFMUKyrQ2v44
 RdBQ==
X-Gm-Message-State: AOJu0Yxueof0DjSZjHFHQPk7Vk2b4tFaXHBplCJOKBjTLKCUsh3v/71R
 1qqunsydHesszYvVY/ZLfahh9AEbkTJULLZ6VUI=
X-Google-Smtp-Source: AGHT+IGhuESAgKWA5osCzpbqrOCVekzgODDbn5qdzpJOvUGf3ksvQUXgefqYsY006nuDPjPk3Eox9w==
X-Received: by 2002:a17:902:c404:b0:1c3:ed30:ce0a with SMTP id
 k4-20020a170902c40400b001c3ed30ce0amr19255819plk.19.1698218855431; 
 Wed, 25 Oct 2023 00:27:35 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 ji5-20020a170903324500b001b06c106844sm8578661plb.151.2023.10.25.00.27.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 00:27:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 28/29] target/alpha: Use TCG_COND_TST{EQ,NE} for CMOVLB{C,S}
Date: Wed, 25 Oct 2023 00:27:06 -0700
Message-Id: <20231025072707.833943-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025072707.833943-1-richard.henderson@linaro.org>
References: <20231025072707.833943-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 49e6a7b62d..c7daf46de7 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1676,16 +1676,12 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             break;
         case 0x14:
             /* CMOVLBS */
-            tmp = tcg_temp_new();
-            tcg_gen_andi_i64(tmp, va, 1);
-            tcg_gen_movcond_i64(TCG_COND_NE, vc, tmp, load_zero(ctx),
+            tcg_gen_movcond_i64(TCG_COND_TSTNE, vc, va, tcg_constant_i64(1),
                                 vb, load_gpr(ctx, rc));
             break;
         case 0x16:
             /* CMOVLBC */
-            tmp = tcg_temp_new();
-            tcg_gen_andi_i64(tmp, va, 1);
-            tcg_gen_movcond_i64(TCG_COND_EQ, vc, tmp, load_zero(ctx),
+            tcg_gen_movcond_i64(TCG_COND_TSTEQ, vc, va, tcg_constant_i64(1),
                                 vb, load_gpr(ctx, rc));
             break;
         case 0x20:
-- 
2.34.1



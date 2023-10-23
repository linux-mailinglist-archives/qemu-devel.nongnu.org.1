Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF93A7D3EF2
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:18:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRl-0006dl-Na; Mon, 23 Oct 2023 14:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRI-00060e-58
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:08 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRG-0008JV-JG
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:07 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-581f78a0206so2091588eaf.2
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084845; x=1698689645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHmmFYF02i+OnY3fmwj8/XxXt0JUUTrQhyiW4ERnoxY=;
 b=xDyj7uBiwUX+P9mTK1Cp7jOH4ec6tKeGipsnCJgTLNDln6sy3EfDpLleAXVZFrE4QB
 WExisMIM/wkJ3D410EeGeyR4WFYKycsmlvn+IiKQiWXvpWPL7zCuLfKT+A+GNC68SL0M
 ZkWiv9N0KD0AtbVrJ8CZlNkNxMFaL3gecWUo4atLF88x8P7v2CHU96/WcrKkDAlc/c65
 syGAwYKcoxCces1BkycTrfqkM7I4F71E7zI+l2LP7hTcrC+55RXr6+kCBZ/WMcFG0i52
 8aDJwonznUyMNYJKvcu+2J6RmKrIyDWYu+aHZTIFBmRPvaKSpEEVjCT/J3Ts1r5/j7OJ
 W6tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084845; x=1698689645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHmmFYF02i+OnY3fmwj8/XxXt0JUUTrQhyiW4ERnoxY=;
 b=FWQuGxejSNQ0Xf5pHjQs9mheZe1xLJbQuv/WFSPUbhID+eRNcEeCzi+w19r1txWFLd
 s3DXNEHDTwfrW1vJXXFsFzyz2sv+Y7rdxV83dXtMNru0u0TeFs3C7MJApU38YpQ3OnYv
 z6Gep4JHYKhf/4zyzZNg5Ba1Z7FwAZvt3US/fn89hw+2ILu/IrKDukckV2B3JV6IR9Qt
 F/ZWXn1BUOdzWGNg0bN6wupr7BF5HjUWieI7vztLizwN8FvVMNR3UcvJ0Nq+rlTJkkeg
 lTBQUxlniBnpbSL2KF1MRwLtVJOWz6EXHUcmxsLsYixhyyYofqSJeHzyLg3+QXHBNWd7
 a6eA==
X-Gm-Message-State: AOJu0YwZW1c+jMfH3TG1mH0yomYSjLqsiz0O2JRfrximqZgxjGPe0OZi
 UywL3RR39aisOIscM5im7SH7+1uu0AfCD36MAM4=
X-Google-Smtp-Source: AGHT+IEVt5DN6yeyCi/UqIUD15i9ZvX+3fqpkCUw45agfnvLS6XyTEOnuX/mYQlmHIlApkx3g9OujA==
X-Received: by 2002:a05:6359:5c20:b0:168:e177:b2bf with SMTP id
 pu32-20020a0563595c2000b00168e177b2bfmr3032364rwb.5.1698084845220; 
 Mon, 23 Oct 2023 11:14:05 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:14:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL v3 38/38] target/xtensa: Use tcg_gen_sextract_i32
Date: Mon, 23 Oct 2023 11:13:29 -0700
Message-Id: <20231023181329.171490-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/xtensa/translate.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 54bee7ddba..de89940599 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -2262,17 +2262,7 @@ static void translate_salt(DisasContext *dc, const OpcodeArg arg[],
 static void translate_sext(DisasContext *dc, const OpcodeArg arg[],
                            const uint32_t par[])
 {
-    int shift = 31 - arg[2].imm;
-
-    if (shift == 24) {
-        tcg_gen_ext8s_i32(arg[0].out, arg[1].in);
-    } else if (shift == 16) {
-        tcg_gen_ext16s_i32(arg[0].out, arg[1].in);
-    } else {
-        TCGv_i32 tmp = tcg_temp_new_i32();
-        tcg_gen_shli_i32(tmp, arg[1].in, shift);
-        tcg_gen_sari_i32(arg[0].out, tmp, shift);
-    }
+    tcg_gen_sextract_i32(arg[0].out, arg[1].in, 0, arg[2].imm + 1);
 }
 
 static uint32_t test_exceptions_simcall(DisasContext *dc,
-- 
2.34.1



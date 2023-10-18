Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 044E87CEAE0
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 00:01:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtEVs-0002Y7-RE; Wed, 18 Oct 2023 17:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVn-0002Kb-4i
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:31 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qtEVl-00059R-Ld
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 17:55:30 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-57b68556d6dso4072750eaf.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 14:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697666128; x=1698270928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmtUHmtXH5nM9zU0wQnJIph+Od9hcdbRCgT1SyGzFJs=;
 b=Ufqo76M35ipkczg50/t8lsFqkadgAVTnQVfWGfj7AMGPqGj66jNJLrl1eearz/UVyv
 IuZy9CejOQCNPUksCmxmuhf5ktljo5a0NkObIuuyqEfbHolNprpSLXqAQcBcDcw8o2dT
 RfUpY9nz2UM7wMvIc6Pf3wSkl7o2zKeHVSo4JoCjq0WT6THXRHowir3nUrtN+2AGUbrq
 mNUNlWCSp0dqqgVEWfy7rqjgvoSGaeejEIMh/9JUZUPotvSfn07wFBIg6eaYbuFMrr6P
 LUozrkCq8FxBz/Jhjb0QDzxwhxfp6wjOEiepPSOSFNvM2TK5ip6lSVo+bRk4KJpZgDvR
 Y2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697666128; x=1698270928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fmtUHmtXH5nM9zU0wQnJIph+Od9hcdbRCgT1SyGzFJs=;
 b=erjj+Pb/2F22DXvSOSdWPjIVkuO4wd6D052h9mpOVdKHYCiYbg7fWRT+G+FMZtAWf0
 cX0+jYhmxsK9baha06yvTjoFSIur5Utu+srHQhb/3htOhKbzg6L2l7IpfJt+88Zmv7Jh
 dg45Q0cAdqLUx4THkfehMxVSgWQ1hsSRUdUtE2H/wiaor/hZbeAu1vE1l6ZK5KRE1+FO
 dUsnZ7Wfp+HxYKjuA6uZr8BEtqwuFQM/e2bYy8u2AfEbCobIKJm5AoUZ8WQSM9SPrKOq
 JuW2zJPQAgGLd99Q2z44+vuY4S3O20bGzJlvBCLKcwl0HXWlWthaAnQbNSXM7yrNVFNF
 7zyA==
X-Gm-Message-State: AOJu0YzHO1HcTnMWRApKlOa2BkBAHQ2VVcUvlDYLUKWQWEkOkwJUIXvU
 Koyn1vet5rYgRzeqFz8p0k/X9xpTbyBtejjk4Cw=
X-Google-Smtp-Source: AGHT+IFTKDlg0Q8pGk2tIxOjZjoGuUrb5XI30zNxuP/W5HOwHeN9KYPGAxQwgjpT57FQwClw5Wye5Q==
X-Received: by 2002:a05:6358:f54:b0:143:5180:1700 with SMTP id
 c20-20020a0563580f5400b0014351801700mr274518rwj.27.1697666128380; 
 Wed, 18 Oct 2023 14:55:28 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 r15-20020aa7962f000000b006889348ba6esm3796263pfg.127.2023.10.18.14.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 14:55:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 60/61] target/hppa: Return zero for r0 from load_gpr
Date: Wed, 18 Oct 2023 14:51:34 -0700
Message-Id: <20231018215135.1561375-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018215135.1561375-1-richard.henderson@linaro.org>
References: <20231018215135.1561375-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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
 target/hppa/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 9a9876c529..a9e0e1706f 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -307,9 +307,7 @@ static void cond_free(DisasCond *cond)
 static TCGv_i64 load_gpr(DisasContext *ctx, unsigned reg)
 {
     if (reg == 0) {
-        TCGv_i64 t = tcg_temp_new_i64();
-        tcg_gen_movi_i64(t, 0);
-        return t;
+        return ctx->zero;
     } else {
         return cpu_gr[reg];
     }
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5E47E333E
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:51:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9F-0008IJ-9v; Mon, 06 Nov 2023 21:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9C-0008Gc-Gu
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:58 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9A-0005rf-3C
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:48:58 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-6ce344fa7e4so3171835a34.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325335; x=1699930135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sTeX8Z9KYrgukeCf1kRNaUbTN7Yqs8Pw5WY/NJNaehw=;
 b=ilCleaGyfl9klo7Sw6ZiOQ5+y95MogCeoZbwJkPPgcfKI25opOfUgwZVyfrZNXvKwa
 PLy6BKa6f1Pr262ocPrSw0fLD1r8Vi9P9BhhT9TPfhJZWQHPGv0nBcpvAAjt5aj3HReU
 ll4zXJbiQEIujIMVUsx0NuKsNVymEGp11oaArpeocmVS6IxRoRHvCx46db4NNXy61f9F
 jRulqFwR/0E3O0KOGeYiLno4v16Rhnn9Heiwr30AEc6G0JSeqsVelrZ8wYTQZyo8ZI0X
 0w+nXrcTJB8vkq5zb9b+NVfD5rFcYUMu/idAKxv2j6qsmpyb9BrGuyJG7omWAeb45BHp
 duzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325335; x=1699930135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sTeX8Z9KYrgukeCf1kRNaUbTN7Yqs8Pw5WY/NJNaehw=;
 b=M/RvwFNE9X4KLLkWUijNR6DYwv6UbfsFxwtjxLEoduYVF11TloJ7mSkhPB5YXKS3yO
 ee9B8FRn0bVDQ+zEZ4tfInVWFtU5THbvsp2SBOdE9uxH9Wr8kDMYo1OgzDn8bTJVdHr1
 j3H1m5wrGgk/fIICxRbQ1Ipqh0pPhuw+Gs1AtDMpGR4rL302fiibxeUw7Snms1E5poZ3
 0xxC/dXrw/of606kfdJTFwzQAgeT4fbZI4/JeTNz/++OoIJDWfQ9xxoVdIEqPqNPBwnd
 +72rZTCckhUuQQf0d80vt4eYtvzSBGDHpunbKCjPk5ThPJxCvtccw/Vac3e3elu5KvEg
 5wWQ==
X-Gm-Message-State: AOJu0YyB+HNpjq1uFbtUC4p5TXkbOaPjfb8YAqRKUco5IpE5eCfMRqvy
 JFvmFkGu5NBN8leI9Vj8gJzUNP1n/pTZXvmLZ8g=
X-Google-Smtp-Source: AGHT+IHVmB+iLBF0TNHqY/6ssBpb97SCrSILvOoS99eprgrJvZi0K0uvztHbX76znr/Jmx9qw/o+5w==
X-Received: by 2002:a9d:734b:0:b0:6bd:603:797f with SMTP id
 l11-20020a9d734b000000b006bd0603797fmr28788334otk.37.1699325334845; 
 Mon, 06 Nov 2023 18:48:54 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.48.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:48:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/35] tcg: Move vec_gen_* declarations to tcg-internal.h
Date: Mon,  6 Nov 2023 18:48:21 -0800
Message-Id: <20231107024842.7650-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x334.google.com
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

These are used within tcg-op-vec.c and tcg/host/tcg-target.c.inc.
There are no uses outside tcg/.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231029210848.78234-7-richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h | 4 ----
 tcg/tcg-internal.h          | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f5ec54f874..3f8b214376 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -21,10 +21,6 @@ void tcg_gen_op4(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg);
 void tcg_gen_op5(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
 void tcg_gen_op6(TCGOpcode, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
 
-void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
-void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
-void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
-
 void tcg_gen_op1_i32(TCGOpcode, TCGv_i32);
 void tcg_gen_op1_i64(TCGOpcode, TCGv_i64);
 void tcg_gen_op1i(TCGOpcode, TCGArg);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 40a69e6e6e..f18d282abb 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -83,4 +83,8 @@ static inline TCGv_i64 TCGV128_HIGH(TCGv_i128 t)
 
 bool tcg_target_has_memory_bswap(MemOp memop);
 
+void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
+void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
+void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
+
 #endif /* TCG_INTERNAL_H */
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A607DA913
	for <lists+qemu-devel@lfdr.de>; Sat, 28 Oct 2023 21:48:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwpG5-000504-R8; Sat, 28 Oct 2023 15:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFs-0004pC-QI
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:56 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qwpFq-0004BS-Gc
 for qemu-devel@nongnu.org; Sat, 28 Oct 2023 15:45:56 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3577ce73552so9702725ab.2
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698522353; x=1699127153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHAeumhj/k6eiqLtdrKjjL6mwObgsX5DY/BFSjKBF5I=;
 b=rJPO4EBxbkxoiPD9zN0NMAUZLNB8dVOTIdGQH48d75MezMMIN72BqO/4Otjjz5LjPv
 YuRl1AZAzxbHfd8TMIfEDCEvybrQaeG6YoEs37KsIhJGVTl0HtVGOG0Aj67VnzxODl2U
 3eloe0LEubNg96bp8jCVlrHfwkzmBTUm2fbCoj9Ts4D6TFQkrDDfi1RF5Xj6d4HosR2z
 tJiqZZTPw1rM5dInVrNapVKBUSDYyVLLuEcDjJ+/iGrFnOGyoZFEKGSR7ZCZRN5Swi5s
 rr3fLHI0CqRLrr2I2SihGNTUzWPJ/fMDvkCbCM20vKIm3Bb0JXDKl7WSpwq5ixTkF9KM
 fOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698522353; x=1699127153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EHAeumhj/k6eiqLtdrKjjL6mwObgsX5DY/BFSjKBF5I=;
 b=dyJbIEG/BIaHBFH7WdArxe+TIsZAbjvYC5nRjs4Gk9JaffqBQ4qXylZKpXKjDMM6hz
 Oda6WGNnL/wu8l3Vw6qGZmIZMDKd3W2SAl7H9hqQf+iCHt0SozAtq0hanRIMxpeVP63s
 6DaAi4m74k7+Zodtbb1aPWpNgY165NJgVxeyYxuT/j7o0xpywQHer9s4gGPmxGJYTbiL
 73U7rIX/dbBgMVilrHCX0CXQeTsUJV8eCArIA7m9Io2wZQbFG/Tyx5Ati2mVbs0Rfdv+
 JMjOHjzZHVbCn/sePvsxAmIcuTvR2JATkN3FNZdyqTtH1pXAt4FuDR/+mFsvZkyibvRY
 k/9g==
X-Gm-Message-State: AOJu0Yz7Lfp+WVailmTKtuoTQwUdtSkKWHEBia+dBpjQrc1MD0r4stVG
 wR0ly3k1ZFIjTZ60RGJe5Zar8iEhYoOWIRSU6bE=
X-Google-Smtp-Source: AGHT+IF9x8ITcdhYE6zynW+aFMxHEZorA8qXJ20hPsU9RuBq58tGp2+bQkjy2501wzm4Ys9YPMI13g==
X-Received: by 2002:a92:cdae:0:b0:34c:e6e6:80d5 with SMTP id
 g14-20020a92cdae000000b0034ce6e680d5mr8454609ild.26.1698522353510; 
 Sat, 28 Oct 2023 12:45:53 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 h9-20020a170902f7c900b001b8a3e2c241sm3600096plw.14.2023.10.28.12.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Oct 2023 12:45:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pbonzini@redhat.com
Subject: [PATCH v2 33/35] target/alpha: Use TCG_COND_TST{EQ, NE} for CMOVLB{C,
 S}
Date: Sat, 28 Oct 2023 12:45:20 -0700
Message-Id: <20231028194522.245170-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028194522.245170-1-richard.henderson@linaro.org>
References: <20231028194522.245170-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12d.google.com
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



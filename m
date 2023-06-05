Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D05B9721C47
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 04:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q60N9-0008JB-DQ; Sun, 04 Jun 2023 22:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q60N6-0008In-Es; Sun, 04 Jun 2023 22:55:05 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q60N4-0002ad-HL; Sun, 04 Jun 2023 22:55:04 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-53f158ecfe1so2222209a12.0; 
 Sun, 04 Jun 2023 19:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685933700; x=1688525700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mS4ZIDQaQTnEUtNvU7I+ova9jxNbSX7aL519hDxz+dk=;
 b=RVWSVBHyEkfQQzpQXaGEShuO/MfLPDpTRTUfMDFw5vZuANHXHfWjQ6o/mHYT5tFcnf
 EOIQMz2rrFhsAaxrUCVmCaXCs1tfKw9Y90KDdNC8P5yuND3vrmwWKa+gHcVq7P+zrbjV
 mYx72lhFuq+BsyjH/zhLbQ/OKOjacya57Sh0STbiQ49h0jegE72oSMk+en5ugxdv2zGa
 w3oXEVJEA6Ho5VxLRqyJg/MdFVRaJ8O8SJkrj4dWx/zgoFbNW9MS7rv7KMnX2iAoFtMt
 LvPVgb6v8PxMykJFN9grnOHLPFW/RJG6YUP4pmqZDAom3U3Dbg6QJU9kG+mIIKq6V3Oz
 jgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685933700; x=1688525700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mS4ZIDQaQTnEUtNvU7I+ova9jxNbSX7aL519hDxz+dk=;
 b=PQHjGExgtl2vXB6jdxZmjZSL3sdFTkyK1wjfZCVpOMeOE81l+3CLIhBtbVWTxKHaOm
 pNw9TZYZjW2BLgFjZo+KOmAAfm/TYg/0vPYHxkaXNSQSCj93xer51D06E5gfqC1EbJ1u
 7C42jimYis/Wr+J2BIpxdZ8g1gUlfeFD6JfcSg3RQ6uz3WUH2m2w6RzTE4nDUoGER7GK
 VP77xKjDnvzT5pALk2v0QFG/I4lpvt9PSCY7Jd6GjRgR+PgpVT8uzXuGGAxPuk97jmv8
 POAQcyFbTstTzgjYN57jqbx+0+0Gt8tke88a6UhsWDu4yCx3oKGYiQuvrd4fbqRx79gd
 SfuA==
X-Gm-Message-State: AC+VfDzcM6xORG3NIS4TJz4mk1L3+8jmyw3VcuIEwRkepr7MwA835zGP
 Dq1PS8fxL6RPRnmmQ5S0LPbf2Erdag0=
X-Google-Smtp-Source: ACHHUZ5DMFyMgW3ca7UyPN46EjXFtu+txY6znp3JKp24Bute8ncb8FqRGqODmuvkMPGzBIizeCYGSg==
X-Received: by 2002:a17:903:41ce:b0:1b0:6541:91c2 with SMTP id
 u14-20020a17090341ce00b001b0654191c2mr2729685ple.63.1685933700379; 
 Sun, 04 Jun 2023 19:55:00 -0700 (PDT)
Received: from wheely.local0.net ([203.221.142.9])
 by smtp.gmail.com with ESMTPSA id
 q5-20020a170902c74500b001ae59169f05sm5316778plq.182.2023.06.04.19.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Jun 2023 19:54:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH v2 3/4] target/ppc: Remove larx/stcx. memory barrier semantics
Date: Mon,  5 Jun 2023 12:54:44 +1000
Message-Id: <20230605025445.161932-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605025445.161932-1-npiggin@gmail.com>
References: <20230605025445.161932-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

larx and stcx. are not defined to order any memory operations.
Remove the barriers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 538f757dec..acb99d8691 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3592,7 +3592,6 @@ static void gen_load_locked(DisasContext *ctx, MemOp memop)
     tcg_gen_mov_tl(cpu_reserve, t0);
     tcg_gen_movi_tl(cpu_reserve_length, memop_size(memop));
     tcg_gen_mov_tl(cpu_reserve_val, gpr);
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_LDAQ);
 }
 
 #define LARX(name, memop)                  \
@@ -3836,11 +3835,6 @@ static void gen_conditional_store(DisasContext *ctx, MemOp memop)
 
     gen_set_label(l1);
 
-    /*
-     * Address mismatch implies failure.  But we still need to provide
-     * the memory barrier semantics of the instruction.
-     */
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
 
     gen_set_label(l2);
@@ -3944,11 +3938,6 @@ static void gen_stqcx_(DisasContext *ctx)
     tcg_gen_br(lab_over);
     gen_set_label(lab_fail);
 
-    /*
-     * Address mismatch implies failure.  But we still need to provide
-     * the memory barrier semantics of the instruction.
-     */
-    tcg_gen_mb(TCG_MO_ALL | TCG_BAR_STRL);
     tcg_gen_trunc_tl_i32(cpu_crf[0], cpu_so);
 
     gen_set_label(lab_over);
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FC072ABC0
	for <lists+qemu-devel@lfdr.de>; Sat, 10 Jun 2023 15:34:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7yhz-00055A-80; Sat, 10 Jun 2023 09:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhw-00052Q-Tw; Sat, 10 Jun 2023 09:32:44 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1q7yhv-0007iU-Aj; Sat, 10 Jun 2023 09:32:44 -0400
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-39a523e8209so1095669b6e.0; 
 Sat, 10 Jun 2023 06:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686403962; x=1688995962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UBgWfsi2CiBVVjPTHqCM9PgrPqB1QcurXMTBVR1Eyak=;
 b=CBJNHDunaC7/e352mHsjqXB8jz3egy/6Ty1dT8ensvtTnfd7vXUYyH2Gg+2cJqKTsh
 QJveTAZNbkK2VAVnJ5FAYB2nwxln4y+XvMr4SdDbRhMbulPC6G45KxBqu+ajyuuJ9Z62
 wpRzyPMf9uyoBPknRmF8Imyhl+b8YlCahHTnrGDX7oGA9O5xo1lR8QOKNTVKV3rv0mT3
 2V8e9EB8Mt4lQGLacrD4kJa0w+YN4A7TeSmQoLILmW2xbFSfpkaeK7IigBHYPT+euxkN
 m70qiSyEmWE9sV2npc6eQskdtWfmUcbBBDprhps/gHvZtR0hsCZwRF5z8zsT4wNg3kTj
 xb5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686403962; x=1688995962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UBgWfsi2CiBVVjPTHqCM9PgrPqB1QcurXMTBVR1Eyak=;
 b=StzIDozcIHwHj02G0QZHGFB2sVGbXiReKd5do5vcr2TxvY8o5WaN6o4H4lqPZiR3Wz
 WqgQS5uQh1ByuHhKWPfzxLVfLbFl1dzXAAQer0WtNxjLmuU+LasNQEtmMCdpDlT23YGT
 eKtmKCvB84XrjfbOp2rkht9YJVABaPxMadRNL7Y1bVainiIKArTrxV50IdDZsv3TeauW
 lGAzS/bncn9Vso7qXFxUAN39wG3FRpViBMMbp4nq2UVQ1euS4CXpUg+G/VULZjCheeOv
 Kd6BjD88c0SdpNizt3jmk6BbNBI0uznFGZo1P+2WY92iFL79D/wgaDg2e1QV6jDptwdw
 8p6g==
X-Gm-Message-State: AC+VfDyFABBfQx/6/jYUDXfCXUIZxOJwf8z9FcSI/MRvp+hiZYr6mr3y
 LqXnjNE6/zUYkN7VeC1RFh5q8lakD84=
X-Google-Smtp-Source: ACHHUZ6v7XdYjHbJjIzR+Gs70bm8UF98zZR8wVwcsGcy2DQ3YkFjle/AJVcvSyqo953yak1MLNnG1g==
X-Received: by 2002:a05:6808:2215:b0:39a:53c7:21cd with SMTP id
 bd21-20020a056808221500b0039a53c721cdmr1062104oib.35.1686403961797; 
 Sat, 10 Jun 2023 06:32:41 -0700 (PDT)
Received: from grind.. ([177.170.117.52]) by smtp.gmail.com with ESMTPSA id
 y3-20020a544d83000000b00395f2c84b81sm2428420oix.54.2023.06.10.06.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Jun 2023 06:32:41 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, danielhb413@gmail.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 sdicaro@DDCI.com
Subject: [PULL 25/29] target/ppc: Decrementer fix BookE semantics
Date: Sat, 10 Jun 2023 10:31:28 -0300
Message-Id: <20230610133132.290703-26-danielhb413@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230610133132.290703-1-danielhb413@gmail.com>
References: <20230610133132.290703-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=danielhb413@gmail.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Nicholas Piggin <npiggin@gmail.com>

The decrementer store function has logic that short-cuts the timer if a
very small value is stored (0, 1, or 2) and raises an interrupt
directly. There are two problem with this on BookE.

First is that BookE says a decrementer interrupt should not be raised
on a store of 0, only of a decrement from 1. Second is that raising
the irq directly will bypass the auto-reload logic in the booke decr
timer function, breaking autoreload when 1 or 2 is stored.

Fix this by removing that small-value special case. It makes this
tricky logic even more difficult to reason about, and it hardly matters
for performance.

Cc: sdicaro@DDCI.com
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-Id: <20230530131214.373524-2-npiggin@gmail.com>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/ppc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index d80b0adc6c..1b1220c423 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -811,11 +811,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
     }
 
     /*
-     * Going from 2 -> 1, 1 -> 0 or 0 -> -1 is the event to generate a DEC
-     * interrupt.
-     *
-     * If we get a really small DEC value, we can assume that by the time we
-     * handled it we should inject an interrupt already.
+     * Going from 1 -> 0 or 0 -> -1 is the event to generate a DEC interrupt.
      *
      * On MSB level based DEC implementations the MSB always means the interrupt
      * is pending, so raise it on those.
@@ -823,8 +819,7 @@ static void __cpu_ppc_store_decr(PowerPCCPU *cpu, uint64_t *nextp,
      * On MSB edge based DEC implementations the MSB going from 0 -> 1 triggers
      * an edge interrupt, so raise it here too.
      */
-    if ((value < 3) ||
-        ((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
+    if (((tb_env->flags & PPC_DECR_UNDERFLOW_LEVEL) && signed_value < 0) ||
         ((tb_env->flags & PPC_DECR_UNDERFLOW_TRIGGERED) && signed_value < 0
           && signed_decr >= 0)) {
         (*raise_excp)(cpu);
-- 
2.40.1



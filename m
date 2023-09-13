Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF8079DD53
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 03:00:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgEDW-0001rX-FY; Tue, 12 Sep 2023 20:58:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgEDF-0001oY-1T; Tue, 12 Sep 2023 20:58:37 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qgEDB-0003Oi-MY; Tue, 12 Sep 2023 20:58:36 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-54290603887so4543818a12.1; 
 Tue, 12 Sep 2023 17:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694566710; x=1695171510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wec+1gma7CHiSPbD5IWoGEup4kbp/bBLdKCCKirXeic=;
 b=ss/9qfZIx89Q+TS2/4uVxiAdxeWII9QN1Yhuba3WHGZ4gR1m0LBxqyf6eyj0XKZiLk
 PAoAeMsIrN4C029H8n9ZOp2GP/3tnYE+99rddGPS1Htcard5iAu0T+KhnEyh64fKjBto
 PXBkK+ZEUHNIeqP+uBam0VL0RIb+vulA1kzUIOWL7ksQB2k80qCOt5HZMDW8flbp7qvF
 djIfQdFS49ezXWA4B/eT9pkeIVwQMI5Vchqt9Mo8AKW+fKk9tEgU/ieShCx3EtHU81NP
 XvHAe3C3pZ2sMNf42Ve1mv1FADilLE71ZfMK1mL8Qd/upEAjMYZz9+PD6Oyk9PVi5ISo
 87Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694566710; x=1695171510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wec+1gma7CHiSPbD5IWoGEup4kbp/bBLdKCCKirXeic=;
 b=XZhIEzKLu1c92v6b4u/Rru0diJvICGShCbgYEbg+6jMqGMNzZU1iNA7TM3shtbJ9zD
 P7i9Kg9gt/vZmZMOzy7gsfHoZ1awo+3ge6HavNd7lf8Inu5Pcntlu5zMAxxFYfA2fP3l
 ny1/uyRSf1j1p/e+pCre4iuRYn45xLxB6hTiSslJrn32NNZgono59IuYCmg0+lfRVX3O
 cAIGkbtl8itqlNWe9ghHc3h4wxPMr7T6l5CIEFoILqlVWaDIkqaLrYQcnXQk4/BqEb9V
 JMjv6P9o07YmY1kcXyJsDN0q7c0NUHUWpiNIuSZbdLLWyorqu1l9A0X4LBIe0m6IsaNS
 tDNg==
X-Gm-Message-State: AOJu0YysDZ7KpTTDbOdTG6imHoVzPsJt2xMi8TP5RglrkeTcOjBK+ZwD
 zv+2pUSiCvxh76zN2PnrV7MBxX7vtVo=
X-Google-Smtp-Source: AGHT+IHiNQFaSmyMMHzsiVL4YeznCXIoyXvpQxcAihp9xUPEwoYr0VYE3Vufte81q4NLBLoZ3UuOOw==
X-Received: by 2002:a05:6a21:3387:b0:14d:7511:1c1 with SMTP id
 yy7-20020a056a21338700b0014d751101c1mr1129790pzb.49.1694566710677; 
 Tue, 12 Sep 2023 17:58:30 -0700 (PDT)
Received: from wheely.local0.net ([193.114.103.68])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a17090a588200b0026f4bb8b2casm208868pji.6.2023.09.12.17.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 17:58:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org
Subject: [RFC PATCH 2/3] target/ppc: Use FP CR1 update helper more widely
Date: Wed, 13 Sep 2023 10:58:13 +1000
Message-Id: <20230913005814.413113-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230913005814.413113-1-npiggin@gmail.com>
References: <20230913005814.413113-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Several places open-code this FP CR1 update. Move them to call
gen_set_cr1_from_fpscr().

FPSCR_OX = 28 so move that to the symbolic constant while we are here.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate/fp-impl.c.inc | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/target/ppc/translate/fp-impl.c.inc b/target/ppc/translate/fp-impl.c.inc
index 4e355cb379..9f71c039ce 100644
--- a/target/ppc/translate/fp-impl.c.inc
+++ b/target/ppc/translate/fp-impl.c.inc
@@ -20,12 +20,12 @@ static void gen_set_cr1_from_fpscr(DisasContext *ctx)
 {
     TCGv tmp = tcg_temp_new();
     tcg_gen_mov_tl(tmp, cpu_fpscr);
-    tcg_gen_shri_tl(cpu_crf[1], tmp, 28);
+    tcg_gen_shri_tl(cpu_crf[1], tmp, FPSCR_OX);
 }
 #else
 static void gen_set_cr1_from_fpscr(DisasContext *ctx)
 {
-    tcg_gen_shri_tl(cpu_crf[1], cpu_fpscr, 28);
+    tcg_gen_shri_tl(cpu_crf[1], cpu_fpscr, FPSCR_OX);
 }
 #endif
 
@@ -694,8 +694,7 @@ static void gen_mtfsb0(DisasContext *ctx)
         gen_helper_fpscr_clrbit(cpu_env, tcg_constant_i32(crb));
     }
     if (unlikely(Rc(ctx->opcode) != 0)) {
-        tcg_gen_mov_tl(cpu_crf[1], cpu_fpscr);
-        tcg_gen_shri_tl(cpu_crf[1], cpu_crf[1], FPSCR_OX);
+        gen_set_cr1_from_fpscr(ctx);
     }
 }
 
@@ -714,8 +713,7 @@ static void gen_mtfsb1(DisasContext *ctx)
         gen_helper_fpscr_setbit(cpu_env, tcg_constant_i32(crb));
     }
     if (unlikely(Rc(ctx->opcode) != 0)) {
-        tcg_gen_mov_tl(cpu_crf[1], cpu_fpscr);
-        tcg_gen_shri_tl(cpu_crf[1], cpu_crf[1], FPSCR_OX);
+        gen_set_cr1_from_fpscr(ctx);
     }
     /* We can raise a deferred exception */
     gen_helper_fpscr_check_status(cpu_env);
@@ -750,8 +748,7 @@ static void gen_mtfsf(DisasContext *ctx)
     get_fpr(t1, rB(ctx->opcode));
     gen_helper_store_fpscr(cpu_env, t1, t0);
     if (unlikely(Rc(ctx->opcode) != 0)) {
-        tcg_gen_mov_tl(cpu_crf[1], cpu_fpscr);
-        tcg_gen_shri_tl(cpu_crf[1], cpu_crf[1], FPSCR_OX);
+        gen_set_cr1_from_fpscr(ctx);
     }
     /* We can raise a deferred exception */
     gen_helper_fpscr_check_status(cpu_env);
@@ -779,8 +776,7 @@ static void gen_mtfsfi(DisasContext *ctx)
     t1 = tcg_constant_i32(1 << sh);
     gen_helper_store_fpscr(cpu_env, t0, t1);
     if (unlikely(Rc(ctx->opcode) != 0)) {
-        tcg_gen_mov_tl(cpu_crf[1], cpu_fpscr);
-        tcg_gen_shri_tl(cpu_crf[1], cpu_crf[1], FPSCR_OX);
+        gen_set_cr1_from_fpscr(ctx);
     }
     /* We can raise a deferred exception */
     gen_helper_fpscr_check_status(cpu_env);
-- 
2.40.1



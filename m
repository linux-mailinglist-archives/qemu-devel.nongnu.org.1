Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3E677376A
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:13:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTD8M-0008Lt-WC; Mon, 07 Aug 2023 23:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTD8I-0008K3-Ud; Mon, 07 Aug 2023 23:11:42 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTD8G-0008Vy-Ee; Mon, 07 Aug 2023 23:11:41 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-55fcc15e109so2860709a12.3; 
 Mon, 07 Aug 2023 20:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691464299; x=1692069099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DdO+BgECe+NBqSgQRBKGGSekj1Ses6+qG4z/10qrFu4=;
 b=LaxAb0tnWl+Cas3A4/SxcjS2iv3mtQmkfOQHPJl9ZlLs7Zrk0wHI7qNJ5JlD0FCFVm
 WXxBh0d7B2VpVt55tA7eiLMUGvBf+5q4GfIwc2YYhpo/ly+VcjcJlJEXWV+GW+FKYVde
 zgFMq/24D+0+hQFlm2G1SoUqgp4EpV9+X+FUaUwVMsTN+CNIaA8Xq+rd9jNgOdaa3vdY
 AITh0aqzgVd7im1z8XIRi/PilIfZxuoQG18ioL/wsdJMh11D+KZRN57Joy/ewHbZXby4
 fh6xUk5ngv1OufGqiuXL0q744UWqMhZdT1IpJNBtX6XccDmNNE8XmZZGYpC6hOGB/BPb
 NV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691464299; x=1692069099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DdO+BgECe+NBqSgQRBKGGSekj1Ses6+qG4z/10qrFu4=;
 b=AqjCfctyk8Q6Q68ew7oSJoIVVoF9RNpbxXqF0El5t1EX63F4unpYTF+jFi22WN4egZ
 0d/lhwJY1pPb8TF8dcNgRZmrLypV1uLEQ7iL4L4AikYgTwuUMOtvk/Pql2Q+YL0DfFBo
 K6o9YP+6KfprwWKZhTm1/8xfqhcxilN22sxdQ3mHmJk9hiDwsfmLXB0WoWQxuZKbmRgh
 vhB760Rsi7wr4c1mLzhsUqfRISnz0dEsMPwKl5gL606XunrRUFIJrA82egEjT/RxRISm
 gNNwA4rTfgf5XBu2e0FY/j2BecnhMkWotmShWoaRCNTmgIkCizYvZHya6MiEJTCijluD
 rM1A==
X-Gm-Message-State: AOJu0Yzg/7l6ZM2utId9D0D5VzMT75U6gML5/esjsXCCgNpKrAnPX5C5
 rkE3uxFV/d52dinl2JFg4tk=
X-Google-Smtp-Source: AGHT+IFlFgxPiOAqxlG46MvqtmpXqEmxMKS7TNaYBGDo2ayu+deqFtQHjIYcPmvN5A6OIALfsNjB6w==
X-Received: by 2002:a05:6a20:728a:b0:133:dc0a:37e7 with SMTP id
 o10-20020a056a20728a00b00133dc0a37e7mr11270661pzk.13.1691464298665; 
 Mon, 07 Aug 2023 20:11:38 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 i21-20020aa79095000000b00687ce7c6540sm482642pfa.99.2023.08.07.20.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:11:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH 3/6] target/ppc: Suppress single step interrupts on rfi-type
 instructions
Date: Tue,  8 Aug 2023 13:11:13 +1000
Message-Id: <20230808031116.398205-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808031116.398205-1-npiggin@gmail.com>
References: <20230808031116.398205-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x534.google.com
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

BookS does not take single step interrupts on completion of rfi and
similar (rfid, hrfid, rfscv). This is not a completely clean way to
do it, but in general non-branch instructions that change NIP on
completion are excluded.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/translate.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5051596670..6e8f1797ac 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -338,7 +338,7 @@ static void gen_ppc_maybe_interrupt(DisasContext *ctx)
  * The exception can be either POWERPC_EXCP_TRACE (on most PowerPCs) or
  * POWERPC_EXCP_DEBUG (on BookE).
  */
-static void gen_debug_exception(DisasContext *ctx)
+static void gen_debug_exception(DisasContext *ctx, bool rfi_type)
 {
 #if !defined(CONFIG_USER_ONLY)
     if (ctx->flags & POWERPC_FLAG_DE) {
@@ -357,10 +357,12 @@ static void gen_debug_exception(DisasContext *ctx)
                                    tcg_constant_i32(POWERPC_EXCP_DEBUG));
         ctx->base.is_jmp = DISAS_NORETURN;
     } else {
-        TCGv t0 = tcg_temp_new();
-        tcg_gen_movi_tl(t0, ctx->cia);
-        gen_helper_book3s_trace(cpu_env, t0);
-        ctx->base.is_jmp = DISAS_NORETURN;
+        if (!rfi_type) { /* BookS does not single step rfi type instructions */
+            TCGv t0 = tcg_temp_new();
+            tcg_gen_movi_tl(t0, ctx->cia);
+            gen_helper_book3s_trace(cpu_env, t0);
+            ctx->base.is_jmp = DISAS_NORETURN;
+        }
     }
 #endif
 }
@@ -7412,6 +7414,8 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 
     /* Honor single stepping. */
     if (unlikely(ctx->singlestep_enabled & CPU_SINGLE_STEP)) {
+        bool rfi_type = false;
+
         switch (is_jmp) {
         case DISAS_TOO_MANY:
         case DISAS_EXIT_UPDATE:
@@ -7420,12 +7424,19 @@ static void ppc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             break;
         case DISAS_EXIT:
         case DISAS_CHAIN:
+            /*
+             * This is a heuristic, to put it kindly. The rfi class of
+             * instructions are among the few outside branches that change
+             * NIP without taking an interrupt. Single step trace interrupts
+             * do not fire on completion of these instructions.
+             */
+            rfi_type = true;
             break;
         default:
             g_assert_not_reached();
         }
 
-        gen_debug_exception(ctx);
+        gen_debug_exception(ctx, rfi_type);
         return;
     }
 
-- 
2.40.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 278F17C7F7D
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:07:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCxb-0007ig-A8; Fri, 13 Oct 2023 03:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwm-0005Pl-RW
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:03 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwX-0004pw-QP
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:00 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so1646569f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183443; x=1697788243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9mvFmC/3JVqTJ99T7u6WfFCi7B0jEk8tUt/iiTq4lI=;
 b=R+YnEHDiC4/LwnjtgFHyh92Cr9Yo76kAYuAu2V46VZXq9GdAMTjY4mEEsZyAg1ca8j
 WIexnAvhOWEzgqqN1V2bBgSAFhl9MId2Uw+6DNb2ZYT3pco8ZDu3p11P1rMeGvGKovRb
 irLQQBNfxHFx8H1X6IR0fidOwydFBKWVpdPmhX60ipBlRlNm1z4PBqGLImuCj6f7ohFv
 4QcQ+oczNeVkXq2QVDhCF96M4Fs9ZZ8eVDJaIjPlkCZgVXTQVqFvaveTjTbEVWqr44Vo
 95VFYIV+Cs3AMQ8ESsr0n4joHlS1BUILdjPLnZsAtMcC895+183jKDdWYswZMAKUWV3q
 DmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183443; x=1697788243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b9mvFmC/3JVqTJ99T7u6WfFCi7B0jEk8tUt/iiTq4lI=;
 b=MUYO4Hd0Y66WQqd4AOqTmhH4SzufZ0OaMbINR6LmMu7KIX/lk5o1nNEzBBLKyLocB7
 9EHiZkI4sPUyMULdhMbw1atvNYzUwHWqeOC3gBuo4WiTX657WsOk554vBDabNSSqIMEG
 iswGztUsghICoEFamXHaB9KKozk2DkjXEfIuya5N0J9crF19lfdVxcqVUafu7n8BSNiy
 IIDpZqL6AiiJtS6lPncdIAuln2M3tnVIyO65Bb60KE2ALl81M6gQvGJJn5TUhqJynt58
 ZMgDrxCuLtA288dVHWDd4cgxKAZAPlx1iamGfOTdq3EQciOpjkjZfDsUXgb7vU2o7NjX
 2c3w==
X-Gm-Message-State: AOJu0Yyd80CocYYqwlQICpiI8NrfmU6zwnS223AaAe6MVoamYt3rcOTB
 dOW/3coenrQJF+NN3mQFXfz6pSwEyiiVeRQcEgI=
X-Google-Smtp-Source: AGHT+IH7eSeuESHp7VosxCk60oxmj3gpYmuwV87pRm2xq8VACW3ViOCIgSK410Qg+VZUgNI2ikEkvQ==
X-Received: by 2002:adf:ecc3:0:b0:319:7c0f:d920 with SMTP id
 s3-20020adfecc3000000b003197c0fd920mr24611216wro.57.1697183443314; 
 Fri, 13 Oct 2023 00:50:43 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.50.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:50:42 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [RFC PATCH 28/78] target/avr: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:32 +0300
Message-Id: <b0cb0572850df62369f0841172b651218bfb15e2.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 target/avr/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index cdffa04519..2043677745 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2753,37 +2753,37 @@ static void avr_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 static void avr_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     bool nonconst_skip = canonicalize_skip(ctx);
     /*
      * Because we disable interrupts while env->skip is set,
      * we must return to the main loop to re-evaluate afterward.
      */
     bool force_exit = ctx->base.tb->flags & TB_FLAGS_SKIP;
 
     switch (ctx->base.is_jmp) {
     case DISAS_NORETURN:
         assert(!nonconst_skip);
         break;
     case DISAS_NEXT:
     case DISAS_TOO_MANY:
     case DISAS_CHAIN:
         if (!nonconst_skip && !force_exit) {
             /* Note gen_goto_tb checks singlestep.  */
             gen_goto_tb(ctx, 1, ctx->npc);
             break;
         }
         tcg_gen_movi_tl(cpu_pc, ctx->npc);
-        /* fall through */
+        fallthrough;
     case DISAS_LOOKUP:
         if (!force_exit) {
             tcg_gen_lookup_and_goto_ptr();
             break;
         }
-        /* fall through */
+        fallthrough;
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
     default:
         g_assert_not_reached();
     }
 }
-- 
2.39.2



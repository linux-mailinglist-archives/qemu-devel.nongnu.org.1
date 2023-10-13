Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 207E57C7F36
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:01:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD4d-0001Re-6J; Fri, 13 Oct 2023 03:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4W-0000ym-OT
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:01 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD4S-0006vS-EQ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:58 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-503056c8195so2456351e87.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183928; x=1697788728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9mvFmC/3JVqTJ99T7u6WfFCi7B0jEk8tUt/iiTq4lI=;
 b=iwU97vr7D+8eEVmXVQ/2LnOikRpOroRzKT0pdv8W46KTnzBk6Qo+1xNyVlMIDYPoEu
 APSpXTZ2oETELb7xHBL9L7agTIHSpUm00VUypEHZeskIIC5BLWEFeAnml8Q3ckeJ1TNk
 X2avcu+qF8fGlSo5KLKLxVkHFQy6tpWNsm6HPIQo07OhYh1i3yXYrGwnMGy2Vr08eRJW
 GbGbtwXRSI7vyRPZaI/md77H3YRGyoOwdFgJ0WeIEYGyqeR4jN+1plTmCASIq1E+puyY
 kcV6WbWTQVOVoSs1W+3ihjhA4OjU6rYXjoUneUpYETO9OcF2A7PPO7bl+W+9RKlbmRWc
 BAqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183928; x=1697788728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b9mvFmC/3JVqTJ99T7u6WfFCi7B0jEk8tUt/iiTq4lI=;
 b=PWWIqrEdARToo9LfGWSU85m0B4N0+/ndpaIMjuN0/DlYFLHuWjj0R0PKjLFBDub/Y/
 eLhXKEvfc3tUoJ/YpHAv9hnUD4iqCUm9K1XhxdlvmeN5RbugfNfwnygZnI7giC4IG7jk
 TqPylS+F2OYsMEIpuZuMDq8ExMr88lI8kfA6n6NjejcfZXkCFvnvAiAN+Bipgyf5fG43
 P5UhWPQEF56FEdAv4JFxWU0HjmGRUpRRrVUcgnKS6JP6Wlh3ISlKR6Y2tPDpJKi+tOO9
 ISZJMyS0DHTYZqIUHoGARCWiFEQZNkmpH5ekVXz7DvFvCVZmpKXuVQYLNioS9/GSvGa8
 4urw==
X-Gm-Message-State: AOJu0Yx5VLJHJdtPXxqMDhLX6Hn9qCcs+F5zHJdIgFt/pAMv+lpLdjpL
 IuY1z4lkQWju76cjkpXRRP3tc1abj4htx+OoAIo=
X-Google-Smtp-Source: AGHT+IGNPx1Qpic8bmsqwCa47Pem8ZyCikI5Htxzfbchj6ALLA/4xNy6jTnr2j5RzqJ/IVTRANjYPg==
X-Received: by 2002:a05:6512:3146:b0:500:bbd4:970f with SMTP id
 s6-20020a056512314600b00500bbd4970fmr19499496lfi.5.1697183928372; 
 Fri, 13 Oct 2023 00:58:48 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:47 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>
Subject: [RFC PATCH v2 28/78] target/avr: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:55 +0300
Message-Id: <b0cb0572850df62369f0841172b651218bfb15e2.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12b.google.com
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



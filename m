Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A017C7F2B
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:00:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCxZ-0007Q2-Bz; Fri, 13 Oct 2023 03:51:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwo-0005W1-8o
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:03 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCwY-0004qP-KE
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:01 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3247cefa13aso1641234f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183445; x=1697788245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZ1hqe+Fu2cE5EdVcsb+6IpRINRQWQg+aUhoqPZ6lw8=;
 b=usX8gcE8ufOM6VuBZfbJAL0IQI33/S54PwFD0T/lsi8Z+RFhOyRE5qeg3LcISPiInW
 J9Vw7HejD7jwriCKTKZt9TGZYUq9g2AX2vLc/oORR361P3UgDWhQ5pi/5fbQKhxfDgu8
 WvPavLV5LRpDew2ULQppPbUumIRECpRq31KgIyCmA3704n66h+iWaQs/oFC7kzph/6+h
 e58m2NInkt7b/ocK+v1UB6MON4nAUC04IKFJ1O3xh4pSzQeMznulSKaMwERk+uTFGH8z
 vNPKePTr+6Q6N5rLwq3ZnCfSTh7EIe+o+lqFekxc7huSBFo0GYWYSvW3GahN5xVGXMNC
 QzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183445; x=1697788245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aZ1hqe+Fu2cE5EdVcsb+6IpRINRQWQg+aUhoqPZ6lw8=;
 b=w+rfbODdcbPBSYpoGutBs6H/adFRrEyQSr6v7tnCW0K0WyNcKNIe0xehwaMZpUBMnJ
 qJdhLazolnWBrNkKX5DZ8CuvF92pD4sY2muAhZHQoOpiPYX3id+6XpFI4dRPzTNTei61
 UXF3PeC76nfo/cZpUh1fJT7Bx3Pk8NVqnyHv3hK4selmauBOv5gJSu7bcKVIOn6wNS9h
 Jd9qtOUptt4jLQrtGKQBz49mjk5KwspNAdVY5AYEFUYx80md7YAGcPvZ5CxJlXEjN/u/
 CzEgbsfB6yMdtBXpGDF0ZuGy1rI1sxMeeQ5yNMWO11o2BGIKvMBypNyJqT9AnJBEfzR/
 /qFw==
X-Gm-Message-State: AOJu0YxNrHoeCWvwkv0fKrgZLD9WCBbzmsHXkf3RFZJ52oTtGMQY3j/K
 9Wd2RcLrqYIV4B7Edc2xXocx01gCwNQ+k8jfuxw=
X-Google-Smtp-Source: AGHT+IFaFuiufMmf7iQH5j/W06rYgO1j8R2RWNvFt3VD5OL1GsxsD3i0ey4yliuS2EsS/9qZk+UeWA==
X-Received: by 2002:a5d:58ca:0:b0:31f:f65f:74ac with SMTP id
 o10-20020a5d58ca000000b0031ff65f74acmr20962360wrf.70.1697183444894; 
 Fri, 13 Oct 2023 00:50:44 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:50:44 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [RFC PATCH 29/78] target/cris: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:33 +0300
Message-Id: <295dcd972e29e2d4adb367e52199d7e412906405.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x432.google.com
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
 target/cris/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index b3974ba0bb..bdd128db23 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3061,94 +3061,94 @@ static void cris_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
 static void cris_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
     DisasJumpType is_jmp = dc->base.is_jmp;
     target_ulong npc = dc->pc;
 
     if (is_jmp == DISAS_NORETURN) {
         /* If we have a broken branch+delayslot sequence, it's too late. */
         assert(dc->delayed_branch != 1);
         return;
     }
 
     if (dc->clear_locked_irq) {
         t_gen_movi_env_TN(locked_irq, 0);
     }
 
     /* Broken branch+delayslot sequence.  */
     if (dc->delayed_branch == 1) {
         /* Set env->dslot to the size of the branch insn.  */
         t_gen_movi_env_TN(dslot, dc->pc - dc->ppc);
         cris_store_direct_jmp(dc);
     }
 
     cris_evaluate_flags(dc);
 
     /* Evaluate delayed branch destination and fold to another is_jmp case. */
     if (is_jmp == DISAS_DBRANCH) {
         if (dc->base.tb->flags & 7) {
             t_gen_movi_env_TN(dslot, 0);
         }
 
         switch (dc->jmp) {
         case JMP_DIRECT:
             npc = dc->jmp_pc;
             is_jmp = dc->cpustate_changed ? DISAS_UPDATE_NEXT : DISAS_TOO_MANY;
             break;
 
         case JMP_DIRECT_CC:
             /*
              * Use a conditional branch if either taken or not-taken path
              * can use goto_tb.  If neither can, then treat it as indirect.
              */
             if (likely(!dc->cpustate_changed)
                 && (use_goto_tb(dc, dc->jmp_pc) || use_goto_tb(dc, npc))) {
                 TCGLabel *not_taken = gen_new_label();
 
                 tcg_gen_brcondi_tl(TCG_COND_EQ, env_btaken, 0, not_taken);
                 gen_goto_tb(dc, 1, dc->jmp_pc);
                 gen_set_label(not_taken);
 
                 /* not-taken case handled below. */
                 is_jmp = DISAS_TOO_MANY;
                 break;
             }
             tcg_gen_movi_tl(env_btarget, dc->jmp_pc);
-            /* fall through */
+            fallthrough;
 
         case JMP_INDIRECT:
             tcg_gen_movcond_tl(TCG_COND_NE, env_pc,
                                env_btaken, tcg_constant_tl(0),
                                env_btarget, tcg_constant_tl(npc));
             is_jmp = dc->cpustate_changed ? DISAS_UPDATE : DISAS_JUMP;
 
             /*
              * We have now consumed btaken and btarget.  Hint to the
              * tcg compiler that the writeback to env may be dropped.
              */
             tcg_gen_discard_tl(env_btaken);
             tcg_gen_discard_tl(env_btarget);
             break;
 
         default:
             g_assert_not_reached();
         }
     }
 
     switch (is_jmp) {
     case DISAS_TOO_MANY:
         gen_goto_tb(dc, 0, npc);
         break;
     case DISAS_UPDATE_NEXT:
         tcg_gen_movi_tl(env_pc, npc);
-        /* fall through */
+        fallthrough;
     case DISAS_JUMP:
         tcg_gen_lookup_and_goto_ptr();
         break;
     case DISAS_UPDATE:
         /* Indicate that interrupts must be re-evaluated before the next TB. */
         tcg_gen_exit_tb(NULL, 0);
         break;
     default:
         g_assert_not_reached();
     }
 }
-- 
2.39.2



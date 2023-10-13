Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 446E27C80FC
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:55:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqI-0008Lo-Iw; Fri, 13 Oct 2023 04:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDq2-0007jZ-0w
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:08 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpu-0000rf-4D
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:05 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-307d20548adso1688715f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186874; x=1697791674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7q+xhkTHYp7EH2hdZlfy5tGr4+PCWY0DFB6lrkygBxU=;
 b=lEDyoBIHQpTsqa2z7yJuutU1ebYxXgVJXV2rs3knyy3dRHnNsIR1R4pDFtHdHi/U3P
 Q1LwG20qODJ5bHJrQPsd4/1PY4e0h5WxVNFQNMH3AhJQWsjo/HuxRQ6p91pOmGwkmnWT
 YXYOOG7h+WgPHF/ZhVsFmX7PRhBRtmi3WPxMMZrNRmS1i4GRfUjcs5Vx7kemDvLxg9wS
 4drh9gkIF0UIiwaY9kgA3AlCfrHfI4v9+2PiQXRLSQH4vDNtXBxVHBRfxlry1Nfy/xpI
 MrEo33O4nHsC0hh1zT41gMILJMjofgq9XBeRT2uhLieWDgM5tg9ZbGm2IMc+2Saxb6Ps
 afXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186874; x=1697791674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7q+xhkTHYp7EH2hdZlfy5tGr4+PCWY0DFB6lrkygBxU=;
 b=qjR7DapWwc+byXrDewmEQ5Jupvw51ZUDowk1FFc5OjGmeazFTA9qclj+zXpMtR3SLO
 18XlCkCHW6wQDyt6DAu/4tcXOFTUCwaO6rXl7pqTj8ISMNbw9JuQg0d1D0tTZv1ZbTk6
 oo5cEC7W92uQnKfq27ezsoJrL4lA7tsR/ewT6TH0kJl1GpAjFmgoydV/TByTUMnAliJS
 4XOdvaPMLYSvlBwaBeFuCu12UgYtep0ehjWv3LGURsh876B3GJhOVWmI9n7cEDXT58Qf
 RkDZvGiRe/GtiwmnDtwVwkNNlMAvZf/9O4u8HK5w19RFsCYRW2tT3lamyEdYS7OI5lLV
 uw+w==
X-Gm-Message-State: AOJu0Yw+Raminwa5d1oP912tGiDguAYBsafP+B5b0TqU3+OCgx7uqdee
 yNMeUw1D4QG/b1Oq2cKMjHTc9FPFKvgh3RCuWDo=
X-Google-Smtp-Source: AGHT+IG3cs06AJGRMyNZZe1i7MOAp8vnpiLmVv6K4gtLM2AXU5BWGXqns9RBMuktw/lTleQe/V3G+A==
X-Received: by 2002:adf:f5c7:0:b0:32d:9fd1:91f9 with SMTP id
 k7-20020adff5c7000000b0032d9fd191f9mr521492wrp.60.1697186874634; 
 Fri, 13 Oct 2023 01:47:54 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:54 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v3 24/78] target/alpha: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:52 +0300
Message-Id: <f1dc9711327112e1fd51e187607ae53c9243752d.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
 target/alpha/helper.c    | 6 +++---
 target/alpha/translate.c | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 970c869771..1afdc1beec 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -452,17 +452,17 @@ bool alpha_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
         if (interrupt_request & CPU_INTERRUPT_HARD) {
             idx = EXCP_DEV_INTERRUPT;
         }
-        /* FALLTHRU */
+        fallthrough;
     case 4:
         if (interrupt_request & CPU_INTERRUPT_TIMER) {
             idx = EXCP_CLK_INTERRUPT;
         }
-        /* FALLTHRU */
+        fallthrough;
     case 5:
         if (interrupt_request & CPU_INTERRUPT_SMP) {
             idx = EXCP_SMP_INTERRUPT;
         }
-        /* FALLTHRU */
+        fallthrough;
     case 6:
         if (interrupt_request & CPU_INTERRUPT_MCHK) {
             idx = EXCP_MCHK;
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 32333081d8..19e1d2ed86 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1436,7 +1436,7 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
     case 0x09:
         /* LDAH */
         disp16 = (uint32_t)disp16 << 16;
-        /* fall through */
+        fallthrough;
     case 0x08:
         /* LDA */
         va = dest_gpr(ctx, ra);
@@ -2940,9 +2940,11 @@ static void alpha_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
             tcg_gen_exit_tb(ctx->base.tb, 0);
         }
         /* FALLTHRU */
+        fallthrough;
     case DISAS_PC_STALE:
         tcg_gen_movi_i64(cpu_pc, ctx->base.pc_next);
         /* FALLTHRU */
+        fallthrough;
     case DISAS_PC_UPDATED:
         tcg_gen_lookup_and_goto_ptr();
         break;
-- 
2.39.2



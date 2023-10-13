Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD007C813F
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:59:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqK-0008OM-GA; Fri, 13 Oct 2023 04:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDq4-0007kx-GP
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:08 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDq1-0000uP-7s
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:07 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3248ac76acbso1572224f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186883; x=1697791683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YyFwdRKpgoyRXm/k/YDCqSRLsmVWCzokGEWgj3zx0Ns=;
 b=iHXPCxe2A3766gL8XCX7jcxrZuzshGGe0ws+ZLd4b5d2pIcF71Pie659Z1OcwTi9hl
 hYTJUYYskdzOt53XQ17EJESp4Ddel2kIYAYhpEZibm8J8+temfBDLJQpDuuAeWMSj/C9
 RDmBYeFTrdWp2rpLc0EMpFJvRCb3X7ULEjmuRWUYqtHVWpLLle3ET2ymoR4FC0CGLIMy
 lcLsGQhjmVSAEDiR33b9HjiNzi79L6GRCN5P/3fbmGuM2/X9EWyuuWEZyt54JScM36KR
 eDKIr1UIHKdSoh3hPHD7uLqmJKKz91GvtS6u8kNWZlWxDUpJRayq1KJ7JJ8R3v0uibps
 Nb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186883; x=1697791683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YyFwdRKpgoyRXm/k/YDCqSRLsmVWCzokGEWgj3zx0Ns=;
 b=Gs6Tn5Z2rVFlo8sT+WwQ+gs8/osBGz9tH/mbd/1Eg8/6Ze3cb3No29dmzNfw4vVo1D
 B5wa0bhF+5WWwCo6VX+EYqv5g2gxtLUDUzblog2oNDXayHIPIC8N90S7uFdAOs4Iau06
 GoDgzvAlSvEXXRXJH2jTsDsQXFQh2J8WmMuvGNuLnz9ku6WiDrumU/ceMPMLyVQSwDMT
 s5qyR1RAJv0TEG092rfSWSPLIl6OAvHBFtx2scGiavO/9jFBss0Vx5WbnCvcLWu1gLkV
 aVVzv/R8u3SOZUu1JXFo3oQSUz+qfGXp3yyY/c0K6XrscUmJrltTiB3m10wLStV7RrLz
 ouBg==
X-Gm-Message-State: AOJu0YzdeVvn7FKomQpSCmtbcghPcjiOH/5bLTaGmR9pMDO2T12SzVTJ
 GT/BB22ovBL21QEYmXL2eGnrFRwxbIAxEJsNkmo=
X-Google-Smtp-Source: AGHT+IGJreP9TZKAyfWO3kMyqT7snGOMjHwbBLgM78ZN+4I3Y+xEqT/IBD45GWe9a3QVm6Re6FW5xg==
X-Received: by 2002:a5d:6c69:0:b0:32c:eeee:d438 with SMTP id
 r9-20020a5d6c69000000b0032ceeeed438mr11336634wrz.54.1697186883673; 
 Fri, 13 Oct 2023 01:48:03 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:03 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [RFC PATCH v3 29/78] target/cris: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:57 +0300
Message-Id: <0d379a3b1f092b18be293448a09dcadebbea98fc.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
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
 target/cris/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index b3974ba0bb..bdd128db23 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3113,7 +3113,7 @@ static void cris_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
                 break;
             }
             tcg_gen_movi_tl(env_btarget, dc->jmp_pc);
-            /* fall through */
+            fallthrough;
 
         case JMP_INDIRECT:
             tcg_gen_movcond_tl(TCG_COND_NE, env_pc,
@@ -3140,7 +3140,7 @@ static void cris_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
         break;
     case DISAS_UPDATE_NEXT:
         tcg_gen_movi_tl(env_pc, npc);
-        /* fall through */
+        fallthrough;
     case DISAS_JUMP:
         tcg_gen_lookup_and_goto_ptr();
         break;
-- 
2.39.2



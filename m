Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A54F7C8103
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:56:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqI-0008JK-0w; Fri, 13 Oct 2023 04:48:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDq9-0007u0-4e
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:13 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDq5-0000xr-Q9
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:12 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-405505b07dfso19070565e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186888; x=1697791688; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2BaJISi7vmLPZA7CcIbdyj8kQAkPTCNcK1r7O/POa5E=;
 b=TFylOXl/9eY5bNMXHAAvFWhWrUgH78wXlpngcgCKuJmRx94tRRwQSWbFvJyP/OLcxG
 vsl4wzKLcKiBoqnIlSRO7uugcXZapXUm0Jovq0Yg9UkikOmGuMTaUuz6DZzWfxUrjHw7
 LfqZj7rbds0e1JF5r07kuwaIMe+PXbt1xtFV1WMMZ6JfQdkUVdeNKDdmJ2F47M0UNKDf
 2IRjiWWByODg9Ki5NKYLqIHqi4sTz50S6YZjAqJquSmKIOuDdSgIHeojaIdktXkkmK+O
 noSGGVtJBpcENOh+tR4WKvLyxm2mf8OsRPs9hD63Qm+EPMUY3zXKFYjoYN7taYeHUG19
 CLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186888; x=1697791688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2BaJISi7vmLPZA7CcIbdyj8kQAkPTCNcK1r7O/POa5E=;
 b=Mq+3zkWSYjhK7GPtRBzSEuRW7Qnra9xAZZgVwZEwXNzfyTdjw4GJ+ZkjYtUWeGVM8J
 Xm7Yz7EYbhEommA6igibH5FimL7S2Q7WmC/w8CCrFIzoXAuZWBnZ4tQ0FGlDYx4UTVPs
 mHos5SjyTmUOooxyCuCR0Ra17XOIXOSgTGyEYAEl9UdIJH/+n30pqfPMGp/OtCVx+Fkg
 p/8c681SgIJtMmV40qYCCDVADqIU+zY4mQ3GoORi5OuA4MMOTnLXTUr4lKkh3wPaqG0W
 9qpnMcZ0MRPvQ2tDxqiEle+Z/d2StSzP0WMJxNChPfZY3Ml0lDc+Wisr2IZOx8UK6ebB
 Kvww==
X-Gm-Message-State: AOJu0Yy01rNFFAFLgRp20RemXqIT5U1+1j/FeHjmDEuHRT+WGnULv+I2
 XqPjJjfXzWGHav3aMbvujUqX5yQsZUe5qPJbedE=
X-Google-Smtp-Source: AGHT+IGdDdV8uc3DGzWgUGRJ5YWzfjS3HvE18mkF9qEA+Fd/WFLx5wQFZHnLcCSFSda50GA2P9VDJw==
X-Received: by 2002:a1c:7907:0:b0:405:409e:1fcb with SMTP id
 l7-20020a1c7907000000b00405409e1fcbmr20417150wme.5.1697186888169; 
 Fri, 13 Oct 2023 01:48:08 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:07 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [RFC PATCH v3 32/78] target/m68k: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:00 +0300
Message-Id: <a788ff5afe4a3b2282234d9446b9ec1a196e0667.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x333.google.com
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
 target/m68k/op_helper.c |  3 ++-
 target/m68k/translate.c | 10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
index 1ce850bbc5..65058b9e2f 100644
--- a/target/m68k/op_helper.c
+++ b/target/m68k/op_helper.c
@@ -418,7 +418,7 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
             do_stack_frame(env, &sp, 1, oldsr, 0, env->pc);
             break;
         }
-        /* fall through */
+        fallthrough;
 
     default:
         do_stack_frame(env, &sp, 0, oldsr, 0, env->pc);
@@ -917,6 +917,7 @@ static struct bf_data bf_prep(uint32_t addr, int32_t ofs, uint32_t len)
             addr -= 1;
         }
         /* fallthru */
+        fallthrough;
     case 3:
         bofs += 32;
         break;
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 4d0110de95..ce102dc585 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -732,7 +732,7 @@ static TCGv gen_lea_mode(CPUM68KState *env, DisasContext *s,
         if (opsize == OS_UNSIZED) {
             return NULL_QREG;
         }
-        /* fallthru */
+        fallthrough;
     case 2: /* Indirect register */
         return get_areg(s, reg0);
     case 4: /* Indirect predecrememnt.  */
@@ -1221,7 +1221,7 @@ static void gen_cc_cond(DisasCompare *c, DisasContext *s, int cond)
             c->v1 = tmp = tcg_temp_new();
             tcg_gen_sub_i32(tmp, QREG_CC_N, QREG_CC_V);
             gen_ext(tmp, tmp, op - CC_OP_CMPB, 1);
-            /* fallthru */
+            fallthrough;
         case 12: /* GE */
         case 13: /* LT */
             tcond = TCG_COND_LT;
@@ -1260,7 +1260,7 @@ static void gen_cc_cond(DisasCompare *c, DisasContext *s, int cond)
         if (op != CC_OP_LOGIC) {
             break;
         }
-        /* fallthru */
+        fallthrough;
     case 10: /* PL (!N) */
     case 11: /* MI (N) */
         /* Several cases represent N normally.  */
@@ -1292,7 +1292,7 @@ static void gen_cc_cond(DisasCompare *c, DisasContext *s, int cond)
             c->v1 = QREG_CC_X;
             goto done;
         }
-        /* fallthru */
+        fallthrough;
     case 8: /* VC (!V) */
     case 9: /* VS (V) */
         /* Logic operations clear V and C.  */
@@ -4234,7 +4234,7 @@ DISAS_INSN(chk)
             opsize = OS_LONG;
             break;
         }
-        /* fallthru */
+        fallthrough;
     default:
         gen_exception(s, s->base.pc_next, EXCP_ILLEGAL);
         return;
-- 
2.39.2



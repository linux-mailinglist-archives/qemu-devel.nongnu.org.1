Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2527D270B
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 01:33:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quhtC-00074H-3Q; Sun, 22 Oct 2023 19:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quht6-00072J-AK
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:40 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quht4-0006gz-4F
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 19:29:40 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3b2ea7cc821so2074290b6e.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 16:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698017377; x=1698622177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6T/c3A96Bz3wE+bsJljf0ySAcIsMHNjnW78siXjVBI=;
 b=ILtitKIxBnpFwtZnYR4CeTgCmInW3PHcX3RLiv5YR8hMspTt4SB3NovXBNZjmNkwZO
 5ctH3wFNZ4r1RPb3fgRb5bC4QbnngQh1ggw5Fx1bboxzxUItylBC+Gro380Nfq8JUOR/
 /3s8Vcwx0uptoolWPpZNvlf8F714xyLVPen2nytQJW4MHLjoH5cV3OYjkHzo57yX5qo4
 XrSbCc6D/nncAYWykG4Dv9gIgkUFj4jeouRaQn9mGnteafQteg8ENIY8wbP+sabBAwIs
 4R84jOov0M58/4aCjJzm0ovR5Qi566VksmhGbAuhN8j4jIJGCu37fYOfAps1+88vol8+
 GMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698017377; x=1698622177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a6T/c3A96Bz3wE+bsJljf0ySAcIsMHNjnW78siXjVBI=;
 b=LsbdmB55rZnBWMH2RndODGG5gAqZncW3O+OSHeTpXDA+MT8aga6fbvjTkk7Z2kZj61
 PVdbfSby1COnNBMjMN8y3yPHQ2rDM4g6DBWvVa2AllyJig5DDxWkCCkdHOt87mENjPQJ
 g8ekDscW+aVxUtYWWEmWRr+HAitp2dKoLoaF1cyq7d7/aN7Jh3UWvQ4S4DTmGPQA9+XM
 jJe59pI3uIEOUXMWOoH7Ijn0PKL1l3An7QDQSmxAD/a30yIEGWXsN0XUNCYKzRcqL686
 YBuzOaMVdVT3G74RgfpAhJHJOxjyh0ZjZDJ5q7c6fPrjN9PrPYhdsCsVF8hKETQGBRYf
 UZrQ==
X-Gm-Message-State: AOJu0YxzHweQk34A3xftWBoWOB9LprHckl8thx0hK+/r2q+IvUO4nT2f
 Ttta01Fe0ji75UaYOjrjLGaBbM5UKHtWfmBoiy8=
X-Google-Smtp-Source: AGHT+IEt5MOmp1oTKyMInzcLuY7aUtvSz7emE6hlkfMMLYNbPxQ7kb91fMYr+3fcz+SGh2k0+fXpPw==
X-Received: by 2002:a05:6358:33a1:b0:12f:158e:ed88 with SMTP id
 i33-20020a05635833a100b0012f158eed88mr10890629rwd.22.1698017376857; 
 Sun, 22 Oct 2023 16:29:36 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 k26-20020a63ba1a000000b005b25a04cf8bsm4023772pgf.12.2023.10.22.16.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 16:29:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v5 03/94] target/sparc: Avoid helper_raise_exception in
 helper_st_asi
Date: Sun, 22 Oct 2023 16:28:01 -0700
Message-Id: <20231022232932.80507-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231022232932.80507-1-richard.henderson@linaro.org>
References: <20231022232932.80507-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

Always use cpu_raise_exception_ra with GETPC for unwind.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/ldst_helper.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 246de86c98..09066d5487 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1650,7 +1650,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             int idx = ((asi & 2) >> 1) | ((asi & 8) >> 2);
             env->dmmu.sun4v_tsb_pointers[idx] = val;
         } else {
-            helper_raise_exception(env, TT_ILL_INSN);
+            goto illegal_insn;
         }
         break;
     case 0x33:
@@ -1662,7 +1662,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
              */
             env->dmmu.sun4v_ctx_config[(asi & 8) >> 3] = val;
         } else {
-            helper_raise_exception(env, TT_ILL_INSN);
+            goto illegal_insn;
         }
         break;
     case 0x35:
@@ -1679,7 +1679,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
             int idx = ((asi & 2) >> 1) | ((asi & 8) >> 2);
             env->immu.sun4v_tsb_pointers[idx] = val;
         } else {
-            helper_raise_exception(env, TT_ILL_INSN);
+            goto illegal_insn;
         }
       break;
     case 0x37:
@@ -1691,7 +1691,7 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
              */
             env->immu.sun4v_ctx_config[(asi & 8) >> 3] = val;
         } else {
-          helper_raise_exception(env, TT_ILL_INSN);
+            goto illegal_insn;
         }
         break;
     case ASI_UPA_CONFIG: /* UPA config */
@@ -1920,6 +1920,8 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, target_ulong val,
     default:
         sparc_raise_mmu_fault(cs, addr, true, false, 1, size, GETPC());
         return;
+    illegal_insn:
+        cpu_raise_exception_ra(env, TT_ILL_INSN, GETPC());
     }
 }
 #endif /* CONFIG_USER_ONLY */
-- 
2.34.1



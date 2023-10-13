Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 158297C80B2
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqE-00086b-IE; Fri, 13 Oct 2023 04:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDps-0007hJ-Sy
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:59 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpo-0000qF-2m
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:54 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4064876e8b8so21533295e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186866; x=1697791666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ESjcaB7QhJKVHfl6pyquXKaEee+3+oQSR3w9K1RfS0=;
 b=DQSHpnfaaX/XSbfSbuGp4lcXeX4QCVupVGqav0QQ8RA+7oZ5lAK3ZHT5NnB+Zf4dIY
 uC3bH8/b2Fs/hzIjq+/B+1JeE9tLaTqTO9NY35HMAfj2nfIfurKGQyU5eoZstGFGquEU
 xYTyqYpWbJ15g5/T/Ww444TbnOkJ/diWVEPzl2nbvE9MV55UScXFBLvu0RVvd6GZvIME
 l9CSffxEbF4oCyGJF2hX0ruGap5mMwdi3SarpD0SBHDrxGvCSRUkPzvtow1QYeH/ieTo
 8FUgvd/0Iw6aG3KacLn5f6+cYN5Bfvc589a1hGOWNPyss+qXGeW95THk9kQsq08Nn41A
 hXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186866; x=1697791666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6ESjcaB7QhJKVHfl6pyquXKaEee+3+oQSR3w9K1RfS0=;
 b=R69hQ2izFDuSj88bcnvwJLVLb71dntMylZexjPIRUZ0+KJHvu+QNR22AcP+pPoL9ZD
 VzjK1d5Z7ZH//e98Wzs1pMNYs8IlodD7VayYxNPIs6nqFcFHRd8G0/T3nO/Bnu+bMoir
 xEq4IVFuZ/vuV/B4emyYCW0Rz+oLdsfsoBxPsYd8V+dmN3jR4q8ZQlq05/BrD5GhKVDw
 L6bDb4gCemWnNPEQlkqMtqeDT5NZB5PfmahzcKd2OhCRkGmiQFSGZttEgFEY3V4wp73p
 VQEcaT4lQzDzv8E/IRYvhaYMXXnlENUIEIki7Jq/b9h/UzC+ZJX6uAw7+wczQHSF7u4F
 xkhA==
X-Gm-Message-State: AOJu0YyOlU1HuuFONP74FQIbPUeDZ6zG/A7QWy7xGYy+OYvI06fDa8i3
 jezni0JnbRGFWEgZWUnqHxgOOJMCb8tdOaAta5I=
X-Google-Smtp-Source: AGHT+IGoatvkoSsOCem4ZvlrJW8EzoqBO4uav3TIBTDe5AgcTam/2JEybBGhWJ6tVH+L87be6FDtog==
X-Received: by 2002:a5d:58e4:0:b0:32d:8e54:29f7 with SMTP id
 f4-20020a5d58e4000000b0032d8e5429f7mr3460245wrd.64.1697186866442; 
 Fri, 13 Oct 2023 01:47:46 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:45 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v3 19/78] target/hppa: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:47 +0300
Message-Id: <e4c35d44927edfe143c14bcff328f0373828018b.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32f.google.com
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
 target/hppa/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 9f3ba9f42f..1df81b0fa2 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -483,7 +483,7 @@ static void cond_free(DisasCond *cond)
     default:
         cond->a0 = NULL;
         cond->a1 = NULL;
-        /* fallthru */
+        fallthrough;
     case TCG_COND_ALWAYS:
         cond->c = TCG_COND_NEVER;
         break;
@@ -3848,13 +3848,13 @@ static bool trans_ftest(DisasContext *ctx, arg_ftest *a)
             goto done;
         case 2: /* rej */
             inv = true;
-            /* fallthru */
+            fallthrough;
         case 1: /* acc */
             mask = 0x43ff800;
             break;
         case 6: /* rej8 */
             inv = true;
-            /* fallthru */
+            fallthrough;
         case 5: /* acc8 */
             mask = 0x43f8000;
             break;
@@ -4230,13 +4230,13 @@ static void hppa_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
         copy_iaoq_entry(cpu_iaoq_f, ctx->iaoq_f, cpu_iaoq_f);
         copy_iaoq_entry(cpu_iaoq_b, ctx->iaoq_b, cpu_iaoq_b);
         nullify_save(ctx);
-        /* FALLTHRU */
+        fallthrough;
     case DISAS_IAQ_N_UPDATED:
         if (is_jmp != DISAS_IAQ_N_STALE_EXIT) {
             tcg_gen_lookup_and_goto_ptr();
             break;
         }
-        /* FALLTHRU */
+        fallthrough;
     case DISAS_EXIT:
         tcg_gen_exit_tb(NULL, 0);
         break;
-- 
2.39.2



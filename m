Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A2476A25E
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 23:03:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQa22-0000qv-QI; Mon, 31 Jul 2023 17:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa20-0000pg-EU
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:20 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qQa1y-0006Od-QP
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 17:02:20 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1bba2318546so42501735ad.1
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 14:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690837337; x=1691442137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UO4NGNMOmfX4cDWpdhP1KDrgQG8uGQRDWa46RjUxab0=;
 b=lLMHSj3qBlUmoNc/cnMvH0quFXz2UGLAQWB2Ca21mMMz3X9DinqI5GGiNWduXb/Ok0
 PFa9t8zmoywyregelON7qqMKy28Y6IQS4hSFkK+5BmGl6CnBDHBLPti/m11RcpEFma7I
 lCHlQfIe/fLoJiXeXUnyB+4v07m0bmwY3mn7ty3sdm+4WAQkLGZhwM5WbFpvG+aDClwK
 k0myEtR0rGLGW6uc40W/cMjRjfwM4leTFuJPBcjsSzF3ofdczXgiHRZwlkOKAa1g4jK5
 0KdG4iNIbaTielT84y2ciqEd3+bPWwU2SqMvJOv7vvR/8QWe4q6bWmA/tSfvP+qriOi/
 SjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690837337; x=1691442137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UO4NGNMOmfX4cDWpdhP1KDrgQG8uGQRDWa46RjUxab0=;
 b=ShyShCM90p41u7icxRy41jOl2hirdHAxmAbktejbdNojRXdcy3KqvYQKwWih11Onh4
 ScXtHr3166hsDryCC52YE1920YMlCB4gINwbkp9sNT8xSxd6bLWQmL4ID2A9wjE/xFfR
 vJENw54XDb5jQxLaa5K3TsT1jpjCrvZ03v+efcn0r3sYPUEO+LlK5tJ+vagVmR5qCM+U
 dqj8nwUfvkTP7HU0tWuLcWylGBqSlG4Yqr8KB9YJtti2G8EHfFpHzlkddroPCYKRpssp
 ij8Yico984zeFTldyGnfA5g+8zHCaOZP5O6tiWO5OmtAaRwJpIT6bpy1BR3jiXbhTTvA
 admg==
X-Gm-Message-State: ABy/qLZtGwhgd5icOuKI6h/FSwUxQp8EFgDz18UpQLeIsA5M4sN2Eujb
 FSqKPvVfTiKn9aKY2Cm2f4PxCOE0G7ySFjB5JNM=
X-Google-Smtp-Source: APBJJlGqVhxKO9cAxdA1AbAOPm40Ex5sRVWMhaV6ItdfUEDggnp3is4wmHsTvhhmh4hELWwLM9YJfQ==
X-Received: by 2002:a17:902:9b94:b0:1bb:a6db:3fd0 with SMTP id
 y20-20020a1709029b9400b001bba6db3fd0mr9435135plp.69.1690837337383; 
 Mon, 31 Jul 2023 14:02:17 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:4f6f:6b:2de4:e0cb])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a1709028bcb00b001bb8895848bsm8924230plo.71.2023.07.31.14.02.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 14:02:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/10] accel/tcg: Clear tcg_ctx->gen_tb on buffer overflow
Date: Mon, 31 Jul 2023 14:02:06 -0700
Message-Id: <20230731210211.137353-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731210211.137353-1-richard.henderson@linaro.org>
References: <20230731210211.137353-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On overflow of code_gen_buffer, we unlock the guest pages we had been
translating, but failed to clear gen_tb.  On restart, if we cannot
allocate a TB, we exit to the main loop to perform the flush of all
TBs as soon as possible.  With garbage in gen_tb, we hit an assert:

../src/accel/tcg/tb-maint.c:348:page_unlock__debug: \
    assertion failed: (page_is_locked(pd))

Fixes: deba78709ae8 ("accel/tcg: Always lock pages before translation")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a1782db5dd..b2d4e22c17 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -374,6 +374,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
                           "Restarting code generation for "
                           "code_gen_buffer overflow\n");
             tb_unlock_pages(tb);
+            tcg_ctx->gen_tb = NULL;
             goto buffer_overflow;
 
         case -2:
-- 
2.34.1



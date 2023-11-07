Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 444267E3413
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:16:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CRr-0005Zp-B2; Mon, 06 Nov 2023 22:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRl-0005Gi-0a
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:09 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0CRh-0001Rm-2K
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 22:08:08 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6b1d1099a84so5244422b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 19:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699326483; x=1699931283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1WVjPga7yIHeu3PAMI2CdXP3lbKO1ZBcZBYWD91rJoo=;
 b=nhtF4NLkpvnQ+cAGjEkUYlLdY8OIl117PwtYqU4M+HZyK6NVc0+wvOxA0ZBiN35mCF
 nZrzo1SaygUmWWWX6kcy88zfE8ABJQWsYmFutalacmRR21vJkidDxdlaA2t1Q/K1cPHm
 0vZ3Ic+zJfTDDAiP6/gNS8UDaaub0m5QjM3TdjWvQlEsIyaO4nIsuRRsqfi/awi7hEUG
 GF26z+7DzNpvZO7Auafrh83RADfwJxyJO7n6wA1jzhpFSiE2tRzddjOVoAHoL/4Ma8LA
 lUyQ0vvxHCyy4rGejwdZcODBtdex+SXBg9Wgvhl4/UwpTeUs5wUp5eQi0ntxFbIJX5HH
 QFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699326483; x=1699931283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1WVjPga7yIHeu3PAMI2CdXP3lbKO1ZBcZBYWD91rJoo=;
 b=qZgNWft5yxetOgyhdPnQ9ZG6NpLLALJ/0Bhj7O5rH6cZqKRFdrj07qMtdq6a8g7Map
 a0odRvc9EQVzzwWHkJvrsuJA3pI1je0Gf35w3XXjQ3zpn3OGIedDzVzqBMkjGbjLb2eJ
 z8rNJBuCZWuKKtzdO0FYwBcQT6dMhGSQK3zt2gM5UPGuHagbXM6kFNeocgrGN12IUR6E
 NjoYQes9Fp+25cHn+miAQA/eBRbqpnS1iADnmxBvuJCfPP9NaVxoHB/WkTgKHaw6kn8I
 VN79Mpu84+8MGudQY94ySXTCMQzowVO10e+0DaeyCyIq0tr+Pp2BQcyk+CM7tCCF9M1w
 Dikg==
X-Gm-Message-State: AOJu0YwD89lG2Q131ErWRV++4LxXLobAS52Ioo3Dd+DFl9KT2C/4Qt84
 MNlcpaha1sKAskDh9O2dGFROMeBdZBTYcPZrx1g=
X-Google-Smtp-Source: AGHT+IGgpWEwhPdfrIkiAE0FE19c1pFDJ4y8lGKwzdGxPaE+KFMeY7iDAUk4TOJ/kPI3062kXoVW+A==
X-Received: by 2002:a05:6a20:12ca:b0:181:275f:3b5e with SMTP id
 v10-20020a056a2012ca00b00181275f3b5emr23182837pzg.5.1699326483640; 
 Mon, 06 Nov 2023 19:08:03 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 13-20020a17090a004d00b0027782f611d1sm6744883pjb.36.2023.11.06.19.08.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 19:08:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 74/85] target/hppa: Implement pa2.0 data prefetch instructions
Date: Mon,  6 Nov 2023 19:03:56 -0800
Message-Id: <20231107030407.8979-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107030407.8979-1-richard.henderson@linaro.org>
References: <20231107030407.8979-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

These are aliased onto the normal integer loads to %g0.
Since we don't emulate caches, prefetch is a nop.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index ba15cf6ab8..e7f379d648 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2976,7 +2976,15 @@ static bool trans_permh(DisasContext *ctx, arg_permh *a)
 
 static bool trans_ld(DisasContext *ctx, arg_ldst *a)
 {
-    if (!ctx->is_pa20 && a->size > MO_32) {
+    if (ctx->is_pa20) {
+       /*
+        * With pa20, LDB, LDH, LDW, LDD to %g0 are prefetches.
+        * Any base modification still occurs.
+        */
+        if (a->t == 0) {
+            return trans_nop_addrx(ctx, a);
+        }
+    } else if (a->size > MO_32) {
         return gen_illegal(ctx);
     }
     return do_load(ctx, a->t, a->b, a->x, a->scale ? a->size : 0,
-- 
2.34.1



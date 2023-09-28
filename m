Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1EC7B2606
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 21:42:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlwti-0007vn-1g; Thu, 28 Sep 2023 15:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwtg-0007v5-OE
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:42:04 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlwtc-0007wN-Rt
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 15:42:04 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-690f7bf73ddso10547874b3a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 12:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695930119; x=1696534919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ujd1qr2cxmKKRJwbJe5azKA+HhGSxwUyFcBo+rqU3b0=;
 b=cmV4NsvXiGgLTljIM7wkEpTpK2Z9OsvPYWoGK2qFUL3ncyjfHC8vE8vnFrV30+Lym/
 UvYXzuG8q4g6Gxq1tSYf8cpwQjcg5Yp0xWNxc++v4g+vuwNqZSSTxfHPHehvpW/Hx8NX
 XlqRZA7r6TE/eH6JrVhiuBh8wkzHhL0Jaj8cEXMzxU4GCABJNZZ48kvl9QoU15MAj1zH
 KT/llk5TWB7jY7PHlkzZ4xe50UGZDfvg7Ibv8rk7yXmxKigvDUryAY20shUoEkt16EDo
 NXQ0KPrA85jnEAgEVoJ9VttLfL9ZPoCNbc/TRaaBqzLDSIUJGqqv2YWxK5CTYcDy9mxF
 JlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695930119; x=1696534919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ujd1qr2cxmKKRJwbJe5azKA+HhGSxwUyFcBo+rqU3b0=;
 b=t/h3y//F8Gw79DDTdkXHJ0wiwLvYvPIxBIDEADD9JfXoxrjGkhRH+tP8gvepXs9vVG
 LP0+VsN15L+NcztOaRHv+mKe7S4dPwG0Y2afTkBjqPAh4pJY69MfwYGnlOG3N4a6K+JO
 EYYOjQcaCkJFFiR+zxWR0dsj4L2lssmdYTp+DfZgytwhfZYIo4082osNZc8CwTdRYZBp
 1ga25FmVeHSUbVG+B5EUXY8sxOP4y7Dwb0ZzaJySwJsgABrCForflHkeSuO0L18RF/dw
 FCjsDU3t15gPgXAO8Mpy3FMgmpKmnaGiLm9qkdgGylyy5R9leaFAxiTgfCmFqRGi1b5R
 74EQ==
X-Gm-Message-State: AOJu0YxnpzzxCkbd5hgrBoi+Q5RnMmzj6i583tNQBQB58uDQpHL5cFfC
 yVFKJtaWpYmGOUMzP67td8eLvyWEvd3fRl8oBco=
X-Google-Smtp-Source: AGHT+IH+FjCgA5xN5ce7l5TxvacmnNIsqQa4/i4qzf3sT6WhrTBK22z1AELw8arm9ZzZjtIdtvXHoQ==
X-Received: by 2002:a05:6a20:1609:b0:14b:887a:6d70 with SMTP id
 l9-20020a056a20160900b0014b887a6d70mr2012330pzj.15.1695930119236; 
 Thu, 28 Sep 2023 12:41:59 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 x23-20020a170902821700b001b80d399730sm15273450pln.242.2023.09.28.12.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 12:41:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/6] accel/tcg: Avoid load of icount_decr if unused
Date: Thu, 28 Sep 2023 12:41:51 -0700
Message-Id: <20230928194156.237351-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230928194156.237351-1-richard.henderson@linaro.org>
References: <20230928194156.237351-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

With CF_NOIRQ and without !CF_USE_ICOUNT, the load isn't used.
Avoid emitting it.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 1a6a5448c8..a3983019a5 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -49,12 +49,15 @@ bool translator_io_start(DisasContextBase *db)
 
 static TCGOp *gen_tb_start(uint32_t cflags)
 {
-    TCGv_i32 count = tcg_temp_new_i32();
+    TCGv_i32 count = NULL;
     TCGOp *icount_start_insn = NULL;
 
-    tcg_gen_ld_i32(count, cpu_env,
-                   offsetof(ArchCPU, neg.icount_decr.u32) -
-                   offsetof(ArchCPU, env));
+    if ((cflags & CF_USE_ICOUNT) || !(cflags & CF_NOIRQ)) {
+        count = tcg_temp_new_i32();
+        tcg_gen_ld_i32(count, cpu_env,
+                       offsetof(ArchCPU, neg.icount_decr.u32) -
+                       offsetof(ArchCPU, env));
+    }
 
     if (cflags & CF_USE_ICOUNT) {
         /*
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 138A178616C
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:26:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuOe-0008US-0Y; Wed, 23 Aug 2023 16:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOV-0008L5-8P
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:59 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuOK-0005UA-Tu
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:23:56 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bbc87ded50so41173835ad.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822219; x=1693427019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JJH5DAXKpxVvxGZBhnGdGfJdujLL25EIiq+q/aDhCI4=;
 b=bZus8SsOIdrq9tLnLASKzh/xUmascleeVXt1dbn48NJyfFv3YQJcDgwFGeZtqa05e1
 COOjjSN7Sduo9XyaXBek36wJlrRjKBYtvLJbLfUu/2kcp6HzUpzL/JTJgzNFKnIIgdHE
 Obo1aZap80oSnvznvkOKiqh+KGk/A//R5wqHplicGLqZEuAxGXllO4n4njSSxpnRzoZu
 /gdLesAmX9cn12736ISxyDr5innthnMTsAx3IyeOXLsuWwz6vyce8JIV4mKBaf/VTS3u
 FomJ0UDSILUvpBP+FuBuniF662zQC9HBgm3Ft5mdUIR05JzpJR0ydQK/K0OtpOKG38vD
 NWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822219; x=1693427019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJH5DAXKpxVvxGZBhnGdGfJdujLL25EIiq+q/aDhCI4=;
 b=FarHbEMpuqKYYtq3kj9fDtzvdp46Ek7dV2ewaJjiyvqSQkg3X+GWPL5aKkpO946yfz
 TEmqLQzAfBiMZGsTw998wXWWb7SUeGAQl1vEkBpdUUH6rncdPid8oi/7O8yoO5WfOfAV
 DJ0qvGUi/IRXxXI40iiri7Hal+UD6yH2abWuh01/+q+r23P6ERXnUJEtYeN+iHuxboJ9
 xr/UYxq7SqzGtKdOthUrVBxKd2rHZ4b5l32pl1CAo2ZDuZztqJXyOsgU0GvuJ/d/8R8m
 WcAEgG8LA2Q4lmAZEs/DloIVi95gD5+3NiHGu3vJG5jT9qBBGJckJ/K1TsCgkW3f3fYO
 l16A==
X-Gm-Message-State: AOJu0YxvozRvQzN9NX/yFIYJCxv2wxu1GWKiu5KgVF0ZhMbm4P/Ba6O9
 LOr1YxE8tetbt/P1sHcpXhaV0LWizf85sTBc9XY=
X-Google-Smtp-Source: AGHT+IGUp+FtYjGk5nKC9mwh4gxXOROtSss3Hnr1juZyXZKERd1IMvckURulCmxBp8558fcq1st2mA==
X-Received: by 2002:a17:903:124b:b0:1b7:e646:4cc4 with SMTP id
 u11-20020a170903124b00b001b7e6464cc4mr14122325plh.28.1692822219307; 
 Wed, 23 Aug 2023 13:23:39 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 iz22-20020a170902ef9600b001b9da42cd7dsm11418641plb.279.2023.08.23.13.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:23:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/48] tcg: Fold deposit with zero to and
Date: Wed, 23 Aug 2023 13:22:50 -0700
Message-Id: <20230823202326.1353645-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Inserting a zero into a value, or inserting a value
into zero at offset 0 may be implemented with AND.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d2156367a3..bbd9bb64c6 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1279,6 +1279,8 @@ static bool fold_ctpop(OptContext *ctx, TCGOp *op)
 
 static bool fold_deposit(OptContext *ctx, TCGOp *op)
 {
+    TCGOpcode and_opc;
+
     if (arg_is_const(op->args[1]) && arg_is_const(op->args[2])) {
         uint64_t t1 = arg_info(op->args[1])->val;
         uint64_t t2 = arg_info(op->args[2])->val;
@@ -1287,6 +1289,41 @@ static bool fold_deposit(OptContext *ctx, TCGOp *op)
         return tcg_opt_gen_movi(ctx, op, op->args[0], t1);
     }
 
+    switch (ctx->type) {
+    case TCG_TYPE_I32:
+        and_opc = INDEX_op_and_i32;
+        break;
+    case TCG_TYPE_I64:
+        and_opc = INDEX_op_and_i64;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    /* Inserting a value into zero at offset 0. */
+    if (arg_is_const(op->args[1])
+        && arg_info(op->args[1])->val == 0
+        && op->args[3] == 0) {
+        uint64_t mask = MAKE_64BIT_MASK(0, op->args[4]);
+
+        op->opc = and_opc;
+        op->args[1] = op->args[2];
+        op->args[2] = temp_arg(tcg_constant_internal(ctx->type, mask));
+        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
+        return false;
+    }
+
+    /* Inserting zero into a value. */
+    if (arg_is_const(op->args[2])
+        && arg_info(op->args[2])->val == 0) {
+        uint64_t mask = deposit64(-1, op->args[3], op->args[4], 0);
+
+        op->opc = and_opc;
+        op->args[2] = temp_arg(tcg_constant_internal(ctx->type, mask));
+        ctx->z_mask = mask & arg_info(op->args[1])->z_mask;
+        return false;
+    }
+
     ctx->z_mask = deposit64(arg_info(op->args[1])->z_mask,
                             op->args[3], op->args[4],
                             arg_info(op->args[2])->z_mask);
-- 
2.34.1



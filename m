Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E667E3338
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:50:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9U-0008SW-0Q; Mon, 06 Nov 2023 21:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9Q-0008Qx-Vw
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:13 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9P-0005wh-IG
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:12 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4ac023c8f82so1566268e0c.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325350; x=1699930150; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YHmBTBkZIpyIbEJIll5966friKsejaD+iHlMP+LfScE=;
 b=ieVjWNmem8Ga4QJGRrNvnMPgxwmaktNVS53aDo0vuUmfd2O8D1XJie9BEmWGVQTdGh
 AA+TFxXAgZOJZMfs1pj80cXFvXQU/OZITGQWozmctyr+BVYZtha/rjdorcYK5UmQZ+r3
 gsXby9CoQ8rWGQnnouINm4+q8eiPpRf0S3847y9LfZJmfJEYeaZ/+JUKpa//TlrM0yxI
 vD3xrv6fTUiXZ7TzsK8bnkcQvKQS/4KgYn1CkfEOAgWWUFTdqcRyWh8TBmfl1PDf2EWT
 zTyXUd3gRu9NG5e+JwKKj+p6OgD1QpXy9AEM+r+/Wf4td2v87kS2RNC/dEIVn5F637Ln
 Medg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325350; x=1699930150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YHmBTBkZIpyIbEJIll5966friKsejaD+iHlMP+LfScE=;
 b=tS0VvFtA7nI7pAlnerAtw1t9GNAExHvkV+jgt6eS80WD2BiS3YgwkQwLfMhlmG+IQF
 /hcOAtRYBqU994xqiz0BtR6ZEJXKNkqUwoRXIStAMFMeSss1uS2SkEpk1KnXQc/ytWsU
 wmgb4sUrv6u/OEof/jePegeVTO/VTremz12QRsmIGEDcGrSahbBXatNSVKlWWVkcoqs6
 KhAc3i+4ZCZfVlJcc+EcTTdsJyPS7e2UZ/QHE5YoYIzyrXA3nCzwea6I13lCGX/muY6/
 BiDcxiDCOh1b4+a2ga69RZnZhfaot1xVWUdksud6dOj01AarMXHB75lDOXE0VNnPVzFQ
 3Uzw==
X-Gm-Message-State: AOJu0YyNtWEcEnUjPieTFrQliMke6cJaU/rjsDxnOnPInrah7AgwbjOj
 Rqac7bnLZ7Q3ECHlwT6zVvacyuOcnSEq+6JDqPo=
X-Google-Smtp-Source: AGHT+IGPbnjkCGS6WC4muG38Cnw3Lrn2mJH7W4vij9s+fg57aOT0UW0Sj8NLxbTNvvB6lg42FzhZJQ==
X-Received: by 2002:a1f:2992:0:b0:4ab:fbff:a811 with SMTP id
 p140-20020a1f2992000000b004abfbffa811mr6793222vkp.14.1699325350551; 
 Mon, 06 Nov 2023 18:49:10 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.49.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:49:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 33/35] tcg/optimize: Canonicalize subi to addi during
 optimization
Date: Mon,  6 Nov 2023 18:48:40 -0800
Message-Id: <20231107024842.7650-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-vk1-xa2c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231026013945.1152174-3-richard.henderson@linaro.org>
---
 tcg/optimize.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index d8e437c826..468f827399 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2166,7 +2166,19 @@ static bool fold_sub_vec(OptContext *ctx, TCGOp *op)
 
 static bool fold_sub(OptContext *ctx, TCGOp *op)
 {
-    return fold_const2(ctx, op) || fold_sub_vec(ctx, op);
+    if (fold_const2(ctx, op) || fold_sub_vec(ctx, op)) {
+        return true;
+    }
+
+    /* Fold sub r,x,i to add r,x,-i */
+    if (arg_is_const(op->args[2])) {
+        uint64_t val = arg_info(op->args[2])->val;
+
+        op->opc = (ctx->type == TCG_TYPE_I32
+                   ? INDEX_op_add_i32 : INDEX_op_add_i64);
+        op->args[2] = arg_new_constant(ctx, -val);
+    }
+    return false;
 }
 
 static bool fold_sub2(OptContext *ctx, TCGOp *op)
-- 
2.34.1



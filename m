Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A8B7085F3
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 18:22:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzgMz-0007bs-3U; Thu, 18 May 2023 12:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzgMr-0007Zg-JS
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:20:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzgMp-0006OY-5f
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:20:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-3f4271185daso21732595e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 09:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684426836; x=1687018836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVJqmD25uEtI8Z7J+wAFRXP/lIYUW4MU+2fPvwiFZvM=;
 b=Zq7fqYuChQO7D06RWNepdR7m3V/b1nwbJASqfFJ3AOvLcbq/qZYCnh8UkC1I6wr8mg
 pEgO54GE1wlwWUJYcloLW3qn3nH1gGKzWw1SqQgZRMnqO2iuhaF5WxFSKSyrrhIc0piq
 oVk9gmcR1YRgC0Smqswjcbm5/w21ui/I7w33ofMLA643bwBNwQ6JYRqHJkttflmxpygO
 F7HdvDsb+UMUTdu6vbZdbxhlh87J52SNTw+CXFWemDLoKfBwGzteOfmdtrb7apx/UnSL
 ++Tmwl74hiqjzQUt1zOaBGGirOZOdJXT46ZVEYrpjtr27Bre9Dgtz9hdNq+mJVhaJiRu
 TWDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684426836; x=1687018836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PVJqmD25uEtI8Z7J+wAFRXP/lIYUW4MU+2fPvwiFZvM=;
 b=Ct4rlLN9Q2hr1zIgFzpFzpAZjIWBj/miLInR0KCeNXIxJeF+wpbWIbC7q61QiJM5wc
 Vl4RrNwgmGB89KdtKSdJJhnM23xfWQNimj8S85dsjKevfR++8w20inOj3dxFrCESMm4n
 +7gbxj6itZZRmL06MPoEXs5q92uYMYErUs9SZk77MJ1T6r/xhVeA3smhTvb5RdFTNykd
 nPHZCDKCTEy+f8DNHwTyvAuUK8PnkvOMCfMTIpFAsAvV4FIBpKUapJQQ40/XNy2CHLKe
 6DHO34PfOu220j8ASSujJxP3uy+S1qZSWDy/QwQSGyor2uT0O+bsb6NeLaUwI26UB2QF
 Ps5w==
X-Gm-Message-State: AC+VfDxZqz4s1UAMxWKOisTPG3sz71nNcaihqVQExUdVq3Z/PuKCn5Lb
 bGB7sD6NIhjsg+lbLHVI4W+fSQ==
X-Google-Smtp-Source: ACHHUZ6i68aN+6OYhBVPzVkQdlWc7jm6TMmkl83wgaSY4BisUti/9m2ZUx8Eiq+5jA0yxY2rfFeAaQ==
X-Received: by 2002:a05:600c:216:b0:3f4:2255:8608 with SMTP id
 22-20020a05600c021600b003f422558608mr1905990wmi.31.1684426836513; 
 Thu, 18 May 2023 09:20:36 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a1cf314000000b003f508777e33sm5778363wmq.3.2023.05.18.09.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 09:20:35 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A469A1FFBF;
 Thu, 18 May 2023 17:20:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH 4/8] accel/tcg: Fix append_mem_cb
Date: Thu, 18 May 2023 17:20:30 +0100
Message-Id: <20230518162034.1277885-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230518162034.1277885-1-alex.bennee@linaro.org>
References: <20230518162034.1277885-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

In fcdab382c8b9 we removed a tcg_gen_extu_tl_i64 from gen_empty_mem_cb,
and failed to adjust the associated copy, leading to a failed assert.

Fixes: fcdab382c8b9 ("accel/tcg: Widen plugin_gen_empty_mem_callback to i64")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230518145813.2940745-1-richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/tcg/plugin-gen.c | 42 ------------------------------------------
 1 file changed, 42 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 34be1b940c..5b73a39ce5 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -254,33 +254,6 @@ static TCGOp *copy_op(TCGOp **begin_op, TCGOp *op, TCGOpcode opc)
     return op;
 }
 
-static TCGOp *copy_extu_i32_i64(TCGOp **begin_op, TCGOp *op)
-{
-    if (TCG_TARGET_REG_BITS == 32) {
-        /* mov_i32 */
-        op = copy_op(begin_op, op, INDEX_op_mov_i32);
-        /* mov_i32 w/ $0 */
-        op = copy_op(begin_op, op, INDEX_op_mov_i32);
-    } else {
-        /* extu_i32_i64 */
-        op = copy_op(begin_op, op, INDEX_op_extu_i32_i64);
-    }
-    return op;
-}
-
-static TCGOp *copy_mov_i64(TCGOp **begin_op, TCGOp *op)
-{
-    if (TCG_TARGET_REG_BITS == 32) {
-        /* 2x mov_i32 */
-        op = copy_op(begin_op, op, INDEX_op_mov_i32);
-        op = copy_op(begin_op, op, INDEX_op_mov_i32);
-    } else {
-        /* mov_i64 */
-        op = copy_op(begin_op, op, INDEX_op_mov_i64);
-    }
-    return op;
-}
-
 static TCGOp *copy_const_ptr(TCGOp **begin_op, TCGOp *op, void *ptr)
 {
     if (UINTPTR_MAX == UINT32_MAX) {
@@ -295,18 +268,6 @@ static TCGOp *copy_const_ptr(TCGOp **begin_op, TCGOp *op, void *ptr)
     return op;
 }
 
-static TCGOp *copy_extu_tl_i64(TCGOp **begin_op, TCGOp *op)
-{
-    if (TARGET_LONG_BITS == 32) {
-        /* extu_i32_i64 */
-        op = copy_extu_i32_i64(begin_op, op);
-    } else {
-        /* mov_i64 */
-        op = copy_mov_i64(begin_op, op);
-    }
-    return op;
-}
-
 static TCGOp *copy_ld_i64(TCGOp **begin_op, TCGOp *op)
 {
     if (TCG_TARGET_REG_BITS == 32) {
@@ -451,9 +412,6 @@ static TCGOp *append_mem_cb(const struct qemu_plugin_dyn_cb *cb,
         tcg_debug_assert(begin_op && begin_op->opc == INDEX_op_ld_i32);
     }
 
-    /* extu_tl_i64 */
-    op = copy_extu_tl_i64(&begin_op, op);
-
     if (type == PLUGIN_GEN_CB_MEM) {
         /* call */
         op = copy_call(&begin_op, op, HELPER(plugin_vcpu_mem_cb),
-- 
2.39.2



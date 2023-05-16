Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AA7705831
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:00:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz0f2-0003ot-He; Tue, 16 May 2023 15:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cO-0000WH-1s
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:56 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz0cK-0003o1-CC
 for qemu-devel@nongnu.org; Tue, 16 May 2023 15:45:55 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64a9335a8e7so8239168b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684266351; x=1686858351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6AghR2GxNGQxhvr7PKKi9iS59oHnnhrCkJuSzSdVhA=;
 b=cj7LyJZde5gUxByrIlnDcfzwYmHhUPBa3vDl3PjvcrQO08IpXYA17ZUZ3TO+jh1pFh
 u94bIwmgTVK0hFAIoWZY5wLgNo9dSDMKmZU2MKqjX37lQqj8MXRw8fmj9w7MObttycNu
 OUPrI54RdOoRAOZnDrvdPQ3YFUevZj/t6oRvBD+/erGwH8lcikWE+oyC+zXkGc+Ww4ES
 ZVbkf2rx2dqFkV1Wx5Kwx2/npIfckddNw8K6R5iRuBuDXVG2J0WzN66x/ZnIHaK1lqwW
 pcgVESIv6anT+R8jghkKie5af78j0KyPzxJtFkvDr1LD0ILHfEUsdGykF3Xy8BIfM2aq
 BgSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684266351; x=1686858351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6AghR2GxNGQxhvr7PKKi9iS59oHnnhrCkJuSzSdVhA=;
 b=jEDBlzW6oRb4sD7pkHkQve+nf6TjWsdrSJrsLwvnUqaZHx/aYRJi6Gdd1R/qMWiWUG
 nhcxPhrNvoz75qZqDoF/VRpKIpnPlDzDugLv7ewyRCxuku+OyNLlV1x//o3+V0IMsKK8
 3W6thT1So5FOqMWguBL7cPr9Y/ziv7g4Cjjx4bcIwf2X5i7a8SjKSb+Egtx79MkY/ICG
 kKnNkOQc2h2XecPS6igKXzHHxHq81iVu6UYjmLE1m1O+jUutjrMzIvcibxix5TmqkT68
 QM8IvEXfgXNJ8EZy14xhHWxGNM+uT6z/nKBxWl6oMM1tDFWbXU9aqDbQEIBjbaO1kCtJ
 0RLw==
X-Gm-Message-State: AC+VfDx0jDIFz2L6hx6pfNPXJBqHiD7dkOI1Ts3KUBzxVE1l0a7m3mQL
 MAIYnbhk46dyj1+uOKD5xr1xNl2xk/8wkNEEU00=
X-Google-Smtp-Source: ACHHUZ5bTatRXo3NyKmIqbRb12NFlrHIJN2m/5ToYD8Gg07PkrtlGTTPrQUOKCz1UtXcTxBBT1mdlA==
X-Received: by 2002:a17:90a:d241:b0:252:b345:7953 with SMTP id
 o1-20020a17090ad24100b00252b3457953mr16550130pjw.24.1684266350973; 
 Tue, 16 May 2023 12:45:50 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 y12-20020a17090abd0c00b002508d73f4e8sm25555pjr.57.2023.05.16.12.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 12:45:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 73/80] tcg/aarch64: Remove USE_GUEST_BASE
Date: Tue, 16 May 2023 12:41:38 -0700
Message-Id: <20230516194145.1749305-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516194145.1749305-1-richard.henderson@linaro.org>
References: <20230516194145.1749305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Eliminate the test vs TARGET_LONG_BITS by considering this
predicate to be always true, and simplify accordingly.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index cc0f55623b..8d78838796 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -85,11 +85,6 @@ bool have_lse2;
 #define TCG_VEC_TMP0 TCG_REG_V31
 
 #ifndef CONFIG_SOFTMMU
-/* Note that XZR cannot be encoded in the address base register slot,
-   as that actaully encodes SP.  So if we need to zero-extend the guest
-   address, via the address index register slot, we need to load even
-   a zero guest base into a register.  */
-#define USE_GUEST_BASE     (guest_base != 0 || TARGET_LONG_BITS == 32)
 #define TCG_REG_GUEST_BASE TCG_REG_X28
 #endif
 
@@ -1760,7 +1755,7 @@ static TCGLabelQemuLdst *prepare_host_addr(TCGContext *s, HostAddress *h,
         tcg_out_insn(s, 3202, B_C, TCG_COND_NE, 0);
     }
 
-    if (USE_GUEST_BASE) {
+    if (guest_base || addr_type == TCG_TYPE_I32) {
         h->base = TCG_REG_GUEST_BASE;
         h->index = addr_reg;
         h->index_ext = addr_type;
@@ -3172,10 +3167,14 @@ static void tcg_target_qemu_prologue(TCGContext *s)
                   CPU_TEMP_BUF_NLONGS * sizeof(long));
 
 #if !defined(CONFIG_SOFTMMU)
-    if (USE_GUEST_BASE) {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_GUEST_BASE, guest_base);
-        tcg_regset_set_reg(s->reserved_regs, TCG_REG_GUEST_BASE);
-    }
+    /*
+     * Note that XZR cannot be encoded in the address base register slot,
+     * as that actaully encodes SP.  Depending on the guest, we may need
+     * to zero-extend the guest address via the address index register slot,
+     * therefore we need to load even a zero guest base into a register.
+     */
+    tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_GUEST_BASE, guest_base);
+    tcg_regset_set_reg(s->reserved_regs, TCG_REG_GUEST_BASE);
 #endif
 
     tcg_out_mov(s, TCG_TYPE_PTR, TCG_AREG0, tcg_target_call_iarg_regs[0]);
-- 
2.34.1



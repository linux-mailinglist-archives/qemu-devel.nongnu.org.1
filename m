Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33108744779
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 08:57:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFUVx-0007Xz-6t; Sat, 01 Jul 2023 02:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVt-0007VY-M5
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:21 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qFUVs-0007Fq-3E
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 02:55:21 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fa8cd4a113so28375235e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 23:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688194519; x=1690786519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ebwpgVZtFJocO+oyA17J6u/jt74rZXaJP0shDH6azA=;
 b=FofdKOAmr4bQD6X7PS92YgE+Xlh0cnUbS4S2sE3Wx2rg3fK2OjBS6L7Glj6LS2KGGX
 ri1g3DbT/PorsDbBoeVDUsBEOT8/hVNL66q2JyzwLJFgkyCs8xZlKCRAeD1pvoZbKpYD
 JnVERKhPQfote0OfOVudSy5OWKVop+o+jyjybR8rbFvVq5isBPS9XLoB2/eiDk08nzmB
 lml6D8fT+eN5K9u1YsERfKl+ysjBzn5fVdNDAcbX+rPbz8R0qBZ3Tn/Fkwlf6CLRrGSm
 hXMCL8C6gvOjU5uUS/bMRcuCse6XD4QTolOTQHcpJbGdpskSA3iw7/ziGJIGC2Rr1H4w
 JqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688194519; x=1690786519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ebwpgVZtFJocO+oyA17J6u/jt74rZXaJP0shDH6azA=;
 b=Werk9VyLGZv5q1bla/y3awcpNQpo4uExH7iqittbL7xLMtzVanwrFdPHXwVmDu8w0C
 nFEcKhi3U4aVL/+RkPJgx6XluxS28e5JFq5Dg1ryWCyAPFYeJ8/OTVGgYMR/TD2D4RiB
 ZfK4I04VPkLuu3QEy/EH8sGyrm+vHYP4GTaRx79uE0TdhQSTDAtBu0zVuCckPIubmJc0
 1MQpZkeV01U11AUbzPzoxeZ6M40jEwXrjuEgoiXXJDAIYtJCpgRkDfg5rn8X00me/irT
 BSS6jWG6XOL/g5HBeyMKbKJ8SSmmobZaHb/LX1bFZGIhPPIYR5nQCFRnT6PzPFqn6aL8
 k8CQ==
X-Gm-Message-State: AC+VfDyRjgn8u0KaeG931xItbfjDzzkdC7MWZJOAvfeZRb2tLJxqBusz
 8/0m9tgoFiSa3QhFFd192YtC3BSgt7Ceeco+t+n2/Q==
X-Google-Smtp-Source: ACHHUZ7tMRycPOHGU9NjX+/lC/hGY1yF2D4zhfpNJaxAtNTPsk5Krr7WFm1sqkfMxy+8e1gO4Aaplg==
X-Received: by 2002:a1c:7908:0:b0:3fa:99ae:3a9a with SMTP id
 l8-20020a1c7908000000b003fa99ae3a9amr3579806wme.2.1688194518872; 
 Fri, 30 Jun 2023 23:55:18 -0700 (PDT)
Received: from localhost.localdomain ([139.47.41.96])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a1cf60a000000b003f9bd9e3226sm20874918wmc.7.2023.06.30.23.55.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 23:55:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/11] tcg: Reduce tcg_assert_listed_vecop() scope
Date: Sat,  1 Jul 2023 08:55:08 +0200
Message-Id: <20230701065510.514743-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230701065510.514743-1-richard.henderson@linaro.org>
References: <20230701065510.514743-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

tcg_assert_listed_vecop() is only used in tcg-op-vec.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230629091107.74384-1-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 6 ------
 tcg/tcg-op-vec.c  | 6 +++---
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 95541e9474..0875971719 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1135,12 +1135,6 @@ uint64_t dup_const(unsigned vece, uint64_t c);
         : (qemu_build_not_reached_always(), 0))                    \
      : dup_const(VECE, C))
 
-#ifdef CONFIG_DEBUG_TCG
-void tcg_assert_listed_vecop(TCGOpcode);
-#else
-static inline void tcg_assert_listed_vecop(TCGOpcode op) { }
-#endif
-
 static inline const TCGOpcode *tcg_swap_vecop_list(const TCGOpcode *n)
 {
 #ifdef CONFIG_DEBUG_TCG
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 64bc8a2156..ad8ee08a7e 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -42,9 +42,9 @@
  * tcg_ctx->vec_opt_opc is non-NULL, the tcg_gen_*_vec expanders
  * will validate that their opcode is present in the list.
  */
-#ifdef CONFIG_DEBUG_TCG
-void tcg_assert_listed_vecop(TCGOpcode op)
+static void tcg_assert_listed_vecop(TCGOpcode op)
 {
+#ifdef CONFIG_DEBUG_TCG
     const TCGOpcode *p = tcg_ctx->vecop_list;
     if (p) {
         for (; *p; ++p) {
@@ -54,8 +54,8 @@ void tcg_assert_listed_vecop(TCGOpcode op)
         }
         g_assert_not_reached();
     }
-}
 #endif
+}
 
 bool tcg_can_emit_vecop_list(const TCGOpcode *list,
                              TCGType type, unsigned vece)
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7BF73E39F
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 17:41:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDoKj-0001OC-Mc; Mon, 26 Jun 2023 11:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJx-0000KR-DJ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:08 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDoJs-0002sc-6j
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 11:40:01 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-312863a983fso3978541f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687793998; x=1690385998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LsbEGf9/sZfjk+gBCU1c0PDJZbrIMUslxNdwNYjh+KU=;
 b=Gl0we+rM9SulbcUbGXrqkSvaEFPB/hk8udsfc47seY0B88uI1oRBuJ51xwJyTMMHZI
 IKXgvQpK7OQU+x02gO3pfFPIJE5fkFOMfkWig/CIOA8haSww1/tzfLfn3uLtlWr5aw2X
 mWq8e9c3nlTToEp3cpRE9Gya6gvruuni+rUT3VTaL++B9tJPrlgu95l54gIL3KFTLkxF
 dfYG5QurxWAY4KT6HtpJ7DMx+routHdhIT0xj/uJlNE0IdauGuLNU/vurNYYa5y6bM8Q
 hA9Cv/hzXWIqYZs4IlHCeRwaEIvcgoT4iuW/5EfnOvKi8C1jiHq27kJzQbVxF2nluCWe
 NrhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687793998; x=1690385998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LsbEGf9/sZfjk+gBCU1c0PDJZbrIMUslxNdwNYjh+KU=;
 b=hOLkAvxU+3lHihOKFTx2AYg/92LiziB7fdFg1Sq57gUAln0BDWXD9Ov7xRzd4Y7UQQ
 d78zzHFfZcpgHvtj/3b9Cxm7YsRl07s1Yjz37qqeAJ5DuH2osvKofU97KoPWczIzEKjh
 DcVvuGP57zp1Bgnk6ivCp560hidK1ApPrZwvUogTkGlukDCbve8l+hxQ0T+KysOVVtZb
 7QSvNqTXc1nCKV6VueirmoGB8fFhL7ubRDb7aWmIM7FoAZ3R7WG6yT4vZZP0zp91MU+D
 EIHGWiQsIQ2GvqLvZm7uSpn57EemtIa2IiyjqQyKfehBkRo/nvA6n1bc5vArm8lC4fvj
 P5Qg==
X-Gm-Message-State: AC+VfDzTLr4Z8cZPEQzDrz4ygJrhZT9pdYT42JtwAErTn1LUp6pWKcyH
 u5BFV8OQYg6KI5uwYOvaw7XnXhuR1p2LaS1l4EQs52Mb
X-Google-Smtp-Source: ACHHUZ4Ygh8TWtZwKCkK4P5sYfrFi9LBPCf62JwvB/NLqbcmkr7ThpJh1u2z4OyylX3V1j6RbYLgGA==
X-Received: by 2002:adf:f044:0:b0:313:eb5a:b645 with SMTP id
 t4-20020adff044000000b00313eb5ab645mr4229491wro.35.1687793998515; 
 Mon, 26 Jun 2023 08:39:58 -0700 (PDT)
Received: from localhost.localdomain ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 t1-20020adfe441000000b00313f45f74a8sm2164178wrm.103.2023.06.26.08.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 08:39:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 19/22] accel/tcg: Remove check_tcg_memory_orders_compatible
Date: Mon, 26 Jun 2023 17:39:42 +0200
Message-Id: <20230626153945.76180-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626153945.76180-1-richard.henderson@linaro.org>
References: <20230626153945.76180-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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

We now issue host memory barriers to match the guest memory order.
Continue to disable MTTCG only if the guest has not been ported.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c | 39 ++++++++++-----------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index 02af6a2891..03dfd67e9e 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -64,37 +64,23 @@ DECLARE_INSTANCE_CHECKER(TCGState, TCG_STATE,
  * they can set the appropriate CONFIG flags in ${target}-softmmu.mak
  *
  * Once a guest architecture has been converted to the new primitives
- * there are two remaining limitations to check.
- *
- * - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
- * - The host must have a stronger memory order than the guest
- *
- * It may be possible in future to support strong guests on weak hosts
- * but that will require tagging all load/stores in a guest with their
- * implicit memory order requirements which would likely slow things
- * down a lot.
+ * there is one remaining limitation to check:
+ *   - The guest can't be oversized (e.g. 64 bit guest on 32 bit host)
  */
 
-static bool check_tcg_memory_orders_compatible(void)
-{
-#if defined(TCG_GUEST_DEFAULT_MO) && defined(TCG_TARGET_DEFAULT_MO)
-    return (TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO) == 0;
-#else
-    return false;
-#endif
-}
-
 static bool default_mttcg_enabled(void)
 {
     if (icount_enabled() || TCG_OVERSIZED_GUEST) {
         return false;
-    } else {
-#ifdef TARGET_SUPPORTS_MTTCG
-        return check_tcg_memory_orders_compatible();
-#else
-        return false;
-#endif
     }
+#ifdef TARGET_SUPPORTS_MTTCG
+# ifndef TCG_GUEST_DEFAULT_MO
+#  error "TARGET_SUPPORTS_MTTCG without TCG_GUEST_DEFAULT_MO"
+# endif
+    return true;
+#else
+    return false;
+#endif
 }
 
 static void tcg_accel_instance_init(Object *obj)
@@ -162,11 +148,6 @@ static void tcg_set_thread(Object *obj, const char *value, Error **errp)
             warn_report("Guest not yet converted to MTTCG - "
                         "you may get unexpected results");
 #endif
-            if (!check_tcg_memory_orders_compatible()) {
-                warn_report("Guest expects a stronger memory ordering "
-                            "than the host provides");
-                error_printf("This may cause strange/hard to debug errors\n");
-            }
             s->mttcg_enabled = true;
         }
     } else if (strcmp(value, "single") == 0) {
-- 
2.34.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01680735976
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 16:25:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFnL-0004Fs-LW; Mon, 19 Jun 2023 10:23:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBFnI-0004ER-18
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:23:48 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBFnF-0000lk-F9
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 10:23:47 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f9b258f3a2so8550605e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 07:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687184624; x=1689776624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xizQ7tZRgd5GaOFhlyM3OwuFvyke8QeFNMuDXQV/YyE=;
 b=KBBmwaTULmC/6FtqOs1WxnJemAB7IsMFoe4IfnKjDx+dYXr1PlTDwU3oeI5HEBC/nd
 OaAd+9m6j7OOt2rEd57UMp+6etvW3gOWB323fZxzQkXqsECEE1HN494Y/cWJHh68DjaY
 63lKrXAK38nE5KQN7LnwTRRLAwYweBtN4NkksGtiSTWbpM4DT70m8EUfdG9nD6wirq6y
 s+ltsuPIxcXy/xrra8w9P8ZgOAPLzM42Ccowi0mN213wrUh07HXavfO5I+FebHwFORVY
 9O4bAw5mhctteAsyVQb9O1JAGB6QmgAPXmOMw/hhbpdpmbbeEO67fCwjQFFA+ga2wVLG
 8uiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687184624; x=1689776624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xizQ7tZRgd5GaOFhlyM3OwuFvyke8QeFNMuDXQV/YyE=;
 b=kPIlxqNGWVU0dplrBjmJV+anNmjEyzTZ7P3KNXkDgHS0+JMYMj7/PJXyjrR899f5fB
 eXkL19PpF/RN6qJWOZYTaeTM7PBDVM9b9zX9sxXBWCSLU31UtAGjC6gYcqlxWpSGaiXs
 P9qCqTapWVSQ7mGJj/D2iE0xHOMaU3gmrMRKlFugNwPs2Sr9Gc0UTajgtXV2DzvuVkd0
 l7EoT2qvNOsW19QmTy6jE0wQqqd76L724riZIHFCLXSOobUFQopwukyW2JmLys2fjOc0
 oTt2gIde7TwmvhROp3kCkFLPma7zx2pIun8Y9Y8AlZCV/VE3SzJ9tdc+aZH+aE0pVNnr
 i6ow==
X-Gm-Message-State: AC+VfDzp5x4D6LxpAN+brXzdxAz3o0yKmtoNSZRiURzTZGVFq0CcQjlY
 cE88h4kSD2hAFR+kGWKft+ZYUyvTGB7R5fUimKSTINiX
X-Google-Smtp-Source: ACHHUZ527hMOO+prCji1d7iZfooYblj3ZI3y6ilj++ADOQlyN/MFbZ7Q6gxsGir5IoHsI3+RGcDdjw==
X-Received: by 2002:a05:600c:2313:b0:3f7:f884:7be4 with SMTP id
 19-20020a05600c231300b003f7f8847be4mr11046556wmo.21.1687184624130; 
 Mon, 19 Jun 2023 07:23:44 -0700 (PDT)
Received: from stoup.lan (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 k25-20020a7bc419000000b003f96d10eafbsm4143467wmi.12.2023.06.19.07.23.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jun 2023 07:23:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 5/5] accel/tcg: Remove check_tcg_memory_orders_compatible
Date: Mon, 19 Jun 2023 16:23:33 +0200
Message-Id: <20230619142333.429028-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619142333.429028-1-richard.henderson@linaro.org>
References: <20230619142333.429028-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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



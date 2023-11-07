Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2DA7E334E
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 03:54:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0C9P-0008QA-LA; Mon, 06 Nov 2023 21:49:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9N-0008PP-7S
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:09 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r0C9L-0005vl-IF
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 21:49:08 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3b52360cdf0so2441082b6e.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 18:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699325346; x=1699930146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Or+n2LZo5yTrnMIWpnTgdydrrS4oDZYVZsFrQSQQ5h4=;
 b=Rzxa3wvf8rQURImtgIq8HGJF9NFe/AgKl7u3kVaXGYL+XPzTyeL5hjokAfCk7qtbAc
 oHBn0FSf+MVw9UVIxOf7ldhQZqp9jEsl9DwAKqKB4cvg5wNX/BcoCvEkvS6KpvnJNtkD
 IvbprEHy0chleiJJEogUouH9MhJXcG6jefnRf1ZkzRgwex996VhoAv14lg2IrSkX8HZ1
 eMLpiWkiXsWTf62DVOTE4mv8zwys7yvvhdL7IeSqOavTSg6ujfzXm0kaBOxHCt4RHOTA
 gs5/j80H3mUO9Oc4bOfN1Pw2asqr9ICJOyFk2rBFAZCqmB1M6fauntTxdywuxJQndz03
 dsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699325346; x=1699930146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Or+n2LZo5yTrnMIWpnTgdydrrS4oDZYVZsFrQSQQ5h4=;
 b=SFEz8A/3g6m08oW1dZ10zp03xVAsUjsCzeqcUi4LZk8C8Zug0l1doSbysBUCyuvX+S
 fsLnwO/nSZYFsmorqGokFpAF7X3b8ffp+stkFdZJofRFcl4jP9W9hKfpFfEpNReFdirE
 nCszjGiMA2RMj0wl59D77P9iSMutK+BLtlcd3Ro3AKILJRFJcdbVdEE3fUVdAFkCspeg
 ovnYOmQH1cVV9m1RpndzsM2u5T2WZ3HkRnQejjUbins0mT5yG2eusnlH5Q+j0gZ16Reg
 FFNPueQTIfl8fu/y0wDIk0Iu0ay3gkYpAw6yWWGxM0zAykHXYfZOb1ht/OnmCrPjtDvn
 lf+w==
X-Gm-Message-State: AOJu0YwORggoWA6iyM9JTG4zcOieSvnAKu7JXxsVAHMhEWdGtPJBDQW2
 6x5rVYIFo4BEORKzwB3rc2WhzqBU5bAr4p1261E=
X-Google-Smtp-Source: AGHT+IG4fZRUDvm/KGujf0KhBPsZzYMr8DJJQMnP3+d3xudmbKkSq+cjumTsVWFc46YaIxWa6udUpg==
X-Received: by 2002:a05:6808:4d9:b0:3ad:f3e6:66f8 with SMTP id
 a25-20020a05680804d900b003adf3e666f8mr27461530oie.41.1699325346114; 
 Mon, 06 Nov 2023 18:49:06 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 fn11-20020a056a002fcb00b006bff7c36fb3sm6367478pfb.95.2023.11.06.18.49.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 18:49:05 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/35] tcg/optimize: Split out cmp_better_copy
Date: Mon,  6 Nov 2023 18:48:35 -0800
Message-Id: <20231107024842.7650-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107024842.7650-1-richard.henderson@linaro.org>
References: <20231107024842.7650-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Compare two temps for "better", split out from finding
the best from a whole list.  Use TCGKind, which already
gives the proper priority.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index cbb095b241..118561f56d 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -122,6 +122,11 @@ static inline bool ts_is_copy(TCGTemp *ts)
     return ts_info(ts)->next_copy != ts;
 }
 
+static TCGTemp *cmp_better_copy(TCGTemp *a, TCGTemp *b)
+{
+    return a->kind < b->kind ? b : a;
+}
+
 /* Reset TEMP's state, possibly removing the temp for the list of copies.  */
 static void reset_ts(OptContext *ctx, TCGTemp *ts)
 {
@@ -174,30 +179,20 @@ static void init_ts_info(OptContext *ctx, TCGTemp *ts)
     }
 }
 
-static TCGTemp *find_better_copy(TCGContext *s, TCGTemp *ts)
+static TCGTemp *find_better_copy(TCGTemp *ts)
 {
-    TCGTemp *i, *g, *l;
+    TCGTemp *i, *ret;
 
     /* If this is already readonly, we can't do better. */
     if (temp_readonly(ts)) {
         return ts;
     }
 
-    g = l = NULL;
+    ret = ts;
     for (i = ts_info(ts)->next_copy; i != ts; i = ts_info(i)->next_copy) {
-        if (temp_readonly(i)) {
-            return i;
-        } else if (i->kind > ts->kind) {
-            if (i->kind == TEMP_GLOBAL) {
-                g = i;
-            } else if (i->kind == TEMP_TB) {
-                l = i;
-            }
-        }
+        ret = cmp_better_copy(ret, i);
     }
-
-    /* If we didn't find a better representation, return the same temp. */
-    return g ? g : l ? l : ts;
+    return ret;
 }
 
 static bool ts_are_copies(TCGTemp *ts1, TCGTemp *ts2)
@@ -672,12 +667,10 @@ static void init_arguments(OptContext *ctx, TCGOp *op, int nb_args)
 static void copy_propagate(OptContext *ctx, TCGOp *op,
                            int nb_oargs, int nb_iargs)
 {
-    TCGContext *s = ctx->tcg;
-
     for (int i = nb_oargs; i < nb_oargs + nb_iargs; i++) {
         TCGTemp *ts = arg_temp(op->args[i]);
         if (ts_is_copy(ts)) {
-            op->args[i] = temp_arg(find_better_copy(s, ts));
+            op->args[i] = temp_arg(find_better_copy(ts));
         }
     }
 }
-- 
2.34.1



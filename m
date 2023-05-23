Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8F170DE27
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:54:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1ST5-0006OC-5L; Tue, 23 May 2023 09:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSY-00059J-Ik
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:55 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1SSX-00039L-5z
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:53:54 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d41763796so2904332b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684850032; x=1687442032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CqRHuePTegdze3NOBrjUysvcJxQSbD+uxpXc5nyVFn4=;
 b=fZzBcExymZpkAFcuLHX96MpONM1SL7FJD6VqVc++2TFKlpfVGsimotrkifNLq+4WkW
 hP1FoZT+8MObBHQmm9HhwERAmL9OR1b3KMv1DBse3MOhHSM5SzYv/iRFXL2o5yzZZX88
 qLxSY3xzJ5gzqiYwxxQEJQHyPLXJRAM52oUCVH7Ka+9aAV9CdTVLsa7RNN9Wax4DtyZl
 VpJREIPIu1rXhZMy5El5Mmxt6s/mOuUkfYb7CwbHRosDhX6xIHFbszHSRqsDvgvoa8Cb
 E+AF3KY96Mr1f5JUUwBQunQkwGeHJj+fsTcUboR8W/lUMy3JbElF7TQvqcemmAVfXghy
 IaWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684850032; x=1687442032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CqRHuePTegdze3NOBrjUysvcJxQSbD+uxpXc5nyVFn4=;
 b=LNzbw159Q0dhGz+YnnVxTg+1GKQilmtOYzg0mh143JhmT0KIJ1Y7JOUwBlKdJLG2YL
 T9y5gJWO9wpcgxfsKqaBkA029YqzDYeQ1gjEOY9+orTnOcOLceCUjKwh5y9uY6LBHdDD
 ajU1mgpeSeGXbRNZBZunyaNloy6vN+z0YdAUSTxK1DjOfqF/3kY3Y+6zGkC+lbdTZWcX
 7z+YiXXBoo1IPF3hb7vQbGJfY+OJPjqnf5v1jxlLIEBK8vb572kqPzPAL/8v40t8tue4
 RlfJg8UNrN/5vHco4Yv2YTDFjvrgGEtCmhzp1U8Y6KDqBnLHw2K+z6e+VmoMkgv7hz7K
 vMYg==
X-Gm-Message-State: AC+VfDyLcjOvvWQp4jv9M92Tc+GX6WS2j4fs0YEzmBCgA9pYOem9wVqJ
 TJ52xb0M8La+FGJrFseU6mDGjYPM4nEaY0/TNGI=
X-Google-Smtp-Source: ACHHUZ4w4C32/1KZ/goYLbCIy7rkWbhaKGIs4370w6CCiGNUYqmdWjazbJ0wNZbVbRXo/+fxcpaUjg==
X-Received: by 2002:a05:6a00:1a15:b0:63b:5c82:e21a with SMTP id
 g21-20020a056a001a1500b0063b5c82e21amr18012407pfv.1.1684850031790; 
 Tue, 23 May 2023 06:53:51 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 b8-20020aa78708000000b0064d27a28451sm5796111pfo.100.2023.05.23.06.53.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:53:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 34/52] tcg: Remove USE_TCG_OPTIMIZATIONS
Date: Tue, 23 May 2023 06:53:04 -0700
Message-Id: <20230523135322.678948-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523135322.678948-1-richard.henderson@linaro.org>
References: <20230523135322.678948-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

This is always defined, and the optimization pass is
essential to producing reasonable code.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index f7e61e736f..7d0449f6a9 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -22,9 +22,6 @@
  * THE SOFTWARE.
  */
 
-/* define it to use liveness analysis (better code) */
-#define USE_TCG_OPTIMIZATIONS
-
 #include "qemu/osdep.h"
 
 /* Define to jump the ELF file used to communicate with GDB.  */
@@ -6078,9 +6075,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     qatomic_set(&prof->opt_time, prof->opt_time - profile_getclock());
 #endif
 
-#ifdef USE_TCG_OPTIMIZATIONS
     tcg_optimize(s);
-#endif
 
 #ifdef CONFIG_PROFILER
     qatomic_set(&prof->opt_time, prof->opt_time + profile_getclock());
-- 
2.34.1



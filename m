Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC66070E9E4
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 02:00:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bu8-0004PA-D9; Tue, 23 May 2023 19:59:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1btm-0004K3-I5
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:38 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bte-0001sH-Q6
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:58:38 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-64d1a0d640cso107583b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684886309; x=1687478309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L4mMrlEHq00cb2PmywQti2UecytZbzZJsKcDPhsh4e0=;
 b=aTd3cqqmbuKPkJisJ7nATYUhtxQKQDXyqH9olGshhln1MybDRBww4DI9dANiE7qdZ/
 ZhBb7B+v5WOlkgGS9VqYDkpyq1gS0gYhINkO1K0fhC3/Z7ZovXAd7N/B04ChlVXWZTv5
 GaWX4yxDzEjWT46akjZPWlXxDiv1XlUZQwwUUtV/+OII756l6ZErb5gIkouQ1RdfmWRY
 0RxBKv2WL5gwzfMQH/KNE0R5ZCXXOwfa+vLFjXdc0xantWImFHWmoP9zoSVX5x5jDFck
 fquAWHfJCcx8SCxLUYEGfZroB/6TejVlvjfsNWlvd8bYfpm0Qh8Fmxeip3Fb4+wSIUP4
 g12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684886309; x=1687478309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L4mMrlEHq00cb2PmywQti2UecytZbzZJsKcDPhsh4e0=;
 b=M6AvOHN0+jOU9l1HgOhU9uM1TN4GL8ieegksWrvaJDlgrsZ/yiSBYWURo25erX9nuu
 S/5LcR1WL3P6DfJ4R1PxwX8+9WnMOxWY5rIBJ7WnTFswM9dNza366pnAaxvFgA5fNAso
 XWDMvpG+8wPLJdOeCN9seyMW/XfmXE84c9eerwfEWZJAl5jcObZTyJTVFxJiKSK2hl6Z
 eCHX5blp7yc3ldZAEZshXokLv/Ll296SPRLxfz0xe8UWRJhrhjZ0dnGqM8TFsIF8yXmN
 lvI5Tp0kGU+ZLQwUiK6ykT+jN16LeQ8b2/owzWIaZnUqIuLSjRqp8btp3TlWKi5kPafZ
 zdqg==
X-Gm-Message-State: AC+VfDzJ2OOz7ZxZuROhn1euu0M2CIwv87IiHS8a5T2NbeklIhPIbzzC
 8brlCQ0rgg1X6KvZK2yy5elfNYfEbhrpnuKVs6M=
X-Google-Smtp-Source: ACHHUZ4ChEc85q0fUX+K3/+wD11wro7u2u7YJC50p2+EgCN8FV94DvsdRP2qXLhauj1+KAy2kb6cfg==
X-Received: by 2002:a05:6a21:9985:b0:106:4197:b7ff with SMTP id
 ve5-20020a056a21998500b001064197b7ffmr16757035pzb.30.1684886309602; 
 Tue, 23 May 2023 16:58:29 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 p18-20020aa78612000000b0063b7c42a070sm6285041pfn.68.2023.05.23.16.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 16:58:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/28] tcg: Remove USE_TCG_OPTIMIZATIONS
Date: Tue, 23 May 2023 16:58:04 -0700
Message-Id: <20230523235804.747803-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523235804.747803-1-richard.henderson@linaro.org>
References: <20230523235804.747803-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index bfe3d80fc2..ac30d484f5 100644
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
@@ -6028,9 +6025,7 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb, uint64_t pc_start)
     qatomic_set(&prof->opt_time, prof->opt_time - profile_getclock());
 #endif
 
-#ifdef USE_TCG_OPTIMIZATIONS
     tcg_optimize(s);
-#endif
 
 #ifdef CONFIG_PROFILER
     qatomic_set(&prof->opt_time, prof->opt_time + profile_getclock());
-- 
2.34.1



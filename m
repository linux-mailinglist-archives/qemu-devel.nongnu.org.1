Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EEE7174BD
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 06:05:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4D4F-0007bT-7O; Wed, 31 May 2023 00:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D48-0007Wl-JL
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:04:04 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q4D46-0006AE-Km
 for qemu-devel@nongnu.org; Wed, 31 May 2023 00:04:04 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-19f454bd2c8so3189420fac.3
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 21:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685505841; x=1688097841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nU8J0ywB81GTgFCV0d7g07ynLS+fiwPxpZ9Ep8BvPFY=;
 b=syZFYkO9GglGbkC9DSqzo7+AjXU0WcZocw/VvVH31Q6kdY7ZRNXrmkHQex5RZvgUND
 Ujc+5jXxGYsMKT/Y6sjRz3oh7BCF9xJ11KJnuD9GNaQOSpYZHr5OrBvxZa9zOTpZ4yS+
 rpY8zv2sQRJGM+BIoyYY7E4p1MGELjmq5JzSPsBY7FTATVg/IYqJBjEk0z431Wv80y0m
 A5jjGcJo9dJO1TO/xe/WIJyBDXw2Bd1/IdrTmnYzbdpNYyyOXeNJnlLe7nl/d5jO5dtm
 8rKlKhq7q5ETB78XuXHpVNEvuBkUPIU/bc6BN0sTEQAYcxHL5WuZh7uUpNIIVSZA5nzL
 kQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685505841; x=1688097841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nU8J0ywB81GTgFCV0d7g07ynLS+fiwPxpZ9Ep8BvPFY=;
 b=KjWdwdLt5ZumbMOaOlPG4ZBN0chuSOAjWONwmtQK9jUU27d0MwMXB/MweYk+XeqVZG
 TSyZoezTmN2WWANdSYfWEX62TnhnDVrBdpf4g6x0TqRA3SBmkFjfVEezEWJW9aGuCquH
 eSmJLCcBcyZdtiBpm7hPyci0P+oWG0GEKOpvDNTsABP4WIytKYAJdgPAjuPps8XqIbgs
 xQoteBLD/YSiwdk3zcNSCli0qmSfRGq0m38RJoQXLEDpn/qkHfMz3+H40HvyHkZvR4xK
 QCp30skMa3vSzo0bxGiudYm8dzn7YfvPBUXZmBKmh/9PqPFMa85pqxXQWxmwpfWJjIR1
 bw8g==
X-Gm-Message-State: AC+VfDxWTTlbTMLfuuOazqfCJGCr6LiXcXli8WOU5N618soCbVIwWCkV
 AVyolj25J9yOkzhTxc4yXZ75/zca7eP8JUklqKs=
X-Google-Smtp-Source: ACHHUZ7Nsy4NT40kPw3qwGAC7YPnm5X25emgRbSdqKUErR0DNkvdoIQgOn+fUiljrcre2x+uCYSqyw==
X-Received: by 2002:a05:6808:2a63:b0:398:4870:d2ed with SMTP id
 fu3-20020a0568082a6300b003984870d2edmr2744044oib.13.1685505841692; 
 Tue, 30 May 2023 21:04:01 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:1cd:ec7a:a720:ce9a])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a63fc0c000000b005348af1b84csm194814pgi.74.2023.05.30.21.04.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 21:04:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 39/48] *: Add missing includes of exec/translation-block.h
Date: Tue, 30 May 2023 21:03:21 -0700
Message-Id: <20230531040330.8950-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230531040330.8950-1-richard.henderson@linaro.org>
References: <20230531040330.8950-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

This had been pulled in via exec/exec-all.h, via exec/translator.h,
but the include of exec-all.h will be removed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hexagon/translate.c   | 1 +
 target/loongarch/translate.c | 3 +--
 target/mips/tcg/translate.c  | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 770de58647..708339198e 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -22,6 +22,7 @@
 #include "tcg/tcg-op-gvec.h"
 #include "exec/helper-gen.h"
 #include "exec/helper-proto.h"
+#include "exec/translation-block.h"
 #include "exec/cpu_ldst.h"
 #include "exec/log.h"
 #include "internal.h"
diff --git a/target/loongarch/translate.c b/target/loongarch/translate.c
index 1cf27a4611..3146a2d4ac 100644
--- a/target/loongarch/translate.c
+++ b/target/loongarch/translate.c
@@ -9,11 +9,10 @@
 #include "cpu.h"
 #include "tcg/tcg-op.h"
 #include "tcg/tcg-op-gvec.h"
-
+#include "exec/translation-block.h"
 #include "exec/translator.h"
 #include "exec/helper-proto.h"
 #include "exec/helper-gen.h"
-
 #include "exec/log.h"
 #include "qemu/qemu-print.h"
 #include "fpu/softfloat.h"
diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index f3da05ba3b..74af91e4f5 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -26,6 +26,7 @@
 #include "translate.h"
 #include "internal.h"
 #include "exec/helper-proto.h"
+#include "exec/translation-block.h"
 #include "semihosting/semihost.h"
 #include "trace.h"
 #include "disas/disas.h"
-- 
2.34.1



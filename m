Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 447FB72312E
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 22:22:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6GgJ-0007GD-UR; Mon, 05 Jun 2023 16:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfr-0006tG-Hl
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:32 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Gfo-0005k6-Jj
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 16:19:30 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-653f9c7b3e4so1955562b3a.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 13:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685996367; x=1688588367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nAImCar6oyDgjZqzKCPoy2LdZjs1Hux2vEDU7Qe1ybQ=;
 b=l/nPa24fQUIv0eQA2WuXBq4Cctm5bbcT8k06GzuFhVZH2dwjQ8pglwBwlAlFfR6tK+
 +jAUrnguNt3bgXJ658gR46qm5iPpD7bqtwE+Xskn+3rF5bI16zvVM5VaqkN46K8f/fjk
 TDHSazgOBdXqLnt4wdEE9/qGF0uQ9wtkj6SujlXN3PffIXK4TGMl4cdVYaVhf29FiRCz
 hAdieSxXCJesq8de7B0aweMGNdvmkLCxZPwIzaMDxWXFlPIjHexEBQrHsoTWqZUpWLZb
 ziHM4vURqkEpp02AVMugfKLzHQncKmruKniTFnbLVN4gZl+RmwE38Ercl8mJWz8TrJxS
 Y+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685996367; x=1688588367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nAImCar6oyDgjZqzKCPoy2LdZjs1Hux2vEDU7Qe1ybQ=;
 b=N+czNV5MadTKEj2+gA4smn7n5toniFif1ukCW7iIK+l9e7BAjAbGDNcfb4a44G7kYW
 ldVX14EKeBgavNPIaQRdzp5yjwW6zVnXJtIvtzkrucY/Omrw+HMa/3/Ofl9jlYhJY5T9
 HMvtxbFnBwaL9W/mQbJsfRRWDAInsVWmT9JVsR+vP33QrMDtH0bXJyFzJQXY9FC1lUzL
 CrAPNbJFnu+I74FLni8KwN3TYQSC45hfQhhZABwQEcgRVvWMgGrBPrdYeTct/InLGfaM
 kLTxzoBXhswYFtEFFFegEhkYvThjkpJTZuUiSk06b+BLC58/ub4vxLvAlDK5q8zs1E3K
 F5Ag==
X-Gm-Message-State: AC+VfDxrgLCc2JrhhwDoS1S3U+GX58WL2ulE1I82UxwQ50sDPAuL9kb1
 RTjxghZ55yyjnfV/cN+JYkKbk6Sksm+gkX2Cgq4=
X-Google-Smtp-Source: ACHHUZ6WqieJ9gZgAMFPYU6pVg/R5SxgkPXA9F9oOdHl41PW+1rqol0uImXXps2+YsYgyqajbduTeQ==
X-Received: by 2002:a17:902:7c0c:b0:1b2:1b20:c45b with SMTP id
 x12-20020a1709027c0c00b001b21b20c45bmr1420740pll.54.1685996367323; 
 Mon, 05 Jun 2023 13:19:27 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 w20-20020a170902c79400b001a980a23802sm7018184pla.111.2023.06.05.13.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 13:19:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 43/52] accel/tcg: Tidy includes for translator.[ch]
Date: Mon,  5 Jun 2023 13:15:39 -0700
Message-Id: <20230605201548.1596865-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230605201548.1596865-1-richard.henderson@linaro.org>
References: <20230605201548.1596865-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Reduce the header to only bswap.h and cpu_ldst.h.
Move exec/translate-all.h to translator.c.
Reduce tcg.h and tcg-op.h to tcg-op-common.h.
Remove otherwise unused headers.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 6 +-----
 accel/tcg/translator.c    | 8 +++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 228002a623..224ae14aa7 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -18,12 +18,8 @@
  * member in your target-specific DisasContext.
  */
 
-
 #include "qemu/bswap.h"
-#include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
-#include "exec/translate-all.h"
-#include "tcg/tcg.h"
+#include "exec/cpu_ldst.h"	/* for abi_ptr */
 
 /**
  * gen_intermediate_code
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 60a613c99d..fda4e7f637 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -8,15 +8,13 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "qemu/error-report.h"
-#include "tcg/tcg.h"
-#include "tcg/tcg-op.h"
 #include "exec/exec-all.h"
-#include "exec/log.h"
 #include "exec/translator.h"
+#include "exec/translate-all.h"
 #include "exec/plugin-gen.h"
-#include "exec/replay-core.h"
-
+#include "tcg/tcg-op-common.h"
 
 static void gen_io_start(void)
 {
-- 
2.34.1



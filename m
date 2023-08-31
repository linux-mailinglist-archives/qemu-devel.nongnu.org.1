Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED97478EE6E
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:19:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhKP-0006eG-00; Thu, 31 Aug 2023 09:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhFu-0003cE-Li
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:58:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbhFr-0005eA-PI
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 08:58:38 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-31c5c06e8bbso635371f8f.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 05:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693486713; x=1694091513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1e6wfOUuMKCjdsL213yjWvY/4BGAvkNLIa8eLz9Omvk=;
 b=GqF3GdQVzYimY9Po0NsGNUukTmmDDvsPWS/nUcIXw+JBi/N+/oL9qpzAzNN2aiDHkI
 9ofSg81Gi/P4Z+/TGoTmVsUh76Hchj044h2eyZe4QS1+QDWZmdL4G02Ndzui2eEywxhc
 ZXbiOVuGj1cd0cyqO9QguLxF2Stp7uOt7TLJ0dMcuod+1JF7jNcM6qZelmyezgsbvFw4
 Cb2wJJs5qaBf5I8gcxEgZcpCt2uk9mwmMMwc7AXLiTIBIOZ4ORbQ9XgTyn0mOscYg5nd
 T6woG8kSpF0hsabxvgV9addb3+NTftYVbZxCnpsplbGvg7rqm1lkYj2sRokO97aMuyio
 sIRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486713; x=1694091513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1e6wfOUuMKCjdsL213yjWvY/4BGAvkNLIa8eLz9Omvk=;
 b=HD1mJN0J8ygjSKb+737ElMrlUO0C3M52uHZgrpcv7xo4icJKSijNlrB15R7E9kbz76
 YtVQEj8gAhh+eMuVUysrlu6qVwQJesJhtAVsRXHwXkoVee8qk7o94ujmuMLdFRbUwrtF
 FCnxEbTysQGu7RRCJOcUUf9iMD0dC8ORKy/DyjbQwT4sI2+S3H1BiMYk84X1T+FS17sZ
 G92jiCnMHVECP7vezBRfN218XQR4muYEb5H59+gZS4+QQI+WimnsCc67fLfdvwMB55YS
 gbomJhAql7GXJBSmX+4H2YeSfp3YSfz+3uTWaSVQhwW8Xqf+PUBq4FVQKWe7chp4QdXi
 RSkw==
X-Gm-Message-State: AOJu0Yzn48r7pv6b7b6MUFninygCaiQcNGfvIqrNW2UE5VlwNdwdFmQL
 XfpBe9x4Cgs3LMQpSgEGQfsk+IRWVycSiRDMZNw=
X-Google-Smtp-Source: AGHT+IHUjWLU/+eXL8zH76o+mmIerwYhEBVW+dytGy6Gbed/inQ69l/k7pg20eFJP18gbEsSL/iHSw==
X-Received: by 2002:a05:6000:11c6:b0:317:5b76:826 with SMTP id
 i6-20020a05600011c600b003175b760826mr3994669wrx.0.1693486713368; 
 Thu, 31 Aug 2023 05:58:33 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.199.245])
 by smtp.gmail.com with ESMTPSA id
 e2-20020a05600c218200b003fef5402d2dsm5122621wme.8.2023.08.31.05.58.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Aug 2023 05:58:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/41] exec/translation-block: Clean up includes
Date: Thu, 31 Aug 2023 14:56:20 +0200
Message-ID: <20230831125646.67855-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230831125646.67855-1-philmd@linaro.org>
References: <20230831125646.67855-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

'qemu/atomic.h' and 'exec/target_page.h' are not used.
'qemu/interval-tree.h' is only required for user emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230828221314.18435-12-philmd@linaro.org>
---
 include/exec/translation-block.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/translation-block.h b/include/exec/translation-block.h
index 5119924927..b785751774 100644
--- a/include/exec/translation-block.h
+++ b/include/exec/translation-block.h
@@ -7,11 +7,11 @@
 #ifndef EXEC_TRANSLATION_BLOCK_H
 #define EXEC_TRANSLATION_BLOCK_H
 
-#include "qemu/atomic.h"
 #include "qemu/thread.h"
-#include "qemu/interval-tree.h"
 #include "exec/cpu-common.h"
-#include "exec/target_page.h"
+#ifdef CONFIG_USER_ONLY
+#include "qemu/interval-tree.h"
+#endif
 
 /*
  * Page tracking code uses ram addresses in system mode, and virtual
-- 
2.41.0



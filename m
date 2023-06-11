Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDD972B0ED
	for <lists+qemu-devel@lfdr.de>; Sun, 11 Jun 2023 11:00:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8Gub-0000y1-W2; Sun, 11 Jun 2023 04:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8GuZ-0000xR-Ji
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:58:59 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q8GuY-0003YC-5I
 for qemu-devel@nongnu.org; Sun, 11 Jun 2023 04:58:59 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-30ae901a9ffso2969421f8f.2
 for <qemu-devel@nongnu.org>; Sun, 11 Jun 2023 01:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686473936; x=1689065936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOqRAxEV8Qalm9ZgxaBgc+XRBEy5Pw0OdcKw70bIFoY=;
 b=b7WmROGZbK43nUXk0JH8LMzqlBm4OgfAfa5jsYJHAdo5N9juZ5f+v6DaNkUqfbhZYx
 qzShfc/V5vTPLeq3qPh1tEyulfDdOlxU4k+uco7UkF5zAOBQHLVoB50XnyWgfzZME583
 iPejQ3/IrjnAAm9NXMxawlXIpq5exmdfGpo5j4n0K5LlCB7ebh7w92pVDk74HjfNQC9E
 hYLB6tL1N2OI0Ch7L4Z5hkhU2LDqhlCEjH0Cg6OeY44kscVhF0cK98cHsCe/P6Uaq4BV
 405JgqN1//e179egrhH8bgHZJ30Ded9mU64d2IJLNjQ+Tp2y2teZxs+LwiGS+1bn3bM3
 0xrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686473936; x=1689065936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fOqRAxEV8Qalm9ZgxaBgc+XRBEy5Pw0OdcKw70bIFoY=;
 b=LZXHfzXLEdXn6A6DHjtYA+ne3ioeSwzsURf8TKuUsQoOeT+PG/tZBoweP+qeuHWuee
 QGvXJZ5Ne5NdShptBTYJkZLp24oIJuJOkSS194H+rBlkBeWnPbs6M+JZ7h0quultRnZJ
 +q1U6xz82t0GPnJbYhB3sJCH0oSd/84d/0ge6g7vgyrnNm9HRslw/zVOsXxIIJev7FQl
 5kFQtqj/GmCgxfmKlZf7Hlv0CKuD55i8kegi9aWf6g/hbQAGx47oagChgoxZTRV72+y4
 JeeB4WQqp5lWbBqUjRbzBKRBlV4yZES7u4iaHelCgkn04H13kEMaPu8fVXo+koR22hD2
 yxZQ==
X-Gm-Message-State: AC+VfDzOk7BEu32aHhWBVgb67lWHNefSDP0JidJq3OPPQzqShOYXWW9+
 C89OpXy8rBr1TyyltxkiMuoLREF/Z6qIDUAAbOw=
X-Google-Smtp-Source: ACHHUZ5ydqEvb3BC7ZEr5UdbF4T08B7bsVV7fb0CZzdagZCX5pSfkXHCQSeFqLHEQbCX4kt/0BLHvQ==
X-Received: by 2002:a05:6000:1371:b0:30e:4254:2264 with SMTP id
 q17-20020a056000137100b0030e42542264mr2690517wrz.55.1686473936727; 
 Sun, 11 Jun 2023 01:58:56 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 u5-20020a5d5145000000b0030fa57d8064sm5839270wrt.52.2023.06.11.01.58.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 11 Jun 2023 01:58:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/26] accel/tcg/cpu-exec: Use generic
 'helper-proto-common.h' header
Date: Sun, 11 Jun 2023 10:58:22 +0200
Message-Id: <20230611085846.21415-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230611085846.21415-1-philmd@linaro.org>
References: <20230611085846.21415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We only need lookup_tb_ptr() prototype.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cpu-exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 42086525d7..12362177af 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -38,7 +38,7 @@
 #include "sysemu/cpu-timers.h"
 #include "exec/replay-core.h"
 #include "sysemu/tcg.h"
-#include "exec/helper-proto.h"
+#include "exec/helper-proto-common.h"
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
-- 
2.38.1



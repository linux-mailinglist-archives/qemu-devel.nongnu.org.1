Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F26736612
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 10:27:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBWhB-0003sz-I0; Tue, 20 Jun 2023 04:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWh6-0003pd-MR
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:32 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBWh5-0006AE-1j
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 04:26:32 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-978863fb00fso695641466b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 01:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687249589; x=1689841589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8HVEO+rO4JrM0VsuNZpQjo3JG+aAn77uXLrzB87/pBg=;
 b=nXJAYhgKUCzUB9JnoctJ95LQzdlk43UZp8837EvwNNM37cpsA+MNN5PS8fLBdk2B+h
 AAFMd2q+Oy+R1o+rQtb4twojHr+tteyc3YpR+1jIi3ANecubpAEmVIImJhHuJ3cDFNrU
 HyZ6S3YRI0WrYHg1N29TL89Vu1EMo4WjSuoHDE31bPlEnHsucYSjfEKE0q1upYOTchzF
 pxM5ZgdUtfi4Iuj5qiZNQyio1a96ZDUdY081Og2ZQ+g0LwgIEIUptpyY6o2mZZ4qyJ9l
 pGAWGxgxo4FPHJ5cq71kCggehh4lFqRmozYYosNSk+7so4XLr6qziG7ZbY4NQq3hlSMa
 IWaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687249589; x=1689841589;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8HVEO+rO4JrM0VsuNZpQjo3JG+aAn77uXLrzB87/pBg=;
 b=ejYqwygQ5nltxlPUlW/Yk5fDWrZr4ObNUHHm8x1QNSLfUzBuZXJwvZrPQLs4zCQvdR
 UNLMeXur4Muivb8iK3ejmhH4Pgc/TGkKgCyxOXqaAoZZnBO50x46f0rr8nvwJ+iTc5Xw
 twyKvcCa/SXI+kpeEmCJGsZggbrGF207PczaHk3DekwC5IkwLdY+OGmFGUUKw5JXyU28
 tgcYH2oRZokmGnZebAxZMnWe084rWNnRDrX+AcPEoX+o7zAXEP8K9bxAStJ8wwvE9c3n
 N0rOpead8njpTHsBhHqIGXfypWWLlKmwMzB2+9wBRIL0MlurKv+t+CoNLLhKBw+UDEsd
 Zo3g==
X-Gm-Message-State: AC+VfDx8A7V6WmFI7DcPWNPnFRhlyXqsRipzieWrgY6sxObxYcX4+dpf
 MM6fA5furoAoAGDBi1G5i3f60L6Q3v6GAmO/MAF0T4qt
X-Google-Smtp-Source: ACHHUZ4PKAiTmPnYhHBjjECIagmbZkJbnI/tHR2B8hPdon48EUxCdZrguUn5h7czF61/v4/TrV2Wrw==
X-Received: by 2002:a17:907:948e:b0:978:af9d:4d4c with SMTP id
 dm14-20020a170907948e00b00978af9d4d4cmr10838528ejc.75.1687249589041; 
 Tue, 20 Jun 2023 01:26:29 -0700 (PDT)
Received: from stoup.lan ([176.176.183.29]) by smtp.gmail.com with ESMTPSA id
 z19-20020a170906669300b00977c7566ccbsm935901ejo.164.2023.06.20.01.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 01:26:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/16] accel/tcg/cpu-exec: Use generic 'helper-proto-common.h'
 header
Date: Tue, 20 Jun 2023 10:26:09 +0200
Message-Id: <20230620082611.770620-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620082611.770620-1-richard.henderson@linaro.org>
References: <20230620082611.770620-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62f.google.com
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

We only need lookup_tb_ptr() prototype.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230611085846.21415-3-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cpu-exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c0ab00385f..179847b294 100644
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
2.34.1



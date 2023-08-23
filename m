Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E45E978618B
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:28:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuRj-0006Pg-UC; Wed, 23 Aug 2023 16:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRd-0005Og-8x
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:13 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYuRb-0006DI-J7
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:27:12 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-68a529e1974so2769469b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692822430; x=1693427230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8qLblRcFRCdHPr4hVq4biqvsFQ7fEHYa5+9HoyfNXw=;
 b=zdolvyQ4niPv/WR0CODfQgBCMu1Ps0PykOOyqAgz5tEtfRHZLQh9pM2MyQTtIveYUB
 MLMjuoOIbqSWe2KCEdnV3gZgMnK8R2UVDH673f0VxsGOZGI7pUt1QCyk4lN9dqtYA3Pq
 qhzDQ7wxUcJVleR/I4CyujEbteFnOP5/1mZHws0hpwAaghbZfZ4y1EeZF4z8cQVCbE9b
 mfD6pZuFrZzvVPrcb5ad3oI7nshpJ/Vvj0M9JH1thLpkXYTPRNw9yUH1afZnRh+qoezv
 g3/uqvaEwTPcEs4aOqHM7c4s62iK/K60M8dT6D8Uu4PyMnhF8Te9NzKZHeIkS/gGOCzH
 Wy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822430; x=1693427230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8qLblRcFRCdHPr4hVq4biqvsFQ7fEHYa5+9HoyfNXw=;
 b=ez1CLfy8zQo5xbk5IEms8p8eeQ8Vddxv5y6UrRb4HRFJST0Em0s/SuLvL4kOlYmvTw
 Q0LwsWmwQpFBZo749BXTShMVfUO7BvG6TqzvO2/3omw8nAdgSPO56djfr7+02v/0nqpp
 MiO3d+5J8YcT5UO6Zq2r7xJrwrxIV1TsGUlijClEKaV3PGH0GaOKWPqbIXIlX0LcP6gI
 /Gc5b8KFChoEn1FPUaZY1/Tt+C0lpAGpo/cYvd2vA+v+vIZNftkjWviKKfrTCrJM4Lps
 2jS53cWVK5sPfvpR/vOovX/3UhN6o6F/kWII4Q/BEmehWOXwHo+xlkD32HzqRH0nFBT7
 CYCA==
X-Gm-Message-State: AOJu0YxcLpuzVqto690oWJi81fl11RpoNS+uJUtQ/YJeLCU1vwhW03Nz
 HIcQutIREY6xA7ABsA5xaTGv4+dbMSIp3c7hJWs=
X-Google-Smtp-Source: AGHT+IFQXidTj/9noRDOhDxrGT4Pzo9ThuiKIn2rlK30+ez+8OLf9R/HLv4LDufTk94u1mQF/e58gw==
X-Received: by 2002:a05:6a21:3291:b0:140:56b6:4137 with SMTP id
 yt17-20020a056a21329100b0014056b64137mr14440042pzb.52.1692822430154; 
 Wed, 23 Aug 2023 13:27:10 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 j25-20020aa783d9000000b006873aa079aasm10117871pfn.171.2023.08.23.13.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:27:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 46/48] target/cris: Fix a typo in gen_swapr()
Date: Wed, 23 Aug 2023 13:23:24 -0700
Message-Id: <20230823202326.1353645-47-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823202326.1353645-1-richard.henderson@linaro.org>
References: <20230823202326.1353645-1-richard.henderson@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230823145542.79633-9-philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/cris/translate.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/target/cris/translate.c b/target/cris/translate.c
index 0b3d724281..42103b5558 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -411,15 +411,17 @@ static inline void t_gen_swapw(TCGv d, TCGv s)
     tcg_gen_or_tl(d, d, t);
 }
 
-/* Reverse the within each byte.
-   T0 = (((T0 << 7) & 0x80808080) |
-   ((T0 << 5) & 0x40404040) |
-   ((T0 << 3) & 0x20202020) |
-   ((T0 << 1) & 0x10101010) |
-   ((T0 >> 1) & 0x08080808) |
-   ((T0 >> 3) & 0x04040404) |
-   ((T0 >> 5) & 0x02020202) |
-   ((T0 >> 7) & 0x01010101));
+/*
+ * Reverse the bits within each byte.
+ *
+ *  T0 = ((T0 << 7) & 0x80808080)
+ *     | ((T0 << 5) & 0x40404040)
+ *     | ((T0 << 3) & 0x20202020)
+ *     | ((T0 << 1) & 0x10101010)
+ *     | ((T0 >> 1) & 0x08080808)
+ *     | ((T0 >> 3) & 0x04040404)
+ *     | ((T0 >> 5) & 0x02020202)
+ *     | ((T0 >> 7) & 0x01010101);
  */
 static void t_gen_swapr(TCGv d, TCGv s)
 {
-- 
2.34.1



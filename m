Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D14178F61F
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 01:26:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbr22-0006ob-PF; Thu, 31 Aug 2023 19:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbr20-0006nh-3k
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 19:24:56 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbr1r-0002Ht-VZ
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 19:24:55 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-68c0d4cc3a4so1159383b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 16:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693524286; x=1694129086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WknjyyvkUA5R2BgSlGNmVEJEpeTJCnFvoRCppP0P3KM=;
 b=ID9qTH1e8l70XOoWNZbmTClNjyiLUsqvM7NxEdhHgsY1mzvcMw4mtuJnYAMXnhwr7W
 4jixWe8CQMs9vIJBWlRGnhq2Ra0T4kxUVSfASPt48xAQao8j9NwT09x4h9tR88cpzRzK
 mF3UB1YlDle7hgueVppK6ZL4HThyP6nc+skv+3I8Tzn0a7UmRb9jw8673DJWQ/kSxcgT
 UcXAbyv+LQHGSV2MiTzLupkVRKU4GAH2tWVC/rFz+/STpy4PS6yWs7QAH1OodedeYUwh
 s8xOzYPq6nU4asI5CeJ44+i+2RhGkTj3pHXk0HZCrHmRcGOPeGcVbdECjBFc6uucIIlt
 PmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693524286; x=1694129086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WknjyyvkUA5R2BgSlGNmVEJEpeTJCnFvoRCppP0P3KM=;
 b=Rgfizz4TDHgghKerx9UtWHgl6Dut1mKT16eduj4lnOrHKb1/mYyr7deId4GY8HhL98
 2Rt7mTm+jDS2PoyhmJj0wVDI6aNrk47/h/2vPcGsF7a4iXhp1G2a4KcdAgIVfuX3vMZw
 4EbhFOlHkp4e3WQPKBfwhJtlV2mnHroVicWT7f2pFBPjOr8LwMY8Goic7qMhRBl08pxZ
 4XbhOWvuc9JxhdIcS5CX6QqU8OZFPzq5ivrspnqEguxHWMugA+/LhqVfg8tdVUPwAh+q
 pogA2eRuxcWa1y/EjV+v6rmKc8hcdq9eIiJGGyuHBRZQn0+6rLA1VvwE3OlqoEpkSx9B
 O7SA==
X-Gm-Message-State: AOJu0YyIbGs7ib80MLFh3uQuigV9dmGbyGO1HqHmMv3VDdC7GOSCKr+V
 ii/05cEI+0FZHuTspZ/HAfDu8SQCv043i+QJlBc=
X-Google-Smtp-Source: AGHT+IHAeOy0lLd+S/ScgvLrZs7FxN41prYgIHyvrqaFqOlxmVb04158MkvZgTmTZBed8YQWWUwxfw==
X-Received: by 2002:a05:6a21:7742:b0:14d:f8a4:d0d1 with SMTP id
 bc2-20020a056a21774200b0014df8a4d0d1mr1171762pzc.35.1693524286590; 
 Thu, 31 Aug 2023 16:24:46 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 jd5-20020a170903260500b001bb8895848bsm1732711plb.71.2023.08.31.16.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 16:24:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 5/5] target/arm: Enable SCTLR_EL1.TIDCP for user-only
Date: Thu, 31 Aug 2023 16:24:41 -0700
Message-Id: <20230831232441.66020-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230831232441.66020-1-richard.henderson@linaro.org>
References: <20230831232441.66020-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

The linux kernel detects and enables this bit.  Once trapped,
EC_SYSTEMREGISTERTRAP is treated like EC_UNCATEGORIZED, so
no changes required within linux-user/aarch64/cpu_loop.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 0bb0585441..b9e09a702d 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -243,6 +243,10 @@ static void arm_cpu_reset_hold(Object *obj)
                                   SCTLR_EnDA | SCTLR_EnDB);
         /* Trap on btype=3 for PACIxSP. */
         env->cp15.sctlr_el[1] |= SCTLR_BT0;
+        /* Trap on implementation defined registers. */
+        if (cpu_isar_feature(aa64_tidcp1, cpu)) {
+            env->cp15.sctlr_el[1] |= SCTLR_TIDCP;
+        }
         /* and to the FP/Neon instructions */
         env->cp15.cpacr_el1 = FIELD_DP64(env->cp15.cpacr_el1,
                                          CPACR_EL1, FPEN, 3);
-- 
2.34.1



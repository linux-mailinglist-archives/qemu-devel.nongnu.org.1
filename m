Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB109782E45
	for <lists+qemu-devel@lfdr.de>; Mon, 21 Aug 2023 18:22:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qY7cq-0001mt-M9; Mon, 21 Aug 2023 12:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cS-0001VG-QD
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:17 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qY7cQ-0005cq-9L
 for qemu-devel@nongnu.org; Mon, 21 Aug 2023 12:19:08 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bc83a96067so18879675ad.0
 for <qemu-devel@nongnu.org>; Mon, 21 Aug 2023 09:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692634745; x=1693239545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZrc3DuTynbE6ZobmlduknjscYzm5QXC9S5Fbkh1+j8=;
 b=JPwA7U1lnq87ZJz4GLDZpKAqSmYvQKmBOxmGJfYb41Ex6ML8pS7y2f2qi17zKQH6zL
 UjopOsqj7tHnjM7yJICIO7FYxxGiuO52iYVuti+sRki0btgcfP9dcZx1pxm6pqy7pWkp
 yYXOvL0rEvU2+2WI0gV1uEQqviOfrTAp5S1+f4ttHYiqy28IYwckk5Qh0gKpGlh5wHu8
 2tJHpVlDAPzSBm+5MFm/qzX3AZPdlNTS8fZytXrn5orMww8kDdOBrPmHMm9PbbQgnlEX
 D1+aSXQeP024mlEEIwojO6vDo7mJ8XFdzEzQCAzA/epb/9XeCiJs4kflp/AEnFctL/ye
 ISdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692634745; x=1693239545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cZrc3DuTynbE6ZobmlduknjscYzm5QXC9S5Fbkh1+j8=;
 b=kMxZEsJcFuM2IzCDaPwnwUTubuUXER2gp4PFJDa/hqCpNctE0OoroW+CVWCU3JpdxI
 YE7uR1zBwIDOS/YdXECbQmHCyYYjUtwnld/O1pv59DAD2kQFZ65TLcONYbip02s8mC4T
 9RPNCiaWWUR3oSOjUa0l/jXQgpt5wdlfHtdpQpQ/C+W1DzcsIRuc8JD7nHZsoANjkBcT
 7GSnahye5s/WTyvyYGoer8QRkvZDuXmWxE99NRUyg37fmnRXyeSU7OJiR8CXH9y9kNWF
 SAw8sV/Uj9VP/u3tWYfWQuf4Zujc1gR7s/8xqidNVc7sMXhHcZlOghLle2ZSJzNBPJL3
 0rmg==
X-Gm-Message-State: AOJu0Yzbg31cIeg8EUmrAR5hDvaaeweYZLNza3sfBH5SI0lpVpnUN/gN
 lX4gPUIvrMu9Hcc1K1d/X5+g7jyQVzkkyfZxK7Q=
X-Google-Smtp-Source: AGHT+IFwq2W2K0WPC+EqLzTAPhKDsQnYxwrKTDSzMeTkZAwwC8f9Pmey6tRF/M4C4JA5QAFfbZh89Q==
X-Received: by 2002:a17:902:ce8e:b0:1b8:a389:4410 with SMTP id
 f14-20020a170902ce8e00b001b8a3894410mr6265584plg.0.1692634744826; 
 Mon, 21 Aug 2023 09:19:04 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:2c08:e710:4459:46f1])
 by smtp.gmail.com with ESMTPSA id
 e16-20020a17090301d000b001ab2b4105ddsm7234549plh.60.2023.08.21.09.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 09:19:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, ardb@kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 10/19] target/arm: Use clmul_32* routines
Date: Mon, 21 Aug 2023 09:18:44 -0700
Message-Id: <20230821161854.419893-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821161854.419893-1-richard.henderson@linaro.org>
References: <20230821161854.419893-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Use generic routines for 32-bit carry-less multiply.
Remove our local version of pmull_d.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 5def86b573..ffb4b44ce4 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2055,18 +2055,6 @@ void HELPER(sve2_pmull_h)(void *vd, void *vn, void *vm, uint32_t desc)
     }
 }
 
-static uint64_t pmull_d(uint64_t op1, uint64_t op2)
-{
-    uint64_t result = 0;
-    int i;
-
-    for (i = 0; i < 32; ++i) {
-        uint64_t mask = -((op1 >> i) & 1);
-        result ^= (op2 << i) & mask;
-    }
-    return result;
-}
-
 void HELPER(sve2_pmull_d)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     intptr_t sel = H4(simd_data(desc));
@@ -2075,7 +2063,7 @@ void HELPER(sve2_pmull_d)(void *vd, void *vn, void *vm, uint32_t desc)
     uint64_t *d = vd;
 
     for (i = 0; i < opr_sz / 8; ++i) {
-        d[i] = pmull_d(n[2 * i + sel], m[2 * i + sel]);
+        d[i] = clmul_32(n[2 * i + sel], m[2 * i + sel]);
     }
 }
 #endif
-- 
2.34.1



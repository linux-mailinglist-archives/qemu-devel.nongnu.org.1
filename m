Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 384E87A23C8
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBuC-0004YY-Ts; Fri, 15 Sep 2023 12:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu7-0004W8-0c
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:52 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu2-0004wW-6b
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:50 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68fcb4dc8a9so2247964b3a.2
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796165; x=1695400965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LeRwmoZj3gayyKtebRoC0JW2YuHlKTaNGyIqgqME+tw=;
 b=MLzuqBHT1waQVa1NmOP9k3UJtevIvMy1oTuSwiUvfGcDmEeoZ9Jb3+fvztG9ofYGsq
 UAxlC9Ff02l0EfDVaEMMq91hzSnWiRSl8PTwAgzn5StD1egatIJxGD5Mj0ex9m9LidX+
 fBHett9ZGt6UtHUeTy4nzZW9r9Km9aQFpr0e12yZGXtyYTE8LNPuevRrDJBupeixOQft
 sjG21otw/lldKsRfH4Ek+/ZKH+n0gl0qpAtHJf4L4YjtaBPzYpji4IERipln9z1G8yzQ
 il9Dh46xVgsOeRK9HBh1pwDqjj7KsKsVGMwOQpHk3fCki+XaBRdQ3reKnUzE8prMvZ4I
 YqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796165; x=1695400965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LeRwmoZj3gayyKtebRoC0JW2YuHlKTaNGyIqgqME+tw=;
 b=Y6jMYPGnlj+6+o8G9CCvO+0ckE8nqrVZIv130nglztMOKhQOWIr/Nj9XMwLhPl6dVb
 HVbIVQRwXxnJbL0+MgdothUDkFUEEmUnjihT4uuzDANBAumzNe72MXZ3RwhyL76/OlXP
 EHUgQndeJ6bdcLKas1nSc+DCiHeJl+YdXJmCwmiyA+qo0wtxDLBZoT0h9UQx+mcRPGKL
 OLZ2qa3l+Si0eJSStAP6j6DqDyHQVjgEVZRIgf6tZhbxdnm2Srt8zAc/8b6WZMiAlleO
 5Ln+YWsDUMw74UB2NfWq1S7cEW8eBsMsEWw1fJ7dqb2G6ECwHqOzN00ub6K2nuYD3/sc
 tfMg==
X-Gm-Message-State: AOJu0YxhosdMNcgHQPiEQHtB8/cqutLg1nopQ/FrHhXSsNA5Q6i80VWU
 jsMEFkhKWzyy6jWHEhZ56NNAxiWFd75JeS9KT3U=
X-Google-Smtp-Source: AGHT+IG/76RxcSJfh6KMiNChvxiv/ay/CY11IQ8yRBG57ne/klwl1EgKdpjPcJ2gJQPC01bQF8eHyQ==
X-Received: by 2002:a05:6a20:bb02:b0:157:7568:6796 with SMTP id
 fc2-20020a056a20bb0200b0015775686796mr1890837pzb.60.1694796164956; 
 Fri, 15 Sep 2023 09:42:44 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/19] target/arm: Use clmul_64
Date: Fri, 15 Sep 2023 09:42:26 -0700
Message-Id: <20230915164231.123580-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Use generic routine for 64-bit carry-less multiply.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_helper.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index ffb4b44ce4..1f93510b85 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2003,28 +2003,14 @@ void HELPER(gvec_pmul_b)(void *vd, void *vn, void *vm, uint32_t desc)
  */
 void HELPER(gvec_pmull_q)(void *vd, void *vn, void *vm, uint32_t desc)
 {
-    intptr_t i, j, opr_sz = simd_oprsz(desc);
+    intptr_t i, opr_sz = simd_oprsz(desc);
     intptr_t hi = simd_data(desc);
     uint64_t *d = vd, *n = vn, *m = vm;
 
     for (i = 0; i < opr_sz / 8; i += 2) {
-        uint64_t nn = n[i + hi];
-        uint64_t mm = m[i + hi];
-        uint64_t rhi = 0;
-        uint64_t rlo = 0;
-
-        /* Bit 0 can only influence the low 64-bit result.  */
-        if (nn & 1) {
-            rlo = mm;
-        }
-
-        for (j = 1; j < 64; ++j) {
-            uint64_t mask = -((nn >> j) & 1);
-            rlo ^= (mm << j) & mask;
-            rhi ^= (mm >> (64 - j)) & mask;
-        }
-        d[i] = rlo;
-        d[i + 1] = rhi;
+        Int128 r = clmul_64(n[i + hi], m[i + hi]);
+        d[i] = int128_getlo(r);
+        d[i + 1] = int128_gethi(r);
     }
     clear_tail(d, opr_sz, simd_maxsz(desc));
 }
-- 
2.34.1



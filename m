Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA927A23C3
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:43:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBu1-0004Th-Ga; Fri, 15 Sep 2023 12:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBtz-0004Sp-4y
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:43 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBtx-0004uU-HV
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:42 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68fb98745c1so1949948b3a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796160; x=1695400960; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BL7EbX1EMhValKoX7e6yR5u3D5ZsID7pdC/xAbPtSgQ=;
 b=ppPnd8PGjQIdN0/Is0+THxhjil2HH8c6Luk9SIlO6X+eo/q9hoiMhRQsyqbYIhSXnr
 6tgmm93JxpdwGpztudvJyGWe+Di24IeveBDGgQMU3j8h03XTS6NhOXCUBTXOgVMb3Shp
 AEkDTMp68v3z/76SXoXkJ7sxTADFJJJkArrU4LigHLxvG4Ts3Y9GigcjEnYfP+LS+v+f
 Z5RJzQ1RMKRd7Ov3qp/tH+DlLcFg3Ui75UoTsNVxuz0Wa/Pa1qGGZmRNKETITKxYcf11
 5F6HeKrplrXOxdH35LdDYeveFKIU4b6OZOPm6FuxMbXGE1puaVZ6jkkcLsWgrb4CdetC
 5yjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796160; x=1695400960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BL7EbX1EMhValKoX7e6yR5u3D5ZsID7pdC/xAbPtSgQ=;
 b=P1j3qXuPxCIoEOCkhJfWwYiwvITzK3Zw7hoDOfz00rohLrjHKx7Fv2JPXHQ/fRrqoz
 ihQByZ3GBQNjO2CKf6arYQDYISBYxleDbcUrZE8zXBUsV98EtU7CN1YpAtxQqRfmhNSg
 tmOybYEmIA0rRK6Z9O/rqNTQWZe+wLI8GwkJydZJfX/S9E7Xty49jbTlC/bASXwPJF6i
 zaOfK+H0pKjI2Vum7LPxHamL1pP/e6BS3rLT7JJ1Xg8OwmAS+KzIWPGHRqO4RiIwXu57
 nLPXw5R5ITqk3BLxvzOk2jd7qsvh/jXhKavJsG9xVXNRXhtHknIC4xAfMJ2fq8L2K3p8
 6wfw==
X-Gm-Message-State: AOJu0YzAoIg0ZmKD3DrDaVsuD1TuSlSNGOCVhNMYZzIsFOr3qbV6AkZl
 7GMkrNEFu5eGNt53NLMvq48MDbaT/HKBxXmjrl0=
X-Google-Smtp-Source: AGHT+IFT/yLy3l+yJ84U1C5r4xFGocbBLm1m+fVG633ioNisZ5fX5VaEI48sSi9U7Vm066EMoEfY2Q==
X-Received: by 2002:a05:6a00:1409:b0:68f:cd32:c52d with SMTP id
 l9-20020a056a00140900b0068fcd32c52dmr2328733pfu.14.1694796160177; 
 Fri, 15 Sep 2023 09:42:40 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/19] target/ppc: Use clmul_16* routines
Date: Fri, 15 Sep 2023 09:42:20 -0700
Message-Id: <20230915164231.123580-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Use generic routines for 16-bit carry-less multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index f45b24d321..ebb2957fe7 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1437,6 +1437,14 @@ void helper_vpmsumb(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     }
 }
 
+void helper_vpmsumh(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+{
+    for (int i = 0; i < 2; ++i) {
+        uint64_t aa = a->u64[i], bb = b->u64[i];
+        r->u64[i] = clmul_16x2_even(aa, bb) ^ clmul_16x2_odd(aa, bb);
+    }
+}
+
 #define PMSUM(name, srcfld, trgfld, trgtyp)                   \
 void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)  \
 {                                                             \
@@ -1457,7 +1465,6 @@ void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)  \
     }                                                         \
 }
 
-PMSUM(vpmsumh, u16, u32, uint32_t)
 PMSUM(vpmsumw, u32, u64, uint64_t)
 
 void helper_VPMSUMD(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
-- 
2.34.1



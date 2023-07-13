Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F61752BED
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 23:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK3eY-0000Lv-Ur; Thu, 13 Jul 2023 17:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eK-0000JI-NA
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:56 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qK3eI-000186-RR
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 17:14:56 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fbf1b82de7so7720355e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 14:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689282893; x=1691874893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIVnJ7xXPoFHeKhRtV8u1nP3hp+hYXvngLOg/MOoyhs=;
 b=fLtEgnncCjkpJKMR5EUcqTThok6V4283ZQNWuxOUcnZGvSQ7KnVx6WbaRA7Rz5w5c9
 MHv8ot8qQm0NE/bsjxse0JJq/hO/36lOwEnnU+SEJu0tzWiAccmrl4Fm525s5f1o7CtD
 k3+dvDaJMkbVUvxtC3tk0cRoyLQ+QE8rQzLAFjDPumdBmwfWg3N2jSMjG4ZZwZRP9xGY
 /xaSvSY0yNORREHO7R/ARuZTe5XXwjK2S4h6ClOws1A8KUGYI1EcF0TcPYC7rH9DA4fe
 sEfSFCZAp0ksx43P7ybIlTIC9ah6brtPvPO0/MgBG7um3w+HJ/XCJdiKfP4u00pIe/8w
 251Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689282893; x=1691874893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nIVnJ7xXPoFHeKhRtV8u1nP3hp+hYXvngLOg/MOoyhs=;
 b=NA5VY3OG1PkBz3z0BJj+CNbLMyiR1NlgPyZzyhph3KmQL0SK+HubqaEEbIgFyjZQIp
 /qETjg93mObT10X+FX+8vsEO9Jppqu+A4xgfNDWMPee+U5FwajPEyCTInwWI18olUq0W
 FmWQrgkff1uASlcoWI0dJn/fOV1iHtMtKpWlyi4HMsh/5Vr97MfkexhWpVhdWUACaAH6
 CWUSQLEd7Lt9kRKlIOCft4iO1wTz2jmcXplo3gu6jpoPtz4oFn8oNXjFHIFkHuSUGr+H
 CDeh6fvd2yqRxlaNY+PktpBHaHByg9Xc99sA88sX1M7ntpi9pd/i/HaMR9zlRqCHNzXQ
 R79Q==
X-Gm-Message-State: ABy/qLbUgP2f6QuxSG2Z0KCyCNzoNvWkDoYy0b7bVAMouJ/61SUEAfkS
 l7BgoLvCmKzPs1ybuVcuPBMadUY2Lv1zDdMumRQs+Fet
X-Google-Smtp-Source: APBJJlFurunZJkiMW5hRh74WNe5sYNVrK/BLDzRJ1M08MBrnmHlAtITtT/gEI6MnI3semGkBQRHXww==
X-Received: by 2002:a7b:ce87:0:b0:3fa:8422:158d with SMTP id
 q7-20020a7bce87000000b003fa8422158dmr560883wmj.18.1689282893616; 
 Thu, 13 Jul 2023 14:14:53 -0700 (PDT)
Received: from stoup.. ([85.193.156.66]) by smtp.gmail.com with ESMTPSA id
 n12-20020adff08c000000b0030ada01ca78sm8973747wro.10.2023.07.13.14.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jul 2023 14:14:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH 12/18] target/ppc: Use clmul_32* routines
Date: Thu, 13 Jul 2023 22:14:29 +0100
Message-Id: <20230713211435.13505-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713211435.13505-1-richard.henderson@linaro.org>
References: <20230713211435.13505-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

Use generic routines for 32-bit carry-less multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 98d6310f59..828f04bce7 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1444,28 +1444,15 @@ void helper_vpmsumh(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
     r->s128 = int128_xor(e, o);
 }
 
-#define PMSUM(name, srcfld, trgfld, trgtyp)                   \
-void helper_##name(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)  \
-{                                                             \
-    int i, j;                                                 \
-    trgtyp prod[sizeof(ppc_avr_t) / sizeof(a->srcfld[0])];    \
-                                                              \
-    VECTOR_FOR_INORDER_I(i, srcfld) {                         \
-        prod[i] = 0;                                          \
-        for (j = 0; j < sizeof(a->srcfld[0]) * 8; j++) {      \
-            if (a->srcfld[i] & (1ull << j)) {                 \
-                prod[i] ^= ((trgtyp)b->srcfld[i] << j);       \
-            }                                                 \
-        }                                                     \
-    }                                                         \
-                                                              \
-    VECTOR_FOR_INORDER_I(i, trgfld) {                         \
-        r->trgfld[i] = prod[2 * i] ^ prod[2 * i + 1];         \
-    }                                                         \
+void helper_vpmsumw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
+{
+    Int128 ia = a->s128;
+    Int128 ib = b->s128;
+    Int128 e = clmul_32x2_even(ia, ib);
+    Int128 o = clmul_32x2_odd(ia, ib);
+    r->s128 = int128_xor(e, o);
 }
 
-PMSUM(vpmsumw, u32, u64, uint64_t)
-
 void helper_VPMSUMD(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i, j;
-- 
2.34.1



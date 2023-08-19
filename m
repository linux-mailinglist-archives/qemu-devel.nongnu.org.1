Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 42875781631
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 03:03:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXAMS-00006A-41; Fri, 18 Aug 2023 21:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMQ-00005B-4R
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXAMN-0007O0-Vg
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 21:02:37 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1bdca7cc28dso12355495ad.1
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 18:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692406955; x=1693011755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYOvUjl9DKYepdyDRgw1XoKhgsFy5EQ3dFtSTrNTOWE=;
 b=T7YmyQ0hTa37BA8zQsPUY0C+QlKcFL2EtaFxnuGn/8GRI+8FmFF2G1d2a4hMAOsFsH
 9kNiuYpTgitTw4ouQUkU8zuhSmZm5YRzCu+RAZ4kDNpwCoyHSFfKgLkMwdNtNqYfIpCe
 Bd4VRdeYE0Fno6yZbceSknSoxct6f6EVY9gO/uWdJzcEomrpkLe7pn6fd33DpXhTWhGa
 MwP8Ua3Ea/hFj6kkgkGjloZNg+F4uBB2LCkIA/HKO2CmfOPsPh+7OloXeNHmjbSWuUwf
 F/0RVxMWMsb1qo0a9VbiomN7vZjkAKo85jtuO8fKR7ghVWbvBiXFzZNEpds8llA715hC
 81aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692406955; x=1693011755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYOvUjl9DKYepdyDRgw1XoKhgsFy5EQ3dFtSTrNTOWE=;
 b=Edb/dS6MqBtCYNItoN/k6Xai7wuYLezQWXKqrB+Tp7vvLemtKxMvtpJQSpOqjHWxeJ
 tcrSD1Q+PRj02eAF2qJM31jyf1t5AanLqO3HYn3xerAeDao716tdn/eeemzzDvfDBxlu
 GP2cp7xRk1gv/6k3S7OdvAx8Uv33muPkBeITBrKSTvwBtmOAv/tIIL+Ufms4Y+LWS8fU
 8YwtZJ6975eR6wfJOwSF9CYMw0ikHJ4VJjp4lkduR1ybMDGJ+dCxbq2zbPH3JVtpYBae
 dfq0Y+DiWioDdBorDFxZZ7Cjcn3Ipo7kWxvKcIYKxpgzhlthIUfPntGI9SaBdPeAU/u1
 Z9MA==
X-Gm-Message-State: AOJu0Ywb5PuESQcWTwsvZ/smeXiL4V+pEaTcDWbS/87i8o1tNDUG3i9s
 2i5TZlAfxbZMOh70L4/rw2ip3rWeIcVnkkpYaGI=
X-Google-Smtp-Source: AGHT+IHJTNeVG6LNfctfk9YDp2pd3DMAe7IFLQSSoZjjZkrHTHdILe9GIpxSpPymAwHqw8WhlIDiJg==
X-Received: by 2002:a17:902:ce8e:b0:1b8:8223:8bdd with SMTP id
 f14-20020a170902ce8e00b001b882238bddmr860340plg.59.1692406954751; 
 Fri, 18 Aug 2023 18:02:34 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a170902d50d00b001b87bedcc6fsm2372019plg.93.2023.08.18.18.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 18:02:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	ardb@kernel.org
Subject: [PATCH v2 16/18] target/ppc: Use clmul_64
Date: Fri, 18 Aug 2023 18:02:16 -0700
Message-Id: <20230819010218.192706-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230819010218.192706-1-richard.henderson@linaro.org>
References: <20230819010218.192706-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Use generic routine for 64-bit carry-less multiply.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index ce793cf163..432834c7d5 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1456,20 +1456,9 @@ void helper_vpmsumw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
 void helper_VPMSUMD(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
-    int i, j;
-    Int128 tmp, prod[2] = {int128_zero(), int128_zero()};
-
-    for (j = 0; j < 64; j++) {
-        for (i = 0; i < ARRAY_SIZE(r->u64); i++) {
-            if (a->VsrD(i) & (1ull << j)) {
-                tmp = int128_make64(b->VsrD(i));
-                tmp = int128_lshift(tmp, j);
-                prod[i] = int128_xor(prod[i], tmp);
-            }
-        }
-    }
-
-    r->s128 = int128_xor(prod[0], prod[1]);
+    Int128 e = clmul_64(a->u64[0], b->u64[0]);
+    Int128 o = clmul_64(a->u64[1], b->u64[1]);
+    r->s128 = int128_xor(e, o);
 }
 
 #if HOST_BIG_ENDIAN
-- 
2.34.1



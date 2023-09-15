Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B977A23C7
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:44:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBu9-0004XR-I9; Fri, 15 Sep 2023 12:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu6-0004W5-Tc
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:50 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBu5-0004x6-GG
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:42:50 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-69042d398b1so989433b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694796168; x=1695400968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Rw61LzYCVJHqZF5cECHlyAs/184pzzLTdpSydfaqRc=;
 b=LgM9q1o1ACtTVPeJnffKhNDMZzPVeM1QtgytIyhEsDkoJYB7208bUVxucr9Swpr3hT
 1YHNHoiPxLh9ygVjzwzTPxE9J1UTYz6CkUqDlo3zedrSGazRwLcsn7I1xHBpbG/zFY4F
 Th/Mql75CYayuyQohw5ixcySO2OFoF3zBHtTGMEsDtjOHq/V1SgH9lJVzkymL5bXqwyK
 FpPbL1z0tlorxnkgHA0oAsDvscWfhtFck7U5CLaRrcv3/tik/HUz5/5XAX0W4VYNr3KT
 E1d/cgcWbFUCSbh7G1eo8OPku67RQTqlf0r7utDLm4ePX1k4kuGZ6x2PUI8DGKtdgPhp
 BuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694796168; x=1695400968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Rw61LzYCVJHqZF5cECHlyAs/184pzzLTdpSydfaqRc=;
 b=VnyzUTFItrfU5qqzIcKlQuGP5l/Ebb7os2VI6kNiybJVf+HRRMdnJXrPgSm85BKJ+D
 mAKAVSD3eBG5Na0e99dSUPG2ax9o5eefsc+xzyX+fcPx3ClusqjLDMV8MApgZbf87Lda
 l38rNlMWiutGIIqSaxQKhCkHnyPOzZcrEa7001EFuJuqHs3LbbmtKfljYLRl520Mq2tL
 noImBWR3JaMVoqvkMJTdWp5S6jXatdkp2+hvNC3Z3cfAPirMpR4LXFAUWxfAaSriRQsd
 nGKeyf50BRP/gvTnOge3pUCO1AwPYYdOkGd2rUhLQCrkNEkyCBAGiGLXTr8DnzQ83s7O
 kjYg==
X-Gm-Message-State: AOJu0YxAaqZQCr+Rg6/iBzXtIIH823UaAvK6kKvEfZKeseJSGm2kjG8g
 BoJ01UzKa76JqHcheFvsRs11oA/t+1ZhdjTfa94=
X-Google-Smtp-Source: AGHT+IFQZYHt8jxpyREB+1wS77kYqEZQXNIAUyBR2IyGppMbui+wOOf4BXf3Nufka1keigJVYr98EQ==
X-Received: by 2002:a05:6a21:47cb:b0:153:24c2:c93b with SMTP id
 as11-20020a056a2147cb00b0015324c2c93bmr2212368pzc.1.1694796167987; 
 Fri, 15 Sep 2023 09:42:47 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 s187-20020a6377c4000000b00577f55e4a4esm3010087pgc.20.2023.09.15.09.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:42:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/19] target/ppc: Use clmul_64
Date: Fri, 15 Sep 2023 09:42:29 -0700
Message-Id: <20230915164231.123580-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915164231.123580-1-richard.henderson@linaro.org>
References: <20230915164231.123580-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Use generic routine for 64-bit carry-less multiply.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/int_helper.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 1ea42b4ede..6fd00684a5 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1455,20 +1455,9 @@ void helper_vpmsumw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 
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



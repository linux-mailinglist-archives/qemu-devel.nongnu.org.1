Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F791785B43
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:57:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpHp-0006vF-15; Wed, 23 Aug 2023 10:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpH5-0006lY-KF
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:55:59 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpH4-0007WK-40
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:55:59 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso725828766b.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692802556; x=1693407356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bgZaltKaeNfzqYDJtYBATNYhh0W6KTRpUukWBytbNs8=;
 b=imbUPrQay4ivpe5Hg6tytg00Gi8LZDnmAqBGnTv8aeYRYLu94QSvKsMefHzNCAL5K5
 ouE8/ljprGj62ECOTYxtmb8eLj4rX8WClgPiCGUu53EjXbUZDe3B3mb4IW0lIt/0rAyN
 fJUwzgm2iCsGX3PG4tqkaUHULG1R+9xZKG3SH5dGVXr0IExMTRCZ49/pPorxGnAUOJ4A
 zfwQTUFVXxfBfc5kA1TXGI+POcCnE9KhVp3WsTRHGCnORBHrLmTIVYceuk5HHLyzsXAo
 iw2KuNpXUumrKFCOSZNvEwHaNC9rTtFoVhAfQ2vuY/kIe93iR7HA9n2Qqhvmultie+Zf
 8kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692802556; x=1693407356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bgZaltKaeNfzqYDJtYBATNYhh0W6KTRpUukWBytbNs8=;
 b=XKauATygfvhQgNlKraQE6HZob0FeQ9wFPUoN3kmUSNqrpELxm2c010Xf3n5GqHxeVD
 kDn21jqhRf4gKShpNNojq8MyZsCCR2rirmYJKBT0HiLxqYpUGZ1ctsyW2LCxnABT2RL/
 Ki/omMYQQik3yYQdVrYIw6iXVwu6gyddKo2v2cbz0IaSspBGjRyTCN4FTpn+ufcrsC0x
 Wg12hKj69VEnvhRpbR6OAl2BxyPo2eNOqQbg8QA5aBhZRNEe8621HbmEuElni3D+6hLs
 uUOUa55MBwDaOBr3uWol1KyHGXWZE1rqq1R+2ga6QeOhZmCeVC7xe6JdL6K+9Ig2ewpZ
 /2fQ==
X-Gm-Message-State: AOJu0YwaXTRP37s5OiMLG2jluIZ55U3iqdiD062HYpdQRW8Lbha+5TmV
 8QpN2FVaCSQStJFKp3To+yhwt+BdXFk013ZKaiSKBg==
X-Google-Smtp-Source: AGHT+IF4/YMDeTHlZoyjm3/hh9xV7NPJCJ1+ol3K+3o2atLRO+o3MpWdSZoKBp0C+gGAtJPHh8p54w==
X-Received: by 2002:a17:906:538d:b0:99d:6dd7:42c2 with SMTP id
 g13-20020a170906538d00b0099d6dd742c2mr10913390ejo.40.1692802556337; 
 Wed, 23 Aug 2023 07:55:56 -0700 (PDT)
Received: from m1x-phil.lan (gsv95-h03-176-172-10-165.dsl.sta.abo.bbox.fr.
 [176.172.10.165]) by smtp.gmail.com with ESMTPSA id
 d16-20020a17090648d000b0098d2d219649sm9942518ejt.174.2023.08.23.07.55.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Aug 2023 07:55:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/8] tcg/tcg-op: Document bswap16_i64() byte pattern
Date: Wed, 23 Aug 2023 16:55:36 +0200
Message-ID: <20230823145542.79633-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823145542.79633-1-philmd@linaro.org>
References: <20230823145542.79633-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg-op.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c1b9a3e34c..80ec6f01c4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1737,6 +1737,15 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
+/*
+ * bswap16_i64: 16-bit byte swap on the low bits of a 64-bit value.
+ *
+ *                                                           flags
+ * Byte pattern:  bswap16_i32(......ab) -> ......ba     (TCG_BSWAP_IZ)
+ *                bswap16_i32(xxxxxxab) -> ......ba     (TCG_BSWAP_OZ)
+ *                bswap16_i32(xxxxxxab) -> ssssssba     (TCG_BSWAP_OS)
+ *                bswap16_i32(xxxxxxab) -> xxxxxxba
+ */
 void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
 {
     /* Only one extension flag may be present. */
@@ -1755,22 +1764,28 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
 
-        tcg_gen_shri_i64(t0, arg, 8);
+                                            /* arg = xxxxxxab (IZ=0) */
+                                            /*     = ......ab (IZ=1) */
+        tcg_gen_shri_i64(t0, arg, 8);       /*  t0 = .xxxxxxa (IZ=0) */
+                                            /*     = .......a (IZ=1) */
         if (!(flags & TCG_BSWAP_IZ)) {
-            tcg_gen_ext8u_i64(t0, t0);
+            tcg_gen_ext8u_i64(t0, t0);      /*  t0 = .......a (IZ=0) */
         }
 
         if (flags & TCG_BSWAP_OS) {
-            tcg_gen_shli_i64(t1, arg, 56);
-            tcg_gen_sari_i64(t1, t1, 48);
+            tcg_gen_shli_i64(t1, arg, 56);  /*  t1 = b....... (OS=1) */
+            tcg_gen_sari_i64(t1, t1, 48);   /*  t1 = ssssssb. (OS=1) */
         } else if (flags & TCG_BSWAP_OZ) {
-            tcg_gen_ext8u_i64(t1, arg);
-            tcg_gen_shli_i64(t1, t1, 8);
+            tcg_gen_ext8u_i64(t1, arg);     /*  t1 = .......b (OZ=1) */
+            tcg_gen_shli_i64(t1, t1, 8);    /*  t1 = ......b. (OZ=1) */
         } else {
-            tcg_gen_shli_i64(t1, arg, 8);
+            tcg_gen_shli_i64(t1, arg, 8);   /*  t1 = xxxxxxb. (IZ=0) */
+                                            /*       ......b. (IZ=1) */
         }
 
-        tcg_gen_or_i64(ret, t0, t1);
+        tcg_gen_or_i64(ret, t0, t1);        /* ret = ......ba (IZ=1 or OZ=1) */
+                                            /*       ssssssba (OS=1)    */
+                                            /*       xxxxxxba (no flag) */
         tcg_temp_free_i64(t0);
         tcg_temp_free_i64(t1);
     }
-- 
2.41.0



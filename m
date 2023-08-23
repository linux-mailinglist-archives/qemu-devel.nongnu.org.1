Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAA7785B3F
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:57:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpHI-0006oC-N0; Wed, 23 Aug 2023 10:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpHG-0006o2-Ra
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:56:10 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpHF-0007XC-5B
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:56:10 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso760338366b.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692802567; x=1693407367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=McFIimYCHo/OXuvkXkkETAJuvcbJTu/sEWzfSN2RhFU=;
 b=BHDIfhkkByIIf94LwS/wzhWfOxc7glIa+Jv6Tq7SmHbxqOJkPcnOAm5M0XJdj9Fm3h
 L+LytdnPu1C4I5PF5FPY/KY2dMSbcXzbJavxs81kRxpDFwX9YaoC8VmNjcyDbqWA8pmr
 qZNpUNdCdvapGATC3i+752k9cQ9ZPt704nJ0px/lg9V43z6LlhdnE+JQPa7BDPC0gIgz
 XK0IS7W+Nh/qbzTV4iHF+ZWMVMdgg+RQkXlRfH12EteLH8tmTGfwJCe33Iiw7EW6n/rw
 wBYZYaOUgej1xpHK1qxZEPlZyz+dVwJv3/JSpQQ5LcOyb9wOpE8ifjbG2Ri5LYUwu6iO
 NzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692802567; x=1693407367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=McFIimYCHo/OXuvkXkkETAJuvcbJTu/sEWzfSN2RhFU=;
 b=iOmEFuLVAy/OPolzgkPb83lirQeFmbegDtw7BmApSkNw+hQdBmC03AhoobnyNZADyg
 nedwpkh+qkoRAIkgUO4nSHudbN+YAJnW6NIUxKPVymuH9pEOizH2sqYh7gYhZpsqOBKa
 BEzNn/tIoErGkgmsutXbUbOEoxyw++Z23vVVG/ENN4UBEZNZ0tL0ptRRq+cxYAD69+gV
 hKK/HktK0yEa+IOECzKuK7dM8yhHfL6pvXGWFaJP1GNyeiOuUuN6DqF7iCa0hzm11Nfg
 aS1lEBZuH9RVxjwCwIhNlm9dBLgrGUmeqIuCugQiDn71bLPVJ/TqG/52ZDgPvJW6JQQP
 7fEw==
X-Gm-Message-State: AOJu0YzqZh0hBqGwfGaLI+Cu/mok4BpHQVvNsifzkwuU259wwff//Qhh
 GmC6TwlnFFF94X6X78VsKCv38j+j8Dyn9aMPRfH70g==
X-Google-Smtp-Source: AGHT+IHjiEl5cFBFMTdJynjdaHZKd9Sl55LGEXneAEiQSd0nHL+TV7xAEgdi2bBfR1bHPpAtLBlgmA==
X-Received: by 2002:a17:907:78d6:b0:9a1:cbe5:7586 with SMTP id
 kv22-20020a17090778d600b009a1cbe57586mr2223836ejc.35.1692802567427; 
 Wed, 23 Aug 2023 07:56:07 -0700 (PDT)
Received: from m1x-phil.lan (gsv95-h03-176-172-10-165.dsl.sta.abo.bbox.fr.
 [176.172.10.165]) by smtp.gmail.com with ESMTPSA id
 v15-20020a170906564f00b0099cbe71f3b5sm9808715ejr.0.2023.08.23.07.56.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Aug 2023 07:56:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/8] tcg/tcg-op: Document bswap32_i64() byte pattern
Date: Wed, 23 Aug 2023 16:55:38 +0200
Message-ID: <20230823145542.79633-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823145542.79633-1-philmd@linaro.org>
References: <20230823145542.79633-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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
 tcg/tcg-op.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index fc9b21d30c..e6e62c4278 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1796,6 +1796,13 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
     }
 }
 
+/*
+ * bswap32_i64: 32-bit byte swap on the low bits of a 64-bit value.
+ *
+ *                                                          flags
+ * Byte pattern:  bswap32_i64(xxxxabcd) -> ssssdcba     (TCG_BSWAP_OS)
+ *                bswap32_i64(xxxxabcd) -> ....dcba
+ */
 void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
 {
     /* Only one extension flag may be present. */
@@ -1815,8 +1822,10 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
         TCGv_i64 t2 = tcg_constant_i64(0x00ff00ff);
 
-                                            /* arg = xxxxabcd */
-        tcg_gen_shri_i64(t0, arg, 8);       /*  t0 = .xxxxabc */
+                                            /* arg = xxxxabcd (IZ=0) */
+                                            /*       ....abcd (IZ=1) */
+        tcg_gen_shri_i64(t0, arg, 8);       /*  t0 = .xxxxabc (IZ=0) */
+                                            /*       .....abc (IZ=1) */
         tcg_gen_and_i64(t1, arg, t2);       /*  t1 = .....b.d */
         tcg_gen_and_i64(t0, t0, t2);        /*  t0 = .....a.c */
         tcg_gen_shli_i64(t1, t1, 8);        /*  t1 = ....b.d. */
@@ -1825,11 +1834,12 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
         tcg_gen_shli_i64(t1, ret, 48);      /*  t1 = dc...... */
         tcg_gen_shri_i64(t0, ret, 16);      /*  t0 = ......ba */
         if (flags & TCG_BSWAP_OS) {
-            tcg_gen_sari_i64(t1, t1, 32);   /*  t1 = ssssdc.. */
+            tcg_gen_sari_i64(t1, t1, 32);   /*  t1 = ssssdc.. (OS=1) */
         } else {
-            tcg_gen_shri_i64(t1, t1, 32);   /*  t1 = ....dc.. */
+            tcg_gen_shri_i64(t1, t1, 32);   /*  t1 = ....dc.. (OS=0) */
         }
-        tcg_gen_or_i64(ret, t0, t1);        /* ret = ssssdcba */
+        tcg_gen_or_i64(ret, t0, t1);        /* ret = ssssdcba (OS=1) */
+                                            /*       ....dcba (OS=0) */
 
         tcg_temp_free_i64(t0);
         tcg_temp_free_i64(t1);
-- 
2.41.0



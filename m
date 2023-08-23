Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0408785B3C
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:57:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYpHK-0006oE-8b; Wed, 23 Aug 2023 10:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpH0-0006lH-7J
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:55:54 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qYpGy-0007Vc-Ni
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:55:53 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-525bd0b2b48so7358794a12.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692802551; x=1693407351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fa17cJ4to23Vkyj/pItGbFPaud9AZDIssGKp3/2djs=;
 b=FDUirXKB2YDaamuXR3GE8d8OsGozU7lp1DZPjr9N4IWWs5i5DUPQ5yt/9k01iRk35X
 HpYF8KnKqbYuSes7dDSEgLtOfA8VRCUb7MPT66B5gYgVOxyrlW4UOCZfI8+Lhm/9eRVB
 ZQ1ahkvOh5axcXkpCe3slvsUxO0ycGUqX8V30UeWYC/hIiCTva6I0BGYpiMdqFEdD8Hu
 yZC4D7PZAmCxCgMlpUOKBfvUTpBCzR4i9VmehfNp1DnJIxY11MYj7ehQV+dL6iovj2Kk
 mVgoegGr0kY4HNPQh2CbFsqouEsVn/lXwSe7r5dkMukDHZBWpxhsdqPDkMn9Ea9cwQ13
 1q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692802551; x=1693407351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fa17cJ4to23Vkyj/pItGbFPaud9AZDIssGKp3/2djs=;
 b=JIGvm90o+hInpbT9/iDRlK0+AFTMD7fDVEvIz4PQs+77+g0AwNcTS2yRB+ODKhXd4g
 dwJD6H4t1l/RjSGJSSLVdiKrZMdBJO+4ikSSMDjoxzL/YGLMpbG1RWG7tjed/cPwea2k
 x8nxTN9uREDNO05ZgT4KKUBuJTeItwE6LQlLsYj4lPfUlYwKn4anLyzHhaUZoZKeHEhp
 auKIwKiU7hM9fyDHAU9o9Jx6ah9yBbSucp/iAcyKYZjcBqmxWjmFSlfg6Tf37m4GTZjE
 2trQj/GUx9VbceHXO6Nyq5Nu5ILXt7AACwY3hnRwGqsuU/NJQktihfHVdKZwrtjhv+mi
 IoOg==
X-Gm-Message-State: AOJu0Yz5qEdHz2+ffNh5bgRKdCVMtJrmJc9DvhSl4ak/0Z05qKBNEGSd
 4ybwawIwLAR5aK4dHx7f162jYeC949+gN1meP0N0Vg==
X-Google-Smtp-Source: AGHT+IEj0q9KTw3727ve+8hX6YuaKO2XRo0HAZ09tWZpKLdBWF3vNNh2J+sFSg0K073YI8VUsVxNqQ==
X-Received: by 2002:aa7:c1d3:0:b0:523:d1e0:7079 with SMTP id
 d19-20020aa7c1d3000000b00523d1e07079mr9077876edp.21.1692802550807; 
 Wed, 23 Aug 2023 07:55:50 -0700 (PDT)
Received: from m1x-phil.lan (gsv95-h03-176-172-10-165.dsl.sta.abo.bbox.fr.
 [176.172.10.165]) by smtp.gmail.com with ESMTPSA id
 e25-20020a50ec99000000b0052a404e5929sm5669edr.66.2023.08.23.07.55.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 23 Aug 2023 07:55:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/8] tcg/tcg-op: Document bswap16_i32() byte pattern
Date: Wed, 23 Aug 2023 16:55:35 +0200
Message-ID: <20230823145542.79633-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823145542.79633-1-philmd@linaro.org>
References: <20230823145542.79633-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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
 tcg/tcg-op.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7aadb37756..c1b9a3e34c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1021,6 +1021,15 @@ void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
+/*
+ * bswap16_i32: 16-bit byte swap on the low bits of a 32-bit value.
+ *
+ *                                                           flags
+ * Byte pattern:  bswap16_i32(..ab) -> .aba             (TCG_BSWAP_IZ)
+ *                bswap16_i32(xxab) -> ..ba             (TCG_BSWAP_OZ)
+ *                bswap16_i32(xxab) -> ssba             (TCG_BSWAP_OS)
+ *                bswap16_i32(xxab) -> xaba
+ */
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
 {
     /* Only one extension flag may be present. */
@@ -1032,22 +1041,29 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 t1 = tcg_temp_ebb_new_i32();
 
-        tcg_gen_shri_i32(t0, arg, 8);
+                                            /* arg = xxab (IZ=0)    */
+                                            /*     = ..ab (IZ=1)    */
+        tcg_gen_shri_i32(t0, arg, 8);       /*  t0 = .xxa (IZ=0)    */
+                                            /*     = ...a (IZ=1)    */
         if (!(flags & TCG_BSWAP_IZ)) {
-            tcg_gen_ext8u_i32(t0, t0);
+            tcg_gen_ext8u_i32(t0, t0);      /*  t0 = ...a (IZ=0)    */
         }
 
         if (flags & TCG_BSWAP_OS) {
-            tcg_gen_shli_i32(t1, arg, 24);
-            tcg_gen_sari_i32(t1, t1, 16);
+            tcg_gen_shli_i32(t1, arg, 24);  /*  t1 = b... (OS=1)    */
+            tcg_gen_sari_i32(t1, t1, 16);   /*  t1 = ssb. (OS=1)    */
         } else if (flags & TCG_BSWAP_OZ) {
-            tcg_gen_ext8u_i32(t1, arg);
-            tcg_gen_shli_i32(t1, t1, 8);
+            tcg_gen_ext8u_i32(t1, arg);     /*  t1 = ...b (OZ=1)    */
+            tcg_gen_shli_i32(t1, t1, 8);    /*  t1 = ..b. (OZ=1)    */
         } else {
-            tcg_gen_shli_i32(t1, arg, 8);
+            tcg_gen_shli_i32(t1, arg, 8);   /*  t1 = xab. (IZ=0)    */
+                                            /*     = .ab. (IZ=1)    */
         }
 
-        tcg_gen_or_i32(ret, t0, t1);
+        tcg_gen_or_i32(ret, t0, t1);        /* ret = ..ba (OZ=1)    */
+                                            /*     = ssba (OS=1)    */
+                                            /*     = .aba (IZ=1)    */
+                                            /*     = xaba (no flag) */
         tcg_temp_free_i32(t0);
         tcg_temp_free_i32(t1);
     }
-- 
2.41.0



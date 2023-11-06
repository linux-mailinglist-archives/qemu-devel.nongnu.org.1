Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD4D7E2EEF
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 22:28:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0789-0004FY-BP; Mon, 06 Nov 2023 16:27:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0786-0004FF-4r
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:27:30 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0781-00088j-Ft
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 16:27:29 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32faea0fa1fso2743749f8f.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 13:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699306043; x=1699910843; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LqtRJGWLJIXA8iSk+upKZYw0PhRCoJdU2LRB4jL9wCI=;
 b=AycQ4Lw+D+ZUiPV4/2zhyPs+h80vZxsILf2HgyF0T+h00UH77mo2x9+zI6TqG7fpHt
 eyoFh62jJi51BExIyP7a1lifytmL3We3e3JxtqhwDZI9VEOd4dCitJP8ciODRABR6lK4
 R2R1Pnw5exLNP77zZQgvYhaz85qMt7QWE6smjk9aD8Vjw6+OE3r0m14R4lU5dC3TFl2+
 OQgJc45FJwmJa4ttK9F3wwc+m6lz/uc2i+STgvqAAqh/PGf/6heRIV5U0x340cwCHYMs
 0bMiA4fmqF7Gr5T21zfcPg3mTke2tm0NbFlMXnsmwQmzjAhkR3gxAl4kIlAoud3y7VpQ
 MHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699306043; x=1699910843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LqtRJGWLJIXA8iSk+upKZYw0PhRCoJdU2LRB4jL9wCI=;
 b=l0j9duqVE7bwCLnYd/gRe+fb6M8uvrLkaOcW78HE1cRmaISPM7wdqnBfjw4l6+1qg3
 AKbAu516qUSdxyxuq0h7qf3DTEKEF8qBy6L4eq79jv5a8pANdqHqJQ3eHPkBhMOO+nri
 SkngJpPh96a3FWVpBnhkPuZ6qCbnWdIaIaqd0S5NzpWfuMQj36UnHrDuEUrVnr+98cG/
 1DBh3TGYdOQ8zuPsrsIlnJFJZB533GG9H5n0hV8I30OFSmua2YcEfOWw2MSA0JDSj3tm
 7QAESx6QvoKMIZxKD1slitUKGfne56mcNddrFLL1L9O3ja7QYSu8qhTjLUUrbO2LOlKW
 j7eQ==
X-Gm-Message-State: AOJu0Yz1Yn//Oks0gLia5JN1yh3ofK/n1be2O8fHiYprca0re6vlIBIO
 ruVunoQUXcxnIosRKQMWM0OkXZ12a5XpKKvOOtI=
X-Google-Smtp-Source: AGHT+IF5RGhOgdLQwa70TDsUkJH3PbWhFiYsMAmaegVnPaq/DR4iR43fvevmbBNck8mF65qz5hKwZg==
X-Received: by 2002:a5d:648e:0:b0:32f:8853:78df with SMTP id
 o14-20020a5d648e000000b0032f885378dfmr902942wri.11.1699306043131; 
 Mon, 06 Nov 2023 13:27:23 -0800 (PST)
Received: from [192.168.69.115] ([176.172.125.26])
 by smtp.gmail.com with ESMTPSA id
 bg13-20020a05600c3c8d00b0040644e699a0sm13500581wmb.45.2023.11.06.13.27.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 13:27:22 -0800 (PST)
Message-ID: <d0abd65b-e63a-4b9b-8ba7-2f642ed01804@linaro.org>
Date: Mon, 6 Nov 2023 22:27:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/35] tcg/optimize: Do swap_commutative2 in
 do_constant_folding_cond2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231028194522.245170-1-richard.henderson@linaro.org>
 <20231028194522.245170-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231028194522.245170-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 28/10/23 21:44, Richard Henderson wrote:
> Mirror the new do_constant_folding_cond1 by doing all
> argument and condition adjustment within one helper.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 107 ++++++++++++++++++++++++++-----------------------
>   1 file changed, 57 insertions(+), 50 deletions(-)

Easier to review with a preliminary code move patch:

-- >8 --
diff --git a/tcg/optimize.c b/tcg/optimize.c
index 89cc794d24..ae8debf6f2 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -589,43 +589,6 @@ static int do_constant_folding_cond(TCGType type, 
TCGArg x,
      return -1;
  }

-/*
- * Return -1 if the condition can't be simplified,
- * and the result of the condition (0 or 1) if it can.
- */
-static int do_constant_folding_cond2(TCGArg *p1, TCGArg *p2, TCGCond c)
-{
-    TCGArg al = p1[0], ah = p1[1];
-    TCGArg bl = p2[0], bh = p2[1];
-
-    if (arg_is_const(bl) && arg_is_const(bh)) {
-        tcg_target_ulong blv = arg_info(bl)->val;
-        tcg_target_ulong bhv = arg_info(bh)->val;
-        uint64_t b = deposit64(blv, 32, 32, bhv);
-
-        if (arg_is_const(al) && arg_is_const(ah)) {
-            tcg_target_ulong alv = arg_info(al)->val;
-            tcg_target_ulong ahv = arg_info(ah)->val;
-            uint64_t a = deposit64(alv, 32, 32, ahv);
-            return do_constant_folding_cond_64(a, b, c);
-        }
-        if (b == 0) {
-            switch (c) {
-            case TCG_COND_LTU:
-                return 0;
-            case TCG_COND_GEU:
-                return 1;
-            default:
-                break;
-            }
-        }
-    }
-    if (args_are_copies(al, bl) && args_are_copies(ah, bh)) {
-        return do_constant_folding_cond_eq(c);
-    }
-    return -1;
-}
-
  /**
   * swap_commutative:
   * @dest: TCGArg of the destination argument, or NO_DEST.
@@ -672,6 +635,10 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
      return false;
  }

+/*
+ * Return -1 if the condition can't be simplified,
+ * and the result of the condition (0 or 1) if it can.
+ */
  static int do_constant_folding_cond1(OptContext *ctx, TCGArg dest,
                                       TCGArg *p1, TCGArg *p2, TCGArg 
*pcond)
  {
@@ -689,6 +656,39 @@ static int do_constant_folding_cond1(OptContext 
*ctx, TCGArg dest,
      return r;
  }

+static int do_constant_folding_cond2(TCGArg *p1, TCGArg *p2, TCGCond c)
+{
+    TCGArg al = p1[0], ah = p1[1];
+    TCGArg bl = p2[0], bh = p2[1];
+
+    if (arg_is_const(bl) && arg_is_const(bh)) {
+        tcg_target_ulong blv = arg_info(bl)->val;
+        tcg_target_ulong bhv = arg_info(bh)->val;
+        uint64_t b = deposit64(blv, 32, 32, bhv);
+
+        if (arg_is_const(al) && arg_is_const(ah)) {
+            tcg_target_ulong alv = arg_info(al)->val;
+            tcg_target_ulong ahv = arg_info(ah)->val;
+            uint64_t a = deposit64(alv, 32, 32, ahv);
+            return do_constant_folding_cond_64(a, b, c);
+        }
+        if (b == 0) {
+            switch (c) {
+            case TCG_COND_LTU:
+                return 0;
+            case TCG_COND_GEU:
+                return 1;
+            default:
+                break;
+            }
+        }
+    }
+    if (args_are_copies(al, bl) && args_are_copies(ah, bh)) {
+        return do_constant_folding_cond_eq(c);
+    }
+    return -1;
+}
+
  static void init_arguments(OptContext *ctx, TCGOp *op, int nb_args)
  {
      for (int i = 0; i < nb_args; i++) {
---

To the best of my knowledge:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



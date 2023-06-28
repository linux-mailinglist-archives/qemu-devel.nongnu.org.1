Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6007409D5
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 09:51:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEPx7-0001tL-HT; Wed, 28 Jun 2023 03:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEPx4-0001t7-Mq
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:50:58 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEPx2-0005yD-Q7
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 03:50:58 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-313e1c27476so563095f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 00:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687938655; x=1690530655;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SBo2xxkUdD8Pj6SFb9Isg5B2YQ+qE2vIzt3F+l8yteE=;
 b=dOqx5kYP8iPEs0hsbYYGGeX5rIUHj7GgD7gSh6NjhB6CpIsZcHOwRzzZH9ytH+7aYH
 QRsAPrXPRH50skYYPY+HyUvqZ40PQuLBQlXIjKWj+3mMEvIE8MK5BCz5NAZDvgzD8hIa
 p523tWbiN0aDGWxTxM37OOJVQpCzl6YFDTodkJ4Kqtm8z3xffDI9mJot718KRTkl/yDs
 F6FmgU+a95ARsTDYs6oP6800kMl+VFVRmqhligYXvMq5jQL2Q/jYdOJVeEobviacXYPZ
 Ir1W4cLMRHCMiQCStMO5WGnHyVO0ac0tn6KsLsFMw+0zK8qqn5X3IZ7peZNjldJG272t
 yRRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687938655; x=1690530655;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SBo2xxkUdD8Pj6SFb9Isg5B2YQ+qE2vIzt3F+l8yteE=;
 b=adxRijhlBrYuHzNiG0U1PyPVVGgWwygyYwKE49xseL3EI1RLh1YzHP0SREwFfe11fx
 EnIKlcsZ4j+sHR6oRCYGVHZUEFMjDmFZ9DuGMkYF0NiIDNe/Vnx+G8f8IRKvb0MHP/DD
 S/lLzWVmEY1rBg3U5Bg0Qn6NpfzCyOQsj1Rck3gR7OZzLhdJi0HpwrRNHot1U3c4ZDzG
 UmDwik12Wz+HbVJ8O2Rq+AlQS6x+ZbooiOzt+gK3Ai6xSTUzQ851GylS+E04v5RFGd8s
 wGx1b1DBjwI72FPGwzDu4/xaLDHr5vSZaPH219G6peGn8tnfYHz2zMrSi3JGX8JL/14p
 RB5w==
X-Gm-Message-State: AC+VfDz3nvcuCGx8dY5cIQCLzPWDeZU/RFdvO+K3lyhmrFjlfkUgeBQz
 2ifWU5rBlr8v0UJf7MDkATRovIhb+c1c0b/UNCM=
X-Google-Smtp-Source: ACHHUZ6MFbaBDvNFs4lh6yL5AWs8RnK4kr68Fp1slrpQQal8iANrII/JIaZt/n/V8UmOkQfM3PqB8g==
X-Received: by 2002:adf:ea89:0:b0:311:f11:4c65 with SMTP id
 s9-20020adfea89000000b003110f114c65mr803646wrm.4.1687938654872; 
 Wed, 28 Jun 2023 00:50:54 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.207.229])
 by smtp.gmail.com with ESMTPSA id
 a16-20020adfdd10000000b00313ef2150dcsm8872245wrm.45.2023.06.28.00.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 00:50:54 -0700 (PDT)
Message-ID: <14655a48-fcaf-0666-2996-4c812251c44a@linaro.org>
Date: Wed, 28 Jun 2023 09:50:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 0/8] target/sparc: Use tcg_gen_lookup_and_goto_ptr
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20230628071202.230991-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230628071202.230991-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.103,
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

On 28/6/23 09:11, Richard Henderson wrote:
> Changes from v2:
>    * Patch 4 relaxes the checking on NPC:
>      (1) save_npc has just asserted that if the low 2 bits are non-zero,
>          then we have exactly one of our 3 special cases.
>      (2) The difference between DYNAMIC_PC_LOOKUP and DYNAMIC_PC within
>          NPC are not relevant to chaining, only those two values within PC.
>      Therefore simplify the test in sparc_tr_tb_stop.

$ git diff v2..v3
-- >8 --
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index fcc1054943..bd877a5e4a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -5683,14 +5683,6 @@ static void sparc_tr_tb_stop(DisasContextBase 
*dcbase, CPUState *cs)
          save_npc(dc);
-        switch (dc->npc) {
-        case DYNAMIC_PC_LOOKUP:
-            if (may_lookup) {
-                tcg_gen_lookup_and_goto_ptr();
-                break;
-            }
-            /* fall through */
-        case DYNAMIC_PC:
+        if (may_lookup) {
+            tcg_gen_lookup_and_goto_ptr();
+        } else {
              tcg_gen_exit_tb(NULL, 0);
-            break;
-        default:
-            g_assert_not_reached();
          }
---

OK, this makes sense.


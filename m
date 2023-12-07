Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04EAB809581
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 23:40:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBN1R-0006B6-4D; Thu, 07 Dec 2023 17:39:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBN1E-0006AN-Nh
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 17:38:56 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rBN18-0007NQ-Cr
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 17:38:55 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2865742e256so1280562a91.0
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 14:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701988729; x=1702593529; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gr+rmUiikWbpszRoG45FQQzMyS1juxvRULU7RLfR6uQ=;
 b=EuoBEZb4ZM4mgY1b4uP2Wcdoym+7zXJetIT/OLFUWanuTamhJciGTjKvFTSFl/iDRY
 SoyzC484cXhzXRQbx1stygpoT8erhib8foSQyPdgbCyQXP8T7a67RY2ZuWduuM6hOLr+
 qemm8qZKQXGeLc9KKVZtdeCrB/t8eVew1uf05i3LxroXw9Tef/qmKFEy+tgfA3nvvpRk
 QtEhKQQFBdFGz2KT8PKJzA+77u+aqmKvgwkMfPTERpMWYVkJp2dUbsa1hUVqwjS8jGAY
 CE/wGir0hvzEa7Ry3vPUPX/1rBUtDF5sLCgNF5F82imI9lVtesm5jg+p1KE6FUKMN+IY
 AyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701988729; x=1702593529;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gr+rmUiikWbpszRoG45FQQzMyS1juxvRULU7RLfR6uQ=;
 b=j5O065PAwwY4UXYNhthx7mPB4oEgyfWoQPCgZzO1cH8bMdxm5GCNFv3/ngRLAu4RN5
 n29BpA/Q7lE3snGIwyYJkW3Ft4yDEnjNY9/95dsrkZ2n0kXvkFuziNBW1C8Qr2baPrTF
 l6N3JEuDpApWcg9nWNSylloh/3K5A96mKACEG134nfEZakuO/8qh0C36p5/iyF86t4He
 RimKGPS3j55kbNl6lAMk8e1r7TfiKJCNZcATjxtIU1kkT4F2/8TsCZmrwe75cjn33Ab+
 EdYzqY1pD9B5FBhWwKccM+0ul8GwqWMAzOtpM/Lle3/B/XuO7PFio93+DuafcvkbtS7h
 7amw==
X-Gm-Message-State: AOJu0Yxn2hz79w+kQ5Vb13Rxxn8ZugqSKXZED2V/qbsFmHkYccF+SAvA
 qhC9WXo9fzD9VaWP4NpCw4YyBw==
X-Google-Smtp-Source: AGHT+IHdEIzCSNScWZ8FrouGVyUZiEPbtdLcXZkU/Y3qQnGYAIByrElrtjZq7zX698a7IDARwOLAJw==
X-Received: by 2002:a17:90a:1988:b0:286:6cc0:885c with SMTP id
 8-20020a17090a198800b002866cc0885cmr2614624pji.73.1701988728711; 
 Thu, 07 Dec 2023 14:38:48 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 5-20020a17090a018500b0028658657e9csm462824pjc.46.2023.12.07.14.38.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Dec 2023 14:38:48 -0800 (PST)
Message-ID: <83f260a3-68e5-4041-9e92-d8250c327cf8@linaro.org>
Date: Thu, 7 Dec 2023 14:38:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] system/vl: Restrict icount to TCG emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Fam Zheng <fam@euphon.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20231207154550.65087-1-philmd@linaro.org>
 <20231207154550.65087-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231207154550.65087-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 12/7/23 07:45, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   stubs/icount.c | 6 ------
>   system/vl.c    | 6 +++++-
>   2 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/stubs/icount.c b/stubs/icount.c
> index a5202e2dd9..b060b03a73 100644
> --- a/stubs/icount.c
> +++ b/stubs/icount.c
> @@ -1,5 +1,4 @@
>   #include "qemu/osdep.h"
> -#include "qapi/error.h"
>   #include "sysemu/cpu-timers.h"
>   
>   /* icount - Instruction Counter API */
> @@ -10,11 +9,6 @@ void icount_update(CPUState *cpu)
>   {
>       abort();
>   }
> -void icount_configure(QemuOpts *opts, Error **errp)
> -{
> -    /* signal error */
> -    error_setg(errp, "cannot configure icount, TCG support not available");
> -}
>   int64_t icount_get_raw(void)
>   {
>       abort();
> diff --git a/system/vl.c b/system/vl.c
> index 2bcd9efb9a..8c99c5f681 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2270,7 +2270,11 @@ static void user_register_global_props(void)
>   
>   static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
>   {
> -    icount_configure(opts, errp);
> +    if (tcg_enabled()) {
> +        icount_configure(opts, errp);
> +    } else {
> +        error_setg(errp, "cannot configure icount, TCG support not available");
> +    }
>       return 0;
>   }

This is called before the accelerator is chosen -- even before the set of available 
accelerators is even found.  Indeed, that's the very next thing that 
configure_accelerators does.

OTOH, I don't see why icount_configure is being called so early.


r~

>   



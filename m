Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C78E720C39
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 01:16:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5DzG-00084r-32; Fri, 02 Jun 2023 19:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5DzC-00084J-7T
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 19:15:10 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q5DzA-0005jq-K5
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 19:15:09 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-30ad8f33f1aso2654986f8f.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 16:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685747704; x=1688339704;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nB8qV+7FUc+KZ0+7+sfoiPJaLsm9XkB9JMk4K7CTx6Y=;
 b=bRW8sZLVBS+f4chzzy7KIJgAWLomfMt9aT6Lt90hpLy5LyElswTIsCOy8xhPsWbQaZ
 WAcCyHFMfyECVodQ+Rnl8wferxpU1ODmw258ri+hLas674A+EtLY4KuvGjNW19sxOLdA
 JNJsqXdyiHodumyOnELEMZDpxQKdUFoPccNghGsVsOs8GJyGlwH/dEQUy4oRpCp3h6je
 NAgJw88ehZT7Tcek80Y0z0DDcHXVBiPSh6hXtbaxf+P7heKyaA+PyOHeXFjY4KFqGmpF
 c9WYF2t/id5walpAc+2D66i7wXP8Cxw7aNTLfFnWKPc/tSOBKvkx9mmw7w1SsKBeMKY2
 lXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685747704; x=1688339704;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nB8qV+7FUc+KZ0+7+sfoiPJaLsm9XkB9JMk4K7CTx6Y=;
 b=BkKhKZA+QW8u/BImGD509xYjOjnAGHhYTIbNDN9acogCijun6ix9SGdM02a9l7IlP7
 hKcfkrIcoEQHiRbC5+dJBBCR2OV1qYwl0WrkQxfiH57kTVBAMNqFetQ2oJ/1vgHCtbxK
 8etpNICtzM7DneobXz/DN4z6nQawZo2ihzbLRqpi45eM7pWjKjgGhXqj4l/Xz7loLPpD
 O4qU8Lr+f6MlQlX1tTm/AoAWyCgy8SGCI1O9vdP5qTwD3B2ekAZiqU1vCPoFGClDc3mi
 8RQnnSF0bL8tVs7Xu0qAvO2scKExq1y3xi947N2UbhfrkbsnDYssmSRhy3g8h6gbAZ0c
 /WZA==
X-Gm-Message-State: AC+VfDz+XVEmyM8sQG+pHW6160MHSzpj0x2oUXTG5JfbXmdxJLRjuCJT
 EvHkj5so8TK1wW9QH344k4eOT743Udk0jl6MOm4=
X-Google-Smtp-Source: ACHHUZ70i1uaw/WqDYADkKOzVl4G58JuNXidMeXEUZ1FE49cW5nrFemXliGM6ZRYMtCDyndzlRvHYQ==
X-Received: by 2002:a05:6000:1208:b0:309:5068:9ebe with SMTP id
 e8-20020a056000120800b0030950689ebemr919347wrx.50.1685747704426; 
 Fri, 02 Jun 2023 16:15:04 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.218.254])
 by smtp.gmail.com with ESMTPSA id
 c4-20020a5d4144000000b0030ade1b9400sm2827678wrq.30.2023.06.02.16.15.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 16:15:04 -0700 (PDT)
Message-ID: <aa5de6ad-b020-0eb4-85a6-017424a7a4fd@linaro.org>
Date: Sat, 3 Jun 2023 01:15:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v3 47/48] exec/poison: Do not poison CONFIG_SOFTMMU
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230531040330.8950-1-richard.henderson@linaro.org>
 <20230531040330.8950-48-richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230531040330.8950-48-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
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

On 31/5/23 06:03, Richard Henderson wrote:
> If CONFIG_USER_ONLY is ok generically, so is CONFIG_SOFTMMU,
> because they are exactly opposite.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/poison.h         | 1 -
>   scripts/make-config-poison.sh | 5 +++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/exec/poison.h b/include/exec/poison.h
> index 256736e11a..e94ee8dfef 100644
> --- a/include/exec/poison.h
> +++ b/include/exec/poison.h
> @@ -85,7 +85,6 @@
>   #pragma GCC poison CONFIG_HVF
>   #pragma GCC poison CONFIG_LINUX_USER
>   #pragma GCC poison CONFIG_KVM
> -#pragma GCC poison CONFIG_SOFTMMU
>   #pragma GCC poison CONFIG_WHPX
>   #pragma GCC poison CONFIG_XEN
>   
> diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
> index 1892854261..2b36907e23 100755
> --- a/scripts/make-config-poison.sh
> +++ b/scripts/make-config-poison.sh
> @@ -4,11 +4,12 @@ if test $# = 0; then
>     exit 0
>   fi
>   
> -# Create list of config switches that should be poisoned in common code...
> -# but filter out CONFIG_TCG and CONFIG_USER_ONLY which are special.
> +# Create list of config switches that should be poisoned in common code,
> +# but filter out several which are handled manually.
>   exec sed -n \
>     -e' /CONFIG_TCG/d' \
>     -e '/CONFIG_USER_ONLY/d' \
> +  -e '/CONFIG_SOFTMMU/d' \
>     -e '/^#define / {' \
>     -e    's///' \
>     -e    's/ .*//' \

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C7772FF1A
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 14:52:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Pxv-0007Hd-AS; Wed, 14 Jun 2023 08:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q9Pxg-00072q-IE
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:50:58 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q9Pxd-0005FG-Fm
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:50:54 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-977c89c47bdso111672966b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 05:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686747051; x=1689339051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WTQ4+XrrgT/Son3X70uGLDpyWXK6q5H7kXhp8853/cw=;
 b=yV2A9K4fraQ0EVx5Fw/W4ckN1VPa58fuCe9NR9SDhjnjZdBxbyf34XXzGbprH55G1q
 uMehKE6G5AQfu7I9Fxqks0NpqPE0XNyVSEX9fZ4/RXh/6Ik4cAyEpjjgLkaP5zOlcLcK
 /oCIP+fNs3aq2od7PDKIQ0OU1KFTfMJay2CYWxumqUhGGVi/tdMPWx7hCMwJ+IqK0iAk
 nqSsnt2tiqaCMMCYwdqdB5GHrzPOzfozgQUvTgnZL9o/SMgg06Oy0zv2T4sOh+gzGSbF
 mNXqH2jofIBmz7siiS0p2xr7zOvVb5Xt+YMC1kVdne1UGTgENubmAtBrPOo1iYdeio0Q
 rrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686747051; x=1689339051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WTQ4+XrrgT/Son3X70uGLDpyWXK6q5H7kXhp8853/cw=;
 b=EMdH80BsflJ4Z4PdA50aFdIIBV1TO/ocaafTknG3Trt1ZD0reeNzzTXs4C0FjVtnUB
 ibVFOsnXNB+0DS4a5xWEtoKWAxtmbOVr40YGaYXhjoy0BJJWYcISeS9jQhcgrjws4e55
 4egLjmQyBQLsjEG35wPybu5Cqfqgyh9qZBXaQg2uGB6JGOBbKgp59bWT7izQ6WZuPvgs
 U7ttishWvA76gBGBUBMo5dXMfQNxqaEB5t5e5p180TLh2Xsq5DWZY9P2HCrA/RVMvfbk
 Cc373dov5AgAjm8P6dcMIFLfY04ZW+SRRzRDZ3Fiv9vqIPiGCjRPOJxsv/awTOeYgJdN
 NQ0A==
X-Gm-Message-State: AC+VfDzfMsvkkJ3alC/rOEzIRqbO2pQt3PCldFGTFlPbUo+zXplNdX6n
 VIvLFs/pBI6Tb4uZ63KykSjQwQ==
X-Google-Smtp-Source: ACHHUZ4fpn9+0maSBD+fzmu8g3DegL5Kudl3Q6dM4wd/K/bbn4L7ZDSSNX9wBNlQPAZvI6z+HYY9jw==
X-Received: by 2002:a17:906:730b:b0:973:bcf6:1d4 with SMTP id
 di11-20020a170906730b00b00973bcf601d4mr18599294ejc.76.1686747051664; 
 Wed, 14 Jun 2023 05:50:51 -0700 (PDT)
Received: from [10.14.201.118] ([213.175.39.66])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a1709061c9200b00965a4350411sm675112ejh.9.2023.06.14.05.50.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 05:50:51 -0700 (PDT)
Message-ID: <b17b304a-3613-41aa-dbb5-7ce6a1902d76@linaro.org>
Date: Wed, 14 Jun 2023 14:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 23/26] target/arm/tcg: Inline 'exec/helper-gen.h'
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230611085846.21415-1-philmd@linaro.org>
 <20230611085846.21415-24-philmd@linaro.org>
 <82a922ac-2c1f-97c1-2949-565add323688@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <82a922ac-2c1f-97c1-2949-565add323688@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 14/6/23 07:01, Richard Henderson wrote:
> On 6/11/23 10:58, Philippe Mathieu-Daudé wrote:
>> +++ b/target/arm/helper.c
>> @@ -26,6 +26,11 @@
>>   #include "qapi/error.h"
>>   #include "qemu/guest-random.h"
>>   #ifdef CONFIG_TCG
>> +
>> +#define HELPER_H "helper.h"
>> +#include "exec/helper-gen.h.inc"
>> +#undef  HELPER_H
> 
> 
> Why is this here?  helper-gen is for tcg code generation, which should 
> not be required at all in this file.  I can't see how the modification 
> to translate.h affects this.

Indeed this is not needed.



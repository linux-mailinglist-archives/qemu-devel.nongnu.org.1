Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA86B7487F4
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 17:26:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH4Ob-00030J-4D; Wed, 05 Jul 2023 11:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4OY-0002zD-Nw
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:26:18 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qH4OW-0004UC-C0
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 11:26:18 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b69f958ef3so111597951fa.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 08:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688570765; x=1691162765;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O7QpgPaXGW/gcj6LdAaCEGOaGvyQ/Wsz18252+a4ayQ=;
 b=q+CeII5+HITm489gbXY1UUZ3dAL3VyoXzmF6CWHbBsr2IxC6DmWC9fuiT6qkuDYIHJ
 K8om8pL1yctnzOtpV7S7W5nCX+aDna9GFLHdQ8LJopPeKckdpOgBZEb2D4gY4n5eLCJH
 tiGOvZ6AHfW8KsNaJKjAzfOt9XFaRn3GCVRTm6KTtVZWk70MvxXkCDMYCe0h0z+aTDAI
 Ihzq+hxS44NxhrAh90Bslj/y/p4cBwwn9L3xGyRt6SQttwXX1kk1Nss/kmnnZxL4dIC0
 hQK8026nNU5dKCjWsaTLoHv5U3HnF5dFWQ4qCUn1OaH0Rchx0IigStklgfErX4BbS1sf
 h5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688570765; x=1691162765;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O7QpgPaXGW/gcj6LdAaCEGOaGvyQ/Wsz18252+a4ayQ=;
 b=X+3dljxYI3GlfxWPWxryi7zGuHpuIT9foGFxNmCKfo2WowR9y7TxvBbKa17ybN55KK
 iEO3RuSmYkOyozbX/NPy+Bby+QZ/n8ZPG+kEY/84pcDa/EGPzXO3L1mU1NpFdhYf6hq9
 Ju8din9HkxS9kQOpr+fp7aTOOElhNaoOWj+rEgs8LE3pxy95teOIicDoqAF5yJYfDBHO
 Z90B9SnA6FVC8dul35WO3w3ST3gwqgljJ0m6w3WHPMUgiDaTtIXlb8Ygq809Fr1f4o4a
 ZyeAqRu3uGQyi7r7MmbwC1f4wCJ4cImmulsubcyO1eozA0cBLO0s5M9o9bKr7Nk320Eg
 pH9w==
X-Gm-Message-State: ABy/qLZIriDrCeeIZZD5cVAmgw6ZuSH4mdKDDUiqhEKM5H4pUxzv2qq1
 jSslsG99rZvN3fhJNHuPczU4cw==
X-Google-Smtp-Source: APBJJlF1paw0uGLBcTdWxUZop7xwi++7LMTd7eG2szVMCHh0hVCY/QZ+7AxjFbFzWkrUhPkly9q/0Q==
X-Received: by 2002:a05:651c:454:b0:2b6:e618:b593 with SMTP id
 g20-20020a05651c045400b002b6e618b593mr7285173ljg.31.1688570765574; 
 Wed, 05 Jul 2023 08:26:05 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.51])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a05651c021000b002b6e863108esm1953496ljn.9.2023.07.05.08.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 08:26:05 -0700 (PDT)
Message-ID: <65d48d3c-ca95-4969-15dd-3aae14e00e81@linaro.org>
Date: Wed, 5 Jul 2023 17:25:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/19] hw/timer/arm_timer: Declare QOM types using
 DEFINE_TYPES() macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>
References: <20230704145012.49870-1-philmd@linaro.org>
 <20230704145012.49870-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230704145012.49870-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 7/4/23 16:49, Philippe Mathieu-Daudé wrote:
> When multiple QOM types are registered in the same file,
> it is simpler to use the the DEFINE_TYPES() macro. Replace
> the type_init() / type_register_static() combination.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   hw/timer/arm_timer.c | 35 +++++++++++++++--------------------
>   1 file changed, 15 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


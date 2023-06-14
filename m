Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9611072F3C5
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 06:50:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9ISh-0002Tf-8I; Wed, 14 Jun 2023 00:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9ISe-0002T0-Pc
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:50:24 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q9ISb-0004S2-ML
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 00:50:23 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31109cd8d8cso138695f8f.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 21:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686718220; x=1689310220;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AzTM1Js8F/82cdwuej/Gdo8dAYcd2cw5W+a3mId43bI=;
 b=PM8OrOMHtUxsSxgK/1OTAX4KCdIeLmKMAvcPI4DJNbmktjbglrv8eysDBm6s1heYqc
 013MSXyjXIrCR1wzr3cKjdytlwAas+QHMqPMxI1fsCuW3eU+fwk3CVQlZcmvSaVCa4cy
 D8xIyNOpn44yWL1lHXgEzYu4VpiyJSBtoJ4yumRMuuB1xyr+qL4cYyboxM4wwA4WCfJb
 14pTDJAOeD7Q6E+CnmwWUaoDOBn5SRdvtXWpfQgFrF6CLlsi/uhvEIs0CBeA0doqOrcb
 Brm6TucsxKPtmF1FYD1H780VZ74DDzLQqqhvzTPsmGpFk/RS9qlHOzc4z1euvQZTe/zu
 X9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686718220; x=1689310220;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AzTM1Js8F/82cdwuej/Gdo8dAYcd2cw5W+a3mId43bI=;
 b=NTi/E/uy0GsqlcfCX5X8uz0UAsnu5kUZRgVLVgjsXw83bM+1DZlk20TuRvX9fUFGat
 7VNwho2qn12IA2l2N6MeLocl+nk8g3qvj1T/aMH5gPcdava7Bo3BEJj4QCNOkNO4dT0t
 NniGAYvN4+7BaJdlOISKvP0k+78lD+soGHqgIO5OYSbyUPwNPmJHT1brrJCdvub0PCck
 lbCvXjYpgp6kqEJL4qtn76dIxFFQv5d/CyRN5G8UyDHR3AOfzDcaTSe6rzzBGuNPwW66
 LXqR+XZCzc5s/Pv6wbcxPeWuSMHiTlapesPRdm3y1I+H3e5CD/Spt5fPxoH6yKOEDk8t
 zyFQ==
X-Gm-Message-State: AC+VfDxRqmyNnUY/Pdi3oK5xua+UYfuYS9J17uKLE0D3J6rVBphs53R/
 KLcQxhHcMz2Pyc8H7Aa94MOISYOkDmiZBVC6BfFTiO50
X-Google-Smtp-Source: ACHHUZ6Y8kVmPoVsf8Db/z+y3QxugDhD+23wWK9Eu2py1lCjWYzKfmgQoHU5xEmaz/M/k1XO8nYuJA==
X-Received: by 2002:a5d:590b:0:b0:310:4fa3:5b0f with SMTP id
 v11-20020a5d590b000000b003104fa35b0fmr1109622wrd.69.1686718219901; 
 Tue, 13 Jun 2023 21:50:19 -0700 (PDT)
Received: from [192.168.4.112] (90-182-62-66.rcp.o2.cz. [90.182.62.66])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a5d50cb000000b0030fb828511csm10418352wrt.100.2023.06.13.21.50.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 21:50:19 -0700 (PDT)
Message-ID: <1db8e8c8-e348-2692-a022-3814c7d06598@linaro.org>
Date: Wed, 14 Jun 2023 06:50:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 17/26] target/arm/tcg: Reduce 'helper-mve.h.inc'
 inclusion
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20230611085846.21415-1-philmd@linaro.org>
 <20230611085846.21415-18-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230611085846.21415-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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

On 6/11/23 10:58, Philippe Mathieu-Daudé wrote:
> Instead of including helper-mve.h.inc via helper.h which
> is included by all TCG files, restrict it to the few files
> that require it.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/arm/helper.h            | 2 --
>   target/arm/tcg/mve_helper.c    | 5 ++++-
>   target/arm/tcg/translate-mve.c | 6 ++++++
>   target/arm/tcg/translate.c     | 4 ++++
>   4 files changed, 14 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


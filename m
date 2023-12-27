Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5032981F296
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 23:48:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIcgL-0000AH-Mv; Wed, 27 Dec 2023 17:47:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcgJ-00009w-I8
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:47:19 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rIcgH-00085p-9u
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 17:47:18 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6d9a79a1ad4so928292b3a.2
 for <qemu-devel@nongnu.org>; Wed, 27 Dec 2023 14:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703717235; x=1704322035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M3kwXjdHwE4b0VwbllgC01gzA1q3vEdMrg+7BPXSS8Q=;
 b=zZDnK47LPtY0KVMXD0RdBWvs3xRTVYE7v2xdlyG0TxpYLAxzYssMcYcf2DG4spREDb
 oFACksF4cbTWMf1uY0nZLMXFi8nvlOHEdtHCcDwV06zg6nnVa3TbO7o7kCwNB+ftplPm
 TisKVtcKB02AhdBcILXefHuHO/4zJoqKK1IedAVyqxw8iabhR9ASa+aXqKM9rhCqrLvT
 0ueg8uby8H9GDjUIhziYuHQHvpFyxxtE6akYcxv7G0ITIi81HGGQ2sVm0Us4kBndVh+u
 wS+4VI43BcHALc8BjgQdomBrokzjy0xZpASHi853TPwWD/8O7BcX6VSpT8bmz0+ICuGw
 CCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703717235; x=1704322035;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M3kwXjdHwE4b0VwbllgC01gzA1q3vEdMrg+7BPXSS8Q=;
 b=p8wkI2SlfmeAZxJFqRKKcoYVDUex7mOq+6T5+JFWBfytc6JvqzSoL+/AIU4hkte2Wy
 6urkKtkMZ39gtrdl/amc9c8NZGbCQul3TSE69sENj1S8WwPrg5rM3FbravI3SR8rScj9
 WVHBkrWvEtAhXVv6y1MzctstjHfDhn9XvPgp6ASd9ZRVqDahodbBJ5hZ9wABCg5p+XJZ
 DGbh4JSGzwM3qDGiTCnUtgGOlcWu3rTiGdu4VDjoxuZCtAituld/JiDuis0pKC65s3bV
 LK/l+B3lTSVr9F3mFnUqwyNqZtM/OobxdyMLj2/HNfDiYaqEDMDc8vpQrj1hH0AwcIkl
 Tu7A==
X-Gm-Message-State: AOJu0YxzkJr3UESvK+TuwRwHcWGaQ0skVnHcdoPZF/QfzbquJWifjP/M
 wZzp1Cg+MQZJ7bNKZ1MwsaC8hOfigfHzY/S6yFXSDXzNvcTuqg==
X-Google-Smtp-Source: AGHT+IFJynYpgghDkfr3tYd7Ro1ex9Fsb0l4DMgQKGr+SwKRroxP13EUSQ5yRFD6DpuRhN6pqtBYpQ==
X-Received: by 2002:a05:6a20:3517:b0:191:9d84:104c with SMTP id
 d23-20020a056a20351700b001919d84104cmr4164143pze.36.1703717235628; 
 Wed, 27 Dec 2023 14:47:15 -0800 (PST)
Received: from ?IPV6:2001:8003:c020:6900:12c1:9684:874a:fb3a?
 ([2001:8003:c020:6900:12c1:9684:874a:fb3a])
 by smtp.gmail.com with ESMTPSA id
 y1-20020a170902ed4100b001cfcd2fb7b0sm10344027plb.285.2023.12.27.14.47.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Dec 2023 14:47:15 -0800 (PST)
Message-ID: <7e91f6d1-51e3-4530-ae83-54aa028538c1@linaro.org>
Date: Thu, 28 Dec 2023 09:47:10 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/35] target/arm: Trap registers when HCR_EL2.{NV, NV1}
 == {1, 1}
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-17-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231218113305.2511480-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 12/18/23 22:32, Peter Maydell wrote:
> When HCR_EL2.{NV,NV1} is {1,1} we must trap five extra registers to
> EL2: VBAR_EL1, ELR_EL1, SPSR_EL1, SCXTNUM_EL1 and TFSR_EL1.
> Implement these traps.
> 
> This trap does not apply when FEAT_NV2 is implemented and enabled;
> include the check that HCR_EL2.NV2 is 0 here, to save us having
> to come back and add it later.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I have mostly implemented FEAT_NV2 after FEAT_NV, but in
> this particular case it seemed cleaner to include the NV2
> bit check from the start.
> ---
>   target/arm/helper.c | 44 ++++++++++++++++++++++++++++++++++++++++----
>   1 file changed, 40 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> @@ -7807,6 +7820,16 @@ static CPAccessResult access_mte(CPUARMState *env, const ARMCPRegInfo *ri,
>       }
>       return CP_ACCESS_OK;
>   }
> +static CPAccessResult access_tfsr_el1(CPUARMState *env, const ARMCPRegInfo *ri,

Spacing.


r~


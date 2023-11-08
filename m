Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C087E5388
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 11:41:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0fyX-0001Bf-Um; Wed, 08 Nov 2023 05:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fyV-0001BD-Cw
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:39:55 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0fyT-0001Sm-G4
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 05:39:55 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-54394328f65so11296786a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 02:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699439992; x=1700044792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7HzxvFFNmO6K1hTFtt7SUREj348gqTywo0NeLEtHUDE=;
 b=FwQEa7Gxn8jPnj3FzchFkFAL6K8+NVimGIr0upWrWTv3zNdkdqPxyzL7ARFhHn/XzL
 9/CmTMrAPAvffu3uRMp6nSNJLLXgrAgs1BfbjdjzSPDBt7UU+Cwt1IOuOvM9HOPfOCQB
 dEgYk/jhlvg3vs/z8ciDfNHuL3+mmyV04TvLzpbif0H/+WgLmm0PNwCYOJue3Wf0aXls
 8ZZxX2wUGkSbc7viWHlIeZ2jAhoMOCsERLG9RiKw6jw6EKwV7C1LXJELN8+dJEmxe/bR
 BS3myBhXKy0JRqnrSJVZ39m+YIvU1nFB/XryNrLxVLyG8OEze2geaAYgva6/ZTnD+xFE
 nOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699439992; x=1700044792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7HzxvFFNmO6K1hTFtt7SUREj348gqTywo0NeLEtHUDE=;
 b=JbEAgeX60dmd5CU/SnqX04yAfEFwI3bwgJXoCqA+Ag//8Oq6UWiYTBDbkRcJpV0mYz
 HSV5fpL2SRR5P2zPH3JVYKIuiJP3Vq7umlhA+3kT4bQEa6tLbfSinFMQU8D3t086exuk
 ZsBYLBvvLrSApzcwXPECCx2jMSYWFp6LlQYMB/9OcJLO6fLhMpIgUaJswdj3GkerBF8h
 b6j5zW7DbEdrCbUtB9arQMDwwLHsi17u6kBLWau3QDHEWSYO0Q6uHof9ko3hSh7mf7LL
 sinWGstpOLfYp2D51XLAy4iNRZlESqFGwWHzFpAbtDTY2V69punaJNNnBKYpqoEiI5Ld
 LfUA==
X-Gm-Message-State: AOJu0YybPh/tQs2KqF1QBNt23wuXVT6sF10m3YFPOySOvr+KZXjEiCB8
 ujrlPYrraY7dJkvzsdCfKrtE6A==
X-Google-Smtp-Source: AGHT+IH24e4J6iKYjhZv//RFEp5tdbmJzGE8w/ya4CTdSC5uW0slNuS/HkMUpPpG59XKP0PGC6dhEw==
X-Received: by 2002:a50:8a8f:0:b0:543:595a:8280 with SMTP id
 j15-20020a508a8f000000b00543595a8280mr1064739edj.37.1699439991707; 
 Wed, 08 Nov 2023 02:39:51 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 v28-20020a50a45c000000b0053f10da1105sm6666119edb.87.2023.11.08.02.39.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 02:39:51 -0800 (PST)
Message-ID: <1a89ee9c-bd1c-4a04-8163-38307156351f@linaro.org>
Date: Wed, 8 Nov 2023 11:39:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/sd: Declare CPU QOM types using DEFINE_TYPES()
 macro
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Bin Meng
 <bin.meng@windriver.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-block@nongnu.org
References: <20231031080603.86889-1-philmd@linaro.org>
 <20231031080603.86889-2-philmd@linaro.org>
 <b06b0685-9407-4350-a8e6-edd0a9411c4e@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <b06b0685-9407-4350-a8e6-edd0a9411c4e@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

On 31/10/23 09:31, Cédric Le Goater wrote:
> On 10/31/23 09:06, Philippe Mathieu-Daudé wrote:
>> When multiple QOM types are registered in the same file,
>> it is simpler to use the the DEFINE_TYPES() macro. In
>> particular because type array declared with such macro
>> are easier to review.
>>
>> Mechanical transformation using the following comby script:
>>
>>    [pattern-x1]
>>    match='''
>>    static const TypeInfo :[i1~.*_info] = {
>>        :[body]
>>    };
>>    static void :[rt1~.*_register_type.](void)
>>    {
>>        type_register_static(&:[i2~.*_info]);
>>    }
>>    type_init(:[rt2~.*_register_type.])
>>    '''
>>    rewrite='''
>>    static const TypeInfo :[i1][] = {
>>        {
>>        :[body]
>>        },
>>    };
>>
>>    DEFINE_TYPES(:[i1])
>>    '''
>>    rule='where :[i1] == :[i2], :[rt1] == :[rt2]'
>>
>>    [pattern-x2]
>>    match='''
>>    static const TypeInfo :[i1a~.*_info] = {
>>        :[body1]
>>    };
>>    ...
>>    static const TypeInfo :[i2a~.*_info] = {
>>        :[body2]
>>    };
>>    static void :[rt1~.*_register_type.](void)
>>    {
>>        type_register_static(&:[i1b~.*_info]);
>>        type_register_static(&:[i2b~.*_info]);
>>    }
>>    type_init(:[rt2~.*_register_type.])
>>    '''
>>    rewrite='''
>>    static const TypeInfo :[i1a][] = {
>>        {
>>        :[body1]
>>        },
>>        {
>>        :[body2]
>>        },
>>    };
>>
>>    DEFINE_TYPES(:[i1a])
>>    '''
>>    rule='''
>>    where
>>    :[i1a] == :[i1b],
>>    :[i2a] == :[i2b],
>>    :[rt1] == :[rt2]
>>    '''
>>
>> and re-indented manually.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> I checked the aspeed part.
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>

In the absence of other reviews, I'm queueing this patch via my cpu/misc 
tree, thanks!

>> ---
>>   hw/sd/aspeed_sdhci.c   | 19 ++++++++-----------
>>   hw/sd/bcm2835_sdhost.c | 33 ++++++++++++++-------------------
>>   hw/sd/cadence_sdhci.c  | 21 +++++++++------------
>>   hw/sd/core.c           | 19 ++++++++-----------
>>   hw/sd/npcm7xx_sdhci.c  | 21 +++++++++------------
>>   hw/sd/pl181.c          | 35 +++++++++++++++--------------------
>>   hw/sd/pxa2xx_mmci.c    | 35 +++++++++++++++--------------------
>>   hw/sd/sd.c             | 37 ++++++++++++++++---------------------
>>   hw/sd/sdhci-pci.c      | 25 +++++++++++--------------
>>   hw/sd/ssi-sd.c         | 19 ++++++++-----------
>>   10 files changed, 113 insertions(+), 151 deletions(-)



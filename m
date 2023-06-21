Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 843F9737EF8
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 11:27:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBu7X-0005M1-4O; Wed, 21 Jun 2023 05:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBu7R-0005HS-8Q
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:27:17 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qBu7P-0001jM-JO
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 05:27:16 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-9875c2d949eso715336366b.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 02:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687339632; x=1689931632;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dOBZPziSr3vloc6+QC3Qi/usRxYL8q7GHkk7X9L15tQ=;
 b=IiEgAeAX0ILyuHjjlyQoljPniDGYqei6iwIvmec2SZWojQB3GjfsVHq2zHOA7wsErI
 0gX13mk+gAPGHcCQAQmrHtLGKcRKjFW5vgLbCIt06APSzngeX5OALp+ny7LCG9QD4d1b
 x7Dp9C+TaXpBQKVBTcBuQ7V7V9Djy8AaMftdMlVJBQuYJ7cRT+DATc9SxksySWZMqm56
 Q+O4jwjJtfTwqZbtLIy3EpMoZqLu/N5OOU1KaeYD68HaVtVT8k/KUlvrsd3awVxCtLC5
 N4hJkF+Ftvq2LoUO5sLvSCJ+LIjpw1Kd1j0CFqPTqUIKscAcpUM0HwoAH6zm2RVeOzoN
 fPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687339632; x=1689931632;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dOBZPziSr3vloc6+QC3Qi/usRxYL8q7GHkk7X9L15tQ=;
 b=eaOM4SZ/JLCcGWwKl7Lmpf87r0ydX+pnRhOtuL/Vi9mK2QBYjgM6sYxg+plVzbMmMF
 rvozqBf5j6Zegc45IUqUthsFdqtPXjcSMMdE/LqlAgNb5hFqaQmaa5l8qDTo5VjPmYUe
 6fLCBbL5XHD1uzNFV/MHpXcfmhMKJ/P+ba46MzGmFu9g2DgVhGBEX3i3W0XNpdzO0uJa
 M43nX2KMHawczJUVDH0S2lia6JyPZGAAsK64+3zS/QQ3dqmV/zW/cNA6lVhODXczS55Z
 4Rf4sgyPQfS+vRdvEyU9lYh5pmha5rGkNDYl/mszp5iaaE58FWnfFZZ9dV+bvIcuilvy
 XoXQ==
X-Gm-Message-State: AC+VfDzGRz7vufQRbQD4AoDzdTMgfiQGdHm340nbIPveTsLKnXIxVmqI
 7fCQEbp1tCxPnKFNC5aQvrRDscCpCIcmodO28pu+ZWrK
X-Google-Smtp-Source: ACHHUZ7FIwuvPZXmdv1kkCcps5BzG82qm+Be8XON56wyJXzrFHGHD+0Q+MCdPnJNzhVsRdWxEytIew==
X-Received: by 2002:a17:907:36c9:b0:987:9203:64b7 with SMTP id
 bj9-20020a17090736c900b00987920364b7mr10690028ejc.18.1687339632545; 
 Wed, 21 Jun 2023 02:27:12 -0700 (PDT)
Received: from [192.168.69.129] ([176.176.128.70])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a170906134e00b009828e26e519sm2747360ejb.122.2023.06.21.02.27.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Jun 2023 02:27:12 -0700 (PDT)
Message-ID: <49783ad9-cb1f-28d4-703f-6c0a99722935@linaro.org>
Date: Wed, 21 Jun 2023 11:27:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 04/46] target/loongarch: Implement xvadd/xvsub
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230620093814.123650-1-gaosong@loongson.cn>
 <20230620093814.123650-5-gaosong@loongson.cn>
 <47d12e8b-493a-e58c-54a1-47bd919c7e20@linaro.org>
 <cbe08731-718e-23d9-d834-1c34565902ad@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cbe08731-718e-23d9-d834-1c34565902ad@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/21/23 11:19, Song Gao wrote:
> 
> 
> 在 2023/6/20 下午8:25, Richard Henderson 写道:
>> On 6/20/23 11:37, Song Gao wrote:
>>> +static bool gvec_xxx(DisasContext *ctx, arg_xxx *a, MemOp mop,
>>> +                     void (*func)(unsigned, uint32_t, uint32_t,
>>> +                                  uint32_t, uint32_t, uint32_t))
>>> +{
>>> +    uint32_t xd_ofs, xj_ofs, xk_ofs;
>>> +
>>> +    CHECK_ASXE;
>>> +
>>> +    xd_ofs = vec_full_offset(a->xd);
>>> +    xj_ofs = vec_full_offset(a->xj);
>>> +    xk_ofs = vec_full_offset(a->xk);
>>> +
>>> +    func(mop, xd_ofs, xj_ofs, xk_ofs, 32, ctx->vl / 8);
>>> +    return true;
>>> +}
>>
>> Comparing gvec_xxx vs gvec_vvv for LSX,
>>
>>>     func(mop, vd_ofs, vj_ofs, vk_ofs, 16, ctx->vl/8);
>>
>> gvec_vvv will write 16 bytes of output, followed by 16 bytes of zero to satisfy vl / 8.
>>
>>
>> I presume this is the intended behaviour of mixing LSX with LASX, that the high 128-bits 
>> that are not considered by the LSX instruction are zeroed on write?
>>
> Yes,  the LSX instruction  can ignore the high 128-bits.

Ignore != write zeros on output.  What is the behaviour?


r~


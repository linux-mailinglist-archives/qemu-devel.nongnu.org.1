Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA45723264
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 23:40:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6Huz-0000d2-SU; Mon, 05 Jun 2023 17:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Huw-0000bF-60
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 17:39:11 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6Huu-0008Pf-JR
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 17:39:09 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-25676b4fb78so2671201a91.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 14:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686001146; x=1688593146;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YXRPLnfZje4Fq40Cva/CR9GQz+i7bOoGkbyLcjnlsgE=;
 b=wOXUqB/MJB2lFtwJXPxWMsopg0Lh8Gu8eIrf12r1msBJs7rPTB4dUn/O3MTi3jqwFX
 OqfCqW5gXGOnD1VQDdA9erPKNh2hTaTxc9VLPlWQKni2CyHrq6X4YYw+5lmBrEwPnWrE
 ENDeeiKogzaUvsk/sO4ACMchcoskAU1+WiGNKYrDxan3PLhPYhpJlDd7d7HCDQtwS0qb
 k8g8BFWgO6i9jnzIUUOm9FzmFot1l+YwhVNinkQ5XZiExY2IxqtXzHhPuJw/NILU/vgh
 U8BMIFX74WAH/QUwADieXJ1zp5/4AfQPhQXlcvi4WghdkGxS+FfDaNQocyoNr2/xkcmy
 Mb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686001146; x=1688593146;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YXRPLnfZje4Fq40Cva/CR9GQz+i7bOoGkbyLcjnlsgE=;
 b=Dcu13YbzfDte0nRdkBEIKzEgEUKch/pU8sra+nPPVsKJbBpCHX5R3It8gnuDea4kAJ
 vhg+zSGGw1x/GSYqeav5d+ZMID8XDCAlJmgRXm/2VM3s1VKChSnVjCNd9euXkyC3EAlJ
 x/77TSsLG4Ge8GAD1n+7JJdZZxyPCxMmoKhOa6GBaPEeYYEp9MPP4Q/1xeN16xw1mt9j
 QBbK6jkLwNC/fM8vNnhmA8r9YSzMeBu5kstdKtTjxpRo9JUw8fuJ94TCrBlAjM3PjgKf
 MjHN60xU1pO66ug56AjYur2kfcBLwJO/JzJgvp6Udct7E9wz6b0DIU7IbRKaW7J8rat7
 /2bg==
X-Gm-Message-State: AC+VfDy7ZmXNDC4ZnPId3+dK7uWTV/dD9dMsuvmh+CTyS8HyZhlV2E+B
 hudDQR9HTNnHL+qMCefpu9J+cg==
X-Google-Smtp-Source: ACHHUZ579mE6DN/7PtXfBn+WYxUmqfK9VO90d4cIzN4LHBhTsaTwkm547aHF0AGkzHzhahnYOdU4UA==
X-Received: by 2002:a17:90b:1e0d:b0:259:c10:ea34 with SMTP id
 pg13-20020a17090b1e0d00b002590c10ea34mr11421pjb.2.1686001146082; 
 Mon, 05 Jun 2023 14:39:06 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3f85:a600:6a3e:e465?
 ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 b16-20020a17090a551000b0024e026444b6sm126726pji.2.2023.06.05.14.39.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 14:39:05 -0700 (PDT)
Message-ID: <fc6f7fb4-8e01-e56b-9fae-a09934933d3e@linaro.org>
Date: Mon, 5 Jun 2023 14:39:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH 1/2] bulk: Replace !CONFIG_SOFTMMU -> CONFIG_USER_ONLY
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230602225811.60152-1-philmd@linaro.org>
 <20230602225811.60152-2-philmd@linaro.org>
 <7913570a-8bf6-2ac9-6869-fab87273742c@linaro.org>
 <97194b58-3f9c-e351-a439-87b2bfed5674@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <97194b58-3f9c-e351-a439-87b2bfed5674@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 6/5/23 13:29, Philippe Mathieu-Daudé wrote:
> On 3/6/23 05:49, Richard Henderson wrote:
>> On 6/2/23 15:58, Philippe Mathieu-Daudé wrote:
>>> CONFIG_USER_ONLY is the opposite of CONFIG_SOFTMMU.
>>> Replace !CONFIG_SOFTMMU negation by the positive form
>>> which is clearer when reviewing code.
>>
>> CONFIG_SOFTMMU should be reserved for the actual softmmu tlb, which we *should* be able 
>> to enable for user-only.  It is the only way to handle some of our host/guest page size 
>> problems.  Further, CONFIG_SOFTMMU should go away as a #define and become a runtime test 
>> (forced to true for system mode).  Pie in the sky stuff.
> 
> This would be:
> 
>    bool has_softmmu(void)
>    {
>    #ifdef CONFIG_USER_ONLY
>        /* TODO: implement */
>        return false;
>    #else
>        return true;
>    #endif
>    }
> 
> ?

Yes, something like that.


r~


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2FE76590B
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 18:44:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3u7-0005Ns-BE; Thu, 27 Jul 2023 12:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP3u3-0005Na-Up
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:31:52 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qP3u2-0001mJ-B1
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:31:51 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1bb775625e2so7446335ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690475507; x=1691080307;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t8jhy7LbSEamd15YQjdZjcGdRphBrK/yDrSg5BLGz2k=;
 b=PJLQ7yAYo0WddKi3y81E4zm9hF+v9pRELVnSMii6uoUQZvRnvhcIV6YJuLrRMbsb1F
 f+Kks13Y85EP0zVTAwizFwh0wjBCE+rIJQNnd3gbPBCMOP0vkH8OUHeeC9lDmdvUxyIQ
 ToFL8VbpaAMFjKUSjFAbKgCT2MaucUHJvblmpq9jHzTODOfcsxIvQIZA2aLEuY+YYMOT
 qTifZgTUGvOS89wzRAEcJmx/8pL9p1KAeKuUOsixsOMH4cqU41GiTu3V3+W6VQ00mYGI
 lxZbc+ShOrJk2i9OH0fgclwtCOsm2ER6UABFL9Zma/+zAKrHOVUP6EuQ9J5A0WUmZXOn
 EFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690475507; x=1691080307;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t8jhy7LbSEamd15YQjdZjcGdRphBrK/yDrSg5BLGz2k=;
 b=M1HJq2OT3ZpesPtpSG656WTmSeLVxti+UKwGXRbN8I0rDBuPbnXZ7K/cQ48xRv0n6E
 Q7WpSwWmPeQBhf9ujio9sYPJe4bvrpYAVVByRCk1G03xyaq65pFZ9HmPUrzX1zUpAkfz
 37BHJrzqcQQlMj/SYDB9In2p2jiUcNoc4iqRN5U4nwKFpFsdN8XscxzsXFKxHeQ1BPlg
 COPcnYL+hDzjovtIUAoo76vjU7g0a/aqmPAG5fiCt5mqze5E5TkG+GKNVJmeTdyL193W
 swhZWAXixLeQD/anX7oqjHp054G5GZJ5ewtM57kzQdOQszbsppTUBQUpadIFuusQpO0I
 KciA==
X-Gm-Message-State: ABy/qLbjeM8XlwBFLZiQGgWXog8YlLZtKv7bkKP30hzwjQeJlRwzfjUS
 YkmRJa1Om5qjntawkm5pGMAzGQ==
X-Google-Smtp-Source: APBJJlGP47KJLw5aSVClOsM+4kRsb6+2myOXR1kv2tVZEhp6NfK1+Y/BIz7WyPnEI5EDaM82/rq40g==
X-Received: by 2002:a17:903:2351:b0:1b8:417d:d042 with SMTP id
 c17-20020a170903235100b001b8417dd042mr3766349plh.20.1690475507280; 
 Thu, 27 Jul 2023 09:31:47 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:caf5:5ae2:432a:1bdf?
 ([2602:ae:154e:c001:caf5:5ae2:432a:1bdf])
 by smtp.gmail.com with ESMTPSA id
 iz12-20020a170902ef8c00b001b8b45b177esm1835420plb.274.2023.07.27.09.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 09:31:46 -0700 (PDT)
Message-ID: <ebdf2692-a155-6d2f-d46c-ddef02f4752a@linaro.org>
Date: Thu, 27 Jul 2023 09:31:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] semihosting/uaccess.c: Replaced a malloc call with
 g_malloc.
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: dinglimin@cmss.chinamobile.com, Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <20230725080630.1083-1-dinglimin@cmss.chinamobile.com>
 <20230725090039.1271-1-dinglimin@cmss.chinamobile.com>
 <106cf02f-f746-e216-22be-8f7594028695@tls.msk.ru>
 <CAFEAcA-ErMrk60uZMu8M-0G15aTvhOZsYsvJD1F-YbLGOFDBYA@mail.gmail.com>
 <E1qOWH5-0002Du-U6@lists.gnu.org>
 <CAFEAcA8UdN4-DU4dAiY3VGLA77mLK-ohfFJs5+5fDt3v1mAAcg@mail.gmail.com>
 <9a05f370-1857-2c28-a184-a5197455b314@linaro.org>
 <CAFEAcA-4qzq7hivk-vuZMfxOaMXU7zusATtotiashNqrSbupSg@mail.gmail.com>
 <ZMKHlCHA+5IWd9EE@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZMKHlCHA+5IWd9EE@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 7/27/23 08:04, Daniel P. Berrangé wrote:
> On Thu, Jul 27, 2023 at 03:56:23PM +0100, Peter Maydell wrote:
>> On Wed, 26 Jul 2023 at 16:21, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> On 7/26/23 02:43, Peter Maydell wrote:
>>>> (Something went wrong with the quoting in your email. I've
>>>> fixed it up.)
>>>>
>>>> On Wed, 26 Jul 2023 at 05:38, <dinglimin@cmss.chinamobile.com> wrote:
>>>>> Peter Maydell wrote:
>>>>>> The third part here, is that g_malloc() does not ever
>>>>>> fail -- it will abort() on out of memory. However
>>>>>> the code here is still handling g_malloc() returning NULL.
>>>>>> The equivalent for "we expect this might fail" (which we want
>>>>>> here, because the guest is passing us the length of memory
>>>>>> to try to allocate) is g_try_malloc().
>>>>
>>>>> g_malloc() is preferred more than g_try_* functions, which return NULL on error,
>>>>> when the size of the requested allocation  is small.
>>>>> This is because allocating few bytes should not be a problem in a healthy system.
>>>>
>>>> This is true. But in this particular case we cannot be sure
>>>> that the size of the allocation is small, because the size
>>>> is controlled by the guest. So we want g_try_malloc().
>>>
>>> And why do we want to use g_try_malloc instead of just sticking with malloc?
>>
>> The only real reason is just consistency
> 
> I think it is slightly stronger than that.
> 
> By using g_try_malloc we make it explicit that this scenario is
> expecting the allocation to fail and needs to handle that.
> 
> If we use plain 'malloc' it isn't clear whether we genuinely expect
> the allocation to fail, or someone just blindly checked malloc
> return value out of habit, because they didn't realize QEMU wants
> abort-on-OOM behaviour most of the time.

Ok, fair enough.


r~


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D07F777765
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 13:42:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU3Wj-0004wz-Ek; Thu, 10 Aug 2023 07:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU3Wh-0004wp-HI
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:08:23 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qU3Wg-00064q-0r
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 07:08:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fe1fc8768aso7072285e9.1
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 04:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691665699; x=1692270499;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2IrbW9Mq+c8/OLy1JgI85jl2Yxm5TKtiw4QyDmH/GYw=;
 b=GNzlyRarW2YEs55h+ES/Jgl5LRPm/f5oWKbiCm9KxiUdVhoRj7eh9jZrHXaIkK2bFd
 TPNYnzJNhu35jMh0uswrIMZ1Vo341/g7v3bnPCz2DGyfjsHrvimmc3D7BzPuo8TmQnvu
 1HaKNTXDLshbBa3W3A9qFQ3ImT0WnQaCVnzI/ro2dXQmq+HTBONQ8FT8ezMAkg3/wCv6
 Ykia5BVWBPvmuiJixgtoxP1Vvqi2HLosn0wRW+gqYqCSIs+G0jOPRKuTD7oDTsd6MsnR
 M2UNe9EBkxFr9vUjtFMiD8HUXEpybw8se4SOXzvnkQqSE2OGGG/A8DlkMvglOdZRlSl/
 MXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691665699; x=1692270499;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2IrbW9Mq+c8/OLy1JgI85jl2Yxm5TKtiw4QyDmH/GYw=;
 b=hm/wtBJnVHJKmTeZ2IG73LabIkefXmqvRu1e9xWfTqjMT2TUclmCNw35Vxm27uM/RJ
 hCcpEGEMujVo98FVf2kPOPyvi2MJADe69tsYJXLa3YDg5PcxPnpBHb0rh2FuroWofnHh
 6fV81z7tIXqSLTdlGLrVzs3H+KU8QY+AWgWnSHBvuj+bE1mzlkz81ygKpjHYw+gfTkX5
 voBNqBGff2hzNp20O8A+hZmB6RQ7oIjTshgJSFYFchuWV1ozo+g67onU5nSoOVtV0nw8
 JC8BtyATRnmc5GOEKfEvt7U9pnCTDtesdDHlytMMtG3BTHjVBa/jbfJnzKu/siwneIX/
 aY4g==
X-Gm-Message-State: AOJu0YxyWB8WfheumSyx2pUG9BEfodDpXgMfmXXZJzVeqAfA+/V8COLg
 QK5+L1iIKmN7eJp1ekT7/XLb4Q==
X-Google-Smtp-Source: AGHT+IEGDHNIxMLEiS8lWJIn2PH4CUKTnCktxNe7CqprwanNhFKuWL45pIPCvSySBdkUmk+q9vWQoQ==
X-Received: by 2002:a7b:c34e:0:b0:3fe:2bb1:11ba with SMTP id
 l14-20020a7bc34e000000b003fe2bb111bamr1900818wmj.27.1691665699486; 
 Thu, 10 Aug 2023 04:08:19 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.158.65])
 by smtp.gmail.com with ESMTPSA id
 m8-20020a7bca48000000b003fa96fe2bd9sm4775041wml.22.2023.08.10.04.08.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Aug 2023 04:08:19 -0700 (PDT)
Message-ID: <2669cda6-a25a-6742-d072-f04fb6c18c08@linaro.org>
Date: Thu, 10 Aug 2023 13:08:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/11] target/loongarch: Add macro to check current arch
Content-Language: en-US
To: Jiajie Chen <c@jia.je>, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org
Cc: yijun@loongson.cn, shenjinyang@loongson.cn, gaosong@loongson.cn,
 i.qemu@xen0n.name
References: <20230808015506.1705140-1-c@jia.je>
 <20230808015506.1705140-2-c@jia.je>
 <68c43230-1198-5d46-5450-26b8f61bd09b@linaro.org>
 <6783fb78-b346-1395-da8e-648792557909@jia.je>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <6783fb78-b346-1395-da8e-648792557909@jia.je>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.156,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/8/23 19:13, Jiajie Chen wrote:
> 
> On 2023/8/9 01:01, Richard Henderson wrote:
>> On 8/7/23 18:54, Jiajie Chen wrote:
>>> Add macro to check if the current cpucfg[1].arch equals to 1(LA32) or
>>> 2(LA64).
>>>
>>> Signed-off-by: Jiajie Chen <c@jia.je>
>>> ---
>>>   target/loongarch/cpu.h | 7 +++++++
>>>   1 file changed, 7 insertions(+)


>> It might be easier to just define
>>
>> static inline bool is_la64(CPULoongArch64 *env)
>> {
>>     return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == 
>> CPUCFG1_ARCH_LA64;
>> }

Ah, drop my other suggestion (Richard's way is simpler).

> Sure, I will use this way.




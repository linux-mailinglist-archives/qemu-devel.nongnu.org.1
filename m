Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD437BF7D2
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 11:49:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq9M2-0004KO-F4; Tue, 10 Oct 2023 05:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq9Ly-0004EG-OT
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:48:39 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qq9Lv-0003FR-8k
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:48:37 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9ae75ece209so985887666b.3
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696931310; x=1697536110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NjRgnkdnq+Xnm7xoAs4BcpBKYlROU4PW+5xYq+lCe5E=;
 b=NHkx0fpY+g2SXpzF46OEB0QB5s7Yp71KmRXc0SuGieKEGgQzXyiitndXa+xqdskkCv
 o4iR/a+BAQaYkfxPOlIzE3Y0L6l0oeopTomrbu2m7M4SbyqcokYgg4CFMGmJCpLwjPSY
 oozwtIbuPz+CHYcE8dqEVbufHHbFAVZEI+0vSPBsTH+gL3yrhoPWs+mHQA3Io3qrERDW
 mQJBrqED6zgcE2sEa50odMOUFIsEI50PHoRCUtfJjr50H0QamvStCz0ZuA83EjxQnMFQ
 MdsZNCKrwlVCmVMIad9dnlNvycAvcOTBUFoqvazzOi/fQnMIXDJwvuvoTiD4ivyQI+gx
 WyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696931310; x=1697536110;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NjRgnkdnq+Xnm7xoAs4BcpBKYlROU4PW+5xYq+lCe5E=;
 b=NJnHwAqXed27nu81QtZMtwyBl/wCo33PTZGPPjZTKhdOx6Kc1ENl9CS/vlt6X21YuJ
 pycGMVpoR6neePp6mkl4BjxmXc1T7kcLR2Dr62SvNpSBUVFBKWXwVZ2vgI3wrARwr5mY
 RJ/Cw25/Z6lIxUoWDZ3U32ybs8FXA8BwPqGRKchtii1rbgSLLNHLL14P4ItVlz02LfLJ
 C1hvrlMG48hjtB9+sHHrzGuoFen3sA+fuH5Kvw3DeDd9OT+a4/wSYuTpepPjlCmEKjGA
 lshs87DVyly7W5mnuNXSyeZJFzxlDZkr4lIEqKZgjzre4gJpaABi9n0DI6E9olxP5aer
 byJQ==
X-Gm-Message-State: AOJu0YzvWIO68X6bU2zmetozT38V8HeOKz4lek1YGW+bhbcUATK16syx
 WARx5AXo7nuq9xntFp9sw5kNzQ==
X-Google-Smtp-Source: AGHT+IFEHsBCz24KEtiGpKDSCOQa3M3jGui/uPzOG8OKTM6Jtu+TAvshZuUSfV6Lvug6hP8HxLs/nQ==
X-Received: by 2002:a17:907:9724:b0:9ae:50e3:7e40 with SMTP id
 jg36-20020a170907972400b009ae50e37e40mr18923706ejc.52.1696931309984; 
 Tue, 10 Oct 2023 02:48:29 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr. [176.172.113.148])
 by smtp.gmail.com with ESMTPSA id
 i11-20020a170906a28b00b009737b8d47b6sm8137657ejz.203.2023.10.10.02.48.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 02:48:29 -0700 (PDT)
Message-ID: <6fcc827a-02fb-7fad-a853-5bcdf9aaa7a1@linaro.org>
Date: Tue, 10 Oct 2023 11:48:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/4] tests/libqtest: Introduce qtest_get_arch_bits()
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>
References: <20231010074952.79165-1-philmd@linaro.org>
 <20231010074952.79165-2-philmd@linaro.org>
 <e108d282-5eec-4430-1a10-8cf3170bb18c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <e108d282-5eec-4430-1a10-8cf3170bb18c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/10/23 11:46, Thomas Huth wrote:
> On 10/10/2023 09.49, Philippe Mathieu-Daudé wrote:
>> Add a method to return the architecture bits (currently 8/32/64).
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/qtest/libqtest.h |  8 ++++++++
>>   tests/qtest/libqtest.c | 21 +++++++++++++++++++++
>>   2 files changed, 29 insertions(+)

>> +unsigned qtest_get_arch_bits(void)
>> +{
>> +    static const char *const arch64[] = {
>> +        "aarch64", "hppa", "x86_64", "loongarch64", "mips64",
>> +        "mips64el", "ppc64", "riscv64", "s390x", "sparc64",
>> +    };
>> +    const char *arch = qtest_get_arch();
>> +
>> +    if (!strcmp(arch, "avr")) {
> 
> Just a matter of taste, but I prefer g_str_equal(), that's easier to read.
> 
>> +        return 8;
>> +    }
>> +
>> +    for (unsigned i = 0; i < ARRAY_SIZE(arch64); i++) {
>> +        if (!strcmp(arch, arch64[i])) {
>> +            return 64;
>> +        }
>> +    }
>> +
>> +    return 32;
>> +}
> 
> Since this function might get called multiple times, would it make sense 
> to cache the value? I.e.:
> 
>    static const unsigned bits;
> 
>    if (!bits) {
>        ... do all the magic to find out the right bits ...
>    }
> 
>    return bits;
> 
> ?

Fine by me, I'll do as suggested in v2.



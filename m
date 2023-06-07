Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D5C727010
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 23:04:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q70Jz-0000Sf-Bu; Wed, 07 Jun 2023 17:03:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q70Jx-0000SK-2m
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 17:03:57 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q70Jv-0003aF-7p
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 17:03:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f7353993cbso8787345e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 14:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686171833; x=1688763833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4VuzHqF/JgnVuuww4s0SJArrcUABjRCgbQR1faNyZFc=;
 b=XdJsfHXbIvMLQk4pOa0u+KdeR5mBS4kmg/htMpzy2raKTfri55IgLUBJl4OAqs8hbm
 jIBEGDuW6x/6AgPnjYZRbyrgLD7fhy2Er3WIecLHjqWCMevBriagd2zAJNHYFvx9TbZ5
 zkM+CM4eWKF0BgKLcnJBmw8O0OZxbJqDYJfurrjVNxFBlExznNFLZRhkVMVw6KfKhJUw
 nm1KUwZwgmDloR4jV9YBpp7oM532Moi3RYGukY04jH8dfDhBU2lN52N85UbWzY3+B+Dl
 seZqvTbfcsiWFIutowpJpAh0GfGtdOJ7Y5CxYYh3DtrtxXpRz5dagQ2Uu8lNZq+8rfHK
 dVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686171833; x=1688763833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4VuzHqF/JgnVuuww4s0SJArrcUABjRCgbQR1faNyZFc=;
 b=L1DN0WgolZdZ9G9NidJL1fLd5Lgi7oOZLQrxaeDvIPyIr7lFoy+grUs3ryq4JSOp3I
 Vh7t6NVLWLyoNikEFn2RfaLCgEUE5MiUWNs6qCOT7ISsI1WuKiJLxqUvsy6+zTJbhqoV
 h9yM/OO29W1Zll+X7J7yt8xT86/vDLx3muEk/+tIXyoI93+4niASDDXTANGoWthCp0P8
 4cpj3n3BqRK3/VT65A+9wqr0+/Aac9xUp08z2BFJXhRO/Fvc518N7JMcVX888+gPYhRD
 8pE4xPZdnGseMFXaoh6r4ZNxPsbBIASt2lpys5pOXLXsPhai4gXrnkNPumucuQ7Q+3K+
 xYqg==
X-Gm-Message-State: AC+VfDxEY6qezba0KW3FYAXe3/h91rpED3KtoZOYkLDakhK+CCMRY8xL
 tDxydkRBT1uNKsW5prJA4mtFB4r0k59+PWKjSd0=
X-Google-Smtp-Source: ACHHUZ5l32jJkwhuTlTJq1ZMPXAiCCvuf6zs6N6kj0RA7kVN+CC4p0F16H5GDpkfV4c58/4mjJ+54w==
X-Received: by 2002:a1c:6a15:0:b0:3f7:367a:bd28 with SMTP id
 f21-20020a1c6a15000000b003f7367abd28mr150124wmc.4.1686171833201; 
 Wed, 07 Jun 2023 14:03:53 -0700 (PDT)
Received: from [192.168.69.115] (bd137-h02-176-184-46-52.dsl.sta.abo.bbox.fr.
 [176.184.46.52]) by smtp.gmail.com with ESMTPSA id
 c23-20020a05600c0ad700b003f7f1466203sm3062975wmr.34.2023.06.07.14.03.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 14:03:52 -0700 (PDT)
Message-ID: <579fb938-dc8a-5f85-143f-644ba1f1db40@linaro.org>
Date: Wed, 7 Jun 2023 23:03:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH 1/1] tests/avocado: update firmware to enable sbsa-ref/max
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20230530152240.79160-1-marcin.juszkiewicz@linaro.org>
 <ab3d3d19-2604-c519-03b0-af3952fb7718@linaro.org>
 <50e8f35d-855b-4d0a-abdd-2aa42599bd65@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <50e8f35d-855b-4d0a-abdd-2aa42599bd65@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 7/6/23 17:29, Marcin Juszkiewicz wrote:
> W dniu 7.06.2023 o 16:33, Philippe Mathieu-Daudé pisze:
>> On 30/5/23 17:22, Marcin Juszkiewicz wrote:
>>> Update prebuilt firmware images to have TF-A with FEAT_FGT support
>>> enabled. This allowed us to enable test for "max" cpu in sbsa-ref
>>> machine.
>>>
>>> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>>> ---
>>>   tests/avocado/machine_aarch64_sbsaref.py | 22 +++++++++++-----------
>>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/tests/avocado/machine_aarch64_sbsaref.py 
>>> b/tests/avocado/machine_aarch64_sbsaref.py
>>> index 0a79fa7ab6..35f8042416 100644
>>> --- a/tests/avocado/machine_aarch64_sbsaref.py
>>> +++ b/tests/avocado/machine_aarch64_sbsaref.py
>>> @@ -29,23 +29,23 @@ def fetch_firmware(self):
>>>           """
>>>           Flash volumes generated using:
>>> -        - Fedora GNU Toolchain version 12.2.1 20220819 (Red Hat 
>>> Cross 12.2.1-2)
>>> +        - Fedora GNU Toolchain version 13.1.1 20230511 (Red Hat 
>>> 13.1.1-2)
>>>           - Trusted Firmware-A
>>> - https://github.com/ARM-software/arm-trusted-firmware/tree/5fdb2e54
>>> + https://github.com/ARM-software/arm-trusted-firmware/tree/c0d8ee38
>>>           - Tianocore EDK II
>>> -          https://github.com/tianocore/edk2/tree/494127613b
>>> -          https://github.com/tianocore/edk2-non-osi/tree/41876073
>>> -          https://github.com/tianocore/edk2-platforms/tree/8efa4f42
>>> +          https://github.com/tianocore/edk2/tree/0f9283429dd4
>>> +          https://github.com/tianocore/edk2-non-osi/tree/f0bb00937ad6
>>> +          https://github.com/tianocore/edk2-platforms/tree/7880b92e2a04
>>
>> Thanks for updating this comment!
> 
> Having a way to reproduce is crucial for CI.
> 
>>> -    @skip("requires TF-A update to handle FEAT_FGT")
>>> +    @skipUnless(os.getenv("AVOCADO_TIMEOUT_EXPECTED"), "Test might 
>>> timeout")
>>
>> Can it still timeout?
> 
> All Linux based tests in this file have that @skipUnless as they take 
> some time:
> 
> test_sbsaref_edk2_firmware: PASS (2.72 s)
> test_sbsaref_alpine_linux_cortex_a57: PASS (23.71 s)
> test_sbsaref_alpine_linux_neoverse_n1: PASS (23.53 s)
> test_sbsaref_alpine_linux_max: PASS (28.16 s)

I suppose this was due to a bug we had with Avocado consuming QEMU's
console. I don't remember recent complains. Alex, do you know if this
was fixed?
We define the class timeout to 180s, so all tests inherit it. In your
run all tests take <30sec, it should be fine to run them on CI.
Adding ~1min30s extra on the job running these Avocado tests seem
reasonable to me, but I have Cc'ed Thomas who took care to reduce
testing time.

Regards,

Phil.


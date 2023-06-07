Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC187264AA
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:30:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6v6Y-000495-GO; Wed, 07 Jun 2023 11:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q6v6W-000486-Ix
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:29:44 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q6v6H-0007ys-Dl
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:29:44 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5169f614977so1265255a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 08:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686151764; x=1688743764;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/M1orYe/+V7Ktowyt9+oLMALLQqkm72aIJzmWoM0vCs=;
 b=PWmClaQXh/lUUNPdU5MgYiEL+ltL2oyH1cz6TRUtYiV/358Wv8WyuEdhkn6g4pmU5O
 5iC0Jg7wGDBeAcM3eaJLLxA+qzEcQfm8T6l2gZFQbvnR4Vn64vbZFEHFk0dWdOcpc1Oa
 CsfSCfnQAEUfXfuT1SF4f1GHyR4DS03/mJpB0eGBwJkQb7OTi/jvOy+ClRXnrCKDDxb1
 55BLf2py3Jq395Gx9pxFJO/GtzpiCyPzo/FtCZ9BqRnTQ3ZSHV+tKQNx/9AVo677P9r6
 DL0xT2jZNMXNOryuX1fRoYi3iMAzT2CvJEhR5483oiNTNn9Dm0NPZVw9bTwpVcwaG5Il
 EOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686151764; x=1688743764;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/M1orYe/+V7Ktowyt9+oLMALLQqkm72aIJzmWoM0vCs=;
 b=kkG80jzo/Er6g/TJbyu2F1u1dnD4XCXIj52GRg94bE+3vHorLBwU0Crwnpoa8R3mhx
 T1O6LTvCtKtnel2cacnxnyB9LWz/OhB5KxsxFBRezLUX8KbYk0LvxbgyzWrNqVpDvRcq
 FxBQKQCLyKDJXhG28Lf8j7DvilUC+ZSeNMnpE3EglO30+bR+KByJwnW1GmYO0LQDekfI
 i1XWk5bPgJ4mm+YDK1rJGiOEd7Z2OGJ3+b+94jusqGH2dABBKXvt8FsEfcbeJtSQI+Hm
 5pk5sQ/+fzA+Ow9Vd3AP4zgW456KainwoNDh+7eGvZHPqPdKw5OhDLrcc+3yEHptIsDX
 EWxw==
X-Gm-Message-State: AC+VfDxLFKwEovu0MTg4XISokHZbuXP0WXjcTMm3KlLxyd4GhhJBxg4O
 KSXebb7yI80VHzTkmYSHf37ahA==
X-Google-Smtp-Source: ACHHUZ6y6yxrV2yu4OJkg7Q0dwEwP2tZ+VH4HWXOD2kR/I+nyTt7iCYjdS2jh1CLMRYI6TqWZy9rGA==
X-Received: by 2002:a17:907:3e99:b0:96a:29c0:8515 with SMTP id
 hs25-20020a1709073e9900b0096a29c08515mr6590776ejc.58.1686151763999; 
 Wed, 07 Jun 2023 08:29:23 -0700 (PDT)
Received: from [192.168.200.206] (83.21.93.182.ipv4.supernova.orange.pl.
 [83.21.93.182]) by smtp.gmail.com with ESMTPSA id
 z16-20020a170906241000b009788d99244csm293233eja.149.2023.06.07.08.29.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jun 2023 08:29:23 -0700 (PDT)
Message-ID: <50e8f35d-855b-4d0a-abdd-2aa42599bd65@linaro.org>
Date: Wed, 7 Jun 2023 17:29:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] tests/avocado: update firmware to enable sbsa-ref/max
Content-Language: pl-PL, en-GB, en-HK
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230530152240.79160-1-marcin.juszkiewicz@linaro.org>
 <ab3d3d19-2604-c519-03b0-af3952fb7718@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <ab3d3d19-2604-c519-03b0-af3952fb7718@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

W dniu 7.06.2023 o 16:33, Philippe Mathieu-Daudé pisze:
> On 30/5/23 17:22, Marcin Juszkiewicz wrote:
>> Update prebuilt firmware images to have TF-A with FEAT_FGT support
>> enabled. This allowed us to enable test for "max" cpu in sbsa-ref
>> machine.
>>
>> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>> ---
>>   tests/avocado/machine_aarch64_sbsaref.py | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/tests/avocado/machine_aarch64_sbsaref.py 
>> b/tests/avocado/machine_aarch64_sbsaref.py
>> index 0a79fa7ab6..35f8042416 100644
>> --- a/tests/avocado/machine_aarch64_sbsaref.py
>> +++ b/tests/avocado/machine_aarch64_sbsaref.py
>> @@ -29,23 +29,23 @@ def fetch_firmware(self):
>>           """
>>           Flash volumes generated using:
>> -        - Fedora GNU Toolchain version 12.2.1 20220819 (Red Hat Cross 
>> 12.2.1-2)
>> +        - Fedora GNU Toolchain version 13.1.1 20230511 (Red Hat 
>> 13.1.1-2)
>>           - Trusted Firmware-A
>> -          
>> https://github.com/ARM-software/arm-trusted-firmware/tree/5fdb2e54
>> +          
>> https://github.com/ARM-software/arm-trusted-firmware/tree/c0d8ee38
>>           - Tianocore EDK II
>> -          https://github.com/tianocore/edk2/tree/494127613b
>> -          https://github.com/tianocore/edk2-non-osi/tree/41876073
>> -          https://github.com/tianocore/edk2-platforms/tree/8efa4f42
>> +          https://github.com/tianocore/edk2/tree/0f9283429dd4
>> +          https://github.com/tianocore/edk2-non-osi/tree/f0bb00937ad6
>> +          https://github.com/tianocore/edk2-platforms/tree/7880b92e2a04
> 
> Thanks for updating this comment!

Having a way to reproduce is crucial for CI.

>> -    @skip("requires TF-A update to handle FEAT_FGT")
>> +    @skipUnless(os.getenv("AVOCADO_TIMEOUT_EXPECTED"), "Test might 
>> timeout")
> 
> Can it still timeout?

All Linux based tests in this file have that @skipUnless as they take 
some time:

test_sbsaref_edk2_firmware: PASS (2.72 s)
test_sbsaref_alpine_linux_cortex_a57: PASS (23.71 s)
test_sbsaref_alpine_linux_neoverse_n1: PASS (23.53 s)
test_sbsaref_alpine_linux_max: PASS (28.16 s)



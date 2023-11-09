Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2447E743D
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 23:12:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1DEu-0004S6-CL; Thu, 09 Nov 2023 17:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1DEl-0004Qh-HX
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 17:10:56 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1DEj-0002Ob-Ex
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 17:10:55 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-544455a4b56so2281356a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 14:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699567851; x=1700172651; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sTApegVAx/CxNA62fdqIZitZorNzK3XfLhc0DzUjmFg=;
 b=xjudbrvWhixcQuJwx9Z5uLani1Dai5Ak2K+f9EWkMnewb54OzGsmQ/dv7rkcJMezf2
 LektzdE6QS7U5ahv8Q8EwVXA2EIOn1IJep/ErQon3Y3dKWoFc5t7h7j7DLxyC8RH33Pm
 rgxI5X8E54nTHjHj4/e6YB6TrXyDhe/4yt1EmpYLsunCFKcwciB/6R6PRfKcTbh2o+Yj
 u275FIwQm1QCp49PuKAwzqdVLtwiS/zwovm+KWpwhvXPCpPtReC5VkjueU+Y1YnYmOXM
 FO8bOBH/DiSEDY3ngub8JDnubIaUkytWX96nmgLumjRIjWsxOOvwqD97fb8NU8S0Oyon
 QTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699567851; x=1700172651;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sTApegVAx/CxNA62fdqIZitZorNzK3XfLhc0DzUjmFg=;
 b=mPogVLUzxK111ugXrMywvp4/95xab3pIMd7w12NsQ4FL+glzi7wf+SfmCJqgOI9lV8
 81bwMjDNCF3HBZm7drich5MoqxWwyE9h8i7kppSSKoGWjOmu8DLoEFjgNnpSS0yUpyhW
 2j9jzj08hdmLa+uo9KnzPshLpLoaTPnMtO21Om7MHCWrkPm00JUgZwRwoYgB/EbgtuHy
 azl4UuQdXIWTZbGzK7cfbxFI6gO1hg9mdPBg2uJxWyikch0AIreQmTVm3DpoZ94KNN4m
 Y13bgV+qve2HVM2rfHrNAuujdfQGuZmOlAVLBcRf2wMB2sC0ym3hMH1Fvd+xkzYsATCQ
 qoyw==
X-Gm-Message-State: AOJu0YytXX+Ofi/g2rEoxJ8LeuhW70doB9mpBoTyK0DuUPyPf1ySvegj
 ZGvfdzfFqVznoKHtVQtiBTcRuA==
X-Google-Smtp-Source: AGHT+IEXu8APWfwS0ShxPkq40vXdN1h1yZjr87cBw2mWymBFbHrqKW7unsuBaRKX6J6jiQHbGbfXgA==
X-Received: by 2002:a17:906:4f86:b0:9e5:2710:6a4 with SMTP id
 o6-20020a1709064f8600b009e5271006a4mr963057eju.49.1699567851515; 
 Thu, 09 Nov 2023 14:10:51 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 fp2-20020a1709069e0200b009e5ded7d090sm289594ejc.97.2023.11.09.14.10.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 14:10:51 -0800 (PST)
Message-ID: <debb7597-ac74-4112-9b6d-beab63030e57@linaro.org>
Date: Thu, 9 Nov 2023 23:10:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] buildsys: Bump minimal meson version required to
 v1.2.3
To: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Rene Engel <ReneEngel80@emailn.de>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20231109160504.93677-2-philmd@linaro.org>
 <20231109170144.848401-1-pbonzini@redhat.com>
 <CAFn=p-aVGqK3ze3uHr0X1y07HU68pKr6TDBHDw9U1AQJV9KhQw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFn=p-aVGqK3ze3uHr0X1y07HU68pKr6TDBHDw9U1AQJV9KhQw@mail.gmail.com>
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

On 9/11/23 22:21, John Snow wrote:
> On Thu, Nov 9, 2023 at 12:01 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>>> We need meson v1.2.3 to build QEMU on macOS Sonoma.
>>>
>>> It also build fine all our CI jobs, so let's use it as our
>>> "good enough" packaged wheel.
>>>
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1939
>>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>>> Signed-off-by: Philippe Mathieu-DaudÃ© <philmd@linaro.org>
>>> ---
>>>   python/wheels/meson-0.63.3-py3-none-any.whl | Bin 926526 -> 0 bytes
>>>   python/wheels/meson-1.2.3-py3-none-any.whl  | Bin 0 -> 964928 bytes
>>>   pythondeps.toml                             |   2 +-
>>>   3 files changed, 1 insertion(+), 1 deletion(-)
>>>   delete mode 100644 python/wheels/meson-0.63.3-py3-none-any.whl
>>>   create mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl
>>>
>>> diff --git a/pythondeps.toml b/pythondeps.toml
>>> index 0a35ebcf9f..a2f8c1980b 100644
>>> --- a/pythondeps.toml
>>> +++ b/pythondeps.toml
>>> @@ -18,7 +18,7 @@
>>>
>>>   [meson]
>>>   # The install key should match the version in python/wheels/
>>> -meson = { accepted = ">=0.63.0", installed = "0.63.3", canary = "meson" }
>>> +meson = { accepted = ">=1.2.3", installed = "1.2.3", canary = "meson" }
>>
>> We don't need to block older versions of Meson, and indeed we don't
>> want to because it's fine to use the distro package everywhere
>> (including Sonoma).  (So the subject would become would be
>> "buildsys: Bump known good meson version to v1.2.3).
>>
>> You can look at sphinx below for another case where the accepted
>> versions are much older than the installed one.
>>
>> If there's anything you'd like to add to the (just sent) documentation
>> to clarify this, please help.
>>
>> Paolo
>>
>>>
>>>   [docs]
>>>   sphinx = { accepted = ">=1.6", installed = "5.3.0", canary = "sphinx-build" }
>>
> 
> I'd like you to also bump the version in the python/scripts/vendor.py
> script. You may have obtained it by other means, but I like
> documenting precisely where these .whl files come from in the form of
> the script.

Indeed I had a tab with https://pypi.org/project/meson/1.2.3/ opened but
neglected to mention it in the patch description.

I have no clue how this wheel package is prepared. It could come from
https://github.com/mesonbuild/meson/actions/runs/6569797806/workflow but
unfortunately the artifacts are not available anymore.

FWIW per 
https://pypi.org/project/meson/1.2.3/#copy-hash-modal-b6a34cf2-bd2f-4018-bfb0-b10d0fba8a3d
the sha-256 is 
4533a43c34548edd1f63a276a42690fce15bde9409bcf20c4b8fa3d7e4d7cac1.

Regards,

Phil.


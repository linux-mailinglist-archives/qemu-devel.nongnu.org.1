Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3787E7441
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 23:13:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1DGG-0005yZ-Lu; Thu, 09 Nov 2023 17:12:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1DG7-0005m0-Hn
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 17:12:21 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r1DG5-0002Yf-Nb
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 17:12:19 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5435336ab0bso2403983a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 14:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699567935; x=1700172735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uXWYSNBlT8VghV+vqUhVXiMq0+wOipJiiQVDFT8MHCc=;
 b=irD8Ssg2WjCwO2TSViwNCMCbna4Q2lS6+sS96CtJaPntVsNt2vLE7TvkSCNi6DzjsC
 p95nX0tuoCGGob3V2jPkGSz+kOGe9TwJWSYXLnI3fIH0gbEQi7qn/IN655akIYS9Grza
 iX8DjmWcFqrMD/sTYEBmxcEdrDeFxAQqiyqI1RKs5vnzlgs+wfAuJ/RQs6MyE2XHfutQ
 1WQwl++ulEqt4X1Pu+H+G/fennx/AjbiMXcbRLjwj1PtI/wCDugzY1CeLRglPZbkmnwG
 Q00aUG5m/ioha9iyIx8WCewO8fwOY8BgYdggOfkpkJBVHzmcpypelwm1fZmKiWRA1ala
 Nh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699567935; x=1700172735;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uXWYSNBlT8VghV+vqUhVXiMq0+wOipJiiQVDFT8MHCc=;
 b=UyC9bgnuDw7uYz4ZkbMXqBBdbSQ/8lfYnr5om0c/IjuJ3vRpTASI1Y/vvk/uA4u6yE
 EDHSnRAc1eyDAlJv/Mdd5oubzVd2Y7sA1P+jpDSWAjTZUn688EIPLr3i9qhHDBCv1nlP
 A5zgOxpURPwgkyRHKPzRsqUntr6/MX1884V79v33AIgM0KXk184s77p1QKaAhoBqs5le
 1p6BvJd4z8ZQQ0TTaZYC3cqiDFPe25hIS3IR56f4Lf63Q4grktJj5BrYJ92qQDFANcbH
 trPGjOn/mDTha7cHYSMkP5O4CEYPQouTREa9cM/RDo6kg1a4h6CO9ekhlLI01Z7M+q2g
 ejTw==
X-Gm-Message-State: AOJu0YyCPAWwQc1BkzUT+R1dnELRhNTOzFNhpKQdM6xqVw+MnfNMDh+p
 /YunLGEPYhrd1BKO9t+QGX0jzA==
X-Google-Smtp-Source: AGHT+IEIYD19CU2Tmc3r3Io+kQoQg3XBKn8Pnmbe86LujdhkkP3d8y4JIu6k9zMlYuDLvG4Wt+fINA==
X-Received: by 2002:a17:907:9287:b0:9ae:82b4:e309 with SMTP id
 bw7-20020a170907928700b009ae82b4e309mr5552377ejc.0.1699567935356; 
 Thu, 09 Nov 2023 14:12:15 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.161])
 by smtp.gmail.com with ESMTPSA id
 fp2-20020a1709069e0200b009e5ded7d090sm289594ejc.97.2023.11.09.14.12.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 14:12:15 -0800 (PST)
Message-ID: <9b707539-092f-47c8-bd81-901738e5ad62@linaro.org>
Date: Thu, 9 Nov 2023 23:12:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] buildsys: Bump minimal meson version required to
 v1.2.3
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Rene Engel <ReneEngel80@emailn.de>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20231109170144.848401-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231109170144.848401-1-pbonzini@redhat.com>
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

On 9/11/23 18:01, Paolo Bonzini wrote:
>> We need meson v1.2.3 to build QEMU on macOS Sonoma.
>>
>> It also build fine all our CI jobs, so let's use it as our
>> "good enough" packaged wheel.
>>
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1939
>> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
>> Signed-off-by: Philippe Mathieu-DaudÃ© <philmd@linaro.org>
>> ---
>>   python/wheels/meson-0.63.3-py3-none-any.whl | Bin 926526 -> 0 bytes
>>   python/wheels/meson-1.2.3-py3-none-any.whl  | Bin 0 -> 964928 bytes
>>   pythondeps.toml                             |   2 +-
>>   3 files changed, 1 insertion(+), 1 deletion(-)
>>   delete mode 100644 python/wheels/meson-0.63.3-py3-none-any.whl
>>   create mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl

This file comes from https://pypi.org/project/meson/1.2.3/

Its SHA-256 hash can be checked vs 
https://pypi.org/project/meson/1.2.3/#copy-hash-modal-b6a34cf2-bd2f-4018-bfb0-b10d0fba8a3d

>> diff --git a/pythondeps.toml b/pythondeps.toml
>> index 0a35ebcf9f..a2f8c1980b 100644
>> --- a/pythondeps.toml
>> +++ b/pythondeps.toml
>> @@ -18,7 +18,7 @@
>>
>>   [meson]
>>   # The install key should match the version in python/wheels/
>> -meson = { accepted = ">=0.63.0", installed = "0.63.3", canary = "meson" }
>> +meson = { accepted = ">=1.2.3", installed = "1.2.3", canary = "meson" }
> 
> We don't need to block older versions of Meson, and indeed we don't
> want to because it's fine to use the distro package everywhere
> (including Sonoma).  (So the subject would become would be
> "buildsys: Bump known good meson version to v1.2.3).
> 
> You can look at sphinx below for another case where the accepted
> versions are much older than the installed one.
> 
> If there's anything you'd like to add to the (just sent) documentation
> to clarify this, please help.
> 
> Paolo
> 
>>
>>   [docs]
>>   sphinx = { accepted = ">=1.6", installed = "5.3.0", canary = "sphinx-build" }
> 



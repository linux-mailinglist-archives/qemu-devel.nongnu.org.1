Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEAB7EB2AF
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:43:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2ucq-00058K-Mh; Tue, 14 Nov 2023 09:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uco-00052B-8m
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:42:46 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2ucm-0000Cd-5T
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:42:45 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-54394328f65so8750687a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699972962; x=1700577762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HKVjdYLFOCZfZk9Pbmo/DUgg/DhEXvN6KIrzrSwtmZE=;
 b=y9OqSrFmXAYGvKJWeueoO5OzpSjk+oeEIe5M4aPBCbvIOCKtQqrpHHbP3fyIJgcp6V
 0CWMZByiaYLtrKhLgABPA1GWyr0cpgBw9GV/HUpcQv7NckXt32TV9wbEJoMFZvTmrwKt
 yMETG6NEJFAerkGW2CXqIRbbd22qx8x33Mw661jMMY/L8y8VrmLRxcUaHAsrbj6LryNh
 +ZdG8cltN09osOFcCzPeov3scUuEPtGZDgcQ6VmvKqu0W5znJvZiCB9FU+u9SBKjtzAW
 ET4Q+mASy4+bYfPPWm3qQ0xtJrqE9glRxIJzjLU1BZSPb5NMeQjGu+Sj/oZQa8kpIOcN
 bl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699972962; x=1700577762;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HKVjdYLFOCZfZk9Pbmo/DUgg/DhEXvN6KIrzrSwtmZE=;
 b=DN8msuFlDxBdqVwm/PI1nPKoQFZsC+9OWgpKZeCxFlk2tJKyVgg7IleHz5sARxSp0K
 G0hvD0eVTDyATr392vsmWVE9eEz2OPKQ88ZBh+hmT+GcU8p/MMyp7rgSRiDYttH776Wg
 bZDgQKgiDub0292GCn0UdcM/H9vr86MyBU5TwrieSta3ykWrNgOaMOoDlLEULz2c7he0
 2U3K6+Qv2XQIz6o88G4gsmirRoWbZJQPmwpO2wuAeP1B9vHWpdQujUmjC3L2y+OTCPsW
 SfR1iQsm63QtXAfq0WQE/OHZA838UiV5nfpjETQkN249LR7ETd5aj34YRAvmb+cHmGrg
 QoTQ==
X-Gm-Message-State: AOJu0YzimjqVVzny4a1iGtenJEjkvQxpzAT4IOYkIe/V/Vamb3T1yEYj
 N3LT5oqETn8ltagTsKh12Nbj3w==
X-Google-Smtp-Source: AGHT+IEtaJpI1MeBRr8Mea8GsJTm1iOrHuuVOdV5kTZQGJCcYoMf9ITDl6j3WqvV+yhiP/TmmsUgVw==
X-Received: by 2002:aa7:c6cc:0:b0:544:1fb7:d5e4 with SMTP id
 b12-20020aa7c6cc000000b005441fb7d5e4mr7419836eds.0.1699972962499; 
 Tue, 14 Nov 2023 06:42:42 -0800 (PST)
Received: from [192.168.69.100] (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 u27-20020a50c05b000000b0053de19620b9sm5318059edd.2.2023.11.14.06.42.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 06:42:42 -0800 (PST)
Message-ID: <9fc50c94-123c-414c-b074-9a742856a3ef@linaro.org>
Date: Tue, 14 Nov 2023 15:42:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado: Replace assertEquals() for Python 3.12
 compatibility
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>
References: <20231114134326.287242-1-thuth@redhat.com>
 <d3c8466c-9a41-4e03-b69f-28ff39aeafd8@linaro.org>
 <f589472f-de29-48df-8355-1a60de029d32@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f589472f-de29-48df-8355-1a60de029d32@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x533.google.com
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

On 14/11/23 15:21, Thomas Huth wrote:
> On 14/11/2023 15.10, Philippe Mathieu-Daudé wrote:
>> Hi Thomas,
>>
>> On 14/11/23 14:43, Thomas Huth wrote:
>>> assertEquals() has been removed in Python 3.12 and should be replaced by
>>> assertEqual(). See: https://docs.python.org/3.12/whatsnew/3.12.html#id3
>>
>>  From this list I see assertEquals() has been deprecated in 3.2, along
>> with assertRegexpMatches(). No warning for this single use?
>>
>> tests/avocado/version.py:25:        self.assertRegexpMatches(res, 
>> r'^(\d+\.\d+\.\d)')
>>
>> Otherwise,
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Thanks!
> 
> I still cannot run all avocado tests yet, so I didn't notice this problem
> yet.

At least you can run *some* tests :>

FYI macOS users still can't run QEMU's Avocado test suite.
Personally I run it somewhere in a cloud machine.

> But you're right, if I only run this test manually, it also fails.
> Care to send a patch, or want me to include it in my patch?

OK I'll send.

> Anyway, I'm seeing also failures here:
> 
>   tests/avocado/replay_kernel.py:ReplayKernelNormal.test_x86_64_pc: 
> INTERRUPTED
>   tests/avocado/reverse_debugging.py:ReverseDebugging_ppc64.test_ppc64_pseries: INTERRUPTED

Sometimes due to timeout.

>   tests/avocado/reverse_debugging.py:ReverseDebugging_ppc64.test_ppc64_powernv: ERROR

This one is concerning.

> Are these still working for you?
> (IIRC at least the replay_kernel test was also failing for me
> before I upgraded to Fedora 39, so it's likely not related to
> the new Python version)

Regards,

Phil.


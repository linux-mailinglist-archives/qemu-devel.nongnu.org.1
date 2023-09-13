Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9B479E454
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 11:55:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgMZ7-00054o-3s; Wed, 13 Sep 2023 05:53:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMZ4-00053p-67
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:53:42 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgMYz-0001OG-UB
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 05:53:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401d10e3e54so71630375e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 02:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694598815; x=1695203615; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qaJgnI2fNP+ifpLovg9oTPWy/V4ht/mQlruyfCQW8jQ=;
 b=ZgGGooEtLvZMBAL0SxvHQqMGBQ8wZACMXmtdDIp95EHbHjKsotQMhN20DcZcIiTtMr
 8wArGb3WiA1PwiszpAT9GHGilvLRSzIdMN+lFGe+BNf0VPqLieLy8peDLLK/O2TejkKC
 CVVwPLepDuOZGoy/gCU3i53j7rvh8d+Ny8wlb0Zw9zOC8sbCaVlrkCu9WtiZkC9Hoidh
 JBKOfNGf+67XdcIm/gVJNO0aLBIb0c3hoa/ePTpSzKnFPVWGaDPhhkexx7izmXq8AsBg
 Tsrfk0pKF8cUgt/N7oUtnLbTzC1Ss9Fmp3amxeLpyOsk87ktPS8+PIveFWOlvIOSoviW
 faGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694598815; x=1695203615;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qaJgnI2fNP+ifpLovg9oTPWy/V4ht/mQlruyfCQW8jQ=;
 b=tTjdzqHWNKtQDSjdmU02KVXwORaxEMhxsMb166XdYIMKmOO48V0+QtRX9r5dyZUUIE
 Klq3azB+0X5+6yJN+TdvY+mJvFbN0hUNDBTqXrKhAusekjr8tAM5VvqQWvypab7nWR4G
 aofuflvk0sQfs3DnqyXZ+sQ5yAquj46bWjcq2SATsqi4trKwIx/sifav9OuwzrEzINDe
 8xBNb7sUmLQFBXhcWH/2L3FottXTAgxrO2mWOi5wFWoPlEYHKmwI7l/GFTCes6w6lCmi
 6kr8vgWEJz3oAQpPeAtD+q7OBkKgPKwxMVSG0lYSCriSVJunxdaW7/JaBhFJXV3sAl5u
 ZtmQ==
X-Gm-Message-State: AOJu0Yy6Yj3WK9VjtbVdGFw7NztqlVXEBjN6TXalNaHP1u8qnCOqLmlI
 74BUdHM7e+/kVIKLGpg5Aea53g==
X-Google-Smtp-Source: AGHT+IE0VrgeqFKP/GROgRbuk+yrrpX48cV0/vEWXSFFnUk4hFGLqO0uMoWiQf5EUo7r1K9xMQLy0A==
X-Received: by 2002:a1c:7703:0:b0:401:cf0d:25ca with SMTP id
 t3-20020a1c7703000000b00401cf0d25camr1628026wmi.40.1694598815340; 
 Wed, 13 Sep 2023 02:53:35 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 v9-20020a1cf709000000b003feeb082a9fsm1551011wmh.3.2023.09.13.02.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 02:53:34 -0700 (PDT)
Message-ID: <038e675f-7075-8dee-1d2d-584b410081d1@linaro.org>
Date: Wed, 13 Sep 2023 11:53:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 0/4] ci: fix hang of FreeBSD CI jobs
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20230912184130.3056054-1-berrange@redhat.com>
 <5cbb92ab-f8b5-4d03-5698-06d0a0b7cfda@redhat.com> <87ledatq3s.fsf@linaro.org>
 <2a8bc661-5fb0-f514-3ae5-4c6c9acb935f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <2a8bc661-5fb0-f514-3ae5-4c6c9acb935f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 13/9/23 11:02, Thomas Huth wrote:
> On 13/09/2023 10.48, Alex Bennée wrote:
>>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>>> On 12/09/2023 20.41, Daniel P. Berrangé wrote:
>>>> This addresses
>>>>     https://gitlab.com/qemu-project/qemu/-/issues/1882
>>>> Which turned out to be a genuine flaw which we missed during merge
>>>> as the patch hitting master co-incided with the FreeBSD CI job
>>>> having an temporary outage due to changed release image version.
>>>> Daniel P. Berrangé (4):
>>>>     microbit: add missing qtest_quit() call
>>>>     qtest: kill orphaned qtest QEMU processes on FreeBSD
>>>>     gitlab: make Cirrus CI timeout explicit
>>>>     gitlab: make Cirrus CI jobs gating
>>>>    .gitlab-ci.d/cirrus.yml       | 4 +++-
>>>>    .gitlab-ci.d/cirrus/build.yml | 2 ++
>>>>    tests/qtest/libqtest.c        | 7 +++++++
>>>>    tests/qtest/microbit-test.c   | 2 ++
>>>>    4 files changed, 14 insertions(+), 1 deletion(-)
>>>>
>>>
>>> Series
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>
>>> Alex, will you pick these up or shall I take them for my next PR?
>>
>> Queued to testing/next, thanks.
>>
>> Do you have a patch to disable the borked avacado tests? Or maybe I
>> should just include Philippe's fix?

As we discussed with Richard yesterday, the fix is not correct.

> I thought that Philippe mentioned that he wanted to provide a patch that 
> disables the broken tests?

Yes, I'm still discussing a bit more on the other thread:
https://lore.kernel.org/all/4e335f86-d075-4cc0-af5a-9dca9b3bf261@linaro.org/



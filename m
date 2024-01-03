Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BD58229F0
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 10:09:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKxEd-00067j-Ra; Wed, 03 Jan 2024 04:08:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKxEM-000670-TZ
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 04:08:07 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKxEJ-0001Mf-NW
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 04:08:05 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33694bf8835so8642795f8f.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jan 2024 01:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704272882; x=1704877682; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kddLE5JKCGU9j3eVdLqxBGlDZb8ajWq0Q9Bk1qRSMl4=;
 b=PLVRy2yyXvu+VDI4WavopNHKE4LJCYcCTLKuEAzBHMpr7JtrzlrokhEDcXJAsMM9yP
 BHqAoGzdfY270Luxc+b3JEK5oeoK8JCIXVLJtnGDomySx8QVFMgBQbDfThWqKoq86QsU
 9aJ4FBKJDYYzH9y7nVR9Ku6vPb5ld5mffCECvmW2q2bT+PMEwD0/PR5r6EAcKpxAm0iu
 kAQ0lheV9e4zVMR1lRH+vX9pFai9xz23UccLpZUZ0mJxxtRAFmNmA7riqVOVjnaNPJ6J
 Ofy9ZjbliCrkTPMDLr0cxW/oxGmGGRJqpaAn+held0jJm7XbhqbNg6FNiy3J+gHYREH/
 lH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704272882; x=1704877682;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kddLE5JKCGU9j3eVdLqxBGlDZb8ajWq0Q9Bk1qRSMl4=;
 b=oevKdSpodg78oq+TYlXmD/pZ3tuYhuLPh+fzsyJuP6hpA+TBYMDEUUvgXbzG8OuwiF
 Xy4sJgQ3bFMYrKbtaeF+4IwYX2fC0ItDCys623eDwgTxFObJ6fA4Fnjbdnp9Tbr6RuPY
 z4TRoV5IxuWTgrZy9tVOJ2JdWKPd4kqsslE2msdCm2TkO4u2MHQPked2/iZwqkhEYvcu
 PFsjbmXAIqSbPQJ/MgR2ZI1FuO8eg/OidQ/Wg4QTIPn7jcZibmqlSXAVq8+CVWR7kS1D
 sSnmvXHn9QEFgVF8OOxMIejUY5EJDA+PrwevMSwsp8u0YoB3P++aPoKMU38XEgN0pbfL
 1vUw==
X-Gm-Message-State: AOJu0YwOOIAgAdtNQSAyOnzoiPddUUyV+4NmZRZAZ2GCpcWd2BaqoliT
 DaTsNkLMM5yOA0a64+tGbJhJrx1u1U9K5g==
X-Google-Smtp-Source: AGHT+IEuROR3ntialr7KsmxFgBXAEE5ZEkZdMUi/szyKGvEh2yDcKSqO8H0nxDUQgzG7gwUE3PZtAQ==
X-Received: by 2002:adf:f306:0:b0:336:1fcf:5aec with SMTP id
 i6-20020adff306000000b003361fcf5aecmr9875073wro.55.1704272881844; 
 Wed, 03 Jan 2024 01:08:01 -0800 (PST)
Received: from [192.168.69.100] (tre93-h02-176-184-7-144.dsl.sta.abo.bbox.fr.
 [176.184.7.144]) by smtp.gmail.com with ESMTPSA id
 c2-20020adffb42000000b003372095b2ddsm12483162wrs.105.2024.01.03.01.08.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 01:08:01 -0800 (PST)
Message-ID: <37057f38-5326-48e2-9646-b356f13da11e@linaro.org>
Date: Wed, 3 Jan 2024 10:07:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] tests/lcitool: Refresh generated files
Content-Language: en-US
To: Ilya Maximets <i.maximets@ovn.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Erik Skultety <eskultet@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ed Maste <emaste@freebsd.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Kyle Evans <kevans@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Beraldo Leal <bleal@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20230711144922.67491-1-philmd@linaro.org>
 <20230711144922.67491-3-philmd@linaro.org> <ZK2YS0v5G3iKyXwJ@redhat.com>
 <41ae7db7-8d80-1749-c89d-025ee30bd73d@linaro.org>
 <ZK6Kn8hB8soQBRsA@redhat.com>
 <30d49562-451e-b4c6-679e-0f8d1e0abe72@linaro.org>
 <ZK6lhY5H/XRqukgU@redhat.com>
 <eb9bb489-d79a-4aa1-951e-b0c7e97313dc@linaro.org>
 <ecdc0f06-a7b2-49ac-a3f4-536f91b80b92@ovn.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ecdc0f06-a7b2-49ac-a3f4-536f91b80b92@ovn.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 2/1/24 19:36, Ilya Maximets wrote:
> On 1/2/24 19:19, Philippe Mathieu-Daudé wrote:
>> On 12/7/23 15:07, Daniel P. Berrangé wrote:
>>> On Wed, Jul 12, 2023 at 02:55:10PM +0200, Philippe Mathieu-Daudé wrote:
>>>> On 12/7/23 13:12, Daniel P. Berrangé wrote:
>>>>> On Wed, Jul 12, 2023 at 01:00:38PM +0200, Philippe Mathieu-Daudé wrote:
>>>>>> On 11/7/23 19:58, Daniel P. Berrangé wrote:
>>>>>>> On Tue, Jul 11, 2023 at 04:49:20PM +0200, Philippe Mathieu-Daudé wrote:
>>>>>>>> Refresh the generated files by running:
>>>>>>>>
>>>>>>>>       $ make lcitool-refresh
>>>>>>>>
>>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>>> ---
>>>>>>>>      tests/docker/dockerfiles/debian-amd64.docker |  2 -
>>>>>>>>      tests/docker/dockerfiles/ubuntu2004.docker   |  2 -
>>>>>>>>      tests/docker/dockerfiles/ubuntu2204.docker   |  2 -
>>>>>>>
>>>>>>> I don't know why this would be removing xen/pmem from these files. If
>>>>>>> I run 'lcitool-refresh' on current git master that doesn't happen
>>
>> FTR since commit cb039ef3d9 libxdp-devel is also being changed on my
>> host, similarly to libpmem-devel, so I suppose it also has some host
>> specific restriction.
> 
> Yeah, many distributions are not building libxdp for non-x86
> architectures today.  There are no real reasons not to, but
> they just do not, because the package is relatively new.  It
> will likely become available in the future.
> 
> I see this thread is a bit old.  Was a solution found for the
> pmem/xen?  i.e. do I need to do something specific for libxdp
> at this point?

Maybe this is tracked in this issue?
https://gitlab.com/libvirt/libvirt-ci/-/issues/30

Otherwise libvirt/lcitool maintainers are Cc'ed :)

> Best regards, Ilya Maximets.
> 
>>
>>>>>>> Do you have any other local changes on top ?
>>>>
>>>> (I just noticed manually updating the libvirt-ci submodule is
>>>>    pointless because the 'lcitool-refresh' rule does that)
>>>>
>>>>>> diff --git a/tests/docker/dockerfiles/ubuntu2204.docker
>>>>>> b/tests/docker/dockerfiles/ubuntu2204.docker
>>>>>> index 1d442cdfe6..5162927016 100644
>>>>>> --- a/tests/docker/dockerfiles/ubuntu2204.docker
>>>>>> +++ b/tests/docker/dockerfiles/ubuntu2204.docker
>>>>>> @@ -73 +72,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>>>>> -                      libpmem-dev \
>>>>>> @@ -99 +97,0 @@ RUN export DEBIAN_FRONTEND=noninteractive && \
>>>>>> -                      libxen-dev \
>>>>>
>>>>> What architecture are you running from ? I'm suspecting it is a non
>>>>> x86_64 architecture as these pacakges are both arch conditionalized.
>>>>
>>>> My host is Darwin aarch64, but how is this relevant to what we
>>>> generate for guests? Are we missing specifying the target arch
>>>> somewhere? (This is not the '--cross-arch' argument, because we
>>>> don't want to cross-build). These dockerfiles always targeted x86_64,
>>>> in particular the debian-amd64.docker one...
>>>
>>> This is an unfortunate design choice of lcitool.
>>>
>>> If you give '--cross-arch' it will always spit out the dockerfile
>>> suitable for cross-compiling to that arch.
>>>
>>> If you omit '--cross-arch' it will always spit out the dockerfile
>>> suitable for compiling on the *current* host arch.
>>>
>>> When we're committing the dockerfiles to qemu (or any libvirt project
>>> using lcitool), we've got an implicit assumption that the non-cross
>>> dockerfiles were for x86_64, and hence an implicit assumption that
>>> the person who ran 'lcitool' was also on x86_64.
>>>
>>> This is clearly a bad design choice mistake in retrospect as people
>>> are increasingly likely to be using aarch64 for day-to-day dev work.
>>>
>>> So I guess we need to come up with a more explicit way to say give
>>> me a native container for x86_64.
>>>
>>> With regards,
>>> Daniel
>>
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AF0A39D43
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Feb 2025 14:21:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkNWm-0007lk-2F; Tue, 18 Feb 2025 08:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkNWg-0007lJ-Pj
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 08:20:39 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkNWe-00065Y-S6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 08:20:38 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38f29a1a93bso3497996f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 05:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739884835; x=1740489635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vC3MmtES1R3kkG1nVWHLeiRBuKWybO9xGwH1FF01u2M=;
 b=dmULQ4Yz1rXh73V2ziPqQ33nOVzOWPYFclw4noD7lQFEapYR70qEwDhtZyPoqBi1aB
 bBbblfskZpR9LahK3q7K/WoGIJtUy5+pgRMAsOuq0rRaTMdHcMSTTEC4gMRftTo5sqLP
 r8D7UKylKILUtXIQc9vEB7YptsmShkz4ZxP4KmEXxfL7Jys3pHT+8TnYtOzs7ovXpxSq
 nP8fsn8HyNy1tXUnW4p5YtO7FaZMRAXAOBuwOsnN2cCiQ36UL6OQFQSNLhGaqwun7NS+
 A7gk23jg2FIUjiFalglyhMhG/gEGNbWSlYHlbISBkX8LUcfBycK2Jd5/8qx8KWk5PlPF
 XXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739884835; x=1740489635;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vC3MmtES1R3kkG1nVWHLeiRBuKWybO9xGwH1FF01u2M=;
 b=Y0x7iHZICZRiDUqwr94I3z1B7DVXVHE8dSC7iaTCISLwu7/aylt7ghYeyLy/uMSosF
 BICosf6wnNKngNhsnmhG85qtqUH21Q8PpuBKG5usNlHZeB9DEspUDmD8rLAmj9zt7qrP
 7Xc6KJVA+o3gLgP6aOQMofbmxqBHosKMLzv0y4XKFP+lYVl6kcrKi0YsokfrMlID0p6y
 gqMpoy5C6mWCk9vHswKZG+ygY0NWJq8ma07aL7pEuIvhZ51kWVPfo2GBekM3PMCy279j
 WN4DESNeivxB4YrS7zpKj4ZdWpBh71IrOY+8eZNUnedgys7/oVLYUP/J6x3PBJEwwZ0l
 S7cA==
X-Gm-Message-State: AOJu0YyZWHQBlXV/rpxavpLvG478+Mip9chO1ridRx++W1K2Ugern0di
 pm9YoC3ULueqgz+XJE4hZy+A0zbujSpHlKZxeP/ObYRC5SETzmC130aMzEXoGoSnkoi0bqhXisr
 UBKk=
X-Gm-Gg: ASbGncuF4lRuUcqIhOjcw+E27S7pgaQBC2gThccb6uVU7R1VbAy0uw9BWA61nxG5eZ8
 aIK6mxylrUfoTxG6FGlOXrVuTUbfE7KcDuyK40Tdj0Tyit80ux0ZNaZwaInHRrj39zGAlmMOf2/
 xgI9LPd5QaV52fmexWGFfYtLmA1n4WjSzC4wpH9Pb1QpnZWuQDdWEXM7rRPuEaL0dVoOjhVjluT
 U+h++LkzvasWIgLCVJLxheTOdUDzhOGGSWWnA4WDihVbEaxm/eeaNIh5a17otEZ9mokOmKmW6JM
 9Wdpvq4wetO1w5XJGGX+1XacMqqv9QpcSyUhKbSoU2l8FudpobJz+0ex7Cg=
X-Google-Smtp-Source: AGHT+IForCtadydOvVhTNjd9ECIey58DSMhrG0QgWU5N7F/lu9Reb+pwn3DxvYQ/N+/It+4SLbTErg==
X-Received: by 2002:a05:6000:156c:b0:38f:2ddd:a1bb with SMTP id
 ffacd0b85a97d-38f33f10603mr11940369f8f.8.1739884834689; 
 Tue, 18 Feb 2025 05:20:34 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1b824dsm181005315e9.34.2025.02.18.05.20.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 05:20:33 -0800 (PST)
Message-ID: <2691328e-09db-496f-975a-c4f61e358f92@linaro.org>
Date: Tue, 18 Feb 2025 14:20:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/9] meson: Disallow 64-bit on 32-bit Xen emulation
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org, David Woodhouse <dwmw2@infradead.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 Paul Durrant <paul@xen.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250208205725.568631-1-richard.henderson@linaro.org>
 <20250208205725.568631-4-richard.henderson@linaro.org>
 <aeaf0f19-0f14-4a02-9c51-09521e7c75e1@linaro.org>
 <dc24cf43-b6a1-42b6-ac93-4128f2c03684@linaro.org>
Content-Language: en-US
In-Reply-To: <dc24cf43-b6a1-42b6-ac93-4128f2c03684@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 18/2/25 14:19, Philippe Mathieu-Daudé wrote:
> On 18/2/25 12:20, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> Adding Xen community.
>>
>> On 8/2/25 21:57, Richard Henderson wrote:
>>> Require a 64-bit host binary to spawn a 64-bit guest.
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   meson.build | 9 +++++++--
>>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/meson.build b/meson.build
>>> index 1af8aeb194..911955cfa8 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -304,9 +304,14 @@ else
>>>   endif
>>>   accelerator_targets = { 'CONFIG_KVM': kvm_targets }
>>> -if cpu in ['x86', 'x86_64']
>>> +if cpu == 'x86'
>>> +  xen_targets = ['i386-softmmu']
>>> +elif cpu == 'x86_64'
>>>     xen_targets = ['i386-softmmu', 'x86_64-softmmu']
>>> -elif cpu in ['arm', 'aarch64']
>>> +elif cpu == 'arm'
>>> +  # i386 emulator provides xenpv machine type for multiple 
>>> architectures
>>> +  xen_targets = ['i386-softmmu']
>>
>> Is actually someone *testing* this config? I'm having hard time building
>> it, so am very suspicious about how it runs, and start to wonder if I'm
>> not just wasting my time (as could be our CI).
> 
> This config is not tested and not functional. I'll post a patch
> removing it.

(thus no need to follow the deprecation policy).

> 
>>
>>> +elif cpu == 'aarch64'
>>>     # i386 emulator provides xenpv machine type for multiple 
>>> architectures
>>>     xen_targets = ['i386-softmmu', 'x86_64-softmmu', 'aarch64-softmmu']
>>>   else
>>
>> Regards,
>>
>> Phil.
>>
> 



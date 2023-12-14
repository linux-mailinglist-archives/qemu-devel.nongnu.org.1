Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73017812BE3
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 10:43:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDiE6-0005Wd-2d; Thu, 14 Dec 2023 04:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDiE4-0005WH-Ae
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 04:41:52 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rDiE2-00039y-KV
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 04:41:52 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2cc4029dc6eso10096431fa.1
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 01:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702546908; x=1703151708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zaSv1cEVN2/csDxZcQM7dUaN1yjFhAc0bctNu6GYJ2s=;
 b=tZk6fUsqSlCv9v9AsjxCsd7vmrkFLPNa9hhdFKdj6p7OsoVBMFn9aP/HivRWmYP2pX
 rL2qzOAaGbiUutqDq5nNUibKMMAPjX6YgihvBkx7s3zC2Kg4gMB9kcWYZsG/PEIaPDe4
 wvqWI89HvMwCqXdxJTpR6TqU6TqGm5Az2za3sfsXfScj9+Y94cBIf5JaG8lxcw91CcWo
 3oJFuEZ9loTBWgQEFI81EyicOK58/w+rZHGhMV4vElyrrytTk502pEaytUclwVwf0HZj
 Nq0sVIrdsfYjlYX5XkRCUI61fdoUraHqmWcmeosiXWM4SdNwp+ym20L79PGjxKj6J4HP
 P1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702546908; x=1703151708;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zaSv1cEVN2/csDxZcQM7dUaN1yjFhAc0bctNu6GYJ2s=;
 b=vfYPlhZsDe/skgZmQsQ4BrLWDtzdcC4WHPDHueJmAJdsc6rf+xnHZ/Z/VljbPZcigT
 Iol+KRAGP8oDSW9qYA2UdG6kFHBuNjOUVV+r1P/E6EqFQ7+Ruk0H1kxOafMjEIyKkaQD
 D3sOmbm4ZhwP49t9lZeGBMd0HFfNjBXjfZtnH7ByEGvQ1WgO9BM5mj3BMgTjyWVylDaR
 +GLU9vP/vvJPJ88qNitNdyykmSiLUmZRAtSCvLK6S/KGXb7QTNhCpNnRgXnDhvkCURy6
 hMIg8UP5m9jpF2R1TnO2EKapwL/om5m5LtUHM3eyqqC+Ayh4GfGHi985MZn+4ETsazuu
 ziOg==
X-Gm-Message-State: AOJu0Yy21i+sMPIeIGzMpKS4U4uIOKXMoeRTN0ZUCS1pGbi/TkQg26g5
 QaarGyrEDxRfxty9l6/FdZQhxA==
X-Google-Smtp-Source: AGHT+IFUBdWXX+JjH2ebUgEKb8xFppKiJlOwr5a/u/5abODSqBse2b+tPHKVziGzfogMCqlZTYoGag==
X-Received: by 2002:a05:651c:2108:b0:2cb:2b10:ee96 with SMTP id
 a8-20020a05651c210800b002cb2b10ee96mr4475815ljq.3.1702546908237; 
 Thu, 14 Dec 2023 01:41:48 -0800 (PST)
Received: from [192.168.199.175] ([93.23.249.68])
 by smtp.gmail.com with ESMTPSA id
 m29-20020a50999d000000b0054cc903baadsm6855403edb.30.2023.12.14.01.41.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Dec 2023 01:41:47 -0800 (PST)
Message-ID: <25c403f3-349a-4c4e-8470-2721881b442e@linaro.org>
Date: Thu, 14 Dec 2023 10:41:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] tests/avocado/intel_iommu.py: increase timeout
Content-Language: en-US
To: eric.auger@redhat.com, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-4-crosa@redhat.com> <8734w8fzbc.fsf@draig.linaro.org>
 <87sf45vpad.fsf@p1.localdomain>
 <6140fc8a-4044-4891-854d-9bf555c5dd78@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6140fc8a-4044-4891-854d-9bf555c5dd78@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x229.google.com
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

On 14/12/23 08:24, Eric Auger wrote:
> Hi Cleber,
> 
> On 12/13/23 21:08, Cleber Rosa wrote:
>> Alex Bennée <alex.bennee@linaro.org> writes:
>>
>>> Cleber Rosa <crosa@redhat.com> writes:
>>>
>>>> Based on many runs, the average run time for these 4 tests is around
>>>> 250 seconds, with 320 seconds being the ceiling.  In any way, the
>>>> default 120 seconds timeout is inappropriate in my experience.
>>> I would rather see these tests updated to fix:
>>>
>>>   - Don't use such an old Fedora 31 image
>> I remember proposing a bump in Fedora version used by default in
>> avocado_qemu.LinuxTest (which would propagate to tests such as
>> boot_linux.py and others), but that was not well accepted.  I can
>> definitely work on such a version bump again.
>>
>>>   - Avoid updating image packages (when will RH stop serving them?)
>> IIUC the only reason for updating the packages is to test the network
>> from the guest, and could/should be done another way.
>>
>> Eric, could you confirm this?
> Sorry for the delay. Yes effectively I used the dnf install to stress
> the viommu. In the past I was able to trigger viommu bugs that way
> whereas getting an IP @ for the guest was just successful.

Maybe this test is useful as what Daniel described as "Tier 2" [*],
that maintainers run locally but don't need to be gating CI? That
would save us some resources there.

[*] https://lore.kernel.org/qemu-devel/20200427152036.GI1244803@redhat.com/

>>
>>>   - The "test" is a fairly basic check of dmesg/sysfs output
>> Maybe the network is also an implicit check here.  Let's see what Eric
>> has to say.
> 
> To be honest I do not remember how avocado does the check in itself; my
> guess if that if the dnf install does not complete you get a timeout and
> the test fails. But you may be more knowledged on this than me ;-)
> 
> Thanks
> 
> Eric



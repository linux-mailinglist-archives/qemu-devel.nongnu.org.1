Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D97CA14A
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 10:09:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsIe2-0001gD-QL; Mon, 16 Oct 2023 04:08:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qsIdx-0001em-SR
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:08:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qsIdv-0003j2-MX
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 04:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697443681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8y5z/3PDI0GIlDQupp0X6VMjE3DLd1Ivx90GwKrOSsY=;
 b=UgZpE3aniLMj/X3DnxyLELI6CuR/JQzsVbrwiWYiwH1iuIg9gqXqVZpb5knHD1qh8fe6tL
 BV6h6pbitzf34N2KjIuFsW4cPSOOQzO2q1paYXJJevs/93mf2esgw/n0pgTusaWbtzT0VJ
 e/eO9xwDh3pzpmYTZdxdvpLyYjogfuk=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-F1AwFmS7Mey_Tr4LythDOQ-1; Mon, 16 Oct 2023 04:08:00 -0400
X-MC-Unique: F1AwFmS7Mey_Tr4LythDOQ-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-457d00df345so667088137.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 01:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697443680; x=1698048480;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8y5z/3PDI0GIlDQupp0X6VMjE3DLd1Ivx90GwKrOSsY=;
 b=AYh3vhn+YTTdLxs0Str/ZAS2YykvRVv3d8YhTRLPoFxhU8x1CJcpvbFbKqoPCM0At1
 AlVne5e6CL0doYgtvJJM084D09NT+61VU3ZVHIWzbXNU7Ko+6MJXbGa/wL7XCBCEAd4J
 CgocZaApiLJCXNo/OaYknLnAWnDuxBrZZPFHxwOM5EuhbXklDD5vXpSqG0Uq6tElnh7y
 mDtjapwDetpEEbGUzHrahM4a4PohYVwPNpUAceSTqPO1S0Bw7CuY/aVVYfFiEtoR7kNj
 YjyN1zpdFccw+l87vMTal17BhCeG+RsISFL+D9a4ImYFBoc6II/Nw6UbjeEN2PbMoIS8
 +gHA==
X-Gm-Message-State: AOJu0YzBuuXgZpVIkEPiWokwIfeLhrx3dRj6jE/ANYkOfMdHSbijkoJE
 8rhtPGviQfSrw7ENgwIyrDZ7eDlOR/Ka2eouR9DZxY2fh9MZfI1ivPm/XifRNxa8nNSnUWrxqsd
 nkGhYCmFSA0e5FCs=
X-Received: by 2002:a05:6102:34f1:b0:44e:8353:e86a with SMTP id
 bi17-20020a05610234f100b0044e8353e86amr25247783vsb.24.1697443679927; 
 Mon, 16 Oct 2023 01:07:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsg4wyEZU/+kZLana8+BTuCIBvrQ5+0Kph77JlFx5fbMg5foHBUBRjTcrB4VNBDxEsrOLZPA==
X-Received: by 2002:a05:6102:34f1:b0:44e:8353:e86a with SMTP id
 bi17-20020a05610234f100b0044e8353e86amr25247771vsb.24.1697443679638; 
 Mon, 16 Oct 2023 01:07:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 px10-20020a056214050a00b00655ec7bbfd0sm3216312qvb.7.2023.10.16.01.07.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 01:07:59 -0700 (PDT)
Message-ID: <87a6cd87-6987-4d75-98a4-1a318b4100a3@redhat.com>
Date: Mon, 16 Oct 2023 10:07:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 05/11] testing/avocado: ppc add new BookE
 boot_linux_console.py tests
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: qemu-ppc@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-6-npiggin@gmail.com>
 <CACPK8XcS05gQemgRKFTvhAaQzDLg+5MKH0sVyuU=pOs=Oo_=SA@mail.gmail.com>
 <CW522VQRHMHA.3DKAX1WTT3YAX@wheely>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <CW522VQRHMHA.3DKAX1WTT3YAX@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/10/23 22:53, Nicholas Piggin wrote:
> On Tue Oct 10, 2023 at 10:03 PM AEST, Joel Stanley wrote:
>> On Tue, 10 Oct 2023 at 18:23, Nicholas Piggin <npiggin@gmail.com> wrote:
>>>
>>> Add simple Linux kernel boot tests for BookE 64-bit and 32-bit CPUs
>>> using Guenter Roeck's rootfs images for Linux testing, and a gitlab
>>> repository with kernel images that I built since there are very few
>>> sources of modern BookE images now.
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>
>> Reviewed-by: Joel Stanley <joel@jms.id.au>
>>
>> Should we get mpe to add a https://github.com/linuxppc/qemu-ci-images
>> for you to keep those kernel images? But perhaps you'd prefer to keep
>> them on gitlab. Just a suggestion.
> 
> Not a bad idea. Or we could try for gitlab/qemu/ci-images I suppose.

Feel free to take these :

   https://github.com/legoater/qemu-ppc-boot/tree/main/buildroot

Supported machines

     prep/ppc 604 CPU
     ref405ep/ppc 405EP CPU
     bamboo/ppc 440EP CPU
     sam460ex/ppc 460EX CPU (equivalent to a 440)
     g3beige/ppc G3 CPU
     mac99/ppc G4 CPU
     e500mc/ppc e500mc CPU
     mpc8544ds/ppc e500v2 CPU
     ppce500/ppc64 e5500, e6500
     mac99/ppc64 970 CPU with 64bit and 32bit user space
     pseries/ppc64 POWER5+, 970, 970MP, POWER7
     pseries/ppc64le POWER8, POWER9, POWER10
     powernv8/ppc64le POWER8 HV CPU
     powernv9/ppc64le POWER9 HV CPU

Thanks,

C.


> 
>>
>>> ---
>>>   tests/avocado/boot_linux_console.py | 53 +++++++++++++++++++++++++++++
>>>   1 file changed, 53 insertions(+)
>>>
>>> diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
>>> index 9434304cd3..dc3346ef49 100644
>>> --- a/tests/avocado/boot_linux_console.py
>>> +++ b/tests/avocado/boot_linux_console.py
>>> @@ -1355,6 +1355,59 @@ def test_ppc64_e500(self):
>>>           tar_hash = '6951d86d644b302898da2fd701739c9406527fe1'
>>>           self.do_test_advcal_2018('19', tar_hash, 'uImage')
>>>
>>> +    def test_ppc64_e6500(self):
>>> +        """
>>> +        :avocado: tags=arch:ppc64
>>> +        :avocado: tags=machine:ppce500
>>> +        :avocado: tags=cpu:e6500
>>> +        :avocado: tags=accel:tcg
>>> +        """
>>> +        kernel_url = ('https://gitlab.com/npiggin/qemu-ci-images/-/raw/main/ppc/corenet64_vmlinux?ref_type=heads&inline=false')
>>
>> Is the ref_type?heads=inline-false required? I seem to get the file
>> successfully with wget and those omitted.
> 
> I just copied the download link, so if it works without then
> I'll remove it.
> 
> Thanks,
> Nick
> 



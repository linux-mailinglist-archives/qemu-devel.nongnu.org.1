Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8569813195
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 14:28:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDlkN-00031I-L8; Thu, 14 Dec 2023 08:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rDlkA-0002yf-Hr
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 08:27:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rDlk6-0000Iq-1B
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 08:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702560418;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IFAffqF6CJ5tF413gWMsZUdS3F+1RarOrkMLNThRh2g=;
 b=GqvEvrjvJuMDkdpJuXxHqMm7sAGEnMwGezEi2GbVQoJQEj/l3LvwJH1LElI37cNTcWopNZ
 ib6ctG5eUGDx40I/JWP86JI549Ah6Ee/AggyBRQV9BHp4M52DFeNhL3dAceNoKZqtd+2zs
 vgGoXt8z+iKlK6ziO1aAQum5KcT3EWA=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-IRG5-jfoNRK2-gc9uXltkA-1; Thu, 14 Dec 2023 08:26:56 -0500
X-MC-Unique: IRG5-jfoNRK2-gc9uXltkA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3b9d731fd1bso12494334b6e.1
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 05:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702560416; x=1703165216;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IFAffqF6CJ5tF413gWMsZUdS3F+1RarOrkMLNThRh2g=;
 b=CIm7fkbndLiHJqKROcW95qp6uMufUb5b565iZ0OwB/4SI1WAIyhcaYL1hmHDyoEkXN
 Jq5Axg4h8g5et8pKfYxnr++OyM0QxyMifLbSh69GhOuScN0InHLLLRhoLK757JlPUg0j
 FNyR+SqdgrJYJ/NX0h5RdavbALSlyTG9BJlX15v99FO34a5IpXD0us9ajWKEyudEPwfZ
 /ZS3Iq9tFC9Yvwxv8fpkkuvYa71Dp6ZPHnWNZtGDIHfct0ausjAGATYoCoMxnZVYlcui
 +4wZhwptpwW86Vt8IEfsFdbU/ApjdueyhCuTyTVHx22aQzb1ijzQCFFrJyU9fqxi3Ryx
 FKjg==
X-Gm-Message-State: AOJu0YywOs2mSMInz8i+DUm/wBuuE7vsmUz3D8Vtjeh5G0qdpXckBJ7K
 K4CUuDkORYH6WYx0XA+/WAlSGdR1nQ5ECNfc0mVkYeaO+nvvfp5FTZI/CP7+IX+KbEsZs5AcDWg
 iQNJPOfm40UJk9NQ=
X-Received: by 2002:a05:6808:15a0:b0:3b8:8f56:1528 with SMTP id
 t32-20020a05680815a000b003b88f561528mr12655511oiw.59.1702560415811; 
 Thu, 14 Dec 2023 05:26:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6A0o6LtxHVOtyd6bLE1stOm98A3AEhVYosXAG/J+EBuGTbNiQGBFRYQUwTAT43kL/SCrf1A==
X-Received: by 2002:a05:6808:15a0:b0:3b8:8f56:1528 with SMTP id
 t32-20020a05680815a000b003b88f561528mr12655487oiw.59.1702560415543; 
 Thu, 14 Dec 2023 05:26:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 m19-20020ae9e013000000b0076db5b792basm5271768qkk.75.2023.12.14.05.26.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Dec 2023 05:26:54 -0800 (PST)
Message-ID: <9e96236b-4346-434c-8e5e-3cc8fb60c32a@redhat.com>
Date: Thu, 14 Dec 2023 14:26:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] tests/avocado/intel_iommu.py: increase timeout
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Radoslaw Biernacki
 <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-4-crosa@redhat.com> <8734w8fzbc.fsf@draig.linaro.org>
 <87sf45vpad.fsf@p1.localdomain>
 <6140fc8a-4044-4891-854d-9bf555c5dd78@redhat.com>
 <878r5x9l4b.fsf@draig.linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <878r5x9l4b.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 12/14/23 10:41, Alex Bennée wrote:
> Eric Auger <eric.auger@redhat.com> writes:
>
>> Hi Cleber,
>>
>> On 12/13/23 21:08, Cleber Rosa wrote:
>>> Alex Bennée <alex.bennee@linaro.org> writes:
>>>
>>>> Cleber Rosa <crosa@redhat.com> writes:
>>>>
>>>>> Based on many runs, the average run time for these 4 tests is around
>>>>> 250 seconds, with 320 seconds being the ceiling.  In any way, the
>>>>> default 120 seconds timeout is inappropriate in my experience.
>>>> I would rather see these tests updated to fix:
>>>>
>>>>  - Don't use such an old Fedora 31 image
>>> I remember proposing a bump in Fedora version used by default in
>>> avocado_qemu.LinuxTest (which would propagate to tests such as
>>> boot_linux.py and others), but that was not well accepted.  I can
>>> definitely work on such a version bump again.
>>>
>>>>  - Avoid updating image packages (when will RH stop serving them?)
>>> IIUC the only reason for updating the packages is to test the network
>>> from the guest, and could/should be done another way.
>>>
>>> Eric, could you confirm this?
>> Sorry for the delay. Yes effectively I used the dnf install to stress
>> the viommu. In the past I was able to trigger viommu bugs that way
>> whereas getting an IP @ for the guest was just successful.
>>>>  - The "test" is a fairly basic check of dmesg/sysfs output
>>> Maybe the network is also an implicit check here.  Let's see what Eric
>>> has to say.
>> To be honest I do not remember how avocado does the check in itself; my
>> guess if that if the dnf install does not complete you get a timeout and
>> the test fails. But you may be more knowledged on this than me ;-)
> I guess the problem is relying on external infrastructure can lead to
> unpredictable results. However its a lot easier to configure user mode
> networking just to pull something off the internet than have a local
> netperf or some such setup to generate local traffic.
>
> I guess there is no loopback like setup which would sufficiently
> exercise the code?

I don't think so. This test is a reproducer for a bug I encountered and
fixed in the past.
Besudes, I am totally fine moving the test out of the gating CI and just
keep it as a tier2 test, as suggested by Phil.

Thanks

Eric
>
>> Thanks
>>
>> Eric
>>>> I think building a buildroot image with the tools pre-installed (with
>>>> perhaps more testing) would be a better use of our limited test time.
>>>>
>>>> FWIW the runtime on my machine is:
>>>>
>>>> ➜  env QEMU_TEST_FLAKY_TESTS=1 ./pyvenv/bin/avocado run ./tests/avocado/intel_iommu.py
>>>> JOB ID     : 5c582ccf274f3aee279c2208f969a7af8ceb9943
>>>> JOB LOG    : /home/alex/avocado/job-results/job-2023-12-11T16.53-5c582cc/job.log
>>>>  (1/4) ./tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu: PASS (44.21 s)
>>>>  (2/4) ./tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_strict: PASS (78.60 s)
>>>>  (3/4) ./tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_strict_cm: PASS (65.57 s)
>>>>  (4/4) ./tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_pt: PASS (66.63 s)
>>>> RESULTS    : PASS 4 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
>>>> JOB TIME   : 255.43 s
>>>>
>>> Yes, I've also seen similar runtimes in other environments... so it
>>> looks like it depends a lot on the "dnf -y install numactl-devel".  If
>>> that can be removed, the tests would have much more predictable runtimes.
>>>



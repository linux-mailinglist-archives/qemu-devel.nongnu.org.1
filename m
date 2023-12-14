Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE4A812910
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 08:25:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDg4w-00070e-4u; Thu, 14 Dec 2023 02:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rDg4t-0006y6-GU
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 02:24:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rDg4r-0002uF-Mu
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 02:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702538652;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nTrq+3Cdbpt4RVJomfi0QnbN0tB/JIdZpvtKrvEXuC8=;
 b=Pz+CUiLu1e/N9JR3lEdfrBHxqibJXgGtvpExX0HuUuLCo5dYACWkXV5cnuZF7N4lWVn6Uh
 NMweK7GbQhOY+AM9KmiKGcUcP4txLLyVte3IJqC8Ljl6l+MYvj5iN7oK6wq3fjOLIUJb7V
 eCtxgNlBRib2iPGJL7jR1ZuA+VKVryw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-QP-Ry03iOcOK434u75XTHg-1; Thu, 14 Dec 2023 02:24:10 -0500
X-MC-Unique: QP-Ry03iOcOK434u75XTHg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40c3826d6feso36341715e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 23:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702538649; x=1703143449;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nTrq+3Cdbpt4RVJomfi0QnbN0tB/JIdZpvtKrvEXuC8=;
 b=pu1DJzdhF9O+ECLnXfN9AApsHHJ5x0NMgyPnX1+H/nug3JSqp6Y810GGS2VS2ds4LE
 osJECd1SvzM393Rkd6b1tv5+ArCo//xVgl89OEzQLLlWfqm+OZkvo0aybcNX4rmFhDq9
 mDuFt9OnGv7z23g1ya3TTqDT+M0tlJVHwXf5VyWzd6T26okgM2cV9gkISGdQMrHVNpRf
 9+cWNaOObbyW25CpqUfjhClzpBHFzrbINrOvFeB+J6+Xf5NU6AYKG7USUqp+34tVMyg8
 deG5qXCvAjzl3qf1Le8kEmStfJ1RBUW0BOdoUSUz/1x7TVwRJ99UI+INom611cAcWMK1
 XM4Q==
X-Gm-Message-State: AOJu0Yw3GUR/0n6nbrq5PnrFFPUSZfQ4iJ3UiRozvlKelgkK+2GbOjwi
 xbPubPxkyaLJSgK/PqnmsAMLSpWBuJRWiG+20Ra+n+hKBHmNgUZKNRsC2OjPaT7tKJ700O9iCea
 f5TiJB3G2coKTxxo=
X-Received: by 2002:a1c:7916:0:b0:40c:55a7:7735 with SMTP id
 l22-20020a1c7916000000b0040c55a77735mr2016768wme.118.1702538649505; 
 Wed, 13 Dec 2023 23:24:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEP1uSGIJVLfMWqdXKJluitZInxrGncOnNatxqUThqfOfa95Chpt5bRpMkX2rLimEB8pTCrnA==
X-Received: by 2002:a1c:7916:0:b0:40c:55a7:7735 with SMTP id
 l22-20020a1c7916000000b0040c55a77735mr2016754wme.118.1702538649091; 
 Wed, 13 Dec 2023 23:24:09 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 gw18-20020a05600c851200b004053e9276easm25685177wmb.32.2023.12.13.23.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 23:24:08 -0800 (PST)
Message-ID: <6140fc8a-4044-4891-854d-9bf555c5dd78@redhat.com>
Date: Thu, 14 Dec 2023 08:24:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] tests/avocado/intel_iommu.py: increase timeout
Content-Language: en-US
To: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
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
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87sf45vpad.fsf@p1.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Cleber,

On 12/13/23 21:08, Cleber Rosa wrote:
> Alex Bennée <alex.bennee@linaro.org> writes:
>
>> Cleber Rosa <crosa@redhat.com> writes:
>>
>>> Based on many runs, the average run time for these 4 tests is around
>>> 250 seconds, with 320 seconds being the ceiling.  In any way, the
>>> default 120 seconds timeout is inappropriate in my experience.
>> I would rather see these tests updated to fix:
>>
>>  - Don't use such an old Fedora 31 image
> I remember proposing a bump in Fedora version used by default in
> avocado_qemu.LinuxTest (which would propagate to tests such as
> boot_linux.py and others), but that was not well accepted.  I can
> definitely work on such a version bump again.
>
>>  - Avoid updating image packages (when will RH stop serving them?)
> IIUC the only reason for updating the packages is to test the network
> from the guest, and could/should be done another way.
>
> Eric, could you confirm this?
Sorry for the delay. Yes effectively I used the dnf install to stress
the viommu. In the past I was able to trigger viommu bugs that way
whereas getting an IP @ for the guest was just successful.
>
>>  - The "test" is a fairly basic check of dmesg/sysfs output
> Maybe the network is also an implicit check here.  Let's see what Eric
> has to say.

To be honest I do not remember how avocado does the check in itself; my
guess if that if the dnf install does not complete you get a timeout and
the test fails. But you may be more knowledged on this than me ;-)

Thanks

Eric
>
>> I think building a buildroot image with the tools pre-installed (with
>> perhaps more testing) would be a better use of our limited test time.
>>
>> FWIW the runtime on my machine is:
>>
>> ➜  env QEMU_TEST_FLAKY_TESTS=1 ./pyvenv/bin/avocado run ./tests/avocado/intel_iommu.py
>> JOB ID     : 5c582ccf274f3aee279c2208f969a7af8ceb9943
>> JOB LOG    : /home/alex/avocado/job-results/job-2023-12-11T16.53-5c582cc/job.log
>>  (1/4) ./tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu: PASS (44.21 s)
>>  (2/4) ./tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_strict: PASS (78.60 s)
>>  (3/4) ./tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_strict_cm: PASS (65.57 s)
>>  (4/4) ./tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_pt: PASS (66.63 s)
>> RESULTS    : PASS 4 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
>> JOB TIME   : 255.43 s
>>
> Yes, I've also seen similar runtimes in other environments... so it
> looks like it depends a lot on the "dnf -y install numactl-devel".  If
> that can be removed, the tests would have much more predictable runtimes.
>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6903C812BE2
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 10:43:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDiDy-0005Vf-RQ; Thu, 14 Dec 2023 04:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rDiDx-0005VK-K0
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 04:41:45 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rDiDv-00039B-Q6
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 04:41:45 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33644eeb305so536229f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 01:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702546901; x=1703151701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IhirMk2Pj6xqfCm4+RuC5WxWiaHBmW0zej7ZrATHGJE=;
 b=wWR9lKsOKxCPG1Qk9FUdA5Cl2MlNNogoEc5cXHzf1oAXeqyFbhzkNdFBOuGtgajuqX
 7tn9KEmULTWf1L8ZQ7Q1S0jneIyBYd1u+E643UsnoajsnvKSfwmIAot7Eyy8joi6U6Xo
 93pwhSxjYUICGlJl2gyQYu8pYX6vQia0Fk93L+3Ktk87470nAbnyjf8G3CfjdvxxeIrO
 mo8mSAWrrcLVIZ/0euqNyl7ScAHmR5DIbyPTy6w1pnBRGsh4SfH/BSxTJeaH/aBscgZd
 FhexvFyGDgOYnNBsydD8i8mBipZm/154S33mXLWe2qcGUIcy9yiN7Y1Wa2RC26gk1jDq
 FMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702546901; x=1703151701;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IhirMk2Pj6xqfCm4+RuC5WxWiaHBmW0zej7ZrATHGJE=;
 b=WP+mmanulqR1enP502n9+hYBE5PsyhwA5Ta4g4Pm6mCUEuxXa+5gdKo9ZJheBGBwu9
 PYF5x5W5R4SPY0/I/6MDEDqu0UM0U481O2TrcAueT/dUa7KDh/eptXlzLCpFligLbQ7G
 Gd4gYLWlHM9FZ6o+ysuUium8vpCrOGYVAdygjN1q0LQNjukXMy/DO3VCBkMHXlnn9h/2
 P8B2ZcYi3YQOfW1062VIVIvjqZ9c3GVtv2SaKdaKTDEwvp4cYJXEgD0vgr8ovAZMeeEt
 Qe9927Z7WhiWIJm0hh6GLCEIdkrl0d2wX7ol8RZ4KRBZ1gOy+m9eeN0cueGtyISRuk3D
 lARA==
X-Gm-Message-State: AOJu0YygBsuZynSVxpMhPilmb+QhX61DR4yaTWfQ7QENxpN9Ukhd5Yrt
 P3NY/Ec1A8zRi2fbhT/JgwoYWQ==
X-Google-Smtp-Source: AGHT+IEc3qEQL4PHiZi5FMs7EFpmq2yI1xzF5FYmjPRNzYhVU6ikvRrNK3BulX8MWW3wqPKtbTnWIA==
X-Received: by 2002:adf:e807:0:b0:336:4658:4481 with SMTP id
 o7-20020adfe807000000b0033646584481mr373139wrm.123.1702546901222; 
 Thu, 14 Dec 2023 01:41:41 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 t5-20020a5d4605000000b0033646bf3e50sm1384068wrq.102.2023.12.14.01.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 01:41:40 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 88F7C5F7D3;
 Thu, 14 Dec 2023 09:41:40 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>,  qemu-devel@nongnu.org,  Jiaxun Yang
 <jiaxun.yang@flygoat.com>,  Radoslaw Biernacki <rad@semihalf.com>,  Paul
 Durrant <paul@xen.org>,  Akihiko Odaki <akihiko.odaki@daynix.com>,  Leif
 Lindholm <quic_llindhol@quicinc.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org,  qemu-arm@nongnu.org,  Philippe =?utf-8?Q?Mathieu-D?=
 =?utf-8?Q?aud=C3=A9?=
 <philmd@linaro.org>,  Beraldo Leal <bleal@redhat.com>,  Wainer dos Santos
 Moschetta <wainersm@redhat.com>,  Sriram Yagnaraman
 <sriram.yagnaraman@est.tech>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 03/10] tests/avocado/intel_iommu.py: increase timeout
In-Reply-To: <6140fc8a-4044-4891-854d-9bf555c5dd78@redhat.com> (Eric Auger's
 message of "Thu, 14 Dec 2023 08:24:05 +0100")
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-4-crosa@redhat.com>
 <8734w8fzbc.fsf@draig.linaro.org> <87sf45vpad.fsf@p1.localdomain>
 <6140fc8a-4044-4891-854d-9bf555c5dd78@redhat.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Thu, 14 Dec 2023 09:41:40 +0000
Message-ID: <878r5x9l4b.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Eric Auger <eric.auger@redhat.com> writes:

> Hi Cleber,
>
> On 12/13/23 21:08, Cleber Rosa wrote:
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>>> Cleber Rosa <crosa@redhat.com> writes:
>>>
>>>> Based on many runs, the average run time for these 4 tests is around
>>>> 250 seconds, with 320 seconds being the ceiling.  In any way, the
>>>> default 120 seconds timeout is inappropriate in my experience.
>>> I would rather see these tests updated to fix:
>>>
>>>  - Don't use such an old Fedora 31 image
>> I remember proposing a bump in Fedora version used by default in
>> avocado_qemu.LinuxTest (which would propagate to tests such as
>> boot_linux.py and others), but that was not well accepted.  I can
>> definitely work on such a version bump again.
>>
>>>  - Avoid updating image packages (when will RH stop serving them?)
>> IIUC the only reason for updating the packages is to test the network
>> from the guest, and could/should be done another way.
>>
>> Eric, could you confirm this?
> Sorry for the delay. Yes effectively I used the dnf install to stress
> the viommu. In the past I was able to trigger viommu bugs that way
> whereas getting an IP @ for the guest was just successful.
>>
>>>  - The "test" is a fairly basic check of dmesg/sysfs output
>> Maybe the network is also an implicit check here.  Let's see what Eric
>> has to say.
>
> To be honest I do not remember how avocado does the check in itself; my
> guess if that if the dnf install does not complete you get a timeout and
> the test fails. But you may be more knowledged on this than me ;-)

I guess the problem is relying on external infrastructure can lead to
unpredictable results. However its a lot easier to configure user mode
networking just to pull something off the internet than have a local
netperf or some such setup to generate local traffic.

I guess there is no loopback like setup which would sufficiently
exercise the code?

>
> Thanks
>
> Eric
>>
>>> I think building a buildroot image with the tools pre-installed (with
>>> perhaps more testing) would be a better use of our limited test time.
>>>
>>> FWIW the runtime on my machine is:
>>>
>>> =E2=9E=9C  env QEMU_TEST_FLAKY_TESTS=3D1 ./pyvenv/bin/avocado run ./tes=
ts/avocado/intel_iommu.py
>>> JOB ID     : 5c582ccf274f3aee279c2208f969a7af8ceb9943
>>> JOB LOG    : /home/alex/avocado/job-results/job-2023-12-11T16.53-5c582c=
c/job.log
>>>  (1/4) ./tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu: PASS=
 (44.21 s)
>>>  (2/4) ./tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_stric=
t: PASS (78.60 s)
>>>  (3/4) ./tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_stric=
t_cm: PASS (65.57 s)
>>>  (4/4) ./tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_pt: P=
ASS (66.63 s)
>>> RESULTS    : PASS 4 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 =
| CANCEL 0
>>> JOB TIME   : 255.43 s
>>>
>> Yes, I've also seen similar runtimes in other environments... so it
>> looks like it depends a lot on the "dnf -y install numactl-devel".  If
>> that can be removed, the tests would have much more predictable runtimes.
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


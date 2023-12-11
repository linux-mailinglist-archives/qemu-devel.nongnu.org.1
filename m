Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B8380D32F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 18:04:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCjfr-0004px-MP; Mon, 11 Dec 2023 12:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCjfC-0004Og-C2
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:01:53 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCjf9-0007FJ-Gq
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 12:01:49 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33622099f23so952663f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 09:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702314104; x=1702918904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lWK2LlwCifXuctnRg+xMKHZBJ8byXCXekix4o2vqaXU=;
 b=lwms/ULkeA20/cioCowuUGBIdKab4pRzYLW9q6LbVGvklkoj/NAiErZYGIJqBHBdrC
 uG0OBKYcJpz6UibUDtn+LXIoysC1rAMMhNsKEybIVG01boWA1j3BAIp2Pk4rvs7eAlHZ
 9ST5ydMdbkuXRW4qsd3hS5fXMn3KvXWAOehDI1SEsyUVtzDYtN+Ec6Xaol7qXUuXiUDQ
 UT9NXdWL0LvFu8aiFgOtIUeU09qceUvizxg63sxnu+aCcmVKnQmLzGEmzHA8o9RLQukk
 U9X2AqUkFOhlNi4kHCnfuvZlr1hOzCoqZaZFnm0+M2z2uLIIVI/lN55I3SXWEA6DDaST
 1Xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702314104; x=1702918904;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lWK2LlwCifXuctnRg+xMKHZBJ8byXCXekix4o2vqaXU=;
 b=NH4LsBuxNjk1X48ATPhtbcyoyRtegUbKfG2g/7HkpANeMTUb+OZ7iM847OMWnfKfPj
 sEhfEGWHfzo9u8fMZtdJPOc5uJWH+ufYqdNBKmpiQFKk+bRCfBlkro1vmTu4wkJ7c35l
 uvgHgzyI/Az6BAQQgiYEdtsF2F3qLbyxIwU935AmlqZxe+U87IGTbc/SBwex9XX7qvi/
 lw+UEJomfWPsUuAXE5Q76vRbQbHPH0VECqSz5QERYTqHRg4kirc82Gwp2ldaspEqexMJ
 TVZq2a/KPB/1g9yHqEamVqeaduUrVk3ZWFMDQ86TCpy/tuoeKc3/g+2rNN0OIJVFqq0+
 iLOA==
X-Gm-Message-State: AOJu0YxHtKxz174kRfK4/WTT46U20E3ptEs93hfnc5Ix8LYhVyzQbPqX
 HNXmQ08QlP/k419kCmyn55DqKw==
X-Google-Smtp-Source: AGHT+IGUs8y3ooVZf55L1O6rZwWTQHdSQQCj0YIswKwihTIgwU8egbDgviUbCMkajaobuux0v6j7Mg==
X-Received: by 2002:adf:ef82:0:b0:336:97c:4764 with SMTP id
 d2-20020adfef82000000b00336097c4764mr2178819wro.57.1702314104397; 
 Mon, 11 Dec 2023 09:01:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 p16-20020a5d48d0000000b0033616ea5a0fsm5974099wrs.45.2023.12.11.09.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 09:01:44 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B29E95FBC6;
 Mon, 11 Dec 2023 17:01:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org,  Jiaxun Yang <jiaxun.yang@flygoat.com>,  Radoslaw
 Biernacki <rad@semihalf.com>,  Paul Durrant <paul@xen.org>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>,  Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  kvm@vger.kernel.org,  qemu-arm@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Beraldo Leal
 <bleal@redhat.com>,  Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,  Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>,  David Woodhouse <dwmw2@infradead.org>,
 Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH 03/10] tests/avocado/intel_iommu.py: increase timeout
In-Reply-To: <20231208190911.102879-4-crosa@redhat.com> (Cleber Rosa's message
 of "Fri, 8 Dec 2023 14:09:04 -0500")
References: <20231208190911.102879-1-crosa@redhat.com>
 <20231208190911.102879-4-crosa@redhat.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Mon, 11 Dec 2023 17:01:43 +0000
Message-ID: <8734w8fzbc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Cleber Rosa <crosa@redhat.com> writes:

> Based on many runs, the average run time for these 4 tests is around
> 250 seconds, with 320 seconds being the ceiling.  In any way, the
> default 120 seconds timeout is inappropriate in my experience.

I would rather see these tests updated to fix:

 - Don't use such an old Fedora 31 image
 - Avoid updating image packages (when will RH stop serving them?)
 - The "test" is a fairly basic check of dmesg/sysfs output

I think building a buildroot image with the tools pre-installed (with
perhaps more testing) would be a better use of our limited test time.

FWIW the runtime on my machine is:

=E2=9E=9C  env QEMU_TEST_FLAKY_TESTS=3D1 ./pyvenv/bin/avocado run ./tests/a=
vocado/intel_iommu.py
JOB ID     : 5c582ccf274f3aee279c2208f969a7af8ceb9943
JOB LOG    : /home/alex/avocado/job-results/job-2023-12-11T16.53-5c582cc/jo=
b.log
 (1/4) ./tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu: PASS (44=
.21 s)
 (2/4) ./tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_strict: P=
ASS (78.60 s)
 (3/4) ./tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_strict_cm=
: PASS (65.57 s)
 (4/4) ./tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_pt: PASS =
(66.63 s)
RESULTS    : PASS 4 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CA=
NCEL 0
JOB TIME   : 255.43 s

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


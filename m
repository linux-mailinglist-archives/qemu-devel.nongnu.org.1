Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 809BA7FF53B
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 17:27:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8jrN-000161-VK; Thu, 30 Nov 2023 11:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8jrK-00015J-9f
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:25:50 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8jrI-0006Fv-2V
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 11:25:50 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40b54261534so9892795e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 08:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701361546; x=1701966346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vhuXMug3aQ5F/kxHcNOxvLvplcIDcKcJglsmAG7to0Q=;
 b=Zhsg4Zh8l3NBGsfXm5SEreNBveVfDEJoiluOQBNDflOowGEfCyaj3Q35VT/d6bpVV2
 XNTrW2AADmkAMYcGWsxY8+TSlLLmj/pfaox2jE7wciYEWHU3CsudjTko7aTCBvgULI0g
 7aUMdz3+N0HlS/yked90LbwyAmXGc7l/JhEY9T4srVhGBHyhQu0mWqMr2rAGGG8fkO8Q
 18H1w/4H1BB7J6/V+vqhsdshomVSj+7PjF3bWNjO9/AmuTFCweazMhrpVaI7Aqz4pRlL
 lRY5JjLqIDwMKnFb+/S8+fF+txWCQyozVgVNn8qDySkUK+Vf0B4BoNgWLvpXw9ivQDtb
 THlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701361546; x=1701966346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vhuXMug3aQ5F/kxHcNOxvLvplcIDcKcJglsmAG7to0Q=;
 b=KGzg8zL3nMWHTnhsdGlFrgSzbbDbIoIcNkCWETTU4qOg8c3jnQteTN4/iiVFFdp4cr
 1/YvToEHXEdBlzgj57KlcOXXp9Boeiib6XvG32X9EKY7pHsbyPpo109RW6PObRAvDrvi
 eyWWP/sBXLt0oNYEucT3CkwtdkuegkCxM14DmcBduGkX4GhTwkZmbiRV6O8yDTgHhtsS
 jmXdGti59VmcLOO3k+JZVl2wtLKwyT5xEFR8dFr137tGIpUfk74Dl/ba5Viy+l7/iIxq
 sTnqZmo0pG8oyp5DSoFhkaLyTsFFPp1LLkIY+9l5kn5t/HaaTg/n5MuM/n6kBUtRbpcl
 NYCQ==
X-Gm-Message-State: AOJu0Yyf6mXz1KXtc6Td8Fz6r5TDoiIZ05F0h0701VMwMjkzg/mrHgHj
 Y01HghlRWxTs3D0D2n0SauS9nA==
X-Google-Smtp-Source: AGHT+IHKxKxb4EUuifFNnpudxEMfeakPbcfxSrAXjC/Scj1wDLLA5zqCykeRk/HcdCreOoOrm+VQhQ==
X-Received: by 2002:a05:600c:354c:b0:402:cc5c:c98 with SMTP id
 i12-20020a05600c354c00b00402cc5c0c98mr16044811wmq.13.1701361546366; 
 Thu, 30 Nov 2023 08:25:46 -0800 (PST)
Received: from [192.168.69.100] (sev93-h02-176-184-17-116.dsl.sta.abo.bbox.fr.
 [176.184.17.116]) by smtp.gmail.com with ESMTPSA id
 r12-20020a05600c458c00b0040b4b66110csm2488544wmo.22.2023.11.30.08.25.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 08:25:45 -0800 (PST)
Message-ID: <6678fa66-22f7-45f3-b83f-453faddd7d45@linaro.org>
Date: Thu, 30 Nov 2023 17:25:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] docs/devel: rationalise unstable gitlab tests under
 FLAKY_TESTS
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, =?UTF-8?Q?C=C3=A9dric_Le_Goate?=
 =?UTF-8?Q?r?= <clg@kaod.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>, Aurelien Jarno <aurelien@aurel32.net>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>
References: <20231130153333.2424775-1-alex.bennee@linaro.org>
 <20231130153333.2424775-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231130153333.2424775-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 30/11/23 16:33, Alex Bennée wrote:
> It doesn't make sense to have two classes of flaky tests. While it may
> take the constrained environment of CI to trigger failures easily it
> doesn't mean they don't occasionally happen on developer machines. As
> CI is the gating factor to passing there is no point developers
> running the tests locally anyway unless they are trying to fix things.
> 
> While we are at it update the language in the docs to discourage the
> QEMU_TEST_FLAKY_TESTS becoming a permanent solution.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   docs/devel/testing.rst                   | 31 +++++++++++++++---------
>   tests/avocado/boot_linux.py              |  8 +++---
>   tests/avocado/boot_linux_console.py      |  5 ++--
>   tests/avocado/intel_iommu.py             |  5 ++--
>   tests/avocado/linux_initrd.py            |  5 ++--
>   tests/avocado/machine_aspeed.py          |  8 +++---
>   tests/avocado/machine_mips_malta.py      |  8 +++---
>   tests/avocado/machine_rx_gdbsim.py       |  8 +++---
>   tests/avocado/machine_s390_ccw_virtio.py |  2 +-
>   tests/avocado/replay_kernel.py           |  5 ++--
>   tests/avocado/reverse_debugging.py       | 14 +++++++----
>   tests/avocado/smmu.py                    |  5 ++--
>   tests/avocado/tuxrun_baselines.py        |  4 +--
>   13 files changed, 67 insertions(+), 41 deletions(-)


> diff --git a/tests/avocado/boot_linux.py b/tests/avocado/boot_linux.py
> index be30dcbd58..9e9773e6e1 100644
> --- a/tests/avocado/boot_linux.py
> +++ b/tests/avocado/boot_linux.py
> @@ -12,7 +12,7 @@
>   
>   from avocado_qemu import LinuxTest, BUILD_DIR
>   
> -from avocado import skipIf
> +from avocado import skipUnless
>   
>   
>   class BootLinuxX8664(LinuxTest):
> @@ -93,7 +93,8 @@ class BootLinuxPPC64(LinuxTest):
>   
>       timeout = 360
>   
> -    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')

Later we could move that to a @flakyTest decorator around QemuBaseTest.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +
>       def test_pseries_tcg(self):
>           """
>           :avocado: tags=machine:pseries



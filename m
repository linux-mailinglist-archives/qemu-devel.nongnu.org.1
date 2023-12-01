Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D843800832
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 11:29:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r90lG-00019u-R2; Fri, 01 Dec 2023 05:28:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r90lB-00018p-Ov
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:28:39 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r90lA-0001OS-4x
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 05:28:37 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a0029289b1bso261216166b.1
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 02:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701426514; x=1702031314; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6kNy7wp9+mrUPguJa5BLXGCSuv3Qnf1ooSCECnFKbZA=;
 b=cFTSDGwmILn+GP/bCE5dMCKup7HiiPefMviAth0PKVWK6IN7Uk5trV7Q6EhJI5o71Q
 HcCUP4E0xvfbUaps5csKDumT24ey4ic0ge3ed66tuzisnr3X6byYW9wJAze/4DSiCQsB
 O75LiLRDPfAQnv2j5xS9qgCbvzzQ9BZ9AkrPTs4+bUnh2uFQStdEvQlCgZeeZahIfBbY
 lemOa+cSyMGOe6mLnqDE3+JIiqwTdl8eVNv3trWeiiY4ijrvMvvYm20PUEFYW141gTpT
 cN+6HgEfEnriKYfmp6T3SI6UxxzZJe/U1CmvcVFnqm6jMwuuAQ3J/3RBhq2lWnkX26Mv
 OaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701426514; x=1702031314;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6kNy7wp9+mrUPguJa5BLXGCSuv3Qnf1ooSCECnFKbZA=;
 b=DYSlnW6peaSlif+6hsCg0HW8USKtNBruknXbMr9QXtlqlDpmrPv1enN+0Yro/LClUl
 3BhIWaSeP07/uC7FhlYeqh8UMcwdpAr10TVxATBY21jgKUHbbNvtvVxVBsyRTydfJrbM
 BpbKyb4dr7P9sFJBCpFMzAhMErjGg67Vc1aWncu/55BcOOgaLqxZZtfVC5EA15qZqlzO
 xsYDhuuLDLfzhncRl3o29+HbmPaU58bnNTlYBY2CfOjMFcNQbWKFkVJzAvcHB4jAjp7P
 mgsQ14VNlbEyPKNW8M+EA8aohj2v/wx9hj+fHEiHg4CII4P5bx8Rdlhx752x76d93dzC
 dloQ==
X-Gm-Message-State: AOJu0Yxnh/XdqrHiyJ+G9PXwD1d19btoakpQeXVfMG9IrdLpx+OYMoZ9
 lJXybKA0+3/R4ZE28N9VTyNp2A==
X-Google-Smtp-Source: AGHT+IFFC/5lq7wNrm9U4utXLnX75AbJipWqKHAFuTWgS/56LgaYefY8KUKkUZflCXpL5Rf1SnqarQ==
X-Received: by 2002:a17:906:1c4b:b0:a19:a1ba:8cd1 with SMTP id
 l11-20020a1709061c4b00b00a19a1ba8cd1mr733858ejg.111.1701426513761; 
 Fri, 01 Dec 2023 02:28:33 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 l22-20020a1709067d5600b00a1a4b4feef3sm95885ejp.120.2023.12.01.02.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 02:28:33 -0800 (PST)
Message-ID: <cf039383-600b-49b3-bb94-8592a2b3d003@linaro.org>
Date: Fri, 1 Dec 2023 11:28:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] gitlab: add optional job to run flaky avocado tests
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Beraldo Leal <bleal@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Eric Auger <eric.auger@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231201093633.2551497-1-alex.bennee@linaro.org>
 <20231201093633.2551497-8-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231201093633.2551497-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 1/12/23 10:36, Alex Bennée wrote:
> One problem with flaky tests is they often only fail under CI
> conditions which makes it hard to debug. We add an optional allow_fail
> job so developers can trigger the only the flaky tests in the CI
> environment if they are debugging.
> 
> Message-Id: <20231130153333.2424775-4-alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - add missing ppc64/aarch64 build
> ---
>   docs/devel/testing.rst                   | 15 ++++++------
>   .gitlab-ci.d/buildtest.yml               | 30 ++++++++++++++++++++++++

This should be split, first add the 'flaky' infrastructure, then
mark tests as flaky, referencing the GitLab issue URL.

>   tests/avocado/boot_linux.py              |  2 ++
>   tests/avocado/boot_linux_console.py      |  1 +
>   tests/avocado/intel_iommu.py             |  1 +
>   tests/avocado/linux_initrd.py            |  2 ++
>   tests/avocado/machine_aspeed.py          |  2 ++
>   tests/avocado/machine_mips_malta.py      |  2 ++
>   tests/avocado/machine_rx_gdbsim.py       |  2 ++
>   tests/avocado/machine_s390_ccw_virtio.py |  1 +
>   tests/avocado/replay_kernel.py           |  2 ++
>   tests/avocado/reverse_debugging.py       |  2 ++
>   tests/avocado/smmu.py                    |  1 +
>   tests/avocado/tuxrun_baselines.py        |  1 +
>   14 files changed, 57 insertions(+), 7 deletions(-)



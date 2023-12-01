Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D11CF801090
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 17:51:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r96j1-0001oG-7U; Fri, 01 Dec 2023 11:50:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r96iz-0001o0-JA
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 11:50:45 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r96ix-0005eF-Ss
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 11:50:45 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-409299277bbso21522185e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 08:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701449441; x=1702054241; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qQ89hHqiYg9GGED2FxM0LW1BbD0NqvsBzSOD/TA8WoA=;
 b=WJ2cxa8AuW8RuzjgkUiY/FVvGA7zGTe76yHLlvq3/8sM2wmtxoJkp4AlTulJhFtYpc
 Lka32bjJOMio4npDvlfYxmBy1Zbm8holqDBwciYT+cCAESFCw6mID7S4DO22T5oIbaJa
 orsWG2A8vuIClt+ysXFj/QKSGlYgDD6QNHEhHDq+J3Y61W/s+FSLr1WfY0keAPuS9YIL
 Bt+Cf3AjYdRdZzvRVxZud4iUL3IZlUaU7eRbwYwPAtk5mehfZUX/66cZ1e0DaXwEfDjj
 xp+Xxqk+BkKs/CgN/jXIfT0qZOXsIQQjvh+M3ylPVFSjaLEqQuHNmrg4rjLb6vEW6IxM
 0ttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701449441; x=1702054241;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qQ89hHqiYg9GGED2FxM0LW1BbD0NqvsBzSOD/TA8WoA=;
 b=VhVxEU5tx2X4MOHIBsZ628G04tgEhAb7P3q8PTWf4dF8teI1L5+evNXRMtDlT1e7bM
 c1QRZ4IpZeAaUjzpkKMBBHfh36aYwhhgSib5rwEHnDgxp3ikdesMiA9vZLsc7qKnCfUl
 x0GXqJxGcPtiJOit/7+GwiNjhTt1c63LTfRJYfqB5fBGMAaJi1Nqarl+Wc5dnMtfPdiA
 AGFuP3SpCQHEzvq1MeMc33NoOJG63XaPMisIZcoFd8uhcws1gN01KsEnji3m5pMWKelT
 ggr3Ga6zqekxVeLAJtqao7nuKqE7hNYa39RxjV6PMdnE4qYBlXX7QqT9Q8MyUc+huMKe
 uZpw==
X-Gm-Message-State: AOJu0YxW2u00DIEYJoNEcxBTYWjAmh0/0sbdTtMU7G7/w4Pp/OWIg0dZ
 CGBHoMaysKMbtsndQh9u+m1uhpvwlTI08ustz5Y=
X-Google-Smtp-Source: AGHT+IHEvXpX62OSnLyQ4/9Cl5B0FiXNCPIBRpz78gLPA4DKr1zy0XBOYt0aJDz/fWXdynb91XApUA==
X-Received: by 2002:a7b:c049:0:b0:40a:3e13:22aa with SMTP id
 u9-20020a7bc049000000b0040a3e1322aamr571462wmc.7.1701449440577; 
 Fri, 01 Dec 2023 08:50:40 -0800 (PST)
Received: from [192.168.69.100] ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 l6-20020a05600c4f0600b0040b3829eb50sm5950578wmq.20.2023.12.01.08.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Dec 2023 08:50:40 -0800 (PST)
Message-ID: <7727c4ad-b6a2-49f5-88bf-0ac83e93f570@linaro.org>
Date: Fri, 1 Dec 2023 17:50:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] gdbstub, avocado and gitlab updates
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20231201151228.2610209-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231201151228.2610209-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi Alex,

On 1/12/23 16:12, Alex Bennée wrote:
> The following changes since commit abf635ddfe3242df907f58967f3c1e6763bbca2d:
> 
>    Update version for v8.2.0-rc2 release (2023-11-28 16:31:16 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-more-8.2-fixes-011223-1
> 
> for you to fetch changes up to a7a740cce1ec49568e7ebd8e776279e59e2fb5b6:
> 
>    gitlab: add optional job to run flaky avocado tests (2023-12-01 14:12:05 +0000)
> 
> ----------------------------------------------------------------
> Flaky avocado tests, gdbstub and gitlab tweaks
> 
>    - gdbstub, properly halt when QEMU is having IO issues
>    - convert skipIf(GITLAB_CI) to skipUnless(QEMU_TEST_FLAKY_TESTS)
>    - drop mips malta cpio test as assets expire in Debian archive
>    - tag sbsa-ref tests as TCG only
>    - build the correct microblaze for avocado-system-ubuntu
>    - add optional flaky tests job to CI
> 
> ----------------------------------------------------------------
> Alex Bennée (6):
>        gdbstub: use a better signal when we halt for IO reasons
>        docs/devel: rationalise unstable gitlab tests under FLAKY_TESTS
>        tests/avocado: drop BootLinuxConsole.test_mips_malta_cpio test

This patch has been posted 5h ago and we are still discussing it...
I'm quite surprised you include it in your PR.

>        tests/avocado: tag sbsa tests as tcg only
>        gitlab: build the correct microblaze target
>        gitlab: add optional job to run flaky avocado tests
> 
>   docs/devel/testing.rst                   | 32 ++++++++++++++--------
>   gdbstub/internals.h                      |  1 +
>   gdbstub/system.c                         |  2 +-
>   .gitlab-ci.d/buildtest.yml               | 32 +++++++++++++++++++++-
>   tests/avocado/boot_linux.py              | 10 +++++--
>   tests/avocado/boot_linux_console.py      | 47 +++-----------------------------
>   tests/avocado/intel_iommu.py             |  6 ++--
>   tests/avocado/linux_initrd.py            |  7 +++--
>   tests/avocado/machine_aarch64_sbsaref.py |  4 +++
>   tests/avocado/machine_aspeed.py          | 10 +++++--
>   tests/avocado/machine_mips_malta.py      | 10 +++++--
>   tests/avocado/machine_rx_gdbsim.py       | 10 +++++--
>   tests/avocado/machine_s390_ccw_virtio.py |  3 +-
>   tests/avocado/replay_kernel.py           |  8 ++++--
>   tests/avocado/reverse_debugging.py       | 16 +++++++----
>   tests/avocado/smmu.py                    |  6 ++--
>   tests/avocado/tuxrun_baselines.py        |  5 ++--
>   17 files changed, 125 insertions(+), 84 deletions(-)
> 
> 



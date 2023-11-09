Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1F67E6516
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 09:20:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r10GT-0002Pv-Ut; Thu, 09 Nov 2023 03:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r10GQ-0002Pb-Eg
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 03:19:46 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r10GO-0007Ll-Es
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 03:19:46 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-32d9effe314so334342f8f.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 00:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699517982; x=1700122782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dm1cJ62P8gCaIlOUfG7nB/4tPGcmd2FJiY73rok53lc=;
 b=D7F+sp1mq9HjwumnOHO/Rh9dgWnWE/UBnXVJdcweYxiecG1TzvCxQYbPNLd+W1s9/M
 Szvlil2J1IN1HRYrLst92n0YiMMaiWnqJ0xuYOOiC8bb8YjRzuNQSSbrk1yK2GuUy1lf
 CH4RMUh+/+kNbRj6s46zFbJ0HGNwtgF7rhADpe9xguEo2hvTPzAteT9vZY4FJsEEEqpw
 ryg6BCtBUz7JgM68/f84L6/1UPaRU0eUiXJ6VxGsAgdrPzAOh9ELYtUP110OpwzoCTTS
 fCqWxgtXTItgcXZKo/0CyC33n+5YaDJTBbXwnQBISILbEPQ+UcAX+JKG6C9T+ot899Vx
 CyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699517982; x=1700122782;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dm1cJ62P8gCaIlOUfG7nB/4tPGcmd2FJiY73rok53lc=;
 b=n7u0Fp4U3PHL+poXtUgu8OO1qVRr54KdKzDQJdcArQCoCiW0IpWLVLGF61a+h9B1Vl
 Cqa9XivTi7hIPyzlN+v+5H4Mrk9a/TvawRM0N8PHFDpgV/KJDz3gP33BKkvR9+cqJsDy
 dQMVlWDeD5N4IYiHI1Enz38BOXa6jQrvJ80FT3jHQ8DD0+f5IrmpQM1t5xTkUBwCLbjr
 D7NXy7iFhoXjIZjhermYpuTXfedUQDhdFQuIiwNYw13LJzgc5N+rfq+1F+Hv5pMVZqpF
 7ta6lF1l/ZpK3cnB5NPxX4JBr1HHvu1S0C7M2p6AUyZfHepFo+J8xjrIBpA9VGEy1Ujr
 9bug==
X-Gm-Message-State: AOJu0Yww4TuFLwvR45jEKMUm/ulEKiWLdg6sQ2OrrGxLOjp1w7nw78hr
 eUofnT1StjtEr5QQ91fWfFopWg==
X-Google-Smtp-Source: AGHT+IF49REc+UhJy1VKN+dRka+4oM435la9wh/vz1kd+zSpdFKtMqzSqw1TGHR2Mx+bgtvlh0PWjQ==
X-Received: by 2002:a05:6000:136a:b0:32d:a3a0:e927 with SMTP id
 q10-20020a056000136a00b0032da3a0e927mr3348978wrz.58.1699517982541; 
 Thu, 09 Nov 2023 00:19:42 -0800 (PST)
Received: from [192.168.23.175] (226.red-88-28-2.dynamicip.rima-tde.net.
 [88.28.2.226]) by smtp.gmail.com with ESMTPSA id
 a10-20020a5d53ca000000b00326dd5486dcsm6775620wrw.107.2023.11.09.00.19.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 00:19:42 -0800 (PST)
Message-ID: <ec2e70ef-1604-4c34-ab36-5449e613ecd1@linaro.org>
Date: Thu, 9 Nov 2023 09:19:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] tests/avocado: add test to exercize processor address
 space memory bound checks
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Cc: imammedo@redhat.com, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org
References: <20231109045601.33349-1-anisinha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231109045601.33349-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 9/11/23 05:56, Ani Sinha wrote:
> QEMU has validations to make sure that a VM is not started with more memory
> (static and hotpluggable memory) than what the guest processor can address
> directly with its addressing bits. This change adds a test to make sure QEMU
> fails to start with a specific error message when an attempt is made to
> start a VM with more memory than what the processor can directly address.
> The test also checks for passing cases when the address space of the processor
> is capable of addressing all memory. Boundary cases are tested.
> 
> CC: imammedo@redhat.com
> CC: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   tests/avocado/mem-addr-space-check.py | 367 ++++++++++++++++++++++++++
>   1 file changed, 367 insertions(+)
>   create mode 100644 tests/avocado/mem-addr-space-check.py
> 
> Changelog:
> v6: added phil's suggestions - added comment to explain why a sleep delay
>      is needed. Reduced delay to 1 sec. Added a one place definition for
>      the sleep duration so we can tweak it if needed later. Added phil's
>      tag. rebased.
> v5:
>    - made the negative test cases (ones that do not result in QEMU crash)
>      more robust by checking the non-existence of the "phys-bits too low"
>      log.
>    - added a new test case for AMD HT window where QEMU starts fine.
>    - rebased.
>    - cosmetic typo/comment adjustments.
> 
> Tests all pass:
> $ ./pyvenv/bin/avocado run tests/avocado/mem-addr-space-check.py --tap -
> 1..15
> ok 1 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_pse36
> ok 2 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_pae
> ok 3 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium_pse36
> ok 4 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium_pae
> ok 5 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium2
> ok 6 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_nonpse36
> ok 7 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q35_70_amd
> ok 8 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q35_71_amd
> ok 9 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35_70_amd
> ok 10 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35_71_amd
> ok 11 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35_71_intel
> ok 12 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q35_71_amd_41bits
> ok 13 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35_71_amd_41bits
> ok 14 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q35_intel_cxl
> ok 15 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35_intel_cxl
> 
> v4: incorporated changes related to suggestions from David.
> v3: added pae tests as well.
> v2: added 64-bit tests. Added cxl tests.
> 
> diff --git a/tests/avocado/mem-addr-space-check.py b/tests/avocado/mem-addr-space-check.py
> new file mode 100644
> index 0000000000..fae7d48598
> --- /dev/null
> +++ b/tests/avocado/mem-addr-space-check.py
> @@ -0,0 +1,367 @@
> +# Check for crash when using memory beyond the available guest processor
> +# address space.
> +#
> +# Copyright (c) 2023 Red Hat, Inc.
> +#
> +# Author:
> +#  Ani Sinha <anisinha@redhat.com>
> +#

[*]

> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +
> +from avocado_qemu import QemuSystemTest
> +import signal
> +import time
> +
> +class MemAddrCheck(QemuSystemTest):
> +    # after launch, in order to generate the logs from QEMU we need to
> +    # wait for some time. Launching and then immediately shutting down
> +    # the VM generates empty logs. A delay of 1 second is added for
> +    # this reason.
> +    DELAY_Q35_BOOT_SEQUENCE = 1

Perfect, thank you!

Do you mind if I add in [*]:

# SPDX-License-Identifier: GPL-2.0-or-later

? Optionally removing the boilerplate license comment if you offer to.

Then I can queue this patch.

Thanks,

Phil.


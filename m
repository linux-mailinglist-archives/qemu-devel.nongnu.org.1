Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C217E59A9
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 16:05:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0k64-0006cC-F4; Wed, 08 Nov 2023 10:04:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0k62-0006bu-3A
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 10:03:58 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0k5z-0004rA-QF
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 10:03:57 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-53de8fc1ad8so11798444a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 07:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699455834; x=1700060634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2gozY5jONp7RuCvr+kyyoHQUvChv36csrOG3dIZsz5U=;
 b=qjuGmhvUyePnnJ99RRQAIEyfRnHoIXSknETOZPF9TQ2ShnArTUCZyjaodCrd7kw3Ge
 A6TIuhiue+RSZYWmIRsEvtQv9jP/F0LtfC/+AMKAJJvAHuUgiecxuDRR0PQvYEkJYBt5
 XC6PwE8fEp4/3/fDcf/q5VGle1uaMSksWKvXjvCo+iNf20Oo6GFNdHVBaPlKssBFBy6S
 Mj7aMj3RW5LR92fDkk9sqKfBEmoQQqyCBcIWX7+YBsFBJY/fgs2Ubm6LQxIQ0NhYACAo
 M3TZMRK4rHZg/Vta0wVnTAl4kZlOVaMlE+ZPzpL6aWN7CVs3jgiabTLFoM2enJraguEC
 K9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699455834; x=1700060634;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2gozY5jONp7RuCvr+kyyoHQUvChv36csrOG3dIZsz5U=;
 b=RNljbLgimq/KdSqXfU7pDmjieqX3Gm/9aNyX+aDIqg2I2911H0/S3K7U+SX9WAo1fM
 5T3bUY7r2lkJIwwL6My+/7Q/c0nq/2dKJmkpHQ+aYZDZIef+v9hOzbyWGBzb6KAhOY80
 OcGHUmMvBFTxiEre8+Z3D0KMsO9l6ia3qbuQTdydCpfg8W7m0KcZ2opNS9ggiBea1CG3
 Wq+OT8bcPqEaF98DshXO2rMo7Rwh/vrt4RFHSBFeR1kXWGPYNta+/UsnArryAGN1SImC
 /ocEOCS6HKoK3d0Xr6mmpM1HaHk7gWEU3vGIsA2V3bBsEMNGEv3B03xrzkNX7wjArNrg
 hznw==
X-Gm-Message-State: AOJu0YylyxndPLZhJgaSqDCnNCte0bUT100AZE+85eplx3gvlqze2wcU
 KhwSDkq2MzWHFyIZBwJfC8zPvQ==
X-Google-Smtp-Source: AGHT+IHzqGwc4ura2tYx9StJe0YgLy+rZqzNUjIxsjn7FKdRnDHJsjS9RwmRDuGiGF1prvgZ/M6+cg==
X-Received: by 2002:a50:8acf:0:b0:543:52be:e6ad with SMTP id
 k15-20020a508acf000000b0054352bee6admr1809731edk.5.1699455833875; 
 Wed, 08 Nov 2023 07:03:53 -0800 (PST)
Received: from [192.168.69.115] ([176.187.199.60])
 by smtp.gmail.com with ESMTPSA id
 g9-20020aa7d1c9000000b0052febc781bfsm6765137edp.36.2023.11.08.07.03.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 07:03:53 -0800 (PST)
Message-ID: <cabed062-bfb7-431d-b0fe-b38c159165e4@linaro.org>
Date: Wed, 8 Nov 2023 16:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] tests/avocado: add test to exercize processor address
 space memory bound checks
Content-Language: en-US
To: Ani Sinha <anisinha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Cc: imammedo@redhat.com, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org
References: <20231103110643.11664-1-anisinha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231103110643.11664-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

Hi Ani,

On 3/11/23 12:06, Ani Sinha wrote:
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
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   tests/avocado/mem-addr-space-check.py | 361 ++++++++++++++++++++++++++
>   1 file changed, 361 insertions(+)
>   create mode 100644 tests/avocado/mem-addr-space-check.py
> 
> Changelog:
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
> index 0000000000..6b4ada5857
> --- /dev/null
> +++ b/tests/avocado/mem-addr-space-check.py
> @@ -0,0 +1,361 @@
> +# Check for crash when using memory beyond the available guest processor
> +# address space.
> +#
> +# Copyright (c) 2023 Red Hat, Inc.
> +#
> +# Author:
> +#  Ani Sinha <anisinha@redhat.com>
> +#
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
> +    # first, lets test some 32-bit processors.
> +    # for all 32-bit cases, pci64_hole_size is 0.
> +    def test_phybits_low_pse36(self):
> +        """
> +        :avocado: tags=machine:q35
> +        :avocado: tags=arch:x86_64
> +
> +        With pse36 feature ON, a processor has 36 bits of addressing. So it can
> +        access up to a maximum of 64GiB of memory. Memory hotplug region begins
> +        at 4 GiB boundary when "above_4g_mem_size" is 0 (this would be true when
> +        we have 0.5 GiB of VM memory, see pc_q35_init()). This means total
> +        hotpluggable memory size is 60 GiB. Per slot, we reserve 1 GiB of memory
> +        for dimm alignment for all newer machines (see enforce_aligned_dimm
> +        property for pc machines and pc_get_device_memory_range()). That leaves
> +        total hotpluggable actual memory size of 59 GiB. If the VM is started
> +        with 0.5 GiB of memory, maxmem should be set to a maximum value of
> +        59.5 GiB to ensure that the processor can address all memory directly.
> +        Note that 64-bit pci hole size is 0 in this case. If maxmem is set to
> +        59.6G, QEMU should fail to start with a message "phy-bits are too low".
> +        If maxmem is set to 59.5G with all other QEMU parameters identical, QEMU
> +        should start fine.
> +        """
> +        self.vm.add_args('-S', '-machine', 'q35', '-m',
> +                         '512,slots=1,maxmem=59.6G',
> +                         '-cpu', 'pentium,pse36=on', '-display', 'none',
> +                         '-object', 'memory-backend-ram,id=mem1,size=1G',
> +                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
> +        self.vm.set_qmp_monitor(enabled=False)
> +        self.vm.launch()
> +        self.vm.wait()
> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
> +
> +    def test_phybits_low_pae(self):
> +        """
> +        :avocado: tags=machine:q35
> +        :avocado: tags=arch:x86_64
> +
> +        With pae feature ON, a processor has 36 bits of addressing. So it can
> +        access up to a maximum of 64GiB of memory. Rest is the same as the case
> +        with pse36 above.
> +        """
> +        self.vm.add_args('-S', '-machine', 'q35', '-m',
> +                         '512,slots=1,maxmem=59.6G',
> +                         '-cpu', 'pentium,pae=on', '-display', 'none',
> +                         '-object', 'memory-backend-ram,id=mem1,size=1G',
> +                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
> +        self.vm.set_qmp_monitor(enabled=False)
> +        self.vm.launch()
> +        self.vm.wait()
> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
> +
> +    def test_phybits_ok_pentium_pse36(self):
> +        """
> +        :avocado: tags=machine:q35
> +        :avocado: tags=arch:x86_64
> +
> +        Setting maxmem to 59.5G and making sure that QEMU can start with the
> +        same options as the failing case above with pse36 cpu feature.
> +        """
> +        self.vm.add_args('-machine', 'q35', '-m',
> +                         '512,slots=1,maxmem=59.5G',
> +                         '-cpu', 'pentium,pse36=on', '-display', 'none',
> +                         '-object', 'memory-backend-ram,id=mem1,size=1G',
> +                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
> +        self.vm.set_qmp_monitor(enabled=False)
> +        self.vm.launch()
> +        time.sleep(3)

Why do we need to wait 3s? Maybe add a definition, then:

            time.sleep(DELAY_Q35_BOOT_SEQUENCE)

here and in the other tests. Or a comment. So we can tune
that delay in a single place. Otherwise,

Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        self.vm.shutdown()
> +        self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')



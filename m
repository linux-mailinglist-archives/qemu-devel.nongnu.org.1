Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2437DEE4D
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 09:45:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyTJN-0003VA-Au; Thu, 02 Nov 2023 04:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qyTJL-0003UY-B4
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 04:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qyTJI-0001IH-PZ
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 04:44:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698914655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ibVzn7CPUhepa2GQDLKJ2Cjc5BC+3x2IblHQU1C0ppA=;
 b=Cov4ePHSXSTMyrZuwAELBHr8pBn9xU3jLKtHsrGSzoVULGvDbOLZAzZg9dKoL5JWAM9yFS
 e3v/mXL5NDAthaGfVHOSpyNzUXDuPzoZ0/Ef3p+GSkduFohdZQizuyDhb+YsPFD4u7dgjk
 ZOrQItgsZVXu5TKCXsm5NTRDll6LgzA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-yCJTZlnzNNqflf105nY9zw-1; Thu, 02 Nov 2023 04:43:33 -0400
X-MC-Unique: yCJTZlnzNNqflf105nY9zw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-408f9cee5e8so4437075e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 01:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698914613; x=1699519413;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ibVzn7CPUhepa2GQDLKJ2Cjc5BC+3x2IblHQU1C0ppA=;
 b=wEX47/ZcdXryUoOf58ChM9hklP7oIBHJGqF/kLjeZ90ABbZkCFV5+nLWeGGVLrzzfp
 F2e+eqtzeTHRx898ctxCYJ9WrpZPnwvkclE4SEVtNZR9SljIV1iG7FP6r1NF1pojWKAJ
 e5RwTjcLp1UK5WWzy3QicgXwudrNIMC7zb300/OSbMT9gdvgpGV3EXdXaj7ZN7WmLFeE
 qC5xaF4/g/Uu2mcwlOlNuJD1oOjN1T7v+s6cUetjNyoOm7M/0dP73jpvIp92CxhBL8/A
 NDSHCgkZut/fztN1pFnHzqocvhVTWlo7EOMe7lUyYQ2qWPwqapbPRJK9gmFKZf0MYu2G
 6MJg==
X-Gm-Message-State: AOJu0YxxBGQChebLqyy29hXUNQe9TjRc4IRhsEJbJdYPFmyl1ccYjS+T
 rIYxd3w6+kqmQ+qQwHNF0g8FmYB3CtaY0Dccfsx9oYeVHN39cGhknYa/jNqejtxDepa6EaQ1CPd
 qf0HsALDq6+sKe+k=
X-Received: by 2002:a05:600c:1913:b0:401:b1c6:97dc with SMTP id
 j19-20020a05600c191300b00401b1c697dcmr13717308wmq.23.1698914612695; 
 Thu, 02 Nov 2023 01:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF4LZAI6NSWGiVGxff93qZcWwxedD5d9rm4jxMDpJgqjadHiJCu0PH6jiCgb2GRsoNQ8xtqg==
X-Received: by 2002:a05:600c:1913:b0:401:b1c6:97dc with SMTP id
 j19-20020a05600c191300b00401b1c697dcmr13717293wmq.23.1698914612089; 
 Thu, 02 Nov 2023 01:43:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c716:3000:f155:cef2:ff4d:c7?
 (p200300cbc7163000f155cef2ff4d00c7.dip0.t-ipconnect.de.
 [2003:cb:c716:3000:f155:cef2:ff4d:c7])
 by smtp.gmail.com with ESMTPSA id
 y20-20020a1c4b14000000b00406408dc788sm2079021wma.44.2023.11.02.01.43.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 01:43:31 -0700 (PDT)
Message-ID: <e6773ec5-dea2-4aea-bb94-a08b3e6cd49c@redhat.com>
Date: Thu, 2 Nov 2023 09:43:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/avocado: add test to exercize processor address
 space memory bound checks
To: Ani Sinha <anisinha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Cc: imammedo@redhat.com, qemu-devel@nongnu.org
References: <20231027104219.36248-1-anisinha@redhat.com>
 <66F15BF6-78AD-4DDF-90A2-F8364483AD5B@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <66F15BF6-78AD-4DDF-90A2-F8364483AD5B@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 01.11.23 02:29, Ani Sinha wrote:
> 
> 
>> On 27-Oct-2023, at 4:12 PM, Ani Sinha <anisinha@redhat.com> wrote:
>>
>> QEMU has validations to make sure that a VM is not started with more memory
>> (static and hotpluggable memory) than what the guest processor can address
>> directly with its addressing bits. This change adds a test to make sure QEMU
>> fails to start with a specific error message when an attempt is made to
>> start a VM with more memory than what the processor can directly address.
>> The test also checks for passing cases when the address space of the processor
>> is capable of addressing all memory. Boundary cases are tested.
>>
>> CC: imammedo@redhat.com
>> CC: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> 
> Gentle ping on this. David does these tests look good and cover all cases more or less?

Hi,

sorry, for some reason the patches never made it to my inbox.

> 
>> ---
>> tests/avocado/mem-addr-space-check.py | 331 ++++++++++++++++++++++++++
>> 1 file changed, 331 insertions(+)
>> create mode 100644 tests/avocado/mem-addr-space-check.py
>>
>> Changelog:
>> v3: added pae tests as well.
>> v2: added 64-bit tests. Added cxl tests.
>>
>> Sample run:
>> $ ./pyvenv/bin/avocado run tests/avocado/mem-addr-space-check.py --tap -
>> 1..14
>> ok 1 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_pse36
>> ok 2 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_pae
>> ok 3 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium_pse36
>> ok 4 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium_pae
>> ok 5 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium2
>> ok 6 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_nonpse36
>> ok 7 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q35_70_amd
>> ok 8 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q35_71_amd
>> ok 9 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35_70_amd
>> ok 10 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35_71_amd
>> ok 11 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35_71_intel
>> ok 12 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q35_71_amd_41bits
>> ok 13 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q35_intel_cxl
>> ok 14 tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35_intel_cxl
>>
>> diff --git a/tests/avocado/mem-addr-space-check.py b/tests/avocado/mem-addr-space-check.py
>> new file mode 100644
>> index 0000000000..6ded11d658
>> --- /dev/null
>> +++ b/tests/avocado/mem-addr-space-check.py
>> @@ -0,0 +1,331 @@
>> +# Check for crash when using memory beyond the available guest processor
>> +# address space.
>> +#
>> +# Copyright (c) 2023 Red Hat, Inc.
>> +#
>> +# Author:
>> +#  Ani Sinha <anisinha@redhat.com>
>> +#
>> +# This program is free software; you can redistribute it and/or modify
>> +# it under the terms of the GNU General Public License as published by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
>> +
>> +from avocado_qemu import QemuSystemTest
>> +import signal
>> +
>> +class MemAddrCheck(QemuSystemTest):
>> +    # first, lets test some 32-bit processors.
>> +    # for all 32-bit cases, pci64_hole_size is 0.
>> +    def test_phybits_low_pse36(self):
>> +        """
>> +        :avocado: tags=machine:q35
>> +        :avocado: tags=arch:x86_64
>> +
>> +        With pse36 feature ON, a processor has 36 bits of addressing. So it can
>> +        access up to a maximum of 64GiB of memory. Memory hotplug region begins
>> +        at 4 GiB boundary when "above_4g_mem_size" is 0 (this would be true when
>> +        we have 0.5 GiB of VM memory, see pc_q35_init()). This means total
>> +        hotpluggable memory size is 60 GiB. Per slot, we reserve 1 GiB of memory
>> +        for dimm alignment for all newer machines (see enforce_aligned_dimm
>> +        property for pc machines and pc_get_device_memory_range()). That leaves
>> +        total hotpluggable actual memory size of 59 GiB. If the VM is started
>> +        with 0.5 GiB of memory, maxmem should be set to a maximum value of
>> +        59.5 GiB to ensure that the processor can address all memory directly.
>> +        Note that 64-bit pci hole size is 0 in this case. If maxmem is set to
>> +        59.6G, QEMU should fail to start with a message "phy-bits are too low".
>> +        If maxmem is set to 59.5G with all other QEMU parameters identical, QEMU
>> +        should start fine.
>> +        """
>> +        self.vm.add_args('-S', '-machine', 'q35', '-m',
>> +                         '512,slots=1,maxmem=59.6G',
>> +                         '-cpu', 'pentium,pse36=on', '-display', 'none',
>> +                         '-object', 'memory-backend-ram,id=mem1,size=1G',
>> +                         '-device', 'virtio-mem-pci,id=vm0,memdev=mem1')

Just a note that for virtio-mem, you don't even have to reserve an (ACPI NVDIMM/DIMM) slot.
So you might get away just setting "slots=0" and using maxmem=60.6G,
making it possible to simplify the comment(s) a bit (and all the other test cases).

Otherwise, maybe clearer use a DIMM instead of a virtio-mem device.

>> +        self.vm.set_qmp_monitor(enabled=False)
>> +        self.vm.launch()
>> +        self.vm.wait()
>> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
>> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>> +
>> +    def test_phybits_low_pae(self):
>> +        """
>> +        :avocado: tags=machine:q35
>> +        :avocado: tags=arch:x86_64
>> +
>> +        With pae feature ON, a processor has 36 bits of addressing. So it can
>> +        access up to a maximum of 64GiB of memory. Rest is the same as the case
>> +        with pse36 above.
>> +        """
>> +        self.vm.add_args('-S', '-machine', 'q35', '-m',
>> +                         '512,slots=1,maxmem=59.6G',
>> +                         '-cpu', 'pentium,pae=on', '-display', 'none',
>> +                         '-object', 'memory-backend-ram,id=mem1,size=1G',
>> +                         '-device', 'virtio-mem-pci,id=vm0,memdev=mem1')

Same considerations.

>> +        self.vm.set_qmp_monitor(enabled=False)
>> +        self.vm.launch()
>> +        self.vm.wait()
>> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
>> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>> +
>> +    def test_phybits_ok_pentium_pse36(self):
>> +        """
>> +        :avocado: tags=machine:q35
>> +        :avocado: tags=arch:x86_64
>> +
>> +        Setting maxmem to 59.5G and making sure that QEMU can start with the
>> +        same options as the failing case above with pse36 cpu feature.
>> +        """
>> +        self.vm.add_args('-machine', 'q35', '-m',
>> +                         '512,slots=1,maxmem=59.5G',
>> +                         '-cpu', 'pentium,pse36=on', '-display', 'none',
>> +                         '-object', 'memory-backend-ram,id=mem1,size=1G',
>> +                         '-device', 'virtio-mem-pci,id=vm0,memdev=mem1')
>> +        self.vm.set_qmp_monitor(enabled=False)
>> +        self.vm.launch()
>> +        self.vm.shutdown()
>> +        self.assertEquals(self.vm.exitcode(), -signal.SIGTERM,
>> +                          "QEMU did not terminate gracefully upon SIGTERM")
>> +
>> +    def test_phybits_ok_pentium_pae(self):
>> +        """
>> +        :avocado: tags=machine:q35
>> +        :avocado: tags=arch:x86_64
>> +
>> +        Test is same as above but now with pae CPUID turned on. Setting

s/CPUID/cpu feture/ ?

>> +        maxmem to 59.5G and making sure that QEMU can start fine with the
>> +        same options as the case above.
>> +        """
>> +        self.vm.add_args('-machine', 'q35', '-m',
>> +                         '512,slots=1,maxmem=59.5G',
>> +                         '-cpu', 'pentium,pae=on', '-display', 'none',
>> +                         '-object', 'memory-backend-ram,id=mem1,size=1G',
>> +                         '-device', 'virtio-mem-pci,id=vm0,memdev=mem1')
>> +        self.vm.set_qmp_monitor(enabled=False)
>> +        self.vm.launch()
>> +        self.vm.shutdown()
>> +        self.assertEquals(self.vm.exitcode(), -signal.SIGTERM,
>> +                          "QEMU did not terminate gracefully upon SIGTERM")
>> +
>> +    def test_phybits_ok_pentium2(self):
>> +        """
>> +        :avocado: tags=machine:q35
>> +        :avocado: tags=arch:x86_64
>> +
>> +        Pentium2 has 36 bits of addressing, so its same as pentium
>> +        with pse36 ON.
>> +        """
>> +        self.vm.add_args('-machine', 'q35', '-m',
>> +                         '512,slots=1,maxmem=59.5G',
>> +                         '-cpu', 'pentium2', '-display', 'none',
>> +                         '-object', 'memory-backend-ram,id=mem1,size=1G',
>> +                         '-device', 'virtio-mem-pci,id=vm0,memdev=mem1')
>> +        self.vm.set_qmp_monitor(enabled=False)
>> +        self.vm.launch()
>> +        self.vm.shutdown()
>> +        self.assertEquals(self.vm.exitcode(), -signal.SIGTERM,
>> +                          "QEMU did not terminate gracefully upon SIGTERM")
>> +
>> +    def test_phybits_low_nonpse36(self):
>> +        """
>> +        :avocado: tags=machine:q35
>> +        :avocado: tags=arch:x86_64
>> +
>> +        Pentium processor has 32 bits of addressing without pse36 or pae
>> +        so it can access up to 4 GiB of memory. Setting maxmem to 4GiB

"access physical addresses up to 4 GiB"

>> +        should make QEMU fail to start with "phys-bits too low" message.

"because the region for memory hotplug is always placed above 4 GiB due to the
PCI hole and simplicity."

>> +        """
>> +        self.vm.add_args('-S', '-machine', 'q35', '-m',
>> +                         '512,slots=1,maxmem=4G',
>> +                         '-cpu', 'pentium', '-display', 'none',
>> +                         '-object', 'memory-backend-ram,id=mem1,size=1G',
>> +                         '-device', 'virtio-mem-pci,id=vm0,memdev=mem1')
>> +        self.vm.set_qmp_monitor(enabled=False)
>> +        self.vm.launch()
>> +        self.vm.wait()
>> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code should be 1")
>> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>> +
>> +    # now lets test some 64-bit CPU cases.
>> +    def test_phybits_low_tcg_q35_70_amd(self):
>> +        """
>> +        :avocado: tags=machine:q35
>> +        :avocado: tags=arch:x86_64
>> +
>> +        For q35 7.1 machines and above, "above_4G" memory starts at 1 TiB
>> +        boundary for AMD cpus (default). Lets test without that case.

^ first time I hear about that. Weird AMD-specific stuff, really.

     /*
      * The HyperTransport range close to the 1T boundary is unique to AMD
      * hosts with IOMMUs enabled. Restrict the ram-above-4g relocation
      * to above 1T to AMD vCPUs only. @enforce_amd_1tb_hole is only false in
      * older machine types (<= 7.0) for compatibility purposes.
      */
     if (IS_AMD_CPU(&cpu->env) && pcmc->enforce_amd_1tb_hole) {
         /* Bail out if max possible address does not cross HT range */
         if (pc_max_used_gpa(pcms, pci_hole64_size) >= AMD_HT_START) {
             x86ms->above_4g_mem_start = AMD_ABOVE_1TB_START;

So there is a fixed memory hole that starts at 0xfd00000000UL. If our max GPA would
overlap that region, we'll place everything above that memory hole.


         }

         /*
          * Advertise the HT region if address space covers the reserved
          * region or if we relocate.
          */
         if (cpu->phys_bits >= 40) {
             e820_add_entry(AMD_HT_START, AMD_HT_SIZE, E820_RESERVED);
         }
     }

I don't think your desciption is quite correct for that case. "above_4G" only starts above
1 TiB if it would overlap that special memory hole starting at 0xfd00000000UL.


-- 
Cheers,

David / dhildenb



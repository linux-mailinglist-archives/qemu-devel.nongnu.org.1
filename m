Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E467E1E3A
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 11:28:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzwpC-00028I-9b; Mon, 06 Nov 2023 05:27:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qzwp7-00027j-Q5
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:27:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qzwp4-0005HS-FN
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 05:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699266429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jNFTF/EiV79cB9MNy/0MakV0nn+e1HNvV1qSY3MHXIE=;
 b=Js7gQGMJmO5jOsTxKOa2CvNedsXhlJU5VDjGK3WxokorX3hanDEkuMUKG13WduTDoRXCxt
 CW0G3UJm87wgaLy/OliIuzQTS+bBwhuyyNDiD4v6a1bbspmnsyB44cDr7xRZbCEKPm1yQF
 Dbru/4FQ3LP4v4BLpzsNvf6RfF6Nuf8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-Lr8hKFARNxyWvt7F7BAOsA-1; Mon, 06 Nov 2023 05:26:28 -0500
X-MC-Unique: Lr8hKFARNxyWvt7F7BAOsA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6b3e4c22dabso2959331b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 02:26:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699266387; x=1699871187;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNFTF/EiV79cB9MNy/0MakV0nn+e1HNvV1qSY3MHXIE=;
 b=vfN6XgooI96q55AoA/tDaHP3r5MVbr4GTNsuvdohs1AEceR0pxhGu4Sc+4y1Ck63wh
 qcDb8Q3cHazaL/osEW59O+OJg8yL2fTH6jgmzyxalk1/tV/WVmurO3dlRse+eWCgU0Af
 PTSfbfYpQvuzgKm7cDGF/iRXvn/uTWW109ndZtLy2gqcn+L/JCgtMn7Q1tUqt1ksv3Hm
 u6ZUtrAmO+/3jwJxNyuMv4tACBUKBr2V4y7BxImH0oeG2s7RTtfIMGLRNX/NiJCV5cxr
 oV2ewBESvkyA6jWpKbRtCKHKH1NsD/w5X6+3deGon/1aX+6DC9dxplOb4JXl8m/tuwVI
 fFaA==
X-Gm-Message-State: AOJu0Yzksxeij4R4uQYSWjbojEjAMBc2UDbVIRcKKB2zKhoQrqEKbTrU
 0ZOUTFXyQFOSsfWxbCPnfn5FqwCl4RiQycM+D5eatRNODUqbGEJzhJFUROlYseel7YCn3ewMdTQ
 QhsaDSu06NDBupfw=
X-Received: by 2002:a05:6300:800a:b0:180:f9c4:a796 with SMTP id
 an10-20020a056300800a00b00180f9c4a796mr15942001pzc.54.1699266387181; 
 Mon, 06 Nov 2023 02:26:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9Ec+IresupHtvm5dtxh9eZ5wokccol0VVxKaSx2kNbzDGKOHewEQsG3XHSWCICq3ga5iYEg==
X-Received: by 2002:a05:6300:800a:b0:180:f9c4:a796 with SMTP id
 an10-20020a056300800a00b00180f9c4a796mr15941982pzc.54.1699266386708; 
 Mon, 06 Nov 2023 02:26:26 -0800 (PST)
Received: from smtpclient.apple ([115.96.199.186])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a056a0007c700b006bdb0f011e2sm5380536pfu.123.2023.11.06.02.26.24
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 06 Nov 2023 02:26:26 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH v3] tests/avocado: add test to exercize processor address
 space memory bound checks
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <e6773ec5-dea2-4aea-bb94-a08b3e6cd49c@redhat.com>
Date: Mon, 6 Nov 2023 15:56:22 +0530
Cc: Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6E448F8A-4508-4D94-BDC0-93DD5BAEB681@redhat.com>
References: <20231027104219.36248-1-anisinha@redhat.com>
 <66F15BF6-78AD-4DDF-90A2-F8364483AD5B@redhat.com>
 <e6773ec5-dea2-4aea-bb94-a08b3e6cd49c@redhat.com>
To: David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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



> On 02-Nov-2023, at 2:13 PM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 01.11.23 02:29, Ani Sinha wrote:
>>> On 27-Oct-2023, at 4:12 PM, Ani Sinha <anisinha@redhat.com> wrote:
>>>=20
>>> QEMU has validations to make sure that a VM is not started with more =
memory
>>> (static and hotpluggable memory) than what the guest processor can =
address
>>> directly with its addressing bits. This change adds a test to make =
sure QEMU
>>> fails to start with a specific error message when an attempt is made =
to
>>> start a VM with more memory than what the processor can directly =
address.
>>> The test also checks for passing cases when the address space of the =
processor
>>> is capable of addressing all memory. Boundary cases are tested.
>>>=20
>>> CC: imammedo@redhat.com
>>> CC: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> Gentle ping on this. David does these tests look good and cover all =
cases more or less?
>=20
> Hi,
>=20
> sorry, for some reason the patches never made it to my inbox.
>=20
>>> ---
>>> tests/avocado/mem-addr-space-check.py | 331 =
++++++++++++++++++++++++++
>>> 1 file changed, 331 insertions(+)
>>> create mode 100644 tests/avocado/mem-addr-space-check.py
>>>=20
>>> Changelog:
>>> v3: added pae tests as well.
>>> v2: added 64-bit tests. Added cxl tests.
>>>=20
>>> Sample run:
>>> $ ./pyvenv/bin/avocado run tests/avocado/mem-addr-space-check.py =
--tap -
>>> 1..14
>>> ok 1 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_pse36
>>> ok 2 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_pae
>>> ok 3 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium=
_pse36
>>> ok 4 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium=
_pae
>>> ok 5 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium=
2
>>> ok 6 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_nonpse=
36
>>> ok 7 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q3=
5_70_amd
>>> ok 8 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q3=
5_71_amd
>>> ok 9 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35=
_70_amd
>>> ok 10 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35=
_71_amd
>>> ok 11 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35=
_71_intel
>>> ok 12 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q3=
5_71_amd_41bits
>>> ok 13 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q3=
5_intel_cxl
>>> ok 14 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35=
_intel_cxl
>>>=20
>>> diff --git a/tests/avocado/mem-addr-space-check.py =
b/tests/avocado/mem-addr-space-check.py
>>> new file mode 100644
>>> index 0000000000..6ded11d658
>>> --- /dev/null
>>> +++ b/tests/avocado/mem-addr-space-check.py
>>> @@ -0,0 +1,331 @@
>>> +# Check for crash when using memory beyond the available guest =
processor
>>> +# address space.
>>> +#
>>> +# Copyright (c) 2023 Red Hat, Inc.
>>> +#
>>> +# Author:
>>> +#  Ani Sinha <anisinha@redhat.com>
>>> +#
>>> +# This program is free software; you can redistribute it and/or =
modify
>>> +# it under the terms of the GNU General Public License as published =
by
>>> +# the Free Software Foundation; either version 2 of the License, or
>>> +# (at your option) any later version.
>>> +#
>>> +# This program is distributed in the hope that it will be useful,
>>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> +# GNU General Public License for more details.
>>> +#
>>> +# You should have received a copy of the GNU General Public License
>>> +# along with this program.  If not, see =
<http://www.gnu.org/licenses/>.
>>> +
>>> +from avocado_qemu import QemuSystemTest
>>> +import signal
>>> +
>>> +class MemAddrCheck(QemuSystemTest):
>>> +    # first, lets test some 32-bit processors.
>>> +    # for all 32-bit cases, pci64_hole_size is 0.
>>> +    def test_phybits_low_pse36(self):
>>> +        """
>>> +        :avocado: tags=3Dmachine:q35
>>> +        :avocado: tags=3Darch:x86_64
>>> +
>>> +        With pse36 feature ON, a processor has 36 bits of =
addressing. So it can
>>> +        access up to a maximum of 64GiB of memory. Memory hotplug =
region begins
>>> +        at 4 GiB boundary when "above_4g_mem_size" is 0 (this would =
be true when
>>> +        we have 0.5 GiB of VM memory, see pc_q35_init()). This =
means total
>>> +        hotpluggable memory size is 60 GiB. Per slot, we reserve 1 =
GiB of memory
>>> +        for dimm alignment for all newer machines (see =
enforce_aligned_dimm
>>> +        property for pc machines and pc_get_device_memory_range()). =
That leaves
>>> +        total hotpluggable actual memory size of 59 GiB. If the VM =
is started
>>> +        with 0.5 GiB of memory, maxmem should be set to a maximum =
value of
>>> +        59.5 GiB to ensure that the processor can address all =
memory directly.
>>> +        Note that 64-bit pci hole size is 0 in this case. If maxmem =
is set to
>>> +        59.6G, QEMU should fail to start with a message "phy-bits =
are too low".
>>> +        If maxmem is set to 59.5G with all other QEMU parameters =
identical, QEMU
>>> +        should start fine.
>>> +        """
>>> +        self.vm.add_args('-S', '-machine', 'q35', '-m',
>>> +                         '512,slots=3D1,maxmem=3D59.6G',
>>> +                         '-cpu', 'pentium,pse36=3Don', '-display', =
'none',
>>> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
>>> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
>=20
> Just a note that for virtio-mem, you don't even have to reserve an =
(ACPI NVDIMM/DIMM) slot.
> So you might get away just setting "slots=3D0" and using maxmem=3D60.6G,=


Ah ok I see https://lwn.net/Articles/755423/  :-)=20

> making it possible to simplify the comment(s) a bit (and all the other =
test cases).
>=20
> Otherwise, maybe clearer use a DIMM instead of a virtio-mem device.

I went with this approach in v4/v5.

>=20
>>> +        self.vm.set_qmp_monitor(enabled=3DFalse)
>>> +        self.vm.launch()
>>> +        self.vm.wait()
>>> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>>> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>>> +
>>> +    def test_phybits_low_pae(self):
>>> +        """
>>> +        :avocado: tags=3Dmachine:q35
>>> +        :avocado: tags=3Darch:x86_64
>>> +
>>> +        With pae feature ON, a processor has 36 bits of addressing. =
So it can
>>> +        access up to a maximum of 64GiB of memory. Rest is the same =
as the case
>>> +        with pse36 above.
>>> +        """
>>> +        self.vm.add_args('-S', '-machine', 'q35', '-m',
>>> +                         '512,slots=3D1,maxmem=3D59.6G',
>>> +                         '-cpu', 'pentium,pae=3Don', '-display', =
'none',
>>> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
>>> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
>=20
> Same considerations.
>=20
>>> +        self.vm.set_qmp_monitor(enabled=3DFalse)
>>> +        self.vm.launch()
>>> +        self.vm.wait()
>>> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>>> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>>> +
>>> +    def test_phybits_ok_pentium_pse36(self):
>>> +        """
>>> +        :avocado: tags=3Dmachine:q35
>>> +        :avocado: tags=3Darch:x86_64
>>> +
>>> +        Setting maxmem to 59.5G and making sure that QEMU can start =
with the
>>> +        same options as the failing case above with pse36 cpu =
feature.
>>> +        """
>>> +        self.vm.add_args('-machine', 'q35', '-m',
>>> +                         '512,slots=3D1,maxmem=3D59.5G',
>>> +                         '-cpu', 'pentium,pse36=3Don', '-display', =
'none',
>>> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
>>> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
>>> +        self.vm.set_qmp_monitor(enabled=3DFalse)
>>> +        self.vm.launch()
>>> +        self.vm.shutdown()
>>> +        self.assertEquals(self.vm.exitcode(), -signal.SIGTERM,
>>> +                          "QEMU did not terminate gracefully upon =
SIGTERM")
>>> +
>>> +    def test_phybits_ok_pentium_pae(self):
>>> +        """
>>> +        :avocado: tags=3Dmachine:q35
>>> +        :avocado: tags=3Darch:x86_64
>>> +
>>> +        Test is same as above but now with pae CPUID turned on. =
Setting
>=20
> s/CPUID/cpu feture/ ?
>=20
>>> +        maxmem to 59.5G and making sure that QEMU can start fine =
with the
>>> +        same options as the case above.
>>> +        """
>>> +        self.vm.add_args('-machine', 'q35', '-m',
>>> +                         '512,slots=3D1,maxmem=3D59.5G',
>>> +                         '-cpu', 'pentium,pae=3Don', '-display', =
'none',
>>> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
>>> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
>>> +        self.vm.set_qmp_monitor(enabled=3DFalse)
>>> +        self.vm.launch()
>>> +        self.vm.shutdown()
>>> +        self.assertEquals(self.vm.exitcode(), -signal.SIGTERM,
>>> +                          "QEMU did not terminate gracefully upon =
SIGTERM")
>>> +
>>> +    def test_phybits_ok_pentium2(self):
>>> +        """
>>> +        :avocado: tags=3Dmachine:q35
>>> +        :avocado: tags=3Darch:x86_64
>>> +
>>> +        Pentium2 has 36 bits of addressing, so its same as pentium
>>> +        with pse36 ON.
>>> +        """
>>> +        self.vm.add_args('-machine', 'q35', '-m',
>>> +                         '512,slots=3D1,maxmem=3D59.5G',
>>> +                         '-cpu', 'pentium2', '-display', 'none',
>>> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
>>> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
>>> +        self.vm.set_qmp_monitor(enabled=3DFalse)
>>> +        self.vm.launch()
>>> +        self.vm.shutdown()
>>> +        self.assertEquals(self.vm.exitcode(), -signal.SIGTERM,
>>> +                          "QEMU did not terminate gracefully upon =
SIGTERM")
>>> +
>>> +    def test_phybits_low_nonpse36(self):
>>> +        """
>>> +        :avocado: tags=3Dmachine:q35
>>> +        :avocado: tags=3Darch:x86_64
>>> +
>>> +        Pentium processor has 32 bits of addressing without pse36 =
or pae
>>> +        so it can access up to 4 GiB of memory. Setting maxmem to =
4GiB
>=20
> "access physical addresses up to 4 GiB"
>=20
>>> +        should make QEMU fail to start with "phys-bits too low" =
message.
>=20
> "because the region for memory hotplug is always placed above 4 GiB =
due to the
> PCI hole and simplicity."
>=20
>>> +        """
>>> +        self.vm.add_args('-S', '-machine', 'q35', '-m',
>>> +                         '512,slots=3D1,maxmem=3D4G',
>>> +                         '-cpu', 'pentium', '-display', 'none',
>>> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
>>> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
>>> +        self.vm.set_qmp_monitor(enabled=3DFalse)
>>> +        self.vm.launch()
>>> +        self.vm.wait()
>>> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>>> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>>> +
>>> +    # now lets test some 64-bit CPU cases.
>>> +    def test_phybits_low_tcg_q35_70_amd(self):
>>> +        """
>>> +        :avocado: tags=3Dmachine:q35
>>> +        :avocado: tags=3Darch:x86_64
>>> +
>>> +        For q35 7.1 machines and above, "above_4G" memory starts at =
1 TiB
>>> +        boundary for AMD cpus (default). Lets test without that =
case.
>=20
> ^ first time I hear about that. Weird AMD-specific stuff, really.
>=20
>    /*
>     * The HyperTransport range close to the 1T boundary is unique to =
AMD
>     * hosts with IOMMUs enabled. Restrict the ram-above-4g relocation
>     * to above 1T to AMD vCPUs only. @enforce_amd_1tb_hole is only =
false in
>     * older machine types (<=3D 7.0) for compatibility purposes.
>     */
>    if (IS_AMD_CPU(&cpu->env) && pcmc->enforce_amd_1tb_hole) {
>        /* Bail out if max possible address does not cross HT range */
>        if (pc_max_used_gpa(pcms, pci_hole64_size) >=3D AMD_HT_START) {
>            x86ms->above_4g_mem_start =3D AMD_ABOVE_1TB_START;
>=20
> So there is a fixed memory hole that starts at 0xfd00000000UL. If our =
max GPA would
> overlap that region, we'll place everything above that memory hole.
>=20
>=20
>        }
>=20
>        /*
>         * Advertise the HT region if address space covers the reserved
>         * region or if we relocate.
>         */
>        if (cpu->phys_bits >=3D 40) {
>            e820_add_entry(AMD_HT_START, AMD_HT_SIZE, E820_RESERVED);
>        }
>    }
>=20
> I don't think your desciption is quite correct for that case. =
"above_4G" only starts above
> 1 TiB if it would overlap that special memory hole starting at =
0xfd00000000UL.
>=20
>=20
> --=20
> Cheers,
>=20
> David / dhildenb



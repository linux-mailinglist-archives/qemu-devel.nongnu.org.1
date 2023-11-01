Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF837DDA9C
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 02:30:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qy02q-0002PR-Fs; Tue, 31 Oct 2023 21:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qy02n-0002PC-Bi
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 21:29:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qy02k-00061t-NY
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 21:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698802152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wMgDykzjXe1fn7mt5HKyqGta1k/1LPosXieo7FVLMW8=;
 b=QROl8/WZHGdV2C1kg+ACeepoAGObVdxv/q737vcBmIW4qygT98Gom15M/UdIFivlYKq7Jz
 rixsnnzyuC52VM6msEFwSqh05+Of8LhK3IFNqr308Qc8xL3eyJeGVWi9gxIgRAtG9plyRR
 tH/WPa6OnaaQz/qJoewf9rsA9tlMehU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-NQWqwL3uMQaa9YZUAk-tgA-1; Tue, 31 Oct 2023 21:29:10 -0400
X-MC-Unique: NQWqwL3uMQaa9YZUAk-tgA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2804e851d5cso2680939a91.0
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 18:29:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698802150; x=1699406950;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wMgDykzjXe1fn7mt5HKyqGta1k/1LPosXieo7FVLMW8=;
 b=ikVEnr0MLvMGC3WyIFgzZo4di+ZxXS5Zq63/1ZTOtjOeYPYAFkliIgOQfI18kQA2+8
 QF3mOH70wM/Dz8PKGz0osMitUSFbNt8rg6eqRs/eRT0pzgm8AtU4gsqbWtDaJaJR4v/C
 8vrn8m1RRc+aBpyOFgGQCAULleuvJVK+JYk7EZhnxUOfQ/AnC8hkaouY63zsQqpK79x6
 uzxefqZCtwZ2N7/gSGI9EWmPrvVoCH71HcT3MyGqJRcplshRSYTeXK7pnb1/ANbknZ5m
 i5cu8XRhDIBllbGKoFhmtiATzF8FCNo48ZVhqujjOMY0uK8fHeEiPneJs5vxXsUAYRYI
 B7GA==
X-Gm-Message-State: AOJu0YxQJyeMFXaOuVuMynvluhQGsawtUo20QBsoCzTe8cH59PPRWtZ0
 O0lXXQ2BYbaryq8/cPBPjaGznhd2S7WO4LdGBYcgQrV0k1bv+U4aZbXxNkdmlndVE5lLmHfWsal
 FnyVimED2gTUJFSw=
X-Received: by 2002:a17:90a:d497:b0:27f:ecd9:6d0e with SMTP id
 s23-20020a17090ad49700b0027fecd96d0emr12943659pju.34.1698802149473; 
 Tue, 31 Oct 2023 18:29:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5kL8coFwCX5kOat94BELo8tFdv1gKBvO6vxr8VwWjGYm02BPn6uHIVnogh6sKaQK8t543aw==
X-Received: by 2002:a17:90a:d497:b0:27f:ecd9:6d0e with SMTP id
 s23-20020a17090ad49700b0027fecd96d0emr12943646pju.34.1698802148967; 
 Tue, 31 Oct 2023 18:29:08 -0700 (PDT)
Received: from smtpclient.apple ([115.96.138.89])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a17090a2dce00b00274b9dd8519sm1586426pjm.35.2023.10.31.18.29.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Oct 2023 18:29:08 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.4\))
Subject: Re: [PATCH v3] tests/avocado: add test to exercize processor address
 space memory bound checks
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20231027104219.36248-1-anisinha@redhat.com>
Date: Wed, 1 Nov 2023 06:59:04 +0530
Cc: imammedo@redhat.com, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <66F15BF6-78AD-4DDF-90A2-F8364483AD5B@redhat.com>
References: <20231027104219.36248-1-anisinha@redhat.com>
To: Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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



> On 27-Oct-2023, at 4:12 PM, Ani Sinha <anisinha@redhat.com> wrote:
>=20
> QEMU has validations to make sure that a VM is not started with more =
memory
> (static and hotpluggable memory) than what the guest processor can =
address
> directly with its addressing bits. This change adds a test to make =
sure QEMU
> fails to start with a specific error message when an attempt is made =
to
> start a VM with more memory than what the processor can directly =
address.
> The test also checks for passing cases when the address space of the =
processor
> is capable of addressing all memory. Boundary cases are tested.
>=20
> CC: imammedo@redhat.com
> CC: David Hildenbrand <david@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Gentle ping on this. David does these tests look good and cover all =
cases more or less?

> ---
> tests/avocado/mem-addr-space-check.py | 331 ++++++++++++++++++++++++++
> 1 file changed, 331 insertions(+)
> create mode 100644 tests/avocado/mem-addr-space-check.py
>=20
> Changelog:
> v3: added pae tests as well.
> v2: added 64-bit tests. Added cxl tests.
>=20
> Sample run:
> $ ./pyvenv/bin/avocado run tests/avocado/mem-addr-space-check.py --tap =
-
> 1..14
> ok 1 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_pse36
> ok 2 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_pae
> ok 3 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium=
_pse36
> ok 4 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium=
_pae
> ok 5 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium=
2
> ok 6 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_nonpse=
36
> ok 7 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q3=
5_70_amd
> ok 8 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q3=
5_71_amd
> ok 9 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35=
_70_amd
> ok 10 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35=
_71_amd
> ok 11 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35=
_71_intel
> ok 12 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q3=
5_71_amd_41bits
> ok 13 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q3=
5_intel_cxl
> ok 14 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35=
_intel_cxl
>=20
> diff --git a/tests/avocado/mem-addr-space-check.py =
b/tests/avocado/mem-addr-space-check.py
> new file mode 100644
> index 0000000000..6ded11d658
> --- /dev/null
> +++ b/tests/avocado/mem-addr-space-check.py
> @@ -0,0 +1,331 @@
> +# Check for crash when using memory beyond the available guest =
processor
> +# address space.
> +#
> +# Copyright (c) 2023 Red Hat, Inc.
> +#
> +# Author:
> +#  Ani Sinha <anisinha@redhat.com>
> +#
> +# This program is free software; you can redistribute it and/or =
modify
> +# it under the terms of the GNU General Public License as published =
by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see =
<http://www.gnu.org/licenses/>.
> +
> +from avocado_qemu import QemuSystemTest
> +import signal
> +
> +class MemAddrCheck(QemuSystemTest):
> +    # first, lets test some 32-bit processors.
> +    # for all 32-bit cases, pci64_hole_size is 0.
> +    def test_phybits_low_pse36(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Darch:x86_64
> +
> +        With pse36 feature ON, a processor has 36 bits of addressing. =
So it can
> +        access up to a maximum of 64GiB of memory. Memory hotplug =
region begins
> +        at 4 GiB boundary when "above_4g_mem_size" is 0 (this would =
be true when
> +        we have 0.5 GiB of VM memory, see pc_q35_init()). This means =
total
> +        hotpluggable memory size is 60 GiB. Per slot, we reserve 1 =
GiB of memory
> +        for dimm alignment for all newer machines (see =
enforce_aligned_dimm
> +        property for pc machines and pc_get_device_memory_range()). =
That leaves
> +        total hotpluggable actual memory size of 59 GiB. If the VM is =
started
> +        with 0.5 GiB of memory, maxmem should be set to a maximum =
value of
> +        59.5 GiB to ensure that the processor can address all memory =
directly.
> +        Note that 64-bit pci hole size is 0 in this case. If maxmem =
is set to
> +        59.6G, QEMU should fail to start with a message "phy-bits are =
too low".
> +        If maxmem is set to 59.5G with all other QEMU parameters =
identical, QEMU
> +        should start fine.
> +        """
> +        self.vm.add_args('-S', '-machine', 'q35', '-m',
> +                         '512,slots=3D1,maxmem=3D59.6G',
> +                         '-cpu', 'pentium,pse36=3Don', '-display', =
'none',
> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
> +        self.vm.set_qmp_monitor(enabled=3DFalse)
> +        self.vm.launch()
> +        self.vm.wait()
> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
> +
> +    def test_phybits_low_pae(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Darch:x86_64
> +
> +        With pae feature ON, a processor has 36 bits of addressing. =
So it can
> +        access up to a maximum of 64GiB of memory. Rest is the same =
as the case
> +        with pse36 above.
> +        """
> +        self.vm.add_args('-S', '-machine', 'q35', '-m',
> +                         '512,slots=3D1,maxmem=3D59.6G',
> +                         '-cpu', 'pentium,pae=3Don', '-display', =
'none',
> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
> +        self.vm.set_qmp_monitor(enabled=3DFalse)
> +        self.vm.launch()
> +        self.vm.wait()
> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
> +
> +    def test_phybits_ok_pentium_pse36(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Darch:x86_64
> +
> +        Setting maxmem to 59.5G and making sure that QEMU can start =
with the
> +        same options as the failing case above with pse36 cpu =
feature.
> +        """
> +        self.vm.add_args('-machine', 'q35', '-m',
> +                         '512,slots=3D1,maxmem=3D59.5G',
> +                         '-cpu', 'pentium,pse36=3Don', '-display', =
'none',
> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
> +        self.vm.set_qmp_monitor(enabled=3DFalse)
> +        self.vm.launch()
> +        self.vm.shutdown()
> +        self.assertEquals(self.vm.exitcode(), -signal.SIGTERM,
> +                          "QEMU did not terminate gracefully upon =
SIGTERM")
> +
> +    def test_phybits_ok_pentium_pae(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Darch:x86_64
> +
> +        Test is same as above but now with pae CPUID turned on. =
Setting
> +        maxmem to 59.5G and making sure that QEMU can start fine with =
the
> +        same options as the case above.
> +        """
> +        self.vm.add_args('-machine', 'q35', '-m',
> +                         '512,slots=3D1,maxmem=3D59.5G',
> +                         '-cpu', 'pentium,pae=3Don', '-display', =
'none',
> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
> +        self.vm.set_qmp_monitor(enabled=3DFalse)
> +        self.vm.launch()
> +        self.vm.shutdown()
> +        self.assertEquals(self.vm.exitcode(), -signal.SIGTERM,
> +                          "QEMU did not terminate gracefully upon =
SIGTERM")
> +
> +    def test_phybits_ok_pentium2(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Darch:x86_64
> +
> +        Pentium2 has 36 bits of addressing, so its same as pentium
> +        with pse36 ON.
> +        """
> +        self.vm.add_args('-machine', 'q35', '-m',
> +                         '512,slots=3D1,maxmem=3D59.5G',
> +                         '-cpu', 'pentium2', '-display', 'none',
> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
> +        self.vm.set_qmp_monitor(enabled=3DFalse)
> +        self.vm.launch()
> +        self.vm.shutdown()
> +        self.assertEquals(self.vm.exitcode(), -signal.SIGTERM,
> +                          "QEMU did not terminate gracefully upon =
SIGTERM")
> +
> +    def test_phybits_low_nonpse36(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Darch:x86_64
> +
> +        Pentium processor has 32 bits of addressing without pse36 or =
pae
> +        so it can access up to 4 GiB of memory. Setting maxmem to =
4GiB
> +        should make QEMU fail to start with "phys-bits too low" =
message.
> +        """
> +        self.vm.add_args('-S', '-machine', 'q35', '-m',
> +                         '512,slots=3D1,maxmem=3D4G',
> +                         '-cpu', 'pentium', '-display', 'none',
> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
> +        self.vm.set_qmp_monitor(enabled=3DFalse)
> +        self.vm.launch()
> +        self.vm.wait()
> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
> +
> +    # now lets test some 64-bit CPU cases.
> +    def test_phybits_low_tcg_q35_70_amd(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Darch:x86_64
> +
> +        For q35 7.1 machines and above, "above_4G" memory starts at 1 =
TiB
> +        boundary for AMD cpus (default). Lets test without that case.
> +        For q35-7.0 machines, "above 4G" memory starts are 4G.
> +        pci64_hole size is 32 GiB. Since TCG_PHYS_ADDR_BITS is =
defined to
> +        be 40, TCG emulated CPUs have maximum of 1 TiB (1024 GiB) of
> +        directly addressible memory.
> +        Hence, maxmem value at most can be
> +        1024 GiB - 4 GiB - 1 GiB per slot for alignment - 32 GiB + =
0.5 GiB
> +        which is equal to 987.5 GiB. Setting the value to 988 GiB =
should
> +        make QEMU fail with the error message.
> +        """
> +        self.vm.add_args('-S', '-machine', 'pc-q35-7.0', '-m',
> +                         '512,slots=3D1,maxmem=3D988G',
> +                         '-display', 'none',
> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
> +        self.vm.set_qmp_monitor(enabled=3DFalse)
> +        self.vm.launch()
> +        self.vm.wait()
> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
> +
> +    def test_phybits_low_tcg_q35_71_amd(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Darch:x86_64
> +
> +        AMD_HT_START is defined to be at 1012 GiB. So for q35 =
machines
> +        version > 7.0 and AMD cpus, instead of 1024 GiB limit for 40 =
bit
> +        processor address space, it has to be 1012 GiB , that is 12 =
GiB
> +        less than the case above.
> +        Make sure QEMU fails when maxmem size is 976 GiB (12 GiB less
> +        than 988 GiB).
> +        """
> +        self.vm.add_args('-S', '-machine', 'pc-q35-7.1', '-m',
> +                         '512,slots=3D1,maxmem=3D976G',
> +                         '-display', 'none',
> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
> +        self.vm.set_qmp_monitor(enabled=3DFalse)
> +        self.vm.launch()
> +        self.vm.wait()
> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
> +
> +    def test_phybits_ok_tcg_q35_70_amd(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Darch:x86_64
> +
> +        Same as q35-7.0 AMD case except that here we check that QEMU =
can
> +        successfully start when maxmem is < 988G.
> +        """
> +        self.vm.add_args('-S', '-machine', 'pc-q35-7.0', '-m',
> +                         '512,slots=3D1,maxmem=3D987.5G',
> +                         '-display', 'none',
> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
> +        self.vm.set_qmp_monitor(enabled=3DFalse)
> +        self.vm.launch()
> +        self.vm.shutdown()
> +        self.assertEquals(self.vm.exitcode(), -signal.SIGTERM,
> +                          "QEMU did not terminate gracefully upon =
SIGTERM")
> +
> +    def test_phybits_ok_tcg_q35_71_amd(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Darch:x86_64
> +
> +        Same as q35-7.1 AMD case except that here we check that QEMU =
can
> +        successfully start when maxmem is < 976G.
> +        """
> +        self.vm.add_args('-S', '-machine', 'pc-q35-7.1', '-m',
> +                         '512,slots=3D1,maxmem=3D975.5G',
> +                         '-display', 'none',
> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
> +        self.vm.set_qmp_monitor(enabled=3DFalse)
> +        self.vm.launch()
> +        self.vm.shutdown()
> +        self.assertEquals(self.vm.exitcode(), -signal.SIGTERM,
> +                          "QEMU did not terminate gracefully upon =
SIGTERM")
> +
> +    def test_phybits_ok_tcg_q35_71_intel(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Darch:x86_64
> +
> +        Same parameters as test_phybits_low_tcg_q35_71_amd() but use
> +        Intel cpu instead. QEMU should start fine in this case as
> +        "above_4G" memory starts at 4G.
> +        """
> +        self.vm.add_args('-S', '-cpu', 'Skylake-Server',
> +                         '-machine', 'pc-q35-7.1', '-m',
> +                         '512,slots=3D1,maxmem=3D976G',
> +                         '-display', 'none',
> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
> +        self.vm.set_qmp_monitor(enabled=3DFalse)
> +        self.vm.launch()
> +        self.vm.shutdown()
> +        self.assertEquals(self.vm.exitcode(), -signal.SIGTERM,
> +                          "QEMU did not terminate gracefully upon =
SIGTERM")
> +
> +    def test_phybits_low_tcg_q35_71_amd_41bits(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Darch:x86_64
> +
> +        AMD processor with 41 bits. Max cpu hw address =3D 2 TiB.
> +        "above_4G" memory starts at 1 TiB for q35-7.1 machines. So =
with
> +        pci_64_hole size at 32 GiB, maxmem should be 991.5 GiB with 1 =
GiB per
> +        slot for alignment and 0.5 GiB as static memory for the VM
> +        (1024 - 32 - 1 + 0.5). With 992 GiB, QEMU should fail to =
start.
> +        """
> +        self.vm.add_args('-S', '-cpu', 'EPYC-v4,phys-bits=3D41',
> +                         '-machine', 'pc-q35-7.1', '-m',
> +                         '512,slots=3D1,maxmem=3D992G',
> +                         '-display', 'none',
> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
> +                         '-device', =
'virtio-mem-pci,id=3Dvm0,memdev=3Dmem1')
> +        self.vm.set_qmp_monitor(enabled=3DFalse)
> +        self.vm.launch()
> +        self.vm.wait()
> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
> +
> +    def test_phybits_low_tcg_q35_intel_cxl(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Darch:x86_64
> +
> +        cxl memory window starts after memory device range. Here, we =
use 1 GiB
> +        of cxl window memory. 4G_mem end aligns at 4G. pci64_hole is =
32 GiB and
> +        starts after the cxl memory window.
> +        So maxmem here should be at most 986 GiB considering all =
memory boundary
> +        alignment constraints with 40 bits (1 TiB) of processor =
physical bits.
> +        """
> +        self.vm.add_args('-S', '-cpu', 'Skylake-Server,phys-bits=3D40',=

> +                         '-machine', 'q35,cxl=3Don', '-m',
> +                         '512,slots=3D1,maxmem=3D987G',
> +                         '-display', 'none',
> +                         '-device', =
'pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1',
> +                         '-M', =
'cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D1G')
> +        self.vm.set_qmp_monitor(enabled=3DFalse)
> +        self.vm.launch()
> +        self.vm.wait()
> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
> +
> +    def test_phybits_ok_tcg_q35_intel_cxl(self):
> +        """
> +        :avocado: tags=3Dmachine:q35
> +        :avocado: tags=3Darch:x86_64
> +
> +        Same as above but here we do not reserve any cxl memory =
window. Hence,
> +        with the exact same parameters as above, QEMU should start =
fine even
> +        with cxl enabled.
> +        """
> +        self.vm.add_args('-S', '-cpu', 'Skylake-Server,phys-bits=3D40',=

> +                         '-machine', 'q35,cxl=3Don', '-m',
> +                         '512,slots=3D1,maxmem=3D987G',
> +                         '-display', 'none',
> +                         '-device', =
'pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1')
> +        self.vm.set_qmp_monitor(enabled=3DFalse)
> +        self.vm.launch()
> +        self.vm.shutdown()
> +        self.assertEquals(self.vm.exitcode(), -signal.SIGTERM,
> +                          "QEMU did not terminate gracefully upon =
SIGTERM")
> --=20
> 2.42.0
>=20



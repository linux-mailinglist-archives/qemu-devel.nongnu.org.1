Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F137C7E6261
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 03:47:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0v4I-0006ZS-Tg; Wed, 08 Nov 2023 21:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r0v4E-0006Z7-61
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 21:46:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r0v4B-0004x9-9A
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 21:46:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699498005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9uTK9lYwHscxKjBooxi8xkxLiCzeEj8YmQuNviv3caM=;
 b=cZnewNCu/kS32lj5fFde8fBCRqY/sTfTyZC8kyYVM9Xj9PK3fSSFtPSEjdGnz43K+GPb45
 EmZ5yub2IZvFE7HkiGYNPKaQxXRAxom4rTvUNuWn/uVpF8v5cIfeEIk4nH7XRMsSPn3fO1
 sJW3POTpkRIvwOvPATlVbu+hle0ZFBQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-Zye_2Vi0Ojew38gfLmPnDw-1; Wed, 08 Nov 2023 21:46:43 -0500
X-MC-Unique: Zye_2Vi0Ojew38gfLmPnDw-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6b243dc6aeeso313607b3a.3
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 18:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699498003; x=1700102803;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9uTK9lYwHscxKjBooxi8xkxLiCzeEj8YmQuNviv3caM=;
 b=EjeI0ebOXMX/Ou8Z+sbkgOaWPftkptdJOqXOmBi4UK+8nz5nrmGHa3zGLFphyJLgOM
 v6nQsNS/OZ43e3gk8uKk9g25YsJk+Deoj1B47klch6dEzWgiHG5Lr2U/8fP8BUqbdaGi
 FbtrUndQTWmN12K4kK9uTFehnYVTzMRwgfd4Lcnh7IauDAHgTLRyXymU5EccU74ioi/l
 0ZuuL6RBJrTLxWdkZsR9+N93TsTmXsqWxepxyIb5EPbd/UZ8vwM+2bGwBSfrirFdkdgw
 wLLX76E6pJlXZIz09K6c9tGOXJLEAxS/TJgTq8o+W96+6dB6lVjgmlA3Io28LxYqNfG/
 dldQ==
X-Gm-Message-State: AOJu0Yy5QbWBogr7y4/iLthcxhsLGlWqEARsaJ09i71QyN2rb96CL0aR
 SXUBiMDKwqorVDbyoHlTHV61jLKhho1iDX8E1b85+Znr/5Flda9YnG4QIhpgyL3g1rdsXa1DhOa
 +39vpcaU9OtYQr9g=
X-Received: by 2002:a05:6a00:ac4:b0:6c3:3213:2d17 with SMTP id
 c4-20020a056a000ac400b006c332132d17mr3653768pfl.29.1699498002629; 
 Wed, 08 Nov 2023 18:46:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH82ZY0VZAsZsz7UoLH1+egg1vrOd/ynDRJ/z2PkYyF6Icqg4XW+rc5V1yWuiU18oyYSPSXsA==
X-Received: by 2002:a05:6a00:ac4:b0:6c3:3213:2d17 with SMTP id
 c4-20020a056a000ac400b006c332132d17mr3653754pfl.29.1699498002140; 
 Wed, 08 Nov 2023 18:46:42 -0800 (PST)
Received: from smtpclient.apple ([115.96.107.18])
 by smtp.gmail.com with ESMTPSA id
 ei35-20020a056a0080e300b006934e7ceb79sm9622310pfb.32.2023.11.08.18.46.39
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Nov 2023 18:46:41 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v5] tests/avocado: add test to exercize processor address
 space memory bound checks
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <cabed062-bfb7-431d-b0fe-b38c159165e4@linaro.org>
Date: Thu, 9 Nov 2023 08:16:26 +0530
Cc: Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9EEBD1E2-8B45-41F4-BB61-9578E541C9A1@redhat.com>
References: <20231103110643.11664-1-anisinha@redhat.com>
 <cabed062-bfb7-431d-b0fe-b38c159165e4@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 08-Nov-2023, at 8:33=E2=80=AFPM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Hi Ani,
>=20
> On 3/11/23 12:06, Ani Sinha wrote:
>> QEMU has validations to make sure that a VM is not started with more =
memory
>> (static and hotpluggable memory) than what the guest processor can =
address
>> directly with its addressing bits. This change adds a test to make =
sure QEMU
>> fails to start with a specific error message when an attempt is made =
to
>> start a VM with more memory than what the processor can directly =
address.
>> The test also checks for passing cases when the address space of the =
processor
>> is capable of addressing all memory. Boundary cases are tested.
>> CC: imammedo@redhat.com
>> CC: David Hildenbrand <david@redhat.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>  tests/avocado/mem-addr-space-check.py | 361 =
++++++++++++++++++++++++++
>>  1 file changed, 361 insertions(+)
>>  create mode 100644 tests/avocado/mem-addr-space-check.py
>> Changelog:
>> v5:
>>   - made the negative test cases (ones that do not result in QEMU =
crash)
>>     more robust by checking the non-existence of the "phys-bits too =
low"
>>     log.
>>   - added a new test case for AMD HT window where QEMU starts fine.
>>   - rebased.
>>   - cosmetic typo/comment adjustments.
>> Tests all pass:
>> $ ./pyvenv/bin/avocado run tests/avocado/mem-addr-space-check.py =
--tap -
>> 1..15
>> ok 1 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_pse36
>> ok 2 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_pae
>> ok 3 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium=
_pse36
>> ok 4 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium=
_pae
>> ok 5 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_pentium=
2
>> ok 6 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_nonpse=
36
>> ok 7 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q3=
5_70_amd
>> ok 8 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q3=
5_71_amd
>> ok 9 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35=
_70_amd
>> ok 10 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35=
_71_amd
>> ok 11 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35=
_71_intel
>> ok 12 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q3=
5_71_amd_41bits
>> ok 13 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35=
_71_amd_41bits
>> ok 14 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_low_tcg_q3=
5_intel_cxl
>> ok 15 =
tests/avocado/mem-addr-space-check.py:MemAddrCheck.test_phybits_ok_tcg_q35=
_intel_cxl
>> v4: incorporated changes related to suggestions from David.
>> v3: added pae tests as well.
>> v2: added 64-bit tests. Added cxl tests.
>> diff --git a/tests/avocado/mem-addr-space-check.py =
b/tests/avocado/mem-addr-space-check.py
>> new file mode 100644
>> index 0000000000..6b4ada5857
>> --- /dev/null
>> +++ b/tests/avocado/mem-addr-space-check.py
>> @@ -0,0 +1,361 @@
>> +# Check for crash when using memory beyond the available guest =
processor
>> +# address space.
>> +#
>> +# Copyright (c) 2023 Red Hat, Inc.
>> +#
>> +# Author:
>> +#  Ani Sinha <anisinha@redhat.com>
>> +#
>> +# This program is free software; you can redistribute it and/or =
modify
>> +# it under the terms of the GNU General Public License as published =
by
>> +# the Free Software Foundation; either version 2 of the License, or
>> +# (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it will be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program.  If not, see =
<http://www.gnu.org/licenses/>.
>> +
>> +from avocado_qemu import QemuSystemTest
>> +import signal
>> +import time
>> +
>> +class MemAddrCheck(QemuSystemTest):
>> +    # first, lets test some 32-bit processors.
>> +    # for all 32-bit cases, pci64_hole_size is 0.
>> +    def test_phybits_low_pse36(self):
>> +        """
>> +        :avocado: tags=3Dmachine:q35
>> +        :avocado: tags=3Darch:x86_64
>> +
>> +        With pse36 feature ON, a processor has 36 bits of =
addressing. So it can
>> +        access up to a maximum of 64GiB of memory. Memory hotplug =
region begins
>> +        at 4 GiB boundary when "above_4g_mem_size" is 0 (this would =
be true when
>> +        we have 0.5 GiB of VM memory, see pc_q35_init()). This means =
total
>> +        hotpluggable memory size is 60 GiB. Per slot, we reserve 1 =
GiB of memory
>> +        for dimm alignment for all newer machines (see =
enforce_aligned_dimm
>> +        property for pc machines and pc_get_device_memory_range()). =
That leaves
>> +        total hotpluggable actual memory size of 59 GiB. If the VM =
is started
>> +        with 0.5 GiB of memory, maxmem should be set to a maximum =
value of
>> +        59.5 GiB to ensure that the processor can address all memory =
directly.
>> +        Note that 64-bit pci hole size is 0 in this case. If maxmem =
is set to
>> +        59.6G, QEMU should fail to start with a message "phy-bits =
are too low".
>> +        If maxmem is set to 59.5G with all other QEMU parameters =
identical, QEMU
>> +        should start fine.
>> +        """
>> +        self.vm.add_args('-S', '-machine', 'q35', '-m',
>> +                         '512,slots=3D1,maxmem=3D59.6G',
>> +                         '-cpu', 'pentium,pse36=3Don', '-display', =
'none',
>> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
>> +                         '-device', 'pc-dimm,id=3Dvm0,memdev=3Dmem1')
>> +        self.vm.set_qmp_monitor(enabled=3DFalse)
>> +        self.vm.launch()
>> +        self.vm.wait()
>> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>> +
>> +    def test_phybits_low_pae(self):
>> +        """
>> +        :avocado: tags=3Dmachine:q35
>> +        :avocado: tags=3Darch:x86_64
>> +
>> +        With pae feature ON, a processor has 36 bits of addressing. =
So it can
>> +        access up to a maximum of 64GiB of memory. Rest is the same =
as the case
>> +        with pse36 above.
>> +        """
>> +        self.vm.add_args('-S', '-machine', 'q35', '-m',
>> +                         '512,slots=3D1,maxmem=3D59.6G',
>> +                         '-cpu', 'pentium,pae=3Don', '-display', =
'none',
>> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
>> +                         '-device', 'pc-dimm,id=3Dvm0,memdev=3Dmem1')
>> +        self.vm.set_qmp_monitor(enabled=3DFalse)
>> +        self.vm.launch()
>> +        self.vm.wait()
>> +        self.assertEquals(self.vm.exitcode(), 1, "QEMU exit code =
should be 1")
>> +        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
>> +
>> +    def test_phybits_ok_pentium_pse36(self):
>> +        """
>> +        :avocado: tags=3Dmachine:q35
>> +        :avocado: tags=3Darch:x86_64
>> +
>> +        Setting maxmem to 59.5G and making sure that QEMU can start =
with the
>> +        same options as the failing case above with pse36 cpu =
feature.
>> +        """
>> +        self.vm.add_args('-machine', 'q35', '-m',
>> +                         '512,slots=3D1,maxmem=3D59.5G',
>> +                         '-cpu', 'pentium,pse36=3Don', '-display', =
'none',
>> +                         '-object', =
'memory-backend-ram,id=3Dmem1,size=3D1G',
>> +                         '-device', 'pc-dimm,id=3Dvm0,memdev=3Dmem1')
>> +        self.vm.set_qmp_monitor(enabled=3DFalse)
>> +        self.vm.launch()
>> +        time.sleep(3)
>=20
> Why do we need to wait 3s?

If we spawn the VM and then immediately kill it, we do not get any logs =
from QEMU. The log file is empty. So I did some experiments and it =
seemed 3 sec is a good time to wait for VM to start and generate the log =
before we kill it. I have not experimented with other tests to see what =
the minimal time is good enough although you are right, several other =
tests (for example machine_avr6) uses such sleeps.

> Maybe add a definition, then:
>=20
>           time.sleep(DELAY_Q35_BOOT_SEQUENCE)
>=20
> here and in the other tests. Or a comment.

I will add a comment why we needed that sleep.

> So we can tune
> that delay in a single place. Otherwise,
>=20
> Acked-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>=20
>> +        self.vm.shutdown()
>> +        self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')




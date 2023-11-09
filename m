Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE6E7E6582
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 09:43:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r10d1-0000Ga-Va; Thu, 09 Nov 2023 03:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r10cy-0000G9-Tp
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 03:43:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1r10cx-000439-1Y
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 03:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699519381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IUcOUyBZtt48YBOgmUptk86wVtQ0skyWf4MyUcuGEvU=;
 b=Zu1kc63voP2Ztw1d1m6iX3HgGKMhIh4kAg8iGKNhGGixsU3d783JsD9EYwx3Q7Z/0PenkI
 B739/ToY+InyRIwTFmh8oLQzDz3U4fos/fk8nljKj6nQGM0Fcge4vUaBPWvtrXMpsoNi6x
 lwaosU5RaoLxL1woSmiMx5o+FRrO0Z8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-yHUN8TwVM0WAIaK2UV_YRA-1; Thu, 09 Nov 2023 03:43:00 -0500
X-MC-Unique: yHUN8TwVM0WAIaK2UV_YRA-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6d339ba2924so572542a34.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 00:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699519379; x=1700124179;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IUcOUyBZtt48YBOgmUptk86wVtQ0skyWf4MyUcuGEvU=;
 b=w9RgoS23lTcYaVQ8EYf8YjOs7bTW2Y/Ey0YBuWl4A2PKbbt/25mkXABLS/IxBsuxPp
 kxCxPGKNF4IO2tfXZddIOhNe4fuKk31MP1oxeOSDmRGx0DE+wGHu+CMLhI0HmgT9tbTQ
 wYPrOHwWfT0cBT+8DVZJU9QRnyC2xhwDAiffl8bUyjV+HXBKf7oUKDxXzu+cFD+JfMzw
 FJcTkSvTFGoYx3uXZ2eMRuLubUBxSLJtOjlcYZL4FpyBKIbUoNWM8bNUNouIFlV7MZgS
 dMvo2DdQouZBOAOl6NVnxLkUUHHRaXV5t78/Bt8iIe6f/fjRgyEoO/Ty/j9O7lLoUjPM
 mByg==
X-Gm-Message-State: AOJu0Yz/mcKDsdQgiulVK+iNZfgwc+31Iv8juZWjfpH0D7UGPn6W3uwT
 kSQxCCWpNvQNhpcKF9WwuzbOfV7Nvy8szPva1k3ZOwITRxnynyBdK3lCEvDFmBnkiUTiXe0Gn+D
 GSFyIzTaVu6w6sVA=
X-Received: by 2002:a05:6830:1683:b0:6d3:1a0e:a7aa with SMTP id
 k3-20020a056830168300b006d31a0ea7aamr4982033otr.3.1699519379622; 
 Thu, 09 Nov 2023 00:42:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3IXMICtjWzzOta7i1G5+OA2w1G3JdEZthTaGeoS/U8crj6J+gWG2ZxEHjw57vS7l9+qoALA==
X-Received: by 2002:a05:6830:1683:b0:6d3:1a0e:a7aa with SMTP id
 k3-20020a056830168300b006d31a0ea7aamr4982013otr.3.1699519379218; 
 Thu, 09 Nov 2023 00:42:59 -0800 (PST)
Received: from smtpclient.apple ([115.96.107.18])
 by smtp.gmail.com with ESMTPSA id
 k125-20020a632483000000b005bd3f34b10dsm4330324pgk.24.2023.11.09.00.42.56
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Nov 2023 00:42:58 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH v6] tests/avocado: add test to exercize processor address
 space memory bound checks
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <ec2e70ef-1604-4c34-ab36-5449e613ecd1@linaro.org>
Date: Thu, 9 Nov 2023 14:12:43 +0530
Cc: Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D5D8D419-76BA-4FB0-9BAC-4F7470A052FC@redhat.com>
References: <20231109045601.33349-1-anisinha@redhat.com>
 <ec2e70ef-1604-4c34-ab36-5449e613ecd1@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



> On 09-Nov-2023, at 1:49=E2=80=AFPM, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> On 9/11/23 05:56, Ani Sinha wrote:
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
>> Acked-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>> ---
>>  tests/avocado/mem-addr-space-check.py | 367 =
++++++++++++++++++++++++++
>>  1 file changed, 367 insertions(+)
>>  create mode 100644 tests/avocado/mem-addr-space-check.py
>> Changelog:
>> v6: added phil's suggestions - added comment to explain why a sleep =
delay
>>     is needed. Reduced delay to 1 sec. Added a one place definition =
for
>>     the sleep duration so we can tweak it if needed later. Added =
phil's
>>     tag. rebased.
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
>> index 0000000000..fae7d48598
>> --- /dev/null
>> +++ b/tests/avocado/mem-addr-space-check.py
>> @@ -0,0 +1,367 @@
>> +# Check for crash when using memory beyond the available guest =
processor
>> +# address space.
>> +#
>> +# Copyright (c) 2023 Red Hat, Inc.
>> +#
>> +# Author:
>> +#  Ani Sinha <anisinha@redhat.com>
>> +#
>=20
> [*]
>=20
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
>> +    # after launch, in order to generate the logs from QEMU we need =
to
>> +    # wait for some time. Launching and then immediately shutting =
down
>> +    # the VM generates empty logs. A delay of 1 second is added for
>> +    # this reason.
>> +    DELAY_Q35_BOOT_SEQUENCE =3D 1
>=20
> Perfect, thank you!
>=20
> Do you mind if I add in [*]:
>=20
> # SPDX-License-Identifier: GPL-2.0-or-later
>=20
> ? Optionally removing the boilerplate license comment if you offer to.

Sure, no worries.

>=20
> Then I can queue this patch.
>=20
> Thanks,
>=20
> Phil.




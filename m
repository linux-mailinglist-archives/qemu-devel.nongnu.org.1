Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1ADDA21315
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Jan 2025 21:24:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcs7N-000841-FM; Tue, 28 Jan 2025 15:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tcs79-0007nY-UC; Tue, 28 Jan 2025 15:23:16 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tcs76-0003Q1-DW; Tue, 28 Jan 2025 15:23:15 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EFC444E6013;
 Tue, 28 Jan 2025 21:23:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id x5Gi1DB-r9_Y; Tue, 28 Jan 2025 21:23:00 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A36244E600F; Tue, 28 Jan 2025 21:23:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A165B74577C;
 Tue, 28 Jan 2025 21:23:00 +0100 (CET)
Date: Tue, 28 Jan 2025 21:23:00 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/functional: Add a ppc64 mac99 test
In-Reply-To: <85e8445a-b7bf-4d01-a6e5-5fcb7d562780@redhat.com>
Message-ID: <7c68e0fb-142e-d68b-1201-98897854915c@eik.bme.hu>
References: <20250128180742.1137741-1-clg@redhat.com>
 <7bb6ab1b-169e-4752-8aee-ef87877a38b4@redhat.com>
 <9bf6cf01-d8c4-4ed8-808d-03e6ee05bc7b@redhat.com>
 <85e8445a-b7bf-4d01-a6e5-5fcb7d562780@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1997126749-1738095780=:49616"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1997126749-1738095780=:49616
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 28 Jan 2025, Thomas Huth wrote:
> On 28/01/2025 19.35, Cédric Le Goater wrote:
>> On 1/28/25 19:20, Thomas Huth wrote:
>>> On 28/01/2025 19.07, Cédric Le Goater wrote:
>>>> The test sequence boots from disk a mac99 machine in 64-bit mode, in
>>>> which case the CPU is a PPC 970.
>>>> 
>>>> The buildroot rootfs is built with config :
>>>> 
>>>> BR2_powerpc64=y
>>>> BR2_powerpc_970=y
>>>> 
>>>> and the kernel with the g5 deconfig.
>>>> 
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>>   MAINTAINERS                          |  1 +
>>>>   tests/functional/meson.build         |  2 ++
>>>>   tests/functional/test_ppc64_mac99.py | 45 ++++++++++++++++++++++++++++
>>>>   3 files changed, 48 insertions(+)
>>>>   create mode 100644 tests/functional/test_ppc64_mac99.py
>>>> 
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 3a2291d17d7e..ebf249173f00 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1446,6 +1446,7 @@ F: include/hw/pci-host/uninorth.h
>>>>   F: include/hw/input/adb*
>>>>   F: pc-bios/qemu_vga.ndrv
>>>>   F: tests/functional/test_ppc_mac.py
>>>> +F: tests/functional/test_ppc64_mac99.py
>>>>   Old World (g3beige)
>>>>   M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>>>> index 01a87b03e553..821a0a7c49ac 100644
>>>> --- a/tests/functional/meson.build
>>>> +++ b/tests/functional/meson.build
>>>> @@ -41,6 +41,7 @@ test_timeouts = {
>>>>     'ppc64_powernv' : 480,
>>>>     'ppc64_pseries' : 480,
>>>>     'ppc64_tuxrun' : 420,
>>>> +  'ppc64_mac99' : 120,
>>>>     'riscv64_tuxrun' : 120,
>>>>     's390x_ccw_virtio' : 420,
>>>>     'sh4_tuxrun' : 240,
>>>> @@ -181,6 +182,7 @@ tests_ppc64_system_thorough = [
>>>>     'ppc64_powernv',
>>>>     'ppc64_pseries',
>>>>     'ppc64_tuxrun',
>>>> +  'ppc64_mac99',
>>>>   ]
>>>>   tests_riscv32_system_quick = [
>>>> diff --git a/tests/functional/test_ppc64_mac99.py b/tests/functional/ 
>>>> test_ppc64_mac99.py
>>>> new file mode 100644
>>>> index 000000000000..ba582d267dae
>>>> --- /dev/null
>>>> +++ b/tests/functional/test_ppc64_mac99.py
>>>> @@ -0,0 +1,45 @@
>>>> +#!/usr/bin/env python3
>>>> +#
>>>> +# Functional test that boots a mac99 machine with a PPC970 CPU
>>>> +#
>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>> +
>>>> +from qemu_test import LinuxKernelTest, Asset
>>>> +from qemu_test import exec_command_and_wait_for_pattern
>>>> +
>>>> +class mac99Test(LinuxKernelTest):
>>>> +
>>>> +    ASSET_BR2_MAC99_LINUX = Asset(
>>>> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/ 
>>>> buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/vmlinux',
>>>> +        
>>>> 'd59307437e4365f2cced0bbd1b04949f7397b282ef349b7cafd894d74aadfbff')
>>>> +
>>>> +    ASSET_BR2_MAC99_ROOTFS = Asset(
>>>> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main// 
>>>> buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/rootfs.ext2',
>>>> +        
>>>> 'bbd5fd8af62f580bc4e585f326fe584e22856572633a8333178ea6d4ed4955a4')
>>>> +
>>>> +    def test_ppc64_mac99_buildroot(self):
>>>> +        self.require_netdev('user')
>>>> +
>>>> +        linux_path = self.ASSET_BR2_MAC99_LINUX.fetch()
>>>> +        rootfs_path = self.ASSET_BR2_MAC99_ROOTFS.fetch()
>>>> +
>>>> +        self.set_machine('mac99')
>>> 
>>> Nit: Move the set_machine to the top of the function, so that the assets 
>>> don't have to be fetched in case the machine is not available.
>>> 
>>> With that nit fixed:
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> 
>>> 
>>>> +        self.vm.set_console()
>>>> +
>>>> +        self.vm.add_args('-kernel', linux_path,
>>>> +                         '-append', 'root=/dev/sda',
>>>> +                         '-drive', f'file={rootfs_path},format=raw',
>>>> +                         '-net', 'nic,model=sungem', '-net', 'user',
>>>> +                         '-snapshot', '-nographic')
>>> 
>>> I just also noticed that we already have "-display none" in python/qemu/ 
>>> machine/machine.py, so you likely don't need the -nographic here (but 
>>> looks like we've got that wrong in a bunch of tests already).
>> 
>> I think we need -nographic else OpenBIOS crashes.  I will check.
>
> Oh, you're right, OpenBIOS hangs with "milliseconds isn't unique" when 
> running "qemu-system-ppc64 -M mac99 -display none -serial stdio" ... that's 
> weird... so you need to keep the -nographic here, indeed!

That's because of -display none, without that you can see the output in 
the window. I think if OpenBIOS finds a VGA card it tries to output there 
so you have to remove that too to get output on serial. But if you have a 
kernel to boot it may still boot with -display none but you have to tell 
it to use serial separately with -append.

Regards,
BALATON Zoltan
--3866299591-1997126749-1738095780=:49616--


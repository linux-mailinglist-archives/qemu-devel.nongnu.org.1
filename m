Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D299EE3E3
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Dec 2024 11:14:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLgCS-00030L-2V; Thu, 12 Dec 2024 05:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLgCI-0002sA-R4
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 05:13:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tLgC3-0001mD-Ix
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 05:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733998391;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hDGkeYt2ipTa2rHNmmary8+7GF6niA0duiasctQSTCA=;
 b=Hdaa0MW7Z+LXuq1QND6oq3iv0SPubGgq2vSS6Lme5KzYOeQlnkWaEAXWRdz5aeBvPshi8f
 RbhA4876QAs00qwhKYQlruTUq5rPxZlbhww2Z9W0LzUZgo2GSXfC+yXBBGXrGOSu8B10BU
 /ZFgqQ6AKnR48RjjpvF0mj6zzJbCosk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-eicB096FO-SGmAaRi9RvhA-1; Thu, 12 Dec 2024 05:13:10 -0500
X-MC-Unique: eicB096FO-SGmAaRi9RvhA-1
X-Mimecast-MFC-AGG-ID: eicB096FO-SGmAaRi9RvhA
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-386333ea577so184126f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 02:13:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733998389; x=1734603189;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hDGkeYt2ipTa2rHNmmary8+7GF6niA0duiasctQSTCA=;
 b=LLbfQPdd0zrc6K8XMftlemukFsKBiWqyRc7duf5ngVO05xTXCdfXnXoTDU1N5rf+Nf
 Hk9RkgLAYKg19p5kEN++3AdCHdxEf0vUUdF3NW96TCVHOgUVb45TDBHTeNoW3GFc9JLd
 Wljgap/SdI8NTQNyqPAnZijVEaRErFecC7w7MrogolWKpHjG0hf5Larb09Vuf9KJMFHl
 mLaNOZePKJXgimkQFs10BHive5AJr92Aof+VxL+07s9y3JfXNnRSmz75qEpNQL9tdEyd
 eP3YjVL2Pzor6nPyB7IIVfaXa6Y5UwR3IelgbCA+FpyfIjzFZJNAvD/Y2k/MGF6Yp/Tg
 CyYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXusSaH228GpLOphSQLYXuiBjdWHcAO5+1yitnHYFhIrQs+jWcgaoQ5ricbfG8+wCZVQl2emuu729+2@nongnu.org
X-Gm-Message-State: AOJu0YyYZXgooNSgaCwhCSyWCtizoXpnvGc4bPNcdjRIkftrF3xWquTT
 KI4zjMAV6gkBjj9FI57ZaMPVSAOUBAL9947E9XM3McrD/aaDwZN2bP0xgl8cfIMbaKw5N+Q75c6
 LcSs0ws+kB8Fm19LUiJR0l67+O+wQYFoUtxLHRYIHo9U1xpQVM1L1
X-Gm-Gg: ASbGncsAxzuk1hhoXpGrBGd7F6H4axHqSJYLLpQMsGtV+iwuP9GyMIGw/Dn/Y5TIVdx
 AfSPgyCwdYsvZDgXk4HwUSSnykCGt2ej2zB89OaqoCeVV05IQyn+ccIINqbDQP6sPt8GzV8Mmd7
 Psr1ZzgaWYXDkVDow4qIAorc8MaHrPkF/hpET3g34fE6mFlHHNtzNA9+Hj22gvJkmFvc3DyW5bR
 yMPGLRBh9Y+CUQnMgKw+Y65LZ8azQqXaH493rHo7z7XhPtuk/cHUiHBrZkfUfHrKUaTxGx+hS0t
 pP05PA==
X-Received: by 2002:a05:600c:b86:b0:436:1c04:aa8e with SMTP id
 5b1f17b1804b1-4361c3746c2mr53132915e9.16.1733998388865; 
 Thu, 12 Dec 2024 02:13:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHra/G9XOutHLyItS9oOqCwCKOch/1YnjjMlQCdUwCIY5FlYYe6f60uS9Pq1jXoPp1T8b0ZKA==
X-Received: by 2002:a05:600c:b86:b0:436:1c04:aa8e with SMTP id
 5b1f17b1804b1-4361c3746c2mr53132615e9.16.1733998388425; 
 Thu, 12 Dec 2024 02:13:08 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362555334bsm12034435e9.1.2024.12.12.02.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 02:13:07 -0800 (PST)
Message-ID: <8d98ea68-32d7-4881-a71a-7bf9b6ed4b20@redhat.com>
Date: Thu, 12 Dec 2024 11:13:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Convert the intel_iommu avocado test
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Jason Wang <jasowang@redhat.com>
References: <20241210125639.101033-1-thuth@redhat.com>
 <3f625ae0-9db4-4999-8b8f-401bd39072e2@eviden.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <3f625ae0-9db4-4999-8b8f-401bd39072e2@eviden.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/12/2024 10.23, CLEMENT MATHIEU--DRIF wrote:
> Hi Thomas,
> 
> 2 minor comments but LGTM
> 
> On 10/12/2024 13:56, Thomas Huth wrote:
>> Caution: External email. Do not open attachments or click links, unless this email comes from a known sender and you know the content is safe.
>>
>>
>> Convert the intel_iommu test to the new functional framework.
>> This test needs some changes since we neither support the old 'LinuxTest'
>> class in the functional framework yet, nor a way to use SSH for running
>> commands in the guest. So we now directly download a Fedora kernel and
>> initrd and set up the serial console for executing the commands and for
>> looking for the results. Instead of configuring the cloud image via
>> cloud-init, we now simply mount the file system manually from an initrd
>> rescue shell.
>>
>> While the old test was exercising the network with a "dnf install"
>> command (which is not the best option for the CI since this depends
>> on third party servers), the new code is now setting up a little
>> HTTP server in the guest and transfers a file from the guest to the
>> host instead.
>>
>> The test should now run much faster and more reliable (since we
>> don't depend on the third party servers for "dnf install" anymore),
>> so we can also drop the @skipUnless decorator now.
>>
>> Signed-off-by: Thomas Huth<thuth@redhat.com>
>> ---
>>   v2:
>>   - Download the cloud image qcow2 and use it as file system
>>     to exercise the virtio-block device
>>   - Instead of removing the "dnf install", transfer a file
>>     via virtio-net to the host
>>   - This needs find_free_port() now:
>>   Based-on:<20241204071911.664057-1-thuth@redhat.com>
>>
>>   MAINTAINERS                          |   1 +
>>   tests/avocado/intel_iommu.py         | 122 -------------------
>>   tests/functional/meson.build         |   2 +
>>   tests/functional/test_intel_iommu.py | 176 +++++++++++++++++++++++++++
>>   4 files changed, 179 insertions(+), 122 deletions(-)
>>   delete mode 100644 tests/avocado/intel_iommu.py
>>   create mode 100755 tests/functional/test_intel_iommu.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a62659b330..2ca452dbf9 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -3679,6 +3679,7 @@ S: Supported
>>   F: hw/i386/intel_iommu.c
>>   F: hw/i386/intel_iommu_internal.h
>>   F: include/hw/i386/intel_iommu.h
>> +F: tests/functional/test_intel_iommu.py
>>
>>   AMD-Vi Emulation
>>   S: Orphan
>> diff --git a/tests/avocado/intel_iommu.py b/tests/avocado/intel_iommu.py
>> deleted file mode 100644
>> index 992583fa7d..0000000000
>> --- a/tests/avocado/intel_iommu.py
>> +++ /dev/null
>> @@ -1,122 +0,0 @@
>> -# INTEL_IOMMU Functional tests
>> -#
>> -# Copyright (c) 2021 Red Hat, Inc.
>> -#
>> -# Author:
>> -#  Eric Auger<eric.auger@redhat.com>
>> -#
>> -# This work is licensed under the terms of the GNU GPL, version 2 or
>> -# later.  See the COPYING file in the top-level directory.
>> -import os
>> -
>> -from avocado import skipUnless
>> -from avocado_qemu.linuxtest import LinuxTest
>> -
>> -@skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
>> -class IntelIOMMU(LinuxTest):
>> -    """
>> -    :avocado: tags=arch:x86_64
>> -    :avocado: tags=distro:fedora
>> -    :avocado: tags=distro_version:31
>> -    :avocado: tags=machine:q35
>> -    :avocado: tags=accel:kvm
>> -    :avocado: tags=intel_iommu
>> -    :avocado: tags=flaky
>> -    """
>> -
>> -    IOMMU_ADDON = ',iommu_platform=on,disable-modern=off,disable-legacy=on'
>> -    kernel_path = None
>> -    initrd_path = None
>> -    kernel_params = None
>> -
>> -    def set_up_boot(self):
>> -        path = self.download_boot()
>> -        self.vm.add_args('-device', 'virtio-blk-pci,bus=pcie.0,' +
>> -                         'drive=drv0,id=virtio-disk0,bootindex=1,'
>> -                         'werror=stop,rerror=stop' + self.IOMMU_ADDON)
>> -        self.vm.add_args('-device', 'virtio-gpu-pci' + self.IOMMU_ADDON)
>> -        self.vm.add_args('-drive',
>> -                         'file=%s,if=none,cache=writethrough,id=drv0' % path)
>> -
>> -    def setUp(self):
>> -        super(IntelIOMMU, self).setUp(None, 'virtio-net-pci' + self.IOMMU_ADDON)
>> -
>> -    def add_common_args(self):
>> -        self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
>> -        self.vm.add_args('-object',
>> -                         'rng-random,id=rng0,filename=/dev/urandom')
>> -
>> -    def common_vm_setup(self, custom_kernel=None):
>> -        self.require_accelerator("kvm")
>> -        self.add_common_args()
>> -        self.vm.add_args("-accel", "kvm")
>> -
>> -        if custom_kernel is None:
>> -            return
>> -
>> -        kernel_url = self.distro.pxeboot_url + 'vmlinuz'
>> -        kernel_hash = '5b6f6876e1b5bda314f93893271da0d5777b1f3c'
>> -        initrd_url = self.distro.pxeboot_url + 'initrd.img'
>> -        initrd_hash = 'dd0340a1b39bd28f88532babd4581c67649ec5b1'
>> -        self.kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>> -        self.initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
>> -
>> -    def run_and_check(self):
>> -        if self.kernel_path:
>> -            self.vm.add_args('-kernel', self.kernel_path,
>> -                             '-append', self.kernel_params,
>> -                             '-initrd', self.initrd_path)
>> -        self.launch_and_wait()
>> -        self.ssh_command('cat /proc/cmdline')
>> -        self.ssh_command('dmesg | grep -e DMAR -e IOMMU')
>> -        self.ssh_command('find /sys/kernel/iommu_groups/ -type l')
>> -        self.ssh_command('dnf -y install numactl-devel')
>> -
>> -    def test_intel_iommu(self):
>> -        """
>> -        :avocado: tags=intel_iommu_intremap
>> -        """
>> -
>> -        self.common_vm_setup(True)
>> -        self.vm.add_args('-device', 'intel-iommu,intremap=on')
>> -        self.vm.add_args('-machine', 'kernel_irqchip=split')
>> -
>> -        self.kernel_params = (self.distro.default_kernel_params +
>> -                              ' quiet intel_iommu=on')
>> -        self.run_and_check()
>> -
>> -    def test_intel_iommu_strict(self):
>> -        """
>> -        :avocado: tags=intel_iommu_strict
>> -        """
>> -
>> -        self.common_vm_setup(True)
>> -        self.vm.add_args('-device', 'intel-iommu,intremap=on')
>> -        self.vm.add_args('-machine', 'kernel_irqchip=split')
>> -        self.kernel_params = (self.distro.default_kernel_params +
>> -                              ' quiet intel_iommu=on,strict')
>> -        self.run_and_check()
>> -
>> -    def test_intel_iommu_strict_cm(self):
>> -        """
>> -        :avocado: tags=intel_iommu_strict_cm
>> -        """
>> -
>> -        self.common_vm_setup(True)
>> -        self.vm.add_args('-device', 'intel-iommu,intremap=on,caching-mode=on')
>> -        self.vm.add_args('-machine', 'kernel_irqchip=split')
>> -        self.kernel_params = (self.distro.default_kernel_params +
>> -                              ' quiet intel_iommu=on,strict')
>> -        self.run_and_check()
>> -
>> -    def test_intel_iommu_pt(self):
>> -        """
>> -        :avocado: tags=intel_iommu_pt
>> -        """
>> -
>> -        self.common_vm_setup(True)
>> -        self.vm.add_args('-device', 'intel-iommu,intremap=on')
>> -        self.vm.add_args('-machine', 'kernel_irqchip=split')
>> -        self.kernel_params = (self.distro.default_kernel_params +
>> -                              ' quiet intel_iommu=on iommu=pt')
>> -        self.run_and_check()
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 30c3eda7e4..84ffb7d98c 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -27,6 +27,7 @@ test_timeouts = {
>>     'arm_raspi2' : 120,
>>     'arm_tuxrun' : 240,
>>     'arm_sx1' : 360,
>> +  'intel_iommu': 300,
>>     'mips_malta' : 120,
>>     'netdev_ethtool' : 180,
>>     'ppc_40p' : 240,
>> @@ -238,6 +239,7 @@ tests_x86_64_system_quick = [
>>
>>   tests_x86_64_system_thorough = [
>>     'acpi_bits',
>> +  'intel_iommu',
>>     'x86_64_tuxrun',
>>     'linux_initrd',
>>     'multiprocess',
>> diff --git a/tests/functional/test_intel_iommu.py b/tests/functional/test_intel_iommu.py
>> new file mode 100755
>> index 0000000000..e234813cee
>> --- /dev/null
>> +++ b/tests/functional/test_intel_iommu.py
>> @@ -0,0 +1,176 @@
>> +#!/usr/bin/env python3
>> +#
>> +# INTEL_IOMMU Functional tests
>> +#
>> +# Copyright (c) 2021 Red Hat, Inc.
>> +#
>> +# Author:
>> +#  Eric Auger<eric.auger@redhat.com>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +import hashlib
>> +import urllib.request
>> +
>> +from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
>> +from qemu_test.ports import Ports
>> +
>> +class IntelIOMMU(LinuxKernelTest):
>> +
>> +    ASSET_KERNEL = Asset(
>> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
>> +         '/31/Server/x86_64/os/images/pxeboot/vmlinuz'),
>> +        'd4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129')
>> +
>> +    ASSET_INITRD = Asset(
>> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
>> +         '/31/Server/x86_64/os/images/pxeboot/initrd.img'),
>> +        '277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8b')
>> +
>> +    ASSET_DISKIMAGE = Asset(
>> +        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
>> +         '/31/Cloud/x86_64/images/Fedora-Cloud-Base-31-1.9.x86_64.qcow2'),
>> +        'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0')
>> +
>> +    default_kernel_params = ('root=/dev/vda1 console=ttyS0 net.ifnames=0 '
>> +                             'quiet rd.rescue ')
>> +    IOMMU_ADDON = ',iommu_platform=on,disable-modern=off,disable-legacy=on'
>> +    kernel_path = None
>> +    initrd_path = None
>> +    kernel_params = None
>> +
>> +    def add_common_args(self, path):
>> +        self.vm.add_args('-drive', f'file={path},if=none,id=drv0,snapshot=on')
>> +        self.vm.add_args('-device', 'virtio-blk-pci,bus=pcie.0,' +
>> +                         'drive=drv0,id=virtio-disk0,bootindex=1,'
>> +                         'werror=stop,rerror=stop' + self.IOMMU_ADDON)
>> +        self.vm.add_args('-device', 'virtio-gpu-pci' + self.IOMMU_ADDON)
>> +        self.vm.add_args('-device', 'virtio-rng-pci,rng=r0')
>> +        self.vm.add_args('-object', 'rng-random,id=r0,filename=/dev/urandom')
>> +        self.vm.add_args("-m", "1G")
>> +        self.vm.add_args("-accel", "kvm")
>> +
>> +    def common_vm_setup(self):
>> +        self.set_machine('q35')
>> +        self.require_accelerator("kvm")
>> +        self.require_netdev('user')
>> +
>> +        self.kernel_path = self.ASSET_KERNEL.fetch()
>> +        self.initrd_path = self.ASSET_INITRD.fetch()
>> +        image_path = self.ASSET_DISKIMAGE.fetch()
>> +        self.add_common_args(image_path)
>> +        self.kernel_params = self.default_kernel_params
>> +
>> +    def add_nic_args(self, hostport):
>> +        self.vm.add_args('-netdev',
>> +                         'user,id=n1,hostfwd=tcp::%d-:8080' % hostport)
> 
> Maybe we should add a constant for 8080 which would help readers understand 
> what it is.

Yes, that's maybe a good idea, especially since I need the value again when 
starting the HTTP server in the guest.

Aside from that: I just learnt yesterday that there is also a 
get_info_usernet_hostfwd_port() in the framework, so maybe I could even get 
rid of the hostport / find_free_port() function in this test ... so I'll 
send a v3 when I find some spare time for this.

>> +        self.vm.add_args('-device',
>> +                         'virtio-net-pci,netdev=n1' + self.IOMMU_ADDON)
>> +
>> +    def run_and_check(self, freeport):
>> +        self.add_nic_args(freeport)
>> +
>> +        if self.kernel_path:
>> +            self.vm.add_args('-kernel', self.kernel_path,
>> +                             '-append', self.kernel_params,
>> +                             '-initrd', self.initrd_path)
>> +        self.vm.set_console()
>> +        self.vm.launch()
>> +        self.wait_for_console_pattern('Entering emergency mode.')
>> +        prompt = '# '
>> +        self.wait_for_console_pattern(prompt)
>> +
>> +        # Copy a file (checked later), umount afterwards to drop disk cache:
>> +        exec_command_and_wait_for_pattern(self, 'mount /dev/vda1 /sysroot',
>> +                                          prompt)
>> +        filename = '/boot/initramfs-5.3.7-301.fc31.x86_64.img'
> 
> Shouldn't we define this after the assets at the top of the class?

Since this is a file within the guest filesystem, not an asset on the host, 
I guess it's mostly a matter of taste. As long as it's only required in this 
function here, I think I'd rather like to keep it here.

  Thomas


>> +        exec_command_and_wait_for_pattern(self, (f'cp /sysroot{filename}'
>> +                                                 ' /sysroot/root/data'),
>> +                                          prompt)
>> +        exec_command_and_wait_for_pattern(self, 'umount /sysroot', prompt)
>> +
>> +        # Switch from initrd to the cloud image filesystem:
>> +        exec_command_and_wait_for_pattern(self, 'mount /dev/vda1 /sysroot',
>> +                                          prompt)
>> +        exec_command_and_wait_for_pattern(self,
>> +                ('for d in dev proc sys run ; do '
>> +                 'mount -o bind /$d /sysroot/$d ; done'), prompt)
>> +        exec_command_and_wait_for_pattern(self, 'chroot /sysroot', prompt)
>> +
>> +        # Checking for IOMMU enablement:
>> +        self.log.info("Checking whether IOMMU has been enabled...")
>> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cmdline',
>> +                                          'intel_iommu=on')
>> +        self.wait_for_console_pattern(prompt)
>> +        exec_command_and_wait_for_pattern(self, 'dmesg | grep DMAR:',
>> +                                          'IOMMU enabled')
>> +        self.wait_for_console_pattern(prompt)
>> +        exec_command_and_wait_for_pattern(self,
>> +                                    'find /sys/kernel/iommu_groups/ -type l',
>> +                                    'devices/0000:00:')
>> +        self.wait_for_console_pattern(prompt)
>> +
>> +        # Check hard disk device via sha256sum:
>> +        self.log.info("Checking hard disk...")
>> +        hashsum = '0dc7472f879be70b2f3daae279e3ae47175ffe249691e7d97f47222b65b8a720'
>> +        exec_command_and_wait_for_pattern(self, 'sha256sum ' + filename,
>> +                                          hashsum)
>> +        self.wait_for_console_pattern(prompt)
>> +        exec_command_and_wait_for_pattern(self, 'sha256sum /root/data',
>> +                                          hashsum)
>> +        self.wait_for_console_pattern(prompt)
>> +
>> +        # Check virtio-net via HTTP:
>> +        exec_command_and_wait_for_pattern(self, 'dhclient eth0', prompt)
>> +        exec_command_and_wait_for_pattern(self,
>> +                                    'python3 -m http.server 8080 & sleep 1',
>> +                                    'Serving HTTP on 0.0.0.0 port 8080')
>> +        hl = hashlib.sha256()
>> +        url = f'http://localhost:{freeport}{filename}'
>> +        self.log.info(f'Downloading {url} ...')
>> +        with urllib.request.urlopen(url) as response:
>> +            while True:
>> +                chunk = response.read(1 << 20)
>> +                if not chunk:
>> +                    break
>> +                hl.update(chunk)
>> +
>> +        digest = hl.hexdigest()
>> +        self.log.info(f'sha256sum of download is {digest}.')
>> +        self.assertEqual(digest, hashsum)
>> +
>> +    def test_intel_iommu(self):
>> +        self.common_vm_setup()
>> +        self.vm.add_args('-device', 'intel-iommu,intremap=on')
>> +        self.vm.add_args('-machine', 'kernel_irqchip=split')
>> +        self.kernel_params += 'intel_iommu=on'
>> +        with Ports() as ports:
>> +            self.run_and_check(ports.find_free_port())
>> +
>> +    def test_intel_iommu_strict(self):
>> +        self.common_vm_setup()
>> +        self.vm.add_args('-device', 'intel-iommu,intremap=on')
>> +        self.vm.add_args('-machine', 'kernel_irqchip=split')
>> +        self.kernel_params += 'intel_iommu=on,strict'
>> +        with Ports() as ports:
>> +            self.run_and_check(ports.find_free_port())
>> +
>> +    def test_intel_iommu_strict_cm(self):
>> +        self.common_vm_setup()
>> +        self.vm.add_args('-device', 'intel-iommu,intremap=on,caching-mode=on')
>> +        self.vm.add_args('-machine', 'kernel_irqchip=split')
>> +        self.kernel_params += 'intel_iommu=on,strict'
>> +        with Ports() as ports:
>> +            self.run_and_check(ports.find_free_port())
>> +
>> +    def test_intel_iommu_pt(self):
>> +        self.common_vm_setup()
>> +        self.vm.add_args('-device', 'intel-iommu,intremap=on')
>> +        self.vm.add_args('-machine', 'kernel_irqchip=split')
>> +        self.kernel_params += 'intel_iommu=on iommu=pt'
>> +        with Ports() as ports:
>> +            self.run_and_check(ports.find_free_port())
>> +
>> +if __name__ == '__main__':
>> +    LinuxKernelTest.main()
>> --
>> 2.47.1
>>
> 



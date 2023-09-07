Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E95787970BD
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:29:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeAMr-0000DX-CD; Thu, 07 Sep 2023 04:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeAMp-0000Ch-EM
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:27:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qeAMm-00006q-IH
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694075275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iY+Rm5ocdC1wlwcvcV56DGudHhAWGfs0W6ML5EGMKM8=;
 b=OUOVL05PGskYrxqM29EXjwJ00ojzGI8OBfUUOxD6AtNLECkqSwvayjB2uJ1aOwuXG66pPy
 oEIkFxLLq2LqeqKMJ5+qD//5abFRmysDAhnObAnCXjD/dRTs3k3aoHcU2gbq9w5LZqpxer
 IfAP4khVHKGRHRTMs8Ic9ByUDGdeVoI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-vUiQvrK1M3ykGnEwVS9DpQ-1; Thu, 07 Sep 2023 04:27:54 -0400
X-MC-Unique: vUiQvrK1M3ykGnEwVS9DpQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fef5403093so2780215e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 01:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694075273; x=1694680073;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iY+Rm5ocdC1wlwcvcV56DGudHhAWGfs0W6ML5EGMKM8=;
 b=DW1XBOXkr8GliyK2boRJyVH+xM3XbaV9UBUzn/WkISM265kBsh/2HPB4BoplNgesTB
 kZTBb6TmKcD51FJ5yy4QnONQIaC2zBRsGorl+x5Ci9YFcQqBMPIUY/plp48oCnjEubaf
 7/syveket3YZr1HqKnbqtCoHYpLxg5cPU/75MbN+8xO1bGqyIrNguqhVtUOYHg8n6FdR
 qfrad8vtHeNXrvRsoUh1TxYUxYT+56iq1uoYeTrFynjeM6UEYeSGQSFY8c0c4gc9XSGy
 epmPMFQM3/xmKURbj8aK+aqIQbQmY5metcGskPYIad0v2QUomKyPxhpBQk/vSpw8gVjU
 Y76Q==
X-Gm-Message-State: AOJu0YzNcQtLICOVCxM6obWrkox9+H4T6nZwWE0iVLnbxyfICs2h81vX
 v5VMxaZ7lkwHspJSjcSE1JtCLF0vQjv+7d16yHWhE8gN1UpRBL/SxIsh9kpV1mp7dO9Cx6vVKDI
 FP8H6WNJjBeNMeDA=
X-Received: by 2002:a1c:4b08:0:b0:3fe:1587:fdf3 with SMTP id
 y8-20020a1c4b08000000b003fe1587fdf3mr1352824wma.14.1694075273243; 
 Thu, 07 Sep 2023 01:27:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUqtR/GRfFU7gTicFyRDOUXTHtFvYh/gTQ421hGPqlsxW6N32plLKXuJP7rgu9wWgKpk1SNw==
X-Received: by 2002:a1c:4b08:0:b0:3fe:1587:fdf3 with SMTP id
 y8-20020a1c4b08000000b003fe1587fdf3mr1352808wma.14.1694075272891; 
 Thu, 07 Sep 2023 01:27:52 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-5.web.vodafone.de. [109.43.176.5])
 by smtp.gmail.com with ESMTPSA id
 p17-20020a7bcc91000000b003fc0505be19sm1792048wma.37.2023.09.07.01.27.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 01:27:52 -0700 (PDT)
Message-ID: <3a2b6b7c-82d1-8500-8f82-cc87b36f2152@redhat.com>
Date: Thu, 7 Sep 2023 10:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v22 14/20] tests/avocado: s390x cpu topology core
Content-Language: en-US
To: Nina Schoetterl-Glausch <nsg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pierre Morel <pmorel@linux.ibm.com>
References: <20230901155812.2696560-1-nsg@linux.ibm.com>
 <20230901155812.2696560-15-nsg@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230901155812.2696560-15-nsg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 01/09/2023 17.58, Nina Schoetterl-Glausch wrote:
> From: Pierre Morel <pmorel@linux.ibm.com>
> 
> Introduction of the s390x cpu topology core functions and
> basic tests.
> 
> We test the correlation between the command line and
> the QMP results in query-cpus-fast for various CPU topology.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>   MAINTAINERS                    |   1 +
>   tests/avocado/s390_topology.py | 200 +++++++++++++++++++++++++++++++++
>   2 files changed, 201 insertions(+)
>   create mode 100644 tests/avocado/s390_topology.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7f2937b0f2..d1b8676666 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1703,6 +1703,7 @@ F: hw/s390x/cpu-topology.c
>   F: target/s390x/kvm/stsi-topology.c
>   F: docs/devel/s390-cpu-topology.rst
>   F: docs/system/s390x/cpu-topology.rst
> +F: tests/avocado/s390_topology.py
>   
>   X86 Machines
>   ------------
> diff --git a/tests/avocado/s390_topology.py b/tests/avocado/s390_topology.py
> new file mode 100644
> index 0000000000..3a54fe2e00
> --- /dev/null
> +++ b/tests/avocado/s390_topology.py
> @@ -0,0 +1,200 @@
> +# Functional test that boots a Linux kernel and checks the console
> +#
> +# Copyright IBM Corp. 2023
> +#
> +# Author:
> +#  Pierre Morel <pmorel@linux.ibm.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +import shutil
> +import time
> +
> +from avocado_qemu import QemuSystemTest
> +from avocado_qemu import exec_command
> +from avocado_qemu import exec_command_and_wait_for_pattern
> +from avocado_qemu import interrupt_interactive_console_until_pattern
> +from avocado_qemu import wait_for_console_pattern
> +from avocado.utils import process
> +from avocado.utils import archive
> +
> +
> +class S390CPUTopology(QemuSystemTest):
> +    """
> +    S390x CPU topology consists of 4 topology layers, from bottom to top,
> +    the cores, sockets, books and drawers and 2 modifiers attributes,
> +    the entitlement and the dedication.
> +    See: docs/system/s390x/cpu-topology.rst.
> +
> +    S390x CPU topology is setup in different ways:
> +    - implicitly from the '-smp' argument by completing each topology
> +      level one after the other beginning with drawer 0, book 0 and
> +      socket 0.
> +    - explicitly from the '-device' argument on the QEMU command line
> +    - explicitly by hotplug of a new CPU using QMP or HMP
> +    - it is modified by using QMP 'set-cpu-topology'
> +
> +    The S390x modifier attribute entitlement depends on the machine
> +    polarization, which can be horizontal or vertical.
> +    The polarization is changed on a request from the guest.
> +    """
> +    timeout = 90
> +
> +    KERNEL_COMMON_COMMAND_LINE = ('printk.time=0 '
> +                                  'root=/dev/ram '
> +                                  'selinux=0 '
> +                                  'rdinit=/bin/sh')
> +
> +    def wait_until_booted(self):
> +        wait_for_console_pattern(self, 'no job control',
> +                                 failure_message='Kernel panic - not syncing',
> +                                 vm=None)
> +
> +    def check_topology(self, c, s, b, d, e, t):
> +        res = self.vm.qmp('query-cpus-fast')
> +        cpus =  res['return']
> +        for cpu in cpus:
> +            core = cpu['props']['core-id']
> +            socket = cpu['props']['socket-id']
> +            book = cpu['props']['book-id']
> +            drawer = cpu['props']['drawer-id']
> +            entitlement = cpu.get('entitlement')
> +            dedicated = cpu.get('dedicated')
> +            if core == c:
> +                self.assertEqual(drawer, d)
> +                self.assertEqual(book, b)
> +                self.assertEqual(socket, s)
> +                self.assertEqual(entitlement, e)
> +                self.assertEqual(dedicated, t)
> +
> +    def kernel_init(self):
> +        """
> +        We need a VM that supports CPU topology,
> +        currently this only the case when using KVM, not TCG.
> +        We need a kernel supporting the CPU topology.
> +        We need a minimal root filesystem with a shell.
> +        """
> +        self.require_accelerator("kvm")
> +        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
> +                      '/fedora-secondary/releases/35/Server/s390x/os'
> +                      '/images/kernel.img')
> +        kernel_hash = '0d1aaaf303f07cf0160c8c48e56fe638'
> +        kernel_path = self.fetch_asset(kernel_url, algorithm='md5',
> +                                       asset_hash=kernel_hash)
> +
> +        initrd_url = ('https://archives.fedoraproject.org/pub/archive'
> +                      '/fedora-secondary/releases/35/Server/s390x/os'
> +                      '/images/initrd.img')
> +        initrd_hash = 'a122057d95725ac030e2ec51df46e172'
> +        initrd_path_xz = self.fetch_asset(initrd_url, algorithm='md5',
> +                                          asset_hash=initrd_hash)
> +        initrd_path = os.path.join(self.workdir, 'initrd-raw.img')
> +        archive.lzma_uncompress(initrd_path_xz, initrd_path)
> +
> +        self.vm.set_console()
> +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
> +        self.vm.add_args('-nographic',
> +                         '-enable-kvm',
> +                         '-cpu', 'max,ctop=on',
> +                         '-m', '512',
> +                         '-kernel', kernel_path,
> +                         '-initrd', initrd_path,
> +                         '-append', kernel_command_line)
> +
> +    def test_single(self):
> +        """
> +        This test checks the simplest topology with a single CPU.
> +
> +        :avocado: tags=arch:s390x
> +        :avocado: tags=machine:s390-ccw-virtio
> +        """
> +        self.kernel_init()
> +        self.vm.launch()
> +        self.wait_until_booted()
> +        self.check_topology(0, 0, 0, 0, 'medium', False)
> +
> +    def test_default(self):
> +        """
> +        This test checks the implicit topology.
> +
> +        :avocado: tags=arch:s390x
> +        :avocado: tags=machine:s390-ccw-virtio
> +        """
> +        self.kernel_init()
> +        self.vm.add_args('-smp',
> +                         '13,drawers=2,books=2,sockets=3,cores=2,maxcpus=24')
> +        self.vm.launch()
> +        self.wait_until_booted()
> +        self.check_topology(0, 0, 0, 0, 'medium', False)
> +        self.check_topology(1, 0, 0, 0, 'medium', False)
> +        self.check_topology(2, 1, 0, 0, 'medium', False)
> +        self.check_topology(3, 1, 0, 0, 'medium', False)
> +        self.check_topology(4, 2, 0, 0, 'medium', False)
> +        self.check_topology(5, 2, 0, 0, 'medium', False)
> +        self.check_topology(6, 0, 1, 0, 'medium', False)
> +        self.check_topology(7, 0, 1, 0, 'medium', False)
> +        self.check_topology(8, 1, 1, 0, 'medium', False)
> +        self.check_topology(9, 1, 1, 0, 'medium', False)
> +        self.check_topology(10, 2, 1, 0, 'medium', False)
> +        self.check_topology(11, 2, 1, 0, 'medium', False)
> +        self.check_topology(12, 0, 0, 1, 'medium', False)
> +
> +    def test_move(self):
> +        """
> +        This test checks the topology modification by moving a CPU
> +        to another socket: CPU 0 is moved from socket 0 to socket 2.
> +
> +        :avocado: tags=arch:s390x
> +        :avocado: tags=machine:s390-ccw-virtio
> +        """
> +        self.kernel_init()
> +        self.vm.add_args('-smp',
> +                         '1,drawers=2,books=2,sockets=3,cores=2,maxcpus=24')
> +        self.vm.launch()
> +        self.wait_until_booted()
> +
> +        self.check_topology(0, 0, 0, 0, 'medium', False)
> +        res = self.vm.qmp('set-cpu-topology',
> +                          {'core-id': 0, 'socket-id': 2, 'entitlement': 'low'})
> +        self.assertEqual(res['return'], {})
> +        self.check_topology(0, 2, 0, 0, 'low', False)

Booting a Linux kernel in the guest always takes some precious seconds of 
testing time ... I wonder whether it maybe makes sense to merge the above 
two tests into one?

> +    def test_hotplug_full(self):
> +        """
> +        This test verifies that a hotplugged defined with '-device'
> +        command line argument finds its right place inside the topology.

"hotplug" is normally rather a "device_add" via HMP/QMP during run-time, so 
I'd rather avoid this term here. Maybe call it "test_device_option" or so?

> +        :avocado: tags=arch:s390x
> +        :avocado: tags=machine:s390-ccw-virtio
> +        """
> +        self.kernel_init()
> +        self.vm.add_args('-smp',
> +                         '1,drawers=2,books=2,sockets=3,cores=2,maxcpus=24')
> +        self.vm.add_args('-device', 'max-s390x-cpu,core-id=10')
> +        self.vm.add_args('-device',
> +                         'max-s390x-cpu,'
> +                         'core-id=1,socket-id=0,book-id=1,drawer-id=1,entitlement=low')
> +        self.vm.add_args('-device',
> +                         'max-s390x-cpu,'
> +                         'core-id=2,socket-id=0,book-id=1,drawer-id=1,entitlement=medium')
> +        self.vm.add_args('-device',
> +                         'max-s390x-cpu,'
> +                         'core-id=3,socket-id=1,book-id=1,drawer-id=1,entitlement=high')
> +        self.vm.add_args('-device',
> +                         'max-s390x-cpu,'
> +                         'core-id=4,socket-id=1,book-id=1,drawer-id=1')
> +        self.vm.add_args('-device',
> +                         'max-s390x-cpu,'
> +                         'core-id=5,socket-id=2,book-id=1,drawer-id=1,dedicated=true')
> +
> +        self.vm.launch()
> +        self.wait_until_booted()
> +
> +        self.check_topology(10, 2, 1, 0, 'medium', False)
> +        self.check_topology(1, 0, 1, 1, 'low', False)
> +        self.check_topology(2, 0, 1, 1, 'medium', False)
> +        self.check_topology(3, 1, 1, 1, 'high', False)
> +        self.check_topology(4, 1, 1, 1, 'medium', False)
> +        self.check_topology(5, 2, 1, 1, 'high', True)

  Thomas



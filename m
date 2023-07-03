Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E0B745B67
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 13:43:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGHwl-0005R4-Ih; Mon, 03 Jul 2023 07:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGHwf-0005QY-21; Mon, 03 Jul 2023 07:42:17 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mKPa=CV=kaod.org=clg@ozlabs.org>)
 id 1qGHwc-0005C4-2T; Mon, 03 Jul 2023 07:42:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QvkYC0dhkz4wxR;
 Mon,  3 Jul 2023 21:42:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QvkY72d1Jz4wqZ;
 Mon,  3 Jul 2023 21:42:03 +1000 (AEST)
Message-ID: <6af57840-9b87-006a-554d-184078d4afae@kaod.org>
Date: Mon, 3 Jul 2023 13:41:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/4] tests/avocado: Add powernv machine test script
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20230703101700.24064-1-npiggin@gmail.com>
 <20230703101700.24064-5-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230703101700.24064-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mKPa=CV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 7/3/23 12:17, Nicholas Piggin wrote:
> This copies ppc_pseries.py to start a set of powernv tests, including
> a Linux boot test for the newly added SMT mode.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>


Reviewed-by: Cédric Le Goater <clg@kaod.org>

A couple of suggestions below,

  


> ---
>   tests/avocado/ppc_powernv.py | 86 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 86 insertions(+)
>   create mode 100644 tests/avocado/ppc_powernv.py
> 
> diff --git a/tests/avocado/ppc_powernv.py b/tests/avocado/ppc_powernv.py
> new file mode 100644
> index 0000000000..f72e87bc70
> --- /dev/null
> +++ b/tests/avocado/ppc_powernv.py
> @@ -0,0 +1,86 @@
> +# Test that Linux kernel boots on ppc powernv machines and check the console
> +#
> +# Copyright (c) 2018, 2020 Red Hat, Inc.
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from avocado.utils import archive
> +from avocado_qemu import QemuSystemTest
> +from avocado_qemu import wait_for_console_pattern
> +
> +class powernvMachine(QemuSystemTest):
> +
> +    timeout = 90
> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
> +    panic_message = 'Kernel panic - not syncing'
> +    good_message = 'VFS: Cannot open root device'
> +
> +    def do_test_linux_boot(self):
> +        self.require_accelerator("tcg")
> +        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
> +                      '/fedora-secondary/releases/29/Everything/ppc64le/os'
> +                      '/ppc/ppc64/vmlinuz')

f29 does support P10 :

   Linux version 4.18.16-300.fc29.ppc64le (mockbuild@buildvm-ppc64le-03.ppc.fedoraproject.org) (gcc version 8.2.1 20180801 (Red Hat 8.2.1-2) (GCC)) #1 SMP Sat Oct 20 23:28:27 UTC 2018

What about :

   https://archives.fedoraproject.org/pub/archive/fedora-secondary/releases/36/Everything/ppc64le/os/ppc/ppc64/

> +        kernel_hash = '3fe04abfc852b66653b8c3c897a59a689270bc77'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        self.vm.set_console()
> +        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'console=hvc0'
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-append', kernel_command_line)
> +        self.vm.launch()
> +
> +    def test_linux_boot(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:powernv

This defaults to POWER9 cpus. No POWER10 ?

> +        :avocado: tags=accel:tcg
> +        """
> +
> +        self.do_test_linux_boot()
> +        console_pattern = 'VFS: Cannot open root device'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +
> +    def test_linux_smp_boot(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:powernv
> +        :avocado: tags=accel:tcg
> +        """
> +
> +        self.vm.add_args('-smp', '4')
> +        self.do_test_linux_boot()
> +        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        wait_for_console_pattern(self, self.good_message, self.panic_message)
> +
> +    def test_linux_smt_boot(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:powernv
> +        :avocado: tags=accel:tcg
> +        """
> +
> +        self.vm.add_args('-smp', '4,threads=4')
> +        self.do_test_linux_boot()
> +        console_pattern = 'CPU maps initialized for 4 threads per core'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        wait_for_console_pattern(self, self.good_message, self.panic_message)
> +
> +    def test_linux_big_boot(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:powernv
> +        :avocado: tags=accel:tcg
> +        """
> +
> +        self.vm.add_args('-smp', '8,threads=4,cores=2,sockets=1')

I would test 2 sockets.

Thanks,

C.

> +        # powernv does not support NUMA
> +        self.do_test_linux_boot()
> +        console_pattern = 'CPU maps initialized for 4 threads per core'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        console_pattern = 'smp: Brought up 1 node, 8 CPUs'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        wait_for_console_pattern(self, self.good_message, self.panic_message)



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1450574865A
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 16:29:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH3Ux-0000a9-K3; Wed, 05 Jul 2023 10:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=c5xU=CX=kaod.org=clg@ozlabs.org>)
 id 1qH3Uv-0000YE-HD; Wed, 05 Jul 2023 10:28:49 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=c5xU=CX=kaod.org=clg@ozlabs.org>)
 id 1qH3Ut-0007yM-5i; Wed, 05 Jul 2023 10:28:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qx28S5hyyz4wxW;
 Thu,  6 Jul 2023 00:28:40 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qx28Q1XTtz4wb8;
 Thu,  6 Jul 2023 00:28:37 +1000 (AEST)
Message-ID: <20f8f102-ce09-8aeb-202c-5db507b7a79f@kaod.org>
Date: Wed, 5 Jul 2023 16:28:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 4/4] tests/avocado: Add powernv machine test script
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230705120631.27670-1-npiggin@gmail.com>
 <20230705120631.27670-5-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230705120631.27670-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=c5xU=CX=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.089, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 7/5/23 14:06, Nicholas Piggin wrote:
> This copies ppc_pseries.py to start a set of powernv tests, including
> a Linux boot test for the newly added SMT mode.
> 
> Reviewed-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> I didn't add the powernv10 support yet as Cedric suggested, and kept the
> same vmlinuz because it's common with the pseries tests. We should do
> that in later tests though. Might be time to update default to power10
> soon if the model is becoming more complete...

power10 is as good as power9, I would say. power9 has been the default for
4 years now. power9 systems are publicly  available though. As you wish.

If we had some ways to deactivate the doorbells when booting Linux, we
would test XIVE with the CPU IPIs also with the tests you introduced.

Pity this wasn't merged :

   https://lore.kernel.org/all/20211105102636.1016378-12-clg@kaod.org/

May be it is possible to tweak the CPU features in OPAL with a QEMU
DT property to remove doorbells ?

C.


> 
> Thanks,
> Nick
> 
>   tests/avocado/ppc_powernv.py | 87 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 87 insertions(+)
>   create mode 100644 tests/avocado/ppc_powernv.py
> 
> diff --git a/tests/avocado/ppc_powernv.py b/tests/avocado/ppc_powernv.py
> new file mode 100644
> index 0000000000..d0e5c07bde
> --- /dev/null
> +++ b/tests/avocado/ppc_powernv.py
> @@ -0,0 +1,87 @@
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
> +        self.vm.add_args('-smp', '16,threads=4,cores=2,sockets=2')
> +
> +        # powernv does not support NUMA
> +        self.do_test_linux_boot()
> +        console_pattern = 'CPU maps initialized for 4 threads per core'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        console_pattern = 'smp: Brought up 2 nodes, 16 CPUs'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        wait_for_console_pattern(self, self.good_message, self.panic_message)



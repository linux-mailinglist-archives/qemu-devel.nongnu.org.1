Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C509C826D9C
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:17:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMoYx-0008OQ-P1; Mon, 08 Jan 2024 07:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=tOGw=IS=kaod.org=clg@ozlabs.org>)
 id 1rMoYt-0008NI-VT; Mon, 08 Jan 2024 07:16:59 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=tOGw=IS=kaod.org=clg@ozlabs.org>)
 id 1rMoYq-0004R2-WC; Mon, 08 Jan 2024 07:16:59 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4T7tN26Ytqz4x22;
 Mon,  8 Jan 2024 23:16:50 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7tMy73Kfz4x1v;
 Mon,  8 Jan 2024 23:16:46 +1100 (AEDT)
Message-ID: <6e7ff0f1-40d7-4bd6-8f1c-8776202af075@kaod.org>
Date: Mon, 8 Jan 2024 13:16:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] tests/avocado: Add FreeBSD distro boot tests for ppc
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Warner Losh <imp@bsdimp.com>
References: <20240107170119.82222-1-npiggin@gmail.com>
 <20240107170119.82222-10-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240107170119.82222-10-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=tOGw=IS=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_MED=-2.3,
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

On 1/7/24 18:01, Nicholas Piggin wrote:
> FreeBSD project provides qcow2 images that work well for testing QEMU.
> Add pseries tests for HPT and Radix, KVM and TCG. This uses a short
> term VM image, because FreeBSD has not set up long term builds for
> ppc64 at present.
> 
> Other architectures could be added so this does not get a ppc_ prefix
> but is instead named similarly to boot_linux.
> 
> Reviewed-by: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Unfortunately the latest stable (14.0) x86-64 VM image does not seem to
> output to console by default and I've not been able to find a reliable
> way to edit the filesystem to change the boot loader options, or use
> console input in the test case to change it on the fly.

It would be interesting to add similar tests for the Big-Endian pseries
image, may be not all tests, but at least TCG.

Also, booting the kernel on a powernv9 machine would be nice. FreeBSD
supports OPAL on POWER9 and it is not that common. It would exercise
the PowerNV models differently from Linux.

I tried the apple image on a mac99,G5 machine but the kernel panics on
a DSI.


> ---
>   tests/avocado/boot_freebsd.py | 106 ++++++++++++++++++++++++++++++++++
>   1 file changed, 106 insertions(+)
>   create mode 100644 tests/avocado/boot_freebsd.py
> 
> diff --git a/tests/avocado/boot_freebsd.py b/tests/avocado/boot_freebsd.py
> new file mode 100644
> index 0000000000..79c68b149a
> --- /dev/null
> +++ b/tests/avocado/boot_freebsd.py
> @@ -0,0 +1,106 @@
> +# Functional tests that boot FreeBSD in various configurations
> +#
> +# Copyright (c) 2023 IBM Corporation
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later. See the COPYING file in the top-level directory.
> +
> +import os
> +
> +from avocado import skipUnless
> +from avocado_qemu import QemuSystemTest
> +from avocado_qemu import wait_for_console_pattern
> +from avocado_qemu import exec_command
> +from avocado.utils import archive
> +from avocado.utils import process
> +from avocado.utils.path import find_command
> +
> +@skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
> +@skipUnless(os.getenv('AVOCADO_ALLOW_LONG_RUNTIME'), 'runtime limited')
> +class BootFreeBSDPPC64(QemuSystemTest):
> +    """
> +    :avocado: tags=arch:ppc64
> +    """
> +
> +    timeout = 360
> +
> +    def setUp(self):
> +        super().setUp()
> +
> +        # We need zstd for all the tests
> +        # See https://github.com/avocado-framework/avocado/issues/5609
> +        zstd = find_command('zstd', False)
> +        if zstd is False:
> +            self.cancel('Could not find "zstd", which is required to '
> +                        'decompress rootfs')
> +        drive_url = ('https://artifact.ci.freebsd.org/snapshot/15.0-CURRENT/8a735ffdf04936c6785ac4fa31486639262dd416/powerpc/powerpc64le/disk.qcow2.zst')

The problem is the sustainability of this snapshot. It seems FreeBSD keeps
one year of history.

Thanks,

C.



> +        drive_hash = '95d863dbbc4b60f4899d1ef21d6489fca05bf03d'
> +        drive_path_zstd = self.fetch_asset(drive_url, asset_hash=drive_hash)
> +        drive_path = os.path.join(self.workdir, 'disk.qcow2')
> +
> +        cmd = f"{zstd} -d {drive_path_zstd} -o {drive_path}"
> +        process.run(cmd)
> +
> +        self.drive_opt = f"file={drive_path},format=qcow2,if=virtio"
> +
> +    def run_pseries_test(self, force_HPT=False):
> +        if force_HPT:
> +            self.vm.add_args('-m', '4g')
> +        else:
> +            self.vm.add_args('-m', '1g')
> +        self.vm.add_args('-smp', '4')
> +        self.vm.add_args('-drive', self.drive_opt)
> +        self.vm.add_args('-net', 'nic,model=virtio')
> +        self.vm.set_console()
> +        self.vm.launch()
> +
> +        wait_for_console_pattern(self, 'Hit [Enter] to boot immediately, or any other key for command prompt.')
> +        if force_HPT:
> +            exec_command(self, 'x')
> +            wait_for_console_pattern(self, 'OK')
> +            exec_command(self, 'set radix_mmu=0')
> +            exec_command(self, 'boot')
> +            wait_for_console_pattern(self, 'cas: selected hash MMU', 'panic:')
> +        else:
> +            exec_command(self, '')
> +            wait_for_console_pattern(self, 'cas: selected radix MMU', 'panic:')
> +
> +        wait_for_console_pattern(self, 'FreeBSD 15.0-CURRENT', 'panic:')
> +        wait_for_console_pattern(self, 'FreeBSD/SMP: Multiprocessor System Detected: 4 CPUs', 'panic:')
> +        wait_for_console_pattern(self, 'FreeBSD/powerpc (Amnesiac) (ttyu0)', 'panic:')
> +
> +    def test_pseries_tcg(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        :avocado: tags=accel:tcg
> +        """
> +        self.require_accelerator("tcg")
> +        self.run_pseries_test()
> +
> +    def test_pseries_hpt_tcg(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        :avocado: tags=accel:tcg
> +        """
> +        self.require_accelerator("tcg")
> +        self.run_pseries_test(force_HPT=True)
> +
> +    def test_pseries_kvm(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        :avocado: tags=accel:kvm
> +        """
> +        self.require_accelerator("kvm")
> +        self.run_pseries_test()
> +
> +    def test_pseries_hpt_kvm(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        :avocado: tags=accel:kvm
> +        """
> +        self.require_accelerator("kvm")
> +        self.run_pseries_test(force_HPT=True)



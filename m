Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A0882719C
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 15:40:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMqlv-0006Zh-AK; Mon, 08 Jan 2024 09:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=tOGw=IS=kaod.org=clg@ozlabs.org>)
 id 1rMqlf-0006TI-3X; Mon, 08 Jan 2024 09:38:20 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=tOGw=IS=kaod.org=clg@ozlabs.org>)
 id 1rMqla-0007hG-2S; Mon, 08 Jan 2024 09:38:18 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4T7xVs5JVDz4wp0;
 Tue,  9 Jan 2024 01:37:57 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T7xVp1BCNz4wbr;
 Tue,  9 Jan 2024 01:37:53 +1100 (AEDT)
Message-ID: <440a3ca8-422e-46d8-a176-aa644d602af7@kaod.org>
Date: Mon, 8 Jan 2024 15:37:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] tests/avocado: ppc add hypervisor tests
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org
References: <20240107170119.82222-1-npiggin@gmail.com>
 <20240107170119.82222-9-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240107170119.82222-9-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
> The powernv and pseries machines both provide hypervisor facilities
> that are supported by KVM. This is a large and complicated set of
> features that don't get much system-level testing in ppc tests.
> 
> Add a new test case for these which runs QEMU KVM inside the target.
> This downloads an Alpine VM image, boots it and downloads and installs
> the qemu package, then boots a virtual machine under it, re-using the
> original Alpine VM image.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   MAINTAINERS                   |   1 +
>   tests/avocado/ppc_hv_tests.py | 201 ++++++++++++++++++++++++++++++++++
>   2 files changed, 202 insertions(+)
>   create mode 100644 tests/avocado/ppc_hv_tests.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 395f26ba86..ffe91a2bc5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1509,6 +1509,7 @@ F: tests/qtest/libqos/*spapr*
>   F: tests/qtest/rtas*
>   F: tests/qtest/libqos/rtas*
>   F: tests/avocado/ppc_pseries.py
> +F: tests/avocado/ppc_hv_tests.py
>   
>   PowerNV (Non-Virtualized)
>   M: Cédric Le Goater <clg@kaod.org>
> diff --git a/tests/avocado/ppc_hv_tests.py b/tests/avocado/ppc_hv_tests.py
> new file mode 100644
> index 0000000000..2162d6bd68
> --- /dev/null
> +++ b/tests/avocado/ppc_hv_tests.py
> @@ -0,0 +1,201 @@
> +# Tests that specifically try to exercise hypervisor features of the
> +# target machines. powernv supports the Power hypervisor ISA, and
> +# pseries supports the nested-HV hypervisor spec.
> +#
> +# Copyright (c) 2023 IBM Corporation
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from avocado import skipIf, skipUnless
> +from avocado.utils import archive
> +from avocado_qemu import QemuSystemTest
> +from avocado_qemu import wait_for_console_pattern, exec_command
> +import os
> +import time
> +import subprocess
> +
> +deps = ["xorriso"] # dependent tools needed in the test setup/box.
> +
> +def which(tool):
> +    """ looks up the full path for @tool, returns None if not found
> +        or if @tool does not have executable permissions.
> +    """
> +    paths=os.getenv('PATH')
> +    for p in paths.split(os.path.pathsep):
> +        p = os.path.join(p, tool)
> +        if os.path.exists(p) and os.access(p, os.X_OK):
> +            return p
> +    return None
> +
> +def missing_deps():
> +    """ returns True if any of the test dependent tools are absent.
> +    """
> +    for dep in deps:
> +        if which(dep) is None:
> +            return True
> +    return False
> +
> +# Alpine is a light weight distro that supports QEMU. These tests boot
> +# that on the machine then run a QEMU guest inside it in KVM mode,
> +# that runs the same Alpine distro image.
> +# QEMU packages are downloaded and installed on each test. That's not a
> +# large download, but it may be more polite to create qcow2 image with
> +# QEMU already installed and use that.
> +@skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
> +@skipUnless(os.getenv('AVOCADO_ALLOW_LONG_RUNTIME'), 'runtime limited')
> +@skipIf(missing_deps(), 'dependencies (%s) not installed' % ','.join(deps))
> +class HypervisorTest(QemuSystemTest):
> +
> +    timeout = 1000
> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 console=hvc0 '
> +    panic_message = 'Kernel panic - not syncing'
> +    good_message = 'VFS: Cannot open root device'
> +
> +    def extract_from_iso(self, iso, path):
> +        """
> +        Extracts a file from an iso file into the test workdir
> +
> +        :param iso: path to the iso file
> +        :param path: path within the iso file of the file to be extracted
> +        :returns: path of the extracted file
> +        """
> +        filename = os.path.basename(path)
> +
> +        cwd = os.getcwd()
> +        os.chdir(self.workdir)
> +
> +        with open(filename, "w") as outfile:
> +            cmd = "xorriso -osirrox on -indev %s -cpx %s %s" %
> +                  (iso, path, filename)
$ build/pyvenv/bin/avocado -V list  build/tests/avocado/ppc_hv_tests.py
Type Test Tag(s)

Resolver             Reference                           Info
avocado-instrumented build/tests/avocado/ppc_hv_tests.py invalid syntax (ppc_hv_tests.py, line 77)

With this change :

@@ -66,8 +74,7 @@ class HypervisorTest(QemuSystemTest):
          os.chdir(self.workdir)
  
          with open(filename, "w") as outfile:
-            cmd = "xorriso -osirrox on -indev %s -cpx %s %s" %
-                  (iso, path, filename)
+            cmd = "xorriso -osirrox on -indev %s -cpx %s %s" % (iso, path, filename)
              subprocess.run(cmd.split(),
                             stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
  
the tests run :

   (1/3) build/tests/avocado/ppc_hv_tests.py:HypervisorTest.test_hv_pseries: PASS (330.62 s)
   (2/3) build/tests/avocado/ppc_hv_tests.py:HypervisorTest.test_hv_pseries_kvm: PASS (327.66 s)
   (3/3) build/tests/avocado/ppc_hv_tests.py:HypervisorTest.test_hv_powernv: /

test 2/3 is not using KVM, TCG is forced in do_start_alpine(), and
the powernv  test fails when starting the HPT VM. See below. Anyhow,
this looks promising. Thanks for these tests.

If you need small images for the L2, you could use :

https://github.com/legoater/qemu-ppc-boot/tree/main/buildroot/qemu_ppc64le_pseries-2023.11-8-gdcd9f0f6eb-20240104

C.


2024-01-08 15:22:06,328 __init__         L0153 DEBUG| (detected by 0, t=2103 jiffies, g=7877, q=12 ncpus=2)
2024-01-08 15:22:06,330 __init__         L0153 DEBUG| Sending NMI from CPU 0 to CPUs 1:
2024-01-08 15:22:06,614 __init__         L0153 DEBUG| NMI backtrace for cpu 1
2024-01-08 15:22:06,618 __init__         L0153 DEBUG| CPU: 1 PID: 2431 Comm: init-early.sh Not tainted 6.1.55-0-lts #1-Alpine
2024-01-08 15:22:06,622 __init__         L0153 DEBUG| Hardware name: IBM pSeries (emulated by qemu) POWER9 (raw) 0x4e1202 0xf000005 hv:linux,kvm pSeries
2024-01-08 15:22:06,625 __init__         L0153 DEBUG| NIP:  c0000000004a6510 LR: c0000000004adb10 CTR: 0000000000000023
2024-01-08 15:22:06,629 __init__         L0153 DEBUG| REGS: c00000000834b440 TRAP: 0500   Not tainted  (6.1.55-0-lts)
2024-01-08 15:22:06,633 __init__         L0153 DEBUG| MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 44844800  XER: 00000000
2024-01-08 15:22:06,635 __init__         L0153 DEBUG| CFAR: 0000000000000000 IRQMASK: 0
2024-01-08 15:22:06,638 __init__         L0153 DEBUG| GPR00: c0000000004adb10 c00000000834b6e0 c000000001502300 c00c0000000fe900
2024-01-08 15:22:06,641 __init__         L0153 DEBUG| GPR04: 0000000000000001 0000000000000400 0000000000000200 0000000000000100
2024-01-08 15:22:06,644 __init__         L0153 DEBUG| GPR08: 0000000000000040 c00000003fa47400 0000000000000080 c0000000025935b0
2024-01-08 15:22:06,647 __init__         L0153 DEBUG| GPR12: 0000000000000180 c00000003ffff300 0000000040000000 c00000003ffb3800
2024-01-08 15:22:06,650 __init__         L0153 DEBUG| GPR16: 0000000000000000 0000000000000000 0000000000000000 c00c0000000fe900
2024-01-08 15:22:06,654 __init__         L0153 DEBUG| GPR20: c00000000834b910 0000000000000000 0000000000000881 c00000003fd92fa8
2024-01-08 15:22:06,656 __init__         L0153 DEBUG| GPR24: 0000000000000000 c00c0000000fe908 0000000000000001 c00000003fd92f80
2024-01-08 15:22:06,659 __init__         L0153 DEBUG| GPR28: c0000000028391d0 0000000000000380 0000000000000300 0000000000000280
2024-01-08 15:22:06,663 __init__         L0153 DEBUG| NIP [c0000000004a6510] kernel_init_pages+0xa0/0x120
2024-01-08 15:22:06,665 __init__         L0153 DEBUG| LR [c0000000004adb10] get_page_from_freelist+0xa00/0x1640
2024-01-08 15:22:06,666 __init__         L0153 DEBUG| Call Trace:
2024-01-08 15:22:06,670 __init__         L0153 DEBUG| [c00000000834b6e0] [c0000000004ad438] get_page_from_freelist+0x328/0x1640 (unreliable)
2024-01-08 15:22:06,674 __init__         L0153 DEBUG| [c00000000834b820] [c0000000004af094] __alloc_pages+0x174/0x12f0
2024-01-08 15:22:06,676 __init__         L0153 DEBUG| [c00000000834ba10] [c0000000004b0bd4] __folio_alloc+0x34/0xb0
2024-01-08 15:22:06,679 __init__         L0153 DEBUG| [c00000000834ba40] [c0000000004e5ef8] vma_alloc_folio+0xd8/0x530
2024-01-08 15:22:06,682 __init__         L0153 DEBUG| [c00000000834baf0] [c000000000470ff8] wp_page_copy+0xc8/0xf10
2024-01-08 15:22:06,685 __init__         L0153 DEBUG| [c00000000834bbd0] [c000000000479188] __handle_mm_fault+0x9d8/0x1940
2024-01-08 15:22:06,688 __init__         L0153 DEBUG| [c00000000834bcc0] [c00000000047a240] handle_mm_fault+0x150/0x3d0
2024-01-08 15:22:06,691 __init__         L0153 DEBUG| [c00000000834bd10] [c00000000008184c] ___do_page_fault+0x32c/0x920
2024-01-08 15:22:06,695 __init__         L0153 DEBUG| [c00000000834bdb0] [c000000000081f10] hash__do_page_fault+0x30/0x100
2024-01-08 15:22:06,698 __init__         L0153 DEBUG| [c00000000834bde0] [c00000000008bd44] do_hash_fault+0x1f4/0x390
2024-01-08 15:22:06,701 __init__         L0153 DEBUG| [c00000000834be10] [c000000000008918] data_access_common_virt+0x198/0x1f0
2024-01-08 15:22:06,703 __init__         L0153 DEBUG| --- interrupt: 300 at 0x7fff9da32a60
2024-01-08 15:22:06,706 __init__         L0153 DEBUG| NIP:  00007fff9da32a60 LR: 00007fff9da37400 CTR: 0000000000000000
2024-01-08 15:22:06,709 __init__         L0153 DEBUG| REGS: c00000000834be80 TRAP: 0300   Not tainted  (6.1.55-0-lts)
2024-01-08 15:22:06,713 __init__         L0153 DEBUG| MSR:  800000000000d033 <SF,EE,PR,ME,IR,DR,RI,LE>  CR: 20000000  XER: 00000000
2024-01-08 15:22:06,716 __init__         L0153 DEBUG| CFAR: c000000000002230 DAR: 00007fff9da7f988 DSISR: 0a000000 IRQMASK: 0
2024-01-08 15:22:06,719 __init__         L0153 DEBUG| GPR00: 00007fff9da37400 00007fffef7f61f0 00007fff9da87e00 00007fff9d9c0000
2024-01-08 15:22:06,723 __init__         L0153 DEBUG| GPR04: 00007fff9da7fbf0 00007fff9da45e84 00007fff9d9d3fb0 00007fffef7f6460
2024-01-08 15:22:06,726 __init__         L0153 DEBUG| GPR08: 0000000000000030 00000000000bf988 00007fff9da7f990 0000000000000000
2024-01-08 15:22:06,728 __init__         L0153 DEBUG| GPR12: 00007fff9da373d8 0000000000000000 0000000000000000 0000000000000000
2024-01-08 15:22:06,731 __init__         L0153 DEBUG| GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
2024-01-08 15:22:06,735 __init__         L0153 DEBUG| GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
2024-01-08 15:22:06,738 __init__         L0153 DEBUG| GPR24: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
2024-01-08 15:22:06,741 __init__         L0153 DEBUG| GPR28: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
2024-01-08 15:22:06,743 __init__         L0153 DEBUG| NIP [00007fff9da32a60] 0x7fff9da32a60
2024-01-08 15:22:06,745 __init__         L0153 DEBUG| LR [00007fff9da37400] 0x7fff9da37400
2024-01-08 15:22:06,746 __init__         L0153 DEBUG| --- interrupt: 300
2024-01-08 15:22:06,748 __init__         L0153 DEBUG| Instruction dump:
2024-01-08 15:22:06,751 __init__         L0153 DEBUG| 7d291850 79470fa4 792953e4 79461764 78a9f00e 79451f24 7d8a3a14 7fc73214
2024-01-08 15:22:06,754 __init__         L0153 DEBUG| 7fea3214 7faa2850 7908e8e2 7d0903a6 <7c004fec> 7c0a4fec 7c074fec 7c0c4fec




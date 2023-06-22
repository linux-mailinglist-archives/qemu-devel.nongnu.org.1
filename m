Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A27F73A755
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 19:34:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCOBw-0007BK-7V; Thu, 22 Jun 2023 13:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=yb1G=CK=kaod.org=clg@ozlabs.org>)
 id 1qCOBr-0006ue-VI; Thu, 22 Jun 2023 13:33:51 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=yb1G=CK=kaod.org=clg@ozlabs.org>)
 id 1qCOBn-00072Q-9k; Thu, 22 Jun 2023 13:33:50 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qn6t03T5dz4x3S;
 Fri, 23 Jun 2023 03:33:44 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qn6sx6Z9sz4x3k;
 Fri, 23 Jun 2023 03:33:41 +1000 (AEST)
Message-ID: <d98b6682-647c-6edd-20ee-ca9672bafef9@kaod.org>
Date: Thu, 22 Jun 2023 19:33:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 7/7] tests/avocado: Add ppc64 pseries multiprocessor
 boot tests
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230622093357.255649-1-npiggin@gmail.com>
 <20230622093357.255649-8-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230622093357.255649-8-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=yb1G=CK=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 6/22/23 11:33, Nicholas Piggin wrote:
> Add mult-thread/core/socket Linux boot tests that ensure the right
> topology comes up. Of particular note is a SMT test, which is a new
> capability for TCG.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.



> ---
>   tests/avocado/ppc_pseries.py | 60 +++++++++++++++++++++++++++++++++---
>   1 file changed, 55 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/avocado/ppc_pseries.py b/tests/avocado/ppc_pseries.py
> index a152cf222e..ff42c770f2 100644
> --- a/tests/avocado/ppc_pseries.py
> +++ b/tests/avocado/ppc_pseries.py
> @@ -14,12 +14,9 @@ class pseriesMachine(QemuSystemTest):
>       timeout = 90
>       KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
>       panic_message = 'Kernel panic - not syncing'
> +    good_message = 'VFS: Cannot open root device'
>   
> -    def test_ppc64_pseries(self):
> -        """
> -        :avocado: tags=arch:ppc64
> -        :avocado: tags=machine:pseries
> -        """
> +    def do_test_ppc64_linux_boot(self):
>           kernel_url = ('https://archives.fedoraproject.org/pub/archive'
>                         '/fedora-secondary/releases/29/Everything/ppc64le/os'
>                         '/ppc/ppc64/vmlinuz')
> @@ -31,5 +28,58 @@ def test_ppc64_pseries(self):
>           self.vm.add_args('-kernel', kernel_path,
>                            '-append', kernel_command_line)
>           self.vm.launch()
> +
> +    def test_ppc64_linux_boot(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        """
> +
> +        self.do_test_ppc64_linux_boot()
>           console_pattern = 'VFS: Cannot open root device'
>           wait_for_console_pattern(self, console_pattern, self.panic_message)
> +
> +    def test_ppc64_linux_smp_boot(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        """
> +
> +        self.vm.add_args('-smp', '4')
> +        self.do_test_ppc64_linux_boot()
> +        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        wait_for_console_pattern(self, self.good_message, self.panic_message)
> +
> +    def test_ppc64_linux_smt_boot(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        """
> +
> +        self.vm.add_args('-smp', '4,threads=4')
> +        self.do_test_ppc64_linux_boot()
> +        console_pattern = 'CPU maps initialized for 4 threads per core'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        console_pattern = 'smp: Brought up 1 node, 4 CPUs'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        wait_for_console_pattern(self, self.good_message, self.panic_message)
> +
> +    def test_ppc64_linux_big_boot(self):
> +        """
> +        :avocado: tags=arch:ppc64
> +        :avocado: tags=machine:pseries
> +        """
> +
> +        self.vm.add_args('-smp', '16,threads=4,cores=2,sockets=2')
> +        self.vm.add_args('-m', '512M',
> +                         '-object', 'memory-backend-ram,size=256M,id=m0',
> +                         '-object', 'memory-backend-ram,size=256M,id=m1')
> +        self.vm.add_args('-numa', 'node,nodeid=0,memdev=m0')
> +        self.vm.add_args('-numa', 'node,nodeid=1,memdev=m1')
> +        self.do_test_ppc64_linux_boot()
> +        console_pattern = 'CPU maps initialized for 4 threads per core'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        console_pattern = 'smp: Brought up 2 nodes, 16 CPUs'
> +        wait_for_console_pattern(self, console_pattern, self.panic_message)
> +        wait_for_console_pattern(self, self.good_message, self.panic_message)



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5826FAA8D48
	for <lists+qemu-devel@lfdr.de>; Mon,  5 May 2025 09:45:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBqUy-0005IM-PV; Mon, 05 May 2025 03:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=q0bJ=XV=kaod.org=clg@ozlabs.org>)
 id 1uBqUv-0005Hk-Bz; Mon, 05 May 2025 03:44:21 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=q0bJ=XV=kaod.org=clg@ozlabs.org>)
 id 1uBqUs-0006ht-Kb; Mon, 05 May 2025 03:44:20 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZrYST6D4Nz4xNx;
 Mon,  5 May 2025 17:44:09 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZrYSQ0w5hz4xN6;
 Mon,  5 May 2025 17:44:03 +1000 (AEST)
Message-ID: <c8b71cca-4b77-4796-96c7-7bbe0c2df3ba@kaod.org>
Date: Mon, 5 May 2025 09:43:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/9] tests/function/aspeed: Add functional test for
 ast2700fc
To: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, longzl2@lenovo.com, yunlin.tang@aspeedtech.com
References: <20250505030618.3612042-1-steven_lee@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250505030618.3612042-1-steven_lee@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=q0bJ=XV=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/5/25 05:06, Steven Lee wrote:
> Introduce a new test suite for ast2700fc machine.
> Rename the original test_aarch64_aspeed.py to
> test_aarch64_aspeed_ast2700.py.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> Change-Id: I3855f55c9f6e5cca1270c179445f549f8d81f36c

meson.build should also be modified to take into account the new tests.
I fixed it.

Anyhow,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



> ---
>   ...peed.py => test_aarch64_aspeed_ast2700.py} |   0
>   .../test_aarch64_aspeed_ast2700fc.py          | 135 ++++++++++++++++++
>   2 files changed, 135 insertions(+)
>   rename tests/functional/{test_aarch64_aspeed.py => test_aarch64_aspeed_ast2700.py} (100%)
>   create mode 100755 tests/functional/test_aarch64_aspeed_ast2700fc.py
> 
> diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed_ast2700.py
> similarity index 100%
> rename from tests/functional/test_aarch64_aspeed.py
> rename to tests/functional/test_aarch64_aspeed_ast2700.py
> diff --git a/tests/functional/test_aarch64_aspeed_ast2700fc.py b/tests/functional/test_aarch64_aspeed_ast2700fc.py
> new file mode 100755
> index 0000000000..b85370e182
> --- /dev/null
> +++ b/tests/functional/test_aarch64_aspeed_ast2700fc.py
> @@ -0,0 +1,135 @@
> +#!/usr/bin/env python3
> +#
> +# Functional test that boots the ASPEED SoCs with firmware
> +#
> +# Copyright (C) 2022 ASPEED Technology Inc
> +#
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +import os
> +
> +from qemu_test import QemuSystemTest, Asset
> +from qemu_test import wait_for_console_pattern
> +from qemu_test import exec_command_and_wait_for_pattern
> +
> +
> +class AST2x00MachineSDK(QemuSystemTest):
> +
> +    def do_test_aarch64_aspeed_sdk_start(self, image):
> +        self.require_netdev('user')
> +        self.vm.set_console()
> +        self.vm.add_args('-device',
> +                         'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
> +        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
> +                         '-net', 'nic', '-net', 'user', '-snapshot')
> +
> +        self.vm.launch()
> +
> +    def verify_openbmc_boot_and_login(self, name):
> +        wait_for_console_pattern(self, 'U-Boot 2023.10')
> +        wait_for_console_pattern(self, '## Loading kernel from FIT Image')
> +        wait_for_console_pattern(self, 'Starting kernel ...')
> +
> +        wait_for_console_pattern(self, f'{name} login:')
> +        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
> +        exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
> +
> +    ASSET_SDK_V906_AST2700 = Asset(
> +            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.06/ast2700-default-obmc.tar.gz',
> +            'f1d53e0be8a404ecce3e105f72bc50fa4e090ad13160ffa91b10a6e0233a9dc6')
> +
> +    def do_ast2700_i2c_test(self):
> +        exec_command_and_wait_for_pattern(self,
> +            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device ',
> +            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d')
> +        exec_command_and_wait_for_pattern(self,
> +            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '0')
> +        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
> +                    property='temperature', value=18000)
> +        exec_command_and_wait_for_pattern(self,
> +            'cat /sys/bus/i2c/devices/1-004d/hwmon/hwmon*/temp1_input', '18000')
> +
> +    def do_ast2700fc_ssp_test(self):
> +        self.vm.shutdown()
> +        self.vm.set_console(console_index=1)
> +        self.vm.launch()
> +
> +        exec_command_and_wait_for_pattern(self, '\012', 'ssp:~$')
> +        exec_command_and_wait_for_pattern(self, 'version',
> +                                          'Zephyr version 3.7.1')
> +        exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
> +                                          '[72c02000] 06010103')
> +
> +    def do_ast2700fc_tsp_test(self):
> +        self.vm.shutdown()
> +        self.vm.set_console(console_index=2)
> +        self.vm.launch()
> +
> +        exec_command_and_wait_for_pattern(self, '\012', 'tsp:~$')
> +        exec_command_and_wait_for_pattern(self, 'version',
> +                                          'Zephyr version 3.7.1')
> +        exec_command_and_wait_for_pattern(self, 'md 72c02000 1',
> +                                          '[72c02000] 06010103')
> +
> +    def start_ast2700fc_test(self, name):
> +        ca35_core = 4
> +        uboot_size = os.path.getsize(self.scratch_file(name,
> +                                                       'u-boot-nodtb.bin'))
> +        uboot_dtb_load_addr = hex(0x400000000 + uboot_size)
> +
> +        load_images_list = [
> +            {
> +                'addr': '0x400000000',
> +                'file': self.scratch_file(name,
> +                                          'u-boot-nodtb.bin')
> +            },
> +            {
> +                'addr': str(uboot_dtb_load_addr),
> +                'file': self.scratch_file(name, 'u-boot.dtb')
> +            },
> +            {
> +                'addr': '0x430000000',
> +                'file': self.scratch_file(name, 'bl31.bin')
> +            },
> +            {
> +                'addr': '0x430080000',
> +                'file': self.scratch_file(name, 'optee',
> +                                          'tee-raw.bin')
> +            }
> +        ]
> +
> +        for load_image in load_images_list:
> +            addr = load_image['addr']
> +            file = load_image['file']
> +            self.vm.add_args('-device',
> +                             f'loader,force-raw=on,addr={addr},file={file}')
> +
> +        for i in range(ca35_core):
> +            self.vm.add_args('-device',
> +                             f'loader,addr=0x430000000,cpu-num={i}')
> +
> +        load_elf_list = {
> +            'ssp': self.scratch_file(name, 'zephyr-aspeed-ssp.elf'),
> +            'tsp': self.scratch_file(name, 'zephyr-aspeed-tsp.elf')
> +        }
> +
> +        for cpu_num, key in enumerate(load_elf_list, start=4):
> +            file = load_elf_list[key]
> +            self.vm.add_args('-device',
> +                             f'loader,file={file},cpu-num={cpu_num}')
> +
> +        self.do_test_aarch64_aspeed_sdk_start(
> +                self.scratch_file(name, 'image-bmc'))
> +
> +    def test_aarch64_ast2700fc_sdk_v09_06(self):
> +        self.set_machine('ast2700fc')
> +
> +        self.archive_extract(self.ASSET_SDK_V906_AST2700)
> +        self.start_ast2700fc_test('ast2700-default')
> +        self.verify_openbmc_boot_and_login('ast2700-default')
> +        self.do_ast2700_i2c_test()
> +        self.do_ast2700fc_ssp_test()
> +        self.do_ast2700fc_tsp_test()
> +
> +if __name__ == '__main__':
> +    QemuSystemTest.main()



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C56B3F4B4
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Sep 2025 07:42:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utJmR-0008Bm-6d; Tue, 02 Sep 2025 01:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org>)
 id 1utJm8-00088K-07; Tue, 02 Sep 2025 01:41:48 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org>)
 id 1utJm3-0001UZ-JB; Tue, 02 Sep 2025 01:41:47 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4cGF3j0N4Hz4w9s;
 Tue,  2 Sep 2025 15:41:37 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4cGF3c5QClz4w9x;
 Tue,  2 Sep 2025 15:41:32 +1000 (AEST)
Message-ID: <824761eb-2994-4065-bc11-1dfa326839f0@kaod.org>
Date: Tue, 2 Sep 2025 07:41:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v5 09/10] tests/function/aspeed: Add OTP functional
 test
To: Kane Chen <kane_chen@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Cc: troy_lee@aspeedtech.com
References: <20250812094011.2617526-1-kane_chen@aspeedtech.com>
 <20250812094011.2617526-10-kane_chen@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250812094011.2617526-10-kane_chen@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Sj0j=3N=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello Kane,

+ Thomas

On 8/12/25 11:40, Kane Chen wrote:
> From: Kane-Chen-AS <kane_chen@aspeedtech.com>
> 
> On boot, the SoC firmware reads data from the OTP region to obtain the
> chip ID and default settings. This change adds test cases to verify
> that the firmware can boot correctly with a pre-configured OTP image.
> 
> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
> ---
>   tests/functional/meson.build            |  2 +
>   tests/functional/test_arm_aspeed_otp.py | 55 +++++++++++++++++++++++++
>   2 files changed, 57 insertions(+)
>   create mode 100644 tests/functional/test_arm_aspeed_otp.py
> 
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 311c6f1806..c731b779dd 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -34,6 +34,7 @@ test_timeouts = {
>     'arm_aspeed_bletchley' : 480,
>     'arm_aspeed_catalina' : 480,
>     'arm_aspeed_gb200nvl_bmc' : 480,
> +  'arm_aspeed_otp': 1200,
>     'arm_aspeed_rainier' : 480,
>     'arm_bpim2u' : 500,
>     'arm_collie' : 180,
> @@ -132,6 +133,7 @@ tests_arm_system_thorough = [
>     'arm_aspeed_bletchley',
>     'arm_aspeed_catalina',
>     'arm_aspeed_gb200nvl_bmc',
> +  'arm_aspeed_otp',
>     'arm_aspeed_rainier',
>     'arm_bpim2u',
>     'arm_canona1100',
> diff --git a/tests/functional/test_arm_aspeed_otp.py b/tests/functional/test_arm_aspeed_otp.py

The tests/functional directory was recently reorganized.

Also, I think I would prefer the new otp test to be part of the
existing test files :

   tests/functional/arm/test_aspeed_ast1030.py
   tests/functional/arm/test_aspeed_ast2600.py

Something to discuss since test_aspeed_ast2600.py is rather big.


> new file mode 100644
> index 0000000000..48c7cad3f3
> --- /dev/null
> +++ b/tests/functional/test_arm_aspeed_otp.py
> @@ -0,0 +1,55 @@
> +import os
> +import time
> +import tempfile
> +import subprocess
> +
> +from qemu_test import LinuxKernelTest, Asset> +from aspeed import AspeedTest
> +from qemu_test import exec_command_and_wait_for_pattern, skipIfMissingCommands
> +

Please add an extra blank line

> +class AspeedOtpMemoryTest(AspeedTest):
> +    # AST2600 SDK image
> +    ASSET_SDK_V907_AST2600 = Asset(
> +        'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.07/ast2600-default-obmc.tar.gz',
> +        'cb6c08595bcbba1672ce716b068ba4e48eda1ed9abe78a07b30392ba2278feba')

Please update first all functional tests with the new SDK v9.07 images.

> +
> +    # AST1030 Zephyr image
> +    ASSET_ZEPHYR_3_02 = Asset(
> +        'https://github.com/AspeedTech-BMC/zephyr/releases/download/v00.03.02/ast1030-evb-demo.zip',
> +        '1ec83caab3ddd5d09481772801be7210e222cb015ce22ec6fffb8a76956dcd4f')

Same for Zephyr images

> +
> +    def generate_otpmem_image(self):
> +        path = self.scratch_file("otpmem.img")
> +        pattern = b'\x00\x00\x00\x00\xff\xff\xff\xff' * (16 * 1024 // 8)
> +        with open(path, "wb") as f:
> +            f.write(pattern)
> +        return path
> +
> +    def test_ast2600_otp_blockdev_device(self):
> +        image_path = self.archive_extract(self.ASSET_SDK_V907_AST2600)
> +        otp_img = self.generate_otpmem_image()
> +        self.vm.set_machine("ast2600-evb")

Please move self.vm.set_machine() at the top of the routine.


Thanks,

C.



> +        self.vm.set_console()
> +        self.vm.add_args(
> +            "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
> +            "-global", "aspeed-otp.drive=otp",
> +        )
> +        self.do_test_arm_aspeed_sdk_start(self.scratch_file("ast2600-default", "image-bmc"))
> +        self.wait_for_console_pattern("ast2600-default login:")
> +
> +    def test_ast1030_otp_blockdev_device(self):
> +        kernel_name = "ast1030-evb-demo-3/zephyr.elf"
> +        kernel_file = self.archive_extract(self.ASSET_ZEPHYR_3_02, member=kernel_name)
> +        otp_img = self.generate_otpmem_image()
> +        self.vm.set_machine("ast1030-evb")
> +        self.vm.set_console()
> +        self.vm.add_args(
> +            "-kernel", kernel_file,
> +            "-blockdev", f"driver=file,filename={otp_img},node-name=otp",
> +            "-global", "aspeed-otp.drive=otp",
> +        )
> +        self.vm.launch()
> +        self.wait_for_console_pattern("Booting Zephyr OS")
> +
> +if __name__ == '__main__':
> +    AspeedTest.main()



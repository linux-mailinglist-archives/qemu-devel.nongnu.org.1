Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B96A9866A
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Apr 2025 11:50:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Wjb-0001bm-2z; Wed, 23 Apr 2025 05:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=wlG+=XJ=kaod.org=clg@ozlabs.org>)
 id 1u7WjL-0001aD-Py; Wed, 23 Apr 2025 05:49:24 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=wlG+=XJ=kaod.org=clg@ozlabs.org>)
 id 1u7WjI-0000jA-8a; Wed, 23 Apr 2025 05:49:23 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4ZjDpM0rNYz4xN6;
 Wed, 23 Apr 2025 19:49:15 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4ZjDpH4Yrvz4xFt;
 Wed, 23 Apr 2025 19:49:11 +1000 (AEST)
Message-ID: <15ab5c1d-5e2a-48d6-884c-22d6dd8e004d@kaod.org>
Date: Wed, 23 Apr 2025 11:49:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] docs/system/arm/aspeed: Support vbootrom for
 AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: troy_lee@aspeedtech.com, nabihestefan@google.com
References: <20250423072350.541742-1-jamin_lin@aspeedtech.com>
 <20250423072350.541742-12-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250423072350.541742-12-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=wlG+=XJ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 4/23/25 09:23, Jamin Lin wrote:
> Using the vbootrom image support and the boot ROM binary is
> now passed via the -bios option, using the image located in
> pc-bios/ast27x0_bootrom.bin.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Nabih Estefan <nabihestefan@google.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Some comments below,


> ---
>   docs/system/arm/aspeed.rst | 96 +++++++++++++++++++++++++++++++++++---
>   1 file changed, 90 insertions(+), 6 deletions(-)
> 
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index 97fd6a0e7f..e15e276a48 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -1,4 +1,4 @@
> -Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
> +Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``bletchley-bmc``, ``fuji-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)
>   ==================================================================================================================================================================================================================================================================================================================================================================================================================
>   
>   The QEMU Aspeed machines model BMCs of various OpenPOWER systems and
> @@ -39,10 +39,6 @@ AST2600 SoC based machines :
>   - ``qcom-dc-scm-v1-bmc``   Qualcomm DC-SCM V1 BMC
>   - ``qcom-firework-bmc``    Qualcomm Firework BMC
>   
> -AST2700 SoC based machines :
> -
> -- ``ast2700-evb``          Aspeed AST2700 Evaluation board (Cortex-A35)
> -

This will conflict with Steven's series adding the ast2700fc machine.
To ease upstreaming of both, it might be good idea to separate the
change adding the "Aspeed 2700 family boards" section from the change
adding the "Boot using a virtual boot ROM" subsection.


Thanks,

C.



>   Supported devices
>   -----------------
>   
> @@ -247,10 +243,78 @@ under Linux), use :
>   
>     -M ast2500-evb,bmc-console=uart3
>   
> +Aspeed 2700 family boards (``ast2700-evb``)
> +==================================================================
> +
> +The QEMU Aspeed machines model BMCs of Aspeed evaluation boards.
> +They are based on different releases of the Aspeed SoC :
> +the AST2700 with quad cores ARM Cortex-A35 64 bits CPUs (1.6GHz)
> +
> +The SoC comes with RAM, Gigabit ethernet, USB, SD/MMC, USB, SPI, I2C,
> +etc.
> +
> +AST2700 SoC based machines :
> +
> +- ``ast2700-evb``          Aspeed AST2700 Evaluation board (Cortex-A35)
> +
> +Supported devices
> +-----------------
> + * Interrupt Controller
> + * Timer Controller
> + * RTC Controller
> + * I2C Controller
> + * System Control Unit (SCU)
> + * SRAM mapping
> + * X-DMA Controller (basic interface)
> + * Static Memory Controller (SMC or FMC) - Only SPI Flash support
> + * SPI Memory Controller
> + * USB 2.0 Controller
> + * SD/MMC storage controllers
> + * SDRAM controller (dummy interface for basic settings and training)
> + * Watchdog Controller
> + * GPIO Controller (Master only)
> + * UART
> + * Ethernet controllers
> + * Front LEDs (PCA9552 on I2C bus)
> + * LPC Peripheral Controller (a subset of subdevices are supported)
> + * Hash/Crypto Engine (HACE) - Hash support only. TODO: Crypto
> + * ADC
> + * eMMC Boot Controller (dummy)
> + * PECI Controller (minimal)
> + * I3C Controller
> + * Internal Bridge Controller (SLI dummy)
> +
> +Missing devices
> +---------------
> + * Coprocessor support
> + * PWM and Fan Controller
> + * Slave GPIO Controller
> + * Super I/O Controller
> + * PCI-Express 1 Controller
> + * Graphic Display Controller
> + * MCTP Controller
> + * Mailbox Controller
> + * Virtual UART
> + * eSPI Controller
> +
> +Boot options
> +------------
> +
> +Images can be downloaded from the ASPEED Forked OpenBMC GitHub release repository :
> +
> +   https://github.com/AspeedTech-BMC/openbmc/releases
> +
>   Booting the ast2700-evb machine
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   
> -Boot the AST2700 machine from the flash image, use an MTD drive :
> +Boot the AST2700 machine from the flash image.
> +
> +There are two supported methods for booting the AST2700 machine with a flash image:
> +
> +Manual boot using ``-device loader``:
> +
> +It causes all 4 CPU cores to start execution from address ``0x430000000``, which
> +corresponds to the BL31 image load address.
>   
>   .. code-block:: bash
>   
> @@ -270,6 +334,26 @@ Boot the AST2700 machine from the flash image, use an MTD drive :
>          -drive file=${IMGDIR}/image-bmc,format=raw,if=mtd \
>          -nographic
>   
> +Boot using a virtual boot ROM (``-bios``):
> +
> +If users do not specify the ``-bios option``, QEMU will attempt to load the
> +default vbootrom image ``ast27x0_bootrom.bin`` from either the current working
> +directory or the ``pc-bios`` directory within the QEMU source tree.
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-aarch64 -M ast2700-evb \
> +      -drive file=image-bmc,format=raw,if=mtd \
> +      -nographic
> +
> +The ``-bios`` option allows users to specify a custom path for the vbootrom
> +image to be loaded during boot. This will load the vbootrom image from the
> +specified path in the ${HOME} directory.
> +
> +.. code-block:: bash
> +
> +  -bios ${HOME}/ast27x0_bootrom.bin
> +
>   Aspeed minibmc family boards (``ast1030-evb``)
>   ==================================================================
>   



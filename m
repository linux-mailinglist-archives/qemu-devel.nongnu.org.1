Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DED87428D1
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 16:48:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEsvM-0006vF-PD; Thu, 29 Jun 2023 10:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org>)
 id 1qEsvK-0006uV-73; Thu, 29 Jun 2023 10:47:06 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org>)
 id 1qEsvH-00036i-1C; Thu, 29 Jun 2023 10:47:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QsLrH6vjHz4wp1;
 Fri, 30 Jun 2023 00:46:55 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QsLrF5Wl6z4wZy;
 Fri, 30 Jun 2023 00:46:53 +1000 (AEST)
Message-ID: <c446b3ee-9a77-7a22-842a-c8c5292a65fa@kaod.org>
Date: Thu, 29 Jun 2023 16:46:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 06/12] aspeed/smc: Wire CS lines at reset
Content-Language: en-US
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-7-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230607043943.1837186-7-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=1kQ5=CR=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/7/23 06:39, Cédric Le Goater wrote:
> Currently, a set of default flash devices is created at machine init
> and drives defined on the QEMU command line are associated to the FMC
> and SPI controllers in sequence :
> 
>     -drive file<file>,format=raw,if=mtd
>     -drive file<file1>,format=raw,if=mtd
> 
> The CS lines are wired in the same creation loop. This makes a strong
> assumption on the ordering and is not very flexible since only a
> limited set of flash devices can be defined : 1 FMC + 1 or 2 SPI,
> which is less than what the SoC really supports.
> 
> A better alternative would be to define the flash devices on the
> command line using a blockdev attached to a CS line of a SSI bus :
> 
>      -blockdev node-name=fmc0,driver=file,filename=./flash.img
>      -device mx66u51235f,addr=0x0,bus=ssi.0,drive=fmc0
> 
> However, user created flash devices are not correctly wired to their
> SPI controller and consequently can not be used by the machine. Fix
> that and wire the CS lines of all available devices when the SSI bus
> is reset.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   hw/arm/aspeed.c     | 5 +----
>   hw/ssi/aspeed_smc.c | 8 ++++++++
>   2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 76a1e7303de1..e5a49bb0b1a7 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -299,17 +299,14 @@ void aspeed_board_init_flashes(AspeedSMCState *s, const char *flashtype,
>   
>       for (i = 0; i < count; ++i) {
>           DriveInfo *dinfo = drive_get(IF_MTD, 0, unit0 + i);
> -        qemu_irq cs_line;
>           DeviceState *dev;
>   
>           dev = qdev_new(flashtype);
>           if (dinfo) {
>               qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo));
>           }
> +        qdev_prop_set_uint8(dev, "addr", i);
>           qdev_realize_and_unref(dev, BUS(s->spi), &error_fatal);
> -
> -        cs_line = qdev_get_gpio_in_named(dev, SSI_GPIO_CS, 0);
> -        qdev_connect_gpio_out_named(DEVICE(s), "cs", i, cs_line);
>       }
>   }
>   
> diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
> index 72811693224d..2a4001b774a2 100644
> --- a/hw/ssi/aspeed_smc.c
> +++ b/hw/ssi/aspeed_smc.c
> @@ -692,6 +692,14 @@ static void aspeed_smc_reset(DeviceState *d)
>           memset(s->regs, 0, sizeof s->regs);
>       }
>   
> +    for (i = 0; i < asc->cs_num_max; i++) {
> +        DeviceState *dev = ssi_get_cs(s->spi, i);
> +        if (dev) {
> +            qemu_irq cs_line = qdev_get_gpio_in_named(dev, SSI_GPIO_CS, 0);
> +            qdev_connect_gpio_out_named(DEVICE(s), "cs", i, cs_line);
> +        }
> +    }
> +
>       /* Unselect all peripherals */
>       for (i = 0; i < asc->cs_num_max; ++i) {
>           s->regs[s->r_ctrl0 + i] |= CTRL_CE_STOP_ACTIVE;


An alternative for the wiring would be to connect the GPIO lines in the
m25p80 realize routine. See below for a draft. Assumption is made on the
availability of the CS lines at the bus parent level, which should be
the controller.
  
Thanks,

C.


diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index aa0bfa57bb26..ae39a1a24b1b 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -154,6 +154,18 @@ SSIBus *ssi_create_bus(DeviceState *parent, const char *name)
      return SSI_BUS(bus);
  }
  
+void ssi_attach(SSIPeripheral *s)
+{
+    BusState *bus = BUS(qdev_get_parent_bus(DEVICE(s)));
+    qemu_irq cs_line = qdev_get_gpio_in_named(DEVICE(s), SSI_GPIO_CS, 0);
+
+    /*
+     * TODO: Will abort if "cs" GPIOs are not defined at the
+     * controller level
+     */
+    qdev_connect_gpio_out_named(DEVICE(bus->parent), "cs", s->addr, cs_line);
+}
+
  uint32_t ssi_transfer(SSIBus *bus, uint32_t val)
  {
      BusState *b = BUS(bus);


diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index afc3fdf4d60b..89add100aefd 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -1628,6 +1628,8 @@ static void m25p80_realize(SSIPeripheral *ss, Error **errp)
  
      qdev_init_gpio_in_named(DEVICE(s),
                              m25p80_write_protect_pin_irq_handler, "WP#", 1);
+
+    ssi_attach(ss);
  }
  
  static void m25p80_reset(DeviceState *d)



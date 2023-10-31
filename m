Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 476947DC82B
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 09:32:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxkAI-00008u-Ed; Tue, 31 Oct 2023 04:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=0CP7=GN=kaod.org=clg@ozlabs.org>)
 id 1qxkAF-000084-Ps; Tue, 31 Oct 2023 04:31:55 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=0CP7=GN=kaod.org=clg@ozlabs.org>)
 id 1qxkAB-0001CP-Ud; Tue, 31 Oct 2023 04:31:55 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SKNf63N2jz4xS7;
 Tue, 31 Oct 2023 19:31:42 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SKNdy2S5Fz4xQf;
 Tue, 31 Oct 2023 19:31:33 +1100 (AEDT)
Message-ID: <b06b0685-9407-4350-a8e6-edd0a9411c4e@kaod.org>
Date: Tue, 31 Oct 2023 09:31:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] hw/sd: Declare CPU QOM types using DEFINE_TYPES()
 macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Bin Meng
 <bin.meng@windriver.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-block@nongnu.org
References: <20231031080603.86889-1-philmd@linaro.org>
 <20231031080603.86889-2-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231031080603.86889-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=0CP7=GN=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/31/23 09:06, Philippe Mathieu-Daudé wrote:
> When multiple QOM types are registered in the same file,
> it is simpler to use the the DEFINE_TYPES() macro. In
> particular because type array declared with such macro
> are easier to review.
> 
> Mechanical transformation using the following comby script:
> 
>    [pattern-x1]
>    match='''
>    static const TypeInfo :[i1~.*_info] = {
>        :[body]
>    };
>    static void :[rt1~.*_register_type.](void)
>    {
>        type_register_static(&:[i2~.*_info]);
>    }
>    type_init(:[rt2~.*_register_type.])
>    '''
>    rewrite='''
>    static const TypeInfo :[i1][] = {
>        {
>        :[body]
>        },
>    };
> 
>    DEFINE_TYPES(:[i1])
>    '''
>    rule='where :[i1] == :[i2], :[rt1] == :[rt2]'
> 
>    [pattern-x2]
>    match='''
>    static const TypeInfo :[i1a~.*_info] = {
>        :[body1]
>    };
>    ...
>    static const TypeInfo :[i2a~.*_info] = {
>        :[body2]
>    };
>    static void :[rt1~.*_register_type.](void)
>    {
>        type_register_static(&:[i1b~.*_info]);
>        type_register_static(&:[i2b~.*_info]);
>    }
>    type_init(:[rt2~.*_register_type.])
>    '''
>    rewrite='''
>    static const TypeInfo :[i1a][] = {
>        {
>        :[body1]
>        },
>        {
>        :[body2]
>        },
>    };
> 
>    DEFINE_TYPES(:[i1a])
>    '''
>    rule='''
>    where
>    :[i1a] == :[i1b],
>    :[i2a] == :[i2b],
>    :[rt1] == :[rt2]
>    '''
> 
> and re-indented manually.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

I checked the aspeed part.

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>   hw/sd/aspeed_sdhci.c   | 19 ++++++++-----------
>   hw/sd/bcm2835_sdhost.c | 33 ++++++++++++++-------------------
>   hw/sd/cadence_sdhci.c  | 21 +++++++++------------
>   hw/sd/core.c           | 19 ++++++++-----------
>   hw/sd/npcm7xx_sdhci.c  | 21 +++++++++------------
>   hw/sd/pl181.c          | 35 +++++++++++++++--------------------
>   hw/sd/pxa2xx_mmci.c    | 35 +++++++++++++++--------------------
>   hw/sd/sd.c             | 37 ++++++++++++++++---------------------
>   hw/sd/sdhci-pci.c      | 25 +++++++++++--------------
>   hw/sd/ssi-sd.c         | 19 ++++++++-----------
>   10 files changed, 113 insertions(+), 151 deletions(-)
> 
> diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
> index be8cafd65f..e53206d959 100644
> --- a/hw/sd/aspeed_sdhci.c
> +++ b/hw/sd/aspeed_sdhci.c
> @@ -198,16 +198,13 @@ static void aspeed_sdhci_class_init(ObjectClass *classp, void *data)
>       device_class_set_props(dc, aspeed_sdhci_properties);
>   }
>   
> -static const TypeInfo aspeed_sdhci_info = {
> -    .name          = TYPE_ASPEED_SDHCI,
> -    .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(AspeedSDHCIState),
> -    .class_init    = aspeed_sdhci_class_init,
> +static const TypeInfo aspeed_sdhci_types[] = {
> +    {
> +        .name           = TYPE_ASPEED_SDHCI,
> +        .parent         = TYPE_SYS_BUS_DEVICE,
> +        .instance_size  = sizeof(AspeedSDHCIState),
> +        .class_init     = aspeed_sdhci_class_init,
> +    },
>   };
>   
> -static void aspeed_sdhci_register_types(void)
> -{
> -    type_register_static(&aspeed_sdhci_info);
> -}
> -
> -type_init(aspeed_sdhci_register_types)
> +DEFINE_TYPES(aspeed_sdhci_types)
> diff --git a/hw/sd/bcm2835_sdhost.c b/hw/sd/bcm2835_sdhost.c
> index 9431c35914..a600cf39e2 100644
> --- a/hw/sd/bcm2835_sdhost.c
> +++ b/hw/sd/bcm2835_sdhost.c
> @@ -436,24 +436,19 @@ static void bcm2835_sdhost_class_init(ObjectClass *klass, void *data)
>       dc->vmsd = &vmstate_bcm2835_sdhost;
>   }
>   
> -static const TypeInfo bcm2835_sdhost_info = {
> -    .name          = TYPE_BCM2835_SDHOST,
> -    .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(BCM2835SDHostState),
> -    .class_init    = bcm2835_sdhost_class_init,
> -    .instance_init = bcm2835_sdhost_init,
> +static const TypeInfo bcm2835_sdhost_types[] = {
> +    {
> +        .name           = TYPE_BCM2835_SDHOST,
> +        .parent         = TYPE_SYS_BUS_DEVICE,
> +        .instance_size  = sizeof(BCM2835SDHostState),
> +        .class_init     = bcm2835_sdhost_class_init,
> +        .instance_init  = bcm2835_sdhost_init,
> +    },
> +    {
> +        .name           = TYPE_BCM2835_SDHOST_BUS,
> +        .parent         = TYPE_SD_BUS,
> +        .instance_size  = sizeof(SDBus),
> +    },
>   };
>   
> -static const TypeInfo bcm2835_sdhost_bus_info = {
> -    .name = TYPE_BCM2835_SDHOST_BUS,
> -    .parent = TYPE_SD_BUS,
> -    .instance_size = sizeof(SDBus),
> -};
> -
> -static void bcm2835_sdhost_register_types(void)
> -{
> -    type_register_static(&bcm2835_sdhost_info);
> -    type_register_static(&bcm2835_sdhost_bus_info);
> -}
> -
> -type_init(bcm2835_sdhost_register_types)
> +DEFINE_TYPES(bcm2835_sdhost_types)
> diff --git a/hw/sd/cadence_sdhci.c b/hw/sd/cadence_sdhci.c
> index 75db34befe..ef4e0d74e3 100644
> --- a/hw/sd/cadence_sdhci.c
> +++ b/hw/sd/cadence_sdhci.c
> @@ -175,17 +175,14 @@ static void cadence_sdhci_class_init(ObjectClass *classp, void *data)
>       dc->vmsd = &vmstate_cadence_sdhci;
>   }
>   
> -static const TypeInfo cadence_sdhci_info = {
> -    .name          = TYPE_CADENCE_SDHCI,
> -    .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(CadenceSDHCIState),
> -    .instance_init = cadence_sdhci_instance_init,
> -    .class_init    = cadence_sdhci_class_init,
> +static const TypeInfo cadence_sdhci_types[] = {
> +    {
> +        .name           = TYPE_CADENCE_SDHCI,
> +        .parent         = TYPE_SYS_BUS_DEVICE,
> +        .instance_size  = sizeof(CadenceSDHCIState),
> +        .instance_init  = cadence_sdhci_instance_init,
> +        .class_init     = cadence_sdhci_class_init,
> +    },
>   };
>   
> -static void cadence_sdhci_register_types(void)
> -{
> -    type_register_static(&cadence_sdhci_info);
> -}
> -
> -type_init(cadence_sdhci_register_types)
> +DEFINE_TYPES(cadence_sdhci_types)
> diff --git a/hw/sd/core.c b/hw/sd/core.c
> index 30ee62c510..52d5d90045 100644
> --- a/hw/sd/core.c
> +++ b/hw/sd/core.c
> @@ -259,16 +259,13 @@ void sdbus_reparent_card(SDBus *from, SDBus *to)
>       sdbus_set_readonly(to, readonly);
>   }
>   
> -static const TypeInfo sd_bus_info = {
> -    .name = TYPE_SD_BUS,
> -    .parent = TYPE_BUS,
> -    .instance_size = sizeof(SDBus),
> -    .class_size = sizeof(SDBusClass),
> +static const TypeInfo sd_bus_types[] = {
> +    {
> +        .name           = TYPE_SD_BUS,
> +        .parent         = TYPE_BUS,
> +        .instance_size  = sizeof(SDBus),
> +        .class_size     = sizeof(SDBusClass),
> +    },
>   };
>   
> -static void sd_bus_register_types(void)
> -{
> -    type_register_static(&sd_bus_info);
> -}
> -
> -type_init(sd_bus_register_types)
> +DEFINE_TYPES(sd_bus_types)
> diff --git a/hw/sd/npcm7xx_sdhci.c b/hw/sd/npcm7xx_sdhci.c
> index b2f5b4a542..9958680090 100644
> --- a/hw/sd/npcm7xx_sdhci.c
> +++ b/hw/sd/npcm7xx_sdhci.c
> @@ -166,17 +166,14 @@ static void npcm7xx_sdhci_instance_init(Object *obj)
>                               TYPE_SYSBUS_SDHCI);
>   }
>   
> -static const TypeInfo npcm7xx_sdhci_info = {
> -    .name = TYPE_NPCM7XX_SDHCI,
> -    .parent = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(NPCM7xxSDHCIState),
> -    .instance_init = npcm7xx_sdhci_instance_init,
> -    .class_init = npcm7xx_sdhci_class_init,
> +static const TypeInfo npcm7xx_sdhci_types[] = {
> +    {
> +        .name           = TYPE_NPCM7XX_SDHCI,
> +        .parent         = TYPE_SYS_BUS_DEVICE,
> +        .instance_size  = sizeof(NPCM7xxSDHCIState),
> +        .instance_init  = npcm7xx_sdhci_instance_init,
> +        .class_init     = npcm7xx_sdhci_class_init,
> +    },
>   };
>   
> -static void npcm7xx_sdhci_register_types(void)
> -{
> -    type_register_static(&npcm7xx_sdhci_info);
> -}
> -
> -type_init(npcm7xx_sdhci_register_types)
> +DEFINE_TYPES(npcm7xx_sdhci_types)
> diff --git a/hw/sd/pl181.c b/hw/sd/pl181.c
> index 5e554bd467..2b33814d83 100644
> --- a/hw/sd/pl181.c
> +++ b/hw/sd/pl181.c
> @@ -519,14 +519,6 @@ static void pl181_class_init(ObjectClass *klass, void *data)
>       k->user_creatable = false;
>   }
>   
> -static const TypeInfo pl181_info = {
> -    .name          = TYPE_PL181,
> -    .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(PL181State),
> -    .instance_init = pl181_init,
> -    .class_init    = pl181_class_init,
> -};
> -
>   static void pl181_bus_class_init(ObjectClass *klass, void *data)
>   {
>       SDBusClass *sbc = SD_BUS_CLASS(klass);
> @@ -535,17 +527,20 @@ static void pl181_bus_class_init(ObjectClass *klass, void *data)
>       sbc->set_readonly = pl181_set_readonly;
>   }
>   
> -static const TypeInfo pl181_bus_info = {
> -    .name = TYPE_PL181_BUS,
> -    .parent = TYPE_SD_BUS,
> -    .instance_size = sizeof(SDBus),
> -    .class_init = pl181_bus_class_init,
> +static const TypeInfo pl181_info[] = {
> +    {
> +        .name           = TYPE_PL181,
> +        .parent         = TYPE_SYS_BUS_DEVICE,
> +        .instance_size  = sizeof(PL181State),
> +        .instance_init  = pl181_init,
> +        .class_init     = pl181_class_init,
> +    },
> +    {
> +        .name           = TYPE_PL181_BUS,
> +        .parent         = TYPE_SD_BUS,
> +        .instance_size  = sizeof(SDBus),
> +        .class_init     = pl181_bus_class_init,
> +    },
>   };
>   
> -static void pl181_register_types(void)
> -{
> -    type_register_static(&pl181_info);
> -    type_register_static(&pl181_bus_info);
> -}
> -
> -type_init(pl181_register_types)
> +DEFINE_TYPES(pl181_info)
> diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
> index 124fbf8bbd..d785a3d80f 100644
> --- a/hw/sd/pxa2xx_mmci.c
> +++ b/hw/sd/pxa2xx_mmci.c
> @@ -580,25 +580,20 @@ static void pxa2xx_mmci_bus_class_init(ObjectClass *klass, void *data)
>       sbc->set_readonly = pxa2xx_mmci_set_readonly;
>   }
>   
> -static const TypeInfo pxa2xx_mmci_info = {
> -    .name = TYPE_PXA2XX_MMCI,
> -    .parent = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(PXA2xxMMCIState),
> -    .instance_init = pxa2xx_mmci_instance_init,
> -    .class_init = pxa2xx_mmci_class_init,
> +static const TypeInfo pxa2xx_mmci_types[] = {
> +    {
> +        .name           = TYPE_PXA2XX_MMCI,
> +        .parent         = TYPE_SYS_BUS_DEVICE,
> +        .instance_size  = sizeof(PXA2xxMMCIState),
> +        .instance_init  = pxa2xx_mmci_instance_init,
> +        .class_init     = pxa2xx_mmci_class_init,
> +    },
> +    {
> +        .name           = TYPE_PXA2XX_MMCI_BUS,
> +        .parent         = TYPE_SD_BUS,
> +        .instance_size  = sizeof(SDBus),
> +        .class_init     = pxa2xx_mmci_bus_class_init,
> +    },
>   };
>   
> -static const TypeInfo pxa2xx_mmci_bus_info = {
> -    .name = TYPE_PXA2XX_MMCI_BUS,
> -    .parent = TYPE_SD_BUS,
> -    .instance_size = sizeof(SDBus),
> -    .class_init = pxa2xx_mmci_bus_class_init,
> -};
> -
> -static void pxa2xx_mmci_register_types(void)
> -{
> -    type_register_static(&pxa2xx_mmci_info);
> -    type_register_static(&pxa2xx_mmci_bus_info);
> -}
> -
> -type_init(pxa2xx_mmci_register_types)
> +DEFINE_TYPES(pxa2xx_mmci_types)
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 4823befdef..1106ff7d78 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -2278,16 +2278,6 @@ static void sd_class_init(ObjectClass *klass, void *data)
>       sc->proto = &sd_proto_sd;
>   }
>   
> -static const TypeInfo sd_info = {
> -    .name = TYPE_SD_CARD,
> -    .parent = TYPE_DEVICE,
> -    .instance_size = sizeof(SDState),
> -    .class_size = sizeof(SDCardClass),
> -    .class_init = sd_class_init,
> -    .instance_init = sd_instance_init,
> -    .instance_finalize = sd_instance_finalize,
> -};
> -
>   /*
>    * We do not model the chip select pin, so allow the board to select
>    * whether card should be in SSI or MMC/SD mode.  It is also up to the
> @@ -2303,16 +2293,21 @@ static void sd_spi_class_init(ObjectClass *klass, void *data)
>       sc->proto = &sd_proto_spi;
>   }
>   
> -static const TypeInfo sd_spi_info = {
> -    .name = TYPE_SD_CARD_SPI,
> -    .parent = TYPE_SD_CARD,
> -    .class_init = sd_spi_class_init,
> +static const TypeInfo sd_types[] = {
> +    {
> +        .name           = TYPE_SD_CARD,
> +        .parent         = TYPE_DEVICE,
> +        .instance_size  = sizeof(SDState),
> +        .class_size     = sizeof(SDCardClass),
> +        .class_init     = sd_class_init,
> +        .instance_init  = sd_instance_init,
> +        .instance_finalize = sd_instance_finalize,
> +    },
> +    {
> +        .name           = TYPE_SD_CARD_SPI,
> +        .parent         = TYPE_SD_CARD,
> +        .class_init     = sd_spi_class_init,
> +    },
>   };
>   
> -static void sd_register_types(void)
> -{
> -    type_register_static(&sd_info);
> -    type_register_static(&sd_spi_info);
> -}
> -
> -type_init(sd_register_types)
> +DEFINE_TYPES(sd_types)
> diff --git a/hw/sd/sdhci-pci.c b/hw/sd/sdhci-pci.c
> index c737c8b930..9b7bee8b3f 100644
> --- a/hw/sd/sdhci-pci.c
> +++ b/hw/sd/sdhci-pci.c
> @@ -68,20 +68,17 @@ static void sdhci_pci_class_init(ObjectClass *klass, void *data)
>       sdhci_common_class_init(klass, data);
>   }
>   
> -static const TypeInfo sdhci_pci_info = {
> -    .name = TYPE_PCI_SDHCI,
> -    .parent = TYPE_PCI_DEVICE,
> -    .instance_size = sizeof(SDHCIState),
> -    .class_init = sdhci_pci_class_init,
> -    .interfaces = (InterfaceInfo[]) {
> -        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> -        { },
> +static const TypeInfo sdhci_pci_types[] = {
> +    {
> +        .name           = TYPE_PCI_SDHCI,
> +        .parent         = TYPE_PCI_DEVICE,
> +        .instance_size  = sizeof(SDHCIState),
> +        .class_init     = sdhci_pci_class_init,
> +        .interfaces     = (InterfaceInfo[]) {
> +            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
> +            { },
> +        },
>       },
>   };
>   
> -static void sdhci_pci_register_type(void)
> -{
> -    type_register_static(&sdhci_pci_info);
> -}
> -
> -type_init(sdhci_pci_register_type)
> +DEFINE_TYPES(sdhci_pci_types)
> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
> index 167c03b780..a6cc1ad6c8 100644
> --- a/hw/sd/ssi-sd.c
> +++ b/hw/sd/ssi-sd.c
> @@ -403,16 +403,13 @@ static void ssi_sd_class_init(ObjectClass *klass, void *data)
>       dc->user_creatable = false;
>   }
>   
> -static const TypeInfo ssi_sd_info = {
> -    .name          = TYPE_SSI_SD,
> -    .parent        = TYPE_SSI_PERIPHERAL,
> -    .instance_size = sizeof(ssi_sd_state),
> -    .class_init    = ssi_sd_class_init,
> +static const TypeInfo ssi_sd_types[] = {
> +    {
> +        .name           = TYPE_SSI_SD,
> +        .parent         = TYPE_SSI_PERIPHERAL,
> +        .instance_size  = sizeof(ssi_sd_state),
> +        .class_init     = ssi_sd_class_init,
> +    },
>   };
>   
> -static void ssi_sd_register_types(void)
> -{
> -    type_register_static(&ssi_sd_info);
> -}
> -
> -type_init(ssi_sd_register_types)
> +DEFINE_TYPES(ssi_sd_types)



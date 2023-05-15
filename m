Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F5B703E04
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 21:59:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyeMA-0004ET-Tg; Mon, 15 May 2023 15:59:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1pyeLU-0003tX-Gu; Mon, 15 May 2023 15:59:02 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nieklinnenbank@gmail.com>)
 id 1pyeLR-0005gO-SA; Mon, 15 May 2023 15:59:00 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-b9e27684b53so11820805276.0; 
 Mon, 15 May 2023 12:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684180736; x=1686772736;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yeGedGxTXKQGoJ5NtayjQQSI1e5eybzJylh11Xp/p2c=;
 b=nSJI30s6sI7eH/dKtEwytbPbHkTTz5uKgBetR9Md8gHmsAwJ/OC6mWtOzwLFQiv5Kt
 1TLBepH3pnvFt2UxY2MXj0h/dcn7uejPuQILSAICWJoNfnx0pk9MyJDxmnC5MxMY6vaY
 KjAl1kXrWo0CGHX9x10pqZV1QVafGAyD5G39hX7K89QvoSbPVn3/06eICy4xDc4zXIJ2
 Gt0Zz0doG3pzPjt1vBDHExcWoZWIbMP6Gc8uwoNll7IsIgpwFJyX7UzMfrydQyrm9kzr
 0UuoofGJes77rIcPf7JK2oeVKK9076AUxlUa+i4PFKxRE+wo9WZT17EFPIquI55z5SD0
 WJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684180736; x=1686772736;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yeGedGxTXKQGoJ5NtayjQQSI1e5eybzJylh11Xp/p2c=;
 b=af+dHBmzMlJh+sLNQtRfoRUiGfRdeMA+HjVZlxvQU9FZ4QzK84yBNgunmUMTe5chNu
 bnUe5AK7rNHOG2W7nQwcUE9H+AsO34EeTUhK5o8V24CJ/EOYvWmLI6NWUEW8YBObjQgF
 aBmgD7gu+5KRQrsYpwQvhRKIjd2HbJvRpBQW5Kr9dgHjBYgLFIyw5lo4Ehqt8hkdzQT5
 PnFeElPJzwEJrOCeftEZ8KJWci5RTtLQsVLkO+xe0Sg/qr+WRXdckwNNLNiEFUn+lbiJ
 fk3dfxDTiZ/CWMf//xSH3uR8BkJjqbBtRHmxTFAASVnUdWw/OlvQ4G1WLtItGb/EHN7W
 f4DQ==
X-Gm-Message-State: AC+VfDzSStydC4oPLN6eCF0y86uOyg3noPWvDDKsphR694xZDaR7NvRQ
 p53abMHQs3ia2yNyMkUlFuSx/cPDKtaRb9HMkMk=
X-Google-Smtp-Source: ACHHUZ4mjMW+KRMJyceyRjMrQu7ILdZlGG3Evj+PA1Zi3xRZt+mqNfjzJm+DHr2QzYkFc8LhLCKs1S3AEgYabwXLzlo=
X-Received: by 2002:a25:4c6:0:b0:ba6:1084:9a2f with SMTP id
 189-20020a2504c6000000b00ba610849a2fmr19879290ybe.16.1684180736617; Mon, 15
 May 2023 12:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230510103004.30015-1-qianfanguijin@163.com>
 <20230510103004.30015-9-qianfanguijin@163.com>
In-Reply-To: <20230510103004.30015-9-qianfanguijin@163.com>
From: Niek Linnenbank <nieklinnenbank@gmail.com>
Date: Mon, 15 May 2023 21:58:45 +0200
Message-ID: <CAPan3WrCDAvfoUnc5jhjyvheiQnASE-oLcbDqQ8OGnHPQ7xmPg@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] hw: arm: allwinner-r40: Add emac and gmac support
To: qianfanguijin@163.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Beniamino Galvani <b.galvani@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000008b335c05fbc0e2e7"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=nieklinnenbank@gmail.com; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000008b335c05fbc0e2e7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Qianfan,

On Wed, May 10, 2023 at 12:30=E2=80=AFPM <qianfanguijin@163.com> wrote:

> From: qianfan Zhao <qianfanguijin@163.com>
>
> R40 has two ethernet controllers named as emac and gmac. The emac is
> compatibled with A10, and the GMAC is compatibled with H3.
>
> Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
> ---
>  hw/arm/allwinner-r40.c         | 50 ++++++++++++++++++++++++++++++++--
>  hw/arm/bananapi_m2u.c          |  3 ++
>  include/hw/arm/allwinner-r40.h |  6 ++++
>  3 files changed, 57 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c
> index b148c56449..c018ad231a 100644
> --- a/hw/arm/allwinner-r40.c
> +++ b/hw/arm/allwinner-r40.c
> @@ -39,6 +39,7 @@ const hwaddr allwinner_r40_memmap[] =3D {
>      [AW_R40_DEV_SRAM_A2]    =3D 0x00004000,
>      [AW_R40_DEV_SRAM_A3]    =3D 0x00008000,
>      [AW_R40_DEV_SRAM_A4]    =3D 0x0000b400,
> +    [AW_R40_DEV_EMAC]       =3D 0x01c0b000,
>      [AW_R40_DEV_MMC0]       =3D 0x01c0f000,
>      [AW_R40_DEV_MMC1]       =3D 0x01c10000,
>      [AW_R40_DEV_MMC2]       =3D 0x01c11000,
> @@ -54,6 +55,7 @@ const hwaddr allwinner_r40_memmap[] =3D {
>      [AW_R40_DEV_UART6]      =3D 0x01c29800,
>      [AW_R40_DEV_UART7]      =3D 0x01c29c00,
>      [AW_R40_DEV_TWI0]       =3D 0x01c2ac00,
> +    [AW_R40_DEV_GMAC]       =3D 0x01c50000,
>      [AW_R40_DEV_DRAMCOM]    =3D 0x01c62000,
>      [AW_R40_DEV_DRAMCTL]    =3D 0x01c63000,
>      [AW_R40_DEV_DRAMPHY]    =3D 0x01c65000,
> @@ -82,7 +84,6 @@ static struct AwR40Unimplemented r40_unimplemented[] =
=3D {
>      { "spi1",       0x01c06000, 4 * KiB },
>      { "cs0",        0x01c09000, 4 * KiB },
>      { "keymem",     0x01c0a000, 4 * KiB },
> -    { "emac",       0x01c0b000, 4 * KiB },
>      { "usb0-otg",   0x01c13000, 4 * KiB },
>      { "usb0-host",  0x01c14000, 4 * KiB },
>      { "crypto",     0x01c15000, 4 * KiB },
> @@ -131,7 +132,6 @@ static struct AwR40Unimplemented r40_unimplemented[] =
=3D
> {
>      { "tvd2",       0x01c33000, 4 * KiB },
>      { "tvd3",       0x01c34000, 4 * KiB },
>      { "gpu",        0x01c40000, 64 * KiB },
> -    { "gmac",       0x01c50000, 64 * KiB },
>      { "hstmr",      0x01c60000, 4 * KiB },
>      { "tcon-top",   0x01c70000, 4 * KiB },
>      { "lcd0",       0x01c71000, 4 * KiB },
> @@ -180,6 +180,8 @@ enum {
>      AW_R40_GIC_SPI_MMC1      =3D 33,
>      AW_R40_GIC_SPI_MMC2      =3D 34,
>      AW_R40_GIC_SPI_MMC3      =3D 35,
> +    AW_R40_GIC_SPI_EMAC      =3D 55,
> +    AW_R40_GIC_SPI_GMAC      =3D 85,
>  };
>
>  /* Allwinner R40 general constants */
> @@ -276,6 +278,11 @@ static void allwinner_r40_init(Object *obj)
>
>      object_initialize_child(obj, "twi0", &s->i2c0, TYPE_AW_I2C_SUN6I);
>
> +    object_initialize_child(obj, "emac", &s->emac, TYPE_AW_EMAC);
> +    object_initialize_child(obj, "gmac", &s->gmac, TYPE_AW_SUN8I_EMAC);
> +    object_property_add_alias(obj, "gmac-phy-addr",
> +                              OBJECT(&s->gmac), "phy-addr");
> +
>      object_initialize_child(obj, "dramc", &s->dramc, TYPE_AW_R40_DRAMC);
>      object_property_add_alias(obj, "ram-addr", OBJECT(&s->dramc),
>                               "ram-addr");
> @@ -285,6 +292,7 @@ static void allwinner_r40_init(Object *obj)
>
>  static void allwinner_r40_realize(DeviceState *dev, Error **errp)
>  {
> +    const char *r40_nic_models[] =3D { "gmac", "emac", NULL };
>      AwR40State *s =3D AW_R40(dev);
>      unsigned i;
>
> @@ -442,6 +450,44 @@ static void allwinner_r40_realize(DeviceState *dev,
> Error **errp)
>      sysbus_mmio_map(SYS_BUS_DEVICE(&s->dramc), 2,
>                      s->memmap[AW_R40_DEV_DRAMPHY]);
>
> +    /* nic support gmac and emac */
> +    for (int i =3D 0; i < ARRAY_SIZE(r40_nic_models) - 1; i++) {
> +        NICInfo *nic =3D &nd_table[i];
> +
> +        if (!nic->used) {
> +            continue;
> +        }
>

Could you please clarify the lines below here? I'm not seeing the function
call 'qemu_show_nic_models()' in any of the other machines / soc
implementations.

Also, if you intend to catch a possible input error here, probably its best
to log/print the error for the user before calling exit()?


> +        if (qemu_show_nic_models(nic->model, r40_nic_models)) {
> +            exit(0);
>
+        }
> +
> +        switch (qemu_find_nic_model(nic, r40_nic_models,
> r40_nic_models[0])) {
> +        case 0: /* gmac */
> +            qdev_set_nic_properties(DEVICE(&s->gmac), nic);
> +            break;
> +        case 1: /* emac */
> +            qdev_set_nic_properties(DEVICE(&s->emac), nic);
> +            break;
> +        default:
> +            exit(1);
> +            break;
> +        }
> +    }
> +
> +    /* GMAC */
> +    object_property_set_link(OBJECT(&s->gmac), "dma-memory",
> +                                     OBJECT(get_system_memory()),
> &error_fatal);
> +    sysbus_realize(SYS_BUS_DEVICE(&s->gmac), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->gmac), 0,
> s->memmap[AW_R40_DEV_GMAC]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->gmac), 0,
> +                       qdev_get_gpio_in(DEVICE(&s->gic),
> AW_R40_GIC_SPI_GMAC));
> +
> +    /* EMAC */
> +    sysbus_realize(SYS_BUS_DEVICE(&s->emac), &error_fatal);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(&s->emac), 0,
> s->memmap[AW_R40_DEV_EMAC]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->emac), 0,
> +                       qdev_get_gpio_in(DEVICE(&s->gic),
> AW_R40_GIC_SPI_EMAC));
> +
>      /* Unimplemented devices */
>      for (i =3D 0; i < ARRAY_SIZE(r40_unimplemented); i++) {
>          create_unimplemented_device(r40_unimplemented[i].device_name,
> diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
> index 20a4550c68..74121d8966 100644
> --- a/hw/arm/bananapi_m2u.c
> +++ b/hw/arm/bananapi_m2u.c
> @@ -92,6 +92,9 @@ static void bpim2u_init(MachineState *machine)
>      object_property_set_int(OBJECT(r40), "ram-size",
>                              r40->ram_size, &error_abort);
>
> +    /* GMAC PHY */
> +    object_property_set_uint(OBJECT(r40), "gmac-phy-addr", 1,
> &error_abort);
> +
>      /* Mark R40 object realized */
>      qdev_realize(DEVICE(r40), NULL, &error_abort);
>
> diff --git a/include/hw/arm/allwinner-r40.h
> b/include/hw/arm/allwinner-r40.h
> index 8243e8903b..5f2d08489e 100644
> --- a/include/hw/arm/allwinner-r40.h
> +++ b/include/hw/arm/allwinner-r40.h
> @@ -28,6 +28,8 @@
>  #include "hw/misc/allwinner-r40-ccu.h"
>  #include "hw/misc/allwinner-r40-dramc.h"
>  #include "hw/i2c/allwinner-i2c.h"
> +#include "hw/net/allwinner_emac.h"
> +#include "hw/net/allwinner-sun8i-emac.h"
>  #include "target/arm/cpu.h"
>  #include "sysemu/block-backend.h"
>
> @@ -36,6 +38,7 @@ enum {
>      AW_R40_DEV_SRAM_A2,
>      AW_R40_DEV_SRAM_A3,
>      AW_R40_DEV_SRAM_A4,
> +    AW_R40_DEV_EMAC,
>      AW_R40_DEV_MMC0,
>      AW_R40_DEV_MMC1,
>      AW_R40_DEV_MMC2,
> @@ -51,6 +54,7 @@ enum {
>      AW_R40_DEV_UART6,
>      AW_R40_DEV_UART7,
>      AW_R40_DEV_TWI0,
> +    AW_R40_DEV_GMAC,
>      AW_R40_DEV_GIC_DIST,
>      AW_R40_DEV_GIC_CPU,
>      AW_R40_DEV_GIC_HYP,
> @@ -103,6 +107,8 @@ struct AwR40State {
>      AwR40ClockCtlState ccu;
>      AwR40DramCtlState dramc;
>      AWI2CState i2c0;
> +    AwEmacState emac;
> +    AwSun8iEmacState gmac;
>      GICState gic;
>      MemoryRegion sram_a1;
>      MemoryRegion sram_a2;
> --
> 2.25.1
>
>
Regards,
Niek
--=20
Niek Linnenbank

--0000000000008b335c05fbc0e2e7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div dir=3D"ltr">Hi Qianfan,<br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 10, 2023=
 at 12:30=E2=80=AFPM &lt;<a href=3D"mailto:qianfanguijin@163.com">qianfangu=
ijin@163.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">From: qianfan Zhao &lt;<a href=3D"mailto:qianfanguijin@163.com"=
 target=3D"_blank">qianfanguijin@163.com</a>&gt;<br>
<br>
R40 has two ethernet controllers named as emac and gmac. The emac is<br>
compatibled with A10, and the GMAC is compatibled with H3.<br>
<br>
Signed-off-by: qianfan Zhao &lt;<a href=3D"mailto:qianfanguijin@163.com" ta=
rget=3D"_blank">qianfanguijin@163.com</a>&gt;<br>
---<br>
=C2=A0hw/arm/allwinner-r40.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 50 ++++++++=
++++++++++++++++++++++++--<br>
=C2=A0hw/arm/bananapi_m2u.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++<=
br>
=C2=A0include/hw/arm/allwinner-r40.h |=C2=A0 6 ++++<br>
=C2=A03 files changed, 57 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/hw/arm/allwinner-r40.c b/hw/arm/allwinner-r40.c<br>
index b148c56449..c018ad231a 100644<br>
--- a/hw/arm/allwinner-r40.c<br>
+++ b/hw/arm/allwinner-r40.c<br>
@@ -39,6 +39,7 @@ const hwaddr allwinner_r40_memmap[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_SRAM_A2]=C2=A0 =C2=A0 =3D 0x00004000,<br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_SRAM_A3]=C2=A0 =C2=A0 =3D 0x00008000,<br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_SRAM_A4]=C2=A0 =C2=A0 =3D 0x0000b400,<br>
+=C2=A0 =C2=A0 [AW_R40_DEV_EMAC]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c0b000,<=
br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_MMC0]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c0f=
000,<br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_MMC1]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c10=
000,<br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_MMC2]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c11=
000,<br>
@@ -54,6 +55,7 @@ const hwaddr allwinner_r40_memmap[] =3D {<br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_UART6]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c29800,<=
br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_UART7]=C2=A0 =C2=A0 =C2=A0 =3D 0x01c29c00,<=
br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_TWI0]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c2a=
c00,<br>
+=C2=A0 =C2=A0 [AW_R40_DEV_GMAC]=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x01c50000,<=
br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_DRAMCOM]=C2=A0 =C2=A0 =3D 0x01c62000,<br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_DRAMCTL]=C2=A0 =C2=A0 =3D 0x01c63000,<br>
=C2=A0 =C2=A0 =C2=A0[AW_R40_DEV_DRAMPHY]=C2=A0 =C2=A0 =3D 0x01c65000,<br>
@@ -82,7 +84,6 @@ static struct AwR40Unimplemented r40_unimplemented[] =3D =
{<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;spi1&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c0600=
0, 4 * KiB },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;cs0&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01c0900=
0, 4 * KiB },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;keymem&quot;,=C2=A0 =C2=A0 =C2=A00x01c0a000, 4 =
* KiB },<br>
-=C2=A0 =C2=A0 { &quot;emac&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c0b000, 4 =
* KiB },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;usb0-otg&quot;,=C2=A0 =C2=A00x01c13000, 4 * KiB=
 },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;usb0-host&quot;,=C2=A0 0x01c14000, 4 * KiB },<b=
r>
=C2=A0 =C2=A0 =C2=A0{ &quot;crypto&quot;,=C2=A0 =C2=A0 =C2=A00x01c15000, 4 =
* KiB },<br>
@@ -131,7 +132,6 @@ static struct AwR40Unimplemented r40_unimplemented[] =
=3D {<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;tvd2&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c3300=
0, 4 * KiB },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;tvd3&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c3400=
0, 4 * KiB },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;gpu&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01c4000=
0, 64 * KiB },<br>
-=C2=A0 =C2=A0 { &quot;gmac&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c50000, 64=
 * KiB },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;hstmr&quot;,=C2=A0 =C2=A0 =C2=A0 0x01c60000, 4 =
* KiB },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;tcon-top&quot;,=C2=A0 =C2=A00x01c70000, 4 * KiB=
 },<br>
=C2=A0 =C2=A0 =C2=A0{ &quot;lcd0&quot;,=C2=A0 =C2=A0 =C2=A0 =C2=A00x01c7100=
0, 4 * KiB },<br>
@@ -180,6 +180,8 @@ enum {<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_GIC_SPI_MMC1=C2=A0 =C2=A0 =C2=A0 =3D 33,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_GIC_SPI_MMC2=C2=A0 =C2=A0 =C2=A0 =3D 34,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_GIC_SPI_MMC3=C2=A0 =C2=A0 =C2=A0 =3D 35,<br>
+=C2=A0 =C2=A0 AW_R40_GIC_SPI_EMAC=C2=A0 =C2=A0 =C2=A0 =3D 55,<br>
+=C2=A0 =C2=A0 AW_R40_GIC_SPI_GMAC=C2=A0 =C2=A0 =C2=A0 =3D 85,<br>
=C2=A0};<br>
<br>
=C2=A0/* Allwinner R40 general constants */<br>
@@ -276,6 +278,11 @@ static void allwinner_r40_init(Object *obj)<br>
<br>
=C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, &quot;twi0&quot;, &amp;s-&=
gt;i2c0, TYPE_AW_I2C_SUN6I);<br>
<br>
+=C2=A0 =C2=A0 object_initialize_child(obj, &quot;emac&quot;, &amp;s-&gt;em=
ac, TYPE_AW_EMAC);<br>
+=C2=A0 =C2=A0 object_initialize_child(obj, &quot;gmac&quot;, &amp;s-&gt;gm=
ac, TYPE_AW_SUN8I_EMAC);<br>
+=C2=A0 =C2=A0 object_property_add_alias(obj, &quot;gmac-phy-addr&quot;,<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OBJECT(&amp;s-&gt;gmac), &quot;phy-addr&quo=
t;);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0object_initialize_child(obj, &quot;dramc&quot;, &amp;s-=
&gt;dramc, TYPE_AW_R40_DRAMC);<br>
=C2=A0 =C2=A0 =C2=A0object_property_add_alias(obj, &quot;ram-addr&quot;, OB=
JECT(&amp;s-&gt;dramc),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;ram-addr&quot;);<br>
@@ -285,6 +292,7 @@ static void allwinner_r40_init(Object *obj)<br>
<br>
=C2=A0static void allwinner_r40_realize(DeviceState *dev, Error **errp)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 const char *r40_nic_models[] =3D { &quot;gmac&quot;, &quot;e=
mac&quot;, NULL };<br>
=C2=A0 =C2=A0 =C2=A0AwR40State *s =3D AW_R40(dev);<br>
=C2=A0 =C2=A0 =C2=A0unsigned i;<br>
<br>
@@ -442,6 +450,44 @@ static void allwinner_r40_realize(DeviceState *dev, Er=
ror **errp)<br>
=C2=A0 =C2=A0 =C2=A0sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;dramc), 2,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0s-&gt;memmap[AW_R40_DEV_DRAMPHY]);<br>
<br>
+=C2=A0 =C2=A0 /* nic support gmac and emac */<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; ARRAY_SIZE(r40_nic_models) - 1; i++=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NICInfo *nic =3D &amp;nd_table[i];<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!nic-&gt;used) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br></blockquote><div><br></div><div>Could yo=
u please clarify the lines below here? I&#39;m not seeing the function call=
 &#39;qemu_show_nic_models()&#39; in any of the other machines / soc implem=
entations.</div><div><br></div><div>Also, if you intend to catch a possible=
 input error here, probably its best to log/print the error for the user be=
fore calling exit()?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (qemu_show_nic_models(nic-&gt;model, r40_ni=
c_models)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(0); <br></blockquote><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (qemu_find_nic_model(nic, r40_nic_model=
s, r40_nic_models[0])) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0: /* gmac */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_set_nic_properties(DEVICE(&=
amp;s-&gt;gmac), nic);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 1: /* emac */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qdev_set_nic_properties(DEVICE(&=
amp;s-&gt;emac), nic);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* GMAC */<br>
+=C2=A0 =C2=A0 object_property_set_link(OBJECT(&amp;s-&gt;gmac), &quot;dma-=
memory&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OBJECT(get_syste=
m_memory()), &amp;error_fatal);<br>
+=C2=A0 =C2=A0 sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;gmac), &amp;error_f=
atal);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;gmac), 0, s-&gt;me=
mmap[AW_R40_DEV_GMAC]);<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;gmac), 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_R40_GIC_SPI_GMAC));<b=
r>
+<br>
+=C2=A0 =C2=A0 /* EMAC */<br>
+=C2=A0 =C2=A0 sysbus_realize(SYS_BUS_DEVICE(&amp;s-&gt;emac), &amp;error_f=
atal);<br>
+=C2=A0 =C2=A0 sysbus_mmio_map(SYS_BUS_DEVICE(&amp;s-&gt;emac), 0, s-&gt;me=
mmap[AW_R40_DEV_EMAC]);<br>
+=C2=A0 =C2=A0 sysbus_connect_irq(SYS_BUS_DEVICE(&amp;s-&gt;emac), 0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0qdev_get_gpio_in(DEVICE(&amp;s-&gt;gic), AW_R40_GIC_SPI_EMAC));<b=
r>
+<br>
=C2=A0 =C2=A0 =C2=A0/* Unimplemented devices */<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ARRAY_SIZE(r40_unimplemented); i++=
) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0create_unimplemented_device(r40_unimpleme=
nted[i].device_name,<br>
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c<br>
index 20a4550c68..74121d8966 100644<br>
--- a/hw/arm/bananapi_m2u.c<br>
+++ b/hw/arm/bananapi_m2u.c<br>
@@ -92,6 +92,9 @@ static void bpim2u_init(MachineState *machine)<br>
=C2=A0 =C2=A0 =C2=A0object_property_set_int(OBJECT(r40), &quot;ram-size&quo=
t;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r40-&gt;ram_size, &amp;error_abort);<br>
<br>
+=C2=A0 =C2=A0 /* GMAC PHY */<br>
+=C2=A0 =C2=A0 object_property_set_uint(OBJECT(r40), &quot;gmac-phy-addr&qu=
ot;, 1, &amp;error_abort);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0/* Mark R40 object realized */<br>
=C2=A0 =C2=A0 =C2=A0qdev_realize(DEVICE(r40), NULL, &amp;error_abort);<br>
<br>
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.=
h<br>
index 8243e8903b..5f2d08489e 100644<br>
--- a/include/hw/arm/allwinner-r40.h<br>
+++ b/include/hw/arm/allwinner-r40.h<br>
@@ -28,6 +28,8 @@<br>
=C2=A0#include &quot;hw/misc/allwinner-r40-ccu.h&quot;<br>
=C2=A0#include &quot;hw/misc/allwinner-r40-dramc.h&quot;<br>
=C2=A0#include &quot;hw/i2c/allwinner-i2c.h&quot;<br>
+#include &quot;hw/net/allwinner_emac.h&quot;<br>
+#include &quot;hw/net/allwinner-sun8i-emac.h&quot;<br>
=C2=A0#include &quot;target/arm/cpu.h&quot;<br>
=C2=A0#include &quot;sysemu/block-backend.h&quot;<br>
<br>
@@ -36,6 +38,7 @@ enum {<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_SRAM_A2,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_SRAM_A3,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_SRAM_A4,<br>
+=C2=A0 =C2=A0 AW_R40_DEV_EMAC,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_MMC0,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_MMC1,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_MMC2,<br>
@@ -51,6 +54,7 @@ enum {<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_UART6,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_UART7,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_TWI0,<br>
+=C2=A0 =C2=A0 AW_R40_DEV_GMAC,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_GIC_DIST,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_GIC_CPU,<br>
=C2=A0 =C2=A0 =C2=A0AW_R40_DEV_GIC_HYP,<br>
@@ -103,6 +107,8 @@ struct AwR40State {<br>
=C2=A0 =C2=A0 =C2=A0AwR40ClockCtlState ccu;<br>
=C2=A0 =C2=A0 =C2=A0AwR40DramCtlState dramc;<br>
=C2=A0 =C2=A0 =C2=A0AWI2CState i2c0;<br>
+=C2=A0 =C2=A0 AwEmacState emac;<br>
+=C2=A0 =C2=A0 AwSun8iEmacState gmac;<br>
=C2=A0 =C2=A0 =C2=A0GICState gic;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a1;<br>
=C2=A0 =C2=A0 =C2=A0MemoryRegion sram_a2;<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div><br clear=3D"all"></div><div>Regards,</div><div>Niek<br>=
</div><div><span class=3D"gmail_signature_prefix">-- </span><br><div dir=3D=
"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Niek Linnenbank<br><b=
r></div></div></div></div></div>

--0000000000008b335c05fbc0e2e7--


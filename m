Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DF47472BA
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:28:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGg4A-0007Nu-Oq; Tue, 04 Jul 2023 09:27:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ssinprem@celestica.com>)
 id 1qGg49-0007ND-A0
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:27:37 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ssinprem@celestica.com>)
 id 1qGg46-000101-16
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:27:37 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6748a616e17so1455664b3a.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=celestica.com; s=google-201810; t=1688477252; x=1691069252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cFphBx4sTqbIAYHRgLy8QeJ3xqxnJHXjdKyMTx2nz2c=;
 b=SHBja3GzZpW2fX5rDgXq7wnt24wfCGfxdVtZfrwIOXt7P6rtHBrLvRuEaHaPe9a5qH
 XwRfNODo/I1aYV4WhxICd19hhCTX95DOwXr8m+jBwY7suJ4HfAOq2rkP3Q+6TXriQcNK
 lQihB4IZGuyNirVqCs8F0bj0t2ch7OfiCZZrTOt6PjcUUEwUi/Tdr6rpRn64JhY1//q9
 2Ti1nHQmLL/8xa9RCBdRAQZz5yTTa3tkRl6MyNP6d+qzDpkhylpN1RQHODVDfd5EWUye
 zv510AuKuG+d3Vv2J27BfU5WnpvKFB2cZ/Xv7ralJaGIUSGraJX+7Adj8IA2+5tdruwr
 S5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688477252; x=1691069252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cFphBx4sTqbIAYHRgLy8QeJ3xqxnJHXjdKyMTx2nz2c=;
 b=AfRRPudXqoQ6k7Komk0r7yBa+WqRoyifPuvh4Acn8zHIRqnS6OGNzVKfA6KoMMWySL
 FonqUQWe46SzX6FtKxE1WXzy2C2u1QvLXLFBbR2cICR2hPgFPv+IHsUMZa7rW7/EHqIY
 K4+jymTxkZGFOHg/f3AKkyKoJp19PbCnMdsc64tWLdNQ/nFxc/NWRfy2hSfhCnjVdBC4
 jSt4Wt71PEHcuYB46RzNHEoOah9yFTMmcMG/s+sI8OuFj8cl3vvsuT19REeJr6mqMDcO
 9exrUJYgsLBiP8DUPQQrT7xZDiOnV/eiJVZs4+tmhrZm/f0Tuom+aTtZL3qHNtDhaWUq
 EmtQ==
X-Gm-Message-State: ABy/qLZjbmshJgf49xmlphtBh2AwFAJzC7G/9OOlxlilhgUXURJg1yo9
 T90m4mLrm9BPpR58e03pNDrrxzcnZ0LrzAzRyuzf+6mpzRZ2KnlEV0yiVOE80srbDg+ntEyhoYT
 k6nyxFcbMLXPrqmvHP1Js3uscFJ6BfaEcgTLAlNfI7Dg6rlgKUH5//1oXgUwL0L4e97RhqWdCFy
 3Qz1ZIkKl1cJeLtZu1wzNbgUcW6/SDm0akzA==
X-Google-Smtp-Source: APBJJlGoqJM1mZnr0vsqEEbBynIzD47+azIYouF4QeGhKwp7+AT25UjfdPnSt0YgS46vRBJAYDyxFksYeVjSr5IFRl0=
X-Received: by 2002:a05:6a00:399a:b0:681:9fe0:b543 with SMTP id
 fi26-20020a056a00399a00b006819fe0b543mr15520151pfb.2.1688477252062; Tue, 04
 Jul 2023 06:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <168846918238.25928.7102858062933368556-0@git.sr.ht>
 <3cda00c1-54f8-57db-8992-3cafa97d4564@kaod.org>
In-Reply-To: <3cda00c1-54f8-57db-8992-3cafa97d4564@kaod.org>
From: Sittisak Sinprem <ssinprem@celestica.com>
Date: Tue, 4 Jul 2023 20:27:01 +0700
Message-ID: <CAE+aGtX9qcaPXhEYyqDuW_PLsKY9bVXhWiWb=oMT+5X-AXg3zg@mail.gmail.com>
Subject: Re: [PATCH qemu v5] aspeed add montblanc bmc reference from fuji
To: Bin Huang <binhuang@meta.com>, Tao Ren <taoren@meta.com>,
 Mike Choi <mikechoi@meta.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, peter.maydell@linaro.org, andrew@aj.id.au, 
 Joel Stanley <joel@jms.id.au>, qemu-stable@nongnu.org, srikanth@celestica.com, 
 ssumet@celestica.com, thangavelu.v@celestica.com, kgengan@celestica.com, 
 anandaramanv@celestica.com
Content-Type: multipart/alternative; boundary="000000000000d27e5c05ffa93e3b"
X-CLS-Gapps: True
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: celesticainc,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=ssinprem@celestica.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

--000000000000d27e5c05ffa93e3b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Meta Team,

the FRU EEPROM content, I think for now detail still be confidential,
Please confirm, Can we add the description in Qemu upstream following
Cedric's request?

On Tue, Jul 4, 2023 at 6:19=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.org>=
 wrote:

> On 7/4/23 13:06, ~ssinprem wrote:
> > From: Sittisak Sinprem <ssinprem@celestica.com>
> >
> > - I2C list follow I2C Tree v1.6 20230320
> > - fru eeprom data use FB FRU format version 4
> >
> > Signed-off-by: Sittisak Sinprem <ssinprem@celestica.com>
>
> You shoot too fast :) Please add some description for the EEPROM contents=
.
> What they enable when the OS/FW boots is good to know for QEMU.
>
> Thanks,
>
> C.
>
>
> > ---
> >   docs/system/arm/aspeed.rst |  1 +
> >   hw/arm/aspeed.c            | 65 +++++++++++++++++++++++++++++++++++++=
+
> >   hw/arm/aspeed_eeprom.c     | 50 +++++++++++++++++++++++++++++
> >   hw/arm/aspeed_eeprom.h     |  7 ++++
> >   4 files changed, 123 insertions(+)
> >
> > diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> > index 80538422a1..5e0824f48b 100644
> > --- a/docs/system/arm/aspeed.rst
> > +++ b/docs/system/arm/aspeed.rst
> > @@ -33,6 +33,7 @@ AST2600 SoC based machines :
> >   - ``tacoma-bmc``           OpenPOWER Witherspoon POWER9 AST2600 BMC
> >   - ``rainier-bmc``          IBM Rainier POWER10 BMC
> >   - ``fuji-bmc``             Facebook Fuji BMC
> > +- ``montblanc-bmc``        Facebook Montblanc BMC
> >   - ``bletchley-bmc``        Facebook Bletchley BMC
> >   - ``fby35-bmc``            Facebook fby35 BMC
> >   - ``qcom-dc-scm-v1-bmc``   Qualcomm DC-SCM V1 BMC
> > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> > index 9fca644d92..bbb7a3392c 100644
> > --- a/hw/arm/aspeed.c
> > +++ b/hw/arm/aspeed.c
> > @@ -189,6 +189,10 @@ struct AspeedMachineState {
> >   #define FUJI_BMC_HW_STRAP1    0x00000000
> >   #define FUJI_BMC_HW_STRAP2    0x00000000
> >
> > +/* Montblanc hardware value */
> > +#define MONTBLANC_BMC_HW_STRAP1    0x00000000
> > +#define MONTBLANC_BMC_HW_STRAP2    0x00000000
> > +
> >   /* Bletchley hardware value */
> >   /* TODO: Leave same as EVB for now. */
> >   #define BLETCHLEY_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
> > @@ -925,6 +929,41 @@ static void fuji_bmc_i2c_init(AspeedMachineState
> *bmc)
> >       }
> >   }
> >
> > +static void montblanc_bmc_i2c_init(AspeedMachineState *bmc)
> > +{
> > +    AspeedSoCState *soc =3D &bmc->soc;
> > +    I2CBus *i2c[16] =3D {};
> > +
> > +    for (int i =3D 0; i < 16; i++) {
> > +        i2c[i] =3D aspeed_i2c_get_bus(&soc->i2c, i);
> > +    }
> > +
> > +    /* Ref from Minipack3_I2C_Tree_V1.6 20230320 */
> > +    at24c_eeprom_init_rom(i2c[3], 0x56, 8192, montblanc_scm_fruid,
> > +                          montblanc_scm_fruid_len);
> > +    at24c_eeprom_init_rom(i2c[6], 0x53, 8192, montblanc_fcm_fruid,
> > +                          montblanc_fcm_fruid_len);
> > +
> > +    /* CPLD and FPGA */
> > +    at24c_eeprom_init(i2c[1], 0x35, 256);  /* SCM CPLD */
> > +    at24c_eeprom_init(i2c[5], 0x35, 256);  /* COMe CPLD TODO: need to
> update */
> > +    at24c_eeprom_init(i2c[12], 0x60, 256); /* MCB PWR CPLD */
> > +    at24c_eeprom_init(i2c[13], 0x35, 256); /* IOB FPGA */
> > +
> > +    /* on BMC board */
> > +    at24c_eeprom_init_rom(i2c[8], 0x51, 8192, montblanc_bmc_fruid,
> > +                          montblanc_bmc_fruid_len); /* BMC EEPROM */
> > +    i2c_slave_create_simple(i2c[8], TYPE_LM75, 0x48); /* Thermal Senso=
r
> */
> > +
> > +    /* COMe Sensor/EEPROM */
> > +    at24c_eeprom_init(i2c[0], 0x56, 16384);          /* FRU EEPROM */
> > +    i2c_slave_create_simple(i2c[0], TYPE_LM75, 0x48); /* INLET Sensor =
*/
> > +    i2c_slave_create_simple(i2c[0], TYPE_LM75, 0x4A); /* OUTLET Sensor
> */
> > +
> > +    /* It expects a pca9555 but a pca9552 is compatible */
> > +    create_pca9552(soc, 4, 0x27);
> > +}
> > +
> >   #define TYPE_TMP421 "tmp421"
> >
> >   static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
> > @@ -1452,6 +1491,28 @@ static void
> aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
> >           aspeed_soc_num_cpus(amc->soc_name);
> >   };
> >
> > +#define MONTBLANC_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> > +
> > +static void aspeed_machine_montblanc_class_init(ObjectClass *oc, void
> *data)
> > +{
> > +    MachineClass *mc =3D MACHINE_CLASS(oc);
> > +    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);
> > +
> > +    mc->desc =3D "Facebook Montblanc BMC (Cortex-A7)";
> > +    amc->soc_name =3D "ast2600-a3";
> > +    amc->hw_strap1 =3D MONTBLANC_BMC_HW_STRAP1;
> > +    amc->hw_strap2 =3D MONTBLANC_BMC_HW_STRAP2;
> > +    amc->fmc_model =3D "mx66l1g45g";
> > +    amc->spi_model =3D "mx66l1g45g";
> > +    amc->num_cs =3D 2;
> > +    amc->macs_mask =3D ASPEED_MAC3_ON;
> > +    amc->i2c_init =3D montblanc_bmc_i2c_init;
> > +    amc->uart_default =3D ASPEED_DEV_UART1;
> > +    mc->default_ram_size =3D MONTBLANC_BMC_RAM_SIZE;
> > +    mc->default_cpus =3D mc->min_cpus =3D mc->max_cpus =3D
> > +        aspeed_soc_num_cpus(amc->soc_name);
> > +};
> > +
> >   #define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> >
> >   static void aspeed_machine_bletchley_class_init(ObjectClass *oc, void
> *data)
> > @@ -1703,6 +1764,10 @@ static const TypeInfo aspeed_machine_types[] =3D=
 {
> >           .name          =3D MACHINE_TYPE_NAME("fuji-bmc"),
> >           .parent        =3D TYPE_ASPEED_MACHINE,
> >           .class_init    =3D aspeed_machine_fuji_class_init,
> > +    }, {
> > +        .name          =3D MACHINE_TYPE_NAME("montblanc-bmc"),
> > +        .parent        =3D TYPE_ASPEED_MACHINE,
> > +        .class_init    =3D aspeed_machine_montblanc_class_init,
> >       }, {
> >           .name          =3D MACHINE_TYPE_NAME("bletchley-bmc"),
> >           .parent        =3D TYPE_ASPEED_MACHINE,
> > diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c
> > index ace5266cec..8cc73f83dc 100644
> > --- a/hw/arm/aspeed_eeprom.c
> > +++ b/hw/arm/aspeed_eeprom.c
> > @@ -161,6 +161,53 @@ const uint8_t rainier_bmc_fruid[] =3D {
> >       0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
> >   };
> >
> > +/* Montblanc BMC FRU */
> > +const uint8_t montblanc_scm_fruid[] =3D {
> > +    0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50,
> 0x41,
> > +    0x43, 0x4b, 0x33, 0x5f, 0x53, 0x43, 0x4d, 0x02, 0x08, 0x32, 0x30,
> 0x30,
> > +    0x30, 0x32, 0x39, 0x34, 0x35, 0x04, 0x0c, 0x31, 0x33, 0x32, 0x30,
> 0x30,
> > +    0x30, 0x31, 0x36, 0x34, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31, 0x33,
> 0x31,
> > +    0x30, 0x30, 0x30, 0x31, 0x32, 0x37, 0x30, 0x31, 0x20, 0x06, 0x0c,
> 0x52,
> > +    0x33, 0x32, 0x31, 0x34, 0x47, 0x30, 0x30, 0x30, 0x33, 0x30, 0x31,
> 0x07,
> > +    0x0d, 0x41, 0x30, 0x33, 0x31, 0x33, 0x58, 0x58, 0x58, 0x58, 0x58,
> 0x58,
> > +    0x58, 0x58, 0x08, 0x01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0x01, 0x00,
> 0x0b,
> > +    0x0d, 0x4d, 0x32, 0x32, 0x31, 0x33, 0x32, 0x33, 0x31, 0x37, 0x30,
> 0x30,
> > +    0x30, 0x32, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30,
> 0x32,
> > +    0x33, 0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f,
> 0x03,
> > +    0x43, 0x54, 0x48, 0x10, 0x06, 0x01, 0x00, 0x00, 0x91, 0xdb, 0xb4,
> 0x13,
> > +    0x03, 0x53, 0x43, 0x4d, 0xfa, 0x02, 0x02, 0x61,
> > +};
> > +
> > +const uint8_t montblanc_fcm_fruid[] =3D {
> > +    0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50,
> 0x41,
> > +    0x43, 0x4b, 0x33, 0x5f, 0x46, 0x43, 0x42, 0x02, 0x08, 0x33, 0x30,
> 0x30,
> > +    0x30, 0x30, 0x31, 0x36, 0x31, 0x04, 0x0c, 0x31, 0x33, 0x32, 0x30,
> 0x30,
> > +    0x30, 0x31, 0x36, 0x33, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31, 0x33,
> 0x31,
> > +    0x30, 0x30, 0x30, 0x31, 0x33, 0x30, 0x30, 0x31, 0x20, 0x06, 0x0c,
> 0x52,
> > +    0x33, 0x32, 0x31, 0x34, 0x47, 0x30, 0x30, 0x31, 0x32, 0x30, 0x31,
> 0x07,
> > +    0x0d, 0x41, 0x31, 0x32, 0x31, 0x32, 0x58, 0x58, 0x58, 0x58, 0x58,
> 0x58,
> > +    0x58, 0x58, 0x08, 0x01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0x01, 0x00,
> 0x0b,
> > +    0x0d, 0x46, 0x35, 0x30, 0x31, 0x33, 0x32, 0x33, 0x31, 0x37, 0x30,
> 0x30,
> > +    0x30, 0x35, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30,
> 0x32,
> > +    0x33, 0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f,
> 0x03,
> > +    0x43, 0x54, 0x48, 0x10, 0x06, 0x02, 0x00, 0x00, 0x91, 0xdb, 0xb4,
> 0x11,
> > +    0x06, 0x03, 0x00, 0x00, 0x91, 0xdb, 0xb4, 0x12, 0x02, 0x8a, 0x00,
> 0x13,
> > +    0x03, 0x46, 0x43, 0x42, 0xfa, 0x02, 0x50, 0x47,
> > +};
> > +
> > +const uint8_t montblanc_bmc_fruid[] =3D {
> > +    0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50,
> 0x41,
> > +    0x43, 0x4b, 0x33, 0x5f, 0x42, 0x4d, 0x43, 0x04, 0x0c, 0x31, 0x33,
> 0x32,
> > +    0x30, 0x30, 0x30, 0x31, 0x33, 0x36, 0x30, 0x31, 0x20, 0x05, 0x0c,
> 0x31,
> > +    0x33, 0x31, 0x30, 0x30, 0x30, 0x30, 0x38, 0x36, 0x30, 0x35, 0x20,
> 0x06,
> > +    0x0c, 0x52, 0x33, 0x30, 0x39, 0x37, 0x47, 0x30, 0x30, 0x30, 0x32,
> 0x30,
> > +    0x37, 0x07, 0x0d, 0x42, 0x30, 0x32, 0x37, 0x34, 0x58, 0x58, 0x58,
> 0x58,
> > +    0x58, 0x58, 0x58, 0x58, 0x08, 0x01, 0x04, 0x09, 0x01, 0x00, 0x0a,
> 0x01,
> > +    0x00, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30, 0x32,
> 0x33,
> > +    0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f, 0x03,
> 0x43,
> > +    0x54, 0x48, 0x13, 0x03, 0x42, 0x4d, 0x43, 0xfa, 0x02, 0xef, 0xba,
> > +};
> > +
> >   const size_t tiogapass_bmc_fruid_len =3D sizeof(tiogapass_bmc_fruid);
> >   const size_t fby35_nic_fruid_len =3D sizeof(fby35_nic_fruid);
> >   const size_t fby35_bb_fruid_len =3D sizeof(fby35_bb_fruid);
> > @@ -168,3 +215,6 @@ const size_t fby35_bmc_fruid_len =3D
> sizeof(fby35_bmc_fruid);
> >   const size_t yosemitev2_bmc_fruid_len =3D sizeof(yosemitev2_bmc_fruid=
);
> >   const size_t rainier_bb_fruid_len =3D sizeof(rainier_bb_fruid);
> >   const size_t rainier_bmc_fruid_len =3D sizeof(rainier_bmc_fruid);
> > +const size_t montblanc_scm_fruid_len =3D sizeof(montblanc_scm_fruid);
> > +const size_t montblanc_fcm_fruid_len =3D sizeof(montblanc_fcm_fruid);
> > +const size_t montblanc_bmc_fruid_len =3D sizeof(montblanc_bmc_fruid);
> > diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h
> > index bbf9e54365..b8fbdd0734 100644
> > --- a/hw/arm/aspeed_eeprom.h
> > +++ b/hw/arm/aspeed_eeprom.h
> > @@ -27,4 +27,11 @@ extern const size_t rainier_bb_fruid_len;
> >   extern const uint8_t rainier_bmc_fruid[];
> >   extern const size_t rainier_bmc_fruid_len;
> >
> > +extern const uint8_t montblanc_scm_fruid[];
> > +extern const uint8_t montblanc_fcm_fruid[];
> > +extern const uint8_t montblanc_bmc_fruid[];
> > +extern const size_t montblanc_scm_fruid_len;
> > +extern const size_t montblanc_fcm_fruid_len;
> > +extern const size_t montblanc_bmc_fruid_len;
> > +
> >   #endif
>
>

--000000000000d27e5c05ffa93e3b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:trebuche=
t ms,sans-serif;font-size:small;color:#134f5c">Hi=C2=A0Meta Team,<br><br>th=
e FRU EEPROM content, I think for now detail still be=C2=A0confidential,<br=
>Please confirm, Can we add the description in Qemu upstream=C2=A0following=
 Cedric&#39;s request?</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Jul 4, 2023 at 6:19=E2=80=AFPM C=C3=
=A9dric Le Goater &lt;<a href=3D"mailto:clg@kaod.org">clg@kaod.org</a>&gt; =
wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 7/4/23=
 13:06, ~ssinprem wrote:<br>
&gt; From: Sittisak Sinprem &lt;<a href=3D"mailto:ssinprem@celestica.com" t=
arget=3D"_blank">ssinprem@celestica.com</a>&gt;<br>
&gt; <br>
&gt; - I2C list follow I2C Tree v1.6 20230320<br>
&gt; - fru eeprom data use FB FRU format version 4<br>
&gt; <br>
&gt; Signed-off-by: Sittisak Sinprem &lt;<a href=3D"mailto:ssinprem@celesti=
ca.com" target=3D"_blank">ssinprem@celestica.com</a>&gt;<br>
<br>
You shoot too fast :) Please add some description for the EEPROM contents.<=
br>
What they enable when the OS/FW boots is good to know for QEMU.<br>
<br>
Thanks,<br>
<br>
C.<br>
<br>
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0docs/system/arm/aspeed.rst |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A0hw/arm/aspeed.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
 65 ++++++++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/arm/aspeed_eeprom.c=C2=A0 =C2=A0 =C2=A0| 50 +++++++++++=
++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/arm/aspeed_eeprom.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 7 ++++<b=
r>
&gt;=C2=A0 =C2=A04 files changed, 123 insertions(+)<br>
&gt; <br>
&gt; diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst<b=
r>
&gt; index 80538422a1..5e0824f48b 100644<br>
&gt; --- a/docs/system/arm/aspeed.rst<br>
&gt; +++ b/docs/system/arm/aspeed.rst<br>
&gt; @@ -33,6 +33,7 @@ AST2600 SoC based machines :<br>
&gt;=C2=A0 =C2=A0- ``tacoma-bmc``=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0O=
penPOWER Witherspoon POWER9 AST2600 BMC<br>
&gt;=C2=A0 =C2=A0- ``rainier-bmc``=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IBM Ra=
inier POWER10 BMC<br>
&gt;=C2=A0 =C2=A0- ``fuji-bmc``=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0Facebook Fuji BMC<br>
&gt; +- ``montblanc-bmc``=C2=A0 =C2=A0 =C2=A0 =C2=A0 Facebook Montblanc BMC=
<br>
&gt;=C2=A0 =C2=A0- ``bletchley-bmc``=C2=A0 =C2=A0 =C2=A0 =C2=A0 Facebook Bl=
etchley BMC<br>
&gt;=C2=A0 =C2=A0- ``fby35-bmc``=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 F=
acebook fby35 BMC<br>
&gt;=C2=A0 =C2=A0- ``qcom-dc-scm-v1-bmc``=C2=A0 =C2=A0Qualcomm DC-SCM V1 BM=
C<br>
&gt; diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c<br>
&gt; index 9fca644d92..bbb7a3392c 100644<br>
&gt; --- a/hw/arm/aspeed.c<br>
&gt; +++ b/hw/arm/aspeed.c<br>
&gt; @@ -189,6 +189,10 @@ struct AspeedMachineState {<br>
&gt;=C2=A0 =C2=A0#define FUJI_BMC_HW_STRAP1=C2=A0 =C2=A0 0x00000000<br>
&gt;=C2=A0 =C2=A0#define FUJI_BMC_HW_STRAP2=C2=A0 =C2=A0 0x00000000<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/* Montblanc hardware value */<br>
&gt; +#define MONTBLANC_BMC_HW_STRAP1=C2=A0 =C2=A0 0x00000000<br>
&gt; +#define MONTBLANC_BMC_HW_STRAP2=C2=A0 =C2=A0 0x00000000<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/* Bletchley hardware value */<br>
&gt;=C2=A0 =C2=A0/* TODO: Leave same as EVB for now. */<br>
&gt;=C2=A0 =C2=A0#define BLETCHLEY_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1<br>
&gt; @@ -925,6 +929,41 @@ static void fuji_bmc_i2c_init(AspeedMachineState =
*bmc)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static void montblanc_bmc_i2c_init(AspeedMachineState *bmc)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 AspeedSoCState *soc =3D &amp;bmc-&gt;soc;<br>
&gt; +=C2=A0 =C2=A0 I2CBus *i2c[16] =3D {};<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (int i =3D 0; i &lt; 16; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c[i] =3D aspeed_i2c_get_bus(&amp;soc-&g=
t;i2c, i);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Ref from Minipack3_I2C_Tree_V1.6 20230320 */<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init_rom(i2c[3], 0x56, 8192, montblanc_scm=
_fruid,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 montblanc_scm_fruid_len);<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init_rom(i2c[6], 0x53, 8192, montblanc_fcm=
_fruid,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 montblanc_fcm_fruid_len);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* CPLD and FPGA */<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(i2c[1], 0x35, 256);=C2=A0 /* SCM CPLD=
 */<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(i2c[5], 0x35, 256);=C2=A0 /* COMe CPL=
D TODO: need to update */<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(i2c[12], 0x60, 256); /* MCB PWR CPLD =
*/<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(i2c[13], 0x35, 256); /* IOB FPGA */<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* on BMC board */<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init_rom(i2c[8], 0x51, 8192, montblanc_bmc=
_fruid,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 montblanc_bmc_fruid_len); /* BMC EEPROM */<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[8], TYPE_LM75, 0x48); /* Th=
ermal Sensor */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* COMe Sensor/EEPROM */<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(i2c[0], 0x56, 16384);=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 /* FRU EEPROM */<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[0], TYPE_LM75, 0x48); /* IN=
LET Sensor */<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[0], TYPE_LM75, 0x4A); /* OU=
TLET Sensor */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* It expects a pca9555 but a pca9552 is compatible */<=
br>
&gt; +=C2=A0 =C2=A0 create_pca9552(soc, 4, 0x27);<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#define TYPE_TMP421 &quot;tmp421&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void bletchley_bmc_i2c_init(AspeedMachineState *bmc=
)<br>
&gt; @@ -1452,6 +1491,28 @@ static void aspeed_machine_fuji_class_init(Obje=
ctClass *oc, void *data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aspeed_soc_num_cpus(amc-&gt;so=
c_name);<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +#define MONTBLANC_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)<br>
&gt; +<br>
&gt; +static void aspeed_machine_montblanc_class_init(ObjectClass *oc, void=
 *data)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc);<br>
&gt; +=C2=A0 =C2=A0 AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;desc =3D &quot;Facebook Montblanc BMC (Cortex-A7=
)&quot;;<br>
&gt; +=C2=A0 =C2=A0 amc-&gt;soc_name =3D &quot;ast2600-a3&quot;;<br>
&gt; +=C2=A0 =C2=A0 amc-&gt;hw_strap1 =3D MONTBLANC_BMC_HW_STRAP1;<br>
&gt; +=C2=A0 =C2=A0 amc-&gt;hw_strap2 =3D MONTBLANC_BMC_HW_STRAP2;<br>
&gt; +=C2=A0 =C2=A0 amc-&gt;fmc_model =3D &quot;mx66l1g45g&quot;;<br>
&gt; +=C2=A0 =C2=A0 amc-&gt;spi_model =3D &quot;mx66l1g45g&quot;;<br>
&gt; +=C2=A0 =C2=A0 amc-&gt;num_cs =3D 2;<br>
&gt; +=C2=A0 =C2=A0 amc-&gt;macs_mask =3D ASPEED_MAC3_ON;<br>
&gt; +=C2=A0 =C2=A0 amc-&gt;i2c_init =3D montblanc_bmc_i2c_init;<br>
&gt; +=C2=A0 =C2=A0 amc-&gt;uart_default =3D ASPEED_DEV_UART1;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;default_ram_size =3D MONTBLANC_BMC_RAM_SIZE;<br>
&gt; +=C2=A0 =C2=A0 mc-&gt;default_cpus =3D mc-&gt;min_cpus =3D mc-&gt;max_=
cpus =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aspeed_soc_num_cpus(amc-&gt;soc_name);<br=
>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)<br=
>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void aspeed_machine_bletchley_class_init(ObjectClas=
s *oc, void *data)<br>
&gt; @@ -1703,6 +1764,10 @@ static const TypeInfo aspeed_machine_types[] =
=3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D MACHINE_TYPE_NAME(&quot;fuji-bmc&quot;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D TYPE_ASPEED_MACHINE,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D a=
speed_machine_fuji_class_init,<br>
&gt; +=C2=A0 =C2=A0 }, {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D MACHINE_TYPE_NAME(&quot;montblanc-bmc&quot;),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TY=
PE_ASPEED_MACHINE,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D aspeed_machi=
ne_montblanc_class_init,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}, {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =3D MACHINE_TYPE_NAME(&quot;bletchley-bmc&quot;),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =3D TYPE_ASPEED_MACHINE,<br>
&gt; diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c<br>
&gt; index ace5266cec..8cc73f83dc 100644<br>
&gt; --- a/hw/arm/aspeed_eeprom.c<br>
&gt; +++ b/hw/arm/aspeed_eeprom.c<br>
&gt; @@ -161,6 +161,53 @@ const uint8_t rainier_bmc_fruid[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A00x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x=
00, 0x00,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/* Montblanc BMC FRU */<br>
&gt; +const uint8_t montblanc_scm_fruid[] =3D {<br>
&gt; +=C2=A0 =C2=A0 0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0=
x49, 0x50, 0x41,<br>
&gt; +=C2=A0 =C2=A0 0x43, 0x4b, 0x33, 0x5f, 0x53, 0x43, 0x4d, 0x02, 0x08, 0=
x32, 0x30, 0x30,<br>
&gt; +=C2=A0 =C2=A0 0x30, 0x32, 0x39, 0x34, 0x35, 0x04, 0x0c, 0x31, 0x33, 0=
x32, 0x30, 0x30,<br>
&gt; +=C2=A0 =C2=A0 0x30, 0x31, 0x36, 0x34, 0x30, 0x31, 0x20, 0x05, 0x0c, 0=
x31, 0x33, 0x31,<br>
&gt; +=C2=A0 =C2=A0 0x30, 0x30, 0x30, 0x31, 0x32, 0x37, 0x30, 0x31, 0x20, 0=
x06, 0x0c, 0x52,<br>
&gt; +=C2=A0 =C2=A0 0x33, 0x32, 0x31, 0x34, 0x47, 0x30, 0x30, 0x30, 0x33, 0=
x30, 0x31, 0x07,<br>
&gt; +=C2=A0 =C2=A0 0x0d, 0x41, 0x30, 0x33, 0x31, 0x33, 0x58, 0x58, 0x58, 0=
x58, 0x58, 0x58,<br>
&gt; +=C2=A0 =C2=A0 0x58, 0x58, 0x08, 0x01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0=
x01, 0x00, 0x0b,<br>
&gt; +=C2=A0 =C2=A0 0x0d, 0x4d, 0x32, 0x32, 0x31, 0x33, 0x32, 0x33, 0x31, 0=
x37, 0x30, 0x30,<br>
&gt; +=C2=A0 =C2=A0 0x30, 0x32, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0=
x32, 0x30, 0x32,<br>
&gt; +=C2=A0 =C2=A0 0x33, 0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0=
x53, 0x0f, 0x03,<br>
&gt; +=C2=A0 =C2=A0 0x43, 0x54, 0x48, 0x10, 0x06, 0x01, 0x00, 0x00, 0x91, 0=
xdb, 0xb4, 0x13,<br>
&gt; +=C2=A0 =C2=A0 0x03, 0x53, 0x43, 0x4d, 0xfa, 0x02, 0x02, 0x61,<br>
&gt; +};<br>
&gt; +<br>
&gt; +const uint8_t montblanc_fcm_fruid[] =3D {<br>
&gt; +=C2=A0 =C2=A0 0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0=
x49, 0x50, 0x41,<br>
&gt; +=C2=A0 =C2=A0 0x43, 0x4b, 0x33, 0x5f, 0x46, 0x43, 0x42, 0x02, 0x08, 0=
x33, 0x30, 0x30,<br>
&gt; +=C2=A0 =C2=A0 0x30, 0x30, 0x31, 0x36, 0x31, 0x04, 0x0c, 0x31, 0x33, 0=
x32, 0x30, 0x30,<br>
&gt; +=C2=A0 =C2=A0 0x30, 0x31, 0x36, 0x33, 0x30, 0x31, 0x20, 0x05, 0x0c, 0=
x31, 0x33, 0x31,<br>
&gt; +=C2=A0 =C2=A0 0x30, 0x30, 0x30, 0x31, 0x33, 0x30, 0x30, 0x31, 0x20, 0=
x06, 0x0c, 0x52,<br>
&gt; +=C2=A0 =C2=A0 0x33, 0x32, 0x31, 0x34, 0x47, 0x30, 0x30, 0x31, 0x32, 0=
x30, 0x31, 0x07,<br>
&gt; +=C2=A0 =C2=A0 0x0d, 0x41, 0x31, 0x32, 0x31, 0x32, 0x58, 0x58, 0x58, 0=
x58, 0x58, 0x58,<br>
&gt; +=C2=A0 =C2=A0 0x58, 0x58, 0x08, 0x01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0=
x01, 0x00, 0x0b,<br>
&gt; +=C2=A0 =C2=A0 0x0d, 0x46, 0x35, 0x30, 0x31, 0x33, 0x32, 0x33, 0x31, 0=
x37, 0x30, 0x30,<br>
&gt; +=C2=A0 =C2=A0 0x30, 0x35, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0=
x32, 0x30, 0x32,<br>
&gt; +=C2=A0 =C2=A0 0x33, 0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0=
x53, 0x0f, 0x03,<br>
&gt; +=C2=A0 =C2=A0 0x43, 0x54, 0x48, 0x10, 0x06, 0x02, 0x00, 0x00, 0x91, 0=
xdb, 0xb4, 0x11,<br>
&gt; +=C2=A0 =C2=A0 0x06, 0x03, 0x00, 0x00, 0x91, 0xdb, 0xb4, 0x12, 0x02, 0=
x8a, 0x00, 0x13,<br>
&gt; +=C2=A0 =C2=A0 0x03, 0x46, 0x43, 0x42, 0xfa, 0x02, 0x50, 0x47,<br>
&gt; +};<br>
&gt; +<br>
&gt; +const uint8_t montblanc_bmc_fruid[] =3D {<br>
&gt; +=C2=A0 =C2=A0 0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0=
x49, 0x50, 0x41,<br>
&gt; +=C2=A0 =C2=A0 0x43, 0x4b, 0x33, 0x5f, 0x42, 0x4d, 0x43, 0x04, 0x0c, 0=
x31, 0x33, 0x32,<br>
&gt; +=C2=A0 =C2=A0 0x30, 0x30, 0x30, 0x31, 0x33, 0x36, 0x30, 0x31, 0x20, 0=
x05, 0x0c, 0x31,<br>
&gt; +=C2=A0 =C2=A0 0x33, 0x31, 0x30, 0x30, 0x30, 0x30, 0x38, 0x36, 0x30, 0=
x35, 0x20, 0x06,<br>
&gt; +=C2=A0 =C2=A0 0x0c, 0x52, 0x33, 0x30, 0x39, 0x37, 0x47, 0x30, 0x30, 0=
x30, 0x32, 0x30,<br>
&gt; +=C2=A0 =C2=A0 0x37, 0x07, 0x0d, 0x42, 0x30, 0x32, 0x37, 0x34, 0x58, 0=
x58, 0x58, 0x58,<br>
&gt; +=C2=A0 =C2=A0 0x58, 0x58, 0x58, 0x58, 0x08, 0x01, 0x04, 0x09, 0x01, 0=
x00, 0x0a, 0x01,<br>
&gt; +=C2=A0 =C2=A0 0x00, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0=
x30, 0x32, 0x33,<br>
&gt; +=C2=A0 =C2=A0 0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0=
x0f, 0x03, 0x43,<br>
&gt; +=C2=A0 =C2=A0 0x54, 0x48, 0x13, 0x03, 0x42, 0x4d, 0x43, 0xfa, 0x02, 0=
xef, 0xba,<br>
&gt; +};<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0const size_t tiogapass_bmc_fruid_len =3D sizeof(tiogapass_=
bmc_fruid);<br>
&gt;=C2=A0 =C2=A0const size_t fby35_nic_fruid_len =3D sizeof(fby35_nic_frui=
d);<br>
&gt;=C2=A0 =C2=A0const size_t fby35_bb_fruid_len =3D sizeof(fby35_bb_fruid)=
;<br>
&gt; @@ -168,3 +215,6 @@ const size_t fby35_bmc_fruid_len =3D sizeof(fby35_=
bmc_fruid);<br>
&gt;=C2=A0 =C2=A0const size_t yosemitev2_bmc_fruid_len =3D sizeof(yosemitev=
2_bmc_fruid);<br>
&gt;=C2=A0 =C2=A0const size_t rainier_bb_fruid_len =3D sizeof(rainier_bb_fr=
uid);<br>
&gt;=C2=A0 =C2=A0const size_t rainier_bmc_fruid_len =3D sizeof(rainier_bmc_=
fruid);<br>
&gt; +const size_t montblanc_scm_fruid_len =3D sizeof(montblanc_scm_fruid);=
<br>
&gt; +const size_t montblanc_fcm_fruid_len =3D sizeof(montblanc_fcm_fruid);=
<br>
&gt; +const size_t montblanc_bmc_fruid_len =3D sizeof(montblanc_bmc_fruid);=
<br>
&gt; diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h<br>
&gt; index bbf9e54365..b8fbdd0734 100644<br>
&gt; --- a/hw/arm/aspeed_eeprom.h<br>
&gt; +++ b/hw/arm/aspeed_eeprom.h<br>
&gt; @@ -27,4 +27,11 @@ extern const size_t rainier_bb_fruid_len;<br>
&gt;=C2=A0 =C2=A0extern const uint8_t rainier_bmc_fruid[];<br>
&gt;=C2=A0 =C2=A0extern const size_t rainier_bmc_fruid_len;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +extern const uint8_t montblanc_scm_fruid[];<br>
&gt; +extern const uint8_t montblanc_fcm_fruid[];<br>
&gt; +extern const uint8_t montblanc_bmc_fruid[];<br>
&gt; +extern const size_t montblanc_scm_fruid_len;<br>
&gt; +extern const size_t montblanc_fcm_fruid_len;<br>
&gt; +extern const size_t montblanc_bmc_fruid_len;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#endif<br>
<br>
</blockquote></div>

--000000000000d27e5c05ffa93e3b--


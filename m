Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8762F74941B
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 05:17:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHFT2-0003sz-7I; Wed, 05 Jul 2023 23:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ssinprem@celestica.com>)
 id 1qHFSt-0003ri-UC
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 23:15:31 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ssinprem@celestica.com>)
 id 1qHFSp-0003Bc-EU
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 23:15:31 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-676cc97ca74so68472b3a.1
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 20:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=celestica.com; s=google-201810; t=1688613324; x=1691205324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tRERO4+Ln91swWbFSIbNJ9KyEnklxdGjq4wlj+dsfvU=;
 b=AS6BK/+idjVQq9QObCpAGfAWXBuDKM6LPd+fOQdclY2naLgQE0PPETBWg3jTBHgmu+
 eykj4/m536l+usvFnnBodw5h+VUZ2cQ8Fz0xD9iWCUfMN0naFFEKre40aDvjUjsq85iN
 MCD6nCD4eL7yKN54wILG8AcbVW20vQ6F3Ts4GWuGUkKxe9tFRAXD3oouO8vGgWor9dbf
 uKmkNL7YkocbFex7UoLlAFm0+WryMWR5dgZfwJxfl3pNoB25AkpCHRu9JXfn+fO5eJp9
 L7Zhv3xHfm665yEZM2pTfz1LBQd+aANgCBmpZ93AAJeAEjZWeoMFdj/uNnrkBM9mocMS
 lk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688613324; x=1691205324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tRERO4+Ln91swWbFSIbNJ9KyEnklxdGjq4wlj+dsfvU=;
 b=QDX9b1kJ1HRkssWP2HDTy1YD1pG9xe3exis4gBXsay2Y7iK8FXZqBep+mNyvSzJP0D
 PjfkF7YpuysoIfJgl2EyBpmD3SGFBkRSFcgqtLEstqkCElYyjQm8RE4GM7mtkM8jvjc9
 0gy+XyD0t1XF/EsdOObjFYWgx1Pgckvooi9C+olz9/NntPKYFNPn8T7qO/CuUqaJQOPf
 P2gL3/8G7iKcC2eyuRJ7057GuDBTc/TugtfCqPGvmlNb/47K3OBNQeNWgj/QGUTlV6So
 1eSnXgVnV1HFpCx18Zb5XI5g+BHWuxaPPKbmHzkAdb+Nkkhx1w3HuDNJrr2dmQ2WMlRd
 bO+g==
X-Gm-Message-State: ABy/qLZUPLdMASVh5guh02xlrY927JMqcj/UUjgwYHAlyfqs2qgC30s+
 A3lBI4rdsUN45Ii04B+b6eqNHj/GLnrZ7IHLx9ZRQ9meYNqL8mbsP11Mh5AuAwxdeznWxJk3YKF
 ae2PGnWodIEUH4dOj9UTHoBDex3XX1sNXswLBxa7Wn7XRtP9Xi6F+YWQFnFO/H6Yf1QHU4O3T+T
 Zawj8yosbothbv/dUV2Fwl4DYm8+PBTTMByw==
X-Google-Smtp-Source: APBJJlEM5zP8aYSEBgdXR4cRFigFsNN+dmR8ExNfN1v8j3IDgqj2qDpuz8Hfl/qnd8rA0+gKFc5JASVcPfqzF5QPugM=
X-Received: by 2002:a05:6a20:54a9:b0:12d:77e:ba3 with SMTP id
 i41-20020a056a2054a900b0012d077e0ba3mr1005975pzk.0.1688613323869; Wed, 05 Jul
 2023 20:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <168846918238.25928.7102858062933368556-0@git.sr.ht>
 <3cda00c1-54f8-57db-8992-3cafa97d4564@kaod.org>
 <CAE+aGtX9qcaPXhEYyqDuW_PLsKY9bVXhWiWb=oMT+5X-AXg3zg@mail.gmail.com>
 <ad5ea665-dce2-46d3-de14-558db8694eb5@kaod.org>
 <BY5PR15MB3555BD84850525E4FF17E086AF2FA@BY5PR15MB3555.namprd15.prod.outlook.com>
In-Reply-To: <BY5PR15MB3555BD84850525E4FF17E086AF2FA@BY5PR15MB3555.namprd15.prod.outlook.com>
From: Sittisak Sinprem <ssinprem@celestica.com>
Date: Thu, 6 Jul 2023 10:14:57 +0700
Message-ID: <CAE+aGtU6mbfDVD7uQ5izBncNH_KJfsL6=P0_qx7s2tMWPuA_+Q@mail.gmail.com>
Subject: Re: [PATCH qemu v5] aspeed add montblanc bmc reference from fuji
To: Mike Choi <mikechoi@meta.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Bin Huang <binhuang@meta.com>, Tao Ren <taoren@meta.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "andrew@aj.id.au" <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, 
 "srikanth@celestica.com" <srikanth@celestica.com>,
 "ssumet@celestica.com" <ssumet@celestica.com>, 
 "thangavelu.v@celestica.com" <thangavelu.v@celestica.com>, 
 "kgengan@celestica.com" <kgengan@celestica.com>, 
 "anandaramanv@celestica.com" <anandaramanv@celestica.com>
Content-Type: multipart/alternative; boundary="00000000000055762d05ffc8edd0"
X-CLS-Gapps: True
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: celesticainc,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=ssinprem@celestica.com; helo=mail-pf1-x435.google.com
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

--00000000000055762d05ffc8edd0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mike,

the FRUID data, it is used to define the BMC Mac address,
to able the CIT, test_eeprom, test_bmc_mac on Qemu.

On Thu, Jul 6, 2023 at 12:38=E2=80=AFAM Mike Choi <mikechoi@meta.com> wrote=
:

> Hi Sittisak,
>
>
>
> Minipack3 is not open-sourced yet, and we are unlikely to be able to
> upstream detailed data.
>
>
>
>    1. What is these FRUID datas for, is it for testing?
>    2. What other option do we have, since we are not able to upstream
>    FRUID data. (It is still OK to upstream system configuration, but NOT =
the
>    arrays of _fruid data array)
>
>
>
> Thanks,
>
> Mike
>
>
>
>
>
> *From: *C=C3=A9dric Le Goater <clg@kaod.org>
> *Date: *Tuesday, July 4, 2023 at 7:07 AM
> *To: *Sittisak Sinprem <ssinprem@celestica.com>, Bin Huang <
> binhuang@meta.com>, Tao Ren <taoren@meta.com>, Mike Choi <
> mikechoi@meta.com>
> *Cc: *qemu-devel@nongnu.org <qemu-devel@nongnu.org>, qemu-arm@nongnu.org =
<
> qemu-arm@nongnu.org>, peter.maydell@linaro.org <peter.maydell@linaro.org>=
,
> andrew@aj.id.au <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
> qemu-stable@nongnu.org <qemu-stable@nongnu.org>, srikanth@celestica.com <
> srikanth@celestica.com>, ssumet@celestica.com <ssumet@celefor stica.com>,
> thangavelu.v@celestica.com <thangavelu.v@celestica.com>,
> kgengan@celestica.com <kgengan@celestica.com>, anandaramanv@celestica.com
> <anandaramanv@celestica.com>
> *Subject: *Re: [PATCH qemu v5] aspeed add montblanc bmc reference from
> fuji
>
>
>
> On 7/4/23 15:27, Sittisak Sinprem wrote:
> > Hi Meta Team,
> >
> > the FRU EEPROM content, I think for now detail still be confidential,
> > Please confirm, Can we add the description in Qemu upstream following
> Cedric's request?
>
> We don't need all the details, and not the confidential part of course.
>
> C.
>
> >
> > On Tue, Jul 4, 2023 at 6:19=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.=
org <
> mailto:clg@kaod.org <clg@kaod.org>>> wrote:
> >
> >     On 7/4/23 13:06, ~ssinprem wrote:
> >      > From: Sittisak Sinprem <ssinprem@celestica.com <
> mailto:ssinprem@celestica.com <ssinprem@celestica.com>>>
> >      >
> >      > - I2C list follow I2C Tree v1.6 20230320
> >      > - fru eeprom data use FB FRU format version 4
> >      >
> >      > Signed-off-by: Sittisak Sinprem <ssinprem@celestica.com <
> mailto:ssinprem@celestica.com <ssinprem@celestica.com>>>
> >
> >     You shoot too fast :) Please add some description for the EEPROM
> contents.
> >     What they enable when the OS/FW boots is good to know for QEMU.
> >
> >     Thanks,
> >
> >     C.
> >
> >
> >      > ---
> >      >   docs/system/arm/aspeed.rst |  1 +
> >      >   hw/arm/aspeed.c            | 65
> ++++++++++++++++++++++++++++++++++++++
> >      >   hw/arm/aspeed_eeprom.c     | 50 +++++++++++++++++++++++++++++
> >      >   hw/arm/aspeed_eeprom.h     |  7 ++++
> >      >   4 files changed, 123 insertions(+)
> >      >
> >      > diff --git a/docs/system/arm/aspeed.rst
> b/docs/system/arm/aspeed.rst
> >      > index 80538422a1..5e0824f48b 100644
> >      > --- a/docs/system/arm/aspeed.rst
> >      > +++ b/docs/system/arm/aspeed.rst
> >      > @@ -33,6 +33,7 @@ AST2600 SoC based machines :
> >      >   - ``tacoma-bmc``           OpenPOWER Witherspoon POWER9 AST260=
0
> BMC
> >      >   - ``rainier-bmc``          IBM Rainier POWER10 BMC
> >      >   - ``fuji-bmc``             Facebook Fuji BMC
> >      > +- ``montblanc-bmc``        Facebook Montblanc BMC
> >      >   - ``bletchley-bmc``        Facebook Bletchley BMC
> >      >   - ``fby35-bmc``            Facebook fby35 BMC
> >      >   - ``qcom-dc-scm-v1-bmc``   Qualcomm DC-SCM V1 BMC
> >      > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> >      > index 9fca644d92..bbb7a3392c 100644
> >      > --- a/hw/arm/aspeed.c
> >      > +++ b/hw/arm/aspeed.c
> >      > @@ -189,6 +189,10 @@ struct AspeedMachineState {
> >      >   #define FUJI_BMC_HW_STRAP1    0x00000000
> >      >   #define FUJI_BMC_HW_STRAP2    0x00000000
> >      >
> >      > +/* Montblanc hardware value */
> >      > +#define MONTBLANC_BMC_HW_STRAP1    0x00000000
> >      > +#define MONTBLANC_BMC_HW_STRAP2    0x00000000
> >      > +
> >      >   /* Bletchley hardware value */
> >      >   /* TODO: Leave same as EVB for now. */
> >      >   #define BLETCHLEY_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
> >      > @@ -925,6 +929,41 @@ static void
> fuji_bmc_i2c_init(AspeedMachineState *bmc)
> >      >       }
> >      >   }
> >      >
> >      > +static void montblanc_bmc_i2c_init(AspeedMachineState *bmc)
> >      > +{
> >      > +    AspeedSoCState *soc =3D &bmc->soc;
> >      > +    I2CBus *i2c[16] =3D {};
> >      > +
> >      > +    for (int i =3D 0; i < 16; i++) {
> >      > +        i2c[i] =3D aspeed_i2c_get_bus(&soc->i2c, i);
> >      > +    }
> >      > +
> >      > +    /* Ref from Minipack3_I2C_Tree_V1.6 20230320 */
> >      > +    at24c_eeprom_init_rom(i2c[3], 0x56, 8192,
> montblanc_scm_fruid,
> >      > +                          montblanc_scm_fruid_len);
> >      > +    at24c_eeprom_init_rom(i2c[6], 0x53, 8192,
> montblanc_fcm_fruid,
> >      > +                          montblanc_fcm_fruid_len);
> >      > +
> >      > +    /* CPLD and FPGA */
> >      > +    at24c_eeprom_init(i2c[1], 0x35, 256);  /* SCM CPLD */
> >      > +    at24c_eeprom_init(i2c[5], 0x35, 256);  /* COMe CPLD TODO:
> need to update */
> >      > +    at24c_eeprom_init(i2c[12], 0x60, 256); /* MCB PWR CPLD */
> >      > +    at24c_eeprom_init(i2c[13], 0x35, 256); /* IOB FPGA */
> >      > +
> >      > +    /* on BMC board */
> >      > +    at24c_eeprom_init_rom(i2c[8], 0x51, 8192,
> montblanc_bmc_fruid,
> >      > +                          montblanc_bmc_fruid_len); /* BMC
> EEPROM */
> >      > +    i2c_slave_create_simple(i2c[8], TYPE_LM75, 0x48); /* Therma=
l
> Sensor */
> >      > +
> >      > +    /* COMe Sensor/EEPROM */
> >      > +    at24c_eeprom_init(i2c[0], 0x56, 16384);          /* FRU
> EEPROM */
> >      > +    i2c_slave_create_simple(i2c[0], TYPE_LM75, 0x48); /* INLET
> Sensor */
> >      > +    i2c_slave_create_simple(i2c[0], TYPE_LM75, 0x4A); /* OUTLET
> Sensor */
> >      > +
> >      > +    /* It expects a pca9555 but a pca9552 is compatible */
> >      > +    create_pca9552(soc, 4, 0x27);
> >      > +}
> >      > +
> >      >   #define TYPE_TMP421 "tmp421"
> >      >
> >      >   static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
> >      > @@ -1452,6 +1491,28 @@ static void
> aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
> >      >           aspeed_soc_num_cpus(amc->soc_name);
> >      >   };
> >      >
> >      > +#define MONTBLANC_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> >      > +
> >      > +static void aspeed_machine_montblanc_class_init(ObjectClass *oc=
,
> void *data)
> >      > +{
> >      > +    MachineClass *mc =3D MACHINE_CLASS(oc);
> >      > +    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);
> >      > +
> >      > +    mc->desc =3D "Facebook Montblanc BMC (Cortex-A7)";
> >      > +    amc->soc_name =3D "ast2600-a3";
> >      > +    amc->hw_strap1 =3D MONTBLANC_BMC_HW_STRAP1;
> >      > +    amc->hw_strap2 =3D MONTBLANC_BMC_HW_STRAP2;
> >      > +    amc->fmc_model =3D "mx66l1g45g";
> >      > +    amc->spi_model =3D "mx66l1g45g";
> >      > +    amc->num_cs =3D 2;
> >      > +    amc->macs_mask =3D ASPEED_MAC3_ON;
> >      > +    amc->i2c_init =3D montblanc_bmc_i2c_init;
> >      > +    amc->uart_default =3D ASPEED_DEV_UART1;
> >      > +    mc->default_ram_size =3D MONTBLANC_BMC_RAM_SIZE;
> >      > +    mc->default_cpus =3D mc->min_cpus =3D mc->max_cpus =3D
> >      > +        aspeed_soc_num_cpus(amc->soc_name);
> >      > +};
> >      > +
> >      >   #define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> >      >
> >      >   static void aspeed_machine_bletchley_class_init(ObjectClass
> *oc, void *data)
> >      > @@ -1703,6 +1764,10 @@ static const TypeInfo
> aspeed_machine_types[] =3D {
> >      >           .name          =3D MACHINE_TYPE_NAME("fuji-bmc"),
> >      >           .parent        =3D TYPE_ASPEED_MACHINE,
> >      >           .class_init    =3D aspeed_machine_fuji_class_init,
> >      > +    }, {
> >      > +        .name          =3D MACHINE_TYPE_NAME("montblanc-bmc"),
> >      > +        .parent        =3D TYPE_ASPEED_MACHINE,
> >      > +        .class_init    =3D aspeed_machine_montblanc_class_init,
> >      >       }, {
> >      >           .name          =3D MACHINE_TYPE_NAME("bletchley-bmc"),
> >      >           .parent        =3D TYPE_ASPEED_MACHINE,
> >      > diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c
> >      > index ace5266cec..8cc73f83dc 100644
> >      > --- a/hw/arm/aspeed_eeprom.c
> >      > +++ b/hw/arm/aspeed_eeprom.c
> >      > @@ -161,6 +161,53 @@ const uint8_t rainier_bmc_fruid[] =3D {
> >      >       0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
> >      >   };
> >      >
> >      > +/* Montblanc BMC FRU */
> >      > +const uint8_t montblanc_scm_fruid[] =3D {
> >      > +    0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49,
> 0x50, 0x41,
> >      > +    0x43, 0x4b, 0x33, 0x5f, 0x53, 0x43, 0x4d, 0x02, 0x08, 0x32,
> 0x30, 0x30,
> >      > +    0x30, 0x32, 0x39, 0x34, 0x35, 0x04, 0x0c, 0x31, 0x33, 0x32,
> 0x30, 0x30,
> >      > +    0x30, 0x31, 0x36, 0x34, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31,
> 0x33, 0x31,
> >      > +    0x30, 0x30, 0x30, 0x31, 0x32, 0x37, 0x30, 0x31, 0x20, 0x06,
> 0x0c, 0x52,
> >      > +    0x33, 0x32, 0x31, 0x34, 0x47, 0x30, 0x30, 0x30, 0x33, 0x30,
> 0x31, 0x07,
> >      > +    0x0d, 0x41, 0x30, 0x33, 0x31, 0x33, 0x58, 0x58, 0x58, 0x58,
> 0x58, 0x58,
> >      > +    0x58, 0x58, 0x08, 0x01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0x01,
> 0x00, 0x0b,
> >      > +    0x0d, 0x4d, 0x32, 0x32, 0x31, 0x33, 0x32, 0x33, 0x31, 0x37,
> 0x30, 0x30,
> >      > +    0x30, 0x32, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32,
> 0x30, 0x32,
> >      > +    0x33, 0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53,
> 0x0f, 0x03,
> >      > +    0x43, 0x54, 0x48, 0x10, 0x06, 0x01, 0x00, 0x00, 0x91, 0xdb,
> 0xb4, 0x13,
> >      > +    0x03, 0x53, 0x43, 0x4d, 0xfa, 0x02, 0x02, 0x61,
> >      > +};
> >      > +
> >      > +const uint8_t montblanc_fcm_fruid[] =3D {
> >      > +    0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49,
> 0x50, 0x41,
> >      > +    0x43, 0x4b, 0x33, 0x5f, 0x46, 0x43, 0x42, 0x02, 0x08, 0x33,
> 0x30, 0x30,
> >      > +    0x30, 0x30, 0x31, 0x36, 0x31, 0x04, 0x0c, 0x31, 0x33, 0x32,
> 0x30, 0x30,
> >      > +    0x30, 0x31, 0x36, 0x33, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31,
> 0x33, 0x31,
> >      > +    0x30, 0x30, 0x30, 0x31, 0x33, 0x30, 0x30, 0x31, 0x20, 0x06,
> 0x0c, 0x52,
> >      > +    0x33, 0x32, 0x31, 0x34, 0x47, 0x30, 0x30, 0x31, 0x32, 0x30,
> 0x31, 0x07,
> >      > +    0x0d, 0x41, 0x31, 0x32, 0x31, 0x32, 0x58, 0x58, 0x58, 0x58,
> 0x58, 0x58,
> >      > +    0x58, 0x58, 0x08, 0x01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0x01,
> 0x00, 0x0b,
> >      > +    0x0d, 0x46, 0x35, 0x30, 0x31, 0x33, 0x32, 0x33, 0x31, 0x37,
> 0x30, 0x30,
> >      > +    0x30, 0x35, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32,
> 0x30, 0x32,
> >      > +    0x33, 0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53,
> 0x0f, 0x03,
> >      > +    0x43, 0x54, 0x48, 0x10, 0x06, 0x02, 0x00, 0x00, 0x91, 0xdb,
> 0xb4, 0x11,
> >      > +    0x06, 0x03, 0x00, 0x00, 0x91, 0xdb, 0xb4, 0x12, 0x02, 0x8a,
> 0x00, 0x13,
> >      > +    0x03, 0x46, 0x43, 0x42, 0xfa, 0x02, 0x50, 0x47,
> >      > +};
> >      > +
> >      > +const uint8_t montblanc_bmc_fruid[] =3D {
> >      > +    0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49,
> 0x50, 0x41,
> >      > +    0x43, 0x4b, 0x33, 0x5f, 0x42, 0x4d, 0x43, 0x04, 0x0c, 0x31,
> 0x33, 0x32,
> >      > +    0x30, 0x30, 0x30, 0x31, 0x33, 0x36, 0x30, 0x31, 0x20, 0x05,
> 0x0c, 0x31,
> >      > +    0x33, 0x31, 0x30, 0x30, 0x30, 0x30, 0x38, 0x36, 0x30, 0x35,
> 0x20, 0x06,
> >      > +    0x0c, 0x52, 0x33, 0x30, 0x39, 0x37, 0x47, 0x30, 0x30, 0x30,
> 0x32, 0x30,
> >      > +    0x37, 0x07, 0x0d, 0x42, 0x30, 0x32, 0x37, 0x34, 0x58, 0x58,
> 0x58, 0x58,
> >      > +    0x58, 0x58, 0x58, 0x58, 0x08, 0x01, 0x04, 0x09, 0x01, 0x00,
> 0x0a, 0x01,
> >      > +    0x00, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30,
> 0x32, 0x33,
> >      > +    0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f,
> 0x03, 0x43,
> >      > +    0x54, 0x48, 0x13, 0x03, 0x42, 0x4d, 0x43, 0xfa, 0x02, 0xef,
> 0xba,
> >      > +};
> >      > +
> >      >   const size_t tiogapass_bmc_fruid_len =3D
> sizeof(tiogapass_bmc_fruid);
> >      >   const size_t fby35_nic_fruid_len =3D sizeof(fby35_nic_fruid);
> >      >   const size_t fby35_bb_fruid_len =3D sizeof(fby35_bb_fruid);
> >      > @@ -168,3 +215,6 @@ const size_t fby35_bmc_fruid_len =3D
> sizeof(fby35_bmc_fruid);
> >      >   const size_t yosemitev2_bmc_fruid_len =3D
> sizeof(yosemitev2_bmc_fruid);
> >      >   const size_t rainier_bb_fruid_len =3D sizeof(rainier_bb_fruid)=
;
> >      >   const size_t rainier_bmc_fruid_len =3D sizeof(rainier_bmc_frui=
d);
> >      > +const size_t montblanc_scm_fruid_len =3D
> sizeof(montblanc_scm_fruid);
> >      > +const size_t montblanc_fcm_fruid_len =3D
> sizeof(montblanc_fcm_fruid);
> >      > +const size_t montblanc_bmc_fruid_len =3D
> sizeof(montblanc_bmc_fruid);
> >      > diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h
> >      > index bbf9e54365..b8fbdd0734 100644
> >      > --- a/hw/arm/aspeed_eeprom.h
> >      > +++ b/hw/arm/aspeed_eeprom.h
> >      > @@ -27,4 +27,11 @@ extern const size_t rainier_bb_fruid_len;
> >      >   extern const uint8_t rainier_bmc_fruid[];
> >      >   extern const size_t rainier_bmc_fruid_len;
> >      >
> >      > +extern const uint8_t montblanc_scm_fruid[];
> >      > +extern const uint8_t montblanc_fcm_fruid[];
> >      > +extern const uint8_t montblanc_bmc_fruid[];
> >      > +extern const size_t montblanc_scm_fruid_len;
> >      > +extern const size_t montblanc_fcm_fruid_len;
> >      > +extern const size_t montblanc_bmc_fruid_len;
> >      > +
> >      >   #endif
> >
>

--00000000000055762d05ffc8edd0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:trebuche=
t ms,sans-serif;font-size:small;color:#134f5c">Hi Mike,<br><br>the FRUID da=
ta, it is used to=C2=A0define=C2=A0the BMC Mac address,<br>to able the CIT,=
 test_eeprom, test_bmc_mac on Qemu.<br></div></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 6, 2023 at 12:38=
=E2=80=AFAM Mike Choi &lt;<a href=3D"mailto:mikechoi@meta.com">mikechoi@met=
a.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div class=3D"msg3844594117212888856">





<div lang=3D"EN-US" style=3D"overflow-wrap: break-word;">
<div class=3D"m_3844594117212888856WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Hi Sittisak, <u></u><=
u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Minipack3 is not open=
-sourced yet, and we are unlikely to be able to upstream detailed data.<u><=
/u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt"><u></u>=C2=A0<u></u><=
/span></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"m_3844594117212888856MsoListParagraph">
<span style=3D"font-size:11pt">What is these FRUID datas for, is it for tes=
ting?<u></u><u></u></span></li><li class=3D"m_3844594117212888856MsoListPar=
agraph">
<span style=3D"font-size:11pt">What other option do we have, since we are n=
ot able to upstream FRUID data. (It is still OK to upstream system configur=
ation, but NOT the arrays of _fruid data array)<u></u><u></u></span></li></=
ol>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Thanks,<u></u><u></u>=
</span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt">Mike<u></u><u></u></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt"><u></u>=C2=A0<u></u><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11pt"><u></u>=C2=A0<u></u><=
/span></p>
<div id=3D"m_3844594117212888856mail-editor-reference-message-container">
<div>
<div style=3D"border-right:none;border-bottom:none;border-left:none;border-=
top:1pt solid rgb(181,196,223);padding:3pt 0in 0in">
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><b><span style=3D"font-=
size:12pt;color:black">From:
</span></b><span style=3D"font-size:12pt;color:black">C=C3=A9dric Le Goater=
 &lt;<a href=3D"mailto:clg@kaod.org" target=3D"_blank">clg@kaod.org</a>&gt;=
<br>
<b>Date: </b>Tuesday, July 4, 2023 at 7:07 AM<br>
<b>To: </b>Sittisak Sinprem &lt;<a href=3D"mailto:ssinprem@celestica.com" t=
arget=3D"_blank">ssinprem@celestica.com</a>&gt;, Bin Huang &lt;<a href=3D"m=
ailto:binhuang@meta.com" target=3D"_blank">binhuang@meta.com</a>&gt;, Tao R=
en &lt;<a href=3D"mailto:taoren@meta.com" target=3D"_blank">taoren@meta.com=
</a>&gt;, Mike Choi &lt;<a href=3D"mailto:mikechoi@meta.com" target=3D"_bla=
nk">mikechoi@meta.com</a>&gt;<br>
<b>Cc: </b><a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-=
devel@nongnu.org</a> &lt;<a href=3D"mailto:qemu-devel@nongnu.org" target=3D=
"_blank">qemu-devel@nongnu.org</a>&gt;, <a href=3D"mailto:qemu-arm@nongnu.o=
rg" target=3D"_blank">qemu-arm@nongnu.org</a> &lt;<a href=3D"mailto:qemu-ar=
m@nongnu.org" target=3D"_blank">qemu-arm@nongnu.org</a>&gt;, <a href=3D"mai=
lto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a=
> &lt;<a href=3D"mailto:peter.maydell@linaro.org" target=3D"_blank">peter.m=
aydell@linaro.org</a>&gt;, <a href=3D"mailto:andrew@aj.id.au" target=3D"_bl=
ank">andrew@aj.id.au</a> &lt;<a href=3D"mailto:andrew@aj.id.au" target=3D"_=
blank">andrew@aj.id.au</a>&gt;, Joel Stanley &lt;<a href=3D"mailto:joel@jms=
.id.au" target=3D"_blank">joel@jms.id.au</a>&gt;, <a href=3D"mailto:qemu-st=
able@nongnu.org" target=3D"_blank">qemu-stable@nongnu.org</a> &lt;<a href=
=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable@nongnu.org=
</a>&gt;,
 <a href=3D"mailto:srikanth@celestica.com" target=3D"_blank">srikanth@celes=
tica.com</a> &lt;<a href=3D"mailto:srikanth@celestica.com" target=3D"_blank=
">srikanth@celestica.com</a>&gt;, <a href=3D"mailto:ssumet@celestica.com" t=
arget=3D"_blank">ssumet@celestica.com</a> &lt;ssumet@cele</span><span style=
=3D"font-size:12pt">for
<span style=3D"color:black"><a href=3D"http://stica.com" target=3D"_blank">=
stica.com</a>&gt;, <a href=3D"mailto:thangavelu.v@celestica.com" target=3D"=
_blank">thangavelu.v@celestica.com</a> &lt;<a href=3D"mailto:thangavelu.v@c=
elestica.com" target=3D"_blank">thangavelu.v@celestica.com</a>&gt;, <a href=
=3D"mailto:kgengan@celestica.com" target=3D"_blank">kgengan@celestica.com</=
a> &lt;<a href=3D"mailto:kgengan@celestica.com" target=3D"_blank">kgengan@c=
elestica.com</a>&gt;, <a href=3D"mailto:anandaramanv@celestica.com" target=
=3D"_blank">anandaramanv@celestica.com</a> &lt;<a href=3D"mailto:anandarama=
nv@celestica.com" target=3D"_blank">anandaramanv@celestica.com</a>&gt;<br>
<b>Subject: </b>Re: [PATCH qemu v5] aspeed add montblanc bmc reference from=
 fuji<u></u><u></u></span></span></p>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12pt"><span style=3D"font-siz=
e:11pt"><br>
<br>
On 7/4/23 15:27, Sittisak Sinprem wrote:<br>
&gt; Hi=C2=A0Meta Team,<br>
&gt; <br>
&gt; the FRU EEPROM content, I think for now detail still be=C2=A0confident=
ial,<br>
&gt; Please confirm, Can we add the description in Qemu upstream=C2=A0follo=
wing Cedric&#39;s request?<br>
<br>
We don&#39;t need all the details, and not the confidential part of course.=
<br>
<br>
C.<br>
<br>
&gt; <br>
&gt; On Tue, Jul 4, 2023 at 6:19=E2=80=AFPM C=C3=A9dric Le Goater &lt;<a hr=
ef=3D"mailto:clg@kaod.org" target=3D"_blank">clg@kaod.org</a> &lt;<a href=
=3D"mailto:clg@kaod.org" target=3D"_blank">mailto:clg@kaod.org</a>&gt;&gt; =
wrote:<br>
&gt; <br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 On 7/4/23 13:06, ~ssinprem wrote:<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; From: Sittisak Sinprem &lt;<a href=
=3D"mailto:ssinprem@celestica.com" target=3D"_blank">ssinprem@celestica.com=
</a> &lt;<a href=3D"mailto:ssinprem@celestica.com" target=3D"_blank">mailto=
:ssinprem@celestica.com</a>&gt;&gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; - I2C list follow I2C Tree v1.6 202=
30320<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; - fru eeprom data use FB FRU format=
 version 4<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; Signed-off-by: Sittisak Sinprem &lt=
;<a href=3D"mailto:ssinprem@celestica.com" target=3D"_blank">ssinprem@celes=
tica.com</a> &lt;<a href=3D"mailto:ssinprem@celestica.com" target=3D"_blank=
">mailto:ssinprem@celestica.com</a>&gt;&gt;<br>
&gt; <br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 You shoot too fast :) Please add some descript=
ion for the EEPROM contents.<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 What they enable when the OS/FW boots is good =
to know for QEMU.<br>
&gt; <br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 Thanks,<br>
&gt; <br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0 C.<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; ---<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0docs/system/arm/aspeed.=
rst |=C2=A0 1 +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0hw/arm/aspeed.c=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 65 +++++++++++++++++++++++++++++++++++=
+++<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0hw/arm/aspeed_eeprom.c=
=C2=A0 =C2=A0 =C2=A0| 50 +++++++++++++++++++++++++++++<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0hw/arm/aspeed_eeprom.h=
=C2=A0 =C2=A0 =C2=A0|=C2=A0 7 ++++<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A04 files changed, 123 in=
sertions(+)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; diff --git a/docs/system/arm/aspeed=
.rst b/docs/system/arm/aspeed.rst<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; index 80538422a1..5e0824f48b 100644=
<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; --- a/docs/system/arm/aspeed.rst<br=
>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +++ b/docs/system/arm/aspeed.rst<br=
>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; @@ -33,6 +33,7 @@ AST2600 SoC based=
 machines :<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0- ``tacoma-bmc``=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OpenPOWER Witherspoon POWER9 AST2600 BMC<=
br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0- ``rainier-bmc``=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IBM Rainier POWER10 BMC<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0- ``fuji-bmc``=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Facebook Fuji BMC<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +- ``montblanc-bmc``=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 Facebook Montblanc BMC<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0- ``bletchley-bmc``=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Facebook Bletchley BMC<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0- ``fby35-bmc``=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Facebook fby35 BMC<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0- ``qcom-dc-scm-v1-bmc`=
`=C2=A0 =C2=A0Qualcomm DC-SCM V1 BMC<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; diff --git a/hw/arm/aspeed.c b/hw/a=
rm/aspeed.c<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; index 9fca644d92..bbb7a3392c 100644=
<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; --- a/hw/arm/aspeed.c<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +++ b/hw/arm/aspeed.c<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; @@ -189,6 +189,10 @@ struct AspeedM=
achineState {<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0#define FUJI_BMC_HW_STR=
AP1=C2=A0 =C2=A0 0x00000000<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0#define FUJI_BMC_HW_STR=
AP2=C2=A0 =C2=A0 0x00000000<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +/* Montblanc hardware value */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +#define MONTBLANC_BMC_HW_STRAP1=C2=
=A0 =C2=A0 0x00000000<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +#define MONTBLANC_BMC_HW_STRAP2=C2=
=A0 =C2=A0 0x00000000<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0/* Bletchley hardware v=
alue */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0/* TODO: Leave same as =
EVB for now. */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0#define BLETCHLEY_BMC_H=
W_STRAP1 AST2600_EVB_HW_STRAP1<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; @@ -925,6 +929,41 @@ static void fu=
ji_bmc_i2c_init(AspeedMachineState *bmc)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +static void montblanc_bmc_i2c_init=
(AspeedMachineState *bmc)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +{<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 AspeedSoCState *soc =
=3D &amp;bmc-&gt;soc;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 I2CBus *i2c[16] =3D =
{};<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 for (int i =3D 0; i =
&lt; 16; i++) {<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c[i]=
 =3D aspeed_i2c_get_bus(&amp;soc-&gt;i2c, i);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 /* Ref from Minipack=
3_I2C_Tree_V1.6 20230320 */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 at24c_eeprom_init_ro=
m(i2c[3], 0x56, 8192, montblanc_scm_fruid,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 montblanc_scm_frui=
d_len);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 at24c_eeprom_init_ro=
m(i2c[6], 0x53, 8192, montblanc_fcm_fruid,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 montblanc_fcm_frui=
d_len);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 /* CPLD and FPGA */<=
br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 at24c_eeprom_init(i2=
c[1], 0x35, 256);=C2=A0 /* SCM CPLD */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 at24c_eeprom_init(i2=
c[5], 0x35, 256);=C2=A0 /* COMe CPLD TODO: need to update */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 at24c_eeprom_init(i2=
c[12], 0x60, 256); /* MCB PWR CPLD */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 at24c_eeprom_init(i2=
c[13], 0x35, 256); /* IOB FPGA */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 /* on BMC board */<b=
r>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 at24c_eeprom_init_ro=
m(i2c[8], 0x51, 8192, montblanc_bmc_fruid,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 montblanc_bmc_frui=
d_len); /* BMC EEPROM */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 i2c_slave_create_sim=
ple(i2c[8], TYPE_LM75, 0x48); /* Thermal Sensor */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 /* COMe Sensor/EEPRO=
M */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 at24c_eeprom_init(i2=
c[0], 0x56, 16384);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* FRU EEPROM */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 i2c_slave_create_sim=
ple(i2c[0], TYPE_LM75, 0x48); /* INLET Sensor */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 i2c_slave_create_sim=
ple(i2c[0], TYPE_LM75, 0x4A); /* OUTLET Sensor */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 /* It expects a pca9=
555 but a pca9552 is compatible */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 create_pca9552(soc, =
4, 0x27);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +}<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0#define TYPE_TMP421 &qu=
ot;tmp421&quot;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0static void bletchley_b=
mc_i2c_init(AspeedMachineState *bmc)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; @@ -1452,6 +1491,28 @@ static void =
aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0aspeed_soc_num_cpus(amc-&gt;soc_name);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +#define MONTBLANC_BMC_RAM_SIZE ASP=
EED_RAM_SIZE(2 * GiB)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +static void aspeed_machine_montbla=
nc_class_init(ObjectClass *oc, void *data)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +{<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 MachineClass *mc =3D=
 MACHINE_CLASS(oc);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 AspeedMachineClass *=
amc =3D ASPEED_MACHINE_CLASS(oc);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;desc =3D &quo=
t;Facebook Montblanc BMC (Cortex-A7)&quot;;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 amc-&gt;soc_name =3D=
 &quot;ast2600-a3&quot;;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 amc-&gt;hw_strap1 =
=3D MONTBLANC_BMC_HW_STRAP1;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 amc-&gt;hw_strap2 =
=3D MONTBLANC_BMC_HW_STRAP2;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 amc-&gt;fmc_model =
=3D &quot;mx66l1g45g&quot;;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 amc-&gt;spi_model =
=3D &quot;mx66l1g45g&quot;;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 amc-&gt;num_cs =3D 2=
;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 amc-&gt;macs_mask =
=3D ASPEED_MAC3_ON;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 amc-&gt;i2c_init =3D=
 montblanc_bmc_i2c_init;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 amc-&gt;uart_default=
 =3D ASPEED_DEV_UART1;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;default_ram_s=
ize =3D MONTBLANC_BMC_RAM_SIZE;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 mc-&gt;default_cpus =
=3D mc-&gt;min_cpus =3D mc-&gt;max_cpus =3D<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 aspeed=
_soc_num_cpus(amc-&gt;soc_name);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +};<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0#define BLETCHLEY_BMC_R=
AM_SIZE ASPEED_RAM_SIZE(2 * GiB)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0static void aspeed_mach=
ine_bletchley_class_init(ObjectClass *oc, void *data)<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; @@ -1703,6 +1764,10 @@ static const=
 TypeInfo aspeed_machine_types[] =3D {<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D MACHINE_TYPE_NAME(&quot;f=
uji-bmc&quot;),<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_ASPEED_MACHINE,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.class_init=C2=A0 =C2=A0 =3D aspeed_machine_fuji_class_init,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 }, {<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D MACHINE_TYPE_NAME(&quot;montblanc-bm=
c&quot;),<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .paren=
t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_ASPEED_MACHINE,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class=
_init=C2=A0 =C2=A0 =3D aspeed_machine_montblanc_class_init,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}, {<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D MACHINE_TYPE_NAME(&quot;b=
letchley-bmc&quot;),<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_ASPEED_MACHINE,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; diff --git a/hw/arm/aspeed_eeprom.c=
 b/hw/arm/aspeed_eeprom.c<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; index ace5266cec..8cc73f83dc 100644=
<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; --- a/hw/arm/aspeed_eeprom.c<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +++ b/hw/arm/aspeed_eeprom.c<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; @@ -161,6 +161,53 @@ const uint8_t =
rainier_bmc_fruid[] =3D {<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A00x31, 0x5=
0, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +/* Montblanc BMC FRU */<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +const uint8_t montblanc_scm_fruid[=
] =3D {<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0xfb, 0xfb, 0x04, 0x=
ff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50, 0x41,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x43, 0x4b, 0x33, 0x=
5f, 0x53, 0x43, 0x4d, 0x02, 0x08, 0x32, 0x30, 0x30,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x30, 0x32, 0x39, 0x=
34, 0x35, 0x04, 0x0c, 0x31, 0x33, 0x32, 0x30, 0x30,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x30, 0x31, 0x36, 0x=
34, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31, 0x33, 0x31,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x30, 0x30, 0x30, 0x=
31, 0x32, 0x37, 0x30, 0x31, 0x20, 0x06, 0x0c, 0x52,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x33, 0x32, 0x31, 0x=
34, 0x47, 0x30, 0x30, 0x30, 0x33, 0x30, 0x31, 0x07,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x0d, 0x41, 0x30, 0x=
33, 0x31, 0x33, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x58, 0x58, 0x08, 0x=
01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0x01, 0x00, 0x0b,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x0d, 0x4d, 0x32, 0x=
32, 0x31, 0x33, 0x32, 0x33, 0x31, 0x37, 0x30, 0x30,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x30, 0x32, 0x0c, 0x=
03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30, 0x32,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x33, 0x30, 0x35, 0x=
30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f, 0x03,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x43, 0x54, 0x48, 0x=
10, 0x06, 0x01, 0x00, 0x00, 0x91, 0xdb, 0xb4, 0x13,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x03, 0x53, 0x43, 0x=
4d, 0xfa, 0x02, 0x02, 0x61,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +};<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +const uint8_t montblanc_fcm_fruid[=
] =3D {<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0xfb, 0xfb, 0x04, 0x=
ff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50, 0x41,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x43, 0x4b, 0x33, 0x=
5f, 0x46, 0x43, 0x42, 0x02, 0x08, 0x33, 0x30, 0x30,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x30, 0x30, 0x31, 0x=
36, 0x31, 0x04, 0x0c, 0x31, 0x33, 0x32, 0x30, 0x30,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x30, 0x31, 0x36, 0x=
33, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31, 0x33, 0x31,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x30, 0x30, 0x30, 0x=
31, 0x33, 0x30, 0x30, 0x31, 0x20, 0x06, 0x0c, 0x52,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x33, 0x32, 0x31, 0x=
34, 0x47, 0x30, 0x30, 0x31, 0x32, 0x30, 0x31, 0x07,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x0d, 0x41, 0x31, 0x=
32, 0x31, 0x32, 0x58, 0x58, 0x58, 0x58, 0x58, 0x58,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x58, 0x58, 0x08, 0x=
01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0x01, 0x00, 0x0b,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x0d, 0x46, 0x35, 0x=
30, 0x31, 0x33, 0x32, 0x33, 0x31, 0x37, 0x30, 0x30,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x30, 0x35, 0x0c, 0x=
03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30, 0x32,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x33, 0x30, 0x35, 0x=
30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f, 0x03,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x43, 0x54, 0x48, 0x=
10, 0x06, 0x02, 0x00, 0x00, 0x91, 0xdb, 0xb4, 0x11,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x06, 0x03, 0x00, 0x=
00, 0x91, 0xdb, 0xb4, 0x12, 0x02, 0x8a, 0x00, 0x13,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x03, 0x46, 0x43, 0x=
42, 0xfa, 0x02, 0x50, 0x47,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +};<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +const uint8_t montblanc_bmc_fruid[=
] =3D {<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0xfb, 0xfb, 0x04, 0x=
ff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50, 0x41,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x43, 0x4b, 0x33, 0x=
5f, 0x42, 0x4d, 0x43, 0x04, 0x0c, 0x31, 0x33, 0x32,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x30, 0x30, 0x30, 0x=
31, 0x33, 0x36, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x33, 0x31, 0x30, 0x=
30, 0x30, 0x30, 0x38, 0x36, 0x30, 0x35, 0x20, 0x06,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x0c, 0x52, 0x33, 0x=
30, 0x39, 0x37, 0x47, 0x30, 0x30, 0x30, 0x32, 0x30,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x37, 0x07, 0x0d, 0x=
42, 0x30, 0x32, 0x37, 0x34, 0x58, 0x58, 0x58, 0x58,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x58, 0x58, 0x58, 0x=
58, 0x08, 0x01, 0x04, 0x09, 0x01, 0x00, 0x0a, 0x01,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x00, 0x0c, 0x03, 0x=
43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30, 0x32, 0x33,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x30, 0x35, 0x30, 0x=
31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f, 0x03, 0x43,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +=C2=A0 =C2=A0 0x54, 0x48, 0x13, 0x=
03, 0x42, 0x4d, 0x43, 0xfa, 0x02, 0xef, 0xba,<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +};<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0const size_t tiogapass_=
bmc_fruid_len =3D sizeof(tiogapass_bmc_fruid);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0const size_t fby35_nic_=
fruid_len =3D sizeof(fby35_nic_fruid);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0const size_t fby35_bb_f=
ruid_len =3D sizeof(fby35_bb_fruid);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; @@ -168,3 +215,6 @@ const size_t fb=
y35_bmc_fruid_len =3D sizeof(fby35_bmc_fruid);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0const size_t yosemitev2=
_bmc_fruid_len =3D sizeof(yosemitev2_bmc_fruid);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0const size_t rainier_bb=
_fruid_len =3D sizeof(rainier_bb_fruid);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0const size_t rainier_bm=
c_fruid_len =3D sizeof(rainier_bmc_fruid);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +const size_t montblanc_scm_fruid_l=
en =3D sizeof(montblanc_scm_fruid);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +const size_t montblanc_fcm_fruid_l=
en =3D sizeof(montblanc_fcm_fruid);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +const size_t montblanc_bmc_fruid_l=
en =3D sizeof(montblanc_bmc_fruid);<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; diff --git a/hw/arm/aspeed_eeprom.h=
 b/hw/arm/aspeed_eeprom.h<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; index bbf9e54365..b8fbdd0734 100644=
<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; --- a/hw/arm/aspeed_eeprom.h<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +++ b/hw/arm/aspeed_eeprom.h<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; @@ -27,4 +27,11 @@ extern const siz=
e_t rainier_bb_fruid_len;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0extern const uint8_t ra=
inier_bmc_fruid[];<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0extern const size_t rai=
nier_bmc_fruid_len;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +extern const uint8_t montblanc_scm=
_fruid[];<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +extern const uint8_t montblanc_fcm=
_fruid[];<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +extern const uint8_t montblanc_bmc=
_fruid[];<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +extern const size_t montblanc_scm_=
fruid_len;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +extern const size_t montblanc_fcm_=
fruid_len;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +extern const size_t montblanc_bmc_=
fruid_len;<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt; +<br>
&gt;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0#endif<br>
&gt; <u></u><u></u></span></p>
</div>
</div>
</div>
</div>
</div>

</div></blockquote></div>

--00000000000055762d05ffc8edd0--


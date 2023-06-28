Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0E5740E38
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 12:08:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qES5e-0001oa-4v; Wed, 28 Jun 2023 06:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ssinprem@celestica.com>)
 id 1qES5a-0001Om-Vf
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 06:07:55 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ssinprem@celestica.com>)
 id 1qES5T-0007Oh-UZ
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 06:07:51 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-25eabe8b5fcso963122a91.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=celestica.com; s=google-201810; t=1687946865; x=1690538865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4ORAG6ii/Knbxhx4iTB8xYsgPRAW1+bI6hIwN4Dbcz4=;
 b=TxTspFz91bucCMm484R+AvFQOdwPPpzGDqriTqBR4iQCFeWF7o+Jcif/KTy+7yLQ8C
 vgfOuNmzazdqOVYMg79Pn1pbFAXbr+9sVc8RnLeBf1ZR4yzL2VQAF9qDuYnQo0QeHXGh
 WXdWgdiMSDWDGYPMApNN6/ogRf/0O5Uj0ON6SSilpOf7z2QqMBRgeV7rFEyTXBRxmVk1
 j5rFYXKUL1JKEFDrmYfdk6UrLPRl3eTTKvl3ZnoJXgygiFP1xRyhw8FkgNstM3WdY3zO
 ATvS2nOX7EE2AK6kcGZVhAuH26r36RjiBZLSsqC+6iBE01YghiDSwvwfmlmQRWo+emkx
 a1sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687946865; x=1690538865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ORAG6ii/Knbxhx4iTB8xYsgPRAW1+bI6hIwN4Dbcz4=;
 b=dUzTQOMKDgvMy4EIhG1jMiAu2P0KFkukp19EPxMj3SHXX9qxnbM0DRLwHmbmOflrMo
 LKd1IUDBGxuRvbAs5eZZ1FKLfwlvyC1lxnRO0QgrViztc4Ky3jGs+R5HW4ek26kTGNON
 X92O5GqONQH4hoNxmdmApnoTAJEMlvOhJTMejM4rcrnz6kMHKRhPfTixmGabo5/N81rF
 MKDtJnMKp71dGaFMnZY9k8x+bylSe3qBBPcFnbWMLRC13ZpyTW1Qn/AadYWRjnwujGU5
 obV3hw6UeyNOpU5F9Dd9x6aoA7eZmJV8Yt0gZ+ga8ud0EVdep2kZ2BdN6EHZ6SYvSNJg
 x+jw==
X-Gm-Message-State: AC+VfDyXsRQrYGeiV6gZnTV4MpIc/sKYQZkyeyRrdNbM6yOr26jiYpMU
 6A7xtNJ1m1707tUwvvUJWna+bY+UQ+70WbWSVHdxcOC4TcgrOWoo1yCeXTfCpgJ7iiBuRxP26TQ
 ClExVoRUNjXTq9eXUWAvX4Mtc7UuG+gBsDczkunCUFqEfGJZRWwRnuuHRrnxnZpNvOuX82FqGQ2
 OlXXJ2f43CInkJsmUexeqQ8DtWLsImC7qTyg==
X-Google-Smtp-Source: ACHHUZ7ZSadrk9GJhHwqVnGCCdXiAEQ2hfTTw9stxvUemPCKGdBlUE/fRxYZ4bP8druewohtTbzAchn4LgCtXTC64YI=
X-Received: by 2002:a17:90b:3583:b0:263:2312:60c2 with SMTP id
 mm3-20020a17090b358300b00263231260c2mr3659545pjb.3.1687946864691; Wed, 28 Jun
 2023 03:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <168794501779.28884.3336012012258765799-0@git.sr.ht>
 <cd38a154-d5c3-1e22-c94f-9e1d74069f6b@kaod.org>
In-Reply-To: <cd38a154-d5c3-1e22-c94f-9e1d74069f6b@kaod.org>
From: Sittisak Sinprem <ssinprem@celestica.com>
Date: Wed, 28 Jun 2023 17:07:17 +0700
Message-ID: <CAE+aGtVDXtPbZxC-OJvQ0R+dOk0S=_gx+0wfyJ+wbA_xn=NLMg@mail.gmail.com>
Subject: Re: [PATCH qemu] aspeed add montblanc bmc reference from fuji
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, 
 andrew@aj.id.au, srikanth@celestica.com, ssumet@celestica.com, 
 thangavelu.v@celestica.com, kgengan@celestica.com, anandaramanv@celestica.com, 
 Joel Stanley <joel@jms.id.au>
Content-Type: multipart/alternative; boundary="00000000000045949d05ff2dc12e"
X-CLS-Gapps: True
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: celesticainc,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=ssinprem@celestica.com; helo=mail-pj1-x1034.google.com
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

--00000000000045949d05ff2dc12e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it Cedric, I just know for it,

I am fixing, and will re-send the patch as V2.

On Wed, Jun 28, 2023 at 5:04=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:

> Hello Sittisak,
>
> On 6/28/23 11:09, ~ssinprem wrote:
> > From: Sittisak Sinprem <ssinprem@celestica.com>
> >
> > - I2C list follow I2C Tree v1.6 20230320
> > - fru eeprom data use FB FRU format version 4
> >
> > Signed-off-by: Sittisak Sinprem <ssinprem@celestica.com>
>
>
> You don't need to cc: qemu-stable@nongnu.org for new machines.
>
> > ---
> >   hw/arm/aspeed.c        | 67 +++++++++++++++++++++++++++++++++++++++++=
+
> >   hw/arm/aspeed_eeprom.c | 50 +++++++++++++++++++++++++++++++
> >   hw/arm/aspeed_eeprom.h |  7 +++++
> >   3 files changed, 124 insertions(+)
> >
> > diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> > index 6880998484..df154cbf52 100644
> > --- a/hw/arm/aspeed.c
> > +++ b/hw/arm/aspeed.c
> > @@ -182,6 +182,10 @@ struct AspeedMachineState {
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
> > @@ -918,6 +922,39 @@ static void fuji_bmc_i2c_init(AspeedMachineState
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
> > +    at24c_eeprom_init(i2c[3], 0x56, montblanc_scm_fruid, 8192, true);
>
> I think you meant to use at24c_eeprom_init_rom ?
>
> Thanks,
>
> C.
>
> > +    at24c_eeprom_init(i2c[6], 0x53, montblanc_fcm_fruid, 8192, true);
> > +
> > +    /* CPLD and FPGA */
> > +    aspeed_eeprom_init(i2c[1], 0x35, 256);  /* SCM CPLD */
> > +    aspeed_eeprom_init(i2c[5], 0x35, 256);  /* COMe CPLD TODO: need to
> update */
> > +    aspeed_eeprom_init(i2c[12], 0x60, 256); /* MCB PWR CPLD */
> > +    aspeed_eeprom_init(i2c[13], 0x35, 256); /* IOB FPGA */
> > +
> > +    /* on BMC board */
> > +    at24c_eeprom_init(i2c[8], 0x51, montblanc_bmc_fruid, 8192, true);
> > +                                                      /* BMC EEPROM */
> > +    i2c_slave_create_simple(i2c[8], TYPE_LM75, 0x48); /* Thermal Senso=
r
> */
> > +
> > +    /* COMe Sensor/EEPROM */
> > +    aspeed_eeprom_init(i2c[0], 0x56, 16384);          /* FRU EEPROM */
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
> > @@ -1450,6 +1487,32 @@ static void
> aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
> >           aspeed_soc_num_cpus(amc->soc_name);
> >   };
> >
> > +/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
> > +#if HOST_LONG_BITS =3D=3D 32
> > +#define MONTBLANC_BMC_RAM_SIZE (1 * GiB)
> > +#else
> > +#define MONTBLANC_BMC_RAM_SIZE (2 * GiB)
> > +#endif
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
> >   /* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */
> >   #if HOST_LONG_BITS =3D=3D 32
> >   #define BLETCHLEY_BMC_RAM_SIZE (1 * GiB)
> > @@ -1706,6 +1769,10 @@ static const TypeInfo aspeed_machine_types[] =3D=
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
> > index ace5266cec..bcde346e9b 100644
> > --- a/hw/arm/aspeed_eeprom.c
> > +++ b/hw/arm/aspeed_eeprom.c
> > @@ -161,6 +161,53 @@ const uint8_t rainier_bmc_fruid[] =3D {
> >       0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
> >   };
> >
> > +/* Montblanc BMC FRU */
> > +const uint8_t montblanc_scm_fruid[8192] =3D {
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
> > +    0x43, 0x54, 0x48, 0x10, 0x06, 0xb4, 0xbd, 0x00, 0x00, 0x00, 0x01,
> 0x13,
> > +    0x03, 0x53, 0x43, 0x4d, 0xfa, 0x02, 0x11, 0x07,
> > +};
> > +
> > +const uint8_t montblanc_fcm_fruid[8192] =3D {
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
> > +    0x43, 0x54, 0x48, 0x10, 0x06, 0xb4, 0xbd, 0x00, 0x00, 0x00, 0x02,
> 0x11,
> > +    0x06, 0xb4, 0xbd, 0x00, 0x00, 0x00, 0x03, 0x12, 0x02, 0x8a, 0x00,
> 0x13,
> > +    0x03, 0x46, 0x43, 0x42, 0xfa, 0x02, 0x0e, 0x61,
> > +};
> > +
> > +const uint8_t montblanc_bmc_fruid[8192] =3D {
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

--00000000000045949d05ff2dc12e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:trebuche=
t ms,sans-serif;font-size:small;color:#134f5c">Got it Cedric, I just know f=
or it,<br><br>I am fixing, and will re-send the patch as V2.</div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, J=
un 28, 2023 at 5:04=E2=80=AFPM C=C3=A9dric Le Goater &lt;<a href=3D"mailto:=
clg@kaod.org">clg@kaod.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Hello Sittisak,<br>
<br>
On 6/28/23 11:09, ~ssinprem wrote:<br>
&gt; From: Sittisak Sinprem &lt;<a href=3D"mailto:ssinprem@celestica.com" t=
arget=3D"_blank">ssinprem@celestica.com</a>&gt;<br>
&gt; <br>
&gt; - I2C list follow I2C Tree v1.6 20230320<br>
&gt; - fru eeprom data use FB FRU format version 4<br>
&gt; <br>
&gt; Signed-off-by: Sittisak Sinprem &lt;<a href=3D"mailto:ssinprem@celesti=
ca.com" target=3D"_blank">ssinprem@celestica.com</a>&gt;<br>
<br>
<br>
You don&#39;t need to cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=
=3D"_blank">qemu-stable@nongnu.org</a> for new machines.<br>
<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/arm/aspeed.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 67 ++++++++++=
++++++++++++++++++++++++++++++++<br>
&gt;=C2=A0 =C2=A0hw/arm/aspeed_eeprom.c | 50 ++++++++++++++++++++++++++++++=
+<br>
&gt;=C2=A0 =C2=A0hw/arm/aspeed_eeprom.h |=C2=A0 7 +++++<br>
&gt;=C2=A0 =C2=A03 files changed, 124 insertions(+)<br>
&gt; <br>
&gt; diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c<br>
&gt; index 6880998484..df154cbf52 100644<br>
&gt; --- a/hw/arm/aspeed.c<br>
&gt; +++ b/hw/arm/aspeed.c<br>
&gt; @@ -182,6 +182,10 @@ struct AspeedMachineState {<br>
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
&gt; @@ -918,6 +922,39 @@ static void fuji_bmc_i2c_init(AspeedMachineState =
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
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(i2c[3], 0x56, montblanc_scm_fruid, 81=
92, true);<br>
<br>
I think you meant to use at24c_eeprom_init_rom ?<br>
<br>
Thanks,<br>
<br>
C.<br>
<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(i2c[6], 0x53, montblanc_fcm_fruid, 81=
92, true);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* CPLD and FPGA */<br>
&gt; +=C2=A0 =C2=A0 aspeed_eeprom_init(i2c[1], 0x35, 256);=C2=A0 /* SCM CPL=
D */<br>
&gt; +=C2=A0 =C2=A0 aspeed_eeprom_init(i2c[5], 0x35, 256);=C2=A0 /* COMe CP=
LD TODO: need to update */<br>
&gt; +=C2=A0 =C2=A0 aspeed_eeprom_init(i2c[12], 0x60, 256); /* MCB PWR CPLD=
 */<br>
&gt; +=C2=A0 =C2=A0 aspeed_eeprom_init(i2c[13], 0x35, 256); /* IOB FPGA */<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* on BMC board */<br>
&gt; +=C2=A0 =C2=A0 at24c_eeprom_init(i2c[8], 0x51, montblanc_bmc_fruid, 81=
92, true);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* BMC EEPROM */<br>
&gt; +=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[8], TYPE_LM75, 0x48); /* Th=
ermal Sensor */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* COMe Sensor/EEPROM */<br>
&gt; +=C2=A0 =C2=A0 aspeed_eeprom_init(i2c[0], 0x56, 16384);=C2=A0 =C2=A0 =
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
&gt; @@ -1450,6 +1487,32 @@ static void aspeed_machine_fuji_class_init(Obje=
ctClass *oc, void *data)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aspeed_soc_num_cpus(amc-&gt;so=
c_name);<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB limit */<b=
r>
&gt; +#if HOST_LONG_BITS =3D=3D 32<br>
&gt; +#define MONTBLANC_BMC_RAM_SIZE (1 * GiB)<br>
&gt; +#else<br>
&gt; +#define MONTBLANC_BMC_RAM_SIZE (2 * GiB)<br>
&gt; +#endif<br>
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
&gt;=C2=A0 =C2=A0/* On 32-bit hosts, lower RAM to 1G because of the 2047 MB=
 limit */<br>
&gt;=C2=A0 =C2=A0#if HOST_LONG_BITS =3D=3D 32<br>
&gt;=C2=A0 =C2=A0#define BLETCHLEY_BMC_RAM_SIZE (1 * GiB)<br>
&gt; @@ -1706,6 +1769,10 @@ static const TypeInfo aspeed_machine_types[] =
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
&gt; index ace5266cec..bcde346e9b 100644<br>
&gt; --- a/hw/arm/aspeed_eeprom.c<br>
&gt; +++ b/hw/arm/aspeed_eeprom.c<br>
&gt; @@ -161,6 +161,53 @@ const uint8_t rainier_bmc_fruid[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A00x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x=
00, 0x00,<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/* Montblanc BMC FRU */<br>
&gt; +const uint8_t montblanc_scm_fruid[8192] =3D {<br>
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
&gt; +=C2=A0 =C2=A0 0x43, 0x54, 0x48, 0x10, 0x06, 0xb4, 0xbd, 0x00, 0x00, 0=
x00, 0x01, 0x13,<br>
&gt; +=C2=A0 =C2=A0 0x03, 0x53, 0x43, 0x4d, 0xfa, 0x02, 0x11, 0x07,<br>
&gt; +};<br>
&gt; +<br>
&gt; +const uint8_t montblanc_fcm_fruid[8192] =3D {<br>
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
&gt; +=C2=A0 =C2=A0 0x43, 0x54, 0x48, 0x10, 0x06, 0xb4, 0xbd, 0x00, 0x00, 0=
x00, 0x02, 0x11,<br>
&gt; +=C2=A0 =C2=A0 0x06, 0xb4, 0xbd, 0x00, 0x00, 0x00, 0x03, 0x12, 0x02, 0=
x8a, 0x00, 0x13,<br>
&gt; +=C2=A0 =C2=A0 0x03, 0x46, 0x43, 0x42, 0xfa, 0x02, 0x0e, 0x61,<br>
&gt; +};<br>
&gt; +<br>
&gt; +const uint8_t montblanc_bmc_fruid[8192] =3D {<br>
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

--00000000000045949d05ff2dc12e--


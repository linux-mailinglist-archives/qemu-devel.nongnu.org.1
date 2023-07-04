Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 177C7746F46
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 12:59:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGdjU-0004qw-NE; Tue, 04 Jul 2023 06:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ssinprem@celestica.com>)
 id 1qGdjT-0004qV-2z
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 06:58:07 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ssinprem@celestica.com>)
 id 1qGdjP-0002QE-2w
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 06:58:06 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-682ae5d4184so20687b3a.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=celestica.com; s=google-201810; t=1688468281; x=1691060281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F0VXyEDeqsmSmdDiGSw0Ac+2/fmWYeChEPFDd6t3jMo=;
 b=BkOQIjegWn1VYKMe1xOzxJoQVET9cMM/EV01aSusTCgOtR1xOlfx2qvzV82rgW1mxd
 dtViDWAWD8F2/vj4w/wn1c77KS8g4U775+q1QkAubP556+fpBkdCdO2DQ3raUCgSMBP/
 SQnTezn0z1kmHxT/VwvggmLaW8NDjBxpi09ElJJoht2s2jJULzYpJfexXgOf8mOWVFFW
 s9Kf/vasHMdICYBtMuE9oTls0QM9aw3bOsP1DvrZIBoZ2gaTeBapKLp4qHh4/pjmFrAB
 qTbSAAxGYpc4AW4CQKv9i+4pMCQivMlezdzCtyQdQI2tjBoV8Gu1L6x4tinHkxql+J9e
 IlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688468281; x=1691060281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F0VXyEDeqsmSmdDiGSw0Ac+2/fmWYeChEPFDd6t3jMo=;
 b=YxNBPOCnLuAP4Q+XDro9JOjYfdty17y+rHAF+81rsaXsaxh3A8pXkqhFi325bV4KPX
 VUS4Qm/zga4kuRr2vxM7r/Tlf9lyfl66v6JOPYzR+8VEQvPJ+ylC9acL9C4zOvFJvfG8
 2HuGEmAZHiqZjMP+PvdwcTA5HsTG6EPSqMeOI+A4mlAgx+dOkzPO4DD9EKA3pHgvmfpM
 HtwBpXi+MT09xniNcUfpai7jVoc7udS9qnve78nTSReTENlzaYe+sbQmgzXJVDXnxewJ
 Xl53R2IqZ9LDAsiEWcLaJHLL5LHnajtTwEKjm9AUyozun2vCNDUl+JQzeimu2trsGIGL
 xa8A==
X-Gm-Message-State: ABy/qLYVHigrnBNteVcpbd+sVS379oSzXbVkh8FG0r27ZnfL5SR+Lo4e
 lFsGtEvjHKhbRUBtTyC/uskc8XkwXxtSJbISdNlxDBRDVi0QJJ0xb1U1zu62JDHrw2bq9oyUso2
 VMhivKvADPhPYMZpVVTG0GuOo7kEAHIQSiMlwSTSdBB07+FQSm11Mdw8TAsP34Sd0ApVsrRM94v
 B9RNOe0LxMw4tJkTVCx99dzfaCHX23B3t5cQ==
X-Google-Smtp-Source: APBJJlGJ2rcHHKpjqUpZze7UGNLRrXGyL0Mrif4C6RDRwI6ak1xMA+CiPn2MZF9fg17ol+T6SNKXdgTD0/cMUwNe6W4=
X-Received: by 2002:a05:6a00:1249:b0:66f:3fc5:6167 with SMTP id
 u9-20020a056a00124900b0066f3fc56167mr15855976pfi.1.1688468280660; Tue, 04 Jul
 2023 03:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <168846792266.24055.9837240417124338096-0@git.sr.ht>
In-Reply-To: <168846792266.24055.9837240417124338096-0@git.sr.ht>
From: Sittisak Sinprem <ssinprem@celestica.com>
Date: Tue, 4 Jul 2023 17:57:33 +0700
Message-ID: <CAE+aGtXPYWUG1VubR8DZr7uFpiwg4St1HfYBfBpsiyszSf61Lg@mail.gmail.com>
Subject: Re: [PATCH qemu v4] aspeed add montblanc bmc reference from fuji
To: "~ssinprem" <ssinprem@celestica.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org, 
 peter.maydell@linaro.org, ssumet@celestica.com, srikanth@celestica.com, 
 kgengan@celestica.com, andrew@aj.id.au, joel@jms.id.au, 
 thangavelu.v@celestica.com, anandaramanv@celestica.com
Content-Type: multipart/alternative; boundary="00000000000015aa9705ffa7288b"
X-CLS-Gapps: True
X-CLOUD-SEC-AV-Sent: true
X-CLOUD-SEC-AV-Info: celesticainc,google_mail,monitor
X-Gm-Spam: 0
X-Gm-Phishy: 0
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=ssinprem@celestica.com; helo=mail-pf1-x42d.google.com
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

--00000000000015aa9705ffa7288b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi C=C3=A9dric,

Please stop this patch,
after the test, the eeprom content is incorrect,

root@bmc:~# weutil -l
bmc_eeprom    /sys/bus/i2c/devices/i2c-8/8-0051/eeprom
chassis_eeprom    /sys/bus/i2c/devices/i2c-6/6-0053/eeprom
dummy_eeprom    /etc/weutil/meta_eeprom_v4_sample.bin
scm_eeprom    /sys/bus/i2c/devices/i2c-3/3-0056/eeprom
root@bmc:~# hexdump -C /sys/bus/i2c/devices/i2c-6/6-0053/eeprom
00000000  fb 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 |................|
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 |................|
*
00002000
root@bmc:~# hexdump -C /sys/bus/i2c/devices/i2c-8/8-0051/eeprom
00000000  fb 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 |................|
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
 |................|
*
00002000
root@bmc:~#

I will send the next version after fixed

On Tue, Jul 4, 2023 at 5:52=E2=80=AFPM ~ssinprem <ssinprem@git.sr.ht> wrote=
:

> From: Sittisak Sinprem <ssinprem@celestica.com>
>
> - I2C list follow I2C Tree v1.6 20230320
> - fru eeprom data use FB FRU format version 4
>
> Signed-off-by: Sittisak Sinprem <ssinprem@celestica.com>
> ---
>  docs/system/arm/aspeed.rst |  1 +
>  hw/arm/aspeed.c            | 63 ++++++++++++++++++++++++++++++++++++++
>  hw/arm/aspeed_eeprom.c     | 50 ++++++++++++++++++++++++++++++
>  hw/arm/aspeed_eeprom.h     |  7 +++++
>  4 files changed, 121 insertions(+)
>
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index 80538422a1..5e0824f48b 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -33,6 +33,7 @@ AST2600 SoC based machines :
>  - ``tacoma-bmc``           OpenPOWER Witherspoon POWER9 AST2600 BMC
>  - ``rainier-bmc``          IBM Rainier POWER10 BMC
>  - ``fuji-bmc``             Facebook Fuji BMC
> +- ``montblanc-bmc``        Facebook Montblanc BMC
>  - ``bletchley-bmc``        Facebook Bletchley BMC
>  - ``fby35-bmc``            Facebook fby35 BMC
>  - ``qcom-dc-scm-v1-bmc``   Qualcomm DC-SCM V1 BMC
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 9fca644d92..91bd4e5637 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -189,6 +189,10 @@ struct AspeedMachineState {
>  #define FUJI_BMC_HW_STRAP1    0x00000000
>  #define FUJI_BMC_HW_STRAP2    0x00000000
>
> +/* Montblanc hardware value */
> +#define MONTBLANC_BMC_HW_STRAP1    0x00000000
> +#define MONTBLANC_BMC_HW_STRAP2    0x00000000
> +
>  /* Bletchley hardware value */
>  /* TODO: Leave same as EVB for now. */
>  #define BLETCHLEY_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1
> @@ -925,6 +929,39 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bm=
c)
>      }
>  }
>
> +static void montblanc_bmc_i2c_init(AspeedMachineState *bmc)
> +{
> +    AspeedSoCState *soc =3D &bmc->soc;
> +    I2CBus *i2c[16] =3D {};
> +
> +    for (int i =3D 0; i < 16; i++) {
> +        i2c[i] =3D aspeed_i2c_get_bus(&soc->i2c, i);
> +    }
> +
> +    /* Ref from Minipack3_I2C_Tree_V1.6 20230320 */
> +    at24c_eeprom_init_rom(i2c[3], 0x56, 8192, montblanc_scm_fruid, true)=
;
> +    at24c_eeprom_init_rom(i2c[6], 0x53, 8192, montblanc_fcm_fruid, true)=
;
> +
> +    /* CPLD and FPGA */
> +    at24c_eeprom_init(i2c[1], 0x35, 256);  /* SCM CPLD */
> +    at24c_eeprom_init(i2c[5], 0x35, 256);  /* COMe CPLD TODO: need to
> update */
> +    at24c_eeprom_init(i2c[12], 0x60, 256); /* MCB PWR CPLD */
> +    at24c_eeprom_init(i2c[13], 0x35, 256); /* IOB FPGA */
> +
> +    /* on BMC board */
> +    at24c_eeprom_init_rom(i2c[8], 0x51, 8192, montblanc_bmc_fruid, true)=
;
> +                                                      /* BMC EEPROM */
> +    i2c_slave_create_simple(i2c[8], TYPE_LM75, 0x48); /* Thermal Sensor =
*/
> +
> +    /* COMe Sensor/EEPROM */
> +    at24c_eeprom_init(i2c[0], 0x56, 16384);          /* FRU EEPROM */
> +    i2c_slave_create_simple(i2c[0], TYPE_LM75, 0x48); /* INLET Sensor */
> +    i2c_slave_create_simple(i2c[0], TYPE_LM75, 0x4A); /* OUTLET Sensor *=
/
> +
> +    /* It expects a pca9555 but a pca9552 is compatible */
> +    create_pca9552(soc, 4, 0x27);
> +}
> +
>  #define TYPE_TMP421 "tmp421"
>
>  static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)
> @@ -1452,6 +1489,28 @@ static void
> aspeed_machine_fuji_class_init(ObjectClass *oc, void *data)
>          aspeed_soc_num_cpus(amc->soc_name);
>  };
>
> +#define MONTBLANC_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
> +
> +static void aspeed_machine_montblanc_class_init(ObjectClass *oc, void
> *data)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc =3D "Facebook Montblanc BMC (Cortex-A7)";
> +    amc->soc_name =3D "ast2600-a3";
> +    amc->hw_strap1 =3D MONTBLANC_BMC_HW_STRAP1;
> +    amc->hw_strap2 =3D MONTBLANC_BMC_HW_STRAP2;
> +    amc->fmc_model =3D "mx66l1g45g";
> +    amc->spi_model =3D "mx66l1g45g";
> +    amc->num_cs =3D 2;
> +    amc->macs_mask =3D ASPEED_MAC3_ON;
> +    amc->i2c_init =3D montblanc_bmc_i2c_init;
> +    amc->uart_default =3D ASPEED_DEV_UART1;
> +    mc->default_ram_size =3D MONTBLANC_BMC_RAM_SIZE;
> +    mc->default_cpus =3D mc->min_cpus =3D mc->max_cpus =3D
> +        aspeed_soc_num_cpus(amc->soc_name);
> +};
> +
>  #define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
>
>  static void aspeed_machine_bletchley_class_init(ObjectClass *oc, void
> *data)
> @@ -1703,6 +1762,10 @@ static const TypeInfo aspeed_machine_types[] =3D {
>          .name          =3D MACHINE_TYPE_NAME("fuji-bmc"),
>          .parent        =3D TYPE_ASPEED_MACHINE,
>          .class_init    =3D aspeed_machine_fuji_class_init,
> +    }, {
> +        .name          =3D MACHINE_TYPE_NAME("montblanc-bmc"),
> +        .parent        =3D TYPE_ASPEED_MACHINE,
> +        .class_init    =3D aspeed_machine_montblanc_class_init,
>      }, {
>          .name          =3D MACHINE_TYPE_NAME("bletchley-bmc"),
>          .parent        =3D TYPE_ASPEED_MACHINE,
> diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c
> index ace5266cec..8cc73f83dc 100644
> --- a/hw/arm/aspeed_eeprom.c
> +++ b/hw/arm/aspeed_eeprom.c
> @@ -161,6 +161,53 @@ const uint8_t rainier_bmc_fruid[] =3D {
>      0x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,
>  };
>
> +/* Montblanc BMC FRU */
> +const uint8_t montblanc_scm_fruid[] =3D {
> +    0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50,
> 0x41,
> +    0x43, 0x4b, 0x33, 0x5f, 0x53, 0x43, 0x4d, 0x02, 0x08, 0x32, 0x30,
> 0x30,
> +    0x30, 0x32, 0x39, 0x34, 0x35, 0x04, 0x0c, 0x31, 0x33, 0x32, 0x30,
> 0x30,
> +    0x30, 0x31, 0x36, 0x34, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31, 0x33,
> 0x31,
> +    0x30, 0x30, 0x30, 0x31, 0x32, 0x37, 0x30, 0x31, 0x20, 0x06, 0x0c,
> 0x52,
> +    0x33, 0x32, 0x31, 0x34, 0x47, 0x30, 0x30, 0x30, 0x33, 0x30, 0x31,
> 0x07,
> +    0x0d, 0x41, 0x30, 0x33, 0x31, 0x33, 0x58, 0x58, 0x58, 0x58, 0x58,
> 0x58,
> +    0x58, 0x58, 0x08, 0x01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0x01, 0x00,
> 0x0b,
> +    0x0d, 0x4d, 0x32, 0x32, 0x31, 0x33, 0x32, 0x33, 0x31, 0x37, 0x30,
> 0x30,
> +    0x30, 0x32, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30,
> 0x32,
> +    0x33, 0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f,
> 0x03,
> +    0x43, 0x54, 0x48, 0x10, 0x06, 0x01, 0x00, 0x00, 0x91, 0xdb, 0xb4,
> 0x13,
> +    0x03, 0x53, 0x43, 0x4d, 0xfa, 0x02, 0x02, 0x61,
> +};
> +
> +const uint8_t montblanc_fcm_fruid[] =3D {
> +    0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50,
> 0x41,
> +    0x43, 0x4b, 0x33, 0x5f, 0x46, 0x43, 0x42, 0x02, 0x08, 0x33, 0x30,
> 0x30,
> +    0x30, 0x30, 0x31, 0x36, 0x31, 0x04, 0x0c, 0x31, 0x33, 0x32, 0x30,
> 0x30,
> +    0x30, 0x31, 0x36, 0x33, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31, 0x33,
> 0x31,
> +    0x30, 0x30, 0x30, 0x31, 0x33, 0x30, 0x30, 0x31, 0x20, 0x06, 0x0c,
> 0x52,
> +    0x33, 0x32, 0x31, 0x34, 0x47, 0x30, 0x30, 0x31, 0x32, 0x30, 0x31,
> 0x07,
> +    0x0d, 0x41, 0x31, 0x32, 0x31, 0x32, 0x58, 0x58, 0x58, 0x58, 0x58,
> 0x58,
> +    0x58, 0x58, 0x08, 0x01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0x01, 0x00,
> 0x0b,
> +    0x0d, 0x46, 0x35, 0x30, 0x31, 0x33, 0x32, 0x33, 0x31, 0x37, 0x30,
> 0x30,
> +    0x30, 0x35, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30,
> 0x32,
> +    0x33, 0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f,
> 0x03,
> +    0x43, 0x54, 0x48, 0x10, 0x06, 0x02, 0x00, 0x00, 0x91, 0xdb, 0xb4,
> 0x11,
> +    0x06, 0x03, 0x00, 0x00, 0x91, 0xdb, 0xb4, 0x12, 0x02, 0x8a, 0x00,
> 0x13,
> +    0x03, 0x46, 0x43, 0x42, 0xfa, 0x02, 0x50, 0x47,
> +};
> +
> +const uint8_t montblanc_bmc_fruid[] =3D {
> +    0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, 0x50,
> 0x41,
> +    0x43, 0x4b, 0x33, 0x5f, 0x42, 0x4d, 0x43, 0x04, 0x0c, 0x31, 0x33,
> 0x32,
> +    0x30, 0x30, 0x30, 0x31, 0x33, 0x36, 0x30, 0x31, 0x20, 0x05, 0x0c,
> 0x31,
> +    0x33, 0x31, 0x30, 0x30, 0x30, 0x30, 0x38, 0x36, 0x30, 0x35, 0x20,
> 0x06,
> +    0x0c, 0x52, 0x33, 0x30, 0x39, 0x37, 0x47, 0x30, 0x30, 0x30, 0x32,
> 0x30,
> +    0x37, 0x07, 0x0d, 0x42, 0x30, 0x32, 0x37, 0x34, 0x58, 0x58, 0x58,
> 0x58,
> +    0x58, 0x58, 0x58, 0x58, 0x08, 0x01, 0x04, 0x09, 0x01, 0x00, 0x0a,
> 0x01,
> +    0x00, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30, 0x32,
> 0x33,
> +    0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f, 0x03,
> 0x43,
> +    0x54, 0x48, 0x13, 0x03, 0x42, 0x4d, 0x43, 0xfa, 0x02, 0xef, 0xba,
> +};
> +
>  const size_t tiogapass_bmc_fruid_len =3D sizeof(tiogapass_bmc_fruid);
>  const size_t fby35_nic_fruid_len =3D sizeof(fby35_nic_fruid);
>  const size_t fby35_bb_fruid_len =3D sizeof(fby35_bb_fruid);
> @@ -168,3 +215,6 @@ const size_t fby35_bmc_fruid_len =3D
> sizeof(fby35_bmc_fruid);
>  const size_t yosemitev2_bmc_fruid_len =3D sizeof(yosemitev2_bmc_fruid);
>  const size_t rainier_bb_fruid_len =3D sizeof(rainier_bb_fruid);
>  const size_t rainier_bmc_fruid_len =3D sizeof(rainier_bmc_fruid);
> +const size_t montblanc_scm_fruid_len =3D sizeof(montblanc_scm_fruid);
> +const size_t montblanc_fcm_fruid_len =3D sizeof(montblanc_fcm_fruid);
> +const size_t montblanc_bmc_fruid_len =3D sizeof(montblanc_bmc_fruid);
> diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h
> index bbf9e54365..b8fbdd0734 100644
> --- a/hw/arm/aspeed_eeprom.h
> +++ b/hw/arm/aspeed_eeprom.h
> @@ -27,4 +27,11 @@ extern const size_t rainier_bb_fruid_len;
>  extern const uint8_t rainier_bmc_fruid[];
>  extern const size_t rainier_bmc_fruid_len;
>
> +extern const uint8_t montblanc_scm_fruid[];
> +extern const uint8_t montblanc_fcm_fruid[];
> +extern const uint8_t montblanc_bmc_fruid[];
> +extern const size_t montblanc_scm_fruid_len;
> +extern const size_t montblanc_fcm_fruid_len;
> +extern const size_t montblanc_bmc_fruid_len;
> +
>  #endif
> --
> 2.38.5
>

--00000000000015aa9705ffa7288b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:&quot;tr=
ebuchet ms&quot;,sans-serif;color:rgb(19,79,92)">Hi=C2=A0<span style=3D"col=
or:rgb(32,33,36);font-family:&quot;Google Sans&quot;,Roboto,sans-serif">C=
=C3=A9dric,</span></div><div class=3D"gmail_default" style=3D"font-family:&=
quot;trebuchet ms&quot;,sans-serif;color:rgb(19,79,92)"><span style=3D"colo=
r:rgb(32,33,36);font-family:&quot;Google Sans&quot;,Roboto,sans-serif"><br>=
Please stop this patch,<br>after the test, the eeprom content is incorrect,=
<br><br></span>root@bmc:~# weutil -l<br>bmc_eeprom =C2=A0 =C2=A0/sys/bus/i2=
c/devices/i2c-8/8-0051/eeprom<br>chassis_eeprom =C2=A0 =C2=A0/sys/bus/i2c/d=
evices/i2c-6/6-0053/eeprom<br>dummy_eeprom =C2=A0 =C2=A0/etc/weutil/meta_ee=
prom_v4_sample.bin<br>scm_eeprom =C2=A0 =C2=A0/sys/bus/i2c/devices/i2c-3/3-=
0056/eeprom<br>root@bmc:~# hexdump -C /sys/bus/i2c/devices/i2c-6/6-0053/eep=
rom<br>00000000 =C2=A0fb 00 00 00 00 00 00 00 =C2=A000 00 00 00 00 00 00 00=
 =C2=A0|................|<br>00000010 =C2=A000 00 00 00 00 00 00 00 =C2=A00=
0 00 00 00 00 00 00 00 =C2=A0|................|<br>*<br>00002000<br>root@bm=
c:~# hexdump -C /sys/bus/i2c/devices/i2c-8/8-0051/eeprom<br>00000000 =C2=A0=
fb 00 00 00 00 00 00 00 =C2=A000 00 00 00 00 00 00 00 =C2=A0|..............=
..|<br>00000010 =C2=A000 00 00 00 00 00 00 00 =C2=A000 00 00 00 00 00 00 00=
 =C2=A0|................|<br>*<br>00002000<br>root@bmc:~#<br><span style=3D=
"color:rgb(32,33,36);font-family:&quot;Google Sans&quot;,Roboto,sans-serif"=
><br>I will send the next version after fixed</span></div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 4, 20=
23 at 5:52=E2=80=AFPM ~ssinprem &lt;<a href=3D"mailto:ssinprem@git.sr.ht">s=
sinprem@git.sr.ht</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">From: Sittisak Sinprem &lt;<a href=3D"mailto:ssinprem@cele=
stica.com" target=3D"_blank">ssinprem@celestica.com</a>&gt;<br>
<br>
- I2C list follow I2C Tree v1.6 20230320<br>
- fru eeprom data use FB FRU format version 4<br>
<br>
Signed-off-by: Sittisak Sinprem &lt;<a href=3D"mailto:ssinprem@celestica.co=
m" target=3D"_blank">ssinprem@celestica.com</a>&gt;<br>
---<br>
=C2=A0docs/system/arm/aspeed.rst |=C2=A0 1 +<br>
=C2=A0hw/arm/aspeed.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 63 +++++++=
+++++++++++++++++++++++++++++++<br>
=C2=A0hw/arm/aspeed_eeprom.c=C2=A0 =C2=A0 =C2=A0| 50 ++++++++++++++++++++++=
++++++++<br>
=C2=A0hw/arm/aspeed_eeprom.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 7 +++++<br>
=C2=A04 files changed, 121 insertions(+)<br>
<br>
diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst<br>
index 80538422a1..5e0824f48b 100644<br>
--- a/docs/system/arm/aspeed.rst<br>
+++ b/docs/system/arm/aspeed.rst<br>
@@ -33,6 +33,7 @@ AST2600 SoC based machines :<br>
=C2=A0- ``tacoma-bmc``=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OpenPOWER Wi=
therspoon POWER9 AST2600 BMC<br>
=C2=A0- ``rainier-bmc``=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 IBM Rainier POWER=
10 BMC<br>
=C2=A0- ``fuji-bmc``=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Faceboo=
k Fuji BMC<br>
+- ``montblanc-bmc``=C2=A0 =C2=A0 =C2=A0 =C2=A0 Facebook Montblanc BMC<br>
=C2=A0- ``bletchley-bmc``=C2=A0 =C2=A0 =C2=A0 =C2=A0 Facebook Bletchley BMC=
<br>
=C2=A0- ``fby35-bmc``=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Facebook fby=
35 BMC<br>
=C2=A0- ``qcom-dc-scm-v1-bmc``=C2=A0 =C2=A0Qualcomm DC-SCM V1 BMC<br>
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c<br>
index 9fca644d92..91bd4e5637 100644<br>
--- a/hw/arm/aspeed.c<br>
+++ b/hw/arm/aspeed.c<br>
@@ -189,6 +189,10 @@ struct AspeedMachineState {<br>
=C2=A0#define FUJI_BMC_HW_STRAP1=C2=A0 =C2=A0 0x00000000<br>
=C2=A0#define FUJI_BMC_HW_STRAP2=C2=A0 =C2=A0 0x00000000<br>
<br>
+/* Montblanc hardware value */<br>
+#define MONTBLANC_BMC_HW_STRAP1=C2=A0 =C2=A0 0x00000000<br>
+#define MONTBLANC_BMC_HW_STRAP2=C2=A0 =C2=A0 0x00000000<br>
+<br>
=C2=A0/* Bletchley hardware value */<br>
=C2=A0/* TODO: Leave same as EVB for now. */<br>
=C2=A0#define BLETCHLEY_BMC_HW_STRAP1 AST2600_EVB_HW_STRAP1<br>
@@ -925,6 +929,39 @@ static void fuji_bmc_i2c_init(AspeedMachineState *bmc)=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
+static void montblanc_bmc_i2c_init(AspeedMachineState *bmc)<br>
+{<br>
+=C2=A0 =C2=A0 AspeedSoCState *soc =3D &amp;bmc-&gt;soc;<br>
+=C2=A0 =C2=A0 I2CBus *i2c[16] =3D {};<br>
+<br>
+=C2=A0 =C2=A0 for (int i =3D 0; i &lt; 16; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 i2c[i] =3D aspeed_i2c_get_bus(&amp;soc-&gt;i2c=
, i);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Ref from Minipack3_I2C_Tree_V1.6 20230320 */<br>
+=C2=A0 =C2=A0 at24c_eeprom_init_rom(i2c[3], 0x56, 8192, montblanc_scm_frui=
d, true);<br>
+=C2=A0 =C2=A0 at24c_eeprom_init_rom(i2c[6], 0x53, 8192, montblanc_fcm_frui=
d, true);<br>
+<br>
+=C2=A0 =C2=A0 /* CPLD and FPGA */<br>
+=C2=A0 =C2=A0 at24c_eeprom_init(i2c[1], 0x35, 256);=C2=A0 /* SCM CPLD */<b=
r>
+=C2=A0 =C2=A0 at24c_eeprom_init(i2c[5], 0x35, 256);=C2=A0 /* COMe CPLD TOD=
O: need to update */<br>
+=C2=A0 =C2=A0 at24c_eeprom_init(i2c[12], 0x60, 256); /* MCB PWR CPLD */<br=
>
+=C2=A0 =C2=A0 at24c_eeprom_init(i2c[13], 0x35, 256); /* IOB FPGA */<br>
+<br>
+=C2=A0 =C2=A0 /* on BMC board */<br>
+=C2=A0 =C2=A0 at24c_eeprom_init_rom(i2c[8], 0x51, 8192, montblanc_bmc_frui=
d, true);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* BMC EEPROM */<br>
+=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[8], TYPE_LM75, 0x48); /* Thermal=
 Sensor */<br>
+<br>
+=C2=A0 =C2=A0 /* COMe Sensor/EEPROM */<br>
+=C2=A0 =C2=A0 at24c_eeprom_init(i2c[0], 0x56, 16384);=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 /* FRU EEPROM */<br>
+=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[0], TYPE_LM75, 0x48); /* INLET S=
ensor */<br>
+=C2=A0 =C2=A0 i2c_slave_create_simple(i2c[0], TYPE_LM75, 0x4A); /* OUTLET =
Sensor */<br>
+<br>
+=C2=A0 =C2=A0 /* It expects a pca9555 but a pca9552 is compatible */<br>
+=C2=A0 =C2=A0 create_pca9552(soc, 4, 0x27);<br>
+}<br>
+<br>
=C2=A0#define TYPE_TMP421 &quot;tmp421&quot;<br>
<br>
=C2=A0static void bletchley_bmc_i2c_init(AspeedMachineState *bmc)<br>
@@ -1452,6 +1489,28 @@ static void aspeed_machine_fuji_class_init(ObjectCla=
ss *oc, void *data)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0aspeed_soc_num_cpus(amc-&gt;soc_name);<br=
>
=C2=A0};<br>
<br>
+#define MONTBLANC_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)<br>
+<br>
+static void aspeed_machine_montblanc_class_init(ObjectClass *oc, void *dat=
a)<br>
+{<br>
+=C2=A0 =C2=A0 MachineClass *mc =3D MACHINE_CLASS(oc);<br>
+=C2=A0 =C2=A0 AspeedMachineClass *amc =3D ASPEED_MACHINE_CLASS(oc);<br>
+<br>
+=C2=A0 =C2=A0 mc-&gt;desc =3D &quot;Facebook Montblanc BMC (Cortex-A7)&quo=
t;;<br>
+=C2=A0 =C2=A0 amc-&gt;soc_name =3D &quot;ast2600-a3&quot;;<br>
+=C2=A0 =C2=A0 amc-&gt;hw_strap1 =3D MONTBLANC_BMC_HW_STRAP1;<br>
+=C2=A0 =C2=A0 amc-&gt;hw_strap2 =3D MONTBLANC_BMC_HW_STRAP2;<br>
+=C2=A0 =C2=A0 amc-&gt;fmc_model =3D &quot;mx66l1g45g&quot;;<br>
+=C2=A0 =C2=A0 amc-&gt;spi_model =3D &quot;mx66l1g45g&quot;;<br>
+=C2=A0 =C2=A0 amc-&gt;num_cs =3D 2;<br>
+=C2=A0 =C2=A0 amc-&gt;macs_mask =3D ASPEED_MAC3_ON;<br>
+=C2=A0 =C2=A0 amc-&gt;i2c_init =3D montblanc_bmc_i2c_init;<br>
+=C2=A0 =C2=A0 amc-&gt;uart_default =3D ASPEED_DEV_UART1;<br>
+=C2=A0 =C2=A0 mc-&gt;default_ram_size =3D MONTBLANC_BMC_RAM_SIZE;<br>
+=C2=A0 =C2=A0 mc-&gt;default_cpus =3D mc-&gt;min_cpus =3D mc-&gt;max_cpus =
=3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 aspeed_soc_num_cpus(amc-&gt;soc_name);<br>
+};<br>
+<br>
=C2=A0#define BLETCHLEY_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)<br>
<br>
=C2=A0static void aspeed_machine_bletchley_class_init(ObjectClass *oc, void=
 *data)<br>
@@ -1703,6 +1762,10 @@ static const TypeInfo aspeed_machine_types[] =3D {<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D MACHINE_TYPE_NAME(&quot;fuji-bmc&quot;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TY=
PE_ASPEED_MACHINE,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.class_init=C2=A0 =C2=A0 =3D aspeed_machi=
ne_fuji_class_init,<br>
+=C2=A0 =C2=A0 }, {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D MA=
CHINE_TYPE_NAME(&quot;montblanc-bmc&quot;),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TYPE_AS=
PEED_MACHINE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 .class_init=C2=A0 =C2=A0 =3D aspeed_machine_mo=
ntblanc_class_init,<br>
=C2=A0 =C2=A0 =C2=A0}, {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=3D MACHINE_TYPE_NAME(&quot;bletchley-bmc&quot;),<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.parent=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D TY=
PE_ASPEED_MACHINE,<br>
diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c<br>
index ace5266cec..8cc73f83dc 100644<br>
--- a/hw/arm/aspeed_eeprom.c<br>
+++ b/hw/arm/aspeed_eeprom.c<br>
@@ -161,6 +161,53 @@ const uint8_t rainier_bmc_fruid[] =3D {<br>
=C2=A0 =C2=A0 =C2=A00x31, 0x50, 0x46, 0x04, 0x00, 0x00, 0x00, 0x00, 0x00,<b=
r>
=C2=A0};<br>
<br>
+/* Montblanc BMC FRU */<br>
+const uint8_t montblanc_scm_fruid[] =3D {<br>
+=C2=A0 =C2=A0 0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, =
0x50, 0x41,<br>
+=C2=A0 =C2=A0 0x43, 0x4b, 0x33, 0x5f, 0x53, 0x43, 0x4d, 0x02, 0x08, 0x32, =
0x30, 0x30,<br>
+=C2=A0 =C2=A0 0x30, 0x32, 0x39, 0x34, 0x35, 0x04, 0x0c, 0x31, 0x33, 0x32, =
0x30, 0x30,<br>
+=C2=A0 =C2=A0 0x30, 0x31, 0x36, 0x34, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31, =
0x33, 0x31,<br>
+=C2=A0 =C2=A0 0x30, 0x30, 0x30, 0x31, 0x32, 0x37, 0x30, 0x31, 0x20, 0x06, =
0x0c, 0x52,<br>
+=C2=A0 =C2=A0 0x33, 0x32, 0x31, 0x34, 0x47, 0x30, 0x30, 0x30, 0x33, 0x30, =
0x31, 0x07,<br>
+=C2=A0 =C2=A0 0x0d, 0x41, 0x30, 0x33, 0x31, 0x33, 0x58, 0x58, 0x58, 0x58, =
0x58, 0x58,<br>
+=C2=A0 =C2=A0 0x58, 0x58, 0x08, 0x01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0x01, =
0x00, 0x0b,<br>
+=C2=A0 =C2=A0 0x0d, 0x4d, 0x32, 0x32, 0x31, 0x33, 0x32, 0x33, 0x31, 0x37, =
0x30, 0x30,<br>
+=C2=A0 =C2=A0 0x30, 0x32, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, =
0x30, 0x32,<br>
+=C2=A0 =C2=A0 0x33, 0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, =
0x0f, 0x03,<br>
+=C2=A0 =C2=A0 0x43, 0x54, 0x48, 0x10, 0x06, 0x01, 0x00, 0x00, 0x91, 0xdb, =
0xb4, 0x13,<br>
+=C2=A0 =C2=A0 0x03, 0x53, 0x43, 0x4d, 0xfa, 0x02, 0x02, 0x61,<br>
+};<br>
+<br>
+const uint8_t montblanc_fcm_fruid[] =3D {<br>
+=C2=A0 =C2=A0 0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, =
0x50, 0x41,<br>
+=C2=A0 =C2=A0 0x43, 0x4b, 0x33, 0x5f, 0x46, 0x43, 0x42, 0x02, 0x08, 0x33, =
0x30, 0x30,<br>
+=C2=A0 =C2=A0 0x30, 0x30, 0x31, 0x36, 0x31, 0x04, 0x0c, 0x31, 0x33, 0x32, =
0x30, 0x30,<br>
+=C2=A0 =C2=A0 0x30, 0x31, 0x36, 0x33, 0x30, 0x31, 0x20, 0x05, 0x0c, 0x31, =
0x33, 0x31,<br>
+=C2=A0 =C2=A0 0x30, 0x30, 0x30, 0x31, 0x33, 0x30, 0x30, 0x31, 0x20, 0x06, =
0x0c, 0x52,<br>
+=C2=A0 =C2=A0 0x33, 0x32, 0x31, 0x34, 0x47, 0x30, 0x30, 0x31, 0x32, 0x30, =
0x31, 0x07,<br>
+=C2=A0 =C2=A0 0x0d, 0x41, 0x31, 0x32, 0x31, 0x32, 0x58, 0x58, 0x58, 0x58, =
0x58, 0x58,<br>
+=C2=A0 =C2=A0 0x58, 0x58, 0x08, 0x01, 0x01, 0x09, 0x01, 0x00, 0x0a, 0x01, =
0x00, 0x0b,<br>
+=C2=A0 =C2=A0 0x0d, 0x46, 0x35, 0x30, 0x31, 0x33, 0x32, 0x33, 0x31, 0x37, =
0x30, 0x30,<br>
+=C2=A0 =C2=A0 0x30, 0x35, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, =
0x30, 0x32,<br>
+=C2=A0 =C2=A0 0x33, 0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, =
0x0f, 0x03,<br>
+=C2=A0 =C2=A0 0x43, 0x54, 0x48, 0x10, 0x06, 0x02, 0x00, 0x00, 0x91, 0xdb, =
0xb4, 0x11,<br>
+=C2=A0 =C2=A0 0x06, 0x03, 0x00, 0x00, 0x91, 0xdb, 0xb4, 0x12, 0x02, 0x8a, =
0x00, 0x13,<br>
+=C2=A0 =C2=A0 0x03, 0x46, 0x43, 0x42, 0xfa, 0x02, 0x50, 0x47,<br>
+};<br>
+<br>
+const uint8_t montblanc_bmc_fruid[] =3D {<br>
+=C2=A0 =C2=A0 0xfb, 0xfb, 0x04, 0xff, 0x01, 0x0d, 0x4d, 0x49, 0x4e, 0x49, =
0x50, 0x41,<br>
+=C2=A0 =C2=A0 0x43, 0x4b, 0x33, 0x5f, 0x42, 0x4d, 0x43, 0x04, 0x0c, 0x31, =
0x33, 0x32,<br>
+=C2=A0 =C2=A0 0x30, 0x30, 0x30, 0x31, 0x33, 0x36, 0x30, 0x31, 0x20, 0x05, =
0x0c, 0x31,<br>
+=C2=A0 =C2=A0 0x33, 0x31, 0x30, 0x30, 0x30, 0x30, 0x38, 0x36, 0x30, 0x35, =
0x20, 0x06,<br>
+=C2=A0 =C2=A0 0x0c, 0x52, 0x33, 0x30, 0x39, 0x37, 0x47, 0x30, 0x30, 0x30, =
0x32, 0x30,<br>
+=C2=A0 =C2=A0 0x37, 0x07, 0x0d, 0x42, 0x30, 0x32, 0x37, 0x34, 0x58, 0x58, =
0x58, 0x58,<br>
+=C2=A0 =C2=A0 0x58, 0x58, 0x58, 0x58, 0x08, 0x01, 0x04, 0x09, 0x01, 0x00, =
0x0a, 0x01,<br>
+=C2=A0 =C2=A0 0x00, 0x0c, 0x03, 0x43, 0x4c, 0x53, 0x0d, 0x08, 0x32, 0x30, =
0x32, 0x33,<br>
+=C2=A0 =C2=A0 0x30, 0x35, 0x30, 0x31, 0x0e, 0x03, 0x57, 0x55, 0x53, 0x0f, =
0x03, 0x43,<br>
+=C2=A0 =C2=A0 0x54, 0x48, 0x13, 0x03, 0x42, 0x4d, 0x43, 0xfa, 0x02, 0xef, =
0xba,<br>
+};<br>
+<br>
=C2=A0const size_t tiogapass_bmc_fruid_len =3D sizeof(tiogapass_bmc_fruid);=
<br>
=C2=A0const size_t fby35_nic_fruid_len =3D sizeof(fby35_nic_fruid);<br>
=C2=A0const size_t fby35_bb_fruid_len =3D sizeof(fby35_bb_fruid);<br>
@@ -168,3 +215,6 @@ const size_t fby35_bmc_fruid_len =3D sizeof(fby35_bmc_f=
ruid);<br>
=C2=A0const size_t yosemitev2_bmc_fruid_len =3D sizeof(yosemitev2_bmc_fruid=
);<br>
=C2=A0const size_t rainier_bb_fruid_len =3D sizeof(rainier_bb_fruid);<br>
=C2=A0const size_t rainier_bmc_fruid_len =3D sizeof(rainier_bmc_fruid);<br>
+const size_t montblanc_scm_fruid_len =3D sizeof(montblanc_scm_fruid);<br>
+const size_t montblanc_fcm_fruid_len =3D sizeof(montblanc_fcm_fruid);<br>
+const size_t montblanc_bmc_fruid_len =3D sizeof(montblanc_bmc_fruid);<br>
diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h<br>
index bbf9e54365..b8fbdd0734 100644<br>
--- a/hw/arm/aspeed_eeprom.h<br>
+++ b/hw/arm/aspeed_eeprom.h<br>
@@ -27,4 +27,11 @@ extern const size_t rainier_bb_fruid_len;<br>
=C2=A0extern const uint8_t rainier_bmc_fruid[];<br>
=C2=A0extern const size_t rainier_bmc_fruid_len;<br>
<br>
+extern const uint8_t montblanc_scm_fruid[];<br>
+extern const uint8_t montblanc_fcm_fruid[];<br>
+extern const uint8_t montblanc_bmc_fruid[];<br>
+extern const size_t montblanc_scm_fruid_len;<br>
+extern const size_t montblanc_fcm_fruid_len;<br>
+extern const size_t montblanc_bmc_fruid_len;<br>
+<br>
=C2=A0#endif<br>
-- <br>
2.38.5<br>
</blockquote></div>

--00000000000015aa9705ffa7288b--


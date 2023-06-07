Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B07EF725C75
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 12:59:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6qsJ-0008Hc-1R; Wed, 07 Jun 2023 06:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6qsG-0008Gr-Pj; Wed, 07 Jun 2023 06:58:44 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6qsE-0002G4-Vi; Wed, 07 Jun 2023 06:58:44 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51492ae66a4so1032422a12.1; 
 Wed, 07 Jun 2023 03:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1686135521; x=1688727521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNVgHpd8dEnVUWkhoTMD4igCFeHsoqOTH4fKB7OFDyI=;
 b=kLQmW1xH2xZD8DFFCYSzUS7iTbKmULd3pxXaIxHG4odvvMR6E2MzQPum6O2uUb0IPn
 S0VrA/OwOatcl6nieE8o+OM3Fec1P75krzwgo+6B7DrlfTUGS1G1E4NXIOQ08u0KYWV1
 rFbuH/V8FqZHNCdbbh/6FWjJd0VNKIH1CW2CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686135521; x=1688727521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kNVgHpd8dEnVUWkhoTMD4igCFeHsoqOTH4fKB7OFDyI=;
 b=JcJy5qMxrtmZhHUFuJY6+srMeLpwzt4YEdMCA1tOAxUAcXz/x/XXcBTRoF13PkZuWf
 ZXOrRvZPOgfAbzswFaLx9NAxnQRlCYCBDbwEZgJ83+Qinyhf7/Y0hcyaaj5Ivquco7am
 H86YBX4vbM8mcDnyk5ckaSUXHEXv1NiSz+v0LuweB1QS44XUDmwGoIWLcwe499I87rBT
 hjn4MWu03FzFUBVvX00IL4JrUhspAMAvn0mIHJHmLk3023uNmmpIKrwLnbDMquCtVkX7
 Jvhj9K+ewXvdVa369qQW2I7zjGfkoU0nYiXo3fhlUT71U2XEikAIMPWzTWrnw4WSj0FT
 2wMQ==
X-Gm-Message-State: AC+VfDzWy3Gz+Fkir7E1gTNgLr+JhVm2Y1Xfd6U729uCdG24ZmLe6/V8
 VwfSzak4B5wODc6UD63PKTGT0nC9jFKexvDtoqA=
X-Google-Smtp-Source: ACHHUZ4b7EBEI8QsLkkSVxxCPdPG0t1A9Y7qAn1s2XuBp87SxCXZJdxSB/YVvEkC9TnmcThapLZictlLafhqJW3F+DY=
X-Received: by 2002:a17:906:58cb:b0:978:8afb:d44c with SMTP id
 e11-20020a17090658cb00b009788afbd44cmr394167ejs.60.1686135520552; Wed, 07 Jun
 2023 03:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-12-clg@kaod.org>
In-Reply-To: <20230607043943.1837186-12-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 7 Jun 2023 10:58:28 +0000
Message-ID: <CACPK8XfYpgPsxNU7280TJgF7_XQVGjO0JFmNtB3v03Bryqxrig@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] aspeed: Introduce a "bmc-console" machine option
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Abhishek Singh Dagur <abhishek@drut.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, 7 Jun 2023 at 04:40, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Most of the Aspeed machines use the UART5 device for the boot console,
> and QEMU connects the first serial Chardev to this SoC device for this
> purpose. See routine connect_serial_hds_to_uarts().
>
> Nevertheless, some machines use another boot console, such as the fuji,
> and commit 5d63d0c76c ("hw/arm/aspeed: Allow machine to set UART
> default") introduced a SoC class attribute 'uart_default' and property
> to be able to change the boot console device. It was later changed by
> commit d2b3eaefb4 ("aspeed: Refactor UART init for multi-SoC machines").
>
> The "bmc-console" machine option goes a step further and lets the user de=
fine
> the UART device from the QEMU command line without introducing a new
> machine definition. For instance, to use device UART3 (mapped on
> /dev/ttyS2 under Linux) instead of the default UART5, one would use :
>
>   -M ast2500-evb,bmc-console=3Duart3
>
> Cc: Abhishek Singh Dagur <abhishek@drut.io>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  docs/system/arm/aspeed.rst | 11 +++++++++++
>  hw/arm/aspeed.c            | 40 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 49 insertions(+), 2 deletions(-)
>
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index d4e293e7f986..80538422a1a4 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -122,6 +122,11 @@ Options specific to Aspeed machines are :
>
>   * ``spi-model`` to change the SPI Flash model.
>
> + * ``bmc-console`` to change the default console device. Most of the
> +   machines use the ``UART5`` device for a boot console, which is
> +   mapped on ``/dev/ttyS4`` under Linux, but it is not always the
> +   case.
> +
>  For instance, to start the ``ast2500-evb`` machine with a different
>  FMC chip and a bigger (64M) SPI chip, use :
>
> @@ -129,6 +134,12 @@ FMC chip and a bigger (64M) SPI chip, use :
>
>    -M ast2500-evb,fmc-model=3Dmx25l25635e,spi-model=3Dmx66u51235f
>
> +To change the boot console and use device ``UART3`` (``/dev/ttyS2``
> +under Linux), use :
> +
> +.. code-block:: bash
> +
> +  -M ast2500-evb,bmc-console=3Duart3
>
>  Aspeed minibmc family boards (``ast1030-evb``)
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 8beed0c2a66e..d3e58936e68a 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -43,6 +43,7 @@ struct AspeedMachineState {
>      AspeedSoCState soc;
>      MemoryRegion boot_rom;
>      bool mmio_exec;
> +    uint32_t uart_chosen;
>      char *fmc_model;
>      char *spi_model;
>  };
> @@ -331,10 +332,11 @@ static void connect_serial_hds_to_uarts(AspeedMachi=
neState *bmc)
>      AspeedMachineClass *amc =3D ASPEED_MACHINE_GET_CLASS(bmc);
>      AspeedSoCState *s =3D &bmc->soc;
>      AspeedSoCClass *sc =3D ASPEED_SOC_GET_CLASS(s);
> +    int uart_chosen =3D bmc->uart_chosen ? bmc->uart_chosen : amc->uart_=
default;
>
> -    aspeed_soc_uart_set_chr(s, amc->uart_default, serial_hd(0));
> +    aspeed_soc_uart_set_chr(s, uart_chosen, serial_hd(0));
>      for (int i =3D 1, uart =3D ASPEED_DEV_UART1; i < sc->uarts_num; i++,=
 uart++) {
> -        if (uart =3D=3D amc->uart_default) {
> +        if (uart =3D=3D uart_chosen) {
>              continue;
>          }
>          aspeed_soc_uart_set_chr(s, uart, serial_hd(i));
> @@ -1079,6 +1081,35 @@ static void aspeed_set_spi_model(Object *obj, cons=
t char *value, Error **errp)
>      bmc->spi_model =3D g_strdup(value);
>  }
>
> +static char *aspeed_get_bmc_console(Object *obj, Error **errp)
> +{
> +    AspeedMachineState *bmc =3D ASPEED_MACHINE(obj);
> +    AspeedMachineClass *amc =3D ASPEED_MACHINE_GET_CLASS(bmc);
> +    int uart_chosen =3D bmc->uart_chosen ? bmc->uart_chosen : amc->uart_=
default;
> +
> +    return g_strdup_printf("uart%d", uart_chosen - ASPEED_DEV_UART1 + 1)=
;
> +}
> +
> +static void aspeed_set_bmc_console(Object *obj, const char *value, Error=
 **errp)
> +{
> +    AspeedMachineState *bmc =3D ASPEED_MACHINE(obj);
> +    AspeedMachineClass *amc =3D ASPEED_MACHINE_GET_CLASS(bmc);
> +    AspeedSoCClass *sc =3D ASPEED_SOC_CLASS(object_class_by_name(amc->so=
c_name));
> +    int val;
> +
> +    if (sscanf(value, "uart%u", &val) !=3D 1) {
> +        error_setg(errp, "Bad value for \"uart\" property");
> +        return;
> +    }
> +
> +    /* The number of UART depends on the SoC */
> +    if (val < 1 || val > sc->uarts_num) {
> +        error_setg(errp, "\"uart\" should be in range [1 - %d]", sc->uar=
ts_num);
> +        return;
> +    }
> +    bmc->uart_chosen =3D ASPEED_DEV_UART1 + val - 1;
> +}
> +
>  static void aspeed_machine_class_props_init(ObjectClass *oc)
>  {
>      object_class_property_add_bool(oc, "execute-in-place",
> @@ -1087,6 +1118,11 @@ static void aspeed_machine_class_props_init(Object=
Class *oc)
>      object_class_property_set_description(oc, "execute-in-place",
>                             "boot directly from CE0 flash device");
>
> +    object_class_property_add_str(oc, "bmc-console", aspeed_get_bmc_cons=
ole,
> +                                  aspeed_set_bmc_console);
> +    object_class_property_set_description(oc, "bmc-console",
> +                           "Change the default UART to \"uartX\"");
> +
>      object_class_property_add_str(oc, "fmc-model", aspeed_get_fmc_model,
>                                     aspeed_set_fmc_model);
>      object_class_property_set_description(oc, "fmc-model",
> --
> 2.40.1
>


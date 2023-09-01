Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCF278FA2A
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 10:46:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbzmC-0007eI-0V; Fri, 01 Sep 2023 04:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qbzm6-0007e0-NB; Fri, 01 Sep 2023 04:45:07 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qbzlz-0006bh-BE; Fri, 01 Sep 2023 04:45:03 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2bd0d19a304so30932991fa.1; 
 Fri, 01 Sep 2023 01:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1693557895; x=1694162695; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ub/+8uCz80Du/L/b809/ZyRrakMTY6fHgUa5/nXoR0k=;
 b=lGda+3696bpMoL33bqGImH8H8QuLQERctG+YhTfiB9bAQOaN1BLEuQ4juqxpSaLxvl
 hCWIBr8Qmr6yDMLq1Xw6EaIyi0iZdr9m0yQZATaK4klAixXTUtI4JeLiKsbS87tC+8Ss
 YPsCAoitTfqIUrMBkVGMKEzQO3KsfOnAMy9BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693557895; x=1694162695;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ub/+8uCz80Du/L/b809/ZyRrakMTY6fHgUa5/nXoR0k=;
 b=UDpT5p/CNyAZQ/xK6xcku7wy/87jlR3LiOY3ReclEzlyxx7i2D0kvPeIM7L6EgwtED
 YVxBrDr+IWxVCvBrw2yD2msxsSXhjTM5HyZCxy+l/i8FBZKcQ8E6ti0TI4Y9s+IL6DRA
 axF/+Wj9pdJsbaJ7pPVkwIKLrNeX/QwoE/rFrtZnllsKfvifWfQUhwJRswZEIMWJVbUH
 jLAcGYgGzWpy1X4Ms+pNv1gyPeIScjhDItQgEiyrVIhNcJpVVoJnEughc/ed4HAiGqZG
 5pC3GLCODnyblPrdXmyx/IjlR5Kk7zcxbUCkEGk2choa3+2Cy5Z1bFRZytQxI+d3y3ZZ
 9EKA==
X-Gm-Message-State: AOJu0Yzwe6PMlBcND61cLOhD3Yfb7vzvrmBGpMKNxfm5ymcwwbQJ2i6k
 XHyBNVcNKbunx9a/iTSkgCzzFtNImBgWEA5zV7GnUg0m
X-Google-Smtp-Source: AGHT+IHoIblBxMPjRsMhVju2QXw73qvZzigVo4kT2ySQk7InWL1yHNdg3m8OS4JAzS+wv4ekfTH7CaPnRBRJkQLfGMQ=
X-Received: by 2002:a2e:98cd:0:b0:2bc:d607:4d1f with SMTP id
 s13-20020a2e98cd000000b002bcd6074d1fmr1092754ljj.44.1693557894592; Fri, 01
 Sep 2023 01:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230831123922.105200-1-clg@kaod.org>
 <20230831123922.105200-6-clg@kaod.org>
 <b6c8df57-c6e4-9962-40a3-f01d5fd2a6dc@kaod.org>
In-Reply-To: <b6c8df57-c6e4-9962-40a3-f01d5fd2a6dc@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 1 Sep 2023 08:44:43 +0000
Message-ID: <CACPK8Xc1rGpkiALx70PXZHbt5K54QpMA1gnkKHgHFy=Gk0+rKQ@mail.gmail.com>
Subject: Re: [PATCH v3.2 5/7] aspeed: Create flash devices only when defaults
 are enabled
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=joel.stan@gmail.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 31 Aug 2023 at 21:13, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> When the -nodefaults option is set, flash devices should be created
> with :
>
>      -blockdev node-name=3Dfmc0,driver=3Dfile,filename=3D./flash.img \
>      -device mx66u51235f,cs=3D0x0,bus=3Dssi.0,drive=3Dfmc0 \
>
> To be noted that in this case, the ROM will not be installed and the
> initial boot sequence (U-Boot loading) will fetch instructions using
> SPI transactions which is significantly slower. That's exactly how HW
> operates though.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

A good addition. Thanks!

> ---
>   docs/system/arm/aspeed.rst | 35 +++++++++++++++++++++++++++++------
>   hw/arm/aspeed.c            |  6 ++++--
>   2 files changed, 33 insertions(+), 8 deletions(-)
>
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index 80538422a1a4..b2dea54eedad 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -104,7 +104,7 @@ To boot a kernel directly from a Linux build tree:
>           -dtb arch/arm/boot/dts/aspeed-ast2600-evb.dtb \
>           -initrd rootfs.cpio
>
> -The image should be attached as an MTD drive. Run :
> +To boot the machine from the flash image, use an MTD drive :
>
>   .. code-block:: bash
>
> @@ -117,23 +117,46 @@ Options specific to Aspeed machines are :
>      device by using the FMC controller to load the instructions, and
>      not simply from RAM. This takes a little longer.
>
> - * ``fmc-model`` to change the FMC Flash model. FW needs support for
> -   the chip model to boot.
> + * ``fmc-model`` to change the default FMC Flash model. FW needs
> +   support for the chip model to boot.
>
> - * ``spi-model`` to change the SPI Flash model.
> + * ``spi-model`` to change the default SPI Flash model.
>
>    * ``bmc-console`` to change the default console device. Most of the
>      machines use the ``UART5`` device for a boot console, which is
>      mapped on ``/dev/ttyS4`` under Linux, but it is not always the
>      case.
>
> -For instance, to start the ``ast2500-evb`` machine with a different
> -FMC chip and a bigger (64M) SPI chip, use :
> +To use other flash models, for instance a different FMC chip and a
> +bigger (64M) SPI for the ``ast2500-evb`` machine, run :
>
>   .. code-block:: bash
>
>     -M ast2500-evb,fmc-model=3Dmx25l25635e,spi-model=3Dmx66u51235f
>
> +When more flexibility is needed to define the flash devices, to use
> +different flash models or define all flash devices (up to 8), the
> +``-nodefaults`` QEMU option can be used to avoid creating the default
> +flash devices.
> +
> +Flash devices should then be created from the command line and attached
> +to a block device :
> +
> +.. code-block:: bash
> +
> +  $ qemu-system-arm -M ast2600-evb \
> +        -blockdev node-name=3Dfmc0,driver=3Dfile,filename=3D/path/to/fmc=
0.img \
> +       -device mx66u51235f,bus=3Dssi.0,cs=3D0x0,drive=3Dfmc0 \
> +       -blockdev node-name=3Dfmc1,driver=3Dfile,filename=3D/path/to/fmc1=
.img \
> +       -device mx66u51235f,bus=3Dssi.0,cs=3D0x1,drive=3Dfmc1 \
> +       -blockdev node-name=3Dspi1,driver=3Dfile,filename=3D/path/to/spi1=
.img \
> +       -device mx66u51235f,cs=3D0x0,bus=3Dssi.1,drive=3Dspi1 \
> +       -nographic -nodefaults
> +
> +In that case, the machine boots fetching instructions from the FMC0
> +device. It is slower to start but closer to what HW does. Using the
> +machine option ``execute-in-place`` has a similar effect.
> +
>   To change the boot console and use device ``UART3`` (``/dev/ttyS2``
>   under Linux), use :
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index cd92cf9ce0bb..271512ce5ced 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -396,12 +396,14 @@ static void aspeed_machine_init(MachineState *machi=
ne)
>       connect_serial_hds_to_uarts(bmc);
>       qdev_realize(DEVICE(&bmc->soc), NULL, &error_abort);
>
> -    aspeed_board_init_flashes(&bmc->soc.fmc,
> +    if (defaults_enabled()) {
> +        aspeed_board_init_flashes(&bmc->soc.fmc,
>                                 bmc->fmc_model ? bmc->fmc_model : amc->fm=
c_model,
>                                 amc->num_cs, 0);
> -    aspeed_board_init_flashes(&bmc->soc.spi[0],
> +        aspeed_board_init_flashes(&bmc->soc.spi[0],
>                                 bmc->spi_model ? bmc->spi_model : amc->sp=
i_model,
>                                 1, amc->num_cs);
> +    }
>
>       if (machine->kernel_filename && sc->num_cpus > 1) {
>           /* With no u-boot we must set up a boot stub for the secondary =
CPU */
> --
> 2.41.0
>
>


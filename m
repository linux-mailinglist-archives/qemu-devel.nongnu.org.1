Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D995878EE2E
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:10:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhLW-0008BZ-Cc; Thu, 31 Aug 2023 09:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qbhIH-0001y8-6O; Thu, 31 Aug 2023 09:01:11 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qbhIB-0006zV-6m; Thu, 31 Aug 2023 09:01:04 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2bccda76fb1so14742501fa.2; 
 Thu, 31 Aug 2023 06:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1693486857; x=1694091657; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sdjYB2atwXGNl8pRzYTRLUgh2hJqktexPueQ/oPUsu0=;
 b=Kn3tVCZbh6rDklpQoDqj9PS0rq56Wbf17kq2k582DdG7AbAbb4rQJDL90RRH6KbIpy
 B3n8oPza3zT/lQ3JxhWGeFJJTyezOvxavBPywD+8+jJXr7Og7tETlg137TNOAkEldZec
 mj4VUGG1QIv7A2ts19t/WYUCZkQd8bPIhK8Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693486857; x=1694091657;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdjYB2atwXGNl8pRzYTRLUgh2hJqktexPueQ/oPUsu0=;
 b=f5xlW5upzJ/GToCo0CH0tTGoYwrd1amXfFnCQB6zNmIjynJvADIdi36vPrGoDJYbeE
 clgZYiGpJkbX80K2JXEnxj1ZkK/nwNoHd0x4h1FlOAS7IADVkDucJcCFjSmX6cwYVnwW
 jQ37xMaWdj4n+wmKemF17+S+y+kZzwdhT5CTTVlsj8X5wEpA4mwmM6noTO1pBVeAziXb
 kx2g1jPA7UqlfwZkAcDIwYaMqMBbuARiAS4IKxClrYQ/tot/J8xf+EwuLCPacPKSKEQH
 g46XKFAdQLr+gjEZWXYvJOkTsBMyv95o6SKRUBNhiziit6OZ+7kd4J3Tv1ejG1HyAZk7
 bytg==
X-Gm-Message-State: AOJu0YwfvigGjGdMe4YAl/WWSqCSuoROO8WKOMeP5c2s92HOpqMIM4+J
 6cwSOUu8BD0gqQlMZLtOUNcZ8nbPsaCZAJxtk48qdruWomM=
X-Google-Smtp-Source: AGHT+IEnjCfujk6PkIcKzrY5Syy/YzzZeq/SzXYF8BJhMySbbUMfl9dfes1/2Ba2c5ZBFN0bU2tT8K+JBT0JVP4EDBg=
X-Received: by 2002:a05:651c:10d4:b0:2bd:1fee:aacb with SMTP id
 l20-20020a05651c10d400b002bd1feeaacbmr3862336ljn.14.1693486855867; Thu, 31
 Aug 2023 06:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230831123922.105200-1-clg@kaod.org>
 <20230831123922.105200-6-clg@kaod.org>
In-Reply-To: <20230831123922.105200-6-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 31 Aug 2023 13:00:44 +0000
Message-ID: <CACPK8XdiTpONmuLag5HnTCPXtoz+Zg-Yo+rrzt+Wuz17hbdDRg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] aspeed: Create flash devices only when defaults
 are enabled
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=joel.stan@gmail.com; helo=mail-lj1-x22e.google.com
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

On Thu, 31 Aug 2023 at 12:39, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> When the -nodefaults option is set, flash devices should be created
> with :
>
>     -blockdev node-name=3Dfmc0,driver=3Dfile,filename=3D./flash.img \
>     -device mx66u51235f,cs=3D0x0,bus=3Dssi.0,drive=3Dfmc0 \
>
> To be noted that in this case, the ROM will not be installed and the
> initial boot sequence (U-Boot loading) will fetch instructions using
> SPI transactions which is significantly slower. That's exactly how HW
> operates though.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

I think this is the first foray for the aspeed machines into
nodefaults removing things that previously would have just worked. I
know we haven't had it in our recommended command lines for a long
time, so that's fine.

Reviewed-by: Joel Stanley <joel@jms.id.au>

Should the content of your commit message go in the docs?

> ---
>  hw/arm/aspeed.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index cd92cf9ce0bb..271512ce5ced 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -396,12 +396,14 @@ static void aspeed_machine_init(MachineState *machi=
ne)
>      connect_serial_hds_to_uarts(bmc);
>      qdev_realize(DEVICE(&bmc->soc), NULL, &error_abort);
>
> -    aspeed_board_init_flashes(&bmc->soc.fmc,
> +    if (defaults_enabled()) {
> +        aspeed_board_init_flashes(&bmc->soc.fmc,
>                                bmc->fmc_model ? bmc->fmc_model : amc->fmc=
_model,
>                                amc->num_cs, 0);
> -    aspeed_board_init_flashes(&bmc->soc.spi[0],
> +        aspeed_board_init_flashes(&bmc->soc.spi[0],
>                                bmc->spi_model ? bmc->spi_model : amc->spi=
_model,
>                                1, amc->num_cs);
> +    }
>
>      if (machine->kernel_filename && sc->num_cpus > 1) {
>          /* With no u-boot we must set up a boot stub for the secondary C=
PU */
> --
> 2.41.0
>


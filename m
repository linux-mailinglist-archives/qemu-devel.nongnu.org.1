Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE1678EEDC
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:42:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhwK-0000yr-0K; Thu, 31 Aug 2023 09:42:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qbhwF-0000lT-7a; Thu, 31 Aug 2023 09:42:23 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qbhwC-0003BM-DI; Thu, 31 Aug 2023 09:42:22 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99bf3f59905so95677766b.3; 
 Thu, 31 Aug 2023 06:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1693489338; x=1694094138; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fHfXKsk4Fp2//RuLUG648k4PSIDJ9GIP2HHnP04Uc/A=;
 b=bSaLibuX3z2briMh165CtPcQNTe4D/8jbc5SpAtRsxNQt/IrQuIyqVmjw3penIa+3Q
 xh0nREtVAYH6be40Ia7VO6oq8ETV6sMy0LyaYfzTf+qYbh06yMHe+cfPmHRESHsyRQBT
 KHI3MU4mouo1xiWOBUunQuxaZWyBR9VUNIssk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693489338; x=1694094138;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fHfXKsk4Fp2//RuLUG648k4PSIDJ9GIP2HHnP04Uc/A=;
 b=HEZB/Bssn20KE4Hpw644u7dTHWHjgYrxC/2dnmF/QCFFBl2REuJ6zvh+vfA2XP3MF9
 5VHlahQo0fYw/hidCBR8g8JeJuNVxx3iu/KbGsEylsSg0YObXpOOIS9TQ5P6GUpmw1Ib
 5UtWxZXPFcGc7mqu7VeuJTWh4YesAsm+v2fWd3gs2meIJfBGbbukHy06CXyW+CoeO9Qf
 lq9+AJjshOlCSSX/Rv5xd/nGV9DI3K5ozJZfJPTGAItcywTOuuSK/xOWr3kUS0EA8oKd
 4whxxH8ePHevOUkD8nZVX5EDlB3Rn3hyWLxQiNogpa/A0kYwIgyBLnMmw9fnStbofyVI
 NjwA==
X-Gm-Message-State: AOJu0YwiRSLJSkLW8Bf0LtNrqqyH9FxnTwkTzLQ+DA/vYtHUvPMik5vc
 lawkWWBPngyu3yWyxPx0ms0QbsHECwLUllZteRw=
X-Google-Smtp-Source: AGHT+IGaKfoJ1XkQ6VsFq+G1z6Q/L93f5jtJ/0OdYc8ayBdu/SqyqyISU2f+/23SUG39M/ZO5cBbBgDTn8ksiD3d97Y=
X-Received: by 2002:a17:907:7758:b0:99c:6692:7f76 with SMTP id
 kx24-20020a170907775800b0099c66927f76mr4571158ejc.16.1693489337965; Thu, 31
 Aug 2023 06:42:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230831123922.105200-1-clg@kaod.org>
 <20230831123922.105200-6-clg@kaod.org>
 <CACPK8XdiTpONmuLag5HnTCPXtoz+Zg-Yo+rrzt+Wuz17hbdDRg@mail.gmail.com>
 <a35c9605-7bea-0252-359e-86855e8ee304@kaod.org>
In-Reply-To: <a35c9605-7bea-0252-359e-86855e8ee304@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 31 Aug 2023 13:42:06 +0000
Message-ID: <CACPK8Xd_XXTStxrNkx36TtE7dfRR2yG0oS3Mfa62F3ap-52OHg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] aspeed: Create flash devices only when defaults
 are enabled
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x636.google.com
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

On Thu, 31 Aug 2023 at 13:22, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 8/31/23 15:00, Joel Stanley wrote:
> > On Thu, 31 Aug 2023 at 12:39, C=C3=A9dric Le Goater <clg@kaod.org> wrot=
e:
> >>
> >> When the -nodefaults option is set, flash devices should be created
> >> with :
> >>
> >>      -blockdev node-name=3Dfmc0,driver=3Dfile,filename=3D./flash.img \
> >>      -device mx66u51235f,cs=3D0x0,bus=3Dssi.0,drive=3Dfmc0 \
> >>
> >> To be noted that in this case, the ROM will not be installed and the
> >> initial boot sequence (U-Boot loading) will fetch instructions using
> >> SPI transactions which is significantly slower. That's exactly how HW
> >> operates though.
> >>
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >
> > I think this is the first foray for the aspeed machines into
> > nodefaults removing things that previously would have just worked.
>
> This is true. It is change from the previous behavior.
>
> QEMU should probably complain if no fmc0 are found to boot from.
> Would that be ok ? And yes, documentation needs some update.

I didn't consider warning. That would help users who blindly added
-nodefaults and wondered why nothing was happening.

This is what happens if you add -nodefaults to an "old" command line
with your patch applied:

$ ./build/qemu-system-arm -M rainier-bmc -nographic -nodefaults
-serial stdio -drive
file=3Dobmc-phosphor-image-rainier.static.mtd,if=3Dmtd,format=3Draw
qemu-system-arm: -drive
file=3Dobmc-phosphor-image-rainier.static.mtd,if=3Dmtd,format=3Draw: machin=
e
type does not support if=3Dmtd,bus=3D0,unit=3D0

Which at least isn't sitting there spinning, as I was worried. I'll
leave it to you as to whether it needs a helpful message.

Cheers,

Joel



>
> Thanks,
>
> C.
>
> > I
> > know we haven't had it in our recommended command lines for a long
> > time, so that's fine.
> >
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> >
> > Should the content of your commit message go in the docs?
> >
> >> ---
> >>   hw/arm/aspeed.c | 6 ++++--
> >>   1 file changed, 4 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> >> index cd92cf9ce0bb..271512ce5ced 100644
> >> --- a/hw/arm/aspeed.c
> >> +++ b/hw/arm/aspeed.c
> >> @@ -396,12 +396,14 @@ static void aspeed_machine_init(MachineState *ma=
chine)
> >>       connect_serial_hds_to_uarts(bmc);
> >>       qdev_realize(DEVICE(&bmc->soc), NULL, &error_abort);
> >>
> >> -    aspeed_board_init_flashes(&bmc->soc.fmc,
> >> +    if (defaults_enabled()) {
> >> +        aspeed_board_init_flashes(&bmc->soc.fmc,
> >>                                 bmc->fmc_model ? bmc->fmc_model : amc-=
>fmc_model,
> >>                                 amc->num_cs, 0);
> >> -    aspeed_board_init_flashes(&bmc->soc.spi[0],
> >> +        aspeed_board_init_flashes(&bmc->soc.spi[0],
> >>                                 bmc->spi_model ? bmc->spi_model : amc-=
>spi_model,
> >>                                 1, amc->num_cs);
> >> +    }
> >>
> >>       if (machine->kernel_filename && sc->num_cpus > 1) {
> >>           /* With no u-boot we must set up a boot stub for the seconda=
ry CPU */
> >> --
> >> 2.41.0
> >>
>


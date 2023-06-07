Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D103E7256ED
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 10:06:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6oBC-0007gg-Sm; Wed, 07 Jun 2023 04:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6oB7-0007dG-Ip; Wed, 07 Jun 2023 04:06:01 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6oB5-0006vm-UR; Wed, 07 Jun 2023 04:06:01 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5169f614977so430494a12.3; 
 Wed, 07 Jun 2023 01:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1686125158; x=1688717158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7PWrZD7tdX0THKKfBC61FMRNJM2p3t1gV6Gtlaj72Y=;
 b=EqSwEs9r6MZisz4sLoeuBgI2UnCb9npw+pRo0aVwPUZrGTTsSrDPQlPHg6sOICYgUN
 BXrCCiVvjTnU3I0Mp9h5zDKQmdcIOjCR4MRYGJGjNsAd0g3Rl5JxqMSz0a/+mKe8ACJM
 uL4VJ3ydn6Q4nYdVDN4umAK60cuSll8M8hMps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686125158; x=1688717158;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x7PWrZD7tdX0THKKfBC61FMRNJM2p3t1gV6Gtlaj72Y=;
 b=EsZleAMWb5NWjtc6VaXAMT6McLQR4TY/pTt8b/Cc4BF5FbW9rUuKbskI8qIWsD+pNd
 iL5oxWOgWL4UgSjt9jixtUmrOekH3aVvPnX1LjxAioC/i27txxtYBS354JyqZAoGU8OS
 UU5F0r9fZYCV9Ra/96ZR97HSRgB47F+vMX/zCrIw9k6k+wLGsYkibAjfftWkIhXlMpxv
 zRVRSE1Awad6P5v64XBwx1SKcuABwFQSJNestK/oLRCByMUfSvEcpkw2b1Z6qWDOtfiG
 Iep2ddpNNI23HgVWsvjEdnScfRzsftINF18rnserhz6pD8123jYFJMrAtoI6vLCT9BUD
 YB+g==
X-Gm-Message-State: AC+VfDwzVmiWfoYddIzN27EropP30e9Kx/x6xmMF7s4tzelmgHFuiJwD
 N7Qs5DGWn3hHae4LcIbgrmSE7FH2jBz9l+Eeb7o=
X-Google-Smtp-Source: ACHHUZ6zRfmZMwk6Ca/ZLXytups2wbYDVlZwHvIdGCV22okpqgB4QbleJxUanT3iszMmvwyilThoYMAotLkiia6/IoM=
X-Received: by 2002:a17:906:d54a:b0:96f:cb13:8715 with SMTP id
 cr10-20020a170906d54a00b0096fcb138715mr5053454ejc.69.1686125157893; Wed, 07
 Jun 2023 01:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-4-clg@kaod.org>
In-Reply-To: <20230607043943.1837186-4-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 7 Jun 2023 08:05:45 +0000
Message-ID: <CACPK8Xf-9xeYf4wwcBHLLbx3Bt-KiB=_0ZJbTc=P-H874Lbzfw@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] aspeed: Use the boot_rom region of the fby35
 machine
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Delevoryas <peter@pjd.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=joel.stan@gmail.com; helo=mail-ed1-x52f.google.com
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
> This change completes commits 5aa281d757 ("aspeed: Introduce a
> spi_boot region under the SoC") and 8b744a6a47 ("aspeed: Add a
> boot_rom overlap region in the SoC spi_boot container") which
> introduced a spi_boot container at the SoC level to map the boot rom
> region as an overlap.
>
> It also fixes a Coverity report (CID 1508061) for a memory leak
> warning when the QEMU process exits by using an bmc_boot_rom
> MemoryRegion available at the machine level.
>
> Cc: Peter Delevoryas <peter@pjd.dev>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/arm/fby35.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/hw/arm/fby35.c b/hw/arm/fby35.c
> index f4600c290b62..f2ff6c1abfd9 100644
> --- a/hw/arm/fby35.c
> +++ b/hw/arm/fby35.c
> @@ -70,8 +70,6 @@ static void fby35_bmc_write_boot_rom(DriveInfo *dinfo, =
MemoryRegion *mr,
>
>  static void fby35_bmc_init(Fby35State *s)
>  {
> -    DriveInfo *drive0 =3D drive_get(IF_MTD, 0, 0);
> -
>      object_initialize_child(OBJECT(s), "bmc", &s->bmc, "ast2600-a3");
>
>      memory_region_init(&s->bmc_memory, OBJECT(&s->bmc), "bmc-memory",
> @@ -95,18 +93,21 @@ static void fby35_bmc_init(Fby35State *s)
>      aspeed_board_init_flashes(&s->bmc.fmc, "n25q00", 2, 0);
>
>      /* Install first FMC flash content as a boot rom. */
> -    if (drive0) {
> -        AspeedSMCFlash *fl =3D &s->bmc.fmc.flashes[0];
> -        MemoryRegion *boot_rom =3D g_new(MemoryRegion, 1);
> -        uint64_t size =3D memory_region_size(&fl->mmio);
> -
> -        if (!s->mmio_exec) {
> -            memory_region_init_rom(boot_rom, NULL, "aspeed.boot_rom",
> -                                   size, &error_abort);
> -            memory_region_add_subregion(&s->bmc_memory, FBY35_BMC_FIRMWA=
RE_ADDR,
> -                                        boot_rom);
> -            fby35_bmc_write_boot_rom(drive0, boot_rom, FBY35_BMC_FIRMWAR=
E_ADDR,
> -                                     size, &error_abort);
> +    if (!s->mmio_exec) {
> +        DriveInfo *mtd0 =3D drive_get(IF_MTD, 0, 0);
> +
> +        if (mtd0) {
> +            AspeedSoCState *bmc =3D &s->bmc;
> +            uint64_t rom_size =3D memory_region_size(&bmc->spi_boot);
> +
> +            memory_region_init_rom(&s->bmc_boot_rom, NULL, "aspeed.boot_=
rom",
> +                                   rom_size, &error_abort);
> +            memory_region_add_subregion_overlap(&bmc->spi_boot_container=
, 0,
> +                                                &s->bmc_boot_rom, 1);
> +
> +            fby35_bmc_write_boot_rom(mtd0, &s->bmc_boot_rom,
> +                                     FBY35_BMC_FIRMWARE_ADDR,
> +                                     rom_size, &error_abort);
>          }
>      }
>  }
> --
> 2.40.1
>


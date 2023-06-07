Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FF7725C33
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 12:56:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6qpc-0006Pn-OD; Wed, 07 Jun 2023 06:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6qpZ-0006O9-RJ; Wed, 07 Jun 2023 06:55:57 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1q6qpY-0001jF-By; Wed, 07 Jun 2023 06:55:57 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9768fd99c0cso97682666b.0; 
 Wed, 07 Jun 2023 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1686135354; x=1688727354;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ib/4dh6/10KWhyrEZa+6Se/dqChCjxMLXkvXYuPbCas=;
 b=R3929sJQOd3me3oyX/IeFlAZ8irxYnxqKjkGvR6eD+Qj8KztoaxszFUVKclB+Q5ARG
 wy979yaZQO0LozEnp2WypER1A6XMXKdIsH36vIb2x1jaqfW0i9xshHNYpa9hqR+FIMk1
 k4kfxX2CsoOGkF/yE1AsdfmJZqYMVmApEEBu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686135354; x=1688727354;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ib/4dh6/10KWhyrEZa+6Se/dqChCjxMLXkvXYuPbCas=;
 b=Vr7XBAx9plpzOQoFHtgYIWpmKnpHfqTQw+5/RFta8s0lUu9lPPK5ZneL9m3OBP7YBe
 BpGUihlTzzfLV5B1ChVvAm9C9W7hz3z3ZGb9OKjzhtVvuaak1Y5JzYjUX5Q4+DwXMD0y
 Svhp9C7RtAdUqM0Am7g0Erwy0X3UW3+EdySocQgflLdtoXKFYShlEOOAmy4KsaFhAC3a
 oTmK1IANjvkdeyCqSHIinbJ8R4G/PRbtm6CCbcBtSEWYcCeAi2GWzuFWLrptYyqtPi6W
 M0j3ecgoAXKz1UWiv7di/SW9t44pZlaCztaksyn1litYx/Jt0RBPwb0rrWzxVRD1xGHq
 Kfdg==
X-Gm-Message-State: AC+VfDx+uArmdkON7eSfhz9AyWTAqnF8gSS7OaHFs55xgjQUgxvFkGmy
 mmRUyBkiznF+VuQyGUDRoppm8SVkLFGve30SpXxVuWdv
X-Google-Smtp-Source: ACHHUZ5OWLhg9xnViueXXuzeGCKXIxR656u0pUe8g7sscJ2XTKKZKpsY3QBs9QFXj6cS8TMjcOT2HjgYXB9jMOwUHfs=
X-Received: by 2002:a17:907:9816:b0:978:2b56:d76e with SMTP id
 ji22-20020a170907981600b009782b56d76emr6153261ejc.12.1686135354281; Wed, 07
 Jun 2023 03:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-11-clg@kaod.org>
In-Reply-To: <20230607043943.1837186-11-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 7 Jun 2023 10:55:41 +0000
Message-ID: <CACPK8XfwFKB6rNq5SU=CbRNTdMEn18wk6jA2K72XdhXxVLF1mg@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] aspeed: Get the BlockBackend of FMC0 from the
 flash device
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x62b.google.com
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
> and get rid of an unnecessary drive_get(IF_MTD) call.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  hw/arm/aspeed.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index efc112ca37b0..8beed0c2a66e 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -15,6 +15,7 @@
>  #include "hw/arm/aspeed.h"
>  #include "hw/arm/aspeed_soc.h"
>  #include "hw/arm/aspeed_eeprom.h"
> +#include "hw/block/flash.h"
>  #include "hw/i2c/i2c_mux_pca954x.h"
>  #include "hw/i2c/smbus_eeprom.h"
>  #include "hw/misc/pca9552.h"
> @@ -427,11 +428,12 @@ static void aspeed_machine_init(MachineState *machi=
ne)
>      }
>
>      if (!bmc->mmio_exec) {
> -        DriveInfo *mtd0 =3D drive_get(IF_MTD, 0, 0);
> +        DeviceState *dev =3D ssi_get_cs(bmc->soc.fmc.spi, 0);
> +        BlockBackend *fmc0 =3D dev ? m25p80_get_blk(dev) : NULL;
>
> -        if (mtd0) {
> +        if (fmc0) {
>              uint64_t rom_size =3D memory_region_size(&bmc->soc.spi_boot)=
;
> -            aspeed_install_boot_rom(bmc, blk_by_legacy_dinfo(mtd0), rom_=
size);
> +            aspeed_install_boot_rom(bmc, fmc0, rom_size);
>          }
>      }
>
> --
> 2.40.1
>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B43A67ABE1E
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 08:35:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjwEC-0004Xm-1j; Sat, 23 Sep 2023 02:34:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjwE9-0004XW-4J
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 02:34:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qjwE7-0000MP-0g
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 02:34:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695450889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xY0RE85F9Zj48GXlDh1ZscB2JLhkKIE5yrvgqmbFlws=;
 b=Ow+Ez2yFOwMo8NwTpalwdMryirEq911kaYmg4/RZjQZEfkbK+519rsEfGLe9aPsfEH3BQD
 LcIwJkxvtNUioB/HoPDcNduW3VQZoPegyOBaqblp6A2ihZqONTW3JsMkbWkZNoopt/mE/p
 0C4zpqq1GWIacbyXPtzLKKBA9I8wCCk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-540-_dsdcnLWNnSY204rsiukSA-1; Sat, 23 Sep 2023 02:34:44 -0400
X-MC-Unique: _dsdcnLWNnSY204rsiukSA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B0BD85A5BE;
 Sat, 23 Sep 2023 06:34:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47B22711282;
 Sat, 23 Sep 2023 06:34:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 57DC821E6900; Sat, 23 Sep 2023 08:34:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: qemu-arm@nongnu.org,  qemu-devel@nongnu.org,  Joel Stanley
 <joel@jms.id.au>,  Andrew Jeffery <andrew@aj.id.au>
Subject: Re: [PATCH 2/4] aspeed: Clean up local variable shadowing
References: <20230922155924.1172019-1-clg@kaod.org>
 <20230922155924.1172019-3-clg@kaod.org>
Date: Sat, 23 Sep 2023 08:34:43 +0200
In-Reply-To: <20230922155924.1172019-3-clg@kaod.org> (=?utf-8?Q?=22C=C3=A9?=
 =?utf-8?Q?dric?= Le Goater"'s
 message of "Fri, 22 Sep 2023 17:59:22 +0200")
Message-ID: <87pm29mm7w.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> Remove superfluous local 'irq' variables and use the one define at the
> top of the routine. This fixes warnings in aspeed_soc_ast2600_realize()
> such as :
>
>   ../hw/arm/aspeed_ast2600.c: In function =E2=80=98aspeed_soc_ast2600_rea=
lize=E2=80=99:
>   ../hw/arm/aspeed_ast2600.c:420:18: warning: declaration of =E2=80=98irq=
=E2=80=99 shadows a previous local [-Wshadow=3Dcompatible-local]
>     420 |         qemu_irq irq =3D aspeed_soc_get_irq(s, ASPEED_DEV_TIMER=
1 + i);
>         |                  ^~~
>   ../hw/arm/aspeed_ast2600.c:312:14: note: shadowed declaration is here
>     312 |     qemu_irq irq;
>         |              ^~~
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/arm/aspeed_ast2600.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index a8b3a8065a11..e122e1c32d42 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -388,7 +388,7 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)
>      aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->timerctrl), 0,
>                      sc->memmap[ASPEED_DEV_TIMER1]);
>      for (i =3D 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
> -        qemu_irq irq =3D aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
> +        irq =3D aspeed_soc_get_irq(s, ASPEED_DEV_TIMER1 + i);
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->timerctrl), i, irq);
>      }
>=20=20
> @@ -413,8 +413,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)
>      }
>      aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i2c), 0, sc->memmap[ASPEED_DEV=
_I2C]);
>      for (i =3D 0; i < ASPEED_I2C_GET_CLASS(&s->i2c)->num_busses; i++) {
> -        qemu_irq irq =3D qdev_get_gpio_in(DEVICE(&s->a7mpcore),
> -                                        sc->irqmap[ASPEED_DEV_I2C] + i);
> +        irq =3D qdev_get_gpio_in(DEVICE(&s->a7mpcore),
> +                               sc->irqmap[ASPEED_DEV_I2C] + i);
>          /* The AST2600 I2C controller has one IRQ per bus. */
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->i2c.busses[i]), 0, irq);
>      }
> @@ -611,8 +611,8 @@ static void aspeed_soc_ast2600_realize(DeviceState *d=
ev, Error **errp)
>      }
>      aspeed_mmio_map(s, SYS_BUS_DEVICE(&s->i3c), 0, sc->memmap[ASPEED_DEV=
_I3C]);
>      for (i =3D 0; i < ASPEED_I3C_NR_DEVICES; i++) {
> -        qemu_irq irq =3D qdev_get_gpio_in(DEVICE(&s->a7mpcore),
> -                                        sc->irqmap[ASPEED_DEV_I3C] + i);
> +        irq =3D qdev_get_gpio_in(DEVICE(&s->a7mpcore),
> +                               sc->irqmap[ASPEED_DEV_I3C] + i);
>          /* The AST2600 I3C controller has one IRQ per bus. */
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->i3c.devices[i]), 0, irq);
>      }

Clashes with Philippe's

    [PATCH v2 10/22] hw/arm/aspeed: Clean up local variable shadowing
    Message-ID: <20230904161235.84651-11-philmd@linaro.org>

The difference is a matter of taste: one @irq in function scope vs. four
in nested scopes.  I'd prefer the former, i.e. this patch, but
maintainers' preference matter more than mine.  If you want me to merge
together with other shadowing patches, tell me your preference, if any.



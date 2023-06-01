Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 752847192E4
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 08:01:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4bLg-0002BQ-Gk; Thu, 01 Jun 2023 01:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q4bLe-0002Ap-1n
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 01:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1q4bLc-00020p-2I
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 01:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685599182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c4+nJawB5C/rpOtXXJPGg1t+YY5vW5g1GOG7XGwr1/8=;
 b=Bb5S9MCASQ1bweD4ExxgsROc9Z5V1GqBN2QXRTbUFufmfEVCyXeEuHUZBw+u6jNqdHBKVF
 6Lp04TBP4OeH2pT6IHaojyXrf2HofruVwe8ZRMs/54Pgsw5FBIiAwOa8IM350YUS/wgWxs
 lAsv6IxSl8dTWiUriaPR8hWCogWFvL0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-Y6dswbWWOYq4fL-wNMgC9Q-1; Thu, 01 Jun 2023 01:59:36 -0400
X-MC-Unique: Y6dswbWWOYq4fL-wNMgC9Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAB5E1C05137;
 Thu,  1 Jun 2023 05:59:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 914C4492B0A;
 Thu,  1 Jun 2023 05:59:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7CD2021E692E; Thu,  1 Jun 2023 07:59:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org,  qemu-ppc@nongnu.org,  Eduardo Habkost
 <eduardo@habkost.net>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 7/7] hw: Simplify using sysbus_init_irqs() [manual]
References: <20230531223341.34827-1-philmd@linaro.org>
 <20230531223341.34827-8-philmd@linaro.org>
Date: Thu, 01 Jun 2023 07:59:34 +0200
In-Reply-To: <20230531223341.34827-8-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu, 1 Jun 2023 00:33:41
 +0200")
Message-ID: <87mt1jafjt.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Audit the sysbus_init_irq() calls and manually convert
> to sysbus_init_irqs() when a loop is involved.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/intc/loongarch_extioi.c | 3 +--
>  hw/intc/omap_intc.c        | 3 +--
>  hw/pci-host/gpex.c         | 2 +-
>  hw/timer/renesas_tmr.c     | 9 +++------
>  4 files changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
> index db941de20e..c579636215 100644
> --- a/hw/intc/loongarch_extioi.c
> +++ b/hw/intc/loongarch_extioi.c
> @@ -275,8 +275,7 @@ static void loongarch_extioi_instance_init(Object *ob=
j)
>      LoongArchExtIOI *s =3D LOONGARCH_EXTIOI(obj);
>      int cpu, pin;
>=20=20
> -    sysbus_init_irqs(SYS_BUS_DEVICE(dev), s->irq, EXTIOI_IRQS);
> -
> +    sysbus_init_irqs(dev, s->irq, EXTIOI_IRQS);

Commit message claims "when a loop is involved".  No loop here.  That
work was actually done in the previous patch:

  diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
  index 0e7a3e32f3..db941de20e 100644
  --- a/hw/intc/loongarch_extioi.c
  +++ b/hw/intc/loongarch_extioi.c
  @@ -273,11 +273,9 @@ static void loongarch_extioi_instance_init(Object *o=
bj)
   {
       SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);
       LoongArchExtIOI *s =3D LOONGARCH_EXTIOI(obj);
  -    int i, cpu, pin;
  +    int cpu, pin;

  -    for (i =3D 0; i < EXTIOI_IRQS; i++) {
  -        sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq[i]);
  -    }
  +    sysbus_init_irqs(SYS_BUS_DEVICE(dev), s->irq, EXTIOI_IRQS);

       qdev_init_gpio_in(DEVICE(obj), extioi_setirq, EXTIOI_IRQS);

In this patch, you merely delete a superfluous type conversion that is
present even before your series.

There are more of them in this function.  Please delete them all, and in
a separate patch.

Actually, there are more elsewhere.  Coccinelle script

    @@
    typedef SysBusDevice;
    SysBusDevice *dev;
    @@
    -    SYS_BUS_DEVICE(dev)
    +    dev

finds some in hw/arm/xlnx-versal.c and hw/rx/rx62n.c, too.

Would be nice to do this for every QOM type, but I don't know how
without duplicating the semantic patch for each of them.  There are
almost 150 uses os OBJECT_DECLARE_TYPE()...

You might want to address this in a separate series, to not delay this
one.

>      qdev_init_gpio_in(DEVICE(obj), extioi_setirq, EXTIOI_IRQS);
>=20=20
>      for (cpu =3D 0; cpu < EXTIOI_CPUS; cpu++) {
> diff --git a/hw/intc/omap_intc.c b/hw/intc/omap_intc.c
> index 647bf324a8..f324b640e3 100644
> --- a/hw/intc/omap_intc.c
> +++ b/hw/intc/omap_intc.c
> @@ -627,8 +627,7 @@ static void omap2_intc_init(Object *obj)
>=20=20
>      s->level_only =3D 1;
>      s->nbanks =3D 3;
> -    sysbus_init_irq(sbd, &s->parent_intr[0]);
> -    sysbus_init_irq(sbd, &s->parent_intr[1]);
> +    sysbus_init_irqs(sbd, s->parent_intr, ARRAY_SIZE(s->parent_intr));

Unrolled loop.  s->parent_intr[] indeed has 2 elements.  Okay.

>      qdev_init_gpio_in(dev, omap_set_intr_noedge, s->nbanks * 32);
>      memory_region_init_io(&s->mmio, obj, &omap2_inth_mem_ops, s,
>                            "omap2-intc", 0x1000);

[...]



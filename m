Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7B682C6BD
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 22:34:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOP9b-0000Cn-1q; Fri, 12 Jan 2024 16:33:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rOP9X-0000CL-MU; Fri, 12 Jan 2024 16:33:23 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rOP9V-0005jf-GL; Fri, 12 Jan 2024 16:33:23 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 810371F393;
 Fri, 12 Jan 2024 21:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705095198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahxnVnXxpZSNcR24q3h+Stwk7Ct/k/IcNC9dnQQCRro=;
 b=RXSJ0KUlqlQb94jSMgnp7KY9dXKkHSCZEh1sV8b3m3o9TYXbHI73yo1NZ1KQxW/Tzl/LeE
 pXzbmpsYcu9uoKrYqyZ4lMbq92JWJqa1w6GBLsGfFPuyG8OJGhAKZObko60kzZ5Df5x59L
 b94P8wuHtbTalHlvUYDQxhUKSBaTdyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705095198;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahxnVnXxpZSNcR24q3h+Stwk7Ct/k/IcNC9dnQQCRro=;
 b=yaYeNV6UEMNmmPIPTKJt+ETLNGj72p/vAsfoPvAr8h7OJ3uzHB8I9/mtfPsH9StIUksQPL
 5C9w4j7VJyFqGDCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705095197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahxnVnXxpZSNcR24q3h+Stwk7Ct/k/IcNC9dnQQCRro=;
 b=Xj0mUNWGvi+WcpUhHsMUi8zIrFTjnYi3K/JsAekN6k/ZWHtzC/lTKjkiWLGS6fi2oFNjOC
 sNtGC0sZARBtrflv6+KeYAlu9DiAu0BLIlw76By0z0j6/JoDsyl1ItaDZdW1WwZJr6hsOY
 2zmA7FQZVfRfRaSPt+mXW5wR/YmEy8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705095197;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahxnVnXxpZSNcR24q3h+Stwk7Ct/k/IcNC9dnQQCRro=;
 b=ky2udXbPYlbgiy6Rz5p+ZbXAQMsVcGw2V8z8S1+kWW1NjLxA12i7rYezMxAv1fsSxEdNI3
 yfE3j2tyLpv5dMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F311E136A4;
 Fri, 12 Jan 2024 21:33:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id p1jmLRywoWXlcQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 12 Jan 2024 21:33:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>,
 Anton Johansson <anjo@rev.ng>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Jean-Christophe Dubois
 <jcd@tribudubois.net>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 14/33] hw/cpu/arm: Handle 'has_el2/3' properties once in
 MPCore parent
In-Reply-To: <20231212162935.42910-15-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
 <20231212162935.42910-15-philmd@linaro.org>
Date: Fri, 12 Jan 2024 18:33:13 -0300
Message-ID: <87y1cudyp2.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 BAYES_HAM(-3.00)[100.00%];
 URIBL_BLOCKED(0.00)[linaro.org:email];
 R_RATELIMIT(0.00)[to_ip_from(RLgn3pipxh44ye66tuwadwbnif)];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWELVE(0.00)[22];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[redhat.com,nuvoton.com,linaro.org,habkost.net,jms.id.au,alistair23.me,rev.ng,gmail.com,google.com,kaod.org,tribudubois.net,codeconstruct.com.au,kernel.org,nongnu.org,ilande.co.uk];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Move the 'has_el2' and 'has_el3' properties to the abstract
> QOM parent.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/cpu/cortex_mpcore.h |  5 +++++
>  hw/arm/exynos4210.c            | 10 ++++++++--
>  hw/arm/vexpress.c              |  6 ++++++
>  hw/arm/xilinx_zynq.c           |  6 ++++++
>  hw/cpu/a15mpcore.c             | 18 ++++++------------
>  hw/cpu/a9mpcore.c              |  5 +----
>  hw/cpu/cortex_mpcore.c         |  3 +++
>  7 files changed, 35 insertions(+), 18 deletions(-)
>
> diff --git a/include/hw/cpu/cortex_mpcore.h b/include/hw/cpu/cortex_mpcor=
e.h
> index 0e7cca9e93..387552468c 100644
> --- a/include/hw/cpu/cortex_mpcore.h
> +++ b/include/hw/cpu/cortex_mpcore.h
> @@ -30,6 +30,8 @@
>   * QEMU interface:
>   *  + QOM property "num-cores" which set the number of cores present in
>   *    the cluster.
> + *  + QOM properties "cpu-has-el3", "cpu-has-el2" which set whether the =
CPUs
> + *    have the exception level features present.
>   */
>  #define TYPE_CORTEX_MPCORE_PRIV "cortex_mpcore_priv"
>  OBJECT_DECLARE_TYPE(CortexMPPrivState, CortexMPPrivClass, CORTEX_MPCORE_=
PRIV)
> @@ -53,6 +55,9 @@ struct CortexMPPrivState {
>=20=20
>      /* Properties */
>      uint32_t num_cores;
> +
> +    bool cpu_has_el3;
> +    bool cpu_has_el2;
>  };
>=20=20
>  #define TYPE_A9MPCORE_PRIV "a9mpcore_priv"
> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
> index ea1364499d..7386a8fe57 100644
> --- a/hw/arm/exynos4210.c
> +++ b/hw/arm/exynos4210.c
> @@ -548,7 +548,7 @@ static void exynos4210_realize(DeviceState *socdev, E=
rror **errp)
>      Exynos4210State *s =3D EXYNOS4210_SOC(socdev);
>      MemoryRegion *system_mem =3D get_system_memory();
>      SysBusDevice *busdev;
> -    DeviceState *dev, *uart[4], *pl330[3];
> +    DeviceState *dev, *mpdev, *uart[4], *pl330[3];
>      int i, n;
>=20=20
>      for (n =3D 0; n < EXYNOS4210_NCPUS; n++) {
> @@ -582,7 +582,13 @@ static void exynos4210_realize(DeviceState *socdev, =
Error **errp)
>      }
>=20=20
>      /* Private memory region and Internal GIC */
> -    qdev_prop_set_uint32(DEVICE(&s->a9mpcore), "num-cores", EXYNOS4210_N=
CPUS);
> +    mpdev =3D DEVICE(&s->a9mpcore);
> +    qdev_prop_set_uint32(mpdev, "num-cores", EXYNOS4210_NCPUS);
> +    /*
> +     * By default A9 CPUs have EL3 enabled.  This board does not current=
ly
> +     * support EL3 so the CPU EL3 property is disabled before realizatio=
n.
> +     */
> +    qdev_prop_set_bit(mpdev, "cpu-has-el3", false);
>      busdev =3D SYS_BUS_DEVICE(&s->a9mpcore);
>      sysbus_realize(busdev, &error_fatal);
>      sysbus_mmio_map(busdev, 0, EXYNOS4210_SMP_PRIVATE_BASE_ADDR);
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index a320d1c181..294b6f15f2 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -239,6 +239,12 @@ static void init_cpus(MachineState *ms, const char *=
cpu_type,
>       * wires itself up to the CPU's generic_timer gpio out lines.
>       */
>      dev =3D qdev_new(privdev);
> +    if (!secure) {
> +        qdev_prop_set_bit(dev, "cpu-has-el3", false);
> +    }
> +    if (!virt) {
> +        qdev_prop_set_bit(dev, "cpu-has-el2", false);
> +    }
>      qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
>      busdev =3D SYS_BUS_DEVICE(dev);
>      sysbus_realize_and_unref(busdev, &error_fatal);
> diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> index fc9c927d09..28430dcfba 100644
> --- a/hw/arm/xilinx_zynq.c
> +++ b/hw/arm/xilinx_zynq.c
> @@ -240,6 +240,12 @@ static void zynq_init(MachineState *machine)
>=20=20
>      dev =3D qdev_new(TYPE_A9MPCORE_PRIV);
>      qdev_prop_set_uint32(dev, "num-cpu", 1);
> +    /*
> +     * By default A9 CPUs have EL3 enabled.  This board does not
> +     * currently support EL3 so the CPU EL3 property is disabled before
> +     * realization.
> +     */
> +    qdev_prop_set_bit(dev, "cpu-has-el3", false);
>      busdev =3D SYS_BUS_DEVICE(dev);
>      sysbus_realize_and_unref(busdev, &error_fatal);
>      sysbus_mmio_map(busdev, 0, MPCORE_PERIPHBASE);
> diff --git a/hw/cpu/a15mpcore.c b/hw/cpu/a15mpcore.c
> index 16874426e1..a16544fdde 100644
> --- a/hw/cpu/a15mpcore.c
> +++ b/hw/cpu/a15mpcore.c
> @@ -52,9 +52,6 @@ static void a15mp_priv_realize(DeviceState *dev, Error =
**errp)
>      SysBusDevice *gicsbd;
>      Error *local_err =3D NULL;
>      int i;
> -    bool has_el3;
> -    bool has_el2 =3D false;
> -    Object *cpuobj;
>=20=20
>      cc->parent_realize(dev, &local_err);
>      if (local_err) {
> @@ -70,14 +67,11 @@ static void a15mp_priv_realize(DeviceState *dev, Erro=
r **errp)
>          /* Make the GIC's TZ support match the CPUs. We assume that
>           * either all the CPUs have TZ, or none do.
>           */
> -        cpuobj =3D OBJECT(qemu_get_cpu(0));
> -        has_el3 =3D object_property_find(cpuobj, "has_el3") &&
> -            object_property_get_bool(cpuobj, "has_el3", &error_abort);
> -        qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
> +        qdev_prop_set_bit(gicdev, "has-security-extensions",
> +                          c->cpu_has_el3);
>          /* Similarly for virtualization support */
> -        has_el2 =3D object_property_find(cpuobj, "has_el2") &&
> -            object_property_get_bool(cpuobj, "has_el2", &error_abort);
> -        qdev_prop_set_bit(gicdev, "has-virtualization-extensions", has_e=
l2);
> +        qdev_prop_set_bit(gicdev, "has-virtualization-extensions",
> +                          c->cpu_has_el2);
>      }
>=20=20
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
> @@ -112,7 +106,7 @@ static void a15mp_priv_realize(DeviceState *dev, Erro=
r **errp)
>                                    qdev_get_gpio_in(gicdev,
>                                                     ppibase + timer_irq[i=
rq]));
>          }
> -        if (has_el2) {
> +        if (c->cpu_has_el2) {
>              /* Connect the GIC maintenance interrupt to PPI ID 25 */
>              sysbus_connect_irq(SYS_BUS_DEVICE(gicdev), i + 4 * c->num_co=
res,
>                                 qdev_get_gpio_in(gicdev, ppibase + 25));
> @@ -134,7 +128,7 @@ static void a15mp_priv_realize(DeviceState *dev, Erro=
r **errp)
>                                  sysbus_mmio_get_region(gicsbd, 0));
>      memory_region_add_subregion(&c->container, 0x2000,
>                                  sysbus_mmio_get_region(gicsbd, 1));
> -    if (has_el2) {
> +    if (c->cpu_has_el2) {
>          memory_region_add_subregion(&c->container, 0x4000,
>                                      sysbus_mmio_get_region(gicsbd, 2));
>          memory_region_add_subregion(&c->container, 0x6000,
> diff --git a/hw/cpu/a9mpcore.c b/hw/cpu/a9mpcore.c
> index 9c138f4442..54949314f8 100644
> --- a/hw/cpu/a9mpcore.c
> +++ b/hw/cpu/a9mpcore.c
> @@ -51,7 +51,6 @@ static void a9mp_priv_realize(DeviceState *dev, Error *=
*errp)
>      SysBusDevice *scubusdev, *gicbusdev, *gtimerbusdev, *mptimerbusdev,
>                   *wdtbusdev;
>      Error *local_err =3D NULL;
> -    bool has_el3;
>      CPUState *cpu0;
>      Object *cpuobj;
>=20=20
> @@ -86,9 +85,7 @@ static void a9mp_priv_realize(DeviceState *dev, Error *=
*errp)
>      /* Make the GIC's TZ support match the CPUs. We assume that
>       * either all the CPUs have TZ, or none do.
>       */
> -    has_el3 =3D object_property_find(cpuobj, "has_el3") &&
> -        object_property_get_bool(cpuobj, "has_el3", &error_abort);
> -    qdev_prop_set_bit(gicdev, "has-security-extensions", has_el3);
> +    qdev_prop_set_bit(gicdev, "has-security-extensions", c->cpu_has_el3);
>=20=20
>      if (!sysbus_realize(SYS_BUS_DEVICE(&s->gic), errp)) {
>          return;
> diff --git a/hw/cpu/cortex_mpcore.c b/hw/cpu/cortex_mpcore.c
> index d7ea633e4e..549b81f708 100644
> --- a/hw/cpu/cortex_mpcore.c
> +++ b/hw/cpu/cortex_mpcore.c
> @@ -27,6 +27,9 @@ static Property cortex_mpcore_priv_properties[] =3D {
>      DEFINE_PROP_UINT32("num-cores", CortexMPPrivState, num_cores, 1),
>      DEFINE_PROP_UINT32("num-cpu", CortexMPPrivState, num_cores, 1), /* a=
lias */
>=20=20
> +    DEFINE_PROP_BOOL("cpu-has-el3", CortexMPPrivState, cpu_has_el3, true=
),
> +    DEFINE_PROP_BOOL("cpu-has-el2", CortexMPPrivState, cpu_has_el2, fals=
e),

Are we missing setting cpu_has_el2 somewhere else? This^ results in fewer
cpregs being registered and is what breaks migration.

You can test with:

$ (echo "migrate file:migfile"; echo "quit") | ./qemu-system-arm -M ast2600=
-evb -monitor stdio
$ ./scripts/analyze-migration.py -f migfile | grep array_len

Before series:
$ ./scripts/analyze-migration.py -f migfile | grep array_len
        "cpreg_vmstate_array_len": "0x0000010a",
        "cpreg_vmstate_array_len": "0x0000010a",

After series:
$ ./scripts/analyze-migration.py -f migfile | grep array_len
        "cpreg_vmstate_array_len": "0x000000df",
        "cpreg_vmstate_array_len": "0x000000df",


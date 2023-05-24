Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9471F70F9ED
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:19:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1qFS-00053x-7O; Wed, 24 May 2023 11:17:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1q1qFP-00052v-Ht
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:17:56 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1q1qFN-0003kL-IL
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:17:55 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ae52ce3250so3717645ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 08:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1684941471; x=1687533471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aqer011XrU8QhlLWL3VDVFSSZ44UDQ23B1rg3lZglNU=;
 b=jBNov6dUmetFuYmtOyd2dntEmACdnH96b2Z9CFqmn7lnA2cinRUqFdAtIAUj0SAT0E
 AdwDUVfusZ1Hc0lKaCOhvAnYk7tg5EvEaT9oBF2FzaYkAJBCmygrbXbJ+byMB+lwoXCw
 QedMkvc7ercrDqca1iCYh8+UDubh81URyafXM7u6dh9MK9ww3nZ23aiCZVtyeI7xAMk2
 5FPBYeSwfAtThvIpsNE3fQ59TLP4880ABtn+2NJ67IW73oh6xB6lKfZ1+6QFltExnRQW
 y0ueAAIqDJwN5h9TekS6pGncjEr5Km1LWZcc8yQIqf6/zwi1wkbSRnmXwE8DTdWklz6F
 I2og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684941471; x=1687533471;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aqer011XrU8QhlLWL3VDVFSSZ44UDQ23B1rg3lZglNU=;
 b=IkyTvmaXpGNJ7Pd/Y0VuQrP1ijcDmRk7FyUQFeMS/vEedeWRh1ipkkKUVlP4kpG6En
 HEXhx7Cqe7BenGrN3RQuFHBZmuyqZZtDvtZOyMnaAXfrfLC+ExLzjurGgTr5ij2YTZcm
 Owq+QfmqESNHN/vQdr65uykAPnnh0qqx7tvgjYmV9SYoyjr1KxXybkH7pkjZ5a+Vi22Y
 rYYxI4K90FddCICJMDU+qwF4EIp1+87Vh+o7KA/BCaFfGaSrqni1+zENUVzH9kZuV0hQ
 K5a4ef2BW2DpcOMU1KWWXPo7mADJ58Qvc1mDA3VkwyGKbQUvwdVz9X8PiEYyLCCUGNJK
 5M7Q==
X-Gm-Message-State: AC+VfDwSgCs6JsHq8h8pLfsRG11rUuEYqVrHqvyNM4gzuua6hX3v8rDS
 yS2jabzbhmMW8xfivwYsFJ+dRmBg8GZE+fkq9qrdbw==
X-Google-Smtp-Source: ACHHUZ4ZsL7+OZfNCcKhV6rWYzlv/625WkZb1gFftUIBFmfRzmzdqItHMrmszh2tpJt3FWTL9wb94zSAvISynzNEqFc=
X-Received: by 2002:a17:902:6bc2:b0:1ae:6e7b:9bb4 with SMTP id
 m2-20020a1709026bc200b001ae6e7b9bb4mr15649550plt.59.1684941471069; Wed, 24
 May 2023 08:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230524143714.565792-1-chigot@adacore.com>
 <14ef3e93-65b2-5c27-5126-3a67e73dc9da@linaro.org>
In-Reply-To: <14ef3e93-65b2-5c27-5126-3a67e73dc9da@linaro.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 24 May 2023 17:17:40 +0200
Message-ID: <CAJ307EjQMw_sg-2wNRqOSSC8OjXn5Z_4mdYZZBZTOnfEaZaVwA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/xlnx-zynqmp: fix unsigned error when checking the
 RPUs number
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, edgar.iglesias@gmail.com, 
 alistair@alistair23.me, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=chigot@adacore.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 24, 2023 at 5:06=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Cl=C3=A9ment,
>
> On 24/5/23 16:37, Cl=C3=A9ment Chigot wrote:
> > When passing --smp with a number lower than XLNX_ZYNQMP_NUM_APU_CPUS,
> > the expression (ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS) will result
> > in a positive number as ms->smp.cpus is a unsigned int.
> > This will raise the following error afterwards, as Qemu will try to
> > instantiate some additional RPUs.
> >    | $ qemu-system-aarch64 --smp 1 -M xlnx-zcu102
> >    | **
> >    | ERROR:../src/tcg/tcg.c:777:tcg_register_thread:
> >    |   assertion failed: (n < tcg_max_ctxs)
> >
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> > ---
> >   hw/arm/xlnx-zynqmp.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> > index 335cfc417d..5905a33015 100644
> > --- a/hw/arm/xlnx-zynqmp.c
> > +++ b/hw/arm/xlnx-zynqmp.c
> > @@ -213,7 +213,7 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms=
, XlnxZynqMPState *s,
> >                                      const char *boot_cpu, Error **errp=
)
> >   {
> >       int i;
> > -    int num_rpus =3D MIN(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS,
> > +    int num_rpus =3D MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS=
),
> >                          XLNX_ZYNQMP_NUM_RPU_CPUS);
> >
> >       if (num_rpus <=3D 0) {
>
> Can we set mc->min_cpus in xlnx_zcu102_machine_class_init() instead?
>
> -- >8 --
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index 4c84bb932a..60a2710e21 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -269,6 +269,7 @@ static void
> xlnx_zcu102_machine_class_init(ObjectClass *oc, void *data)
>       mc->block_default_type =3D IF_IDE;
>       mc->units_per_default_bus =3D 1;
>       mc->ignore_memory_transaction_failures =3D true;
> +    mc->min_cpus =3D XLNX_ZYNQMP_NUM_APU_CPUS;
>       mc->max_cpus =3D XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPU=
S;
>       mc->default_cpus =3D XLNX_ZYNQMP_NUM_APU_CPUS;
>       mc->default_ram_id =3D "ddr-ram";
> ---
>
> $ qemu-system-aarch64 -M xlnx-zcu102 -smp 1
> qemu-system-aarch64: Invalid SMP CPUs 1. The min CPUs supported by
> machine 'xlnx-zcu102' is 4

We encountered this issue when we were trying to emulate a zynqmp with
only two cortex-a53 cores. I don't have the full context but this was
probably to debug a race condition or something like that.
Thus, I would like to keep the possibility of lowering the CPU number,
even if it doesn't match the real board.

Cl=C3=A9ment


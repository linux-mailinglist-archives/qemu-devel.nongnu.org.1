Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBA179A135
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 04:18:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfWTU-0000rT-7b; Sun, 10 Sep 2023 22:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfWTR-0000r6-58
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 22:16:25 -0400
Received: from mail-ua1-x92b.google.com ([2607:f8b0:4864:20::92b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qfWTO-0000n3-Qq
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 22:16:24 -0400
Received: by mail-ua1-x92b.google.com with SMTP id
 a1e0cc1a2514c-7a02252eb5dso1048695241.1
 for <qemu-devel@nongnu.org>; Sun, 10 Sep 2023 19:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694398581; x=1695003381; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6hXXLchbEzlcod8zva8H1iGN1H1ERkk1UvCWoNg/eTA=;
 b=VlnmwLmYN2oMo8x/xZ48pa3rYsh8OIOPG1jA4q8MbnD0FdIzWMPKo4SbydYvIsN2+L
 AmBOAKzrNovsUSYgkUIgqhHLSmsLdh5JAw9OWwKDEya/8t1cbH9zjo3eqUgKgzet0f/W
 7c9WY8QsWsYlhaP+U2wAcor5HmOye5zCfipBDVYDSx4/649Lnh/4nyhshYpSiPmILHjA
 d63rRVsdElPXbZsmFY9Gx7IWZNmX5RVnciu2uG/QW/Gl+Gfmh8YrL2IfpMo8a2uKdTmd
 c7fW0q01cj0tRwR5jFdpl/zu7OP8spEaHuT5vpIO8k/aTzs0i1yU4xHNZ8g0Cbx3YLvI
 X67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694398581; x=1695003381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6hXXLchbEzlcod8zva8H1iGN1H1ERkk1UvCWoNg/eTA=;
 b=OiOc5Nc5kc1FokZHU4HMIeGIY+hS/cd0TYkIrRstLAfnZDFIFyH51q/NT+HegL2OVh
 mzFa0cQYUeV53e4uaCNyNIp7NwE7ywVcluyY/HgaH5C29koSMJRfAVTAyFjv8pphi2yu
 mL7ZP1tgUhrzCmti2LfOuRTWbfzPYrpu2OR6og6C7ZvJZ5pWNMN+7w32R5S1eyCI+WZ2
 y+vBs5gSNBnp9c0NALdGVbGjyLk7WvPaGySxr5r7YWH1uMk+4/z+9LaitgdKQLwnFrhE
 XUyT1zfhdvjvthSRwzNswICrKSFnFUbNBQE/BpzanIc3KatrmQrQ1in2sPq3Qfh8k7wQ
 Y8Pw==
X-Gm-Message-State: AOJu0YxTjvFoDbp+ARETVDWo0D1A+FpeHFPn67415Tc/InFRd79Ijpmh
 yPrj8kOQmsLlrXU8ZmPIiSdD3hMdqgTj9UUbG1U=
X-Google-Smtp-Source: AGHT+IFNNdMnvHuu/IpVRJFHI10z2Y1rxoZPTRQmMYIeEUSBYi/Md7vsFekxFUja/PFYmHxefMBeul0QakheUHb+ycw=
X-Received: by 2002:a05:6102:452:b0:44d:590d:28a9 with SMTP id
 e18-20020a056102045200b0044d590d28a9mr5247105vsq.3.1694398581350; Sun, 10 Sep
 2023 19:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230908060431.1903919-1-alistair.francis@wdc.com>
 <20230908060431.1903919-49-alistair.francis@wdc.com>
 <0bdad3e3-bfd6-ffea-a725-46b9e4629756@linaro.org>
 <271e0ae3-86c2-870a-f596-55755e67c6f0@ventanamicro.com>
In-Reply-To: <271e0ae3-86c2-870a-f596-55755e67c6f0@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 11 Sep 2023 12:15:54 +1000
Message-ID: <CAKmqyKOFV=KP0ScJbstD6XVMiJ-NXRDA8FKbv6Pg0nYqvo6y=g@mail.gmail.com>
Subject: Re: [PULL 48/65] target/riscv/cpu.c: split kvm prop handling to its
 own helper
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Weiwei Li <liweiwei@iscas.ac.cn>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92b;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Sep 10, 2023 at 6:58=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 9/8/23 10:21, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 8/9/23 08:04, Alistair Francis wrote:
> >> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >>
> >> Future patches will split the existing Property arrays even further, a=
nd
> >> the existing code in riscv_cpu_add_user_properties() will start to sca=
le
> >> bad with it because it's dealing with KVM constraints mixed in with TC=
G
> >> constraints. We're going to pay a high price to share a couple of comm=
on
> >> lines of code between the two.
> >>
> >> Create a new riscv_cpu_add_kvm_properties() that will be forked from
> >> riscv_cpu_add_user_properties() if we're running KVM. The helper
> >> includes all properties that a KVM CPU will add. The rest of
> >> riscv_cpu_add_user_properties() body will then be relieved from having
> >> to deal with KVM constraints.
> >>
> >> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >> Reviewed-by: Weiwei Li <liweiwei@iscas.ac.cn>
> >> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> >> Message-ID: <20230901194627.1214811-4-dbarboza@ventanamicro.com>
> >> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >> ---
> >>   target/riscv/cpu.c | 65 ++++++++++++++++++++++++++++++--------------=
--
> >>   1 file changed, 42 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> >> index db640e7460..8e6d316500 100644
> >> --- a/target/riscv/cpu.c
> >> +++ b/target/riscv/cpu.c
> >> @@ -1943,6 +1943,46 @@ static void cpu_set_cfg_unavailable(Object *obj=
, Visitor *v,
> >>   }
> >>   #endif
> >> +#ifndef CONFIG_USER_ONLY
> >
> > #ifdef CONFIG_KVM ?
>
> Yeah, CONFIG_KVM would be more fitting here. We're moving all this code t=
o kvm.c
> in "[PATCH v2 00/19] riscv: split TCG/KVM accelerators from cpu.c", and w=
e won't
> need neither in the end, so for now it's simpler to temporarily leave it =
like
> this.

There are CI failures, so I have converted this to #ifdef CONFIG_KVM
which should fix them.

Alistair

>
>
> Thanks,
>
> Daniel
>
> >
> >> +static void riscv_cpu_add_kvm_unavail_prop(Object *obj, const char *p=
rop_name)
> >> +{
> >> +    /* Check if KVM created the property already */
> >> +    if (object_property_find(obj, prop_name)) {
> >> +        return;
> >> +    }
> >> +
> >> +    /*
> >> +     * Set the default to disabled for every extension
> >> +     * unknown to KVM and error out if the user attempts
> >> +     * to enable any of them.
> >> +     */
> >> +    object_property_add(obj, prop_name, "bool",
> >> +                        NULL, cpu_set_cfg_unavailable,
> >> +                        NULL, (void *)prop_name);
> >> +}
> >> +
> >> +static void riscv_cpu_add_kvm_properties(Object *obj)
> >> +{
> >> +    Property *prop;
> >> +    DeviceState *dev =3D DEVICE(obj);
> >> +
> >> +    kvm_riscv_init_user_properties(obj);
> >> +    riscv_cpu_add_misa_properties(obj);
> >> +
> >> +    for (prop =3D riscv_cpu_extensions; prop && prop->name; prop++) {
> >> +        riscv_cpu_add_kvm_unavail_prop(obj, prop->name);
> >> +    }
> >> +
> >> +    for (int i =3D 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
> >> +        /* Check if KVM created the property already */
> >> +        if (object_property_find(obj, riscv_cpu_options[i].name)) {
> >> +            continue;
> >> +        }
> >> +        qdev_property_add_static(dev, &riscv_cpu_options[i]);
> >> +    }
> >> +}
> >> +#endif
> >> +
> >>   /*
> >>    * Add CPU properties with user-facing flags.
> >>    *
> >> @@ -1958,39 +1998,18 @@ static void riscv_cpu_add_user_properties(Obje=
ct *obj)
> >>       riscv_add_satp_mode_properties(obj);
> >>       if (kvm_enabled()) {
> >> -        kvm_riscv_init_user_properties(obj);
> >> +        riscv_cpu_add_kvm_properties(obj);
> >> +        return;
> >>       }
> >>   #endif
> >>       riscv_cpu_add_misa_properties(obj);
> >>       for (prop =3D riscv_cpu_extensions; prop && prop->name; prop++) =
{
> >> -#ifndef CONFIG_USER_ONLY
> >> -        if (kvm_enabled()) {
> >> -            /* Check if KVM created the property already */
> >> -            if (object_property_find(obj, prop->name)) {
> >> -                continue;
> >> -            }
> >> -
> >> -            /*
> >> -             * Set the default to disabled for every extension
> >> -             * unknown to KVM and error out if the user attempts
> >> -             * to enable any of them.
> >> -             */
> >> -            object_property_add(obj, prop->name, "bool",
> >> -                                NULL, cpu_set_cfg_unavailable,
> >> -                                NULL, (void *)prop->name);
> >> -            continue;
> >> -        }
> >> -#endif
> >>           qdev_property_add_static(dev, prop);
> >>       }
> >>       for (int i =3D 0; i < ARRAY_SIZE(riscv_cpu_options); i++) {
> >> -        /* Check if KVM created the property already */
> >> -        if (object_property_find(obj, riscv_cpu_options[i].name)) {
> >> -            continue;
> >> -        }
> >>           qdev_property_add_static(dev, &riscv_cpu_options[i]);
> >>       }
> >>   }
> >


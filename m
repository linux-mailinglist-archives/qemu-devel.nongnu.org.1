Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CD37FBE25
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 16:34:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8050-0005bl-Hh; Tue, 28 Nov 2023 10:32:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r804v-0005aO-5J
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:32:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r804c-0003it-2G
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701185549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tg6RYWeqCpwUoQCzRfUgguApc1UmfoSk7iO/0ub4xnQ=;
 b=G00fEO70GQ8BhNGECPaQ1vFbJ/Cohzqr4PltjPE3dwSw8DLZOomGNFBavVJlfY8RR+ijf0
 JlVnX8uSI3wE0VcRnBQE13Une7pTMcErrXTwiBEN4BGPLt686js29EONx2dRm/nf1k+0Hr
 XjTrEn2DyQPtO5pm9Cdd0b3EAUau2O0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-52dlCmDXOAWZQPtucfuS9Q-1; Tue, 28 Nov 2023 10:32:26 -0500
X-MC-Unique: 52dlCmDXOAWZQPtucfuS9Q-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-54af6c23f5aso2999648a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 07:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701185545; x=1701790345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tg6RYWeqCpwUoQCzRfUgguApc1UmfoSk7iO/0ub4xnQ=;
 b=dLcuaziKQktiUsBrjZlIVkjbY4fwAJskkXDDC7YeK/VdHWj85DX+S9py9vgrb03PrK
 VqJhxgiYB5nzYgMGtDcAsC1ngfxbKQMvVOLhPgx+bPt4/7/7F+Nr0LzQM6XK0nMUss9J
 z9fU9Z0RhP2owPWOAbNkLsjgNX+sZhAC6fVqmpkoWjmNDg7sBoaajrf1r+pbTfKaqTtM
 JKnyzSJ263W/lpCbnU2nX0sJ3lFe0Qn0+vjxkds6McISGS+YIKloxUwKsyPZBhneYHTa
 CqbuUpvwOYbDL8wHbW5ZfKOOKdtjuoGfuMQypDIeG8CF157GtqeY6+nBvhMETVLA97o/
 FMdA==
X-Gm-Message-State: AOJu0YwEwD2gAZ6gUKEG3LTkhvJtDbZv5N02OaxlI3DxE7RKK4lkSDoK
 U3XQBLy9F6dFURobAgHe46DXtnhw/Wj0pAY2wa/JDFPLBu/pTjBwqnuVUSAF5ediU6tEIuJfRRE
 +WTyxLP9S+lLcD9Y=
X-Received: by 2002:a05:6402:ca9:b0:54b:8a3:33d4 with SMTP id
 cn9-20020a0564020ca900b0054b08a333d4mr8894221edb.21.1701185545211; 
 Tue, 28 Nov 2023 07:32:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMGpmPt7p6iX1F5rrS2VkmRstyL767+5Ii7X39+PL6kV21emtghvT6KRos4CGfcShd+vt/lQ==
X-Received: by 2002:a05:6402:ca9:b0:54b:8a3:33d4 with SMTP id
 cn9-20020a0564020ca900b0054b08a333d4mr8894200edb.21.1701185544908; 
 Tue, 28 Nov 2023 07:32:24 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 z40-20020a509e2b000000b0054b79a10c5bsm2011932ede.1.2023.11.28.07.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 07:32:24 -0800 (PST)
Date: Tue, 28 Nov 2023 16:32:21 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini
 <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand
 <david@redhat.com>, Peter Xu <peterx@redhat.com>, Anton Johansson
 <anjo@rev.ng>, Peter Maydell <peter.maydell@linaro.org>,
 kvm@vger.kernel.org, Marek Vasut <marex@denx.de>, David Gibson
 <david@gibson.dropbear.id.au>, Brian Cain <bcain@quicinc.com>, Yoshinori
 Sato <ysato@users.sourceforge.jp>, "Edgar E . Iglesias"
 <edgar.iglesias@gmail.com>, Claudio Fontana <cfontana@suse.de>, Daniel
 Henrique Barboza <dbarboza@ventanamicro.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-ppc@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Aurelien
 Jarno <aurelien@aurel32.net>, Ilya Leoshkevich <iii@linux.ibm.com>, Daniel
 Henrique Barboza <danielhb413@gmail.com>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@kaod.org>, Alistair Francis <alistair.francis@wdc.com>, Alessandro Di
 Federico <ale@rev.ng>, Song Gao <gaosong@loongson.cn>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Chris Wulff <crwulff@gmail.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org, Yanan Wang
 <wangyanan55@huawei.com>, Luc Michel <luc@lmichel.fr>, Weiwei Li
 <liweiwei@iscas.ac.cn>, Bin Meng <bin.meng@windriver.com>, Stafford Horne
 <shorne@gmail.com>, Xiaojuan Yang <yangxiaojuan@loongson.cn>, "Daniel P .
 Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Aleksandar Rikalo
 <aleksandar.rikalo@syrmia.com>, Bernhard Beschow <shentey@gmail.com>, Mark
 Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-riscv@nongnu.org, Alex
 =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Nicholas Piggin
 <npiggin@gmail.com>, Greg Kurz <groug@kaod.org>, Michael Rolnik
 <mrolnik@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Markus
 Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 01/22] target/i386: Only realize existing APIC device
Message-ID: <20231128163221.6c91e013@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230918160257.30127-2-philmd@linaro.org>
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-2-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 18 Sep 2023 18:02:34 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> APIC state is created under a certain condition,
> use the same condition to realize it.
> Having a NULL APIC state is a bug: use assert().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/i386/cpu-sysemu.c | 9 +++------
>  target/i386/cpu.c        | 8 +++++---
>  2 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
> index 2375e48178..6a164d3769 100644
> --- a/target/i386/cpu-sysemu.c
> +++ b/target/i386/cpu-sysemu.c
> @@ -272,9 +272,7 @@ void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
>      APICCommonState *apic;
>      APICCommonClass *apic_class =3D apic_get_class(errp);
> =20
> -    if (!apic_class) {
> -        return;
> -    }
> +    assert(apic_class);

if errp doesn't lead to error_fatal/abort, wouldn't that effectively mask
following error
 apic_get_class():
      error_setg(errp, "KVM does not support userspace APIC");
      return NULL;
???

> =20
>      cpu->apic_state =3D DEVICE(object_new_with_class(OBJECT_CLASS(apic_c=
lass)));
>      object_property_add_child(OBJECT(cpu), "lapic",
> @@ -293,9 +291,8 @@ void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)
>      APICCommonState *apic;
>      static bool apic_mmio_map_once;
> =20
> -    if (cpu->apic_state =3D=3D NULL) {
> -        return;
> -    }
> +    assert(cpu->apic_state);

it would be better to explode in one place only inside apic_get_class(),
provided !kvm_irqchip_in_kernel() case is dealt with properly.


>      qdev_realize(DEVICE(cpu->apic_state), NULL, errp);
> =20
>      /* Map APIC MMIO area */
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b2a20365e1..a23d4795e0 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -7448,9 +7448,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Er=
ror **errp)
>      }
> =20
>  #ifndef CONFIG_USER_ONLY
> -    x86_cpu_apic_realize(cpu, &local_err);
> -    if (local_err !=3D NULL) {
> -        goto out;
> +    if (cpu->env.features[FEAT_1_EDX] & CPUID_APIC || ms->smp.cpus > 1) {
> +        x86_cpu_apic_realize(cpu, &local_err);
> +        if (local_err !=3D NULL) {
> +            goto out;
> +        }

better move 'if (cpu->apic_state =3D=3D NULL) {' from x86_cpu_apic_realize()
to the caller, instead of repeating test again.

>      }
>  #endif /* !CONFIG_USER_ONLY */
>      cpu_reset(cs);



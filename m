Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE957FBE2B
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 16:35:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r806u-0007Oa-Kx; Tue, 28 Nov 2023 10:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r806p-0007N5-JG
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:34:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r806n-000454-Ma
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 10:34:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701185685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D9lOQjODNv02P43/kZH/wGQ3w31tJS9+8fDtN67uTGI=;
 b=NyjTBJ5yv9WguSF41/HC+2EQMw2noy9dmB1Pr+cjC9SDTKgW7C2Ec8x6MAMxtNXwxEvlzW
 P9NRr+O9ayhJSBxnayYId2ZnJ8fvxG2qYKmiOku3jsB+elOePuFR1vuB2s4y1Av74axOLK
 Fv2jmzer0NBRoTeafmg5OjTL3q37Xao=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-WVDbl6tuOpeXaLDx_aPW4Q-1; Tue, 28 Nov 2023 10:34:43 -0500
X-MC-Unique: WVDbl6tuOpeXaLDx_aPW4Q-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50abbf4ee79so6032825e87.1
 for <qemu-devel@nongnu.org>; Tue, 28 Nov 2023 07:34:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701185682; x=1701790482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D9lOQjODNv02P43/kZH/wGQ3w31tJS9+8fDtN67uTGI=;
 b=IHW8j6kdYsNpnG5dr76Vj6GRSHCvdgOQagRtYhDdD0eJkhQO2YZJP6iNHb0/bd1tz8
 i17wccoPaXB9Qt7VhaBsoc5rnkMOxg04BRcMfJstpGlRD63z5WCtr5PcQFV/inr+3cMc
 53gszZ6AnuXiV5ZCFAB/eVOXAQnPrHZwkuMw9arySBzis6Bsaz7tAKgJzZaJg4l2HB6h
 pOsPycZAlsYoVVUjK+0/YQH3q1xqdgqxECT/ECdD4QN9Jr1dcqHm6VFgY4HVcI/Gw0C7
 MM7bnoRHyV+5nIWAAKK4E5jgy/7hIpfZRkXoe7cjk9IshsM+V9bRuh0Yv1g894pPrzAw
 sWFA==
X-Gm-Message-State: AOJu0YwirLkSbNPAfit+um31fZESrrgw2yzuCDr3hWxxcnyPs3E/Of97
 gRtzvoxT/aJtPsynse4zefHVAQNIndX7jmON1OM+16SrrnSPzYLiiZBDg4N7sXpcnZ1ustUZYvG
 wLzJG1i8qbxdSwoI=
X-Received: by 2002:ac2:4acb:0:b0:50b:ac31:28e5 with SMTP id
 m11-20020ac24acb000000b0050bac3128e5mr5758120lfp.65.1701185682044; 
 Tue, 28 Nov 2023 07:34:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVxWl5bdZvuMtpJUQ8Z+EaD52jviZNSCZAMpxb5IUoQ4q6GjfDoZU/DsJDwJO/WcMaVBCVag==
X-Received: by 2002:ac2:4acb:0:b0:50b:ac31:28e5 with SMTP id
 m11-20020ac24acb000000b0050bac3128e5mr5758085lfp.65.1701185681511; 
 Tue, 28 Nov 2023 07:34:41 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 d11-20020a056402000b00b0054851cd28d2sm6365832edu.79.2023.11.28.07.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Nov 2023 07:34:41 -0800 (PST)
Date: Tue, 28 Nov 2023 16:34:38 +0100
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
Subject: Re: [PATCH 02/22] hw/intc/apic: Pass CPU using QOM link property
Message-ID: <20231128163438.3d257bdd@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230918160257.30127-3-philmd@linaro.org>
References: <20230918160257.30127-1-philmd@linaro.org>
 <20230918160257.30127-3-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 18 Sep 2023 18:02:35 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> QOM objects shouldn't access each other internals fields
> except using the QOM API.
>=20
> Declare the 'cpu' and 'base-addr' properties, set them
> using object_property_set_link() and qdev_prop_set_uint32()
> respectively.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/intc/apic_common.c    |  2 ++
>  target/i386/cpu-sysemu.c | 11 ++++++-----
>  2 files changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index 68ad30e2f5..e28f7402ab 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -394,6 +394,8 @@ static Property apic_properties_common[] =3D {
>                      true),
>      DEFINE_PROP_BOOL("legacy-instance-id", APICCommonState, legacy_insta=
nce_id,
>                       false),
> +    DEFINE_PROP_LINK("cpu", APICCommonState, cpu, TYPE_X86_CPU, X86CPU *=
),
> +    DEFINE_PROP_UINT32("base-addr", APICCommonState, apicbase, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
> index 6a164d3769..6edfb7e2af 100644
> --- a/target/i386/cpu-sysemu.c
> +++ b/target/i386/cpu-sysemu.c
> @@ -269,7 +269,6 @@ APICCommonClass *apic_get_class(Error **errp)
> =20
>  void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
>  {
> -    APICCommonState *apic;
>      APICCommonClass *apic_class =3D apic_get_class(errp);
> =20
>      assert(apic_class);
> @@ -279,11 +278,13 @@ void x86_cpu_apic_create(X86CPU *cpu, Error **errp)
>                                OBJECT(cpu->apic_state));
>      object_unref(OBJECT(cpu->apic_state));
> =20
> +    if (!object_property_set_link(OBJECT(cpu->apic_state), "cpu",
> +                                  OBJECT(cpu), errp)) {
> +        return;
> +    }
>      qdev_prop_set_uint32(cpu->apic_state, "id", cpu->apic_id);
> -    /* TODO: convert to link<> */
> -    apic =3D APIC_COMMON(cpu->apic_state);
> -    apic->cpu =3D cpu;
> -    apic->apicbase =3D APIC_DEFAULT_ADDRESS | MSR_IA32_APICBASE_ENABLE;
> +    qdev_prop_set_uint32(cpu->apic_state, "base-addr",
> +                         APIC_DEFAULT_ADDRESS | MSR_IA32_APICBASE_ENABLE=
);
>  }
> =20
>  void x86_cpu_apic_realize(X86CPU *cpu, Error **errp)



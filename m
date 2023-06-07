Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 590767264CD
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 17:38:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6vDy-0007Gk-Fl; Wed, 07 Jun 2023 11:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6vDj-0007EI-UW
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:37:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q6vDi-0001Cp-Bi
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 11:37:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686152229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=23H9u8k9dGR+RMR5UGdhhy+JizAILZYJw7gjPENvjlc=;
 b=C2sEuI/mBJlk9kIVPH9kCyWWclsz8Q5wGm1PcLas1tfbGBX6lqkwxDGBiN1wzfogeoGf5t
 koo6KU1XykScSxI+50V2Uqhf1HYAF0NmX0uszWwEdTRoRmEZMoLbfoAgCDqQIHqXdn1rEk
 uzmKXQGPdc5RKkDcsVn6tr21BqxH6NE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-1KtIev-LNqu1E5k-VKP66g-1; Wed, 07 Jun 2023 09:52:13 -0400
X-MC-Unique: 1KtIev-LNqu1E5k-VKP66g-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-514b05895f7so964092a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 06:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686145932; x=1688737932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=23H9u8k9dGR+RMR5UGdhhy+JizAILZYJw7gjPENvjlc=;
 b=ZC1p5VhaYpjaAzt2AfUQVmGTHV00NGxekTH0NMp+4k8F7FRFfMXu526VLkG4vRQrxy
 WtBAPsjbJhF9k1h7Okx2JTy79RsZ1GWGhWpmPjVW5UK87bxYuYBhwbDreF2cJAB+EinL
 nfDpU8kRARSyI+ryY1tJV8G+ahYON4fuUEEa+FBzANUOMsdV5uvFuEcACudnx6uB82rW
 HvfCIsuK2QebvBmrOG7xvd9rwx6IDTLMpWAvvem23xKv0RvW+vOiWZezHWXqnjHrVObW
 J7amCPaAFAnwpLnWMfedutaugfTwSgytPNFYBcR7crdUn4z6Bgp0djmhvNSNkHIGpRuT
 3xtA==
X-Gm-Message-State: AC+VfDzFqDIimR4ChfoHif6IdwCRNTKTe/inassDA5eE/+byIW+SNhCg
 tqwZo6MoQ93eKQQdHTP9ev9Kx7A6eed6YhOIhoEZdKldpg/zlh8sp/WWtJp9TzGdTd/lUgpn0cy
 YTaHrUlCu/o4vpqk=
X-Received: by 2002:a17:907:7da4:b0:974:1c98:d38e with SMTP id
 oz36-20020a1709077da400b009741c98d38emr6202326ejc.2.1686145931889; 
 Wed, 07 Jun 2023 06:52:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4om4dVLEpY/+JmKKUmuHz0T7w2Z5PSdi3AJRHT1UlPxlkHptupOIcpoCxsohRtPaIGVetYpQ==
X-Received: by 2002:a17:907:7da4:b0:974:1c98:d38e with SMTP id
 oz36-20020a1709077da400b009741c98d38emr6202304ejc.2.1686145931662; 
 Wed, 07 Jun 2023 06:52:11 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 i21-20020a170906851500b00965e9a23f2bsm6958502ejx.134.2023.06.07.06.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 06:52:11 -0700 (PDT)
Date: Wed, 7 Jun 2023 15:52:10 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: <qemu-devel@nongnu.org>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <berrange@redhat.com>, <jusual@redhat.com>,
 <dfaggioli@suse.com>, <joao.m.martins@oracle.com>, <jon.grimm@amd.com>,
 <santosh.Shukla@amd.com>
Subject: Re: [PATCH v5 3/3] pc: q35: Bump max_cpus to 1024
Message-ID: <20230607155210.5251df58@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230607024939.703991-4-suravee.suthikulpanit@amd.com>
References: <20230607024939.703991-1-suravee.suthikulpanit@amd.com>
 <20230607024939.703991-4-suravee.suthikulpanit@amd.com>
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

On Tue, 6 Jun 2023 21:49:39 -0500
Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:

> Since KVM_MAX_VCPUS is currently defined to 1024 for x86 as shown in
> arch/x86/include/asm/kvm_host.h, update QEMU limits to the same number.
>=20
> In case KVM could not support the specified number of vcpus, QEMU would
> return the following error message:
>=20
>   qemu-system-x86_64: kvm_init_vcpu: kvm_get_vcpu failed (xxx): Invalid a=
rgument
>=20
> Also, keep max_cpus at 288 for machine version 8.0 and older.
>=20
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Julia Suvorova <jusual@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc_q35.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 371cca7484..63866a16e0 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -360,12 +360,12 @@ static void pc_q35_machine_options(MachineClass *m)
>      m->default_nic =3D "e1000e";
>      m->default_kernel_irqchip_split =3D false;
>      m->no_floppy =3D 1;
> +    m->max_cpus =3D 1024;
>      m->no_parallel =3D !module_object_class_by_name(TYPE_ISA_PARALLEL);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_AMD_IOMMU_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_INTEL_IOMMU_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
>      machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
> -    m->max_cpus =3D 288;
>  }
> =20
>  static void pc_q35_8_1_machine_options(MachineClass *m)
> @@ -388,6 +388,7 @@ static void pc_q35_8_0_machine_options(MachineClass *=
m)
> =20
>      /* For pc-q35-8.0 and older, use SMBIOS 2.8 by default */
>      pcmc->default_smbios_ep_type =3D SMBIOS_ENTRY_POINT_TYPE_32;
> +    m->max_cpus =3D 288;
>  }
> =20
>  DEFINE_Q35_MACHINE(v8_0, "pc-q35-8.0", NULL,



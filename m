Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54265756561
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 15:46:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLOYk-0006VY-4P; Mon, 17 Jul 2023 09:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qLOYe-0006VA-ER
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 09:46:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qLOYc-0001j0-Pd
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 09:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689601593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/tBQ4VC7htl183g/JLSOFRPxQQl5ZomwNWSnleVlBuA=;
 b=aWAG6QCoXwElFOvjjYK9Wg2ljMverKHB3pFYFKGHw9bjjHemEM3+1JFAG3Hy4ya1l7PP1K
 xlgMtTAd9ZLr+mBfe++rVrhtJbHHf/nLB2avj3F1AqM7A06Xxtia5WKrK4RSgqWe2Pb0Ho
 n3VKo4fVoHf9t84sLAYRNcBCz3Is0fs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407--hZ6Fo0DOKa6-Qdvp27nvg-1; Mon, 17 Jul 2023 09:46:32 -0400
X-MC-Unique: -hZ6Fo0DOKa6-Qdvp27nvg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9932e8e76b9so276130666b.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 06:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689601591; x=1692193591;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/tBQ4VC7htl183g/JLSOFRPxQQl5ZomwNWSnleVlBuA=;
 b=dY0yy+bE90gTRW2zVReLRbM6FIjVdIBWLSsAMx+Dinle/WjBIqRy+POtUjLroEjZc8
 3OSfGT2dVQAUgtsqDUk1HmhDSUYk64lnZCtWxpmSbo6qIpTaL8s0a6vBHCLN3KqZ3rFi
 3Ljr12qx1c/FZQgBnUvzZ74v8mS9u3UNkQIIS/ZovHMPon8o906jlo8vX5wEEPei6b8t
 dn//1Feqf1oOA9ib2E/rsFIXtRVQUobYIenJFLqYyd8k5GDQGppGqK+XyrWJB61yAOSj
 z2Gbkc80P48gNoZ9vW3ZnM+bb+SqZyfF78Sl7l3OChF15eFYBxA6/HbktDBbDsm3NCKu
 vUKg==
X-Gm-Message-State: ABy/qLaV//Z3TCwfQpn3qlOUuRn3kzIemNuFwAWAXvwSMoZT2FDMjNLS
 jvo/N75qBKDK9BstfH+Ky/KEvIifD9erOu6DlglDxS7dBBJa8nMcOANuZc+vqOQqg4sYCxfQIn5
 MtOHpMRK8CKLx+Uw=
X-Received: by 2002:a17:906:6496:b0:974:1ef7:1e88 with SMTP id
 e22-20020a170906649600b009741ef71e88mr10601858ejm.13.1689601591361; 
 Mon, 17 Jul 2023 06:46:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG9GbOhEEzUjI0DnD7unE5Q57VLxCmY1Ty7cyiopANRMJRbnOWsQlzMh/1CYLTHqwMdc/8egA==
X-Received: by 2002:a17:906:6496:b0:974:1ef7:1e88 with SMTP id
 e22-20020a170906649600b009741ef71e88mr10601847ejm.13.1689601591080; 
 Mon, 17 Jul 2023 06:46:31 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 p27-20020a170906141b00b00977eec7b7e8sm9247708ejc.68.2023.07.17.06.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 06:46:30 -0700 (PDT)
Date: Mon, 17 Jul 2023 15:46:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 05/11] tpm_crb: use the ISA bus
Message-ID: <20230717154630.64759bd1@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230714070931.23476-6-j@getutm.app>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-6-j@getutm.app>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 14 Jul 2023 00:09:21 -0700
Joelle van Dyne <j@getutm.app> wrote:

> Since this device is gated to only build for targets with the PC
> configuration, we should use the ISA bus like with TPM TIS.

does it affect migration in any way?
=46rom guest pov it looks like there a new ISA device will appear
and then if you do ping pong migration between old - new QEMU will really i=
t work?

If it will, then commit message here shall describe why it safe and why it =
works


> Signed-off-by: Joelle van Dyne <j@getutm.app>
> ---
>  hw/tpm/tpm_crb.c | 52 ++++++++++++++++++++++++------------------------
>  hw/tpm/Kconfig   |  2 +-
>  2 files changed, 27 insertions(+), 27 deletions(-)
>=20
> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> index 07c6868d8d..6144081d30 100644
> --- a/hw/tpm/tpm_crb.c
> +++ b/hw/tpm/tpm_crb.c
> @@ -22,6 +22,7 @@
>  #include "hw/qdev-properties.h"
>  #include "hw/pci/pci_ids.h"
>  #include "hw/acpi/tpm.h"
> +#include "hw/isa/isa.h"
>  #include "migration/vmstate.h"
>  #include "sysemu/tpm_backend.h"
>  #include "sysemu/tpm_util.h"
> @@ -34,7 +35,7 @@
>  #include "tpm_crb.h"
> =20
>  struct CRBState {
> -    DeviceState parent_obj;
> +    ISADevice parent_obj;
> =20
>      TPMCRBState state;
>  };
> @@ -43,49 +44,49 @@ typedef struct CRBState CRBState;
>  DECLARE_INSTANCE_CHECKER(CRBState, CRB,
>                           TYPE_TPM_CRB)
> =20
> -static void tpm_crb_none_request_completed(TPMIf *ti, int ret)
> +static void tpm_crb_isa_request_completed(TPMIf *ti, int ret)
>  {
>      CRBState *s =3D CRB(ti);
> =20
>      tpm_crb_request_completed(&s->state, ret);
>  }
> =20
> -static enum TPMVersion tpm_crb_none_get_version(TPMIf *ti)
> +static enum TPMVersion tpm_crb_isa_get_version(TPMIf *ti)
>  {
>      CRBState *s =3D CRB(ti);
> =20
>      return tpm_crb_get_version(&s->state);
>  }
> =20
> -static int tpm_crb_none_pre_save(void *opaque)
> +static int tpm_crb_isa_pre_save(void *opaque)
>  {
>      CRBState *s =3D opaque;
> =20
>      return tpm_crb_pre_save(&s->state);
>  }
> =20
> -static const VMStateDescription vmstate_tpm_crb_none =3D {
> +static const VMStateDescription vmstate_tpm_crb_isa =3D {
>      .name =3D "tpm-crb",
> -    .pre_save =3D tpm_crb_none_pre_save,
> +    .pre_save =3D tpm_crb_isa_pre_save,
>      .fields =3D (VMStateField[]) {
>          VMSTATE_END_OF_LIST(),
>      }
>  };
> =20
> -static Property tpm_crb_none_properties[] =3D {
> +static Property tpm_crb_isa_properties[] =3D {
>      DEFINE_PROP_TPMBE("tpmdev", CRBState, state.tpmbe),
>      DEFINE_PROP_BOOL("ppi", CRBState, state.ppi_enabled, true),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> -static void tpm_crb_none_reset(void *dev)
> +static void tpm_crb_isa_reset(void *dev)
>  {
>      CRBState *s =3D CRB(dev);
> =20
>      return tpm_crb_reset(&s->state, TPM_CRB_ADDR_BASE);
>  }
> =20
> -static void tpm_crb_none_realize(DeviceState *dev, Error **errp)
> +static void tpm_crb_isa_realize(DeviceState *dev, Error **errp)
>  {
>      CRBState *s =3D CRB(dev);
> =20
> @@ -100,52 +101,51 @@ static void tpm_crb_none_realize(DeviceState *dev, =
Error **errp)
> =20
>      tpm_crb_init_memory(OBJECT(s), &s->state, errp);
> =20
> -    memory_region_add_subregion(get_system_memory(),
> +    memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
>          TPM_CRB_ADDR_BASE, &s->state.mmio);
> =20
>      if (s->state.ppi_enabled) {
> -        memory_region_add_subregion(get_system_memory(),
> +        memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
>              TPM_PPI_ADDR_BASE, &s->state.ppi.ram);
>      }
> =20
>      if (xen_enabled()) {
> -        tpm_crb_none_reset(dev);
> +        tpm_crb_isa_reset(dev);
>      } else {
> -        qemu_register_reset(tpm_crb_none_reset, dev);
> +        qemu_register_reset(tpm_crb_isa_reset, dev);
>      }
>  }
> =20
> -static void tpm_crb_none_class_init(ObjectClass *klass, void *data)
> +static void tpm_crb_isa_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
>      TPMIfClass *tc =3D TPM_IF_CLASS(klass);
> =20
> -    dc->realize =3D tpm_crb_none_realize;
> -    device_class_set_props(dc, tpm_crb_none_properties);
> -    dc->vmsd  =3D &vmstate_tpm_crb_none;
> +    dc->realize =3D tpm_crb_isa_realize;
> +    device_class_set_props(dc, tpm_crb_isa_properties);
> +    dc->vmsd  =3D &vmstate_tpm_crb_isa;
>      dc->user_creatable =3D true;
>      tc->model =3D TPM_MODEL_TPM_CRB;
> -    tc->get_version =3D tpm_crb_none_get_version;
> -    tc->request_completed =3D tpm_crb_none_request_completed;
> +    tc->get_version =3D tpm_crb_isa_get_version;
> +    tc->request_completed =3D tpm_crb_isa_request_completed;
> =20
>      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>  }
> =20
> -static const TypeInfo tpm_crb_none_info =3D {
> +static const TypeInfo tpm_crb_isa_info =3D {
>      .name =3D TYPE_TPM_CRB,
> -    /* could be TYPE_SYS_BUS_DEVICE (or LPC etc) */
> -    .parent =3D TYPE_DEVICE,
> +    .parent =3D TYPE_ISA_DEVICE,
>      .instance_size =3D sizeof(CRBState),
> -    .class_init  =3D tpm_crb_none_class_init,
> +    .class_init  =3D tpm_crb_isa_class_init,
>      .interfaces =3D (InterfaceInfo[]) {
>          { TYPE_TPM_IF },
>          { }
>      }
>  };
> =20
> -static void tpm_crb_none_register(void)
> +static void tpm_crb_isa_register(void)
>  {
> -    type_register_static(&tpm_crb_none_info);
> +    type_register_static(&tpm_crb_isa_info);
>  }
> =20
> -type_init(tpm_crb_none_register)
> +type_init(tpm_crb_isa_register)
> diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
> index a46663288c..1fd73fe617 100644
> --- a/hw/tpm/Kconfig
> +++ b/hw/tpm/Kconfig
> @@ -22,7 +22,7 @@ config TPM_TIS
> =20
>  config TPM_CRB
>      bool
> -    depends on TPM && PC
> +    depends on TPM && ISA_BUS
>      select TPM_BACKEND
> =20
>  config TPM_SPAPR



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 979967DFE02
	for <lists+qemu-devel@lfdr.de>; Fri,  3 Nov 2023 03:39:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyk47-0007oW-AP; Thu, 02 Nov 2023 22:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qyk45-0007ni-JD
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 22:37:41 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qyk43-0007b6-Jo
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 22:37:41 -0400
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-6bd32d1a040so1727399b3a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 19:37:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698979057; x=1699583857;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+CpJmkFDEzoJYwEPKX+ZMiF/NtA1dtRsWU46idzkV4=;
 b=Vi7WWqhexUm5xp/7J1nnBCsSKf0VfYpwF3U4HnvAISbfzJDHd67KKxtffomXfUhqs2
 eQ94dWBUZ8ygXxvp2zEZh85Utr1NZOt20Fv+psXIkdg2GMyDBarbzIaiCLhIoPcf1/Mo
 mY0bmCK19vDw1fnyoAGwitz5u6JbOu0xQFOsZm0qWesfSYfOuGrGoE4lz+vi7sAXkGnn
 MNHsGpNBuwB/U2wBIWYwIEaxyUOANOPDpf19ZW2G4xYfnsLfYRKmAW9Q3GFGFNO11xEx
 JUIyBGtMmK1TQl5a3qrv49P71D4yQCun4snuzSZeX7BsvYjx+zzMxzNiVE5iU6t3GR7C
 RczQ==
X-Gm-Message-State: AOJu0YwnN1kMHrrYNcJS7EaV3ZpYtp9ApTOIcfFETflulJVkKIbKsPj1
 w5sNeZtkCRtnQUSldz2c6fnc/3pl/e8=
X-Google-Smtp-Source: AGHT+IGJnJTTMrTKZcN28yCTc4rX84+ed6JKUDCLzNsWcRD2cod/tuLeb3qfOXcm8lstXeIz6i+XJQ==
X-Received: by 2002:a05:6a00:9385:b0:68c:69c8:e0f0 with SMTP id
 ka5-20020a056a00938500b0068c69c8e0f0mr22622473pfb.18.1698979057053; 
 Thu, 02 Nov 2023 19:37:37 -0700 (PDT)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com.
 [209.85.216.50]) by smtp.gmail.com with ESMTPSA id
 a24-20020aa78658000000b006b287c0ed63sm375908pfo.137.2023.11.02.19.37.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 19:37:35 -0700 (PDT)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-28003daaaa6so1467744a91.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 19:37:35 -0700 (PDT)
X-Received: by 2002:a17:90a:34d:b0:280:c576:31b9 with SMTP id
 13-20020a17090a034d00b00280c57631b9mr6061983pjf.38.1698979055086; Thu, 02 Nov
 2023 19:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231031040021.65582-1-j@getutm.app>
 <20231031040021.65582-6-j@getutm.app>
 <33cc4e46-c48c-4fd8-bcec-b57698598a0e@linux.ibm.com>
In-Reply-To: <33cc4e46-c48c-4fd8-bcec-b57698598a0e@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Thu, 2 Nov 2023 19:37:24 -0700
X-Gmail-Original-Message-ID: <CA+E+eSACJs1oHPjqT4h7F32+y+HS_en45aVYSPKoUyAmoax11w@mail.gmail.com>
Message-ID: <CA+E+eSACJs1oHPjqT4h7F32+y+HS_en45aVYSPKoUyAmoax11w@mail.gmail.com>
Subject: Re: [PATCH v4 05/14] tpm_crb: move ACPI table building to device
 interface
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.210.173; envelope-from=osy86dev@gmail.com;
 helo=mail-pf1-f173.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Nov 2, 2023 at 11:50=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 10/31/23 00:00, Joelle van Dyne wrote:
> > This logic is similar to TPM TIS ISA device. Since TPM CRB can only
> > support TPM 2.0 backends, we check for this in realize.
>
> The problem on x86_64 is that the creation of the ACPI doesn't seem to
> get invoked. The device then ends up not working under Linux. The
> problem seems to be
>
> .parent =3D TYPE_DEVICE
>
> When I change this to TYPE_ISA_DEVICE it starts generating the ACPI
> table. I am not sure what other side effects this may have, though.
Ah sorry, this is probably a side effect of the patch I dropped where
the bus was moved back from ISA to SysBus. The patch was dropped
because people complained that the side effects of a new device
appearing on the ISA bus during migration is unknown. That means we
will probably have to add some logic to call the ACPI build methods on
non-ISA devices.

>
>     Stefan
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> > ---
> >   hw/tpm/tpm_crb.h        |  2 ++
> >   hw/i386/acpi-build.c    | 23 -----------------------
> >   hw/tpm/tpm_crb.c        | 16 ++++++++++++++++
> >   hw/tpm/tpm_crb_common.c | 19 +++++++++++++++++++
> >   4 files changed, 37 insertions(+), 23 deletions(-)
> >
> > diff --git a/hw/tpm/tpm_crb.h b/hw/tpm/tpm_crb.h
> > index 36863e1664..e6a86e3fd1 100644
> > --- a/hw/tpm/tpm_crb.h
> > +++ b/hw/tpm/tpm_crb.h
> > @@ -73,5 +73,7 @@ void tpm_crb_init_memory(Object *obj, TPMCRBState *s,=
 Error **errp);
> >   void tpm_crb_mem_save(TPMCRBState *s, uint32_t *saved_regs, void *sav=
ed_cmdmem);
> >   void tpm_crb_mem_load(TPMCRBState *s, const uint32_t *saved_regs,
> >                         const void *saved_cmdmem);
> > +void tpm_crb_build_aml(TPMIf *ti, Aml *scope, uint32_t baseaddr, uint3=
2_t size,
> > +                       bool build_ppi);
> >
> >   #endif /* TPM_TPM_CRB_H */
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 80db183b78..ce3f7b2d91 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1441,9 +1441,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
> >       uint32_t nr_mem =3D machine->ram_slots;
> >       int root_bus_limit =3D 0xFF;
> >       PCIBus *bus =3D NULL;
> > -#ifdef CONFIG_TPM
> > -    TPMIf *tpm =3D tpm_find();
> > -#endif
> >       bool cxl_present =3D false;
> >       int i;
> >       VMBusBridge *vmbus_bridge =3D vmbus_bridge_find();
> > @@ -1790,26 +1787,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linke=
r,
> >           }
> >       }
> >
> > -#ifdef CONFIG_TPM
> > -    if (TPM_IS_CRB(tpm)) {
> > -        dev =3D aml_device("TPM");
> > -        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")))=
;
> > -        aml_append(dev, aml_name_decl("_STR",
> > -                                      aml_string("TPM 2.0 Device")));
> > -        crs =3D aml_resource_template();
> > -        aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE,
> > -                                           TPM_CRB_ADDR_SIZE, AML_READ=
_WRITE));
> > -        aml_append(dev, aml_name_decl("_CRS", crs));
> > -
> > -        aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> > -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> > -
> > -        tpm_build_ppi_acpi(tpm, dev);
> > -
> > -        aml_append(sb_scope, dev);
> > -    }
> > -#endif
> > -
> >       if (pcms->sgx_epc.size !=3D 0) {
> >           uint64_t epc_base =3D pcms->sgx_epc.base;
> >           uint64_t epc_size =3D pcms->sgx_epc.size;
> > diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > index 99c64dd72a..8d57295b15 100644
> > --- a/hw/tpm/tpm_crb.c
> > +++ b/hw/tpm/tpm_crb.c
> > @@ -19,6 +19,8 @@
> >   #include "qemu/module.h"
> >   #include "qapi/error.h"
> >   #include "exec/address-spaces.h"
> > +#include "hw/acpi/acpi_aml_interface.h"
> > +#include "hw/acpi/tpm.h"
> >   #include "hw/qdev-properties.h"
> >   #include "hw/pci/pci_ids.h"
> >   #include "hw/acpi/tpm.h"
> > @@ -121,6 +123,11 @@ static void tpm_crb_none_realize(DeviceState *dev,=
 Error **errp)
> >           return;
> >       }
> >
> > +    if (tpm_crb_none_get_version(TPM_IF(s)) !=3D TPM_VERSION_2_0) {
> > +        error_setg(errp, "TPM CRB only supports TPM 2.0 backends");
> > +        return;
> > +    }
> > +
> >       tpm_crb_init_memory(OBJECT(s), &s->state, errp);
> >
> >       /* only used for migration */
> > @@ -142,10 +149,17 @@ static void tpm_crb_none_realize(DeviceState *dev=
, Error **errp)
> >       }
> >   }
> >
> > +static void build_tpm_crb_none_aml(AcpiDevAmlIf *adev, Aml *scope)
> > +{
> > +    tpm_crb_build_aml(TPM_IF(adev), scope, TPM_CRB_ADDR_BASE, TPM_CRB_=
ADDR_SIZE,
> > +                      true);
> > +}
> > +
> >   static void tpm_crb_none_class_init(ObjectClass *klass, void *data)
> >   {
> >       DeviceClass *dc =3D DEVICE_CLASS(klass);
> >       TPMIfClass *tc =3D TPM_IF_CLASS(klass);
> > +    AcpiDevAmlIfClass *adevc =3D ACPI_DEV_AML_IF_CLASS(klass);
> >
> >       dc->realize =3D tpm_crb_none_realize;
> >       device_class_set_props(dc, tpm_crb_none_properties);
> > @@ -154,6 +168,7 @@ static void tpm_crb_none_class_init(ObjectClass *kl=
ass, void *data)
> >       tc->model =3D TPM_MODEL_TPM_CRB;
> >       tc->get_version =3D tpm_crb_none_get_version;
> >       tc->request_completed =3D tpm_crb_none_request_completed;
> > +    adevc->build_dev_aml =3D build_tpm_crb_none_aml;
> >
> >       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> >   }
> > @@ -166,6 +181,7 @@ static const TypeInfo tpm_crb_none_info =3D {
> >       .class_init  =3D tpm_crb_none_class_init,
> >       .interfaces =3D (InterfaceInfo[]) {
> >           { TYPE_TPM_IF },
> > +        { TYPE_ACPI_DEV_AML_IF },
> >           { }
> >       }
> >   };
> > diff --git a/hw/tpm/tpm_crb_common.c b/hw/tpm/tpm_crb_common.c
> > index 605e8576e9..4fff0c6b59 100644
> > --- a/hw/tpm/tpm_crb_common.c
> > +++ b/hw/tpm/tpm_crb_common.c
> > @@ -239,3 +239,22 @@ void tpm_crb_mem_load(TPMCRBState *s, const uint32=
_t *saved_regs,
> >       memcpy(regs, saved_regs, TPM_CRB_R_MAX);
> >       memcpy(&regs[R_CRB_DATA_BUFFER], saved_cmdmem, A_CRB_DATA_BUFFER)=
;
> >   }
> > +
> > +void tpm_crb_build_aml(TPMIf *ti, Aml *scope, uint32_t baseaddr, uint3=
2_t size,
> > +                       bool build_ppi)
> > +{
> > +    Aml *dev, *crs;
> > +
> > +    dev =3D aml_device("TPM");
> > +    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> > +    aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")=
));
> > +    aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> > +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> > +    crs =3D aml_resource_template();
> > +    aml_append(crs, aml_memory32_fixed(baseaddr, size, AML_READ_WRITE)=
);
> > +    aml_append(dev, aml_name_decl("_CRS", crs));
> > +    if (build_ppi) {
> > +        tpm_build_ppi_acpi(ti, dev);
> > +    }
> > +    aml_append(scope, dev);
> > +}


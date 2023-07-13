Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6373752A36
	for <lists+qemu-devel@lfdr.de>; Thu, 13 Jul 2023 20:11:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qK0lp-0003kb-24; Thu, 13 Jul 2023 14:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qK0ln-0003kS-C9
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 14:10:27 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qK0ll-0000Wg-Is
 for qemu-devel@nongnu.org; Thu, 13 Jul 2023 14:10:27 -0400
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-3a3fbfb616dso798218b6e.3
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 11:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689271824; x=1691863824;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AkeYoMUPuDa/9f2qMjnLRzXUKc8uE1ysAK4p7WKIPvA=;
 b=gOyRaDSFu4R0+v5eK7TtHpqcMQ2UkX03aTVLrjjFKFJzAyI0GrZFjILe0oNzcVuX7f
 kGSvdrHPthIzyNonQ+YHH1ILU8CxK/H96URk4Kaax5CFuoADESjLXLkZupkh5ZBAjejK
 4AZa/Pskdjso+Wl2IT8BWbECLu9HQzy3ugRFsfIhSFG9iHQ9/kzNDdnELDQoMwTWkmGg
 l29b2v7YDM/PJXhuTfwLQdevICRl/fCGEQMTgxeBds22Zb07TrpRABH48g4qkerXooiT
 jDYpg0xLQZ9yCuS1pMZTpOjDN5Bx1uRKnNinXymPwk8oiLQJCdk3+CTmnpcVSTbAnwpd
 YkaA==
X-Gm-Message-State: ABy/qLbdKSLkk6GT7B+33ImHfHoGh38c/0tfHUHPFIvC+zs4s54Oaa4i
 hIbGByfOjYQd/HPTuX8qHpySfgTmpceTbg==
X-Google-Smtp-Source: APBJJlEbYncNSUN74M7akclvspJUbVQqkBA3CGXXXdla3o7Z5405frTRq5gdcGptErMUqX9e52AabA==
X-Received: by 2002:aca:3441:0:b0:3a1:eb0e:ddab with SMTP id
 b62-20020aca3441000000b003a1eb0eddabmr2059185oia.28.1689271824095; 
 Thu, 13 Jul 2023 11:10:24 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com.
 [209.85.210.48]) by smtp.gmail.com with ESMTPSA id
 n11-20020a0568080a0b00b003a1f444307esm3101017oij.58.2023.07.13.11.10.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Jul 2023 11:10:23 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-6b74b37fbe0so854840a34.1
 for <qemu-devel@nongnu.org>; Thu, 13 Jul 2023 11:10:23 -0700 (PDT)
X-Received: by 2002:a05:6870:1fc2:b0:1b3:8c06:c9d7 with SMTP id
 gp2-20020a0568701fc200b001b38c06c9d7mr2980835oac.10.1689271823616; Thu, 13
 Jul 2023 11:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230713035232.48406-1-j@getutm.app>
 <20230713035232.48406-7-j@getutm.app>
 <d51ec99a-81d3-76ab-648f-f80550856271@linux.ibm.com>
In-Reply-To: <d51ec99a-81d3-76ab-648f-f80550856271@linux.ibm.com>
From: Joelle van Dyne <j@getutm.app>
Date: Thu, 13 Jul 2023 11:10:12 -0700
X-Gmail-Original-Message-ID: <CA+E+eSDTa-tsk0a1yx89VFdFQU2hfHfV3f3t2vyW55hQ=+=zzw@mail.gmail.com>
Message-ID: <CA+E+eSDTa-tsk0a1yx89VFdFQU2hfHfV3f3t2vyW55hQ=+=zzw@mail.gmail.com>
Subject: Re: [PATCH 06/11] tpm_crb: move ACPI table building to device
 interface
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.167.171; envelope-from=osy86dev@gmail.com;
 helo=mail-oi1-f171.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

In that case, do you think we should have a check in "realize" to make
sure the backend is 2.0?

On Thu, Jul 13, 2023 at 9:08=E2=80=AFAM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 7/12/23 23:51, Joelle van Dyne wrote:
> > This logic is similar to TPM TIS ISA device.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > ---
> >   hw/i386/acpi-build.c | 23 -----------------------
> >   hw/tpm/tpm_crb.c     | 28 ++++++++++++++++++++++++++++
> >   2 files changed, 28 insertions(+), 23 deletions(-)
> >
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 9c74fa17ad..b767df39df 100644
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
> > @@ -1793,26 +1790,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linke=
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
> > index 6144081d30..14feb9857f 100644
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
> > @@ -116,10 +118,34 @@ static void tpm_crb_isa_realize(DeviceState *dev,=
 Error **errp)
> >       }
> >   }
> >
> > +static void build_tpm_crb_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
> > +{
> > +    Aml *dev, *crs;
> > +    CRBState *s =3D CRB(adev);
> > +    TPMIf *ti =3D TPM_IF(s);
> > +
> > +    dev =3D aml_device("TPM");
> > +    if (tpm_crb_isa_get_version(ti) =3D=3D TPM_VERSION_2_0) {
> > +        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")))=
;
> > +        aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Devi=
ce")));
> > +    } else {
> > +        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C31")));
> > +    }
>
> CRB only exists for TPM 2.0 and that's why we didn't have a different cas=
e here before.
>
> CRB only has MSFT0101: https://elixir.bootlin.com/linux/latest/source/dri=
vers/char/tpm/tpm_crb.c#L820
> TIS has PNP0C31: https://elixir.bootlin.com/linux/latest/source/drivers/c=
har/tpm/tpm_tis.c
>
> You should remove the check for TPM_VERSION_2_0.
>
>     Stefan
> > +    aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> > +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> > +    crs =3D aml_resource_template();
> > +    aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE, TPM_CRB_ADDR=
_SIZE,
> > +                                      AML_READ_WRITE));
> > +    aml_append(dev, aml_name_decl("_CRS", crs));
> > +    tpm_build_ppi_acpi(ti, dev);
> > +    aml_append(scope, dev);
> > +}
> > +
> >   static void tpm_crb_isa_class_init(ObjectClass *klass, void *data)
> >   {
> >       DeviceClass *dc =3D DEVICE_CLASS(klass);
> >       TPMIfClass *tc =3D TPM_IF_CLASS(klass);
> > +    AcpiDevAmlIfClass *adevc =3D ACPI_DEV_AML_IF_CLASS(klass);
> >
> >       dc->realize =3D tpm_crb_isa_realize;
> >       device_class_set_props(dc, tpm_crb_isa_properties);
> > @@ -128,6 +154,7 @@ static void tpm_crb_isa_class_init(ObjectClass *kla=
ss, void *data)
> >       tc->model =3D TPM_MODEL_TPM_CRB;
> >       tc->get_version =3D tpm_crb_isa_get_version;
> >       tc->request_completed =3D tpm_crb_isa_request_completed;
> > +    adevc->build_dev_aml =3D build_tpm_crb_isa_aml;
> >
> >       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> >   }
> > @@ -139,6 +166,7 @@ static const TypeInfo tpm_crb_isa_info =3D {
> >       .class_init  =3D tpm_crb_isa_class_init,
> >       .interfaces =3D (InterfaceInfo[]) {
> >           { TYPE_TPM_IF },
> > +        { TYPE_ACPI_DEV_AML_IF },
> >           { }
> >       }
> >   };


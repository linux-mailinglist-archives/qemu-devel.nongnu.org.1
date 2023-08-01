Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F17476A748
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 05:04:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQff8-0005je-TV; Mon, 31 Jul 2023 23:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qQff6-0005jV-T1
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 23:03:04 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qQff5-0007d3-1m
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 23:03:04 -0400
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-68706b39c4cso2894936b3a.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 20:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690858981; x=1691463781;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OO+W3UHP27/t5gygVCdVrCP5QxV1RKnF8QiKXEBf1Nc=;
 b=SYOWhIx2Xp6l0PoSBppJXaMT+GpeBCOa+nSK6IiqUw01bdDRRNLCyYA8XwomnUOCv+
 MFbRsNjnvdd62DIi+aDFdUPVj9U4Du4cB01HYmkQgzVE8FA0RfU/VMdTFLDSIPkYtZai
 1Uqmtp+tkOB3y6CIqkApYhE9eXzBt2Q2IKUakFBNjn/MpB0yJzkEovmCIv6OQQknz+Eb
 SjZZZMCtf5ZnYW6wTWUx7csYmfnl90YokGE3XqQpu3fQ3kfugLJ4zsJpQuQQ09yRRSbP
 bZCp6iTty1sv+5WjbfacBe+doo0W3/KcwTI6SYpPDzSd8Yl5MUQvHNqCOzJS4OjC6xds
 rGtA==
X-Gm-Message-State: ABy/qLYlYucrxY7Xfk9IEM0F/vLUZKOQzIBL2zidwyAe1QuBa8zPM2eX
 SFR3IesrLb9xUbJf9rwvC2MpkvWP9oI=
X-Google-Smtp-Source: APBJJlGchEAGyeoybmo1Ij60EXS9dmavnkdVF0bTk5Bo7QsQF2FFGUo+gehU5TiksBlLb043d8JzQg==
X-Received: by 2002:a05:6a00:138f:b0:686:9385:4644 with SMTP id
 t15-20020a056a00138f00b0068693854644mr13500496pfg.2.1690858981019; 
 Mon, 31 Jul 2023 20:03:01 -0700 (PDT)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com.
 [209.85.216.49]) by smtp.gmail.com with ESMTPSA id
 18-20020aa79152000000b00686f0b15b06sm8184001pfi.188.2023.07.31.20.03.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Jul 2023 20:03:00 -0700 (PDT)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2680ccc1d52so2956782a91.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 20:03:00 -0700 (PDT)
X-Received: by 2002:a17:90a:f995:b0:268:13e2:fc91 with SMTP id
 cq21-20020a17090af99500b0026813e2fc91mr10270226pjb.31.1690858980155; Mon, 31
 Jul 2023 20:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-7-j@getutm.app>
 <c3e07358-0d07-ffdc-6dbf-aab763ef92be@linux.ibm.com>
 <20230717154249.3b11f50a@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230717154249.3b11f50a@imammedo.users.ipa.redhat.com>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 31 Jul 2023 20:02:48 -0700
X-Gmail-Original-Message-ID: <CA+E+eSB4KkTP7mkMm4VWb6DE3nhSOOB7O9ibtusAW4KKjqQakg@mail.gmail.com>
Message-ID: <CA+E+eSB4KkTP7mkMm4VWb6DE3nhSOOB7O9ibtusAW4KKjqQakg@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] tpm_crb: move ACPI table building to device
 interface
To: Igor Mammedov <imammedo@redhat.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, Joelle van Dyne <j@getutm.app>,
 qemu-devel@nongnu.org, 
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.210.171; envelope-from=osy86dev@gmail.com;
 helo=mail-pf1-f171.google.com
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

On Mon, Jul 17, 2023 at 6:42=E2=80=AFAM Igor Mammedov <imammedo@redhat.com>=
 wrote:
>
> On Fri, 14 Jul 2023 13:21:33 -0400
> Stefan Berger <stefanb@linux.ibm.com> wrote:
>
> > On 7/14/23 03:09, Joelle van Dyne wrote:
> > > This logic is similar to TPM TIS ISA device. Since TPM CRB can only
> > > support TPM 2.0 backends, we check for this in realize.
> > >
> > > Signed-off-by: Joelle van Dyne <j@getutm.app>
> >
> > This patch changes the order of in which the ACPI table elements are cr=
eated but doesn't matter and also doesn't seem to upset ACPI test cases fro=
m what I saw:
>
> it seems we do have tests for TIS only (which I added when I was refactor=
ing it to TYPE_ACPI_DEV_AML_IF)
> perhaps add a test for CRB before this patch a follow process described i=
n bios-tables-test.c
> for updating expected blob
I read the file and looked at the commits for TIS tests but I'm not
sure I understand how it works. At what point do I specify that the
CRB device should be created for the test?

>
> >
> > Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> >
> > > ---
> > >   hw/i386/acpi-build.c | 23 -----------------------
> > >   hw/tpm/tpm_crb.c     | 29 +++++++++++++++++++++++++++++
> > >   2 files changed, 29 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > > index 9c74fa17ad..b767df39df 100644
> > > --- a/hw/i386/acpi-build.c
> > > +++ b/hw/i386/acpi-build.c
> > > @@ -1441,9 +1441,6 @@ build_dsdt(GArray *table_data, BIOSLinker *link=
er,
> > >       uint32_t nr_mem =3D machine->ram_slots;
> > >       int root_bus_limit =3D 0xFF;
> > >       PCIBus *bus =3D NULL;
> > > -#ifdef CONFIG_TPM
> > > -    TPMIf *tpm =3D tpm_find();
> > > -#endif
> > >       bool cxl_present =3D false;
> > >       int i;
> > >       VMBusBridge *vmbus_bridge =3D vmbus_bridge_find();
> > > @@ -1793,26 +1790,6 @@ build_dsdt(GArray *table_data, BIOSLinker *lin=
ker,
> > >           }
> > >       }
> > >
> > > -#ifdef CONFIG_TPM
> > > -    if (TPM_IS_CRB(tpm)) {
> > > -        dev =3D aml_device("TPM");
> > > -        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")=
));
> > > -        aml_append(dev, aml_name_decl("_STR",
> > > -                                      aml_string("TPM 2.0 Device")))=
;
> > > -        crs =3D aml_resource_template();
> > > -        aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE,
> > > -                                           TPM_CRB_ADDR_SIZE, AML_RE=
AD_WRITE));
> > > -        aml_append(dev, aml_name_decl("_CRS", crs));
> > > -
> > > -        aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
> > > -        aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> > > -
> > > -        tpm_build_ppi_acpi(tpm, dev);
> > > -
> > > -        aml_append(sb_scope, dev);
> > > -    }
> > > -#endif
> > > -
> > >       if (pcms->sgx_epc.size !=3D 0) {
> > >           uint64_t epc_base =3D pcms->sgx_epc.base;
> > >           uint64_t epc_size =3D pcms->sgx_epc.size;
> > > diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > > index 6144081d30..594696ffb8 100644
> > > --- a/hw/tpm/tpm_crb.c
> > > +++ b/hw/tpm/tpm_crb.c
> > > @@ -19,6 +19,8 @@
> > >   #include "qemu/module.h"
> > >   #include "qapi/error.h"
> > >   #include "exec/address-spaces.h"
> > > +#include "hw/acpi/acpi_aml_interface.h"
> > > +#include "hw/acpi/tpm.h"
> > >   #include "hw/qdev-properties.h"
> > >   #include "hw/pci/pci_ids.h"
> > >   #include "hw/acpi/tpm.h"
> > > @@ -99,6 +101,11 @@ static void tpm_crb_isa_realize(DeviceState *dev,=
 Error **errp)
> > >           return;
> > >       }
> > >
> > > +    if (tpm_crb_isa_get_version(TPM_IF(s)) !=3D TPM_VERSION_2_0) {
> > > +        error_setg(errp, "TPM CRB only supports TPM 2.0 backends");
> > > +        return;
> > > +    }
> > > +
> > >       tpm_crb_init_memory(OBJECT(s), &s->state, errp);
> > >
> > >       memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
> > > @@ -116,10 +123,30 @@ static void tpm_crb_isa_realize(DeviceState *de=
v, Error **errp)
> > >       }
> > >   }
> > >
> > > +static void build_tpm_crb_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
> > > +{
> > > +    Aml *dev, *crs;
> > > +    CRBState *s =3D CRB(adev);
> > > +    TPMIf *ti =3D TPM_IF(s);
> > > +
> > > +    dev =3D aml_device("TPM");
> > > +    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> > > +    aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device=
")));
> > > +    aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> > > +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> > > +    crs =3D aml_resource_template();
> > > +    aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE, TPM_CRB_AD=
DR_SIZE,
> > > +                                      AML_READ_WRITE));
> > > +    aml_append(dev, aml_name_decl("_CRS", crs));
> > > +    tpm_build_ppi_acpi(ti, dev);
> > > +    aml_append(scope, dev);
> > > +}
> > > +
> > >   static void tpm_crb_isa_class_init(ObjectClass *klass, void *data)
> > >   {
> > >       DeviceClass *dc =3D DEVICE_CLASS(klass);
> > >       TPMIfClass *tc =3D TPM_IF_CLASS(klass);
> > > +    AcpiDevAmlIfClass *adevc =3D ACPI_DEV_AML_IF_CLASS(klass);
> > >
> > >       dc->realize =3D tpm_crb_isa_realize;
> > >       device_class_set_props(dc, tpm_crb_isa_properties);
> > > @@ -128,6 +155,7 @@ static void tpm_crb_isa_class_init(ObjectClass *k=
lass, void *data)
> > >       tc->model =3D TPM_MODEL_TPM_CRB;
> > >       tc->get_version =3D tpm_crb_isa_get_version;
> > >       tc->request_completed =3D tpm_crb_isa_request_completed;
> > > +    adevc->build_dev_aml =3D build_tpm_crb_isa_aml;
> > >
> > >       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> > >   }
> > > @@ -139,6 +167,7 @@ static const TypeInfo tpm_crb_isa_info =3D {
> > >       .class_init  =3D tpm_crb_isa_class_init,
> > >       .interfaces =3D (InterfaceInfo[]) {
> > >           { TYPE_TPM_IF },
> > > +        { TYPE_ACPI_DEV_AML_IF },
> > >           { }
> > >       }
> > >   };
> >
>


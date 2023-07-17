Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 374C7756553
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 15:44:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLOVG-0003ca-Bg; Mon, 17 Jul 2023 09:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qLOVA-0003aR-Pf
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 09:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qLOV8-0000Rr-2P
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 09:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689601376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8KRSxHn6yfXZ8Codtuh0DLQrMJtdfqj6AMa+JpCtOxM=;
 b=R3bu4dDybJglSlqX0t+sj2m2SIw8iOGkxJBcITrFUAGtTxl18BCcX00feV2UKAF7X/PEpT
 Tc21jfXjHHgmcI8D8Judd4p4Igc0xQe5nCuaeDajh2mFoAZl4Ld7xgWSc5OT0eL7ePHzRr
 1Heq22OhE42aGbLkFwA54Ov276l8SpA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-WYwtDfDrPzGxo3v4depSyQ-1; Mon, 17 Jul 2023 09:42:52 -0400
X-MC-Unique: WYwtDfDrPzGxo3v4depSyQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9892495397cso262869466b.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 06:42:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689601371; x=1692193371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8KRSxHn6yfXZ8Codtuh0DLQrMJtdfqj6AMa+JpCtOxM=;
 b=WuCWU5clWqaSwJGiqJJZeuACy+AgLi0/MuGDKHltY341BtVYqSTnxb4G8gwsrMxU3C
 7MW1/rl4757glgbUt1++FuPE/x3UkjcgqJmoAfEx2NOQ+uG/zmcFFuBlgamsOgCDSZnj
 IiYFjakwvt3aQFqJFceBprhlAY3zmI92mEisAUrThkBeL6jQ13nN6JkKtZ+gYz7XsR35
 jrJW9gQTX7jl27EhhGNKWCJQzcyhnueGC0QFIemghMhLaZPYBZKvj1XkROR3DL2I4bAQ
 KUTbQXze/CaNaUsmpSW+s2LI0MXFuOqf3dr2NScGigbhd/+OKK5BMdVrlsfwFGBvzf1v
 Y7sg==
X-Gm-Message-State: ABy/qLaQEtHfcxpNAoPPXcSLY5Y5cQ2xPZ9YHUxp8/AkSHZRgLc6icpM
 M9e+QwRBoYbGxlZ3FSi/Btw+zYOKrD0KdgIZ2yWllRaIorRhW6+L9Du5sgxpRyyVre2YtBdSDlE
 KDmwffhCDA+c0958=
X-Received: by 2002:a17:907:2ceb:b0:982:45ca:ac06 with SMTP id
 hz11-20020a1709072ceb00b0098245caac06mr11658720ejc.60.1689601371524; 
 Mon, 17 Jul 2023 06:42:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEusPIaHDk91Rkz42ukSaemLPXzOpRYYoEFF+T/VQy67rufxgzuEQOJEK39wmgOZz3CEnrZPw==
X-Received: by 2002:a17:907:2ceb:b0:982:45ca:ac06 with SMTP id
 hz11-20020a1709072ceb00b0098245caac06mr11658705ejc.60.1689601371225; 
 Mon, 17 Jul 2023 06:42:51 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 j22-20020a170906411600b00993159ce075sm9109023ejk.210.2023.07.17.06.42.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 06:42:50 -0700 (PDT)
Date: Mon, 17 Jul 2023 15:42:49 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 06/11] tpm_crb: move ACPI table building to device
 interface
Message-ID: <20230717154249.3b11f50a@imammedo.users.ipa.redhat.com>
In-Reply-To: <c3e07358-0d07-ffdc-6dbf-aab763ef92be@linux.ibm.com>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-7-j@getutm.app>
 <c3e07358-0d07-ffdc-6dbf-aab763ef92be@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 14 Jul 2023 13:21:33 -0400
Stefan Berger <stefanb@linux.ibm.com> wrote:

> On 7/14/23 03:09, Joelle van Dyne wrote:
> > This logic is similar to TPM TIS ISA device. Since TPM CRB can only
> > support TPM 2.0 backends, we check for this in realize.
> > 
> > Signed-off-by: Joelle van Dyne <j@getutm.app>  
> 
> This patch changes the order of in which the ACPI table elements are created but doesn't matter and also doesn't seem to upset ACPI test cases from what I saw:

it seems we do have tests for TIS only (which I added when I was refactoring it to TYPE_ACPI_DEV_AML_IF)
perhaps add a test for CRB before this patch a follow process described in bios-tables-test.c
for updating expected blob

>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> > ---
> >   hw/i386/acpi-build.c | 23 -----------------------
> >   hw/tpm/tpm_crb.c     | 29 +++++++++++++++++++++++++++++
> >   2 files changed, 29 insertions(+), 23 deletions(-)
> > 
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> > index 9c74fa17ad..b767df39df 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1441,9 +1441,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >       uint32_t nr_mem = machine->ram_slots;
> >       int root_bus_limit = 0xFF;
> >       PCIBus *bus = NULL;
> > -#ifdef CONFIG_TPM
> > -    TPMIf *tpm = tpm_find();
> > -#endif
> >       bool cxl_present = false;
> >       int i;
> >       VMBusBridge *vmbus_bridge = vmbus_bridge_find();
> > @@ -1793,26 +1790,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
> >           }
> >       }
> > 
> > -#ifdef CONFIG_TPM
> > -    if (TPM_IS_CRB(tpm)) {
> > -        dev = aml_device("TPM");
> > -        aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> > -        aml_append(dev, aml_name_decl("_STR",
> > -                                      aml_string("TPM 2.0 Device")));
> > -        crs = aml_resource_template();
> > -        aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE,
> > -                                           TPM_CRB_ADDR_SIZE, AML_READ_WRITE));
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
> >       if (pcms->sgx_epc.size != 0) {
> >           uint64_t epc_base = pcms->sgx_epc.base;
> >           uint64_t epc_size = pcms->sgx_epc.size;
> > diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > index 6144081d30..594696ffb8 100644
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
> > @@ -99,6 +101,11 @@ static void tpm_crb_isa_realize(DeviceState *dev, Error **errp)
> >           return;
> >       }
> > 
> > +    if (tpm_crb_isa_get_version(TPM_IF(s)) != TPM_VERSION_2_0) {
> > +        error_setg(errp, "TPM CRB only supports TPM 2.0 backends");
> > +        return;
> > +    }
> > +
> >       tpm_crb_init_memory(OBJECT(s), &s->state, errp);
> > 
> >       memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
> > @@ -116,10 +123,30 @@ static void tpm_crb_isa_realize(DeviceState *dev, Error **errp)
> >       }
> >   }
> > 
> > +static void build_tpm_crb_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
> > +{
> > +    Aml *dev, *crs;
> > +    CRBState *s = CRB(adev);
> > +    TPMIf *ti = TPM_IF(s);
> > +
> > +    dev = aml_device("TPM");
> > +    aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
> > +    aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
> > +    aml_append(dev, aml_name_decl("_UID", aml_int(1)));
> > +    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
> > +    crs = aml_resource_template();
> > +    aml_append(crs, aml_memory32_fixed(TPM_CRB_ADDR_BASE, TPM_CRB_ADDR_SIZE,
> > +                                      AML_READ_WRITE));
> > +    aml_append(dev, aml_name_decl("_CRS", crs));
> > +    tpm_build_ppi_acpi(ti, dev);
> > +    aml_append(scope, dev);
> > +}
> > +
> >   static void tpm_crb_isa_class_init(ObjectClass *klass, void *data)
> >   {
> >       DeviceClass *dc = DEVICE_CLASS(klass);
> >       TPMIfClass *tc = TPM_IF_CLASS(klass);
> > +    AcpiDevAmlIfClass *adevc = ACPI_DEV_AML_IF_CLASS(klass);
> > 
> >       dc->realize = tpm_crb_isa_realize;
> >       device_class_set_props(dc, tpm_crb_isa_properties);
> > @@ -128,6 +155,7 @@ static void tpm_crb_isa_class_init(ObjectClass *klass, void *data)
> >       tc->model = TPM_MODEL_TPM_CRB;
> >       tc->get_version = tpm_crb_isa_get_version;
> >       tc->request_completed = tpm_crb_isa_request_completed;
> > +    adevc->build_dev_aml = build_tpm_crb_isa_aml;
> > 
> >       set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> >   }
> > @@ -139,6 +167,7 @@ static const TypeInfo tpm_crb_isa_info = {
> >       .class_init  = tpm_crb_isa_class_init,
> >       .interfaces = (InterfaceInfo[]) {
> >           { TYPE_TPM_IF },
> > +        { TYPE_ACPI_DEV_AML_IF },
> >           { }
> >       }
> >   };  
> 



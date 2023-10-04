Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9027B9735
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 00:14:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoA8E-0001az-Ct; Wed, 04 Oct 2023 18:14:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoA8C-0001aj-R1
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qoA8B-0000aZ-2f
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:14:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696457649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XA8Dkk6acZDfpGKAnCmebFAAKM8/IPnM4lcqsbanNps=;
 b=PEDWA7AFmjXr1fRYRgHtd2kxP+psg0VKTl0zm/Uver3xVN6b7aX8IHznIw5AcToXDPUfVA
 TljVe+eh7c4/oLZcMXu3JYv2IwzsMTEgFHZHwENXSFULiLghWcOKzXPc17VZthjBte0Dwy
 up4KLynNZn2SX/zF2eEiVtSRqunQ/Zs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-dol8B4UQPza0dG3_vcECrA-1; Wed, 04 Oct 2023 18:14:07 -0400
X-MC-Unique: dol8B4UQPza0dG3_vcECrA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40554735995so2236255e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 15:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696457646; x=1697062446;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XA8Dkk6acZDfpGKAnCmebFAAKM8/IPnM4lcqsbanNps=;
 b=buQCmbTcAnCNFQXAQy7IHnsFWIgy76KyJ/hnrs3FdLPQFMwzp1iByAIc2Gsodp2svT
 hu5x8DDedQ2tej+tLo23NE9HsaFZDbdCwwWNkYi1kxFzI50+TZTv3g8iLSwkacwWiCMR
 HiixMaE2AtlwK+TEGUqAD5l0XDmgTDZxmC3KI92Ea77jCfVHVyvaVDAJTrmEt+NqxBOc
 6XKq73V0tjlJTB9qro9WQwwN1gxdFXu66p/4I8aJoUahiHv8laR+DuFEh9V9mDZu+wiQ
 h8sWS+NG21U5e2+Azo5fNbIpirsJx9wayS5OpdZa/vXKuGlcEiDt3oSu3LrG8mbaRi2g
 +8mg==
X-Gm-Message-State: AOJu0YzSOKP2gPt/iqIYzWujOP5WA8qzIAFVAPTDOU0HFTChAQ3ZHVgB
 +u+REQDHFcpICRzMOIy69ltaC/62eFuvMgB0vpiO5PI/8GmzRHTme8mpetQ4OkEsITEME31ntF/
 sD3QrOBF7FiS0ckM=
X-Received: by 2002:a1c:6a0c:0:b0:404:757e:c5ba with SMTP id
 f12-20020a1c6a0c000000b00404757ec5bamr3107875wmc.26.1696457646334; 
 Wed, 04 Oct 2023 15:14:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCB65UQT9Y6UXaNWiMQ7YtVIEQJ5W89QbzFKAuWmbcek2z+1ENQcPjCDYA8MxO6Hviqae43g==
X-Received: by 2002:a1c:6a0c:0:b0:404:757e:c5ba with SMTP id
 f12-20020a1c6a0c000000b00404757ec5bamr3107850wmc.26.1696457645906; 
 Wed, 04 Oct 2023 15:14:05 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 m20-20020a7bca54000000b00406408dc788sm2422056wml.44.2023.10.04.15.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 15:14:04 -0700 (PDT)
Date: Wed, 4 Oct 2023 18:14:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Dave Jiang <dave.jiang@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PULL 33/63] hw/cxl: Add QTG _DSM support for ACPI0017 device
Message-ID: <20231004180529-mutt-send-email-mst@kernel.org>
References: <cover.1696408966.git.mst@redhat.com>
 <0bae0aebf44ac89b47ef11c5d101323dd5540951.1696408966.git.mst@redhat.com>
 <f563aba2-2261-d4e7-dbe7-92396a595ea4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f563aba2-2261-d4e7-dbe7-92396a595ea4@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 04, 2023 at 07:46:19PM +0200, Thomas Huth wrote:
> On 04/10/2023 10.44, Michael S. Tsirkin wrote:
> > From: Dave Jiang <dave.jiang@intel.com>
> > 
> > Add a simple _DSM call support for the ACPI0017 device to return a fake QTG
> > ID value of 0 in all cases. The enabling is for _DSM plumbing testing
> > from the OS.
> > 
> > Following edited for readbility only
> > 
> > Device (CXLM)
> > {
> >      Name (_HID, "ACPI0017")  // _HID: Hardware ID
> > ...
> >      Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
> >      {
> >          If ((Arg0 == ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52")))
> >          {
> >              If ((Arg2 == Zero))
> >              {
> >                  Return (Buffer (One) { 0x01 })
> >              }
> > 
> >              If ((Arg2 == One))
> >              {
> >                  Return (Package (0x02)
> >                  {
> >                      Buffer (0x02)
> >                      { 0x01, 0x00 },
> >                      Package (0x01)
> >                      {
> >                          Buffer (0x02)
> >                          { 0x00, 0x00 }
> >                      }
> >                  })
> >              }
> >          }
> >      }
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > --
> > v2: Minor edit to drop reference to switches in patch description.
> > Message-Id: <20230904161847.18468-3-Jonathan.Cameron@huawei.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   include/hw/acpi/cxl.h |  1 +
> >   hw/acpi/cxl.c         | 57 +++++++++++++++++++++++++++++++++++++++++++
> >   hw/i386/acpi-build.c  |  1 +
> >   3 files changed, 59 insertions(+)
> > 
> > diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
> > index acf4418886..8f22c71530 100644
> > --- a/include/hw/acpi/cxl.h
> > +++ b/include/hw/acpi/cxl.h
> > @@ -25,5 +25,6 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
> >                       BIOSLinker *linker, const char *oem_id,
> >                       const char *oem_table_id, CXLState *cxl_state);
> >   void build_cxl_osc_method(Aml *dev);
> > +void build_cxl_dsm_method(Aml *dev);
> >   #endif
> > diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> > index 92b46bc932..5e9039785a 100644
> > --- a/hw/acpi/cxl.c
> > +++ b/hw/acpi/cxl.c
> > @@ -30,6 +30,63 @@
> >   #include "qapi/error.h"
> >   #include "qemu/uuid.h"
> > +void build_cxl_dsm_method(Aml *dev)
> > +{
> > +    Aml *method, *ifctx, *ifctx2;
> > +
> > +    method = aml_method("_DSM", 4, AML_SERIALIZED);
> > +    {
> > +        Aml *function, *uuid;
> > +
> > +        uuid = aml_arg(0);
> > +        function = aml_arg(2);
> > +        /* CXL spec v3.0 9.17.3.1 *, QTG ID _DSM */
> > +        ifctx = aml_if(aml_equal(
> > +            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
> > +
> > +        /* Function 0, standard DSM query function */
> > +        ifctx2 = aml_if(aml_equal(function, aml_int(0)));
> > +        {
> > +            uint8_t byte_list[1] = { 0x01 }; /* functions 1 only */
> > +
> > +            aml_append(ifctx2,
> > +                       aml_return(aml_buffer(sizeof(byte_list), byte_list)));
> > +        }
> > +        aml_append(ifctx, ifctx2);
> > +
> > +        /*
> > +         * Function 1
> > +         * A return value of {1, {0}} inciate that
> > +         * max supported QTG ID of 1 and recommended QTG is 0.
> > +         * The values here are faked to simplify emulation.
> > +         */
> > +        ifctx2 = aml_if(aml_equal(function, aml_int(1)));
> > +        {
> > +            uint16_t word_list[1] = { 0x01 };
> > +            uint16_t word_list2[1] = { 0 };
> > +            uint8_t *byte_list = (uint8_t *)word_list;
> > +            uint8_t *byte_list2 = (uint8_t *)word_list2;
> > +            Aml *pak, *pak1;
> > +
> > +            /*
> > +             * The return package is a package of a WORD and another package.
> > +             * The embedded package contains 0 or more WORDs for the
> > +             * recommended QTG IDs.
> > +             */
> > +            pak1 = aml_package(1);
> > +            aml_append(pak1, aml_buffer(sizeof(uint16_t), byte_list2));
> > +            pak = aml_package(2);
> > +            aml_append(pak, aml_buffer(sizeof(uint16_t), byte_list));
> > +            aml_append(pak, pak1);
> 
> This looks fishy ... first declaring a uint16_t array in host endian order,
> then casting it to an uint8_t* byte array for code that likely expects
> little endian byte order in the guest ... I assume that this won't work and
> needs some more love for big endian hosts?
> 
>  Thomas
> 


Oh, good catch!
So that would be "Add dummy ACPI QTG DSM".

I actually also don't like sizeof(uint16_t) here, it should be
sizeof array. Maybe it actually can use build_append_int_noprefix
in some way?

And inciate is a typo.


> > +            aml_append(ifctx2, aml_return(pak));
> > +        }
> > +        aml_append(ifctx, ifctx2);
> > +    }
> > +    aml_append(method, ifctx);
> > +    aml_append(dev, method);
> > +}
> 



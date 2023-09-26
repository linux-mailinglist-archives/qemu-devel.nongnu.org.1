Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8D17AEC0B
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 14:01:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql6jv-0006OK-Ri; Tue, 26 Sep 2023 08:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ql6jl-0006JX-Kn
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ql6jj-0005Ps-DD
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 08:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695729618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4NmQkghllO1nGwm91UHl7HGCTJD6XVEi2WmtgRIkds=;
 b=Y0GMtna4vu+ES3Wm1HrWCrChMmMFIVefB6XrJPGjfq04K48K4zYZNcR6kZF+sq1HTc3lX+
 DDrCMlJpKHD4kM7C3LV7QJJFeFqxzE1ciD3H+V67PWJHShJWnOVlELnjW3rvCZNfSIngr5
 a27/39IiIB7l4fIStw9IKX03Um3iJXA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-lvw73hurNvOnVqTfHTVfPw-1; Tue, 26 Sep 2023 08:00:17 -0400
X-MC-Unique: lvw73hurNvOnVqTfHTVfPw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-503343a850aso13039444e87.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 05:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695729616; x=1696334416;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4NmQkghllO1nGwm91UHl7HGCTJD6XVEi2WmtgRIkds=;
 b=sclieTGJxfuER9NTYQnmdHxHi856qL2D36g4I1BCA/j67BAfwgiqm5e+Aool2gMCSL
 l3PhTLzobjZuuvXZKT/Ph/ikjL1OwjgLMixJIGY0K5U5+m3pG+vovONt17KKuTXSE+yA
 C5Lvz8SKb3GaGjEOXCvgi/LE/LNkaArp7IfWmz8zLJdw2c1aoasRbkP68A7LvvfMSMUp
 OnJi17TT9yCSWJOk5pgJsWaZJn4NgYEdoqtxVeYCn7uwXjwWCOeqPNX1ZBCMn5Dyy8yz
 6NAgwQhVa1W438d2dkKlEcmW2RbtepWw+WfZhWyuBU48fma6kb8Y21DgrJXAc+h2gqup
 64ng==
X-Gm-Message-State: AOJu0YxQJIEF9nAhumDkNDp1AbnvHXdxLRKd/tjNqh4cW0Cmf6uNEiWV
 rsTBSOS1RCo7u/2qPSH8xPNHGjo1Ds5bDC7+xaAEFA8GkxvGRNbXuxb4cSSJzAb4EKpz1Ix2dFA
 S++x5fZ76nu64W9g=
X-Received: by 2002:a05:6512:b0a:b0:4fb:9fa7:dcda with SMTP id
 w10-20020a0565120b0a00b004fb9fa7dcdamr9564748lfu.26.1695729615687; 
 Tue, 26 Sep 2023 05:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwUMVB4d8DMbWsLGirxzt3P7OYfWpSOmwr33+1bVHqXkLI2YY/kWNQLoYxp5Siu1ToLotCOw==
X-Received: by 2002:a05:6512:b0a:b0:4fb:9fa7:dcda with SMTP id
 w10-20020a0565120b0a00b004fb9fa7dcdamr9564686lfu.26.1695729615257; 
 Tue, 26 Sep 2023 05:00:15 -0700 (PDT)
Received: from redhat.com ([2.52.31.177]) by smtp.gmail.com with ESMTPSA id
 c23-20020aa7d617000000b0052a1c0c859asm6802502edr.59.2023.09.26.05.00.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 05:00:14 -0700 (PDT)
Date: Tue, 26 Sep 2023 08:00:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>
Subject: Re: [PATCH RFC V2 24/37] hw/acpi: Update ACPI GED framework to
 support vCPU Hotplug
Message-ID: <20230926075838-mutt-send-email-mst@kernel.org>
References: <20230926100436.28284-1-salil.mehta@huawei.com>
 <20230926100436.28284-25-salil.mehta@huawei.com>
 <20230926070112-mutt-send-email-mst@kernel.org>
 <f68a5ccc153f4971b5fbe681095a7624@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f68a5ccc153f4971b5fbe681095a7624@huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 26, 2023 at 11:37:38AM +0000, Salil Mehta wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, September 26, 2023 12:02 PM
> > To: Salil Mehta <salil.mehta@huawei.com>
> > Cc: qemu-devel@nongnu.org; qemu-arm@nongnu.org; maz@kernel.org; jean-
> > philippe@linaro.org; Jonathan Cameron <jonathan.cameron@huawei.com>;
> > lpieralisi@kernel.org; peter.maydell@linaro.org;
> > richard.henderson@linaro.org; imammedo@redhat.com; andrew.jones@linux.dev;
> > david@redhat.com; philmd@linaro.org; eric.auger@redhat.com;
> > will@kernel.org; ardb@kernel.org; oliver.upton@linux.dev;
> > pbonzini@redhat.com; gshan@redhat.com; rafael@kernel.org;
> > borntraeger@linux.ibm.com; alex.bennee@linaro.org; linux@armlinux.org.uk;
> > darren@os.amperecomputing.com; ilkka@os.amperecomputing.com;
> > vishnu@os.amperecomputing.com; karl.heubaum@oracle.com;
> > miguel.luis@oracle.com; salil.mehta@opnsrc.net; zhukeqian
> > <zhukeqian1@huawei.com>; wangxiongfeng (C) <wangxiongfeng2@huawei.com>;
> > wangyanan (Y) <wangyanan55@huawei.com>; jiakernel2@gmail.com;
> > maobibo@loongson.cn; lixianglai@loongson.cn
> > Subject: Re: [PATCH RFC V2 24/37] hw/acpi: Update ACPI GED framework to
> > support vCPU Hotplug
> > 
> > On Tue, Sep 26, 2023 at 11:04:23AM +0100, Salil Mehta wrote:
> > > ACPI GED shall be used to convey to the guest kernel about any CPU hot-
> > (un)plug
> > > events. Therefore, existing ACPI GED framework inside QEMU needs to be
> > enhanced
> > > to support CPU hotplug state and events.
> > >
> > > Co-developed-by: Salil Mehta <salil.mehta@huawei.com>
> > 
> > Co-developed with yourself?
> > 
> > didn't you co-develop this with xianglai li?
> 
> No, our effort is quite old ARM patch-set existed since the year 2020
> without any change. Please check the original patch-set here:
> 
> https://lore.kernel.org/qemu-devel/20200613213629.21984-11-salil.mehta@huawei.com/
> 
> 
> To be fair to the authors, it will not be right to add another SOB here.
> 

I see. And what's the difference with patches that xianglai li posted?
Are they both rebases of the same old patch then?

> 
> > 
> > Just include his S.O.B then, and drop the non-standard Co-developed-by.
> 
> Co-developed-by Tag has been added to ensure main authors of the patch
> get highlighted clearly.

I think I don't know the patch provenance at this point.

> 
> > 
> > 
> > 
> > > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > > Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
> > > Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> > > Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
> > 
> > 
> > 
> > > ---
> > >  hw/acpi/generic_event_device.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/hw/acpi/generic_event_device.c
> > b/hw/acpi/generic_event_device.c
> > > index ad252e6a91..0266733a54 100644
> > > --- a/hw/acpi/generic_event_device.c
> > > +++ b/hw/acpi/generic_event_device.c
> > > @@ -12,6 +12,7 @@
> > >  #include "qemu/osdep.h"
> > >  #include "qapi/error.h"
> > >  #include "hw/acpi/acpi.h"
> > > +#include "hw/acpi/cpu.h"
> > >  #include "hw/acpi/generic_event_device.h"
> > >  #include "hw/irq.h"
> > >  #include "hw/mem/pc-dimm.h"
> > > @@ -239,6 +240,8 @@ static void acpi_ged_device_plug_cb(HotplugHandler
> > *hotplug_dev,
> > >          } else {
> > >              acpi_memory_plug_cb(hotplug_dev, &s->memhp_state, dev,
> > errp);
> > >          }
> > > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> > > +        acpi_cpu_plug_cb(hotplug_dev, &s->cpuhp_state, dev, errp);
> > >      } else {
> > >          error_setg(errp, "virt: device plug request for unsupported
> > device"
> > >                     " type: %s", object_get_typename(OBJECT(dev)));
> > > @@ -253,6 +256,8 @@ static void acpi_ged_unplug_request_cb(HotplugHandler
> > *hotplug_dev,
> > >      if ((object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) &&
> > >                         !(object_dynamic_cast(OBJECT(dev),
> > TYPE_NVDIMM)))) {
> > >          acpi_memory_unplug_request_cb(hotplug_dev, &s->memhp_state, dev,
> > errp);
> > > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> > > +        acpi_cpu_unplug_request_cb(hotplug_dev, &s->cpuhp_state, dev,
> > errp);
> > >      } else {
> > >          error_setg(errp, "acpi: device unplug request for unsupported
> > device"
> > >                     " type: %s", object_get_typename(OBJECT(dev)));
> > > @@ -266,6 +271,8 @@ static void acpi_ged_unplug_cb(HotplugHandler
> > *hotplug_dev,
> > >
> > >      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > >          acpi_memory_unplug_cb(&s->memhp_state, dev, errp);
> > > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
> > > +        acpi_cpu_unplug_cb(&s->cpuhp_state, dev, errp);
> > >      } else {
> > >          error_setg(errp, "acpi: device unplug for unsupported device"
> > >                     " type: %s", object_get_typename(OBJECT(dev)));
> > > @@ -277,6 +284,7 @@ static void acpi_ged_ospm_status(AcpiDeviceIf *adev,
> > ACPIOSTInfoList ***list)
> > >      AcpiGedState *s = ACPI_GED(adev);
> > >
> > >      acpi_memory_ospm_status(&s->memhp_state, list);
> > > +    acpi_cpu_ospm_status(&s->cpuhp_state, list);
> > >  }
> > >
> > >  static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits
> > ev)
> > > @@ -291,6 +299,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev,
> > AcpiEventStatusBits ev)
> > >          sel = ACPI_GED_PWR_DOWN_EVT;
> > >      } else if (ev & ACPI_NVDIMM_HOTPLUG_STATUS) {
> > >          sel = ACPI_GED_NVDIMM_HOTPLUG_EVT;
> > > +    } else if (ev & ACPI_CPU_HOTPLUG_STATUS) {
> > > +        sel = ACPI_GED_CPU_HOTPLUG_EVT;
> > >      } else {
> > >          /* Unknown event. Return without generating interrupt. */
> > >          warn_report("GED: Unsupported event %d. No irq injected", ev);
> > > --
> > > 2.34.1



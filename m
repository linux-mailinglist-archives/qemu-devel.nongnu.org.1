Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B3FAE19A8
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Jun 2025 13:11:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSZdH-0002pP-W2; Fri, 20 Jun 2025 07:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSZd1-0002oh-HC
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 07:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uSZcz-0005Bv-Dv
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 07:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750417786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0OqQ2p2Hgz2qUTH7fsIcOPZtBPS8OhJGUFJyKwSHi/Y=;
 b=Kn8HA7g3zPqz8fAn83SHPtSkRFKBUVgppRtAAfhKrnl/irxhBz1yuZ/QHEokxWm8Pnw0cj
 q4LFwDjLA7qK7p5VEhaQ6VWQTe6bPq5MW51Bw+vkVlfVwQ2U5e3vxs7NcHfTHHoiEYNCiI
 J3AubfGqSSZADtWtxk1upE2/X7ca340=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-z4Yz9q0IMnq07uAQOtBDyQ-1; Fri, 20 Jun 2025 07:09:45 -0400
X-MC-Unique: z4Yz9q0IMnq07uAQOtBDyQ-1
X-Mimecast-MFC-AGG-ID: z4Yz9q0IMnq07uAQOtBDyQ_1750417784
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4535ad64d30so13819575e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 04:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750417784; x=1751022584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0OqQ2p2Hgz2qUTH7fsIcOPZtBPS8OhJGUFJyKwSHi/Y=;
 b=tXwGfHZFKS5yKD/Qdsfr+oofhssc1hxq6493LACWslmkhHwHqm8j47+bafZY9UxIBO
 PyWVn7kIsOywg2pHU4W7ZbRue9uXIGoPzgMXK5zKw9eked56HL2ofvy81fVIPz7odE/I
 FtpEYgMsimwM7ukNoRtKWWnLgegNY5uPLgahXz54xc7mPi7XGa7AKF9bf6TugBU8Z9JE
 tcoT1zX3XanA7xM86K4u1dqIaH6P42vcRdYIAKJPX9C2oAGoWBqQWdj1BfrhU6U3Aeks
 fs+LZlPVodQLCwgJfUdkpYBAplSu5oS8ot8fnhnB1jD+gFWsxJRquieje3yGJSEldwez
 ZAjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvE7tBKUoBihdHBaQNh+xCsD8RGeJ1X1TDSQ6dYCB3Y6Bea7awwl3zsIk/FQmfBhUzm6KH8PVQFTqj@nongnu.org
X-Gm-Message-State: AOJu0YxNMlpQTvQE+BNyB51fPPSF3xSyr1OuxPJmbN05RDqBp22qHNCP
 wOM0Vkr2CvRxo3kmPEBTmEupgag6P1kKmmCBS8pr2hmhp21GG3Se4jqSr4ErOGT1SvQ8rGhZ/FY
 FH1euGlnDTr3pzWBWxcSf16eNv3oWwNx1xXmOY9Yta4naSGuVyfxes5C7
X-Gm-Gg: ASbGnctKRmo/+Rk2nYAbxUvdIft/HqVK02XCpiUnXcXePEHMyyfa1tE4PlzvGEni95h
 O3zh+TFPuFYE51M7tlPILni0szA8OfYJShbmNZ5/8cIIbkMocyMl0KNLbqvMQ4dfuxP2U58COUF
 +6NStFxdtbT7U/l17TwtVsv+loIV+k8cfxaopZ31U9rH7wW7Yvxdq2XGvCFxMomME4oughfZ8Af
 tZqvCv0GzQixjBT5tTB3amS4eTZL7SlvOLMjkw36UpK5knqhTqpFaBjsTrnWEMeBeh3/lOq0iMa
 AHyzcwJ4iJpT
X-Received: by 2002:a05:600c:3545:b0:442:f12f:bd9f with SMTP id
 5b1f17b1804b1-453659d44f9mr19572865e9.27.1750417784180; 
 Fri, 20 Jun 2025 04:09:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMU4rkFUXg13dd5ykQDb15WXmPryXUYK+cdEC5+2LyM5fqkv6pJ6+l36peZPmn3Bd8nbAS5A==
X-Received: by 2002:a05:600c:3545:b0:442:f12f:bd9f with SMTP id
 5b1f17b1804b1-453659d44f9mr19572595e9.27.1750417783791; 
 Fri, 20 Jun 2025 04:09:43 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453632312a3sm31618575e9.1.2025.06.20.04.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jun 2025 04:09:43 -0700 (PDT)
Date: Fri, 20 Jun 2025 13:09:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Eric Auger <eric.auger@redhat.com>, <eric.auger.pro@gmail.com>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <peter.maydell@linaro.org>,
 <gustavo.romero@linaro.org>, <anisinha@redhat.com>, <mst@redhat.com>,
 <shannon.zhaosl@gmail.com>, <pbonzini@redhat.com>, <philmd@linaro.org>,
 <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 02/29] hw/acpi/ged: Add a
 acpi-pci-hotplug-with-bridge-support property
Message-ID: <20250620130941.6c0e6ff8@fedora>
In-Reply-To: <20250620095308.00000d16@huawei.com>
References: <20250616094903.885753-1-eric.auger@redhat.com>
 <20250616094903.885753-3-eric.auger@redhat.com>
 <20250620095308.00000d16@huawei.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 20 Jun 2025 09:53:08 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Mon, 16 Jun 2025 11:46:31 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
> 
> > A new boolean property is introduced. This will be used to turn
> > ACPI PCI hotplug support. By default it is unset.
> > 
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>  
> 
> I wonder a bit if it makes sense to do this so early rather than just
> before it is first used in the series?  Doesn't really matter though.
> Just meant I read on a bit before giving an RB on this.

Just before would be better, but it doesn't really matter.
I guess Eric can rearrange that if there would be need to respin.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> > ---
> >  include/hw/acpi/generic_event_device.h | 2 ++
> >  hw/acpi/generic_event_device.c         | 2 ++
> >  2 files changed, 4 insertions(+)
> > 
> > diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
> > index d2dac87b4a..f5ffa67a39 100644
> > --- a/include/hw/acpi/generic_event_device.h
> > +++ b/include/hw/acpi/generic_event_device.h
> > @@ -63,6 +63,7 @@
> >  #include "hw/acpi/memory_hotplug.h"
> >  #include "hw/acpi/ghes.h"
> >  #include "hw/acpi/cpu.h"
> > +#include "hw/acpi/pcihp.h"
> >  #include "qom/object.h"
> >  
> >  #define ACPI_POWER_BUTTON_DEVICE "PWRB"
> > @@ -114,6 +115,7 @@ struct AcpiGedState {
> >      MemoryRegion container_memhp;
> >      CPUHotplugState cpuhp_state;
> >      MemoryRegion container_cpuhp;
> > +    AcpiPciHpState pcihp_state;
> >      GEDState ged_state;
> >      uint32_t ged_event_bitmap;
> >      qemu_irq irq;
> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > index 7a62f8d5bc..7831db412b 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -318,6 +318,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
> >  
> >  static const Property acpi_ged_properties[] = {
> >      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> > +    DEFINE_PROP_BOOL(ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, AcpiGedState,
> > +                     pcihp_state.use_acpi_hotplug_bridge, 0),
> >  };
> >  
> >  static const VMStateDescription vmstate_memhp_state = {  
> 



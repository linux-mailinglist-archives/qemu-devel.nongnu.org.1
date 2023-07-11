Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 934A374E959
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 10:49:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ91y-0002KG-J5; Tue, 11 Jul 2023 04:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qJ91w-0002Jt-QZ
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 04:47:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qJ91p-0006Hv-Dh
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 04:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689065244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a0jks4zyzUK5FTWiUbIYHZE5X6iLF/reQlhpFh/ub0s=;
 b=VnmksycEZU0EjLKjpESLKXyalOPuQpcyQq/+HOZLTGfXocfn1DY8qNH0m+rSEKrQ7nnoRx
 6IOo1PFanfYQT8VAYKRFfQCVOBtaepJOxn9CqfsJt3w7u9xY+i5i0fqNo5zbIsJEa0YLXU
 5Zhd2PrpVMWILA7Ap9qXGC2qeSztvF8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-DdOT2RGwPmyvJH_FFbfN2Q-1; Tue, 11 Jul 2023 04:47:22 -0400
X-MC-Unique: DdOT2RGwPmyvJH_FFbfN2Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-4fb76659d54so4769677e87.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 01:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689065241; x=1691657241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0jks4zyzUK5FTWiUbIYHZE5X6iLF/reQlhpFh/ub0s=;
 b=CHLYBBHHMYBmrUPe9H7dKCuXiImZcNYIRtKcCbbh2pWlYzBqPQOHuP1AFjqdcv22SF
 Ypmh5NJXi559JfMAH6XwigiH/2il8AZpjrE3BpiNvyzB2pikg9DpwXJW824yL3RNGpvX
 NjRT1SHV+zsDLTRCCdVpvCJIBwJeDaQ+OVJ1X+bcMK2tL4N0JTgCL/w1IZyGgHm9DkIp
 kWRR4H6ic9PQI/6HDqXsZVgGMCwJlGYbHDBgvyTCpOWoWh0hxZtsBRq/QPyigfnMtItU
 Lr0X/YPinBTraXnBpmuJrLGxBWoiMpC5Hmv8IYqX1AoljHzUDf31BWvmX1ggrje6bf3V
 qAdQ==
X-Gm-Message-State: ABy/qLaH0mV+VmVVmu+EPtW4lpsW6cX/GRFD6xeSQoKz6/ZE6SADlybD
 44scEcw1oHbpIaG4fcZPtEUrPgCFFEPv2xYvpc3bUJpcV4bziz7fjL/QPi2BU/IUYi6kW6AyFkY
 RymKm46HoM+RXAl4=
X-Received: by 2002:a05:6512:3157:b0:4f8:7617:6445 with SMTP id
 s23-20020a056512315700b004f876176445mr11589743lfi.48.1689065241191; 
 Tue, 11 Jul 2023 01:47:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE8GVW/09hQ83VODeRdSkWd4WrcNuaTeg4xDUBbeSaKzT0lSMSTDoODT6XIrIj64kX8srqAQw==
X-Received: by 2002:a05:6512:3157:b0:4f8:7617:6445 with SMTP id
 s23-20020a056512315700b004f876176445mr11589724lfi.48.1689065240821; 
 Tue, 11 Jul 2023 01:47:20 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 v15-20020a1cf70f000000b003fa8158135esm12359147wmh.11.2023.07.11.01.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jul 2023 01:47:20 -0700 (PDT)
Date: Tue, 11 Jul 2023 04:47:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org,
 Gavin Shan <gshan@redhat.com>, Mario Casquero <mcasquer@redhat.com>
Subject: Re: [PATCH v3 3/7] arm/virt: Use virtio-md-pci (un)plug functions
Message-ID: <20230711044647-mutt-send-email-mst@kernel.org>
References: <20230710100714.228867-1-david@redhat.com>
 <20230710100714.228867-4-david@redhat.com>
 <20230710173933-mutt-send-email-mst@kernel.org>
 <b9351bf7-cabd-784c-bebc-a18a9b3f4bc1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9351bf7-cabd-784c-bebc-a18a9b3f4bc1@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, Jul 11, 2023 at 10:32:31AM +0200, David Hildenbrand wrote:
> On 10.07.23 23:40, Michael S. Tsirkin wrote:
> > > @@ -2855,12 +2796,11 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
> > >                                        SYS_BUS_DEVICE(dev));
> > >           }
> > >       }
> > > +
> > >       if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> > >           virt_memory_plug(hotplug_dev, dev, errp);
> > > -    }
> > > -
> > > -    if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MEM_PCI)) {
> > > -        virt_virtio_md_pci_plug(hotplug_dev, dev, errp);
> > > +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
> > > +        virtio_md_pci_plug(VIRTIO_MD_PCI(dev), MACHINE(hotplug_dev), errp);
> > >       }
> > >       if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> > 
> > 
> > How is this supposed to link if virtio-md is disabled at compile time?
> > 
> 
> Good point.
> 
> The old code unconditionally enabled MEM_DEVICE, so we never required subs
> for that.
> 
> We either need stubs or have to wrap this in #ifdef.
> 
> Stubs sound cleaner.

That is what we usually do, yes.

-- 
MST



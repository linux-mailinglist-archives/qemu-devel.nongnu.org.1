Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECB2777F6B
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 19:44:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU9hk-0007Ui-Hp; Thu, 10 Aug 2023 13:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qU9hh-0007E2-Ip
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:44:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qU9hf-0005BG-9i
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 13:44:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691689446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4opRmKHk32vkF98ZxEahBmO7AB2tpAtqx0ntq3I1l/w=;
 b=GtgDeGyKMGkr2SEz7lraRcxJY2fPeuh/L3IHRw8EuubUQYAAc8O5pU6tlfUaFCZZXg5YlX
 gDqDDnzoX7oZS3nKj5rtJXR1wqiZNZI4hivVdA5kZgEKyzwZ8ThjqV9+BZhOtT6Ymx5b0P
 BU0GH2cQtscOdYHsW6oj0AvfhfmUSYU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-VQWp2ek-MASSse11E4LApA-1; Thu, 10 Aug 2023 13:44:02 -0400
X-MC-Unique: VQWp2ek-MASSse11E4LApA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30e4943ca7fso658664f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 10:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691689441; x=1692294241;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4opRmKHk32vkF98ZxEahBmO7AB2tpAtqx0ntq3I1l/w=;
 b=YXZ4dVNWso0EUOieLewTaBzhaFCyfRIjsFJDhaLaKMphxsl4oAK/XzxPzaoe3SHd9U
 FMB86G3mRoP4QG3wL6EauHYS/mpCLcOyzMxt7GgMLDHf7e6XTxwP+0vkcQ+lbsYcqFfk
 amA5MsdQAGlLM9KY913nRw3QxlPK+kixm5M9SmK/TYebEmpHTUVwFtb5ayx2gbKvPGvL
 7U8n9MB7HQel2Qh9cChellmP78adZTwbeU/wC8/WenXCVZtTjt3fszC0LZttUSBuRfUF
 pXjAOTCkBvFZSB2t1qgYcoihF4fTx6WwcABVmupjPJPCDza3LMjlEJNdAFWGhNpGb3kh
 nE5A==
X-Gm-Message-State: AOJu0Yzdl4T2aaohKVQ5E7vZgeclWms/ynbUQsQXIWT5qUTpj4Kx7P7q
 HtNaAgELkTe2DfrcrnEpwhiweGuzIXTGUAncMZ/tYv7/MdVknk4YTHQjqCFQcmhhd6+9+WwPvVn
 D/yPsZv9y2ypFFuU=
X-Received: by 2002:a05:6000:1ca:b0:317:f70b:3156 with SMTP id
 t10-20020a05600001ca00b00317f70b3156mr2892795wrx.28.1691689441347; 
 Thu, 10 Aug 2023 10:44:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcjzQ0gJVpAYk+Uh2ymMLs/49ALvHbZV8xTwRbJE2DS4pO0UZv3gwsAwNZx9KtQ6u6dKFW4A==
X-Received: by 2002:a05:6000:1ca:b0:317:f70b:3156 with SMTP id
 t10-20020a05600001ca00b00317f70b3156mr2892780wrx.28.1691689440966; 
 Thu, 10 Aug 2023 10:44:00 -0700 (PDT)
Received: from redhat.com ([2.55.42.146]) by smtp.gmail.com with ESMTPSA id
 e13-20020a5d500d000000b00317ddccb0d1sm2808612wrt.24.2023.08.10.10.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 10:44:00 -0700 (PDT)
Date: Thu, 10 Aug 2023 13:43:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Chien <jason.chien@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Greg Kurz <groug@kaod.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH] hw/pci-host: Allow extended config space access for
 Designware PCIe host
Message-ID: <20230810134315-mutt-send-email-mst@kernel.org>
References: <20230809102257.25121-1-jason.chien@sifive.com>
 <20230809172413-mutt-send-email-mst@kernel.org>
 <CADr__8ohzCfEYkXz+6u06hDQZNM8q9Cp9eehtcBFhdKtnySPBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADr__8ohzCfEYkXz+6u06hDQZNM8q9Cp9eehtcBFhdKtnySPBA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 11, 2023 at 01:22:08AM +0800, Jason Chien wrote:
> As far as I know, the order issue is caused by nested device realization. In
> this case, realizing TYPE_DESIGNWARE_PCIE_HOST will also
> realize TYPE_DESIGNWARE_PCIE_ROOT(see designware_pcie_host_realize()).
> device_set_realized() is the function that realizing a device must go through,
> and this function first realizes the device by dc->realize() and then realizes
> the device's child bus by qbus_realize(). Whether there is any child bus of the
> device may depend on dc->realize(). The realization flow will be like a
> recursive call to device_set_realized(). More precisely, the flow in this case
> is: qdev_realize() --> ... --> FIRST device_set_realized() --> FIRST dc->
> realize() --> ... --> designware_pcie_host_realize() --> qdev_realize() --> ...
> --> SECOND device_set_realized() --> SECOND dc->realize() --> ... -->
>  designware_pcie_root_realize() --> ...--> back to the SECOND
> device_set_realized() --> SECOND qbus_realize() the CHILD bus "dw-pcie" --> ...
> --> back to the FIRST device_set_realized() --> FIRST qbus_realize() the PARENT
> bus "pcie".
> 
> I also found this patch that solves the same bus issue.

Which patch?

> Do you have any suggestions on the order of realization? Thanks!


I see. It's not easy to fix. Worth thinking about but I guess your
patch is ok for now.

> On Thu, Aug 10, 2023 at 5:24 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Wed, Aug 09, 2023 at 10:22:50AM +0000, Jason Chien wrote:
>     > In pcie_bus_realize(), a root bus is realized as a PCIe bus and a
>     non-root
>     > bus is realized as a PCIe bus if its parent bus is a PCIe bus. However,
>     > the child bus "dw-pcie" is realized before the parent bus "pcie" which is
>     > the root PCIe bus. Thus, the extended configuration space is not
>     accessible
>     > on "dw-pcie". The issue can be resolved by adding the
>     > PCI_BUS_EXTENDED_CONFIG_SPACE flag to "pcie" before "dw-pcie" is
>     realized.
>     >
>     > Signed-off-by: Jason Chien <jason.chien@sifive.com>
> 
>     I think we should fix the order of initialization rather than
>     hack around it.
> 
>     > ---
>     >  hw/pci-host/designware.c | 1 +
>     >  1 file changed, 1 insertion(+)
>     >
>     > diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
>     > index 9e183caa48..388d252ee2 100644
>     > --- a/hw/pci-host/designware.c
>     > +++ b/hw/pci-host/designware.c
>     > @@ -694,6 +694,7 @@ static void designware_pcie_host_realize(DeviceState
>     *dev, Error **errp)
>     >                                       &s->pci.io,
>     >                                       0, 4,
>     >                                       TYPE_PCIE_BUS);
>     > +    pci->bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
>     > 
>     >      memory_region_init(&s->pci.address_space_root,
>     >                         OBJECT(s),
>     > --
>     > 2.17.1
> 
> 



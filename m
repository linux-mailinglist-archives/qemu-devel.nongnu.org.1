Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A7A72C66C
	for <lists+qemu-devel@lfdr.de>; Mon, 12 Jun 2023 15:52:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8hxJ-00022C-0g; Mon, 12 Jun 2023 09:51:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q8hxH-00020U-E0
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q8hxF-0007x4-Si
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 09:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686577893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kKsNyRdaPXOi49/DYV89yMCnk97ouiTuCV4P/tGhP58=;
 b=WP3sMlFPj1GVO3hGZ2v11ohsmATM1iqenaB/ce6UqUI5lCT8FJZY9gO7yby10RzzBFyVgB
 qe/AKt8AbnOuYLxoKl7e1YbdvQX33xurAR0Yg7bKOMTxPMMcvr2fiZqO1o98kJKOrZRf+n
 FtzQULhTPt+PrJ9KRAfE3O+Siub8gtg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-DzLwjXd8Ni2_7HC2hwc4_w-1; Mon, 12 Jun 2023 09:51:28 -0400
X-MC-Unique: DzLwjXd8Ni2_7HC2hwc4_w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-95847b4b4e7so511954766b.3
 for <qemu-devel@nongnu.org>; Mon, 12 Jun 2023 06:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686577886; x=1689169886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kKsNyRdaPXOi49/DYV89yMCnk97ouiTuCV4P/tGhP58=;
 b=S9AwhWknznjVS1ClfLTxEpfHWTV9cxEFULuEqtuh2iszKRVn7ufyM4BITrqJYILFWb
 Xj0nTkzjxKPne8Ka/LNOzwrfIMl+TUVpV/K6qCsDW4IU0GT9vcjtLPGviSP4Kb1bW/Hw
 WOS3JmqPpveoee2PbcwXma6tefX/n+Fk8ygYcgwtZwD5qSi2boSe+KiGWkKE5H0sgvws
 vtHIK1JAcupdZNB+o54nptstlsiOw9PVf+9cOHN6z9b16Jprj1pCGTbKg2d6UmYENY9p
 n98NrRd5I3cRIajI5se0NZpRTVIdJUJUZl+85snqNyZ5tiG6zIhWrf+xmhrgJL3oNJqN
 Q1PA==
X-Gm-Message-State: AC+VfDzHf56OAvKvF+a+IIHdOc0XF2CMchVoxMytMDcLokUCnb3uc84h
 l2PQDMxPCYWNdYq3GuOfZYhT429FSzgKY43Ez84y2Z2sSn1HFR6jApw2zRDsE2lQ9vkh6WVB/ZY
 J2OY3S/XBrB2Oc+s60ZZrpjM=
X-Received: by 2002:a17:907:a427:b0:94a:9f9a:b3c4 with SMTP id
 sg39-20020a170907a42700b0094a9f9ab3c4mr10983346ejc.49.1686577886028; 
 Mon, 12 Jun 2023 06:51:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4mTHUqKNUkzDCoOB4i/gc4Yp89Z/vYmpc43/bCu0vslYkEsXwC7W3QqQHJTTFgMIxewY4AyQ==
X-Received: by 2002:a17:907:a427:b0:94a:9f9a:b3c4 with SMTP id
 sg39-20020a170907a42700b0094a9f9ab3c4mr10983334ejc.49.1686577885795; 
 Mon, 12 Jun 2023 06:51:25 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 um14-20020a170906cf8e00b00977d14d89fesm5219969ejb.34.2023.06.12.06.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Jun 2023 06:51:25 -0700 (PDT)
Date: Mon, 12 Jun 2023 15:51:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 05/15] hw/pci-host/q35: Initialize PCI_HOST_BYPASS_IOMMU
 property from board code
Message-ID: <20230612155124.346595a2@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230611103412.12109-6-shentey@gmail.com>
References: <20230611103412.12109-1-shentey@gmail.com>
 <20230611103412.12109-6-shentey@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, 11 Jun 2023 12:34:02 +0200
Bernhard Beschow <shentey@gmail.com> wrote:

> The Q35 PCI host already has a PCI_HOST_BYPASS_IOMMU property. However, the
> host initializes this property itself by accessing global machine state,
> thereby assuming it to be a PC machine. Avoid this by having board code
> set this property.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/i386/pc_q35.c  | 2 ++
>  hw/pci-host/q35.c | 3 +--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index 29b46d3e1c..5220b535b2 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -230,6 +230,8 @@ static void pc_q35_init(MachineState *machine)
>                              x86ms->below_4g_mem_size, NULL);
>      object_property_set_int(phb, PCI_HOST_ABOVE_4G_MEM_SIZE,
>                              x86ms->above_4g_mem_size, NULL);
> +    object_property_set_bool(phb, PCI_HOST_BYPASS_IOMMU,
> +                             pcms->default_bus_bypass_iommu, NULL);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(phb), &error_fatal);
>  
>      /* pci */
> diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
> index 23b689dba3..7980ddde69 100644
> --- a/hw/pci-host/q35.c
> +++ b/hw/pci-host/q35.c
> @@ -66,8 +66,7 @@ static void q35_host_realize(DeviceState *dev, Error **errp)
>                                  s->mch.pci_address_space,
>                                  s->mch.address_space_io,
>                                  0, TYPE_PCIE_BUS);
> -    pci->bypass_iommu =
> -        PC_MACHINE(qdev_get_machine())->default_bus_bypass_iommu;
> +
>      qdev_realize(DEVICE(&s->mch), BUS(pci->bus), &error_fatal);
>  }
>  



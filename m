Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDBA742AFF
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 19:03:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEv25-0004nA-84; Thu, 29 Jun 2023 13:02:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEv1u-0004lh-MJ
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 13:02:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEv1s-0005TN-Rl
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 13:02:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688058119;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C+3xRKS8CjELBG1aFSop6p/7715kxVctvTPZ+W8JSJY=;
 b=S0zciEsSvT29YC0S+N6GEf/KcypEAk6fKkVdd2tl5osoDYJn50GH766bYhRNuPCC/2P9Q2
 cqVfKybNz9I2m+UNOKMPebErX/NQwm3af91Md97E5RA90CsPalAuVklO5OrCEvYrkaK47X
 zg+s/t5R1t4awUsjLqltdXRp8aDt06k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-KmQ8sY1VOpKLE_1GcV15MQ-1; Thu, 29 Jun 2023 13:01:58 -0400
X-MC-Unique: KmQ8sY1VOpKLE_1GcV15MQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7673887b2cfso16871285a.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 10:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688058117; x=1690650117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C+3xRKS8CjELBG1aFSop6p/7715kxVctvTPZ+W8JSJY=;
 b=GrB+9eHEnzLn20brnX+Aqd6mUM/6RHKNtE4Y2PUrNc9yYRqtx5sQVFfWzH5JB5h3Pg
 nCBFeqsjGH0mi80Aw3QsV22gXpOzt7Jo+3X2JP1NLLLwqYGIEwZx9/gjgba1mfrYwgiK
 //rve+awJdRKEsVEXvvhUUFYULOqYDCFGUAg985G691ICO8io7jvnJG/IlTiv1p+efhU
 AlpmTVSdQ3nanNNe4sZjxtLyGVhoPehLFuDAQ4Urbzv7vrIFaH/5NPcomhelCIVtaGGm
 RaT2zjiN2wanqAQZ43ZflXJcJhvsM+bV6u0otN/9lPGTIoBNAdT0q+R6wApcQ8zaKM1U
 BbbQ==
X-Gm-Message-State: AC+VfDz11UiGd5FWFvO7h2+JnYjimi2nyCXrROfXTtTSswgccQsMEnnN
 6Hnc/EA6a3/0xxOc60DgXpecON37TusvodHLxusRIpzFCLXCth0bgxo6QZ0UiOfwZ1VmT6a6T/s
 DHb+cXecF2tHrbnw=
X-Received: by 2002:a05:620a:44d4:b0:766:f972:73da with SMTP id
 y20-20020a05620a44d400b00766f97273damr14854371qkp.1.1688058117466; 
 Thu, 29 Jun 2023 10:01:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4laFr2VULrmmrfH3qcIQxhAj2KmisjBxBV6TjdHmVk2jTrDHgV00YT6W9+u0KrGiDEd/hOIA==
X-Received: by 2002:a05:620a:44d4:b0:766:f972:73da with SMTP id
 y20-20020a05620a44d400b00766f97273damr14854339qkp.1.1688058117079; 
 Thu, 29 Jun 2023 10:01:57 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 pe34-20020a05620a852200b00765a71e399bsm4803926qkn.55.2023.06.29.10.01.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jun 2023 10:01:56 -0700 (PDT)
Date: Thu, 29 Jun 2023 13:01:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/1] pcie: Add hotplug detect state register to w1cmask
Message-ID: <ZJ25AdfN7AqYkB6z@x1n>
References: <20230629090500.438976-2-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230629090500.438976-2-leobras@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Hi, Leo,

Thanks for figuring this out.  Let me copy a few more potential reviewers
from commit 17858a1695 ("hw/acpi/ich9: Set ACPI PCI hot-plug as default on
Q35").

On Thu, Jun 29, 2023 at 06:05:00AM -0300, Leonardo Bras wrote:
> When trying to migrate a machine type pc-q35-6.0 or lower, with this
> cmdline options:
> 
> -device driver=pcie-root-port,port=18,chassis=19,id=pcie-root-port18,bus=pcie.0,addr=0x12 \
> -device driver=nec-usb-xhci,p2=4,p3=4,id=nex-usb-xhci0,bus=pcie-root-port18,addr=0x12.0x1
> 
> the following bug happens after all ram pages were sent:
> 
> qemu-kvm: get_pci_config_device: Bad config data: i=0x6e read: 0 device: 40 cmask: ff wmask: 0 w1cmask:19
> qemu-kvm: Failed to load PCIDevice:config
> qemu-kvm: Failed to load pcie-root-port:parent_obj.parent_obj.parent_obj
> qemu-kvm: error while loading state for instance 0x0 of device '0000:00:12.0/pcie-root-port'
> qemu-kvm: load of migration failed: Invalid argument
> 
> This happens on pc-q35-6.0 or lower because of:
> { "ICH9-LPC", ACPI_PM_PROP_ACPI_PCIHP_BRIDGE, "off" }
> 
> In this scenario, hotplug_handler_plug() calls pcie_cap_slot_plug_cb(),
> which sets the bus dev->config byte 0x6e with bit PCI_EXP_SLTSTA_PDS to 
> signal PCI hotplug for the guest. After a while the guest will deal with
> this hotplug and qemu will clear the above bit.
> 
> Then, during migration, get_pci_config_device() will compare the
> configs of both the freshly created device and the one that is being
> received via migration, which will differ due to the PCI_EXP_SLTSTA_PDS bit
> and cause the bug to reproduce.
> 
> To avoid this fake incompatibility, there are two fields in PCIDevice that
> can help:
> 
> .wmask: Used to implement R/W bytes, and
> .w1cmask: Used to implement RW1C(Write 1 to Clear) bytes

Is there one more option to clear the bit in cmask?

IIUC w1cmask means the guest can now write to this bit, but afaiu from the
pcie spec it's RO.

> 
> According to pcie_cap_slot_init() the slot status register
> (PCI_EXP_SLTSTA), in which PCI_EXP_SLTSTA_PDS is a flag, seems to fall
> under w1cmask field, with makes sense due to the way signaling the hotplug
> works.
> 
> So, add PCI_EXP_SLTSTA_PDS bit to w1cmask, so the fake incompatibility on
> get_pci_config_device() does not abort the migration.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2215819
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

Do we need a Fixes: and also the need to copy stable?

> ---
>  hw/pci/pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index b8c24cf45f..2def1765a5 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -657,7 +657,7 @@ void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
>                                 PCI_EXP_SLTCTL_EIC);
>  
>      pci_word_test_and_set_mask(dev->w1cmask + pos + PCI_EXP_SLTSTA,
> -                               PCI_EXP_HP_EV_SUPPORTED);
> +                               PCI_EXP_HP_EV_SUPPORTED | PCI_EXP_SLTSTA_PDS);
>  
>      dev->exp.hpev_notified = false;
>  
> -- 
> 2.41.0
> 

-- 
Peter Xu



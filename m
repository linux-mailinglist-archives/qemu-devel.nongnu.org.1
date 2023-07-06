Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BEB749F25
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 16:37:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHQ5P-0001Nt-Vx; Thu, 06 Jul 2023 10:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHQ5N-0001NV-MJ
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHQ5L-0001LI-Oo
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 10:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688654154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rY/LIV/BgluVXP/7gZfxyNlWZWfLyLLNwZGT7a7v/DI=;
 b=AFy+SpvLc/nOcMkNIp7yX2Vr7lnDM9i8ebW/Y52I5OhBlH1RsuY+FfG9t9wyGzLjXaaxcg
 uIDbeUr0dA7XMPypffxq8OOZKYk1AdneJcQhUKor9000MUj1nxXUOmeSnZ6JmKM/Q+BHtN
 mCGz0gPeJofwI0Cmek78iy65TvdKu3k=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-xliHUp7tMcqKyDThWk3RMw-1; Thu, 06 Jul 2023 10:35:53 -0400
X-MC-Unique: xliHUp7tMcqKyDThWk3RMw-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3a38095b2e6so151776b6e.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 07:35:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688654152; x=1691246152;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rY/LIV/BgluVXP/7gZfxyNlWZWfLyLLNwZGT7a7v/DI=;
 b=QRo1mvtDYAtncZyejDaLe/4G02lCy9gl6LfIxsJxEwgACeEhZ6GZpmK/lUd4cItya6
 wvzHQUDDlG60Oz/MdhcNjbpbPy0bV3Hq9ZLY1QVHQNC6g2ocJ7ZBSNKScXpRDh7L/PnQ
 zJd5oQhL1Aah/NTX5va62teNJrehae5GPUBz55iAAm0ec1LgZjzinhCBEok5MMRtpHYe
 9eRxs1cg6fVtq1msSD1dhUUw2dm7lmKsOKBthV+nkA8l6GyLRFkCAoY1OqQVWHsf3KWT
 i3/79JjXSGq3jSeAOTI1GMuqzhTVzcYrAsmYPAR7TWyg14WQzfzWoTYauEPd9S4iF7S/
 pUaA==
X-Gm-Message-State: ABy/qLYFD1ECHaxgER9+znggKsk3BXRxs7A6Dbo54JNOqIE74VRUgDS1
 lNtCFkKeMB1AsOsJU+UQujo9xtM+TZqkH2iO94kr/1lrbnwWVWQUJUtGLKX5elEQiS7aufuaGRk
 qaP7ZekbhKU7jYag=
X-Received: by 2002:a05:6358:9faf:b0:134:c37f:4b5b with SMTP id
 fy47-20020a0563589faf00b00134c37f4b5bmr1127390rwb.1.1688654152339; 
 Thu, 06 Jul 2023 07:35:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHowl32hhdb3ajH+f1xbORWY/t5R5Nkad11/bmhxlJAF/W0kATcEfHBahe1cdHyo9p4xjUC2g==
X-Received: by 2002:a05:6358:9faf:b0:134:c37f:4b5b with SMTP id
 fy47-20020a0563589faf00b00134c37f4b5bmr1127370rwb.1.1688654151954; 
 Thu, 06 Jul 2023 07:35:51 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 j20-20020ae9c214000000b007620b03ee65sm813449qkg.37.2023.07.06.07.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 07:35:51 -0700 (PDT)
Date: Thu, 6 Jul 2023 10:35:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] pcie: Add hotplug detect state register to cmask
Message-ID: <ZKbRRt8ESGsMz+o7@x1n>
References: <20230706045546.593605-3-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706045546.593605-3-leobras@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Jul 06, 2023 at 01:55:47AM -0300, Leonardo Bras wrote:
> When trying to migrate a machine type pc-q35-6.0 or lower, with this
> cmdline options,
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
> which sets dev->config byte 0x6e with bit PCI_EXP_SLTSTA_PDS to signal PCI
> hotplug for the guest. After a while the guest will deal with this hotplug
> and qemu will clear the above bit.

Do you mean that the bit will be cleared after this point for the whole
lifecycle of the VM, as long as the pcie topology doesn't change again?

"This bit indicates the presence of an adapter in the slot"

IIUC the adapter in the slot is there, why it's cleared rather than set?

> 
> Then, during migration, get_pci_config_device() will compare the
> configs of both the freshly created device and the one that is being
> received via migration, which will differ due to the PCI_EXP_SLTSTA_PDS bit
> and cause the bug to reproduce.
> 
> To avoid this fake incompatibility, there are tree fields in PCIDevice that
> can help:
> 
> - wmask: Used to implement R/W bytes, and
> - w1cmask: Used to implement RW1C(Write 1 to Clear) bytes
> - cmask: Used to enable config checks on load.
> 
> According to PCI Express® Base Specification Revision 5.0 Version 1.0,
> table 7-27 (Slot Status Register) bit 6, the "Presence Detect State" is
> listed as RO (read-only), so it only makes sense to make use of the cmask
> field.
> 
> So, clear PCI_EXP_SLTSTA_PDS bit on cmask, so the fake incompatibility on
> get_pci_config_device() does not abort the migration.

Yes, using cmask makes more sense to me, but we'd need some pci developer
to ack it at last I guess, anyway.

> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2215819
> Signed-off-by: Leonardo Bras <leobras@redhat.com>

I asked the same question, and I still keep confused: whether there's a
first bad commit?  Starting from when it fails?

For example, is this broken on 6.0 binaries too with pc-q35-6.0?

Thanks,

> ---
>  hw/pci/pcie.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index b8c24cf45f..cae56bf1c8 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -659,6 +659,10 @@ void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
>      pci_word_test_and_set_mask(dev->w1cmask + pos + PCI_EXP_SLTSTA,
>                                 PCI_EXP_HP_EV_SUPPORTED);
>  
> +    /* Avoid migration abortion when this device hot-removed by guest */
> +    pci_word_test_and_clear_mask(dev->cmask + pos + PCI_EXP_SLTSTA,
> +                                 PCI_EXP_SLTSTA_PDS);
> +
>      dev->exp.hpev_notified = false;
>  
>      qbus_set_hotplug_handler(BUS(pci_bridge_get_sec_bus(PCI_BRIDGE(dev))),
> -- 
> 2.41.0
> 

-- 
Peter Xu



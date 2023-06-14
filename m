Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 903A572FF5F
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 15:03:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Q8u-0003pD-Cb; Wed, 14 Jun 2023 09:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q9Q8f-0003VZ-4i
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 09:02:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q9Q8c-0007Us-Uf
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 09:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686747733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5BpbPmrLkqLl9TpPjXO6LDaJUhtIz6K39RC+SAY/v4=;
 b=SgBUZVQGPcQFq0onRnUCnzdZaVNKN1k0qx5DrtE1j7CzA2a9ylAmb7gCNf3cSI9PGH5Daq
 EJFTnansDZ1Iiqmr9Ju8SVl2y4ZMNLxZcOqwcHc5iLF2r4Ujpjx+ntrqfVfEt7BO1n6oFH
 A9E4SlOoOG0RmD7Gfdsy2nuZzgtjSBM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-h-CSJ7lAMomQ-lkUk43UBg-1; Wed, 14 Jun 2023 09:02:00 -0400
X-MC-Unique: h-CSJ7lAMomQ-lkUk43UBg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-977c516686aso89766666b.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 06:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686747719; x=1689339719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y5BpbPmrLkqLl9TpPjXO6LDaJUhtIz6K39RC+SAY/v4=;
 b=OvqnAV5I1JLUi4inq7s5OAMmAm91rwz4B6kovSgugAgIQVc/gPVmPWBwMbAZJftjKj
 fzdnW8pSdbTBHDp8aWBSuAXCJuWFlfvGUZZ8e6mySvaA1NQG4H4GdbhLCBNW4ovXPKLB
 KjLSKovrrnZCNabWcpF96OCbj/L2kqlYaugxE/LffhRQBpF/ZW6AGH/uYQ6Bz+AB1k2K
 HZ76TAsMqHRiYr97tEFQ88mqtPe37uvgZGUhWjYkvlZbm+BSpCBqU3KOmuk7w47xJszS
 nm4TsdBKMf0HwRndixFPR8aY+GybBUsnRiOgs2liTo5fkK4H5VQLMbr5RhOQa8En/eZV
 WK9g==
X-Gm-Message-State: AC+VfDyWGsm1gj3HJBWMm7r6TuB+lGp2yM1Xcy2MbIq2yo6R3qj6V8uQ
 QCZC8gxZpp/MyUwSHAk5ClntlD69P+z8Ra/nA/u1JHwfVt0atYoLl+UmYMgzPiA/XoPQeNxtIot
 8lLx8OjlvyuGKCFs=
X-Received: by 2002:a17:907:360c:b0:96a:48ed:531d with SMTP id
 bk12-20020a170907360c00b0096a48ed531dmr17137675ejc.27.1686747719375; 
 Wed, 14 Jun 2023 06:01:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5RykGKSSopPepQnpxA//4z1P0Bc7NbadL47nLV/jL2W8NrXg9IWMKbrncBCFO6QVImczJIkQ==
X-Received: by 2002:a17:907:360c:b0:96a:48ed:531d with SMTP id
 bk12-20020a170907360c00b0096a48ed531dmr17137656ejc.27.1686747719005; 
 Wed, 14 Jun 2023 06:01:59 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 gu4-20020a170906f28400b0096fbc516a93sm7981119ejb.211.2023.06.14.06.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 06:01:57 -0700 (PDT)
Date: Wed, 14 Jun 2023 15:01:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, jusual@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/pci: prevent hotplug of devices on pcie-root-ports
 with wrong devfn address
Message-ID: <20230614150157.03952658@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230614123150.7077-1-anisinha@redhat.com>
References: <20230614123150.7077-1-anisinha@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 14 Jun 2023 18:01:50 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> PCIE root ports only allow one device on slot 0/function 0. When hotplugging a
> device on a pcie root port, make sure that the device address passed is
> always 0x00 that represents slot 0 and function 0. Any other slot value and
> function value would be illegal on a root port.
> 
> CC: jusual@redhat.com
> CC: imammedo@redhat.com
> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  hw/pci/pci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> Note:
> I tested this with both native and acpi hotplug enabled on pcie. The
> check seems to work on both.
> 
> (qemu)  netdev_add socket,id=hostnet1,listen=:1234
> (qemu) device_add e1000e,netdev=hostnet1,mac=00:11:22:33:44:03,id=net1,bus=pci.6,addr=0x2.0x5
> Error: PCI: slot 2 function 5 is not valid for e1000e
> (qemu) device_add e1000e,netdev=hostnet1,mac=00:11:22:33:44:03,id=net1,bus=pci.6,addr=0x0.0
> (qemu) info network
> net1: index=0,type=nic,model=e1000e,macaddr=00:11:22:33:44:03
>  \ hostnet1: index=0,type=socket,
> (qemu) device_del net1
> (qemu) info network
> hostnet1: index=0,type=socket,
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index bf38905b7d..bc39322dfd 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -64,6 +64,7 @@ bool pci_available = true;
>  static char *pcibus_get_dev_path(DeviceState *dev);
>  static char *pcibus_get_fw_dev_path(DeviceState *dev);
>  static void pcibus_reset(BusState *qbus);
> +static bool pcie_has_upstream_port(PCIDevice *dev);
>  
>  static Property pci_props[] = {
>      DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> @@ -1189,6 +1190,14 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
>                     name);
>  
>         return NULL;
> +    } else if (dev->hotplugged &&

> +               !pci_is_vf(pci_dev) &&
> +               pcie_has_upstream_port(pci_dev) 
can you clarify what above 2 lines are here for?

you can't hotplug anything into upstream port (only downstream)
and why _vf() is here also not clear.
 
> && devfn) {
> +        /* For an upstream PCIE port, we only support one device at slot 0 */
> +        error_setg(errp, "PCI: slot %d function %d is not valid for %s",
> +                   PCI_SLOT(devfn), PCI_FUNC(devfn), name);
> +        return NULL;
> +
>      }
>  
>      pci_dev->devfn = devfn;



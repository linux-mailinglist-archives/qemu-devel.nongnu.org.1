Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D1730977
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 22:54:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9XVD-0005sM-Lq; Wed, 14 Jun 2023 16:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q9XVB-0005ms-Da
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 16:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q9XV9-0000Ev-J2
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 16:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686776038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6EelWry+eQQzrriI0k+y6gbidr5FV7E/KMzLshMS8Ys=;
 b=bbcE94j5VAtEbUoLDfzjBdaf9WYjj/XAWeoL60rynoMh0DSaMwNBGgPgRckI933GDThNsA
 nlKjI5R6Mqs2Du4xUJbyzUVqc3ZQ21eAThPQ3d0sXV9hQiYnFAExWTi2RXbKd/S86TUUTl
 60l8OHOrGaefojpsNGd611VLzfTNhf0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669--vnmrTXmMLWlaiafjTGmpA-1; Wed, 14 Jun 2023 16:53:57 -0400
X-MC-Unique: -vnmrTXmMLWlaiafjTGmpA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-970e0152da7so119263166b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 13:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686776036; x=1689368036;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6EelWry+eQQzrriI0k+y6gbidr5FV7E/KMzLshMS8Ys=;
 b=cy6i3kW1/2sX96+jZp2HpUdGSJ2E5dRGN7uegBmReHSuMPOt+OjqbmpQ/nzolI4yqf
 mhEA2mob7hc9PWbI0UwRqgWbFlWEDsxC297bm7JJjFM9TWX1qtrjCmPQ5Ohh+BIOK4Zz
 aRVWt+x7Ccm5mYFtg2FFycQt99IG1/mevXqvsq25+9dgw6ft8uYhKFsvKQMZXuLOY5dl
 ZF9D7kPJA4PGj3Yp5IleRlX84jKVPJ42tT48G8K/ebljAkHzJ7E/x5k7hghl2YNQRQdl
 OUbzi+OxVVSAfp3Af5LXdDsxn3be5c2FvREQ0qP1mV2sxHLUUY83SR00ygkgCq+BjVf6
 Jmxw==
X-Gm-Message-State: AC+VfDyZhE883CmaGu6bp/xNSmJgoNgOBtcKehDzcMFSnBiOeFuCxqFt
 YYtdajry+srNUeQD6aNM98JkuxUu/J0OKQgZsDpS1L1vrPpCgp3KwxNLGizC7tdugnCX/Zk69Wh
 RxCUkyBT5bmwlssk=
X-Received: by 2002:a17:907:7da9:b0:973:93d6:189f with SMTP id
 oz41-20020a1709077da900b0097393d6189fmr19850941ejc.61.1686776035988; 
 Wed, 14 Jun 2023 13:53:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ZO3aJfjTOfzfWn0/FXjezeDZ600p8/qQkHuxn8+DGv38hUx3FYUAljzPoi6BDWf3L2uaWbQ==
X-Received: by 2002:a17:907:7da9:b0:973:93d6:189f with SMTP id
 oz41-20020a1709077da900b0097393d6189fmr19850928ejc.61.1686776035704; 
 Wed, 14 Jun 2023 13:53:55 -0700 (PDT)
Received: from redhat.com (server.hotelpassage.eu. [88.146.207.194])
 by smtp.gmail.com with ESMTPSA id
 u13-20020a1709064acd00b009787ad3157bsm8529518ejt.39.2023.06.14.13.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 13:53:55 -0700 (PDT)
Date: Wed, 14 Jun 2023 16:53:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com,
 imammedo@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/pci: prevent hotplug of devices on pcie-root-ports
 with wrong devfn address
Message-ID: <20230614165253-mutt-send-email-mst@kernel.org>
References: <20230614123150.7077-1-anisinha@redhat.com>
 <20230614102137-mutt-send-email-mst@kernel.org>
 <BDD79A0E-C9D4-4E4B-AFFA-41716326B141@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BDD79A0E-C9D4-4E4B-AFFA-41716326B141@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Wed, Jun 14, 2023 at 10:09:35PM +0530, Ani Sinha wrote:
> 
> 
> > On 14-Jun-2023, at 7:52 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Wed, Jun 14, 2023 at 06:01:50PM +0530, Ani Sinha wrote:
> >> PCIE root ports only allow one device on slot 0/function 0.
> > 
> > 
> > Why do you say this? PCI devices can be multifunction.
> 
> Yeah you are right, the language needs correction. For hot plugging, I believe only function 0 is relevant. At least that is what it looks like from the code.

Adding function 0 is what makes it visible to guest.
But you can't block multifunction devices that would be a regression.


> > 
> >> When hotplugging a
> >> device on a pcie root port, make sure that the device address passed is
> >> always 0x00 that represents slot 0 and function 0. Any other slot value and
> >> function value would be illegal on a root port.
> >> 
> >> CC: jusual@redhat.com
> >> CC: imammedo@redhat.com
> >> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >> ---
> >> hw/pci/pci.c | 9 +++++++++
> >> 1 file changed, 9 insertions(+)
> >> 
> >> Note:
> >> I tested this with both native and acpi hotplug enabled on pcie. The
> >> check seems to work on both.
> >> 
> >> (qemu)  netdev_add socket,id=hostnet1,listen=:1234
> >> (qemu) device_add e1000e,netdev=hostnet1,mac=00:11:22:33:44:03,id=net1,bus=pci.6,addr=0x2.0x5
> >> Error: PCI: slot 2 function 5 is not valid for e1000e
> >> (qemu) device_add e1000e,netdev=hostnet1,mac=00:11:22:33:44:03,id=net1,bus=pci.6,addr=0x0.0
> >> (qemu) info network
> >> net1: index=0,type=nic,model=e1000e,macaddr=00:11:22:33:44:03
> >> \ hostnet1: index=0,type=socket,
> >> (qemu) device_del net1
> >> (qemu) info network
> >> hostnet1: index=0,type=socket,
> >> 
> >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >> index bf38905b7d..bc39322dfd 100644
> >> --- a/hw/pci/pci.c
> >> +++ b/hw/pci/pci.c
> >> @@ -64,6 +64,7 @@ bool pci_available = true;
> >> static char *pcibus_get_dev_path(DeviceState *dev);
> >> static char *pcibus_get_fw_dev_path(DeviceState *dev);
> >> static void pcibus_reset(BusState *qbus);
> >> +static bool pcie_has_upstream_port(PCIDevice *dev);
> >> 
> >> static Property pci_props[] = {
> >>     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> >> @@ -1189,6 +1190,14 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> >>                    name);
> >> 
> >>        return NULL;
> >> +    } else if (dev->hotplugged &&
> >> +               !pci_is_vf(pci_dev) &&
> >> +               pcie_has_upstream_port(pci_dev) && devfn) {
> >> +        /* For an upstream PCIE port, we only support one device at slot 0 */
> >> +        error_setg(errp, "PCI: slot %d function %d is not valid for %s",
> >> +                   PCI_SLOT(devfn), PCI_FUNC(devfn), name);
> >> +        return NULL;
> >> +
> >>     }
> >> 
> >>     pci_dev->devfn = devfn;
> >> -- 
> >> 2.39.1
> > 



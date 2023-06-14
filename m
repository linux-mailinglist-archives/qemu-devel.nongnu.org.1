Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36ED4730976
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 22:54:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9XTz-0004r1-Fu; Wed, 14 Jun 2023 16:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q9XTy-0004qq-1P
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 16:52:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q9XTw-0008JD-BY
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 16:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686775963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tF3RLZHixKww+mTQkgi80GTSg4eHHprTh0LjBzCYjf8=;
 b=VPWIZi/juSYEJ3NVnHvezTSnPz5EBdcBm98tDxz+LQPbLP4YWFz87DyjgJk48z7HdIdWhK
 ywIzQxIMgTezRJpuIL0xiNaZ6DmJ/IpaJuKq3XZmTEFFPWjET24L29pjhgWyMXujcgS4V/
 VrYoG2M0fp/j+pKchSMYLnK6myk43xw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-GgBLIB5-N3CBPndUu7LlEw-1; Wed, 14 Jun 2023 16:52:42 -0400
X-MC-Unique: GgBLIB5-N3CBPndUu7LlEw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-98277fac2a1so78503466b.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 13:52:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686775961; x=1689367961;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tF3RLZHixKww+mTQkgi80GTSg4eHHprTh0LjBzCYjf8=;
 b=OO5yXhujeTrV9p/5wJVLfLny7XFGffcUaK90L72DHTgZXQRi8R0zlWrvILhaksFFfx
 TgCmUZt9YCDFit1d+6eWqq45U/X+ne9cgw2iiP/oEj800uYGtWYqeyOenjnbJQ8EqPr1
 EHXBpTdWrB7K83rJOSto4crpehfyrfkr5/PnETBVuM7SWpZj48nM65Pacqc1aGs1Ve9S
 Oji/CS4N6n/NmjGClpAKDnbXezyfykUYakTkip8xwq2y1pGhd7nfQuxOLSkS5wIaLenF
 zIeJNOvKpap31FNaV5rNFxObq6ovjvJsTOFJCDTEbiW5guJTSDyV/Chfm8nhGYBAP/Jq
 nZDQ==
X-Gm-Message-State: AC+VfDxwZtTPH3yEqKvYE7kPeOsjoIZ1kKIPodpfCXk79hsggqfalb9I
 kN33AcJ/eGHDRpK8+7IirQ3BfxUlAC/lLfkPVwAvfem2/MSn044AGkEkd77qGA3tVrMmqSD/E38
 klaDhuv7acR4gpMQ=
X-Received: by 2002:a50:ec97:0:b0:518:7099:3e5f with SMTP id
 e23-20020a50ec97000000b0051870993e5fmr5906838edr.4.1686775960936; 
 Wed, 14 Jun 2023 13:52:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ji/DgxV2WJ/m7ivvInU7GcWgoJZn3VhKZ9h6HhW52qOivdq0B4hACcBNAuwZaliKbnhXikQ==
X-Received: by 2002:a50:ec97:0:b0:518:7099:3e5f with SMTP id
 e23-20020a50ec97000000b0051870993e5fmr5906827edr.4.1686775960634; 
 Wed, 14 Jun 2023 13:52:40 -0700 (PDT)
Received: from redhat.com (server.hotelpassage.eu. [88.146.207.194])
 by smtp.gmail.com with ESMTPSA id
 g16-20020aa7d1d0000000b0050bc4600d38sm8115449edp.79.2023.06.14.13.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 13:52:40 -0700 (PDT)
Date: Wed, 14 Jun 2023 16:52:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/pci: prevent hotplug of devices on pcie-root-ports
 with wrong devfn address
Message-ID: <20230614165051-mutt-send-email-mst@kernel.org>
References: <20230614123150.7077-1-anisinha@redhat.com>
 <20230614150157.03952658@imammedo.users.ipa.redhat.com>
 <E6BFF3BE-42D8-4651-99B1-D4BF6C1D17B1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E6BFF3BE-42D8-4651-99B1-D4BF6C1D17B1@redhat.com>
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

On Wed, Jun 14, 2023 at 10:31:40PM +0530, Ani Sinha wrote:
> 
> 
> > On 14-Jun-2023, at 6:31 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > On Wed, 14 Jun 2023 18:01:50 +0530
> > Ani Sinha <anisinha@redhat.com> wrote:
> > 
> >> PCIE root ports only allow one device on slot 0/function 0. When hotplugging a
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
> > 
> >> +               !pci_is_vf(pci_dev) &&
> >> +               pcie_has_upstream_port(pci_dev) 
> > can you clarify what above 2 lines are here for?
> > 
> > you can't hotplug anything into upstream port (only downstream)
> 
> This code checks if the hot plugged device is being plugged into a pcie root port. For pcie root ports, only slot 0 can be used. Please see 3f1e1478db2d67098d9 . The conditional check just above this hunk therefore checks for unoccupied function 0 in slot 0 if the device is plugged into an upstream pcie root port. I think for hot plugs, only function 0 is allowed.

Not really. The way we hotplug a multifunction device is by first
populating all functions != 0, then finally pupulating function 0
which is when the event triggers.

> 
> As for vf, I am not sure. I believe for vfs the restriction is not valid. I just kept the check based on the conditional just prior to it.
> 
> > and why _vf() is here also not clear.
> > 
> >> && devfn) {
> >> +        /* For an upstream PCIE port, we only support one device at slot 0 */
> >> +        error_setg(errp, "PCI: slot %d function %d is not valid for %s",
> >> +                   PCI_SLOT(devfn), PCI_FUNC(devfn), name);
> >> +        return NULL;
> >> +
> >>     }
> >> 
> >>     pci_dev->devfn = devfn;



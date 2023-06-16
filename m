Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4E47329E5
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 10:33:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA4st-0002bg-20; Fri, 16 Jun 2023 04:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qA4sp-0002bE-9L
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 04:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qA4sn-0000JZ-Br
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 04:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686904356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XF0M1+ZDdaVDq+SOm9Zj3jaoDeDZABLdummikl+eH+0=;
 b=MozvyMHomdvEdhyr1RvpcOlhYt86BKmPNq6tiwvqPZRsyiQPK9meLD42S0VkQUBxwmap4D
 ohCFtKXPba5eXqlF6FraHuPRAzgYn2kqDf5LLkASFyuU/eMlwatBgeegIm7H7F5VkeIdIN
 y16TAY/pAVNx++6C6OCOMHHiJEXCZNQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-O18zt0A5NbCL3iLnYyxdqg-1; Fri, 16 Jun 2023 04:32:30 -0400
X-MC-Unique: O18zt0A5NbCL3iLnYyxdqg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-311143796afso171124f8f.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jun 2023 01:32:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686904349; x=1689496349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XF0M1+ZDdaVDq+SOm9Zj3jaoDeDZABLdummikl+eH+0=;
 b=MLq1H1ewtKDdyrQ10Bk526Ax6m4M0fIeJQ2Pkiyx/R8iOhAWidOmxSe4bEJC4JKTLT
 MeGnGiPhdHzdrjcblq+CzHFmO2lHyXORYt6rsP2dMOOJzceSEZIeccl95wNNwsWxbh4A
 J8xQG8Vle/EJw99WPgvxKlkFFK3Wf6WUyfIIAWXWKqNcfpX43rqj2KCwgrUcCTuqQm0O
 dCQLp8joECpBnjtk1CBQPZuZnu2ImBZvMzt0RraoautSsVdFmBqV9lAaTL0DPq0L3D7u
 jN8gGGzJSfu/yUwf8mmzj4ObMjAFuugzSIgN+N8iN3DhsDpzl4O6pY4XRriLT1mPsbnq
 n0ig==
X-Gm-Message-State: AC+VfDxziJna9XxNi0YaOZP84VZjYc8x6gMjjqRBlAK/1OaTKLTF+o0v
 yozqXhohKw15eE8rCOumvo8zWLbxO9ijT1+qo8Av/gMv33D2N9UVmiIIvV2M8C/Nlmq8jP5ax8W
 98PUVFU8R7tnmE9I=
X-Received: by 2002:adf:ee51:0:b0:311:13a7:2d87 with SMTP id
 w17-20020adfee51000000b0031113a72d87mr805762wro.66.1686904349155; 
 Fri, 16 Jun 2023 01:32:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ713m3NziD0SgvmT1NtfwPhFqZDcFpc6EM4BeyiLGR0xras8SjfB+WgiyyVbQ9iOG/ZXOJ7pw==
X-Received: by 2002:adf:ee51:0:b0:311:13a7:2d87 with SMTP id
 w17-20020adfee51000000b0031113a72d87mr805748wro.66.1686904348824; 
 Fri, 16 Jun 2023 01:32:28 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 f11-20020a5d50cb000000b0030fb828511csm16395270wrt.100.2023.06.16.01.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jun 2023 01:32:28 -0700 (PDT)
Date: Fri, 16 Jun 2023 10:32:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Julia Suvorova <jusual@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/pci: prevent hotplug of devices on
 pcie-root-ports on the wrong slot
Message-ID: <20230616103227.0028f4fa@imammedo.users.ipa.redhat.com>
In-Reply-To: <D505615B-F22E-441A-9F6C-566E46C714E8@redhat.com>
References: <20230615051645.4798-1-anisinha@redhat.com>
 <20230615132659.6bcfcf0c@imammedo.users.ipa.redhat.com>
 <D505615B-F22E-441A-9F6C-566E46C714E8@redhat.com>
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

On Fri, 16 Jun 2023 13:06:06 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> > On 15-Jun-2023, at 4:56 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > On Thu, 15 Jun 2023 10:46:45 +0530
> > Ani Sinha <anisinha@redhat.com> wrote:
> >   
> >> PCIE root ports and other upstream ports only allow one device on slot 0.
> >> When hotplugging a device on a pcie root port, make sure that the device
> >> address passed always represents slot 0. Any other slot value would be
> >> illegal on a root port.
> >> 
> >> CC: jusual@redhat.com
> >> CC: imammedo@redhat.com
> >> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> >> ---
> >> hw/pci/pci.c | 16 ++++++++++++++++
> >> 1 file changed, 16 insertions(+)
> >> 
> >> changelog:
> >> v2: feedback from mst included.
> >> 
> >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> >> index bf38905b7d..66999352cc 100644
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
> >> @@ -1182,6 +1183,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> >>     } else if (dev->hotplugged &&
> >>                !pci_is_vf(pci_dev) &&
> >>                pci_get_function_0(pci_dev)) {
> >> +        /*
> >> +         * populating function 0 triggers a bus scan from the guest that
> >> +         * exposes other non-zero functions. Hence we need to ensure that
> >> +         * function 0 is available.
> >> +         */
> >>         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
> >>                    " new func %s cannot be exposed to guest.",
> >>                    PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
> >> @@ -1189,6 +1195,16 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> >>                    name);
> >> 
> >>        return NULL;
> >> +    } else if (dev->hotplugged &&
> >> +               !pci_is_vf(pci_dev) &&
> >> +               pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
> >> +        /*
> >> +         * If the device is being plugged into an upstream PCIE port,  
> > 
> > you probably mixing up downstream port with upstream one,
> > the only thing that could be plugged into upstream port
> > is PCIE switch.
> > 
> > Also I'm not sure that we should do this at all.
> > Looking at BZ it seems that QEMU crashes inside backend
> > and tear down/cleanup sequence is broken somewhere.
> > And that is the root cause, so I'd rather fix that 1st
> > and only after that consider adding workarounds if any
> > were necessary.  
> 
> I have added more details in the ticket. I still believe that my approach is in the right direction.

eject is _optional_ and guest is free to ignore eject request.
That shall not cause improper QEMU behavior.

Preventing bug trigger is ok if we can't fix root cause but
then one should explain in commit message what root cause
is and why it can't be fixed.

does it work for similar coldplugged setup without unplug
(if yes then why)?

> 
> > 
> >   
> >> +         * like a pcie root port, we only support one device at slot 0
> >> +         */
> >> +        error_setg(errp, "PCI: slot %d is not valid for %s",
> >> +                   PCI_SLOT(devfn), name);
> >> +        return NULL;
> >>     }
> >> 
> >>     pci_dev->devfn = devfn;  
> 



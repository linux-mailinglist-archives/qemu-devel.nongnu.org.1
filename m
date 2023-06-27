Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECBAA73FC12
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:39:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7y9-0003UU-RF; Tue, 27 Jun 2023 08:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qE7y7-0003U9-T0
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:38:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qE7y5-0008Am-On
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:38:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687869528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1S9TitJCsbSqsj4GY6YGvC85kEdx0AGbL8dUgQyLqwc=;
 b=c0RvVgkp6+LzLXs1la+hgGanppoRIG35tdlbgBlztbPYaCN6PKPZXlTQIC3ewV1N4QrqCW
 InKGJDRIXhiED5PIbBpwvXt+shVTawXBC/cvVCCMSE8qg5K1KIOlWa6E9dsHoQA6rJ6TPV
 auNbvrSPnlxXz00e4g4CnC/dUb5mhB8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-tOg1VAOgO8aw7iWS9PGfTQ-1; Tue, 27 Jun 2023 08:38:47 -0400
X-MC-Unique: tOg1VAOgO8aw7iWS9PGfTQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-51a5c1e9fbdso5326587a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687869526; x=1690461526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1S9TitJCsbSqsj4GY6YGvC85kEdx0AGbL8dUgQyLqwc=;
 b=Wq/j/F4hxkoyMhNVNulSYsdfsaGebGwDDRLDKN0qsxJMURBgaww/adCUW9VWwRDyuV
 4SlQP133gI9XMwibSJ3eXtcH0ml/RZMV1hzX/tqZzNWYKAiEeeStjAYik8lTK8RDcIbS
 aoE/yxTM01t0EDxvRO4LsQGXoL1+QXj8KyasR2AVwkMDL7pUqXll5oDQs+bTwcJ7sy/f
 P2hxA1Fkhegxj2HE2Y7A9VFTRfOVkP++LsDlz6Moh7TSb+stYt8okDjpe/dZevD2H9mC
 In6zh6bEzjIekTGs/1TyPVmHMb0AUHzYJTaue94D2FLW9RseeXQxIVNqrYDmmxJ5Rq9C
 PsWQ==
X-Gm-Message-State: AC+VfDxZ1w/9dGU+cP3ulwCGz7+CmVfIC35swqPDVcZ7lnWQ062lkXca
 nCqjvqJdVm/+emuYlyucmMbDoc9WEuC6qd6qvZgN8HHX4UBiWl58DLgzW+djf6Z+CsX6Fxbyroe
 Jb1d4CdgER1ZJjjY=
X-Received: by 2002:a05:6402:18c:b0:518:741e:9314 with SMTP id
 r12-20020a056402018c00b00518741e9314mr30670921edv.11.1687869526129; 
 Tue, 27 Jun 2023 05:38:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TkIKnzblY+GByMGumzOzcDtA64y2UykFZ1UBkvZNJbYrJx9Nrl/cD4nhjfs11Sxfyy/rHvg==
X-Received: by 2002:a05:6402:18c:b0:518:741e:9314 with SMTP id
 r12-20020a056402018c00b00518741e9314mr30670906edv.11.1687869525850; 
 Tue, 27 Jun 2023 05:38:45 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 d15-20020a05640208cf00b0051a3e7d7996sm3782999edz.83.2023.06.27.05.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 05:38:45 -0700 (PDT)
Date: Tue, 27 Jun 2023 14:38:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, jusual@redhat.com
Subject: Re: [RESEND PATCH v5 5/5] hw/pci: ensure PCIE devices are plugged
 into only slot 0 of PCIE port
Message-ID: <20230627143844.514594e8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230627081835-mutt-send-email-mst@kernel.org>
References: <20230626161244.4145-1-anisinha@redhat.com>
 <20230626161244.4145-6-anisinha@redhat.com>
 <20230627110224.36fa1b06@imammedo.users.ipa.redhat.com>
 <A085E1C1-244C-4ED3-AC9A-17497BA66255@redhat.com>
 <20230627135849.37e52f87@imammedo.users.ipa.redhat.com>
 <20230627081835-mutt-send-email-mst@kernel.org>
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

On Tue, 27 Jun 2023 08:23:25 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Jun 27, 2023 at 01:58:49PM +0200, Igor Mammedov wrote:
> > On Tue, 27 Jun 2023 15:23:04 +0530
> > Ani Sinha <anisinha@redhat.com> wrote:
> >   
> > > > On 27-Jun-2023, at 2:32 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> > > > 
> > > > On Mon, 26 Jun 2023 21:42:44 +0530
> > > > Ani Sinha <anisinha@redhat.com> wrote:
> > > >     
> > > >> PCI Express ports only have one slot, so PCI Express devices can only be
> > > >> plugged into slot 0 on a PCIE port. Enforce it.    
> > > > 
> > > > btw, previously you mentioned ARI.
> > > > So if we turn it on, wouldn't this patch actually become regression?    
> > > 
> > > If ARI breaks this, it will break other areas in QEMU too, ex anywhere pci_get_function_0() is used.
> > > Regardless, I think at least the tests are worth fixing, particularly the mess with hd-geo-test.  
> > 
> > I'm fine with this patch if you test it with ARI enabled and it won't break
> > something that has been working before this patch. Just mention what testing
> > you've done in commit message.  
> 
> Oh yes. That's why it was checking !vf originally. It's because the most
> common use of ARI is SRIOV, so it works a a kind of hack.

should we check for ARI cap instead of vf hack?
why we haven't that from the beginning?

> 
> > >   
> > > >     
> > > >> 
> > > >> CC: jusual@redhat.com
> > > >> CC: imammedo@redhat.com
> > > >> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> > > >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > > >> Reviewed-by: Julia Suvorova <jusual@redhat.com>
> > > >> ---
> > > >> hw/pci/pci.c | 6 ++++++
> > > >> 1 file changed, 6 insertions(+)
> > > >> 
> > > >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > >> index bf38905b7d..426af133b0 100644
> > > >> --- a/hw/pci/pci.c
> > > >> +++ b/hw/pci/pci.c
> > > >> @@ -64,6 +64,7 @@ bool pci_available = true;
> > > >> static char *pcibus_get_dev_path(DeviceState *dev);
> > > >> static char *pcibus_get_fw_dev_path(DeviceState *dev);
> > > >> static void pcibus_reset(BusState *qbus);
> > > >> +static bool pcie_has_upstream_port(PCIDevice *dev);
> > > >> 
> > > >> static Property pci_props[] = {
> > > >>     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> > > >> @@ -1189,6 +1190,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> > > >>                    name);
> > > >> 
> > > >>        return NULL;
> > > >> +    } else if (pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
> > > >> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> > > >> +                   " parent device only allows plugging into slot 0.",
> > > >> +                   PCI_SLOT(devfn), name);
> > > >> +        return NULL;
> > > >>     }
> > > >> 
> > > >>     pci_dev->devfn = devfn;    
> > > >     
> > >   
> 



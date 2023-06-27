Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D5173FBEC
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:24:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7jQ-0002M3-DH; Tue, 27 Jun 2023 08:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qE7jK-0002Jm-Iz
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qE7jI-00042u-Jp
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:23:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687868612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9nSVWFmIcxJ5jBwkQyJai+GJWEbupCYH+RqEovEmF4U=;
 b=IPse4JF/bND3HavxecO6Dw/2cU1+AgOFmLnkwBNKhtUNnGmcrrJRyXc548D+gHBOMshnHE
 btvkCakbwsn9rfcEGruxAJWuWA5a2egIRekEvDxCWv33Owt3ukMbAss/+CZ5AG6PieG6A+
 hVp2pVhcdNyY/OddAtI35eYmTQEGHwM=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-2ZKfZfzLNTS-5waiRF5_DQ-1; Tue, 27 Jun 2023 08:23:30 -0400
X-MC-Unique: 2ZKfZfzLNTS-5waiRF5_DQ-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-44376d27193so39682137.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687868610; x=1690460610;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9nSVWFmIcxJ5jBwkQyJai+GJWEbupCYH+RqEovEmF4U=;
 b=IrlDunYP5Gwve/m7qDMLh1c+s3UBYVQWHH04R9xokDe2/LtgBvG7U/I8QBD61FRzRQ
 l9hzWAzsWx5WIcHiNpXRhO3Y05C8Lfk3utS/5IQOYiOBD7e2EYmeY1YMMO+LmPaUOpIQ
 7JQ5cxu5inknEDYAcEcF9ZNK8LkIGxA+xfutCgHzndejKETY8NdH7/qUE9kR2yLYxseW
 sh3nImhjx9GK7mxXs0zZg0g0AJGZ4EtJniVS7PsmG//gbSOlOCX5AzFWZCJevQdCi/V2
 bIk0X6aLt3vrO1SBeRXE4xLFFFdXpc+1qwyMN1dk0MTegtja8eQvz5oEf7sb+jHWLBHi
 Njjg==
X-Gm-Message-State: AC+VfDzt7bhjG8RGDlXTtrV5e8DtuAeP/MCOyxgJbfyTqaFWJToVnLtU
 ZrktetnwpVRICssfhR/YvcEwINVREFVilXoxlgreKt0k2ap6DWWLAjhWPGApbN0k2Nxvr77KYQX
 ce5+DhhTMYSLD+WM=
X-Received: by 2002:a05:6102:11f2:b0:43b:3e78:9886 with SMTP id
 e18-20020a05610211f200b0043b3e789886mr9930795vsg.26.1687868610095; 
 Tue, 27 Jun 2023 05:23:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4EI5Xng9mgLwxwOAk04u+jN74lXIa/DO6iY4JaxjLeRIAwcFZWd1GzBLBSNrOI6b5not8c2g==
X-Received: by 2002:a05:6102:11f2:b0:43b:3e78:9886 with SMTP id
 e18-20020a05610211f200b0043b3e789886mr9930782vsg.26.1687868609795; 
 Tue, 27 Jun 2023 05:23:29 -0700 (PDT)
Received: from redhat.com ([2.52.141.236]) by smtp.gmail.com with ESMTPSA id
 z20-20020a67d294000000b00440b20a7634sm1044248vsi.33.2023.06.27.05.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jun 2023 05:23:29 -0700 (PDT)
Date: Tue, 27 Jun 2023 08:23:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, jusual@redhat.com
Subject: Re: [RESEND PATCH v5 5/5] hw/pci: ensure PCIE devices are plugged
 into only slot 0 of PCIE port
Message-ID: <20230627081835-mutt-send-email-mst@kernel.org>
References: <20230626161244.4145-1-anisinha@redhat.com>
 <20230626161244.4145-6-anisinha@redhat.com>
 <20230627110224.36fa1b06@imammedo.users.ipa.redhat.com>
 <A085E1C1-244C-4ED3-AC9A-17497BA66255@redhat.com>
 <20230627135849.37e52f87@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627135849.37e52f87@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Tue, Jun 27, 2023 at 01:58:49PM +0200, Igor Mammedov wrote:
> On Tue, 27 Jun 2023 15:23:04 +0530
> Ani Sinha <anisinha@redhat.com> wrote:
> 
> > > On 27-Jun-2023, at 2:32 PM, Igor Mammedov <imammedo@redhat.com> wrote:
> > > 
> > > On Mon, 26 Jun 2023 21:42:44 +0530
> > > Ani Sinha <anisinha@redhat.com> wrote:
> > >   
> > >> PCI Express ports only have one slot, so PCI Express devices can only be
> > >> plugged into slot 0 on a PCIE port. Enforce it.  
> > > 
> > > btw, previously you mentioned ARI.
> > > So if we turn it on, wouldn't this patch actually become regression?  
> > 
> > If ARI breaks this, it will break other areas in QEMU too, ex anywhere pci_get_function_0() is used.
> > Regardless, I think at least the tests are worth fixing, particularly the mess with hd-geo-test.
> 
> I'm fine with this patch if you test it with ARI enabled and it won't break
> something that has been working before this patch. Just mention what testing
> you've done in commit message.

Oh yes. That's why it was checking !vf originally. It's because the most
common use of ARI is SRIOV, so it works a a kind of hack.

> > 
> > >   
> > >> 
> > >> CC: jusual@redhat.com
> > >> CC: imammedo@redhat.com
> > >> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> > >> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > >> Reviewed-by: Julia Suvorova <jusual@redhat.com>
> > >> ---
> > >> hw/pci/pci.c | 6 ++++++
> > >> 1 file changed, 6 insertions(+)
> > >> 
> > >> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > >> index bf38905b7d..426af133b0 100644
> > >> --- a/hw/pci/pci.c
> > >> +++ b/hw/pci/pci.c
> > >> @@ -64,6 +64,7 @@ bool pci_available = true;
> > >> static char *pcibus_get_dev_path(DeviceState *dev);
> > >> static char *pcibus_get_fw_dev_path(DeviceState *dev);
> > >> static void pcibus_reset(BusState *qbus);
> > >> +static bool pcie_has_upstream_port(PCIDevice *dev);
> > >> 
> > >> static Property pci_props[] = {
> > >>     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
> > >> @@ -1189,6 +1190,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> > >>                    name);
> > >> 
> > >>        return NULL;
> > >> +    } else if (pcie_has_upstream_port(pci_dev) && PCI_SLOT(devfn)) {
> > >> +        error_setg(errp, "PCI: slot %d is not valid for %s,"
> > >> +                   " parent device only allows plugging into slot 0.",
> > >> +                   PCI_SLOT(devfn), name);
> > >> +        return NULL;
> > >>     }
> > >> 
> > >>     pci_dev->devfn = devfn;  
> > >   
> > 



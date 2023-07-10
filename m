Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9848D74DE65
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 21:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIwnF-00064q-7N; Mon, 10 Jul 2023 15:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIwn4-00064c-Lv
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:43:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIwms-0003o6-Ft
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 15:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689018189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T+s1UgrWPsnmPjxE1YqQhy0bj1FMKHWmNPW0Dg1S7Ns=;
 b=iixXU78a1rdfHhi04qXwPEPXlXt/w7Z7B+p1V8Kk9K3YdxhWS06cxzOzgEsKJSFdhEpWtF
 i0lDRzOCoJn0esW5PP2qn0c9RkO/X2LnIv1iXnJTeY/WIM3VFFjQCL+roWX/RyhacNENGx
 p2X5qZrm9E87r2YGabOmnc6eZDssHRE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-VLSfQYwMP7iOp_qHquhpAQ-1; Mon, 10 Jul 2023 15:43:07 -0400
X-MC-Unique: VLSfQYwMP7iOp_qHquhpAQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3143ac4a562so2775585f8f.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 12:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689018185; x=1691610185;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T+s1UgrWPsnmPjxE1YqQhy0bj1FMKHWmNPW0Dg1S7Ns=;
 b=ZVxcgLj3J2wgHGaEDSp8Mwp64U/1vSTU+OM4/KRFngmKD0KH3Gw/ia2lkQZvWizWXw
 sZmALeC54wd09ARghJhDX4egVGNEY20BlQFx7wA3H2qEz6oDx8WcazjmwtK9ElhCIloa
 ECEwo6PjgZ7b5H+j40HdCuXavydJokEiHd6lCJrGqdBzxO0u2ymibDFUcSWP1zbMYvhS
 ELLRRaphBPp50ZwAwz3deHRI4ahspHB5zFngiy3BrxzTJpcr5Zdw1pNxXEXO1UCr8wIt
 YZHGVJ7k57Exj2j+VA5w2DwKkF4X6uWSTvFiS52umlCzWOYJJVLgG/hjkBGwMO9LyGh8
 Pnrg==
X-Gm-Message-State: ABy/qLYEieptN+5QwDRY0zmBA8Ht1H75r0a4ao9x7M2s+D135+X6JS3m
 M+qReuJxm0C/2StGDwpIBbkkcgnuX/jxYarrVK7ffUsG/asuND1KZ87/rPS3d9aLMa6I71xcr8L
 4Y4KUgH2kvWyfWwI=
X-Received: by 2002:adf:f805:0:b0:314:4c78:8b84 with SMTP id
 s5-20020adff805000000b003144c788b84mr12748273wrp.17.1689018185599; 
 Mon, 10 Jul 2023 12:43:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF9fcKuHuBhe2vZuO7WL9LC1PxAe/aYUmBCja1FJKIKj5XEBmXI8251MAEQ9ZEG8rv1n2RBew==
X-Received: by 2002:adf:f805:0:b0:314:4c78:8b84 with SMTP id
 s5-20020adff805000000b003144c788b84mr12748259wrp.17.1689018185291; 
 Mon, 10 Jul 2023 12:43:05 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 k2-20020a5d5182000000b003143aa0ca8asm258079wrv.13.2023.07.10.12.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 12:43:04 -0700 (PDT)
Date: Mon, 10 Jul 2023 15:43:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v8 6/6] hw/pci: add comment explaining the reason for
 checking function 0 in hotplug
Message-ID: <20230710154155-mutt-send-email-mst@kernel.org>
References: <20230705115925.5339-1-anisinha@redhat.com>
 <20230705115925.5339-7-anisinha@redhat.com>
 <F99D12E7-135A-4A03-8B9D-1FF384FBCA5A@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F99D12E7-135A-4A03-8B9D-1FF384FBCA5A@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Wed, Jul 05, 2023 at 05:33:31PM +0530, Ani Sinha wrote:
> 
> 
> > On 05-Jul-2023, at 5:29 PM, Ani Sinha <anisinha@redhat.com> wrote:
> > 
> > This change is cosmetic. A comment is added explaining why we need to check for
> > the availability of function 0 when we hotplug a device.
> 
> Please ignore this patch. Its a duplicate of one already sent with an updated patch summary.

I'm not sure which one it is, sorry. Dropped this for now, repost later
pls.

> > 
> > CC: mst@redhat.com
> > Signed-off-by: Ani Sinha <anisinha@redhat.com>
> > ---
> > hw/pci/pci.c | 11 ++++++++---
> > 1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 62b393dfb7..7aee3a7f12 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -1181,9 +1181,14 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
> >                    PCI_SLOT(devfn), PCI_FUNC(devfn), name,
> >                    bus->devices[devfn]->name, bus->devices[devfn]->qdev.id);
> >         return NULL;
> > -    } else if (dev->hotplugged &&
> > -               !pci_is_vf(pci_dev) &&
> > -               pci_get_function_0(pci_dev)) {
> > +    } /*
> > +       * Populating function 0 triggers a scan from the guest that
> > +       * exposes other non-zero functions. Hence we need to ensure that
> > +       * function 0 wasn't added yet.
> > +       */
> > +    else if (dev->hotplugged &&
> > +             !pci_is_vf(pci_dev) &&
> > +             pci_get_function_0(pci_dev)) {
> >         error_setg(errp, "PCI: slot %d function 0 already occupied by %s,"
> >                    " new func %s cannot be exposed to guest.",
> >                    PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
> > -- 
> > 2.39.1
> > 



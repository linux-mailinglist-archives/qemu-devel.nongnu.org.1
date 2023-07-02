Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C47744CD4
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 10:58:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFstu-0001OR-HP; Sun, 02 Jul 2023 04:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFsts-0001O0-Ty
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFstr-0007A7-CI
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688288262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UN5waCaEpNnmjkm2GAC+sDmZrTMKHGSh+yxJBwBLxQo=;
 b=GK2V+Y2R/+AY/CrdtH3tPqT/k7LrkmbxZJ6COU9lijvvJKlr7o+aIb20ph4Zy3APa7uz6i
 YOb8VgeIgx4cWr84A/7W02QVQrRvFDexRhz5Ay997vjBWgphDgph4NG+Vtn94SaMR9nBGX
 nE760rL/qUB1bUpIM/T3fyTmff6zf9A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-yAQys7fGMS-YJWSVKk-Zdg-1; Sun, 02 Jul 2023 04:57:39 -0400
X-MC-Unique: yAQys7fGMS-YJWSVKk-Zdg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-50a16ab50e6so1487069a12.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 01:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688288258; x=1690880258;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UN5waCaEpNnmjkm2GAC+sDmZrTMKHGSh+yxJBwBLxQo=;
 b=EF3Y2pyDRAZm/lpcA/lhgM+YYRB7cMjK79msti2I/h/rLSyxlAIkHNq7Qqer9Uu5co
 nhZM1VR2jccLegYMRYZYJlZByf097iegz+2bAZTDREhRquGI1Q50FjazQxGifX0nr+Tv
 U5+YAneT0ZviVek+9LDI1MyedMtWzzD5Z/3KIqiGVF4yLen+/ZPEWrKaOIKeKkfqRYR9
 0tqaR860jEmo40i9OkluLigT/6KlwJ34g3TytYLLPmQc1oAlU08PY+bja8BAdoKtJz0e
 2zLt94GaGxvzqStwc6TdolvAz57UyAWtJWj7bOCKbykUJ8K/djIY8xG1bkGNN1OF0eMc
 jJbg==
X-Gm-Message-State: ABy/qLabPUxvXEyS1LjXcZBlrrFGua3/3SSihtMVwlQbWfXNdu4Lf9lu
 cnU+M9OE/ZDnW41DjW/iIKsYnAYlJeWyWwc817Mx9xc/HJUD1Kve2Ru4Y9hBGNWD4IgREgmEqYN
 kGEXZU1QoJ7GtRhE=
X-Received: by 2002:a50:fb09:0:b0:51d:fa7c:c330 with SMTP id
 d9-20020a50fb09000000b0051dfa7cc330mr2169556edq.26.1688288258194; 
 Sun, 02 Jul 2023 01:57:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEx7JdN5HKMDtqS4JssJaXpWHAAMMeU1ABTCG8yT0Z+htNh/0OUsaf+WbQOWPtNxiaQd+IAlg==
X-Received: by 2002:a50:fb09:0:b0:51d:fa7c:c330 with SMTP id
 d9-20020a50fb09000000b0051dfa7cc330mr2169541edq.26.1688288257901; 
 Sun, 02 Jul 2023 01:57:37 -0700 (PDT)
Received: from redhat.com ([2.52.134.224]) by smtp.gmail.com with ESMTPSA id
 bc23-20020a056402205700b0051d9dbf5edfsm6858534edb.55.2023.07.02.01.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 01:57:37 -0700 (PDT)
Date: Sun, 2 Jul 2023 04:57:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 4/4] pci: Compare function number and ARI next function
 number
Message-ID: <20230702045605-mutt-send-email-mst@kernel.org>
References: <20230701070133.24877-1-akihiko.odaki@daynix.com>
 <20230701070133.24877-5-akihiko.odaki@daynix.com>
 <20230702004344-mutt-send-email-mst@kernel.org>
 <b7611765-761d-62e8-a3d5-06a7c0b2f33c@daynix.com>
 <20230702044829-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230702044829-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sun, Jul 02, 2023 at 04:55:48AM -0400, Michael S. Tsirkin wrote:
> On Sun, Jul 02, 2023 at 05:46:38PM +0900, Akihiko Odaki wrote:
> > On 2023/07/02 13:58, Michael S. Tsirkin wrote:
> > > On Sat, Jul 01, 2023 at 04:01:22PM +0900, Akihiko Odaki wrote:
> > > > The function number must be lower than the next function number
> > > > advertised with ARI.
> > > > 
> > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > 
> > > I don't get this logic at all - where is the limitation coming from?
> > > 
> > > All I see in the spec is:
> > > 	Next Function Number - With non-VFs, this field indicates the Function Number of the next higher
> > > 	numbered Function in the Device, or 00h if there are no higher numbered Functions. Function 0 starts
> > > 	this linked list of Functions.
> > > 	The presence of Shadow Functions does not affect this field.
> > > 	For VFs, this field is undefined since VFs are located using First VF Offset (see § Section 9.3.3.9 ) and VF
> > > 	Stride (see § Section 9.3.3.10 ).
> > > 
> > > and
> > > 
> > > 	 To improve the enumeration performance and create a more deterministic solution, software can
> > > 	enumerate Functions through a linked list of Function Numbers. The next linked list element is
> > > 	communicated through each Function’s ARI Capability Register.
> > > 	i. Function 0 acts as the head of a linked list of Function Numbers. Software detects a
> > > 	non-Zero Next Function Number field within the ARI Capability Register as the next
> > > 	Function within the linked list. Software issues a configuration probe using the Bus Number
> > > 	captured by the Device and the Function Number derived from the ARI Capability Register
> > > 	to locate the next associated Function’s configuration space.
> > > 	ii. Function Numbers may be sparse and non-sequential in their consumption by an ARI
> > > 	Device.
> > 
> > The statement "With non-VFs, this field indicates the Function Number of the
> > next higher numbered Function in the Device, or 00h if there are no higher
> > numbered Functions." implies the Function Number of the device should be
> > lower than the value advertised by the field (for non-VFs; this patch does
> > not check if it's VF or not.)
> 
> 
> Now I get it. Good point! I'd say if we want this check we should add
> it in pcie_ari_init, making that return int.
> But for now it's dead code since your are changing it to 0.
> So maybe a comment in pcie_ari_init is enough:
> 
> /*
>  * Note: nextfn must be the Function Number of the
>  * next higher numbered Function in the Device, or 00h if there are no higher
>  * numbered Functions.
>  * TODO: validate this.
>  */

Or add an assert, and
	TODO: in case this can ever come from command line, we'll have
	to replace the assert below with a runtime check.


> > > 
> > > 
> > > 
> > > 
> > > 
> > > > ---
> > > >   hw/pci/pci.c | 15 +++++++++++++++
> > > >   1 file changed, 15 insertions(+)
> > > > 
> > > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > > index e2eb4c3b4a..568665ee42 100644
> > > > --- a/hw/pci/pci.c
> > > > +++ b/hw/pci/pci.c
> > > > @@ -2059,6 +2059,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> > > >       Error *local_err = NULL;
> > > >       bool is_default_rom;
> > > >       uint16_t class_id;
> > > > +    uint16_t ari;
> > > > +    uint16_t nextfn;
> > > >       /*
> > > >        * capped by systemd (see: udev-builtin-net_id.c)
> > > > @@ -2121,6 +2123,19 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> > > >           }
> > > >       }
> > > > +    if (pci_is_express(pci_dev)) {
> > > > +        ari = pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI);
> > > > +        if (ari) {
> > > > +            nextfn = (pci_get_long(pci_dev->config + ari + PCI_ARI_CAP) >> 8) & 0xff;
> > > > +            if (nextfn && (pci_dev->devfn & 0xff) >= nextfn) {
> > > > +                error_setg(errp, "PCI: function number %u is not lower than ARI next function number %u",
> > > > +                           pci_dev->devfn & 0xff, nextfn);
> > > > +                pci_qdev_unrealize(DEVICE(pci_dev));
> > > > +                return;
> > > > +            }
> > > > +        }
> > > > +    }
> > > > +
> > > >       if (pci_dev->failover_pair_id) {
> > > >           if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
> > > >               error_setg(errp, "failover primary device must be on "
> > > > -- 
> > > > 2.41.0
> > > 



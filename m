Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C92744CD1
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 10:57:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFss8-0008OQ-R7; Sun, 02 Jul 2023 04:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFss6-0008Nm-5r
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:55:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFss4-0006yo-HK
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688288151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mjYvxM6aARYzdxbg1oION0RoFKF8WR0fzmk/mQSEJIc=;
 b=hWMOaGF7B191u10QWFnuhQ5w3fIvb9JC7mAVEvC1/efNF4rndA4fH/89eoNb4MlvhFNHO2
 rzBjWHtTwdNEkJdb48lGXJ/h5l7LYTnYz9/nc2E0ywFwllvyPvss1kz7El5LpLs9eaxJLd
 4V6nkc+w+AMcjlpTAFToYVS09DLAbQ8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-XfdZXhlpPbeJ-hCf1uPtbQ-1; Sun, 02 Jul 2023 04:55:49 -0400
X-MC-Unique: XfdZXhlpPbeJ-hCf1uPtbQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-513f337d478so1737746a12.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 01:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688288148; x=1690880148;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mjYvxM6aARYzdxbg1oION0RoFKF8WR0fzmk/mQSEJIc=;
 b=B/nuW1KQHGcCC+Bn0x3QKOcShvjt0QTiDUL9cy3JPXfxxQT8nJA/dwwm0XNsm29jYx
 4DMdPcsZ8AFnT8bmea19Xw7OiaQ/oJzzFV7Jnp0SCYFm82U+1tpPfwmnnTfTYJVSZBHf
 k5EE+EzKvQFAM71paoAhpWU3IixtUKOvDoqYfxHMMIQw6kvF7uZAZWGWfmqa15YRHxei
 +ilBY1YWbHtnMzEROFDg9Z9cyU6SdK5Vidn6dVgGA6dsIoUzfUHCE1bgaSRGuJU2NYIJ
 XasUyA80DGXPpnyN/KwYjtnlL323CigmYk7kckSVZf5Y+AsfBrt/yL58eWddLW4KpUDR
 gPxw==
X-Gm-Message-State: ABy/qLalBO9DDJi0+v/xj3ABzrtQbgIXxpIe49aGj8xOJ1IkfiCpi4l0
 HTz7VQN9CBMSNMMQtb2utWJAnBDuV9/jswhL0gNBE8smyO+QdVI1oWnsriL8Omvl0Yu9uxuOJzE
 jLC4PaX1Rbj9iV6I=
X-Received: by 2002:aa7:c24d:0:b0:51d:f39d:1716 with SMTP id
 y13-20020aa7c24d000000b0051df39d1716mr4209491edo.22.1688288148622; 
 Sun, 02 Jul 2023 01:55:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHgKh6pAhhj/ygFhDkuomdDs9IZTmIWWFilfR6eMQmaoZHEd8E/+3CmRQwbcb7iF6oZnVYhtw==
X-Received: by 2002:aa7:c24d:0:b0:51d:f39d:1716 with SMTP id
 y13-20020aa7c24d000000b0051df39d1716mr4209477edo.22.1688288148286; 
 Sun, 02 Jul 2023 01:55:48 -0700 (PDT)
Received: from redhat.com ([2.52.134.224]) by smtp.gmail.com with ESMTPSA id
 r26-20020aa7d59a000000b0051d961ab28asm7518162edq.67.2023.07.02.01.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 01:55:47 -0700 (PDT)
Date: Sun, 2 Jul 2023 04:55:44 -0400
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
Message-ID: <20230702044829-mutt-send-email-mst@kernel.org>
References: <20230701070133.24877-1-akihiko.odaki@daynix.com>
 <20230701070133.24877-5-akihiko.odaki@daynix.com>
 <20230702004344-mutt-send-email-mst@kernel.org>
 <b7611765-761d-62e8-a3d5-06a7c0b2f33c@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7611765-761d-62e8-a3d5-06a7c0b2f33c@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Sun, Jul 02, 2023 at 05:46:38PM +0900, Akihiko Odaki wrote:
> On 2023/07/02 13:58, Michael S. Tsirkin wrote:
> > On Sat, Jul 01, 2023 at 04:01:22PM +0900, Akihiko Odaki wrote:
> > > The function number must be lower than the next function number
> > > advertised with ARI.
> > > 
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> > I don't get this logic at all - where is the limitation coming from?
> > 
> > All I see in the spec is:
> > 	Next Function Number - With non-VFs, this field indicates the Function Number of the next higher
> > 	numbered Function in the Device, or 00h if there are no higher numbered Functions. Function 0 starts
> > 	this linked list of Functions.
> > 	The presence of Shadow Functions does not affect this field.
> > 	For VFs, this field is undefined since VFs are located using First VF Offset (see § Section 9.3.3.9 ) and VF
> > 	Stride (see § Section 9.3.3.10 ).
> > 
> > and
> > 
> > 	 To improve the enumeration performance and create a more deterministic solution, software can
> > 	enumerate Functions through a linked list of Function Numbers. The next linked list element is
> > 	communicated through each Function’s ARI Capability Register.
> > 	i. Function 0 acts as the head of a linked list of Function Numbers. Software detects a
> > 	non-Zero Next Function Number field within the ARI Capability Register as the next
> > 	Function within the linked list. Software issues a configuration probe using the Bus Number
> > 	captured by the Device and the Function Number derived from the ARI Capability Register
> > 	to locate the next associated Function’s configuration space.
> > 	ii. Function Numbers may be sparse and non-sequential in their consumption by an ARI
> > 	Device.
> 
> The statement "With non-VFs, this field indicates the Function Number of the
> next higher numbered Function in the Device, or 00h if there are no higher
> numbered Functions." implies the Function Number of the device should be
> lower than the value advertised by the field (for non-VFs; this patch does
> not check if it's VF or not.)


Now I get it. Good point! I'd say if we want this check we should add
it in pcie_ari_init, making that return int.
But for now it's dead code since your are changing it to 0.
So maybe a comment in pcie_ari_init is enough:

/*
 * Note: nextfn must be the Function Number of the
 * next higher numbered Function in the Device, or 00h if there are no higher
 * numbered Functions.
 * TODO: validate this.
 */

> > 
> > 
> > 
> > 
> > 
> > > ---
> > >   hw/pci/pci.c | 15 +++++++++++++++
> > >   1 file changed, 15 insertions(+)
> > > 
> > > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > > index e2eb4c3b4a..568665ee42 100644
> > > --- a/hw/pci/pci.c
> > > +++ b/hw/pci/pci.c
> > > @@ -2059,6 +2059,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> > >       Error *local_err = NULL;
> > >       bool is_default_rom;
> > >       uint16_t class_id;
> > > +    uint16_t ari;
> > > +    uint16_t nextfn;
> > >       /*
> > >        * capped by systemd (see: udev-builtin-net_id.c)
> > > @@ -2121,6 +2123,19 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> > >           }
> > >       }
> > > +    if (pci_is_express(pci_dev)) {
> > > +        ari = pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI);
> > > +        if (ari) {
> > > +            nextfn = (pci_get_long(pci_dev->config + ari + PCI_ARI_CAP) >> 8) & 0xff;
> > > +            if (nextfn && (pci_dev->devfn & 0xff) >= nextfn) {
> > > +                error_setg(errp, "PCI: function number %u is not lower than ARI next function number %u",
> > > +                           pci_dev->devfn & 0xff, nextfn);
> > > +                pci_qdev_unrealize(DEVICE(pci_dev));
> > > +                return;
> > > +            }
> > > +        }
> > > +    }
> > > +
> > >       if (pci_dev->failover_pair_id) {
> > >           if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
> > >               error_setg(errp, "failover primary device must be on "
> > > -- 
> > > 2.41.0
> > 



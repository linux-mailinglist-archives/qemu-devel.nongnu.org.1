Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6950A74E92D
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 10:34:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ8p1-0008RK-BG; Tue, 11 Jul 2023 04:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qJ8oy-0008Na-Rs
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 04:34:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qJ8ou-0002J6-Ka
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 04:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689064443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=scegDVuqLniXVBQLTpYvJieYnttyC5KCaPVfOqIJ1t0=;
 b=EVvHURUEpJQgVNRYcTf6Rgng+tNDhhdKd2Z/T/hd9RG/jWCpgLYAgXqycjFpRDPiv9KMx+
 M8hbwPCsAJ+dLXW6sux71/ko8uuymlb5FOe1od/eUQ4BBZUY9TqnsBwTdPzAE2j/oayRBc
 QkcgV60YQcgB6hZZFYldio9szJTPPzQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-mweMG9bdNWOlkIgs2jD_AQ-1; Tue, 11 Jul 2023 04:34:02 -0400
X-MC-Unique: mweMG9bdNWOlkIgs2jD_AQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-98e40d91fdfso345071666b.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 01:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689064440; x=1691656440;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=scegDVuqLniXVBQLTpYvJieYnttyC5KCaPVfOqIJ1t0=;
 b=aWf6ys6kGbCBimpRm/z5XwIpo1UdXUhZTNJnWjLLc24OWhiPeNaSOBnWg/M1hll3av
 Hky4nEy24+TyDuCN26X+Qzx952lnGARa3IZYlSyk4cXYd8+OzjYVtV7vZi7YtHv5AAv9
 J9YqBhVSD5RwJM9ly0F0AWuxEnVSyzw1bESL1SGPtulBKq9KLYf1XXxyASaKm9AXoc6Y
 SCIglBayj39A9fv7qPKz/pdQQLLdWP/52mDRpzRB5pHpHLP/QKplctf6ulp3C1Dmcv0Q
 ZDyox1Zb6DOiSz2jC1ykTbEEtIRJCQ4+Ruqt0ApbwSJH2NYKoThbMqc7FxBzQRwn+5GN
 8FXA==
X-Gm-Message-State: ABy/qLaO7GUn0XffwFTII7hUPHICl/EHLaEzgKz1cKaDR0LXMR+0a4TB
 2rdmkXig/LcvrkgFltftxM5PWUemr7n4iaZ7uun/jOXPDihLJUQy57zHvEKSNxXXTw0oNhXbXYs
 6wAOQPS9jWCACnlsYTikFCsE=
X-Received: by 2002:a17:907:a704:b0:992:630f:98b6 with SMTP id
 vw4-20020a170907a70400b00992630f98b6mr15407409ejc.37.1689064440789; 
 Tue, 11 Jul 2023 01:34:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGQylfpYgmb0mL4ZJ23qyuUvJaIv4O5VAjRR2VahLIaPjscN6kqEl+UNgAsxW1QgcWDdfuwZQ==
X-Received: by 2002:a17:907:a704:b0:992:630f:98b6 with SMTP id
 vw4-20020a170907a70400b00992630f98b6mr15407397ejc.37.1689064440477; 
 Tue, 11 Jul 2023 01:34:00 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 li13-20020a170906f98d00b009887c9b2812sm845935ejb.8.2023.07.11.01.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jul 2023 01:34:00 -0700 (PDT)
Date: Tue, 11 Jul 2023 04:33:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-block@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 4/4] pci: Compare function number and ARI next function
 number
Message-ID: <20230711043101-mutt-send-email-mst@kernel.org>
References: <20230701070133.24877-1-akihiko.odaki@daynix.com>
 <20230701070133.24877-5-akihiko.odaki@daynix.com>
 <805445D0-111B-4D7B-A02F-71A4B90FA848@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <805445D0-111B-4D7B-A02F-71A4B90FA848@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Tue, Jul 11, 2023 at 12:40:47PM +0530, Ani Sinha wrote:
> 
> 
> > On 01-Jul-2023, at 12:31 PM, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> > 
> > The function number must be lower than the next function number
> > advertised with ARI.
> > 
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> > hw/pci/pci.c | 15 +++++++++++++++
> > 1 file changed, 15 insertions(+)
> > 
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index e2eb4c3b4a..568665ee42 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -2059,6 +2059,8 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> >     Error *local_err = NULL;
> >     bool is_default_rom;
> >     uint16_t class_id;
> > +    uint16_t ari;
> > +    uint16_t nextfn;
> > 
> >     /*
> >      * capped by systemd (see: udev-builtin-net_id.c)
> > @@ -2121,6 +2123,19 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
> >         }
> >     }
> > 
> > +    if (pci_is_express(pci_dev)) {
> > +        ari = pcie_find_capability(pci_dev, PCI_EXT_CAP_ID_ARI);
> > +        if (ari) {
> > +            nextfn = (pci_get_long(pci_dev->config + ari + PCI_ARI_CAP) >> 8) & 0xff;
> > +            if (nextfn && (pci_dev->devfn & 0xff) >= nextfn) {
> > +                error_setg(errp, "PCI: function number %u is not lower than ARI next function number %u",
> > +                           pci_dev->devfn & 0xff, nextfn);
> > +                pci_qdev_unrealize(DEVICE(pci_dev));
> > +                return;
> > +            }
> > +        }
> > +    }
> > +
> 
> So I kind of got lost in all the patches. What was the ultimate decision regarding checking this?

We still need to fix ARI for multi-function PFs.
I feel the right thing to do is to init Next Function in the ARI
capability, automatically.
For now, we have merely changed ARI setting next function to 0.
At least that's more correct for the common case of ARI PF with VFs.


> >     if (pci_dev->failover_pair_id) {
> >         if (!pci_bus_is_express(pci_get_bus(pci_dev))) {
> >             error_setg(errp, "failover primary device must be on "
> > -- 
> > 2.41.0
> > 



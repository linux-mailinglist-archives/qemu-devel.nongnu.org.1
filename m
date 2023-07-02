Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 502CD744DB5
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 15:26:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFx4J-0003j7-HD; Sun, 02 Jul 2023 09:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFx4G-0003iU-Kq
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 09:24:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFx4D-0005yG-Pl
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 09:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688304280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ol4fZ5x/BoF74DuCnyX4MEfQ90CYTeb5DYAd17AMths=;
 b=PyH8ZzPa6tIENxFxlQuPCTKllHAHlq6qqv7sqUq/TeIr49oFWJutjcnzHCa1AV8cp2w1kd
 ejl3RSJIzbJg7WuPcUiDbiIa/iYdLRixt+/tS450U+SMI43A7lJWfhaPkm+ixdFrZFcLeh
 7QgIvySUw31+s45BTDSzP7f5T8ilFjY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-YHr-GqqvM4qYi62m8KifWQ-1; Sun, 02 Jul 2023 09:24:38 -0400
X-MC-Unique: YHr-GqqvM4qYi62m8KifWQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fbb6675155so17867805e9.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 06:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688304276; x=1690896276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ol4fZ5x/BoF74DuCnyX4MEfQ90CYTeb5DYAd17AMths=;
 b=Uv/twx7LGWMjyXurbZ9JsqzEiSF2hPn0KxN0rpeJHW+cOJnxg/q10BpPacREUEvc+W
 5e5b/J1KU7nrbBFcl4OCRI62vZDvOUiLYoVGHT6UDHvvkUmHX0TfZmsuGNFZcRThUKSF
 ZmT9dlN78h6XyMxAcDHuIGaRWo1cDCFPJU9scpQXcFCr9R+ilc/SAUeLILAB+74446VZ
 9iXIce8rpcWz5xIfzqdc2Vlyv0CF7pzqfW4M9ZJQQRo+GJfK0aApy/L94vn2XTX+JXoA
 p9KDsCNn7jAmYBZWg5IYJhXSx6xcizY2T3lyGXkkPGJzVCm0mV5oqQTR+EZUZn+9wgog
 V9Ag==
X-Gm-Message-State: AC+VfDzIvroOoGBWm78q5tTYfdY1Z9jBlzEsY5hrA4rkDFUJBjbv0ww/
 VQaxwJ/rWbHGZNDJshNrspviRxCanq3O+QGvT64TbHhBk2oqrVhPaidSqjgP54tiAhK3xTHiH0Q
 of/iznEuWmGmj7rI=
X-Received: by 2002:a05:600c:3787:b0:3f9:b2c6:2cd with SMTP id
 o7-20020a05600c378700b003f9b2c602cdmr5352156wmr.15.1688304276268; 
 Sun, 02 Jul 2023 06:24:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5mFVZ41TATqWto34yHOZhFB7+qoYpk49bkn+RX1xJSIXPqk9K+QoNk0e+GdHCxr9eaELcDaQ==
X-Received: by 2002:a05:600c:3787:b0:3f9:b2c6:2cd with SMTP id
 o7-20020a05600c378700b003f9b2c602cdmr5352143wmr.15.1688304275938; 
 Sun, 02 Jul 2023 06:24:35 -0700 (PDT)
Received: from redhat.com ([2.52.134.224]) by smtp.gmail.com with ESMTPSA id
 y17-20020a1c4b11000000b003f9b24cf881sm27080034wma.16.2023.07.02.06.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 06:24:35 -0700 (PDT)
Date: Sun, 2 Jul 2023 09:24:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH v2 1/4] docs: Fix next function numbers in SR/IOV
 documentation
Message-ID: <20230702092412-mutt-send-email-mst@kernel.org>
References: <20230702094631.39111-1-akihiko.odaki@daynix.com>
 <20230702094631.39111-2-akihiko.odaki@daynix.com>
 <20230702064038-mutt-send-email-mst@kernel.org>
 <611d209e-0fd7-5e72-7f25-61fc88ec1a2f@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <611d209e-0fd7-5e72-7f25-61fc88ec1a2f@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Jul 02, 2023 at 08:19:43PM +0900, Akihiko Odaki wrote:
> On 2023/07/02 19:40, Michael S. Tsirkin wrote:
> > On Sun, Jul 02, 2023 at 06:46:25PM +0900, Akihiko Odaki wrote:
> > > The ARI next function number field is undefined for VF so the PF should
> > > end the linked list formed with the field by specifying 0.
> > > 
> > > This also changes the value of the field for VF; it seems to imply the
> > > value has some meaning if it differs from one of the PF, but it doesn't.
> > > 
> > > Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in docs/pcie_sriov.txt")
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > ---
> > >   docs/pcie_sriov.txt | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
> > > index 7eff7f2703..2b7094dc47 100644
> > > --- a/docs/pcie_sriov.txt
> > > +++ b/docs/pcie_sriov.txt
> > > @@ -48,7 +48,7 @@ setting up a BAR for a VF.
> > >         ...
> > >         int ret = pcie_endpoint_cap_init(d, 0x70);
> > >         ...
> > > -      pcie_ari_init(d, 0x100, 1);
> > > +      pcie_ari_init(d, 0x100, 0);
> > >         ...
> > >         /* Add and initialize the SR/IOV capability */
> > > @@ -78,7 +78,7 @@ setting up a BAR for a VF.
> > >         ...
> > >         int ret = pcie_endpoint_cap_init(d, 0x60);
> > >         ...
> > > -      pcie_ari_init(d, 0x100, 1);
> > > +      pcie_ari_init(d, 0x100, 0);
> > >         ...
> > >         memory_region_init(mr, ... )
> > >         pcie_sriov_vf_register_bar(d, bar_nr, mr);
> > 
> > 
> > So now code does not match docs.
> 
> Can you elaborate more?

your new revision addresses this.

-- 
MST



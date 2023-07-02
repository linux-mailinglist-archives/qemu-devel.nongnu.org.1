Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00477744D51
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 12:40:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFuUK-0007iG-8W; Sun, 02 Jul 2023 06:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFuUI-0007hm-Qj
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 06:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFuUH-0001Qn-AH
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 06:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688294364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cPVxm1y8+0THj0EoGx3JPUcjD5lQHxZkUy0xI2875Vw=;
 b=WqXJC2uU2euHhIVGid6yS9yoeLQ3v37SMamgLVrzOFeDtqSNamrLc75A9vXhHTflUch2av
 8Tog7xGLvm/NNbBfpFVuoiZ6uG5fQ7ylTMHijkPaSnkU4yCYlGZl+yorxm2ltmlxTQioYl
 tqJlUC4c8D1XcaGKnXiK8+Plo3fek6M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-S4D_cyaaMEGK3DcZmA6Msg-1; Sun, 02 Jul 2023 06:39:22 -0400
X-MC-Unique: S4D_cyaaMEGK3DcZmA6Msg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fbb6675155so17430955e9.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 03:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688294361; x=1690886361;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cPVxm1y8+0THj0EoGx3JPUcjD5lQHxZkUy0xI2875Vw=;
 b=cN/9MW4x65595O9nuADnDWAPlNrmGRpyEp/ajwpaLGSxBxsGgGrw/gHdETTvODuIUN
 at/UXnSDeRUYS6aWqwNLGAKwftC9CrqeofE353p/NOZrZroqG4iQMYFH42c14w2BfP39
 HQUtkzS1rY4pyeGlVEntR94l4vpsjO4KdzDSqWaRQTAaU+mI+pacbxFd8ahpGJspUz2L
 VBtJJ0XuQRvDOfK7Mgz6sNGIGsGTbRDSeI1fHTmlY/gNA49pZ85hbN1xLCusnXa2OXO8
 mXdpwIN/O2ZQcRXurTTHj9xJ6d2DAwvOvuvkt9mH5JcIeTIXGvlliw0/XttnNuxFpV/1
 knYA==
X-Gm-Message-State: AC+VfDx6ulvdxnBSgyiQr+dFfA0+PRo8W62y2fphuYhwwXO3G/q3OwIO
 7WtAmM0nJmLufXR87kycn18D6nWbmCTnePwmqrCtUC3z2GKtDH5st5d1O6AyUylMfPJOD8hosg+
 hGzXkxnJSFtajIHQ=
X-Received: by 2002:a05:600c:b51:b0:3fb:407e:9b31 with SMTP id
 k17-20020a05600c0b5100b003fb407e9b31mr5267802wmr.37.1688294361523; 
 Sun, 02 Jul 2023 03:39:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5b4PKFvFuAPf2yDXM1wgXX87ywlNLhdWArybweOXqhszQkGNmS2upRww3x3nzLZdoGpRYy+A==
X-Received: by 2002:a05:600c:b51:b0:3fb:407e:9b31 with SMTP id
 k17-20020a05600c0b5100b003fb407e9b31mr5267790wmr.37.1688294361202; 
 Sun, 02 Jul 2023 03:39:21 -0700 (PDT)
Received: from redhat.com ([2.52.134.224]) by smtp.gmail.com with ESMTPSA id
 j19-20020a5d4533000000b0030aded83385sm22852428wra.27.2023.07.02.03.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 03:39:20 -0700 (PDT)
Date: Sun, 2 Jul 2023 06:39:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 3/3] igb: Fix ARI next function numbers
Message-ID: <20230702063501-mutt-send-email-mst@kernel.org>
References: <20230702083357.13517-1-akihiko.odaki@daynix.com>
 <20230702083357.13517-4-akihiko.odaki@daynix.com>
 <20230702045815-mutt-send-email-mst@kernel.org>
 <d0769c54-62f7-6aa8-01b1-0e40cc46e02a@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0769c54-62f7-6aa8-01b1-0e40cc46e02a@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Sun, Jul 02, 2023 at 06:49:50PM +0900, Akihiko Odaki wrote:
> On 2023/07/02 18:00, Michael S. Tsirkin wrote:
> > On Sun, Jul 02, 2023 at 05:33:56PM +0900, Akihiko Odaki wrote:
> > > The ARI next function number field is undefined for VF so the PF should
> > > end the linked list formed with the field by specifying 0.
> > > 
> > > Fixes: 3a977deebe ("Intrdocue igb device emulation")
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > 
> > 
> > I would also change it for the VF just so people don't wonder
> > what's the magic value. Do document in commit log though.
> > 
> > Maybe just drop this parameter from pcie_ari_init completely
> > for now?
> 
> I sent v2, but it doesn't change the field for VFs either to save code for
> migration. The parameter for pcie_ari_init() also remains to migrate from
> older versions.

For migration, stick the boolean in PCIDevice::cap_present. Use QEMU_PCIE_ERR_UNC_MASK_BITNR as
a template.


> > 
> > 
> > > ---
> > >   hw/net/igb.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/net/igb.c b/hw/net/igb.c
> > > index 1c989d7677..897386fc09 100644
> > > --- a/hw/net/igb.c
> > > +++ b/hw/net/igb.c
> > > @@ -431,7 +431,7 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
> > >           hw_error("Failed to initialize AER capability");
> > >       }
> > > -    pcie_ari_init(pci_dev, 0x150, 1);
> > > +    pcie_ari_init(pci_dev, 0x150, 0);
> > >       pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
> > >           IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
> > > -- 
> > > 2.41.0
> > 



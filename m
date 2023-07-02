Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 549F5744CC7
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 10:41:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFsdW-0003ew-4C; Sun, 02 Jul 2023 04:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFsdT-0003eF-2k
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFsdR-0004Id-Ep
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 04:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688287243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ug+SqhjlMrXmCFh6P9sleTi0nK7GNr0zGrxTwvpcE10=;
 b=ihPd2zRPsAuPgftKWYlIa7kwyj4EyGp25B/eAUmS9MmmHdJqt1JEyyXRQOebJOg1Ee/xjC
 GrMsS4x+HbO2ykPs9HbgLoAtvLLkyrct8ficK4daZIRPXNYdK/+vq429nvzfSer4ZkZ9vy
 pm4oNa5rsIyX6KdCrYec0IURpeTZns0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-FREShxqPMxiLP78Vk8fBhw-1; Sun, 02 Jul 2023 04:40:42 -0400
X-MC-Unique: FREShxqPMxiLP78Vk8fBhw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so17090145e9.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 01:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688287241; x=1690879241;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ug+SqhjlMrXmCFh6P9sleTi0nK7GNr0zGrxTwvpcE10=;
 b=RsxiUJqm2aRyAD/z1grsNOnhxKn48XfI5mOyJxDI/F4a/TyuiDsFinszysP7AW4Kqt
 O4dXo+Gr+1ArivR1Jnt3XYNICM6i/12zLoKRGD33Eylr6Q8BaSZITj1+aywdPvPJc2Xu
 VovJgdP5FxqohS+GonLG/ooyla0R618MtN05gp8dNO9dEU70sal8RRxxynRDvPottHRv
 Y5V9OzOjw+yPIxuGbDQXcFfo/9a+M7NVuWN1Q1RxjpiwkEL3FS/D58744r+GMiiBlNPU
 rWqlDiWeRwWE8oGS4Xk0bI+0MwvyaU1fdyNFBc8O0zVgRw3EMGmVmERAJybRdJZRYseb
 WfPw==
X-Gm-Message-State: AC+VfDwC8/ARjQOVvhYvvS2GDQMiTlI3sh734meD4OvGtZLY++WcUU7A
 8fyItMxOvOx36cRDLUGKyA7uAsr6FO1KjvBiYSK5NyOOUbMTC88m/C9Hub2VaFb4zn52SCFlPe0
 KzpiilYPWdrLNINE=
X-Received: by 2002:a7b:c393:0:b0:3fb:403d:90c0 with SMTP id
 s19-20020a7bc393000000b003fb403d90c0mr4728106wmj.39.1688287241394; 
 Sun, 02 Jul 2023 01:40:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7XH9eh48cfdFf+97rS41GP0UUbVx2J3YGt1vZv1ZheEOSW2+oIQhms4RuBV/6VsaBGDVjZ9Q==
X-Received: by 2002:a7b:c393:0:b0:3fb:403d:90c0 with SMTP id
 s19-20020a7bc393000000b003fb403d90c0mr4728091wmj.39.1688287241112; 
 Sun, 02 Jul 2023 01:40:41 -0700 (PDT)
Received: from redhat.com ([2.52.134.224]) by smtp.gmail.com with ESMTPSA id
 g14-20020a7bc4ce000000b003fbaf9abf2fsm12108788wmk.23.2023.07.02.01.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 01:40:40 -0700 (PDT)
Date: Sun, 2 Jul 2023 04:40:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>
Subject: Re: [PATCH 3/4] igb: Fix ARI next function numbers
Message-ID: <20230702043919-mutt-send-email-mst@kernel.org>
References: <20230701070133.24877-1-akihiko.odaki@daynix.com>
 <20230701070133.24877-4-akihiko.odaki@daynix.com>
 <20230702010041-mutt-send-email-mst@kernel.org>
 <ff06355e-bfd6-7574-e42c-ecfd6939e7aa@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff06355e-bfd6-7574-e42c-ecfd6939e7aa@daynix.com>
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

On Sun, Jul 02, 2023 at 05:38:42PM +0900, Akihiko Odaki wrote:
> On 2023/07/02 14:05, Michael S. Tsirkin wrote:
> > On Sat, Jul 01, 2023 at 04:01:21PM +0900, Akihiko Odaki wrote:
> > > The next function numbers are expected to form a linked list ending with
> > > 0.
> > > 
> > > Fixes: 3a977deebe ("Intrdocue igb device emulation")
> > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > ---
> > >   hw/net/igb_core.h | 3 +++
> > >   hw/net/igb.c      | 4 +---
> > >   hw/net/igbvf.c    | 5 ++++-
> > >   3 files changed, 8 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/hw/net/igb_core.h b/hw/net/igb_core.h
> > > index 9cbbfd516b..e1dab76995 100644
> > > --- a/hw/net/igb_core.h
> > > +++ b/hw/net/igb_core.h
> > > @@ -49,6 +49,9 @@
> > >   #define IGB_NUM_QUEUES          (16)
> > >   #define IGB_NUM_VM_POOLS        (8)
> > > +#define IGB_VF_OFFSET           (0x80)
> > > +#define IGB_VF_STRIDE           (2)
> > > +
> > >   typedef struct IGBCore IGBCore;
> > >   enum { PHY_R = BIT(0),
> > > diff --git a/hw/net/igb.c b/hw/net/igb.c
> > > index 1c989d7677..543ca0114a 100644
> > > --- a/hw/net/igb.c
> > > +++ b/hw/net/igb.c
> > > @@ -81,8 +81,6 @@ struct IGBState {
> > >   };
> > >   #define IGB_CAP_SRIOV_OFFSET    (0x160)
> > > -#define IGB_VF_OFFSET           (0x80)
> > > -#define IGB_VF_STRIDE           (2)
> > >   #define E1000E_MMIO_IDX     0
> > >   #define E1000E_FLASH_IDX    1
> > > @@ -431,7 +429,7 @@ static void igb_pci_realize(PCIDevice *pci_dev, Error **errp)
> > >           hw_error("Failed to initialize AER capability");
> > >       }
> > > -    pcie_ari_init(pci_dev, 0x150, 1);
> > > +    pcie_ari_init(pci_dev, 0x150, IGB_VF_OFFSET);
> > >       pcie_sriov_pf_init(pci_dev, IGB_CAP_SRIOV_OFFSET, TYPE_IGBVF,
> > >           IGB_82576_VF_DEV_ID, IGB_MAX_VF_FUNCTIONS, IGB_MAX_VF_FUNCTIONS,
> > 
> > 
> > I think this change would break migrations from 8.0. No?
> 
> Well, I don't have a reason to concern more for this change than other bug
> fixes with behavioral changes observable from the guest.

Try it and see it fail.


> > 
> > 
> > More importantly your commit log says linked list should end
> > with 0, but you make it point at a VF instead.
> > 
> > 
> > > diff --git a/hw/net/igbvf.c b/hw/net/igbvf.c
> > > index 284ea61184..bf2f237ab5 100644
> > > --- a/hw/net/igbvf.c
> > > +++ b/hw/net/igbvf.c
> > > @@ -240,6 +240,9 @@ static const MemoryRegionOps mmio_ops = {
> > >   static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
> > >   {
> > >       IgbVfState *s = IGBVF(dev);
> > > +    uint16_t nextvfn = pcie_sriov_vf_number(dev) + 1;
> > > +    uint16_t nextfn = nextvfn < IGB_MAX_VF_FUNCTIONS ?
> > > +                      IGB_VF_OFFSET + nextvfn * IGB_VF_STRIDE : 0;
> > >       int ret;
> > >       int i;
> > > @@ -270,7 +273,7 @@ static void igbvf_pci_realize(PCIDevice *dev, Error **errp)
> > >           hw_error("Failed to initialize AER capability");
> > >       }
> > > -    pcie_ari_init(dev, 0x150, 1);
> > > +    pcie_ari_init(dev, 0x150, nextfn);
> > 
> > 
> > 
> > For this one I don't see why it matters at all:
> > 
> > The presence of Shadow Functions does not affect this field.
> > For VFs, this field is undefined since VFs are located using First VF Offset (see § Section 9.3.3.9 ) and VF
> > Stride (see § Section 9.3.3.10 ).
> 
> I missed the statements saying the field is undefined for VFs. I posted an
> alternative series ("[PATCH 0/3] pci: Fix ARI next function numbers") so
> please review it.
> 
> > 
> > 
> > 
> > 
> > >   }
> > >   static void igbvf_pci_uninit(PCIDevice *dev)
> > > -- 
> > > 2.41.0
> > 



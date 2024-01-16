Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A4F82E7E8
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 03:22:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPZ4C-0004gA-Gx; Mon, 15 Jan 2024 21:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPZ48-0004fn-Jq
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 21:20:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPZ46-0001oL-KF
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 21:20:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705371633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hxA3S9QCMmBXI9Wo/nIxTQsp7CyA//CHDyZy95gcxSU=;
 b=FzZxYDEC57XkNxaMShr6XSVFxARqXp/hOVAqytxr76li/6PFjTwvHrx6p3vGtIpZyfQWYB
 ks0fi6nnpLh4UA2JdAbTogl1fLKOSnSq+2oraqJu8gF0dbrx8jxEn42fSW3m/x87CGfcy7
 +k3J4I5usR9xIIebEF3VvBXyjbb4jPY=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-ie5tlJqCNvy-LpyhiCUJ9Q-1; Mon, 15 Jan 2024 21:20:31 -0500
X-MC-Unique: ie5tlJqCNvy-LpyhiCUJ9Q-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-598d67da1c2so2819374eaf.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 18:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705371631; x=1705976431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hxA3S9QCMmBXI9Wo/nIxTQsp7CyA//CHDyZy95gcxSU=;
 b=dC8Xd3thNN5BfncwGkznbWQtwZlexLaZ6dxFQ+WctjUydOH8g1e567WEtVyLO8GIei
 sV3TIgafRgfQzFIChyuzZJv5jakn0l8IIbFda+2NmJe9+xafzbT284+QPJwFk9Tvx8yq
 pnuAyTqGSOEqW27WOwKbbGQmixessmlwTeR4tdVcr5U+tDsjkTTM5MJPzPeI6JVWdqAi
 La7QZHHXO56ERlAKUrfpzSBIgX1W9mHGhPq1BgSlxcnlLkq7E4nMO1+gYwYiZW9duEoN
 ohpqFcnAbwXUjTjKMj9MwQlJ9vD0aL0Cnce7yPAO3evgtddbO2LkRE1EvLrdswO1+E5a
 l94w==
X-Gm-Message-State: AOJu0YwnbMs5K6/nMRH2PNFgm1dAuGUaY6kJK+V3IRnmkWZv8ZYSlKR3
 B1zi4Xj8/eUQ578LD5WX37vLRgnDQtSnO7fD/eph4emaJwuGma85WO4rkHIc+TyUkkeueHEs4YL
 ZJitLvHt9DwSDhYGRSQiH4MJNhe+Kn5wFiHGu120=
X-Received: by 2002:a05:6359:2c95:b0:175:4953:4637 with SMTP id
 qw21-20020a0563592c9500b0017549534637mr3044848rwb.50.1705371630827; 
 Mon, 15 Jan 2024 18:20:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGad/IV9tzOYN/CTeuFLWqQhlC2AmDQyuKcBnEc6C57jtlBO9eR9ym3nzRFuCiGw+T+R8CVVADHPHMiglwtRfU=
X-Received: by 2002:a05:6359:2c95:b0:175:4953:4637 with SMTP id
 qw21-20020a0563592c9500b0017549534637mr3044842rwb.50.1705371630471; Mon, 15
 Jan 2024 18:20:30 -0800 (PST)
MIME-Version: 1.0
References: <SN4PR13MB5727A538887598415C5A37D28681A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB5727D7B4E7CC91345135A5058661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEvwanHfheCMo-gDjzx1DrX51AMtoaYJ9PcE0yYmZdA+Uw@mail.gmail.com>
 <SN4PR13MB5727A90B141E383127F1E25D8661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB572773EF8D25A2E2C5AE48608661A@SN4PR13MB5727.namprd13.prod.outlook.com>
 <SN4PR13MB57274870E6BBFC76749E8D96866F2@SN4PR13MB5727.namprd13.prod.outlook.com>
 <CACGkMEu6X2L-eawwsy_pE1mVVDU7V=Qe_51YrK16W-kKu4BGxA@mail.gmail.com>
 <SN4PR13MB572738F10FAE449DDBD735D686732@SN4PR13MB5727.namprd13.prod.outlook.com>
In-Reply-To: <SN4PR13MB572738F10FAE449DDBD735D686732@SN4PR13MB5727.namprd13.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 Jan 2024 10:20:19 +0800
Message-ID: <CACGkMEtHQHmhBAF6WguUSHr+iFMmOjvTshqpGzkvE=QtkgVVPA@mail.gmail.com>
Subject: Re: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
 VIRTIO_F_NOTIFICATION_DATA feature
To: Wentao Jia <wentao.jia@nephogine.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, 
 Rick Zhong <zhaoyong.zhong@nephogine.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

On Tue, Jan 16, 2024 at 9:57=E2=80=AFAM Wentao Jia <wentao.jia@nephogine.co=
m> wrote:
>
> Hi, Jason
>
> I just add two features in vhost user feature bits, The patch was tested =
in my environment
> I do not know what the compatibility mean

For example, if you don't do that,

Migrating from 9.0 to 8.2 will break as 8.2 doesn't have those new
features at all.

Please refer hw_compat_8_2.

Thanks

>
> Wentao
>
> -----Original Message-----
> From: Jason Wang <jasowang@redhat.com>
> Sent: Monday, January 15, 2024 8:18 AM
> To: Wentao Jia <wentao.jia@nephogine.com>
> Cc: qemu-devel@nongnu.org; mst@redhat.com; Rick Zhong <zhaoyong.zhong@nep=
hogine.com>
> Subject: Re: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and VIRTIO_F_N=
OTIFICATION_DATA feature
>
> On Fri, Jan 12, 2024 at 4:18=E2=80=AFPM Wentao Jia <wentao.jia@nephogine.=
com> wrote:
> >
> > Hi, Michael and Jason
> >
> > Do you have any other comments?
> > Is there a schedule for merge the patch into the community?
> > Thank you
>
> I think as discussed, we need to add compatibility support for those feat=
ures.
>
> Thanks
>
> >
> > Wentao
> >
> > -----Original Message-----
> > From: Wentao Jia
> > Sent: Tuesday, January 2, 2024 1:57 PM
> > To: qemu-devel@nongnu.org
> > Cc: 'mst@redhat.com' <mst@redhat.com>; Rick Zhong
> > <zhaoyong.zhong@nephogine.com>; 'Jason Wang' <jasowang@redhat.com>
> > Subject: RE: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
> > VIRTIO_F_NOTIFICATION_DATA feature
> >
> >
> > ---
> >  hw/net/vhost_net.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c index
> > e8e1661646..211ca859a6 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -76,6 +76,8 @@ static const int user_feature_bits[] =3D {
> >      VIRTIO_F_IOMMU_PLATFORM,
> >      VIRTIO_F_RING_PACKED,
> >      VIRTIO_F_RING_RESET,
> > +    VIRTIO_F_IN_ORDER,
> > +    VIRTIO_F_NOTIFICATION_DATA,
> >      VIRTIO_NET_F_RSS,
> >      VIRTIO_NET_F_HASH_REPORT,
> >      VIRTIO_NET_F_GUEST_USO4,
> > --
> >
> > -----Original Message-----
> > From: Wentao Jia
> > Sent: Tuesday, January 2, 2024 1:38 PM
> > To: Jason Wang <jasowang@redhat.com>
> > Cc: mst@redhat.com; Rick Zhong <zhaoyong.zhong@nephogine.com>
> > Subject: RE: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
> > VIRTIO_F_NOTIFICATION_DATA feature
> >
> > Hi, Jason
> >
> > It is good just change feature bits, I will commit a new patch, thanks
> >
> > Wentao Jia
> >
> > -----Original Message-----
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Tuesday, January 2, 2024 11:24 AM
> > To: Wentao Jia <wentao.jia@nephogine.com>
> > Cc: mst@redhat.com; Rick Zhong <zhaoyong.zhong@nephogine.com>
> > Subject: Re: FW: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
> > VIRTIO_F_NOTIFICATION_DATA feature
> >
> > On Tue, Jan 2, 2024 at 10:26=E2=80=AFAM Wentao Jia <wentao.jia@nephogin=
e.com> wrote:
> > >
> > > Hi, Michael  and Jason
> > >
> > >
> > >
> > > please review the patch at your convenience, thank you
> > >
> > > vhost-user: add VIRTIO_F_IN_ORDER and VIRTIO_F_NOTIFICATION_DATA
> > > feature - Patchwork (kernel.org)
> > >
> > >
> > >
> > > Wentao Jia
> > >
> > >
> > >
> > > From: Wentao Jia
> > > Sent: Friday, December 1, 2023 6:11 PM
> > > To: qemu-devel@nongnu.org
> > > Subject: [PATCH] vhost-user: add VIRTIO_F_IN_ORDER and
> > > VIRTIO_F_NOTIFICATION_DATA feature
> > >
> > >
> > >
> > > VIRTIO_F_IN_ORDER and VIRTIO_F_NOTIFICATION_DATA feature are
> > > important feature
> > >
> > > for dpdk vdpa packets transmitting performance, add the 2 features
> > > at vhost-user
> > >
> > > front-end to negotiation with backend.
> > >
> > >
> > >
> > > Signed-off-by: Kyle Xu zhenbing.xu@corigine.com
> > >
> > > Signed-off-by: Wentao Jia wentao.jia@corigine.com
> > >
> > > Reviewed-by:   Xinying Yu xinying.yu@corigine.com
> > >
> > > Reviewed-by:   Shujing Dong shujing.dong@corigine.com
> > >
> > > Reviewed-by:   Rick Zhong zhaoyong.zhong@corigine.com
> > >
> > > ---
> > >
> > > hw/net/vhost_net.c         | 2 ++
> > >
> > > include/hw/virtio/virtio.h | 4 ++++
> > >
> > > 2 files changed, 6 insertions(+)
> > >
> > >
> > >
> > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > >
> > > index e8e1661646..211ca859a6 100644
> > >
> > > --- a/hw/net/vhost_net.c
> > >
> > > +++ b/hw/net/vhost_net.c
> > >
> > > @@ -76,6 +76,8 @@ static const int user_feature_bits[] =3D {
> > >
> > >      VIRTIO_F_IOMMU_PLATFORM,
> > >
> > >      VIRTIO_F_RING_PACKED,
> > >
> > >      VIRTIO_F_RING_RESET,
> > >
> > > +    VIRTIO_F_IN_ORDER,
> > >
> > > +    VIRTIO_F_NOTIFICATION_DATA,
> > >
> > >      VIRTIO_NET_F_RSS,
> > >
> > >      VIRTIO_NET_F_HASH_REPORT,
> > >
> > >      VIRTIO_NET_F_GUEST_USO4,
> > >
> > > diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> > >
> > > index c8f72850bc..3880b6764c 100644
> > >
> > > --- a/include/hw/virtio/virtio.h
> > >
> > > +++ b/include/hw/virtio/virtio.h
> > >
> > > @@ -369,6 +369,10 @@ typedef struct VirtIORNGConf VirtIORNGConf;
> > >
> > >                        VIRTIO_F_RING_PACKED, false), \
> > >
> > >      DEFINE_PROP_BIT64("queue_reset", _state, _field, \
> > >
> > >                        VIRTIO_F_RING_RESET, true)
> > >
> > > +    DEFINE_PROP_BIT64("notification_data", _state, _field, \
> > >
> > > +                      VIRTIO_F_NOTIFICATION_DATA, true), \
> > >
> > > +    DEFINE_PROP_BIT64("in_order", _state, _field, \
> > >
> > > +                      VIRTIO_F_IN_ORDER, true)
> >
> > Do we want compatibility support for those?
> >
> > Thanks
> >
> > >
> > >
> > >
> > > hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
> > >
> > > bool virtio_queue_enabled_legacy(VirtIODevice *vdev, int n);
> > >
> > > --
> >
>



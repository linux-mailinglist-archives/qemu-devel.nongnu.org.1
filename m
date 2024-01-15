Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3011682D330
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 03:53:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPD5J-000206-EF; Sun, 14 Jan 2024 21:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPD5G-0001zf-Va
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 21:52:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPD5F-00086w-73
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 21:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705287136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QzAe6cZFSU1ZpMPBJ95UsYKXc2cUukA0JFyF99mevrk=;
 b=R9U3moPDN+mY2dZRXYwZ/MiwY1U0iYsx9RrZ8iA4Tq0OkltODZdB0OgHPWzBWQAdXoTxuJ
 yK6xIsp/25D+pVArjniwXBoQ4s71c0Hw6p2JQ3zYph9cBKeQZ+ySF5hcT+Q6YWYop5RAw4
 8i1VNDey6CbzEuBzNZ0+huwZ4l6rbs4=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-T0MteWNuPISuutxk-NFTOQ-1; Sun, 14 Jan 2024 21:52:14 -0500
X-MC-Unique: T0MteWNuPISuutxk-NFTOQ-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6ddeebf1e23so6991083a34.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 18:52:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705287134; x=1705891934;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QzAe6cZFSU1ZpMPBJ95UsYKXc2cUukA0JFyF99mevrk=;
 b=m54RTRgDDeQcRVB+n4IqK+Ea9TZqPNjeZ/8Y+5GBVJxkBbdWOJ3i5+dc9NXPRcfu+R
 zbY3bwNRo2IEbbN98uZPk94nmAsFtg/Fzbn9FUmq9odBg72v0kTr2lRL0SdER2/Emv1R
 lGOfNasPwYAu6kFxOraXRHDjs/ERiDqN5d+s7hmunK97+v0T9bgGcUeVZfQU6FwGWmjY
 AXwnfML4GI3oiwAWMdCHqOFkd/Wkw+SU49qZ/d6GZmHBo9sjFSorA4OzUeUM9DTPCqeo
 EtBjIvlfFadqubU5eXCT3uV5jnH5Q2J53EIqq187in3BP2mcAXNRZ1kcJW2mMOOCZyX3
 DT2Q==
X-Gm-Message-State: AOJu0Yy/LBRMU+7fJy0mUbb3bFmkO/vMylU62b02uQmdKJSldDwtskyj
 RssQytc6jgI5XSsedXb5/9x7UcSfzkPIJT3TwyTtBXJ31ichncJfQAc9Il5P0AbwZL9B6u9s1ig
 6D4Ym19vcIznUD/eX3zomYdv/4H61rtlsVaNJrl8=
X-Received: by 2002:a05:6830:4b:b0:6dd:e93e:595c with SMTP id
 d11-20020a056830004b00b006dde93e595cmr5665171otp.75.1705287134160; 
 Sun, 14 Jan 2024 18:52:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFNGolWOyispK+2n73y5SA21w0Dso8zmSSt81M9ZzY3U+MTpAWTrXOEYdVXePo25rtLhQtI1e2vp1OW7snHmxo=
X-Received: by 2002:a05:6830:4b:b0:6dd:e93e:595c with SMTP id
 d11-20020a056830004b00b006dde93e595cmr5665166otp.75.1705287133976; Sun, 14
 Jan 2024 18:52:13 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-22-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEtn3L7YJwo7Zn6U-6dmgrt98B814S6mDYSUw75+87naeg@mail.gmail.com>
In-Reply-To: <CACGkMEtn3L7YJwo7Zn6U-6dmgrt98B814S6mDYSUw75+87naeg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 10:52:03 +0800
Message-ID: <CACGkMEuKy6s7obZtF4a9ni9w2kiugWaGXQEmEqtGACAKGNrFgQ@mail.gmail.com>
Subject: Re: [PATCH 21/40] vdpa: vhost_vdpa_dma_batch_end_once rename
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jan 15, 2024 at 10:40=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
> On Fri, Dec 8, 2023 at 2:51=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com>=
 wrote:
> >
> > No functional changes. Rename only.
> >
> > Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > ---
> >  hw/virtio/vhost-vdpa.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> > index 47c764b..013bfa2 100644
> > --- a/hw/virtio/vhost-vdpa.c
> > +++ b/hw/virtio/vhost-vdpa.c
> > @@ -191,7 +191,7 @@ static void vhost_vdpa_iotlb_batch_begin_once(Vhost=
VDPAShared *s)
> >      s->iotlb_batch_begin_sent =3D true;
> >  }
> >
> > -static void vhost_vdpa_dma_end_batch(VhostVDPAShared *s)
> > +static void vhost_vdpa_dma_batch_end_once(VhostVDPAShared *s)
> >  {
> >      struct vhost_msg_v2 msg =3D {};
> >      int fd =3D s->device_fd;
> > @@ -229,7 +229,7 @@ static void vhost_vdpa_listener_commit(MemoryListen=
er *listener)
> >  {
> >      VhostVDPAShared *s =3D container_of(listener, VhostVDPAShared, lis=
tener);
> >
> > -    vhost_vdpa_dma_end_batch(s);
> > +    vhost_vdpa_dma_batch_end_once(s);
> >  }
> >
> >  static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntr=
y *iotlb)
> > @@ -1367,7 +1367,7 @@ static void *vhost_vdpa_load_map(void *opaque)
> >              vhost_vdpa_iotlb_batch_begin_once(shared);
> >              break;
> >          case VHOST_IOTLB_BATCH_END:
> > -            vhost_vdpa_dma_end_batch(shared);
> > +            vhost_vdpa_dma_batch_end_once(shared);
>
> It's better to explain why having a "_once" suffix is better here.

Ok, if it's for symmetry for host_vdpa_iotlb_batch_begin_once(), I
think it makes sense.

But it's better to document this in the change log.

Thanks

>
> Thanks
>
> >              break;
> >          default:
> >              error_report("Invalid IOTLB msg type %d", msg->iotlb.type)=
;
> > --
> > 1.8.3.1
> >



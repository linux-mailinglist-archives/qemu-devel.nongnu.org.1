Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A7E76A7AC
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 05:50:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQgNO-0000q5-2X; Mon, 31 Jul 2023 23:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qQgNM-0000pv-Up
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 23:48:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qQgNK-0002h2-9s
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 23:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690861724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l6N2IJOfFadEDXVYnDqLNO+R0zEGdaV5ZOsCLwgMLO8=;
 b=PzLjJ/yI8DsO8+EaoqLBYZ+YBfnt80yPmjmSv2OGEYkKUi8o0dyJIdcbvpH0Au66y4rcoT
 MNZFPdg9UcelEfWcyITtDWDczv/MUpTdDS1FvNuX25xzLiEQGCB1L65RDUWTMFiDjuy9bC
 BM7KLaOITkBW9PSAROAFsMA19tRuU7k=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-9iY6n2jEOoSIEyd6M3ti9Q-1; Mon, 31 Jul 2023 23:48:41 -0400
X-MC-Unique: 9iY6n2jEOoSIEyd6M3ti9Q-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9bb2d0b47so46039581fa.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 20:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690861720; x=1691466520;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l6N2IJOfFadEDXVYnDqLNO+R0zEGdaV5ZOsCLwgMLO8=;
 b=Ol9Kc4BvlXMVYjCOBUVZm3Em6oe8SIURQoNvdAG2VPZoX/nLq1H11VCtdxmkUqY2+a
 VmtkN4qnTv8CFHzxREMrUvCrQ7dcBF37czSnJ287XrpWKN2qRx1tX+dN+fejrd9W6SRL
 PQcLfiJ4OG7oH+/vvg5NJzFXxEfUKJMaSpebgU9SnIku0UcfX0U8u/xyA3tKIw55Gtbw
 GzBxz5uWzbXLrbR82bWaMB7pAbHt63TAh4f0UfSaAPo1bnXWlArdqF9PC0umj/+9cs/A
 gxVtJ7Hw1GtcYtQ/ixEad6Cbjq/jxLR4ObeSKELa1h47zn/ALR+scsQeeGsij2AUk0Bh
 4USw==
X-Gm-Message-State: ABy/qLbpKVb2PkIHURHWqsiU1E+csH0bvXef/QIzFVmQmcbCTgAmzbN8
 iJjxBHMpkVLm4DvEKo0NCEL0xgla546rc058WALUIjxASHL+OO09Ahw/AcVtAQvoumMOF6m5xh2
 N9TqOboN9rcFqmOLWCRAUN4VN1jdsZu8=
X-Received: by 2002:a2e:a0c6:0:b0:2b6:e958:5700 with SMTP id
 f6-20020a2ea0c6000000b002b6e9585700mr1348001ljm.4.1690861720026; 
 Mon, 31 Jul 2023 20:48:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFdzFA18COa2CBA9kZmZCayXQwtkinq7BqKvUN1byUpjrGL7WAfoJ3cNfSNDPdPg7yv8n4eUc5tr0Hfmaq6btY=
X-Received: by 2002:a2e:a0c6:0:b0:2b6:e958:5700 with SMTP id
 f6-20020a2ea0c6000000b002b6e9585700mr1347994ljm.4.1690861719720; Mon, 31 Jul
 2023 20:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230728172028.2074052-1-eperezma@redhat.com>
 <CACGkMEsPRp5ieCXyVDu0z0xynATL8eeY5Dtb8QNPo7f2Gde=ww@mail.gmail.com>
 <CAJaqyWccXD1PcA=jV59LCkxzCbnvghtPrk_ShFscdDXe1Aj4uQ@mail.gmail.com>
In-Reply-To: <CAJaqyWccXD1PcA=jV59LCkxzCbnvghtPrk_ShFscdDXe1Aj4uQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 1 Aug 2023 11:48:28 +0800
Message-ID: <CACGkMEsNVOajUObv_5Stnn4wtQtSdLNcxVqiB7_6xAnN1OSjQQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Enable vdpa net migration with features depending on
 CVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Gautam Dawar <gdawar@xilinx.com>,
 si-wei.liu@oracle.com, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Parav Pandit <parav@mellanox.com>, Cindy Lu <lulu@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 Shannon Nelson <snelson@pensando.io>, Lei Yang <leiyang@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
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

On Mon, Jul 31, 2023 at 6:15=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Jul 31, 2023 at 8:41=E2=80=AFAM Jason Wang <jasowang@redhat.com> =
wrote:
> >
> > On Sat, Jul 29, 2023 at 1:20=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@re=
dhat.com> wrote:
> > >
> > > At this moment the migration of net features that depends on CVQ is n=
ot
> > > possible, as there is no reliable way to restore the device state lik=
e mac
> > > address, number of enabled queues, etc to the destination.  This is m=
ainly
> > > caused because the device must only read CVQ, and process all the com=
mands
> > > before resuming the dataplane.
> > >
> > > This series lift that requirement, sending the VHOST_VDPA_SET_VRING_E=
NABLE
> > > ioctl for dataplane vqs only after the device has processed all comma=
nds.
> >
> > I think it's better to explain (that is what I don't understand) why
> > we can not simply reorder vhost_net_start_one() in vhost_net_start()?
> >
> >     for (i =3D 0; i < nvhosts; i++) {
> >         if (i < data_queue_pairs) {
> >             peer =3D qemu_get_peer(ncs, i);
> >         } else {
> >             peer =3D qemu_get_peer(ncs, n->max_queue_pairs);
> >         }
> >
> >         if (peer->vring_enable) {
> >             /* restore vring enable state */
> >             r =3D vhost_set_vring_enable(peer, peer->vring_enable);
> >
> >             if (r < 0) {
> >                 goto err_start;
> >             }
> >         }
> >
> > =3D>      r =3D vhost_net_start_one(get_vhost_net(peer), dev);
> >         if (r < 0) {
> >             goto err_start;
> >         }
> >     }
> >
> > Can we simply start cvq first here?
> >
>
> Well the current order is:
> * set dev features (conditioned by
> * Configure all vq addresses
> * Configure all vq size
> ...
> * Enable cvq
> * DRIVER_OK
> * Enable all the rest of the queues.
>
> If we just start CVQ first, we need to modify vhost_vdpa_set_features
> as minimum. A lot of code that depends on vdev->vq_index{,_end} may be
> affected.
>
> Also, I'm not sure if all the devices will support configure address,
> vq size, etc after DRIVER_OK.

Ok, so basically what I meant is to seek a way to refactor
vhost_net_start() instead of introducing new ops (e.g introducing
virtio ops in vhost seems a layer violation anyhow).

Can we simply factor VRING_ENABLE out and then we can enable vring in
any order as we want in vhost_net_start()?

Thanks

>
> > Thanks
> >
> > > ---
> > > From FRC:
> > > * Enable vqs early in case CVQ cannot be shadowed.
> > >
> > > Eugenio P=C3=A9rez (7):
> > >   vdpa: export vhost_vdpa_set_vring_ready
> > >   vdpa: add should_enable op
> > >   vdpa: use virtio_ops->should_enable at vhost_vdpa_set_vrings_ready
> > >   vdpa: add stub vhost_vdpa_should_enable
> > >   vdpa: delay enable of data vqs
> > >   vdpa: enable cvq svq if data vq are shadowed
> > >   vdpa: remove net cvq migration blocker
> > >
> > >  include/hw/virtio/vhost-vdpa.h |  9 +++++
> > >  hw/virtio/vhost-vdpa.c         | 33 ++++++++++++----
> > >  net/vhost-vdpa.c               | 69 ++++++++++++++++++++++++++------=
--
> > >  hw/virtio/trace-events         |  2 +-
> > >  4 files changed, 89 insertions(+), 24 deletions(-)
> > >
> > > --
> > > 2.39.3
> > >
> > >
> >
>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE12E7692E2
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 12:17:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQPwW-0004Xq-Mc; Mon, 31 Jul 2023 06:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qQPwM-0004XQ-Na
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qQPwK-00058Y-Tk
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690798547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2op9uT+D64YwC/WB7rjKWmmlh8/31Sr0Yo7KKu8TK2w=;
 b=RpnMOj4n3N+XYn4dftyVIZxs8bhcDRMHCqf7LaPsKKyX5dfgHnuBC1hMhFXAHxEmCmomYu
 GHeqXf21sPWxmPhn/onA4y5dOcJL4ENZkEFeU98j48kPKM3D6y0cfpPgJ33M57wqhehGPM
 dyYQjwBO9XvWHh9lrheN4vnJvRRhThk=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-T5mMAVeSMWOu6vyb5xv3Gw-1; Mon, 31 Jul 2023 06:15:46 -0400
X-MC-Unique: T5mMAVeSMWOu6vyb5xv3Gw-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-4475debcebfso731404137.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 03:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690798546; x=1691403346;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2op9uT+D64YwC/WB7rjKWmmlh8/31Sr0Yo7KKu8TK2w=;
 b=RcXUAKXYSVvcWoT+Fxb/KHHFnpIYawwnBluX5jwuSnIbqKAPFfb32TotfWKlWXc32l
 k0bDhm9j8lLa9enESQ/iSDIy76vq0L00Fyqa5qfnJM1xxon0zlVQb0hB1qdVY66PTt2B
 VqsebB5g7r2pN/AJf1DYd+VRgv7panNFk7DlTOFNmUyMdoybQqvs0cCyh0+vgR0bIPDt
 2wHYjYgYB0G1jeo36iw5VqPr9medmz4tL0EqRs6VDscjYWXQUqkEPwfeYzLcbXgWGcym
 PjdO4eBvw6+vN2tB5EgRcqRuzbtaj3mY/ag7++70tUcaOtCzR5bM0SUOytTrDhc5/EL7
 4spg==
X-Gm-Message-State: ABy/qLZPjHlKZsaF5mIqc6kWhKKLSso3gegChGBSi0xnhg+lcRZIrwUi
 CQPaYHVXUHd8MUEgEJVh0ZGcOnUjS/IPllqgb1oHHZ7TkO+ZKZq9eGuBsmvlyaV2WOt9fkcOxf/
 xeXSYHC6fmqzWCCrTuDYJKherDo1roG8=
X-Received: by 2002:a67:e90a:0:b0:447:7cb1:3148 with SMTP id
 c10-20020a67e90a000000b004477cb13148mr1840727vso.33.1690798545609; 
 Mon, 31 Jul 2023 03:15:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGURdqy3aAtCWZzsh86XSQmBmVx9dW5T0KYauK3FigVUtjvg4G/ipzFUnIzc8wAlWybgHr9BJy8mQhGP9+NuAY=
X-Received: by 2002:a67:e90a:0:b0:447:7cb1:3148 with SMTP id
 c10-20020a67e90a000000b004477cb13148mr1840712vso.33.1690798545124; Mon, 31
 Jul 2023 03:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230728172028.2074052-1-eperezma@redhat.com>
 <CACGkMEsPRp5ieCXyVDu0z0xynATL8eeY5Dtb8QNPo7f2Gde=ww@mail.gmail.com>
In-Reply-To: <CACGkMEsPRp5ieCXyVDu0z0xynATL8eeY5Dtb8QNPo7f2Gde=ww@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 31 Jul 2023 12:15:08 +0200
Message-ID: <CAJaqyWccXD1PcA=jV59LCkxzCbnvghtPrk_ShFscdDXe1Aj4uQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Enable vdpa net migration with features depending on
 CVQ
To: Jason Wang <jasowang@redhat.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
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

On Mon, Jul 31, 2023 at 8:41=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Sat, Jul 29, 2023 at 1:20=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redh=
at.com> wrote:
> >
> > At this moment the migration of net features that depends on CVQ is not
> > possible, as there is no reliable way to restore the device state like =
mac
> > address, number of enabled queues, etc to the destination.  This is mai=
nly
> > caused because the device must only read CVQ, and process all the comma=
nds
> > before resuming the dataplane.
> >
> > This series lift that requirement, sending the VHOST_VDPA_SET_VRING_ENA=
BLE
> > ioctl for dataplane vqs only after the device has processed all command=
s.
>
> I think it's better to explain (that is what I don't understand) why
> we can not simply reorder vhost_net_start_one() in vhost_net_start()?
>
>     for (i =3D 0; i < nvhosts; i++) {
>         if (i < data_queue_pairs) {
>             peer =3D qemu_get_peer(ncs, i);
>         } else {
>             peer =3D qemu_get_peer(ncs, n->max_queue_pairs);
>         }
>
>         if (peer->vring_enable) {
>             /* restore vring enable state */
>             r =3D vhost_set_vring_enable(peer, peer->vring_enable);
>
>             if (r < 0) {
>                 goto err_start;
>             }
>         }
>
> =3D>      r =3D vhost_net_start_one(get_vhost_net(peer), dev);
>         if (r < 0) {
>             goto err_start;
>         }
>     }
>
> Can we simply start cvq first here?
>

Well the current order is:
* set dev features (conditioned by
* Configure all vq addresses
* Configure all vq size
...
* Enable cvq
* DRIVER_OK
* Enable all the rest of the queues.

If we just start CVQ first, we need to modify vhost_vdpa_set_features
as minimum. A lot of code that depends on vdev->vq_index{,_end} may be
affected.

Also, I'm not sure if all the devices will support configure address,
vq size, etc after DRIVER_OK.

> Thanks
>
> > ---
> > From FRC:
> > * Enable vqs early in case CVQ cannot be shadowed.
> >
> > Eugenio P=C3=A9rez (7):
> >   vdpa: export vhost_vdpa_set_vring_ready
> >   vdpa: add should_enable op
> >   vdpa: use virtio_ops->should_enable at vhost_vdpa_set_vrings_ready
> >   vdpa: add stub vhost_vdpa_should_enable
> >   vdpa: delay enable of data vqs
> >   vdpa: enable cvq svq if data vq are shadowed
> >   vdpa: remove net cvq migration blocker
> >
> >  include/hw/virtio/vhost-vdpa.h |  9 +++++
> >  hw/virtio/vhost-vdpa.c         | 33 ++++++++++++----
> >  net/vhost-vdpa.c               | 69 ++++++++++++++++++++++++++--------
> >  hw/virtio/trace-events         |  2 +-
> >  4 files changed, 89 insertions(+), 24 deletions(-)
> >
> > --
> > 2.39.3
> >
> >
>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D965674CE9B
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 09:38:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIlTB-0001Q9-NZ; Mon, 10 Jul 2023 03:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qIlT9-0001Pl-Cl
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:38:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qIlT7-00023Z-UO
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 03:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688974681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4BE4gxu0kEicAnK9dDnmr376xR6mYNsNGvdfzRDuJ08=;
 b=XBqaQWIZ6x2VxBdTN+ducHEkzRzpu+49NtKrl18HL4ltyfJgfzZzBoquguZbguawzYPDwy
 nZEJUVMVYdS9PmOFdR/jKyJoW/UeJlkDAWbenuItBFomR6OQFm2BKgoPBbfrbkB0ah9ExU
 skUPRa0s13WnyI9Bga81Ztx8Y1aXJr4=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-bTeXmEMjMFiGAVazll-riw-1; Mon, 10 Jul 2023 03:37:59 -0400
X-MC-Unique: bTeXmEMjMFiGAVazll-riw-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-c8f360a07a2so51474276.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 00:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688974679; x=1691566679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4BE4gxu0kEicAnK9dDnmr376xR6mYNsNGvdfzRDuJ08=;
 b=BsG0ZUX2Tw3hmU6p1eL0w38eGC28aYeDriu52gbx8+oMFhuECOAssNIA+PSXbu0aEQ
 4bqmBySLU8H29S1qKdaZoXfI6fGIt4Tbsc3WbRkgfoIK8X1sAVxb+I1WzSQS8inxzNo+
 z7Sn7qr2ZkLPw7awFZp3iK6h2ipJDUiPNANDYxWo+2nkDXRR9MQoeFPOQgt/ob5ysWMX
 29p4nh+TJalvvp/keyvYzzBy+f4wTkYp07sWdxZiNLNdX8X2kkU1KNdLQIc3tYEGgcZ5
 XeSmaat+bM7gG0OWC1vSTaL0zaRERO2t7uz/bYjK6X9mGl2l1nt7DDnaLXvLkGNOXB5v
 fdDw==
X-Gm-Message-State: ABy/qLahhsARVTBrmxZXV+zV11HBmD5iWWXBVE5Sk4JGXW72z3BQXckm
 Sg/mVW7XxYluUJS6gpJD67g/CF3HEqK1UGR+cZjsZ6626Xkjlrd5QOFjBdbLBQ87x32iN0kcd8T
 K7nJSQ1qrhiD8X9bEkASUBk2wcIrUyBA=
X-Received: by 2002:a25:b285:0:b0:c73:2015:2d7c with SMTP id
 k5-20020a25b285000000b00c7320152d7cmr4471551ybj.33.1688974678808; 
 Mon, 10 Jul 2023 00:37:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGAnNKYqbOcoeFa3tOHTVyV1jtcKDQbsNtNq0+D2LK2eybE1HHEK1mx1EIRASMtecZpGNEMyHrgg75QaUpnUiM=
X-Received: by 2002:a25:b285:0:b0:c73:2015:2d7c with SMTP id
 k5-20020a25b285000000b00c7320152d7cmr4471542ybj.33.1688974678544; Mon, 10 Jul
 2023 00:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230706191227.835526-1-eperezma@redhat.com>
 <20230706191227.835526-7-eperezma@redhat.com>
 <CACGkMEtjbYCGNLLO+HDhtbA7QqZALr-cEpkjX=ETy=j3eCkTVA@mail.gmail.com>
In-Reply-To: <CACGkMEtjbYCGNLLO+HDhtbA7QqZALr-cEpkjX=ETy=j3eCkTVA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 10 Jul 2023 09:37:22 +0200
Message-ID: <CAJaqyWcS6O+GNYsjuWo7Z85pq5Ls7_WWjLdM4z8eYGSSUMVc9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] vdpa: remove net cvq migration blocker
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Cindy Lu <lulu@redhat.com>,
 si-wei.liu@oracle.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Shannon Nelson <snelson@pensando.io>,
 Gautam Dawar <gdawar@xilinx.com>, Harpreet Singh Anand <hanand@xilinx.com>,
 Parav Pandit <parav@mellanox.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>, 
 Lei Yang <leiyang@redhat.com>
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

On Mon, Jul 10, 2023 at 5:54=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Jul 7, 2023 at 3:12=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > Now that we have add migration blockers if the device does not support
> > all the needed features, remove the general blocker applied to all net
> > devices with CVQ.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
>
> I wonder what's the difference compared if we just start cvq first in
> vhost_net_start()?
>

That's interesting. It would complicate the for loop in
vhost_net_start, but I think it's less complicated than
should_start_op.

It would be something like moving from:

for (i =3D 0; i < nvhosts; i++) {
    if (i < data_queue_pairs) {
        peer =3D qemu_get_peer(ncs, i);
    } else {
        peer =3D qemu_get_peer(ncs, n->max_queue_pairs);
    }

    ...

    r =3D vhost_net_start_one(get_vhost_net(peer), dev);
    if (r < 0) {
        goto err_start;
    }
}

To:

for (i =3D 0; i < nvhosts; i++) {
    if (i =3D=3D 0 && cvq) {
        peer =3D qemu_get_peer(ncs, n->max_queue_pairs);
    } else {
        peer =3D qemu_get_peer(ncs, i - cvq);
    }

    ...

    r =3D vhost_net_start_one(get_vhost_net(peer), dev);
    if (r < 0) {
        goto err_start;
    }
}

Is this what you have in mind?

Thanks!

> Thanks
>
> > ---
> >  net/vhost-vdpa.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> >
> > diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> > index d5970e9f06..5432b50498 100644
> > --- a/net/vhost-vdpa.c
> > +++ b/net/vhost-vdpa.c
> > @@ -996,18 +996,6 @@ static NetClientState *net_vhost_vdpa_init(NetClie=
ntState *peer,
> >          s->vhost_vdpa.shadow_vq_ops =3D &vhost_vdpa_net_svq_ops;
> >          s->vhost_vdpa.shadow_vq_ops_opaque =3D s;
> >          s->cvq_isolated =3D cvq_isolated;
> > -
> > -        /*
> > -         * TODO: We cannot migrate devices with CVQ and no x-svq enabl=
ed as
> > -         * there is no way to set the device state (MAC, MQ, etc) befo=
re
> > -         * starting the datapath.
> > -         *
> > -         * Migration blocker ownership now belongs to s->vhost_vdpa.
> > -         */
> > -        if (!svq) {
> > -            error_setg(&s->vhost_vdpa.migration_blocker,
> > -                       "net vdpa cannot migrate with CVQ feature");
> > -        }
> >      }
> >      ret =3D vhost_vdpa_add(nc, (void *)&s->vhost_vdpa, queue_pair_inde=
x, nvqs);
> >      if (ret) {
> > --
> > 2.39.3
> >
>



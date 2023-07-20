Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D731D75A935
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 10:26:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMOy2-0002dS-FH; Thu, 20 Jul 2023 04:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qMOxQ-0002UE-T6
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 04:24:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qMOxJ-0003dh-7j
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 04:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689841442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v9zcjYLosG8gr73zXT6nB2fxNoPZ091HtQMtIG/x8Ak=;
 b=efald4fpoHPCL/7R8gjop1ahI1DWPGeL5R5F9mUWZuBzTUpXQjf42hiOK6yWMyh1JjOhqH
 Z1sOVOyQF+YQhu8I0Affa/RWXXTiGusDhi6Dhlu4TejE7cYwe9cFw4aBGJxSUE+tTRN1M9
 ALg3OwMj/cVTKFvYzlqrpYdpPb5TTfk=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-nCejVMWlNy-4aq2CnCiO1w-1; Thu, 20 Jul 2023 04:23:57 -0400
X-MC-Unique: nCejVMWlNy-4aq2CnCiO1w-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b6fdb7eeafso4238801fa.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 01:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689841436; x=1692433436;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v9zcjYLosG8gr73zXT6nB2fxNoPZ091HtQMtIG/x8Ak=;
 b=Xz0jO9RKOnCQb+Vk2rLdXRNy5cbZt1pZPuK2jSV/EJaI20V2/BzHkovI88oau4p7TM
 vKtsJ8ejvOB8r9017mIJX79Y965i6XeGYvMcUpx3QjxEttuZcbsDdgzsw21tgFCmVv1+
 MTj6jPnZts67MlVsX2IxP8dgxK4fdIQgPC6WX+egS1DP86l3+z0cWBJy2yM2JvaxHsI2
 t/Wvmm921ACG5U+fP5BCgHbQZuuSukbMZLWqclkLpmu0XjaS2LKinX84H8xZBUmqE4Vy
 2xNvFe2P5ve2lvm4YYjBS7qYOFgUotXItTwO5JAHulD/MbDHY9tipu5VIFlbDaTOb02/
 hRHw==
X-Gm-Message-State: ABy/qLZ/SoO0GX/5zeciT8xHH2+dDjEtZZe2aTZ9Ny0tZpEupiWPvsii
 8wcI2aEQakX+t/N3a7wNVTm0sIlodjSC+UkoJmq/bWkSCN5LzVp4PaOtf1LldoNFxOklwB+IQ0o
 UTl0bAZGNybnMdtSW/cDRzKI88eaFOEY=
X-Received: by 2002:a2e:b17b:0:b0:2b6:cbba:1307 with SMTP id
 a27-20020a2eb17b000000b002b6cbba1307mr1612493ljm.0.1689841436388; 
 Thu, 20 Jul 2023 01:23:56 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHKD26EnAUJvBmStdZevBch4PZiZQVKktXQJLthaNoB3YhNiifSdjZI6lUXnSpFSQ9q2PiKgbCM2LBeCaPxhWk=
X-Received: by 2002:a2e:b17b:0:b0:2b6:cbba:1307 with SMTP id
 a27-20020a2eb17b000000b002b6cbba1307mr1612483ljm.0.1689841436094; Thu, 20 Jul
 2023 01:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230706191227.835526-1-eperezma@redhat.com>
 <20230706191227.835526-7-eperezma@redhat.com>
 <CACGkMEtjbYCGNLLO+HDhtbA7QqZALr-cEpkjX=ETy=j3eCkTVA@mail.gmail.com>
 <CAJaqyWcS6O+GNYsjuWo7Z85pq5Ls7_WWjLdM4z8eYGSSUMVc9Q@mail.gmail.com>
 <CAJaqyWchexS5Gq9Ot88mBPp1nPnZYS3=q+GaE+DNBfeP1a+Rug@mail.gmail.com>
In-Reply-To: <CAJaqyWchexS5Gq9Ot88mBPp1nPnZYS3=q+GaE+DNBfeP1a+Rug@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jul 2023 16:23:44 +0800
Message-ID: <CACGkMEtj7a4H-PW3qLc-t0Cve6QG4f1zRFpMc5S2pfGFSYFdEQ@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] vdpa: remove net cvq migration blocker
To: Eugenio Perez Martin <eperezma@redhat.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Thu, Jul 20, 2023 at 4:18=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Mon, Jul 10, 2023 at 9:37=E2=80=AFAM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Mon, Jul 10, 2023 at 5:54=E2=80=AFAM Jason Wang <jasowang@redhat.com=
> wrote:
> > >
> > > On Fri, Jul 7, 2023 at 3:12=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@r=
edhat.com> wrote:
> > > >
> > > > Now that we have add migration blockers if the device does not supp=
ort
> > > > all the needed features, remove the general blocker applied to all =
net
> > > > devices with CVQ.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > >
> > > I wonder what's the difference compared if we just start cvq first in
> > > vhost_net_start()?
> > >
> >
> > That's interesting. It would complicate the for loop in
> > vhost_net_start, but I think it's less complicated than
> > should_start_op.
> >
> > It would be something like moving from:
> >
> > for (i =3D 0; i < nvhosts; i++) {
> >     if (i < data_queue_pairs) {
> >         peer =3D qemu_get_peer(ncs, i);
> >     } else {
> >         peer =3D qemu_get_peer(ncs, n->max_queue_pairs);
> >     }
> >
> >     ...
> >
> >     r =3D vhost_net_start_one(get_vhost_net(peer), dev);
> >     if (r < 0) {
> >         goto err_start;
> >     }
> > }
> >
> > To:
> >
> > for (i =3D 0; i < nvhosts; i++) {
> >     if (i =3D=3D 0 && cvq) {
> >         peer =3D qemu_get_peer(ncs, n->max_queue_pairs);
> >     } else {
> >         peer =3D qemu_get_peer(ncs, i - cvq);
> >     }
> >
> >     ...
> >
> >     r =3D vhost_net_start_one(get_vhost_net(peer), dev);
> >     if (r < 0) {
> >         goto err_start;
> >     }
> > }
> >
> > Is this what you have in mind?
> >
>

Yes, something like this.

Thanks

> Friendly ping.
>
> Thanks!
>



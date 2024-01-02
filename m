Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 566D7821DD8
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 15:39:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKfuv-00036r-DX; Tue, 02 Jan 2024 09:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rKfut-00035a-Ae
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 09:38:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rKfur-0003t5-BB
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 09:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704206328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3F7U3lQS5j0a5uSmITGI4DPObQevbEoHda2/rZfgWqA=;
 b=hzSaPgeXg82nmWSwYyROy4FU1eJlev2n4C1O0TkjnolxsisDP2PK1h93KZZ3jopeGPk98M
 khSMW0QQ0nceRH1eOM0toTtW2yzBgrBPydv2Vpa/3ARJpP5EMkAeVnkGUyXDxdj23rpRWm
 WoW0j8ebiiNml2Xitv3IgUDnYMNxMyA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-mOtdUZbIPwyfL9ZAwSw_dQ-1; Tue, 02 Jan 2024 09:38:47 -0500
X-MC-Unique: mOtdUZbIPwyfL9ZAwSw_dQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5f1df517cf3so21731987b3.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 06:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704206326; x=1704811126;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3F7U3lQS5j0a5uSmITGI4DPObQevbEoHda2/rZfgWqA=;
 b=rOS1PpRvJkzH2a6WFTjxbfPL1H2QhYfG2qrA/TYTeXA4FVrin/zjOY1hYY74jkmfbF
 gftIsyNsr8vTJW9ud9tn/Rf+MEoVekDJTLAalp0K21odGdVdL9dh1ZAt4lZFBJLAFoKR
 +10Wz8NR6xeMe1OrtSCxGm1YshmhZaaZctIrParTLOrjAGj3Qm6M3DTwvpJuXwW8d/WJ
 HPSJkiqmuHWQBodjaW0UvM6K4dIY9s9mZUVQl17h44qmOejhb7JF3g/eZfoj/mS/ETxQ
 wAR94QpESFKaJ3T021lC3D7dnTR2kcKvqaco1ove37FDSbodg/JQ7VPVNIX/SkcIDAnl
 20Mg==
X-Gm-Message-State: AOJu0Yybm2JhHdIXAPuEXe6ygQ3oSS3qZNv14MgXwCVc7xewAyB6B0YW
 grCfJidcw3OWcFoqkGUs2DgKU6hkMwQ0aAK1A4gzXL0Sl0cEWkGaNnHj19SI+nbuwy99uKnyUOt
 1WfP1AgNHA1i4E1mOMql90MIX8a0+lhULad+smBg=
X-Received: by 2002:a0d:ea4e:0:b0:5e8:566:56ff with SMTP id
 t75-20020a0dea4e000000b005e8056656ffmr11525041ywe.32.1704206326701; 
 Tue, 02 Jan 2024 06:38:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGniz6n5paOXmq9CaLgyyBZv0q4o8SiSG1q7rB1ViVBgikWhk4Vx2GwFXnNY6fDbTTHmaSwJ/QRypCFRoON0UI=
X-Received: by 2002:a0d:ea4e:0:b0:5e8:566:56ff with SMTP id
 t75-20020a0dea4e000000b005e8056656ffmr11525035ywe.32.1704206326471; Tue, 02
 Jan 2024 06:38:46 -0800 (PST)
MIME-Version: 1.0
References: <20231215172830.2540987-1-eperezma@redhat.com>
 <20231225113031-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231225113031-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 2 Jan 2024 15:38:10 +0100
Message-ID: <CAJaqyWc+Y_nTHJEPJxcseOT9Bop3z232J_WoShHTeDSJgFBXEw@mail.gmail.com>
Subject: Re: [PATCH for 9.0 00/12] Map memory at destination .load_setup in
 vDPA-net migration
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, si-wei.liu@oracle.com, 
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>, 
 Parav Pandit <parav@mellanox.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
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

On Mon, Dec 25, 2023 at 5:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Fri, Dec 15, 2023 at 06:28:18PM +0100, Eugenio P=C3=A9rez wrote:
> > Current memory operations like pinning may take a lot of time at the
> > destination.  Currently they are done after the source of the migration=
 is
> > stopped, and before the workload is resumed at the destination.  This i=
s a
> > period where neigher traffic can flow, nor the VM workload can continue
> > (downtime).
> >
> > We can do better as we know the memory layout of the guest RAM at the
> > destination from the moment the migration starts.  Moving that operatio=
n allows
> > QEMU to communicate the kernel the maps while the workload is still run=
ning in
> > the source, so Linux can start mapping them.
> >
> > Also, the destination of the guest memory may finish before the destina=
tion
> > QEMU maps all the memory.  In this case, the rest of the memory will be=
 mapped
> > at the same time as before applying this series, when the device is sta=
rting.
> > So we're only improving with this series.
> >
> > If the destination has the switchover_ack capability enabled, the desti=
nation
> > hold the migration until all the memory is mapped.
> >
> > This needs to be applied on top of [1]. That series performs some code
> > reorganization that allows to map the guest memory without knowing the =
queue
> > layout the guest configure on the device.
> >
> > This series reduced the downtime in the stop-and-copy phase of the live
> > migration from 20s~30s to 5s, with a 128G mem guest and two mlx5_vdpa d=
evices,
> > per [2].
>
> I think this is reasonable and could be applied - batching is good.
> Could you rebase on master and repost please?
>

New comments appeared in the meantime [1], but I'll rebase with the
needed changes after they converge.

Thanks!

[1] https://patchwork.kernel.org/comment/25653487/


> > Future directions on top of this series may include:
> > * Iterative migration of virtio-net devices, as it may reduce downtime =
per [3].
> >   vhost-vdpa net can apply the configuration through CVQ in the destina=
tion
> >   while the source is still migrating.
> > * Move more things ahead of migration time, like DRIVER_OK.
> > * Check that the devices of the destination are valid, and cancel the m=
igration
> >   in case it is not.
> >
> > v1 from RFC v2:
> > * Hold on migration if memory has not been mapped in full with switchov=
er_ack.
> > * Revert map if the device is not started.
> >
> > RFC v2:
> > * Delegate map to another thread so it does no block QMP.
> > * Fix not allocating iova_tree if x-svq=3Don at the destination.
> > * Rebased on latest master.
> > * More cleanups of current code, that might be split from this series t=
oo.
> >
> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2023-12/msg01986.h=
tml
> > [2] https://lists.nongnu.org/archive/html/qemu-devel/2023-12/msg00909.h=
tml
> > [3] https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a56=
6f61@nvidia.com/T/
> >
> > Eugenio P=C3=A9rez (12):
> >   vdpa: do not set virtio status bits if unneeded
> >   vdpa: make batch_begin_once early return
> >   vdpa: merge _begin_batch into _batch_begin_once
> >   vdpa: extract out _dma_end_batch from _listener_commit
> >   vdpa: factor out stop path of vhost_vdpa_dev_start
> >   vdpa: check for iova tree initialized at net_client_start
> >   vdpa: set backend capabilities at vhost_vdpa_init
> >   vdpa: add vhost_vdpa_load_setup
> >   vdpa: approve switchover after memory map in the migration destinatio=
n
> >   vdpa: add vhost_vdpa_net_load_setup NetClient callback
> >   vdpa: add vhost_vdpa_net_switchover_ack_needed
> >   virtio_net: register incremental migration handlers
> >
> >  include/hw/virtio/vhost-vdpa.h |  32 ++++
> >  include/net/net.h              |   8 +
> >  hw/net/virtio-net.c            |  48 ++++++
> >  hw/virtio/vhost-vdpa.c         | 274 +++++++++++++++++++++++++++------
> >  net/vhost-vdpa.c               |  43 +++++-
> >  5 files changed, 357 insertions(+), 48 deletions(-)
> >
> > --
> > 2.39.3
> >
>



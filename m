Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D55577DEBEF
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 05:38:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyPSG-00073y-SK; Thu, 02 Nov 2023 00:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qyPSF-00073p-9W
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 00:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1qyPSC-000092-Uu
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 00:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698899831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iukaMYfmqPA/rxx89fEB9cgg1TUol1/dtw4GDa+7DkY=;
 b=abOiDU65e3GoPhLVAWJEfcgKZdch3h9qjmmyD7n6hHhLH+VL7S3jTtJch7Jma6ORDHz2ON
 Obls+PHf67qmTMia8PsYyBRscJ1jLY0LNRKLUuy3JIZXIOlYkKF37HgOWzRlH7WSpbizYy
 QwgGNTETDFi5a1JTny1Dvi5jZSVLrT8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-AL3uX_rsNTKRSUucr9FMSA-1; Thu, 02 Nov 2023 00:37:09 -0400
X-MC-Unique: AL3uX_rsNTKRSUucr9FMSA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66fe14725aeso6296636d6.2
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 21:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698899829; x=1699504629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iukaMYfmqPA/rxx89fEB9cgg1TUol1/dtw4GDa+7DkY=;
 b=FmXLpC5WvlN8/mrQh4pzumHjyG5G0H3DcmXt8559LDAo9eYinJJ4l9cZF9L2dnX/fx
 bLBDTMgDhsHuKeXTlWD6bhYeUTcTAExwXH53FTCWkizKvIWucpZb3JpZ+EfhM07So4nl
 pi3KCX8nI4/eCTFotbS9iQ4TIb8cyNgKhWxQLhc+PiKq680sBKqkfEld6t7xnT95m5LG
 W2U6TgDHEnFqrT8RDx8PGuQF3klIp4rRUjC0oVk9Ar/Kiy+w/7MghHKly3WK+97Y/SLc
 SzVCrN9/aoiQWnMySc0OaMZTHqVAM0ctdtLsb50iiGIfj8uw9P2cgBYqbi9qOFyeaT1k
 0Pmg==
X-Gm-Message-State: AOJu0YyuKcS8tkhgGfWIzeUioQ4MmAxTvv6ZZ/Qg0m1m+00+dmcF4Bjw
 qmsgTAo6by6V2ErGPbDhEhpTF/4UPp2d/Gjf+2Q9rF+nqv5IFFMFHaJc2ibwzxVux1/uvHGSsJX
 JP19gHJwruyqYtHJai3Oiz2ovgJp6gCA=
X-Received: by 2002:a05:6214:21aa:b0:66d:12c7:bf85 with SMTP id
 t10-20020a05621421aa00b0066d12c7bf85mr22496631qvc.31.1698899829068; 
 Wed, 01 Nov 2023 21:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYso8L6Zm38Nfu7wl9+PZECxvsvdakzJgWSgW5vXd1ec1y9ofNlPRGYhClFVcboRXjtazWLGWZRvAQ550dvpg=
X-Received: by 2002:a05:6214:21aa:b0:66d:12c7:bf85 with SMTP id
 t10-20020a05621421aa00b0066d12c7bf85mr22496618qvc.31.1698899828826; Wed, 01
 Nov 2023 21:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231019143455.2377694-1-eperezma@redhat.com>
In-Reply-To: <20231019143455.2377694-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 2 Nov 2023 12:36:56 +0800
Message-ID: <CACGkMEtxkdg6-Dv1Qm2vd__PENMtg5hrekjXLa0kFhcz2XRdzQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/18] Map memory at destination .load_setup in
 vDPA-net migration
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Shannon <shannon.nelson@amd.com>, 
 Parav Pandit <parav@mellanox.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, yin31149@gmail.com,
 Yajun Wu <yajunw@nvidia.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Lei Yang <leiyang@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Juan Quintela <quintela@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, si-wei.liu@oracle.com, 
 Gautam Dawar <gdawar@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

On Thu, Oct 19, 2023 at 10:35=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
>
> Current memory operations like pinning may take a lot of time at the
> destination.  Currently they are done after the source of the migration i=
s
> stopped, and before the workload is resumed at the destination.  This is =
a
> period where neigher traffic can flow, nor the VM workload can continue
> (downtime).
>
> We can do better as we know the memory layout of the guest RAM at the
> destination from the moment the migration starts.  Moving that operation =
allows
> QEMU to communicate the kernel the maps while the workload is still runni=
ng in
> the source, so Linux can start mapping them.  Ideally, all IOMMU is confi=
gured,
> but if the vDPA parent driver uses on-chip IOMMU and .set_map we're still
> saving all the pinning time.
>
> Note that further devices setup at the end of the migration may alter the=
 guest
> memory layout. But same as the previous point, many operations are still =
done
> incrementally, like memory pinning, so we're saving time anyway.
>
> The first bunch of patches just reorganizes the code, so memory related
> operation parameters are shared between all vhost_vdpa devices.  This is
> because the destination does not know what vhost_vdpa struct will have th=
e
> registered listener member, so it is easier to place them in a shared str=
uct
> rather to keep them in vhost_vdpa struct.  Future version may squash or o=
mit
> these patches.
>
> Only tested with vdpa_sim. I'm sending this before full benchmark, as som=
e work
> like [1] can be based on it, and Si-Wei agreed on benchmark this series w=
ith
> his experience.

I'd expect we can see some improvement even without other
optimizations? For example, do we see improvement on mlx5?

(Or we can probably add some delay to the simulator to see)

Thanks

>
> Future directions on top of this series may include:
> * Iterative migration of virtio-net devices, as it may reduce downtime pe=
r [1].
>   vhost-vdpa net can apply the configuration through CVQ in the destinati=
on
>   while the source is still migrating.
> * Move more things ahead of migration time, like DRIVER_OK.
> * Check that the devices of the destination are valid, and cancel the mig=
ration
>   in case it is not.
>
> [1] https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f=
61@nvidia.com/T/
>
> Eugenio P=C3=A9rez (18):
>   vdpa: add VhostVDPAShared
>   vdpa: move iova tree to the shared struct
>   vdpa: move iova_range to vhost_vdpa_shared
>   vdpa: move shadow_data to vhost_vdpa_shared
>   vdpa: use vdpa shared for tracing
>   vdpa: move file descriptor to vhost_vdpa_shared
>   vdpa: move iotlb_batch_begin_sent to vhost_vdpa_shared
>   vdpa: move backend_cap to vhost_vdpa_shared
>   vdpa: remove msg type of vhost_vdpa
>   vdpa: move iommu_list to vhost_vdpa_shared
>   vdpa: use VhostVDPAShared in vdpa_dma_map and unmap
>   vdpa: use dev_shared in vdpa_iommu
>   vdpa: move memory listener to vhost_vdpa_shared
>   vdpa: do not set virtio status bits if unneeded
>   vdpa: add vhost_vdpa_load_setup
>   vdpa: add vhost_vdpa_net_load_setup NetClient callback
>   vdpa: use shadow_data instead of first device v->shadow_vqs_enabled
>   virtio_net: register incremental migration handlers
>
>  include/hw/virtio/vhost-vdpa.h |  43 +++++---
>  include/net/net.h              |   4 +
>  hw/net/virtio-net.c            |  23 +++++
>  hw/virtio/vdpa-dev.c           |   7 +-
>  hw/virtio/vhost-vdpa.c         | 183 ++++++++++++++++++---------------
>  net/vhost-vdpa.c               | 127 ++++++++++++-----------
>  hw/virtio/trace-events         |  14 +--
>  7 files changed, 239 insertions(+), 162 deletions(-)
>
> --
> 2.39.3
>
>



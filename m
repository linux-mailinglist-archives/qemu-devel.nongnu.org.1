Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9C081DD74
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 02:43:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHZz5-0006pN-U4; Sun, 24 Dec 2023 20:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1rHZz4-0006pB-4q
 for qemu-devel@nongnu.org; Sun, 24 Dec 2023 20:42:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1rHZz2-0004or-Ag
 for qemu-devel@nongnu.org; Sun, 24 Dec 2023 20:42:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703468538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hfsf5szy+T+3jOX8ityI3Repo0EsIY3zN5LBGo4eYcU=;
 b=SrW3AN9/7gRp+sGxVC9m+gGf0jF08Z0QmsnLDOqcHKnK3mFxVDZ6wImMAjRet/Ftv1hACg
 q7A/RJk8XM3CnJsoyoEaGxVJLVn0eckB27UYVCCugfVErS5vqxQOlKXoumlOLLSTDVUoiR
 ewlyIUWFSMESDY07+vV9lruFFH+wMl4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-fE7gK49nNGONIGnehJ8ldQ-1; Sun, 24 Dec 2023 20:42:16 -0500
X-MC-Unique: fE7gK49nNGONIGnehJ8ldQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a0c510419caso181690866b.1
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 17:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703468535; x=1704073335;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hfsf5szy+T+3jOX8ityI3Repo0EsIY3zN5LBGo4eYcU=;
 b=bgnsATJa1rNdB0WS+Sue3Cl7GRz6XPYnNnyGeQMmA67doAi1l80EhcONU4mkc4Bcel
 1Dk6estI8c6+fm9ToHq7nm8UYOVhWEBSXfBlIewUdPHviKZ128QS/PTD79e4Gz8AtGDi
 ugBp/Z3A/GtAP38oM9GrifwYHxDtojaph9NtvKWzq0+AjYAH9Kso9KjS22/lyF57hPNs
 SB3asNjgVGeQoPQpvwpCiCUTfHUfuSo03joYfWxdVoh3OLulHm3jsit/SDVvbpdi711m
 cqFDB2z82JKqapFp4fmPdgFOkOyH6v8RfN1RMx57RaUVlMRMgLNsVdPLVPvM+XcniR4T
 YNCw==
X-Gm-Message-State: AOJu0YxKvC1DIZVR6L87zbYhCJaPo7j2PXcdG0SPedPdJgYoluYS5nEz
 9wRKHumjgx67Ce0oxzIG+6f/s51OxmZ+0DPqFpezlQsoJbMBYCy1p8bM/OTzQ+kK9RRRbLavO02
 oFmbnR46nReqVvn5nVsSF40L39sDmjsvHDmkn7YM=
X-Received: by 2002:a17:906:86:b0:a23:6a3b:31d9 with SMTP id
 6-20020a170906008600b00a236a3b31d9mr2151452ejc.33.1703468535427; 
 Sun, 24 Dec 2023 17:42:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEt1e9puT2LmbjSM+n+yYjM80JaGIDBQJsIlQ94CAIOZ+wsx25mt+AfTLDFwKvRKcViSKikM6bS7WekNm1DRFE=
X-Received: by 2002:a17:906:86:b0:a23:6a3b:31d9 with SMTP id
 6-20020a170906008600b00a236a3b31d9mr2151445ejc.33.1703468535128; Sun, 24 Dec
 2023 17:42:15 -0800 (PST)
MIME-Version: 1.0
References: <20231215172830.2540987-1-eperezma@redhat.com>
In-Reply-To: <20231215172830.2540987-1-eperezma@redhat.com>
From: Lei Yang <leiyang@redhat.com>
Date: Mon, 25 Dec 2023 09:41:38 +0800
Message-ID: <CAPpAL=wm9gN-2KKWkuHOcRm8fGbckngAy3kN5696OasHwPwGsg@mail.gmail.com>
Subject: Re: [PATCH for 9.0 00/12] Map memory at destination .load_setup in
 vDPA-net migration
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 si-wei.liu@oracle.com, 
 Jason Wang <jasowang@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.594,
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

QE tested this series with regression tests, there are no new regression is=
sues.

Tested-by: Lei Yang <leiyang@redhat.com>



On Sat, Dec 16, 2023 at 1:28=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
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
> the source, so Linux can start mapping them.
>
> Also, the destination of the guest memory may finish before the destinati=
on
> QEMU maps all the memory.  In this case, the rest of the memory will be m=
apped
> at the same time as before applying this series, when the device is start=
ing.
> So we're only improving with this series.
>
> If the destination has the switchover_ack capability enabled, the destina=
tion
> hold the migration until all the memory is mapped.
>
> This needs to be applied on top of [1]. That series performs some code
> reorganization that allows to map the guest memory without knowing the qu=
eue
> layout the guest configure on the device.
>
> This series reduced the downtime in the stop-and-copy phase of the live
> migration from 20s~30s to 5s, with a 128G mem guest and two mlx5_vdpa dev=
ices,
> per [2].
>
> Future directions on top of this series may include:
> * Iterative migration of virtio-net devices, as it may reduce downtime pe=
r [3].
>   vhost-vdpa net can apply the configuration through CVQ in the destinati=
on
>   while the source is still migrating.
> * Move more things ahead of migration time, like DRIVER_OK.
> * Check that the devices of the destination are valid, and cancel the mig=
ration
>   in case it is not.
>
> v1 from RFC v2:
> * Hold on migration if memory has not been mapped in full with switchover=
_ack.
> * Revert map if the device is not started.
>
> RFC v2:
> * Delegate map to another thread so it does no block QMP.
> * Fix not allocating iova_tree if x-svq=3Don at the destination.
> * Rebased on latest master.
> * More cleanups of current code, that might be split from this series too=
.
>
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2023-12/msg01986.htm=
l
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2023-12/msg00909.htm=
l
> [3] https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f=
61@nvidia.com/T/
>
> Eugenio P=C3=A9rez (12):
>   vdpa: do not set virtio status bits if unneeded
>   vdpa: make batch_begin_once early return
>   vdpa: merge _begin_batch into _batch_begin_once
>   vdpa: extract out _dma_end_batch from _listener_commit
>   vdpa: factor out stop path of vhost_vdpa_dev_start
>   vdpa: check for iova tree initialized at net_client_start
>   vdpa: set backend capabilities at vhost_vdpa_init
>   vdpa: add vhost_vdpa_load_setup
>   vdpa: approve switchover after memory map in the migration destination
>   vdpa: add vhost_vdpa_net_load_setup NetClient callback
>   vdpa: add vhost_vdpa_net_switchover_ack_needed
>   virtio_net: register incremental migration handlers
>
>  include/hw/virtio/vhost-vdpa.h |  32 ++++
>  include/net/net.h              |   8 +
>  hw/net/virtio-net.c            |  48 ++++++
>  hw/virtio/vhost-vdpa.c         | 274 +++++++++++++++++++++++++++------
>  net/vhost-vdpa.c               |  43 +++++-
>  5 files changed, 357 insertions(+), 48 deletions(-)
>
> --
> 2.39.3
>
>



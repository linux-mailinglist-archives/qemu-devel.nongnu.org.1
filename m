Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F42A800450
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 08:05:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8xZf-00086N-7n; Fri, 01 Dec 2023 02:04:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r8xZc-000860-H3
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 02:04:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1r8xZa-0008An-RB
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 02:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701414265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BEWw5pf5F+hxIijpTh0NTNyyYRjBn/C+UT/pyCpnzKg=;
 b=ghcqw0ExF3/AtvfmUtFSW1UmlcUjXIw8kDM3/NV9CdEXPu2ow3fCfLbCLwIXgP/qs5oeXK
 ftAZeczNDOk/rNm/IqfzOk6+a8VGXQNDqvZNdbkna5HNeMc0afqpzHEudLQ/AcnN8dkMDW
 QUAZuQXQrBaY/XPIOq4MxlRYkvMnmzs=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-6HfUO9_VN_-_M4QTmpdtgQ-1; Fri, 01 Dec 2023 02:04:22 -0500
X-MC-Unique: 6HfUO9_VN_-_M4QTmpdtgQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-50bca4c8dd7so1928310e87.3
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 23:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701414261; x=1702019061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BEWw5pf5F+hxIijpTh0NTNyyYRjBn/C+UT/pyCpnzKg=;
 b=Y+lI8STCpc9GEIh5UAbk+HzkSGf70/k5rf1y6pL5oNjktUQhlnjaBSMhUmSfkFLDpJ
 cbpzy9v6SuwSPTG/0O6SsJIY/ngv3tDBiVBa4aZaPNdEju4ef6HketaMbMQXTXFChraa
 bYFq/jxkbnzd5xP6Y5YA/iT+8O/HQ1lYwYUfs6W9nTWyyMUt/ObIsLHFBMbzYj43xaQi
 hTjPWa4IzyEwIYt5Qu9TF2JCg5Y1GugHp0zEZXY2ADlXQQIcsoppPSj1ZkGfZRzRYbBL
 CsdGbb7oom94+YyeaXxck+H8zUI7RwUcmFC8LqMT3X6yiExmRD5Yw1Z4n4+Q4Cu+v7S8
 DRyw==
X-Gm-Message-State: AOJu0YwGVjOD4ErK9qpfuJpVEpAOyj4/xGAwLebOCxaceRsPPRcIQOky
 Ho5vlDNzDZbiScAXbDQhWENcd1PBPN+Ut28ypHJmD2rDTOgxknXiQuu/Xsyb76r6pr1gtU4cmrU
 obuwF/OGLhkUE+3UYsJbb6xs5+zP3V4U=
X-Received: by 2002:a05:6512:104d:b0:50b:d764:28f6 with SMTP id
 c13-20020a056512104d00b0050bd76428f6mr395733lfb.142.1701414261008; 
 Thu, 30 Nov 2023 23:04:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFT6o5Y2WljPowy/9N+tUq3sovDZhvHDM2MsPCpth6OJSig+XH8KvxKnFeQ9Inrx3c/NpBOJO7ZrOC6gACeJjA=
X-Received: by 2002:a05:6512:104d:b0:50b:d764:28f6 with SMTP id
 c13-20020a056512104d00b0050bd76428f6mr395725lfb.142.1701414260698; Thu, 30
 Nov 2023 23:04:20 -0800 (PST)
MIME-Version: 1.0
References: <20231124171430.2964464-1-eperezma@redhat.com>
In-Reply-To: <20231124171430.2964464-1-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 1 Dec 2023 15:04:09 +0800
Message-ID: <CACGkMEshEvedjnRvawt-RSPwDWwSWFG9bUwtL9P8eiFvKRH6gA@mail.gmail.com>
Subject: Re: [PATCH 9.0 00/13] Consolidate common vdpa members in
 VhostVDPAShared
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Parav Pandit <parav@mellanox.com>,
 si-wei.liu@oracle.com, 
 Stefano Garzarella <sgarzare@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 Lei Yang <leiyang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Laurent Vivier <lvivier@redhat.com>
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

On Sat, Nov 25, 2023 at 1:14=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redhat=
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
> the source, so Linux can start mapping them.  Ideally, all IOMMU is confi=
gured,
> but if the vDPA parent driver uses on-chip IOMMU and .set_map we're still
> saving all the pinning time.
>
> This is a first required step to consolidate all the members in a common
> struct.  This is needed because the destination does not know what vhost_=
vdpa
> struct will have the registered listener member, so it is easier to place=
 them
> in a shared struct rather to keep them in vhost_vdpa struct.
>
> v1 from RFC:
> * Fix vhost_vdpa_net_cvq_start checking for always_svq instead of
>   shadow_data.  This could cause CVQ not being shadowed if
>   vhost_vdpa_net_cvq_start was called in the middle of a migration.

With the renaming of the VhostVDPAShared to VhostVDPAParent.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>
> Eugenio P=C3=A9rez (13):
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
>
>  include/hw/virtio/vhost-vdpa.h |  36 +++++---
>  hw/virtio/vdpa-dev.c           |   7 +-
>  hw/virtio/vhost-vdpa.c         | 160 +++++++++++++++++----------------
>  net/vhost-vdpa.c               | 117 ++++++++++++------------
>  hw/virtio/trace-events         |  14 +--
>  5 files changed, 174 insertions(+), 160 deletions(-)
>
> --
> 2.39.3
>
>



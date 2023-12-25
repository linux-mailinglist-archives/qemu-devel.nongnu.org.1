Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A5581E194
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 17:32:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHnrG-0003VH-48; Mon, 25 Dec 2023 11:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rHnrD-0003UG-3R
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 11:31:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rHnr9-0000Gc-1h
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 11:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703521865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4PwgFmbqDYf73IrAOmHfYxGKIoR0vwmLjGLJNjXBH1w=;
 b=h1x6oDGHBVTt2bW5/ED6a4jvQhWPkAOuz/nj1a+moFTvfpzbG+unAtr8rR8mmW6Pdh1KNa
 R4dmRUbd84KK463oLxQmRLmgPew8EtvpQP8YNT8/K4H0Gixky1Uz5AZqGybHsFIV0dh9FW
 guP80NpEWvzb3inUZE3BTyUGxT1ge7U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-A5SzOmSAO5qMNZ9h61kh6g-1; Mon, 25 Dec 2023 11:31:04 -0500
X-MC-Unique: A5SzOmSAO5qMNZ9h61kh6g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40c4a824c4bso37981715e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Dec 2023 08:31:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703521863; x=1704126663;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4PwgFmbqDYf73IrAOmHfYxGKIoR0vwmLjGLJNjXBH1w=;
 b=qoKJZUErt74vWeUuvpFpL7e0bJOmfY+C+pFqImjvYfO2UNVgP8nSVrirMQCRFt3x4J
 VZHDNGOKXd9OgqRTtytjSyyUrRslI8dffwn6QJSZJ0Uwwj07kSjAZ2gKUTDWfxMQS4wr
 uSor002wu3GnOW8EqykcRDmCX9GFMVG9CNJwV1mt7yISrgCXfX2tHsIaieV4MugZwXU2
 lW8IjmkEdWY5FFnJQ1RnVusJiG/7q/YJr4K6FY432RV1AjXGsrbcdWxqdnu+pobFk9i7
 XGu3pN3srtgMOAvBbmrpmpqR+vpXAXSJKvVe9Sbapvi5Oaz4NbhoX364SKiyikGGoqSQ
 1AYQ==
X-Gm-Message-State: AOJu0YyVkO+dUcugGe7MUd9GrM84QOHefUlRQ0oTT8/0I1XspmtRbaJT
 zAyxXhbcPIBSRoEG0oPd4rvy4b6t8aJqz5pGN2g5/Q6YLTwgVe8pBBlOhpMmxTZAYBtqNSAl+Gn
 evslhUGUB3FJDuQCz6oeYFPU=
X-Received: by 2002:a05:600c:3f85:b0:40d:3bd1:3dca with SMTP id
 fs5-20020a05600c3f8500b0040d3bd13dcamr3225709wmb.157.1703521862916; 
 Mon, 25 Dec 2023 08:31:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG5JGiaafLCUhZWp9BDJaAIlhYjDIC96VX0hFpJWGcCs+vT/IXJejyro7ykqGaJdQRgcSlbzw==
X-Received: by 2002:a05:600c:3f85:b0:40d:3bd1:3dca with SMTP id
 fs5-20020a05600c3f8500b0040d3bd13dcamr3225701wmb.157.1703521862599; 
 Mon, 25 Dec 2023 08:31:02 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ef:4100:2cf6:9475:f85:181e])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a05600c471000b0040c4886f254sm25473562wmo.13.2023.12.25.08.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 08:31:01 -0800 (PST)
Date: Mon, 25 Dec 2023 11:30:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, si-wei.liu@oracle.com,
 Lei Yang <leiyang@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>,
 Zhu Lingshan <lingshan.zhu@intel.com>, Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH for 9.0 00/12] Map memory at destination .load_setup in
 vDPA-net migration
Message-ID: <20231225113031-mutt-send-email-mst@kernel.org>
References: <20231215172830.2540987-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231215172830.2540987-1-eperezma@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.977,
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

On Fri, Dec 15, 2023 at 06:28:18PM +0100, Eugenio Pérez wrote:
> Current memory operations like pinning may take a lot of time at the
> destination.  Currently they are done after the source of the migration is
> stopped, and before the workload is resumed at the destination.  This is a
> period where neigher traffic can flow, nor the VM workload can continue
> (downtime).
> 
> We can do better as we know the memory layout of the guest RAM at the
> destination from the moment the migration starts.  Moving that operation allows
> QEMU to communicate the kernel the maps while the workload is still running in
> the source, so Linux can start mapping them.
> 
> Also, the destination of the guest memory may finish before the destination
> QEMU maps all the memory.  In this case, the rest of the memory will be mapped
> at the same time as before applying this series, when the device is starting.
> So we're only improving with this series.
> 
> If the destination has the switchover_ack capability enabled, the destination
> hold the migration until all the memory is mapped.
> 
> This needs to be applied on top of [1]. That series performs some code
> reorganization that allows to map the guest memory without knowing the queue
> layout the guest configure on the device.
> 
> This series reduced the downtime in the stop-and-copy phase of the live
> migration from 20s~30s to 5s, with a 128G mem guest and two mlx5_vdpa devices,
> per [2].

I think this is reasonable and could be applied - batching is good.
Could you rebase on master and repost please?

> Future directions on top of this series may include:
> * Iterative migration of virtio-net devices, as it may reduce downtime per [3].
>   vhost-vdpa net can apply the configuration through CVQ in the destination
>   while the source is still migrating.
> * Move more things ahead of migration time, like DRIVER_OK.
> * Check that the devices of the destination are valid, and cancel the migration
>   in case it is not.
> 
> v1 from RFC v2:
> * Hold on migration if memory has not been mapped in full with switchover_ack.
> * Revert map if the device is not started.
> 
> RFC v2:
> * Delegate map to another thread so it does no block QMP.
> * Fix not allocating iova_tree if x-svq=on at the destination.
> * Rebased on latest master.
> * More cleanups of current code, that might be split from this series too.
> 
> [1] https://lists.nongnu.org/archive/html/qemu-devel/2023-12/msg01986.html
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2023-12/msg00909.html
> [3] https://lore.kernel.org/qemu-devel/6c8ebb97-d546-3f1c-4cdd-54e23a566f61@nvidia.com/T/
> 
> Eugenio Pérez (12):
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



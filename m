Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE6080D7E7
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 19:41:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rClCm-0001uk-Hf; Mon, 11 Dec 2023 13:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rClCe-0001uR-1u
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:40:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rClCY-0000YV-GP
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 13:40:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702320021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b0VVVNlLLka3oXJpf3EcaDCeeE+WMRxhKNTm+eE8E78=;
 b=I9Cu7IsCnMLBczJNI0pR4B00+fn53vfZ03cuDpy8FQ/IE/GxsMv51XKsH4au/jV4OLt8oo
 Pn6eKNYD6TBo+WXWnMThYqcIpt8u8ABdro5GR4Nl7PRCuohRKeeh6enRx4aLQJ29CbISyc
 kMI2njr+m7TWwjuK9jW2yriJcpQiFhA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-vMDuq-c0PP2NfHgzcEhgXw-1; Mon, 11 Dec 2023 13:40:19 -0500
X-MC-Unique: vMDuq-c0PP2NfHgzcEhgXw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5d12853cb89so53541327b3.3
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 10:40:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702320019; x=1702924819;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b0VVVNlLLka3oXJpf3EcaDCeeE+WMRxhKNTm+eE8E78=;
 b=Cev+gRezOrNOAmVz4wIwa1uMkxmCenjZ14Zh3qOK2XLRWJGMwigedodQoX7jEtVGcT
 03qnYhBA2qRp/Ue0TSek59UAKsDL/3AYf3RsN0FOKLScRwIjJbQH3SZkP7jHm2UPhbM2
 7RgYG/raWCuoYDsZrjzDe8+irXhwHQWFdGU38U+NKOIZWDZYFXi+QmpDpQyLYIenS1oI
 D++SWiyQxuMtpn2ooNXCqoViLVvdPTR+xDdqtKcsrYQnpaB5dx8s2lxnAIXWbPjGpNuS
 vq8vn94D59NryoB5NXPdraxtPAaSl0f01ROSPEqDwyTcQE0DISughKYb75TemB7S8oLp
 uSLA==
X-Gm-Message-State: AOJu0Yycr+u+7e3gVDob/ygPYidl0W3OmEWtfYvj8F6QQQNZcD/9XFke
 puUSQcvjAOWh3SfkJrUJEM9xJJluin3v1mQFb9SQxTKNYluHZTGinh2EKKc9KBVIIuute9n8Ibi
 O6Q87jxg2wuvGsdnXepntrQCIrm6jtM8=
X-Received: by 2002:a25:d352:0:b0:db5:474c:da0b with SMTP id
 e79-20020a25d352000000b00db5474cda0bmr2708708ybf.64.1702320018674; 
 Mon, 11 Dec 2023 10:40:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvd3koR7SZ3wYy/HKjxQzgMKa7OMKB4ddyCNU0ShYMGnzxzPQBwweXfC4YIVmDeyhpdYIxx4xJ8RcyH5xLOhg=
X-Received: by 2002:a25:d352:0:b0:db5:474c:da0b with SMTP id
 e79-20020a25d352000000b00db5474cda0bmr2708691ybf.64.1702320018407; Mon, 11
 Dec 2023 10:40:18 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 11 Dec 2023 19:39:41 +0100
Message-ID: <CAJaqyWe8F5dLEAL5y1JAkyti--hk6BHbGyu8MSChYTj4ffQHdg@mail.gmail.com>
Subject: Re: [PATCH 00/40] vdpa-net: improve migration downtime through
 descriptor ASID and persistent IOTLB
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jasowang@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Dec 7, 2023 at 7:50=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> This patch series contain several enhancements to SVQ live migration down=
time
> for vDPA-net hardware device, specifically on mlx5_vdpa. Currently it is =
based
> off of Eugenio's RFC v2 .load_setup series [1] to utilize the shared faci=
lity
> and reduce frictions in merging or duplicating code if at all possible.
>
> It's stacked up in particular order as below, as the optimization for one=
 on
> the top has to depend on others on the bottom. Here's a breakdown for wha=
t
> each part does respectively:
>
> Patch #  |          Feature / optimization
> ---------V---------------------------------------------------------------=
----
> 35 - 40  | trace events
> 34       | migrate_cancel bug fix
> 21 - 33  | (Un)map batching at stop-n-copy to further optimize LM down ti=
me
> 11 - 20  | persistent IOTLB [3] to improve LM down time
> 02 - 10  | SVQ descriptor ASID [2] to optimize SVQ switching
> 01       | dependent linux headers
>          V
>

Hi Si-Wei,

Thanks for the series, I think it contains great additions for the
live migration solution!

It is pretty large though. Do you think it would be feasible to split
out the fixes and the tracing patches in a separated series? That
would allow the reviews to focus on the downtime reduction. I think I
acked all of them.

Maybe we can even create a third series for the vring asid? I think we
should note an increase on performance using svq so it justifies by
itself too.

> Let's first define 2 sources of downtime that this work is concerned with=
:
>
> * SVQ switching downtime (Downtime #1): downtime at the start of migratio=
n.
>   Time spent on teardown and setup for SVQ mode switching, and this downt=
ime
>   is regarded as the maxium time for an individual vdpa-net device.
>   No memory transfer is involved during SVQ switching, hence no .
>
> * LM downtime (Downtime #2): aggregated downtime for all vdpa-net devices=
 on
>   resource teardown and setup in the last stop-n-copy phase on source hos=
t.
>
> With each part of the optimizations applied bottom up, the effective outc=
ome
> in terms of down time (in seconds) performance can be observed in this ta=
ble:
>
>
>                     |    Downtime #1    |    Downtime #2
> --------------------+-------------------+-------------------
> Baseline QEMU       |     20s ~ 30s     |        20s
>                     |                   |
> Iterative map       |                   |
> at destination[1]   |        5s         |        20s
>                     |                   |
> SVQ descriptor      |                   |
>     ASID [2]        |        2s         |         5s
>                     |                   |
>                     |                   |
> persistent IOTLB    |        2s         |         2s
>       [3]           |                   |
>                     |                   |
> (Un)map batching    |                   |
> at stop-n-copy      |      1.7s         |       1.5s
> before switchover   |                   |
>
> (VM config: 128GB mem, 2 mlx5_vdpa devices, each w/ 4 data vqs)
>

Thanks for all the profiling, it looks promising!

> Please find the details regarding each enhancement on the commit log.
>
> Thanks,
> -Siwei
>
>
> [1] [RFC PATCH v2 00/10] Map memory at destination .load_setup in vDPA-ne=
t migration
> https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg05711.html
> [2] VHOST_BACKEND_F_DESC_ASID
> https://lore.kernel.org/virtualization/20231018171456.1624030-2-dtatulea@=
nvidia.com/
> [3] VHOST_BACKEND_F_IOTLB_PERSIST
> https://lore.kernel.org/virtualization/1698304480-18463-1-git-send-email-=
si-wei.liu@oracle.com/
>
> ---
>
> Si-Wei Liu (40):
>   linux-headers: add vhost_types.h and vhost.h
>   vdpa: add vhost_vdpa_get_vring_desc_group
>   vdpa: probe descriptor group index for data vqs
>   vdpa: piggyback desc_group index when probing isolated cvq
>   vdpa: populate desc_group from net_vhost_vdpa_init
>   vhost: make svq work with gpa without iova translation
>   vdpa: move around vhost_vdpa_set_address_space_id
>   vdpa: add back vhost_vdpa_net_first_nc_vdpa
>   vdpa: no repeat setting shadow_data
>   vdpa: assign svq descriptors a separate ASID when possible
>   vdpa: factor out vhost_vdpa_last_dev
>   vdpa: check map_thread_enabled before join maps thread
>   vdpa: ref counting VhostVDPAShared
>   vdpa: convert iova_tree to ref count based
>   vdpa: add svq_switching and flush_map to header
>   vdpa: indicate SVQ switching via flag
>   vdpa: judge if map can be kept across reset
>   vdpa: unregister listener on last dev cleanup
>   vdpa: should avoid map flushing with persistent iotlb
>   vdpa: avoid mapping flush across reset
>   vdpa: vhost_vdpa_dma_batch_end_once rename
>   vdpa: factor out vhost_vdpa_map_batch_begin
>   vdpa: vhost_vdpa_dma_batch_begin_once rename
>   vdpa: factor out vhost_vdpa_dma_batch_end
>   vdpa: add asid to dma_batch_once API
>   vdpa: return int for dma_batch_once API
>   vdpa: add asid to all dma_batch call sites
>   vdpa: support iotlb_batch_asid
>   vdpa: expose API vhost_vdpa_dma_batch_once
>   vdpa: batch map/unmap op per svq pair basis
>   vdpa: batch map and unmap around cvq svq start/stop
>   vdpa: factor out vhost_vdpa_net_get_nc_vdpa
>   vdpa: batch multiple dma_unmap to a single call for vm stop
>   vdpa: fix network breakage after cancelling migration
>   vdpa: add vhost_vdpa_set_address_space_id trace
>   vdpa: add vhost_vdpa_get_vring_base trace for svq mode
>   vdpa: add vhost_vdpa_set_dev_vring_base trace for svq mode
>   vdpa: add trace events for eval_flush
>   vdpa: add trace events for vhost_vdpa_net_load_cmd
>   vdpa: add trace event for vhost_vdpa_net_load_mq
>
>  hw/virtio/trace-events                       |   9 +-
>  hw/virtio/vhost-shadow-virtqueue.c           |  35 ++-
>  hw/virtio/vhost-vdpa.c                       | 156 +++++++---
>  include/hw/virtio/vhost-vdpa.h               |  16 +
>  include/standard-headers/linux/vhost_types.h |  13 +
>  linux-headers/linux/vhost.h                  |   9 +
>  net/trace-events                             |   8 +
>  net/vhost-vdpa.c                             | 434 +++++++++++++++++++++=
+-----
>  8 files changed, 558 insertions(+), 122 deletions(-)
>
> --
> 1.8.3.1
>



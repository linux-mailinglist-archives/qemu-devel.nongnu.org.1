Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B507B4980
	for <lists+qemu-devel@lfdr.de>; Sun,  1 Oct 2023 21:57:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qn2YA-0000fY-Lz; Sun, 01 Oct 2023 15:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qn2Y8-0000fO-Oc
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 15:56:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qn2Y6-0007VH-Of
 for qemu-devel@nongnu.org; Sun, 01 Oct 2023 15:56:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696190177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NH9e42sIwUVsS7y5MsGyW/lDLtpNpqJo/Nw4TSR/dXM=;
 b=dUxPSEX2eINJM+jPaunKeG14uhgf3Q0iIfH8/3yXzmlaf+uwzymjMVJcla92s9+39jDJ9P
 d1KURBV3JO3k1ro6W5aR+t4T1Jj4GExCUGXJINF/dYBfU9kO9Ygpm/rQX25axCFUzeVAnJ
 g0EiUtDCsnNjZ6YQrwMx8Beg54QNblg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-8CcheggbPNKwvuPESoE6iA-1; Sun, 01 Oct 2023 15:56:14 -0400
X-MC-Unique: 8CcheggbPNKwvuPESoE6iA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40524bc3c5cso131539485e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Oct 2023 12:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696190173; x=1696794973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NH9e42sIwUVsS7y5MsGyW/lDLtpNpqJo/Nw4TSR/dXM=;
 b=dLEGrlbEdFTELiJ7RPRi53DD7SQQGYfycCM0lqUFCM/QpBBb+szHGMK0ZkGTVX0HYG
 bTKPS6MI3I0yEHx3SREW1ZRdHrgwZ9bBVmYsnrmLHR/VcwTKnF5PCa5JbKRMIzh5iq5L
 IIOCZPupxz2aJJS2eUnENF+AXCebKYNiRV4H5B925s12FXkSpf1M3vp1O6lqOSHGbHdR
 ssRFWC54bu+XH2Lov/4nKqdMOf8YHauoSPF6dUXmhMCZIA9tx7nBNqi29y4K4XQO8RfE
 G3m5d1BuwGyh7w03TDmwfIZoarjeZ8fQ73KF8GySKwFS1doljQ0eCS5UbjWMSpUOcyuI
 JOnQ==
X-Gm-Message-State: AOJu0Yw277WZIr0+D7RdcudOsRFaL7zphaDzSTHzo6Z9hrVAn33b4Zwq
 k5/+xcT7QTG+MhqALbglMC7RVWrudMHO8IdAGdWYf79LVIq7c0+DQRIPW+LNhGAX0/JQQoiJP1/
 LjgCShoCvnxgGMxQ=
X-Received: by 2002:a05:600c:2154:b0:402:fec4:fddc with SMTP id
 v20-20020a05600c215400b00402fec4fddcmr8992656wml.17.1696190173344; 
 Sun, 01 Oct 2023 12:56:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWBlF1fbz8vSYz4Hl/VzhKmFZ8G65/loLSDXeNF/9e+Df1GPezgYscFQeWOtZ0EsJOLJ4A1g==
X-Received: by 2002:a05:600c:2154:b0:402:fec4:fddc with SMTP id
 v20-20020a05600c215400b00402fec4fddcmr8992648wml.17.1696190172949; 
 Sun, 01 Oct 2023 12:56:12 -0700 (PDT)
Received: from redhat.com ([2.52.132.27]) by smtp.gmail.com with ESMTPSA id
 c25-20020adfa319000000b00324853fc8adsm8467055wrb.104.2023.10.01.12.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 12:56:12 -0700 (PDT)
Date: Sun, 1 Oct 2023 15:56:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org,
 leiyang@redhat.com, 18801353760@163.com
Subject: Re: [PATCH v4 0/8] vdpa: Send all CVQ state load commands in parallel
Message-ID: <20231001155527-mutt-send-email-mst@kernel.org>
References: <cover.1693287885.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1693287885.git.yin31149@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 29, 2023 at 01:54:42PM +0800, Hawkins Jiawei wrote:
> This patchset allows QEMU to delay polling and checking the device
> used buffer until either the SVQ is full or control commands shadow
> buffers are full, instead of polling and checking immediately after
> sending each SVQ control command, so that QEMU can send all the SVQ
> control commands in parallel, which have better performance improvement.
> 
> I use vp_vdpa device to simulate vdpa device, and create 4094 VLANS in
> guest to build a test environment for sending multiple CVQ state load
> commands. This patch series can improve latency from 20455 us to
> 13732 us for about 4099 CVQ state load commands, about 1.64 us per command.
> 
> Note that this patch should be based on
> patch "Vhost-vdpa Shadow Virtqueue VLAN support" at [1].
> 
> [1]. https://lore.kernel.org/all/cover.1690100802.git.yin31149@gmail.com/

Eugenio, you acked patch 1 but it's been a while - care to review the
rest of the patchset?

> TestStep
> ========
> 1. regression testing using vp-vdpa device
>   - For L0 guest, boot QEMU with two virtio-net-pci net device with
> `ctrl_vq`, `ctrl_rx`, `ctrl_rx_extra` features on, command line like:
>       -device virtio-net-pci,disable-legacy=on,disable-modern=off,
> iommu_platform=on,mq=on,ctrl_vq=on,guest_announce=off,
> indirect_desc=off,queue_reset=off,ctrl_rx=on,ctrl_rx_extra=on,...
> 
>   - For L1 guest, apply the patch series and compile the source code,
> start QEMU with two vdpa device with svq mode on, enable the `ctrl_vq`,
> `ctrl_rx`, `ctrl_rx_extra` features on, command line like:
>       -netdev type=vhost-vdpa,x-svq=true,...
>       -device virtio-net-pci,mq=on,guest_announce=off,ctrl_vq=on,
> ctrl_rx=on,ctrl_rx_extra=on...
> 
>   - For L2 source guest, run the following bash command:
> ```bash
> #!/bin/sh
> 
> for idx1 in {0..9}
> do
>   for idx2 in {0..9}
>   do
>     for idx3 in {0..6}
>     do
>       ip link add macvlan$idx1$idx2$idx3 link eth0
> address 4a:30:10:19:$idx1$idx2:1$idx3 type macvlan mode bridge
>       ip link set macvlan$idx1$idx2$idx3 up
>     done
>   done
> done
> ```
>   - Execute the live migration in L2 source monitor
> 
>   - Result
>     * with this series, QEMU should not trigger any error or warning.
> 
> 
> 
> 2. perf using vp-vdpa device
>   - For L0 guest, boot QEMU with two virtio-net-pci net device with
> `ctrl_vq`, `ctrl_vlan` features on, command line like:
>       -device virtio-net-pci,disable-legacy=on,disable-modern=off,
> iommu_platform=on,mq=on,ctrl_vq=on,guest_announce=off,
> indirect_desc=off,queue_reset=off,ctrl_vlan=on,...
> 
>   - For L1 guest, apply the patch series, then apply an addtional
> patch to record the load time in microseconds as following:
> ```diff
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 6b958d6363..501b510fd2 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -295,7 +295,10 @@ static int vhost_net_start_one(struct vhost_net *net,
>      }
>  
>      if (net->nc->info->load) {
> +        int64_t start_us = g_get_monotonic_time();
>          r = net->nc->info->load(net->nc);
> +        error_report("vhost_vdpa_net_load() = %ld us",
> +                     g_get_monotonic_time() - start_us);
>          if (r < 0) {
>              goto fail;
>          }
> ```
> 
>   - For L1 guest, compile the code, and start QEMU with two vdpa device
> with svq mode on, enable the `ctrl_vq`, `ctrl_vlan` features on,
> command line like:
>       -netdev type=vhost-vdpa,x-svq=true,...
>       -device virtio-net-pci,mq=on,guest_announce=off,ctrl_vq=on,
> ctrl_vlan=on...
> 
>   - For L2 source guest, run the following bash command:
> ```bash
> #!/bin/sh
> 
> for idx in {1..4094}
> do
>   ip link add link eth0 name vlan$idx type vlan id $idx
> done
> ```
> 
>   - execute the live migration in L2 source monitor
> 
>   - Result
>     * with this series, QEMU should not trigger any warning
> or error except something like "vhost_vdpa_net_load() = 13732 us"
>     * without this series, QEMU should not trigger any warning
> or error except something like "vhost_vdpa_net_load() = 20455 us"
> 
> ChangeLog
> =========
> v4:
>   - refactor subject line suggested by Eugenio in patch
> "vhost: Add count argument to vhost_svq_poll()"
>   - split `in` to `vdpa_in` and `model_in` instead of reusing `in`
> in vhost_vdpa_net_handle_ctrl_avail() suggested by Eugenio in patch
> "vdpa: Use iovec for vhost_vdpa_net_cvq_add()"
>   - pack CVQ command by iov_from_buf() instead of accessing
> `out` directly suggested by Eugenio in patch
> "vdpa: Avoid using vhost_vdpa_net_load_*() outside vhost_vdpa_net_load()"
>   - always check the return value of vhost_vdpa_net_svq_poll()
> suggested Eugenio in patch
> "vdpa: Move vhost_svq_poll() to the caller of vhost_vdpa_net_cvq_add()"
>   - use `struct iovec` instead of `void **` as cursor,
> add vhost_vdpa_net_load_cursor_reset() helper function
> to reset the cursors, refactor vhost_vdpa_net_load_cmd() to prepare buffers
> by iov_copy() instead of accessing `in` and `out` directly
> suggested by Eugenio in patch
> "vdpa: Introduce cursors to vhost_vdpa_net_loadx()"
>   - refactor argument `cmds_in_flight` to `len` for
> vhost_vdpa_net_svq_full(), check the return value of
> vhost_vdpa_net_svq_poll() in vhost_vdpa_net_svq_flush(),
> use iov_size(), vhost_vdpa_net_load_cursor_reset()
> and iov_discard_front() to update the cursors instead of
> accessing it directly according to Eugenio in patch
> "vdpa: Send cvq state load commands in parallel"
> 
> v3: https://lore.kernel.org/all/cover.1689748694.git.yin31149@gmail.com/
>   - refactor vhost_svq_poll() to accept cmds_in_flight
> suggested by Jason and Eugenio
>   - refactor vhost_vdpa_net_cvq_add() to make control commands buffers
> is not tied to `s->cvq_cmd_out_buffer` and `s->status`, so we can reuse
> it suggested by Eugenio
>   - poll and check when SVQ is full or control commands shadow buffers is
> full
> 
> v2: https://lore.kernel.org/all/cover.1683371965.git.yin31149@gmail.com/
>   - recover accidentally deleted rows
>   - remove extra newline
>   - refactor `need_poll_len` to `cmds_in_flight`
>   - return -EINVAL when vhost_svq_poll() return 0 or check
> on buffers written by device fails
>   - change the type of `in_cursor`, and refactor the
> code for updating cursor
>   - return directly when vhost_vdpa_net_load_{mac,mq}()
> returns a failure in vhost_vdpa_net_load()
> 
> v1: https://lore.kernel.org/all/cover.1681732982.git.yin31149@gmail.com/
> 
> Hawkins Jiawei (8):
>   vhost: Add count argument to vhost_svq_poll()
>   vdpa: Use iovec for vhost_vdpa_net_cvq_add()
>   vhost: Expose vhost_svq_available_slots()
>   vdpa: Avoid using vhost_vdpa_net_load_*() outside
>     vhost_vdpa_net_load()
>   vdpa: Check device ack in vhost_vdpa_net_load_rx_mode()
>   vdpa: Move vhost_svq_poll() to the caller of vhost_vdpa_net_cvq_add()
>   vdpa: Introduce cursors to vhost_vdpa_net_loadx()
>   vdpa: Send cvq state load commands in parallel
> 
>  hw/virtio/vhost-shadow-virtqueue.c |  38 +--
>  hw/virtio/vhost-shadow-virtqueue.h |   3 +-
>  net/vhost-vdpa.c                   | 380 +++++++++++++++++++----------
>  3 files changed, 276 insertions(+), 145 deletions(-)
> 
> -- 
> 2.25.1



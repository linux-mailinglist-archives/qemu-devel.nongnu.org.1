Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF6375914B
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 11:13:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM3Dq-0002Af-KH; Wed, 19 Jul 2023 05:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qM3Di-0002AG-EN
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 05:11:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qM3Dg-0007BZ-Em
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 05:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689757899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FVS01N16MreRUY0XRKU3b1eiwke1xl1hqdH/LBtrsto=;
 b=IoBYRJNf/tAdG9Az+BaF4HIcxYgQ+oDKzMjBd1OUFryUuHllnAJr5P2FwPqylGoCmdHeqb
 YAITTOErsgM8TjTqh25had2QrMdvULCd2GmjLceMe+0A3Eas2sR6pqOiJi5+tLgk8X7cxI
 Jfkh5kjSAZ8ICXQvtVEJ8CasDWdmCBs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-1RpH0SAFMHeSP2oj5AODBg-1; Wed, 19 Jul 2023 05:11:37 -0400
X-MC-Unique: 1RpH0SAFMHeSP2oj5AODBg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-314326f6e23so3709825f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 02:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689757897; x=1692349897;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVS01N16MreRUY0XRKU3b1eiwke1xl1hqdH/LBtrsto=;
 b=A+vxptj2ewxmIAKlT727y2aQKiP1tyWFD+4JoxgsxlbSSik4zc2+yv0xI6gt8dO1sU
 zEhZ4pmA3Gb81ZP4tGP2/nf/NG8osOhUktY+O5fyaLmbRgse4AS8YfhWDOZ4neKMX/L4
 9Gef419hdw1LkymrYZboBocUHC3M96nTdeApvAhd8U/RlKmu7E7M4XSvMHgKQ5iMjTID
 GWRNUs/tbs7kEewVMeSWOxCRqwFoIIzncd6JAYNXrglcGuAFYK6D/H7zofnN7fBEVMRR
 1VOhdG733HK6w/BIRF7FygRJdOr3xK9wjIaJNamfw99N+Tihr7TUl2yxySDWo8audVQi
 TMQw==
X-Gm-Message-State: ABy/qLazj4BrB3NfZ+QTOEUd/DHUdfGSPvoZ6/3iSmS/JM4AAV7Et9/Q
 iRjlcznBJqW9nfepuEpnyeIbobe8PTVWQbcDzbCqXTMU0z+pU1EcP5rKxaEUTvGwn8+vBDlgiAK
 8//8EO9qgOQWJ9mM=
X-Received: by 2002:adf:fec6:0:b0:316:f34d:68bb with SMTP id
 q6-20020adffec6000000b00316f34d68bbmr9756124wrs.54.1689757896695; 
 Wed, 19 Jul 2023 02:11:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEIm1x308DUF8EWEXHGfTAgJ4SIk0o1DEDn7gKF/Y/jlwMpHc7pYJ3VJU4f361dERAb4nF0WA==
X-Received: by 2002:adf:fec6:0:b0:316:f34d:68bb with SMTP id
 q6-20020adffec6000000b00316f34d68bbmr9756111wrs.54.1689757896320; 
 Wed, 19 Jul 2023 02:11:36 -0700 (PDT)
Received: from redhat.com ([2.52.16.41]) by smtp.gmail.com with ESMTPSA id
 q19-20020a056000137300b003143d80d11dsm4701041wrz.112.2023.07.19.02.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 02:11:35 -0700 (PDT)
Date: Wed, 19 Jul 2023 05:11:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org,
 18801353760@163.com
Subject: Re: [PATCH v3 0/8] vdpa: Send all CVQ state load commands in parallel
Message-ID: <20230719045858-mutt-send-email-mst@kernel.org>
References: <cover.1689748694.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689748694.git.yin31149@gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Wed, Jul 19, 2023 at 03:53:45PM +0800, Hawkins Jiawei wrote:
> This patchset allows QEMU to delay polling and checking the device
> used buffer until either the SVQ is full or control commands shadow
> buffers are full, instead of polling and checking immediately after
> sending each SVQ control command, so that QEMU can send all the SVQ
> control commands in parallel, which have better performance improvement.
> 
> I use vp_vdpa device to simulate vdpa device, and create 4094 VLANS in
> guest to build a test environment for sending multiple CVQ state load
> commands. This patch series can improve latency from 10023 us to
> 8697 us for about 4099 CVQ state load commands, about 0.32 us per command.

Looks like a tiny improvement.
At the same time we have O(n^2) behaviour with memory mappings.
Not saying we must not do this but I think it's worth
checking where the bottleneck is. My guess would be
vp_vdpa is not doing things in parallel. Want to try fixing that
to see how far it can be pushed?


> Note that this patch should be based on
> patch "Vhost-vdpa Shadow Virtqueue VLAN support" at [1].
> 
> [1]. https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg03719.html
> 
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
>   - wait for some time, then execute the live migration in L2 source monitor
> 
>   - Result
>     * with this series, QEMU should not trigger any warning
> or error except something like "vhost_vdpa_net_load() = 8697 us"
>     * without this series, QEMU should not trigger any warning
> or error except something like "vhost_vdpa_net_load() = 10023 us"
> 
> ChangeLog
> =========
> v3:
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
>   vhost: Add argument to vhost_svq_poll()
>   vdpa: Use iovec for vhost_vdpa_net_cvq_add()
>   vhost: Expose vhost_svq_available_slots()
>   vdpa: Avoid using vhost_vdpa_net_load_*() outside
>     vhost_vdpa_net_load()
>   vdpa: Check device ack in vhost_vdpa_net_load_rx_mode()
>   vdpa: Move vhost_svq_poll() to the caller of vhost_vdpa_net_cvq_add()
>   vdpa: Add cursors to vhost_vdpa_net_loadx()
>   vdpa: Send cvq state load commands in parallel
> 
>  hw/virtio/vhost-shadow-virtqueue.c |  38 ++--
>  hw/virtio/vhost-shadow-virtqueue.h |   3 +-
>  net/vhost-vdpa.c                   | 354 ++++++++++++++++++-----------
>  3 files changed, 249 insertions(+), 146 deletions(-)
> 
> -- 
> 2.25.1



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 486C47595D6
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 14:47:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM6Zm-0005ge-9G; Wed, 19 Jul 2023 08:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qM6Zf-0005ZB-An
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 08:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qM6Zd-0005ol-63
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 08:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689770792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ULjEyzOlOgB/MvbtHc6sz31NCku2LxnkCuP17QRXnC0=;
 b=HcpJ9I5dvL/voja1YKQuFQs4u6KMFw7+fpZwQSSCmW5+bNIlWq19FmKAUx+l/q9BuoL44o
 NQq6eo4Rb+zf4pawDAtCcbpTwHPvWQRQd1ZLyHGIaeYPdHHYtiU/eeRLfrS7DbY4+t6Yk+
 Tq1MQB7vZB+Wm+vBJcvKSP4BTUnV4I8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-S8kq1dpPN3SMvmBMKhYh4A-1; Wed, 19 Jul 2023 08:46:30 -0400
X-MC-Unique: S8kq1dpPN3SMvmBMKhYh4A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbdf34184eso36903735e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 05:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689770789; x=1692362789;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ULjEyzOlOgB/MvbtHc6sz31NCku2LxnkCuP17QRXnC0=;
 b=Oz2J+qg7BX4RUhKP5K3bYdY14PlD4MJxXrWGwbCbysB2F/gptJJ/eGjK2UqyixOOp0
 gVg6EGqKqiyOMs88X8oibJQngov5JWTR0xs4VZ+S7ar1yzGMW8OVVUqLRvy+bu0Vg3qd
 lbAH29WPVHgBJFnQ3DKxwBMDXbqQAJO2E9SS+6kEkf6OoB+tXXRAkBCxPRcLj7V+P/CF
 HDf2xHhcO2wRmOMfVCCt8ZHTc89l/lIGivt+mRA2RLRXuepZyz9NvOW6uChEerSSt6Uz
 JstbMw+9ArIFQCPWZa0P2TIi6NVmsQUHyHdHGWNPgByz/hdVBMDNp+AgOB5JfvF6pcdT
 zdCg==
X-Gm-Message-State: ABy/qLYot0EK5Ox9eUnTmPwFNhpBzJVi9OCJspZaSjCUjVrzN4G72m8s
 pR3cftPk1YyuTgsOmEsJ/JL5n0WYL8pcPtU3h5gLOEsZjG7y1TtOG2pb5j7OM7b/hiipQg8OHX3
 oNuiuTRcetOQxMiw=
X-Received: by 2002:a7b:c019:0:b0:3fb:b890:128e with SMTP id
 c25-20020a7bc019000000b003fbb890128emr1821978wmb.33.1689770789351; 
 Wed, 19 Jul 2023 05:46:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEdMcRD+vFvcJSLh0TKStlMD+KUqEtIL9ly7s4VODtKxHJbxSm/ZG2Kgaj1yI++FPcDGGQW8g==
X-Received: by 2002:a7b:c019:0:b0:3fb:b890:128e with SMTP id
 c25-20020a7bc019000000b003fbb890128emr1821965wmb.33.1689770788984; 
 Wed, 19 Jul 2023 05:46:28 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:b04e:7ffc:40d6:ae85:fe35])
 by smtp.gmail.com with ESMTPSA id
 y9-20020a7bcd89000000b003fbb1a9586esm1662408wmj.15.2023.07.19.05.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jul 2023 05:46:28 -0700 (PDT)
Date: Wed, 19 Jul 2023 08:46:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, qemu-devel@nongnu.org,
 18801353760@163.com
Subject: Re: [PATCH v3 0/8] vdpa: Send all CVQ state load commands in parallel
Message-ID: <20230719083730-mutt-send-email-mst@kernel.org>
References: <cover.1689748694.git.yin31149@gmail.com>
 <20230719045858-mutt-send-email-mst@kernel.org>
 <CAKrof1Nu+Y26=ubQKNmjdSaHTUM7Q5HRwwN_BqG4mZTsAY=CiA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKrof1Nu+Y26=ubQKNmjdSaHTUM7Q5HRwwN_BqG4mZTsAY=CiA@mail.gmail.com>
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

On Wed, Jul 19, 2023 at 08:35:50PM +0800, Hawkins Jiawei wrote:
> 在 2023/7/19 17:11, Michael S. Tsirkin 写道:
> > On Wed, Jul 19, 2023 at 03:53:45PM +0800, Hawkins Jiawei wrote:
> >> This patchset allows QEMU to delay polling and checking the device
> >> used buffer until either the SVQ is full or control commands shadow
> >> buffers are full, instead of polling and checking immediately after
> >> sending each SVQ control command, so that QEMU can send all the SVQ
> >> control commands in parallel, which have better performance improvement.
> >>
> >> I use vp_vdpa device to simulate vdpa device, and create 4094 VLANS in
> >> guest to build a test environment for sending multiple CVQ state load
> >> commands. This patch series can improve latency from 10023 us to
> >> 8697 us for about 4099 CVQ state load commands, about 0.32 us per command.
> >
> > Looks like a tiny improvement.
> > At the same time we have O(n^2) behaviour with memory mappings.
> 
> Hi Michael,
> 
> Thanks for your review.
> 
> I wonder why you say "we have O(n^2) behaviour on memory mappings" here?

it's not specific to virtio - it's related to device init.
generally each device has some memory. during boot bios
enables each individually O(n) where n is # of devices.
memory maps has to be updated and in qemu this update
is at least superlinear with n (more like O(n log n) I think).
This gets up > O(n^2) with n number of devices.

>  From my understanding, QEMU maps two page-size buffers as control
> commands shadow buffers at device startup. These buffers then are used
> to cache SVQ control commands, where QEMU fills them with multiple SVQ control
> commands bytes, flushes them when SVQ descriptors are full or these
> control commands shadow buffers reach their capacity.
> 
> QEMU repeats this process until all CVQ state load commands have been
> sent in loading.
> 
> In this loading process, only control commands shadow buffers
> translation should be relative to memory mappings, which should be
> O(log n) behaviour to my understanding(Please correct me if I am wrong).
> 
> > Not saying we must not do this but I think it's worth
> > checking where the bottleneck is. My guess would be
> > vp_vdpa is not doing things in parallel. Want to try fixing that
> 
> As for "vp_vdpa is not doing things in parallel.", do you mean
> the vp_vdpa device cannot process QEMU's SVQ control commands
> in parallel?
> 
> In this situation, I will try to use real vdpa hardware to
> test the patch series performance.

yea, pls do that.

> > to see how far it can be pushed?
> 
> Currently, I am involved in the "Add virtio-net Control Virtqueue state
> restore support" project in Google Summer of Code now. Because I am
> uncertain about the time it will take to fix that problem in the vp_vdpa
> device, I prefer to complete the gsoc project first.
> 
> Thanks!
> 
> 
> >
> >
> >> Note that this patch should be based on
> >> patch "Vhost-vdpa Shadow Virtqueue VLAN support" at [1].
> >>
> >> [1]. https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg03719.html
> >>
> >> TestStep
> >> ========
> >> 1. regression testing using vp-vdpa device
> >>    - For L0 guest, boot QEMU with two virtio-net-pci net device with
> >> `ctrl_vq`, `ctrl_rx`, `ctrl_rx_extra` features on, command line like:
> >>        -device virtio-net-pci,disable-legacy=on,disable-modern=off,
> >> iommu_platform=on,mq=on,ctrl_vq=on,guest_announce=off,
> >> indirect_desc=off,queue_reset=off,ctrl_rx=on,ctrl_rx_extra=on,...
> >>
> >>    - For L1 guest, apply the patch series and compile the source code,
> >> start QEMU with two vdpa device with svq mode on, enable the `ctrl_vq`,
> >> `ctrl_rx`, `ctrl_rx_extra` features on, command line like:
> >>        -netdev type=vhost-vdpa,x-svq=true,...
> >>        -device virtio-net-pci,mq=on,guest_announce=off,ctrl_vq=on,
> >> ctrl_rx=on,ctrl_rx_extra=on...
> >>
> >>    - For L2 source guest, run the following bash command:
> >> ```bash
> >> #!/bin/sh
> >>
> >> for idx1 in {0..9}
> >> do
> >>    for idx2 in {0..9}
> >>    do
> >>      for idx3 in {0..6}
> >>      do
> >>        ip link add macvlan$idx1$idx2$idx3 link eth0
> >> address 4a:30:10:19:$idx1$idx2:1$idx3 type macvlan mode bridge
> >>        ip link set macvlan$idx1$idx2$idx3 up
> >>      done
> >>    done
> >> done
> >> ```
> >>    - Execute the live migration in L2 source monitor
> >>
> >>    - Result
> >>      * with this series, QEMU should not trigger any error or warning.
> >>
> >>
> >>
> >> 2. perf using vp-vdpa device
> >>    - For L0 guest, boot QEMU with two virtio-net-pci net device with
> >> `ctrl_vq`, `ctrl_vlan` features on, command line like:
> >>        -device virtio-net-pci,disable-legacy=on,disable-modern=off,
> >> iommu_platform=on,mq=on,ctrl_vq=on,guest_announce=off,
> >> indirect_desc=off,queue_reset=off,ctrl_vlan=on,...
> >>
> >>    - For L1 guest, apply the patch series, then apply an addtional
> >> patch to record the load time in microseconds as following:
> >> ```diff
> >> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> >> index 6b958d6363..501b510fd2 100644
> >> --- a/hw/net/vhost_net.c
> >> +++ b/hw/net/vhost_net.c
> >> @@ -295,7 +295,10 @@ static int vhost_net_start_one(struct vhost_net *net,
> >>       }
> >>
> >>       if (net->nc->info->load) {
> >> +        int64_t start_us = g_get_monotonic_time();
> >>           r = net->nc->info->load(net->nc);
> >> +        error_report("vhost_vdpa_net_load() = %ld us",
> >> +                     g_get_monotonic_time() - start_us);
> >>           if (r < 0) {
> >>               goto fail;
> >>           }
> >> ```
> >>
> >>    - For L1 guest, compile the code, and start QEMU with two vdpa device
> >> with svq mode on, enable the `ctrl_vq`, `ctrl_vlan` features on,
> >> command line like:
> >>        -netdev type=vhost-vdpa,x-svq=true,...
> >>        -device virtio-net-pci,mq=on,guest_announce=off,ctrl_vq=on,
> >> ctrl_vlan=on...
> >>
> >>    - For L2 source guest, run the following bash command:
> >> ```bash
> >> #!/bin/sh
> >>
> >> for idx in {1..4094}
> >> do
> >>    ip link add link eth0 name vlan$idx type vlan id $idx
> >> done
> >> ```
> >>
> >>    - wait for some time, then execute the live migration in L2 source monitor
> >>
> >>    - Result
> >>      * with this series, QEMU should not trigger any warning
> >> or error except something like "vhost_vdpa_net_load() = 8697 us"
> >>      * without this series, QEMU should not trigger any warning
> >> or error except something like "vhost_vdpa_net_load() = 10023 us"
> >>
> >> ChangeLog
> >> =========
> >> v3:
> >>    - refactor vhost_svq_poll() to accept cmds_in_flight
> >> suggested by Jason and Eugenio
> >>    - refactor vhost_vdpa_net_cvq_add() to make control commands buffers
> >> is not tied to `s->cvq_cmd_out_buffer` and `s->status`, so we can reuse
> >> it suggested by Eugenio
> >>    - poll and check when SVQ is full or control commands shadow buffers is
> >> full
> >>
> >> v2: https://lore.kernel.org/all/cover.1683371965.git.yin31149@gmail.com/
> >>    - recover accidentally deleted rows
> >>    - remove extra newline
> >>    - refactor `need_poll_len` to `cmds_in_flight`
> >>    - return -EINVAL when vhost_svq_poll() return 0 or check
> >> on buffers written by device fails
> >>    - change the type of `in_cursor`, and refactor the
> >> code for updating cursor
> >>    - return directly when vhost_vdpa_net_load_{mac,mq}()
> >> returns a failure in vhost_vdpa_net_load()
> >>
> >> v1: https://lore.kernel.org/all/cover.1681732982.git.yin31149@gmail.com/
> >>
> >> Hawkins Jiawei (8):
> >>    vhost: Add argument to vhost_svq_poll()
> >>    vdpa: Use iovec for vhost_vdpa_net_cvq_add()
> >>    vhost: Expose vhost_svq_available_slots()
> >>    vdpa: Avoid using vhost_vdpa_net_load_*() outside
> >>      vhost_vdpa_net_load()
> >>    vdpa: Check device ack in vhost_vdpa_net_load_rx_mode()
> >>    vdpa: Move vhost_svq_poll() to the caller of vhost_vdpa_net_cvq_add()
> >>    vdpa: Add cursors to vhost_vdpa_net_loadx()
> >>    vdpa: Send cvq state load commands in parallel
> >>
> >>   hw/virtio/vhost-shadow-virtqueue.c |  38 ++--
> >>   hw/virtio/vhost-shadow-virtqueue.h |   3 +-
> >>   net/vhost-vdpa.c                   | 354 ++++++++++++++++++-----------
> >>   3 files changed, 249 insertions(+), 146 deletions(-)
> >>
> >> --
> >> 2.25.1
> >



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E50F7B70BD
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 20:24:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnk2Z-0003nV-7k; Tue, 03 Oct 2023 14:22:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qnk2V-0003mZ-V8
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qnk2T-0008E8-Sw
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 14:22:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696357352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5pB5RAGKmuf18mm9yCyhsD9z+meFtHcLB/3NCubVHDA=;
 b=BDEQus9NxicltlRzApzWC6aSFZiBz1vKpvBIw2bZLzHQjJktTD2UTxyst0j5hFL33GSFUF
 YWG1N+lS0g1JbJ4DVsAwxQT+rryJD9eSjrlKK8WzalY5m8G6GsF8L1137xFw7RWKvjDeqv
 YP4if/txUfq6+En7qhEVae6QkJnc9TM=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-v0_z0JRlMoeIgddEGjcB2w-1; Tue, 03 Oct 2023 14:22:29 -0400
X-MC-Unique: v0_z0JRlMoeIgddEGjcB2w-1
Received: by mail-yb1-f200.google.com with SMTP id
 3f1490d57ef6-d84acda47aeso1477780276.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 11:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696357349; x=1696962149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5pB5RAGKmuf18mm9yCyhsD9z+meFtHcLB/3NCubVHDA=;
 b=r1i5QEghScmAUACDcQtL1l+ft0YM6RPWa6OTRCdC9xNTWLbdMooS8nHNQnvrzPj/13
 zEyCz1zprIgXd8+b1peo3FN8VWREZmWZL1QXoqeH+gMfSbO2EDcnB3QjP1LFGAaR8asC
 R3yqUCJ17Vs8piCPH+VuR7CRzbPD9c7aJwNNWcwAf19hdCHmTtJfJ/TO4n1r5TLFSDn0
 UhS+aQwFn5jW+ejYThGBxW/9+SuvPPuymnH6eJzN0PfIsisTJV6Jlpb3GG3EZceoy/HO
 KvdP1+b0asDcpVBy6IaCTesixVJIJxr8kDG/Nxb/uhSDkw6FNYrmX/gOwGMr6/mPyB9K
 Wylg==
X-Gm-Message-State: AOJu0YwY/hvDPFEeNmS5PAaJqNwC2XwebJzYun5C2ZoHUmOZLWXoK81p
 SjrK9U9pBYcBSJ9oZ4blVMxRzVBOnWCauYy84ME72AhqjoHAmH3b3+GVKvKI8VCOsH1Q8s0nkMz
 7YvkG/3eo/bM75dkI0F4dq/o2ldrpNyM=
X-Received: by 2002:a25:5889:0:b0:d71:6bc4:ac6d with SMTP id
 m131-20020a255889000000b00d716bc4ac6dmr24340ybb.65.1696357349038; 
 Tue, 03 Oct 2023 11:22:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFy6kqrcSfDuVtnbIOqWtlr7/9vwgWP0N1q05lAF/DaSZDAjhplN4NLaqZBgbGOawxn1uGhQI78x4HJ9bPqYc=
X-Received: by 2002:a25:5889:0:b0:d71:6bc4:ac6d with SMTP id
 m131-20020a255889000000b00d716bc4ac6dmr24321ybb.65.1696357348740; Tue, 03 Oct
 2023 11:22:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693287885.git.yin31149@gmail.com>
 <20231001155527-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231001155527-mutt-send-email-mst@kernel.org>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 3 Oct 2023 20:21:51 +0200
Message-ID: <CAJaqyWcQu10d6z+qeKSHEunFMKEnGPzyNRrjt0=pHywtRcb2Kw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] vdpa: Send all CVQ state load commands in parallel
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hawkins Jiawei <yin31149@gmail.com>, jasowang@redhat.com,
 qemu-devel@nongnu.org, leiyang@redhat.com, 18801353760@163.com
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

On Sun, Oct 1, 2023 at 9:56=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Tue, Aug 29, 2023 at 01:54:42PM +0800, Hawkins Jiawei wrote:
> > This patchset allows QEMU to delay polling and checking the device
> > used buffer until either the SVQ is full or control commands shadow
> > buffers are full, instead of polling and checking immediately after
> > sending each SVQ control command, so that QEMU can send all the SVQ
> > control commands in parallel, which have better performance improvement=
.
> >
> > I use vp_vdpa device to simulate vdpa device, and create 4094 VLANS in
> > guest to build a test environment for sending multiple CVQ state load
> > commands. This patch series can improve latency from 20455 us to
> > 13732 us for about 4099 CVQ state load commands, about 1.64 us per comm=
and.
> >
> > Note that this patch should be based on
> > patch "Vhost-vdpa Shadow Virtqueue VLAN support" at [1].
> >
> > [1]. https://lore.kernel.org/all/cover.1690100802.git.yin31149@gmail.co=
m/
>
> Eugenio, you acked patch 1 but it's been a while - care to review the
> rest of the patchset?
>

I'm sorry, I was under the impression that this should go after
optimizing the memory maps.

I'll continue with the revision.

Thanks!

> > TestStep
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > 1. regression testing using vp-vdpa device
> >   - For L0 guest, boot QEMU with two virtio-net-pci net device with
> > `ctrl_vq`, `ctrl_rx`, `ctrl_rx_extra` features on, command line like:
> >       -device virtio-net-pci,disable-legacy=3Don,disable-modern=3Doff,
> > iommu_platform=3Don,mq=3Don,ctrl_vq=3Don,guest_announce=3Doff,
> > indirect_desc=3Doff,queue_reset=3Doff,ctrl_rx=3Don,ctrl_rx_extra=3Don,.=
..
> >
> >   - For L1 guest, apply the patch series and compile the source code,
> > start QEMU with two vdpa device with svq mode on, enable the `ctrl_vq`,
> > `ctrl_rx`, `ctrl_rx_extra` features on, command line like:
> >       -netdev type=3Dvhost-vdpa,x-svq=3Dtrue,...
> >       -device virtio-net-pci,mq=3Don,guest_announce=3Doff,ctrl_vq=3Don,
> > ctrl_rx=3Don,ctrl_rx_extra=3Don...
> >
> >   - For L2 source guest, run the following bash command:
> > ```bash
> > #!/bin/sh
> >
> > for idx1 in {0..9}
> > do
> >   for idx2 in {0..9}
> >   do
> >     for idx3 in {0..6}
> >     do
> >       ip link add macvlan$idx1$idx2$idx3 link eth0
> > address 4a:30:10:19:$idx1$idx2:1$idx3 type macvlan mode bridge
> >       ip link set macvlan$idx1$idx2$idx3 up
> >     done
> >   done
> > done
> > ```
> >   - Execute the live migration in L2 source monitor
> >
> >   - Result
> >     * with this series, QEMU should not trigger any error or warning.
> >
> >
> >
> > 2. perf using vp-vdpa device
> >   - For L0 guest, boot QEMU with two virtio-net-pci net device with
> > `ctrl_vq`, `ctrl_vlan` features on, command line like:
> >       -device virtio-net-pci,disable-legacy=3Don,disable-modern=3Doff,
> > iommu_platform=3Don,mq=3Don,ctrl_vq=3Don,guest_announce=3Doff,
> > indirect_desc=3Doff,queue_reset=3Doff,ctrl_vlan=3Don,...
> >
> >   - For L1 guest, apply the patch series, then apply an addtional
> > patch to record the load time in microseconds as following:
> > ```diff
> > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > index 6b958d6363..501b510fd2 100644
> > --- a/hw/net/vhost_net.c
> > +++ b/hw/net/vhost_net.c
> > @@ -295,7 +295,10 @@ static int vhost_net_start_one(struct vhost_net *n=
et,
> >      }
> >
> >      if (net->nc->info->load) {
> > +        int64_t start_us =3D g_get_monotonic_time();
> >          r =3D net->nc->info->load(net->nc);
> > +        error_report("vhost_vdpa_net_load() =3D %ld us",
> > +                     g_get_monotonic_time() - start_us);
> >          if (r < 0) {
> >              goto fail;
> >          }
> > ```
> >
> >   - For L1 guest, compile the code, and start QEMU with two vdpa device
> > with svq mode on, enable the `ctrl_vq`, `ctrl_vlan` features on,
> > command line like:
> >       -netdev type=3Dvhost-vdpa,x-svq=3Dtrue,...
> >       -device virtio-net-pci,mq=3Don,guest_announce=3Doff,ctrl_vq=3Don,
> > ctrl_vlan=3Don...
> >
> >   - For L2 source guest, run the following bash command:
> > ```bash
> > #!/bin/sh
> >
> > for idx in {1..4094}
> > do
> >   ip link add link eth0 name vlan$idx type vlan id $idx
> > done
> > ```
> >
> >   - execute the live migration in L2 source monitor
> >
> >   - Result
> >     * with this series, QEMU should not trigger any warning
> > or error except something like "vhost_vdpa_net_load() =3D 13732 us"
> >     * without this series, QEMU should not trigger any warning
> > or error except something like "vhost_vdpa_net_load() =3D 20455 us"
> >
> > ChangeLog
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > v4:
> >   - refactor subject line suggested by Eugenio in patch
> > "vhost: Add count argument to vhost_svq_poll()"
> >   - split `in` to `vdpa_in` and `model_in` instead of reusing `in`
> > in vhost_vdpa_net_handle_ctrl_avail() suggested by Eugenio in patch
> > "vdpa: Use iovec for vhost_vdpa_net_cvq_add()"
> >   - pack CVQ command by iov_from_buf() instead of accessing
> > `out` directly suggested by Eugenio in patch
> > "vdpa: Avoid using vhost_vdpa_net_load_*() outside vhost_vdpa_net_load(=
)"
> >   - always check the return value of vhost_vdpa_net_svq_poll()
> > suggested Eugenio in patch
> > "vdpa: Move vhost_svq_poll() to the caller of vhost_vdpa_net_cvq_add()"
> >   - use `struct iovec` instead of `void **` as cursor,
> > add vhost_vdpa_net_load_cursor_reset() helper function
> > to reset the cursors, refactor vhost_vdpa_net_load_cmd() to prepare buf=
fers
> > by iov_copy() instead of accessing `in` and `out` directly
> > suggested by Eugenio in patch
> > "vdpa: Introduce cursors to vhost_vdpa_net_loadx()"
> >   - refactor argument `cmds_in_flight` to `len` for
> > vhost_vdpa_net_svq_full(), check the return value of
> > vhost_vdpa_net_svq_poll() in vhost_vdpa_net_svq_flush(),
> > use iov_size(), vhost_vdpa_net_load_cursor_reset()
> > and iov_discard_front() to update the cursors instead of
> > accessing it directly according to Eugenio in patch
> > "vdpa: Send cvq state load commands in parallel"
> >
> > v3: https://lore.kernel.org/all/cover.1689748694.git.yin31149@gmail.com=
/
> >   - refactor vhost_svq_poll() to accept cmds_in_flight
> > suggested by Jason and Eugenio
> >   - refactor vhost_vdpa_net_cvq_add() to make control commands buffers
> > is not tied to `s->cvq_cmd_out_buffer` and `s->status`, so we can reuse
> > it suggested by Eugenio
> >   - poll and check when SVQ is full or control commands shadow buffers =
is
> > full
> >
> > v2: https://lore.kernel.org/all/cover.1683371965.git.yin31149@gmail.com=
/
> >   - recover accidentally deleted rows
> >   - remove extra newline
> >   - refactor `need_poll_len` to `cmds_in_flight`
> >   - return -EINVAL when vhost_svq_poll() return 0 or check
> > on buffers written by device fails
> >   - change the type of `in_cursor`, and refactor the
> > code for updating cursor
> >   - return directly when vhost_vdpa_net_load_{mac,mq}()
> > returns a failure in vhost_vdpa_net_load()
> >
> > v1: https://lore.kernel.org/all/cover.1681732982.git.yin31149@gmail.com=
/
> >
> > Hawkins Jiawei (8):
> >   vhost: Add count argument to vhost_svq_poll()
> >   vdpa: Use iovec for vhost_vdpa_net_cvq_add()
> >   vhost: Expose vhost_svq_available_slots()
> >   vdpa: Avoid using vhost_vdpa_net_load_*() outside
> >     vhost_vdpa_net_load()
> >   vdpa: Check device ack in vhost_vdpa_net_load_rx_mode()
> >   vdpa: Move vhost_svq_poll() to the caller of vhost_vdpa_net_cvq_add()
> >   vdpa: Introduce cursors to vhost_vdpa_net_loadx()
> >   vdpa: Send cvq state load commands in parallel
> >
> >  hw/virtio/vhost-shadow-virtqueue.c |  38 +--
> >  hw/virtio/vhost-shadow-virtqueue.h |   3 +-
> >  net/vhost-vdpa.c                   | 380 +++++++++++++++++++----------
> >  3 files changed, 276 insertions(+), 145 deletions(-)
> >
> > --
> > 2.25.1
>



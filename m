Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFA975A28E
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 00:57:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMG4t-00053N-R7; Wed, 19 Jul 2023 18:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qMG4q-000537-DZ
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 18:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qMG4o-0005ED-3h
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 18:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689807320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W/bj+H8dvg7LE2a7tQOH9TZExpovKVdAPIh7DSw6YeU=;
 b=gh8pacfRPfGnsaDUmlNCdfsLdWaEsnSHjxshqm7J3DSZEyci7mopWe/Hy9TOKkQ9ch2pce
 iQ59BfxIVOvjpgT+tB+EAmDb3h1CtGFH174z/jE4gYNqenT9wOoEwhm+5xv+UQgCIqYEgQ
 4a6maNTYi2/TS15PIDVBKjpJ5oaa8KU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-DD6KaOJTPWaX6splcU64ww-1; Wed, 19 Jul 2023 18:55:18 -0400
X-MC-Unique: DD6KaOJTPWaX6splcU64ww-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-51a38fb9dc8so52793a12.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 15:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689807317; x=1690412117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/bj+H8dvg7LE2a7tQOH9TZExpovKVdAPIh7DSw6YeU=;
 b=g0sR3EqMsXyXRVpHXOnLWLf8ezzGi0HijWroANAiZKD/L4rrZtfTa48VBXnPAhdm0r
 XUZn8DAekGIoxj+yfWMfcDn1WH0fGUe9Zo5gLyrFTcaxg+8BAftc+3XJqir8YiySpZd9
 CG70TdjUkbcW3XKmOeyaLUDyBVOs1+hhQ/pOBjSVtagM4/bQPLlgAeMACyErdhtfMveK
 kNDKe47i9pEAxeanMSf6LiPpMSJoZoS22Q0tEUnze+lPyaxJElIHGkav/R6uE1HpgKCp
 U7yS+q56EJtmuu8ZSRwHBUPrl2nS+IbfMMnLBfKtjBs/cTDfYuzipgqOlBwiinCi3naE
 IKyA==
X-Gm-Message-State: ABy/qLYuITCgDQGZG7YT560lYQ6kpax9SJw2ekCoztowtmmFWhM+oITq
 BOzUH9oN0Gaf3mPNxjgDTPt/VKwMtvbsnqzNWlIMwm/rfz85tB5Xowp91/N6EYnyBk3+m/GHss2
 AtNUu1IY//ARGpEZ+7K0ICEbCXZb68z4=
X-Received: by 2002:a05:6402:514f:b0:51a:2c81:72ee with SMTP id
 n15-20020a056402514f00b0051a2c8172eemr3497068edd.20.1689807317199; 
 Wed, 19 Jul 2023 15:55:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHFdGGBLjVb6UuLmYseFqxbNPHf268sIDSMqg3VswrCWSCkjeefIBS69dSGYJXMcr+Xl+BEiTo9rBYCBKy8yxk=
X-Received: by 2002:a05:6402:514f:b0:51a:2c81:72ee with SMTP id
 n15-20020a056402514f00b0051a2c8172eemr3497058edd.20.1689807316840; Wed, 19
 Jul 2023 15:55:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689748694.git.yin31149@gmail.com>
 <20230719045858-mutt-send-email-mst@kernel.org>
 <CAKrof1Nu+Y26=ubQKNmjdSaHTUM7Q5HRwwN_BqG4mZTsAY=CiA@mail.gmail.com>
 <CAPpAL=xwDgafOGf_W+oduR0FKJMKYYz+KWyouNPyGWbzNZEnsw@mail.gmail.com>
 <CAKrof1PV=d5thAMW2cPcEuu2jQF4ohw=mLp9qh8p2shOj=BYWw@mail.gmail.com>
In-Reply-To: <CAKrof1PV=d5thAMW2cPcEuu2jQF4ohw=mLp9qh8p2shOj=BYWw@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 20 Jul 2023 06:54:39 +0800
Message-ID: <CAPpAL=zsf0OgwE3973OVH141doqdKLo5CS93no6z3jhxRG+_EA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] vdpa: Send all CVQ state load commands in parallel
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 eperezma@redhat.com, qemu-devel@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leiyang@redhat.com;
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

On Wed, Jul 19, 2023 at 11:25=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com=
> wrote:
>
> =E5=9C=A8 2023/7/19 20:44, Lei Yang =E5=86=99=E9=81=93:
> > Hello Hawkins and Michael
> >
> > Looks like there are big changes about vp_vdpa, therefore, if needed,
> > QE can test this series in QE's environment before the patch is
>
> Hi Lei,
>
> This patch series does not modify the code of vp_vdpa. Instead, it only
> modifies how QEMU sends SVQ control commands to the vdpa device.
>
Hi Hawkins

> Considering that the behavior of the vp_vdpa device differs from that
> of real vdpa hardware, would it be possible for you to test this patch
> series on a real vdpa device?

Yes, there is a hardware device to test it , I will update the test
results ASAP.

BR
Lei
>
> Thanks!
>
>
> > merged, and provide the result.
> >
> > BR
> > Lei
> >
> >
> > On Wed, Jul 19, 2023 at 8:37=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.=
com> wrote:
> >>
> >> =E5=9C=A8 2023/7/19 17:11, Michael S. Tsirkin =E5=86=99=E9=81=93:
> >>> On Wed, Jul 19, 2023 at 03:53:45PM +0800, Hawkins Jiawei wrote:
> >>>> This patchset allows QEMU to delay polling and checking the device
> >>>> used buffer until either the SVQ is full or control commands shadow
> >>>> buffers are full, instead of polling and checking immediately after
> >>>> sending each SVQ control command, so that QEMU can send all the SVQ
> >>>> control commands in parallel, which have better performance improvem=
ent.
> >>>>
> >>>> I use vp_vdpa device to simulate vdpa device, and create 4094 VLANS =
in
> >>>> guest to build a test environment for sending multiple CVQ state loa=
d
> >>>> commands. This patch series can improve latency from 10023 us to
> >>>> 8697 us for about 4099 CVQ state load commands, about 0.32 us per co=
mmand.
> >>>
> >>> Looks like a tiny improvement.
> >>> At the same time we have O(n^2) behaviour with memory mappings.
> >>
> >> Hi Michael,
> >>
> >> Thanks for your review.
> >>
> >> I wonder why you say "we have O(n^2) behaviour on memory mappings" her=
e?
> >>
> >>   From my understanding, QEMU maps two page-size buffers as control
> >> commands shadow buffers at device startup. These buffers then are used
> >> to cache SVQ control commands, where QEMU fills them with multiple SVQ=
 control
> >> commands bytes, flushes them when SVQ descriptors are full or these
> >> control commands shadow buffers reach their capacity.
> >>
> >> QEMU repeats this process until all CVQ state load commands have been
> >> sent in loading.
> >>
> >> In this loading process, only control commands shadow buffers
> >> translation should be relative to memory mappings, which should be
> >> O(log n) behaviour to my understanding(Please correct me if I am wrong=
).
> >>
> >>> Not saying we must not do this but I think it's worth
> >>> checking where the bottleneck is. My guess would be
> >>> vp_vdpa is not doing things in parallel. Want to try fixing that
> >>
> >> As for "vp_vdpa is not doing things in parallel.", do you mean
> >> the vp_vdpa device cannot process QEMU's SVQ control commands
> >> in parallel?
> >>
> >> In this situation, I will try to use real vdpa hardware to
> >> test the patch series performance.
> >>
> >>> to see how far it can be pushed?
> >>
> >> Currently, I am involved in the "Add virtio-net Control Virtqueue stat=
e
> >> restore support" project in Google Summer of Code now. Because I am
> >> uncertain about the time it will take to fix that problem in the vp_vd=
pa
> >> device, I prefer to complete the gsoc project first.
> >>
> >> Thanks!
> >>
> >>
> >>>
> >>>
> >>>> Note that this patch should be based on
> >>>> patch "Vhost-vdpa Shadow Virtqueue VLAN support" at [1].
> >>>>
> >>>> [1]. https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg03719.=
html
> >>>>
> >>>> TestStep
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D
> >>>> 1. regression testing using vp-vdpa device
> >>>>     - For L0 guest, boot QEMU with two virtio-net-pci net device wit=
h
> >>>> `ctrl_vq`, `ctrl_rx`, `ctrl_rx_extra` features on, command line like=
:
> >>>>         -device virtio-net-pci,disable-legacy=3Don,disable-modern=3D=
off,
> >>>> iommu_platform=3Don,mq=3Don,ctrl_vq=3Don,guest_announce=3Doff,
> >>>> indirect_desc=3Doff,queue_reset=3Doff,ctrl_rx=3Don,ctrl_rx_extra=3Do=
n,...
> >>>>
> >>>>     - For L1 guest, apply the patch series and compile the source co=
de,
> >>>> start QEMU with two vdpa device with svq mode on, enable the `ctrl_v=
q`,
> >>>> `ctrl_rx`, `ctrl_rx_extra` features on, command line like:
> >>>>         -netdev type=3Dvhost-vdpa,x-svq=3Dtrue,...
> >>>>         -device virtio-net-pci,mq=3Don,guest_announce=3Doff,ctrl_vq=
=3Don,
> >>>> ctrl_rx=3Don,ctrl_rx_extra=3Don...
> >>>>
> >>>>     - For L2 source guest, run the following bash command:
> >>>> ```bash
> >>>> #!/bin/sh
> >>>>
> >>>> for idx1 in {0..9}
> >>>> do
> >>>>     for idx2 in {0..9}
> >>>>     do
> >>>>       for idx3 in {0..6}
> >>>>       do
> >>>>         ip link add macvlan$idx1$idx2$idx3 link eth0
> >>>> address 4a:30:10:19:$idx1$idx2:1$idx3 type macvlan mode bridge
> >>>>         ip link set macvlan$idx1$idx2$idx3 up
> >>>>       done
> >>>>     done
> >>>> done
> >>>> ```
> >>>>     - Execute the live migration in L2 source monitor
> >>>>
> >>>>     - Result
> >>>>       * with this series, QEMU should not trigger any error or warni=
ng.
> >>>>
> >>>>
> >>>>
> >>>> 2. perf using vp-vdpa device
> >>>>     - For L0 guest, boot QEMU with two virtio-net-pci net device wit=
h
> >>>> `ctrl_vq`, `ctrl_vlan` features on, command line like:
> >>>>         -device virtio-net-pci,disable-legacy=3Don,disable-modern=3D=
off,
> >>>> iommu_platform=3Don,mq=3Don,ctrl_vq=3Don,guest_announce=3Doff,
> >>>> indirect_desc=3Doff,queue_reset=3Doff,ctrl_vlan=3Don,...
> >>>>
> >>>>     - For L1 guest, apply the patch series, then apply an addtional
> >>>> patch to record the load time in microseconds as following:
> >>>> ```diff
> >>>> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> >>>> index 6b958d6363..501b510fd2 100644
> >>>> --- a/hw/net/vhost_net.c
> >>>> +++ b/hw/net/vhost_net.c
> >>>> @@ -295,7 +295,10 @@ static int vhost_net_start_one(struct vhost_net=
 *net,
> >>>>        }
> >>>>
> >>>>        if (net->nc->info->load) {
> >>>> +        int64_t start_us =3D g_get_monotonic_time();
> >>>>            r =3D net->nc->info->load(net->nc);
> >>>> +        error_report("vhost_vdpa_net_load() =3D %ld us",
> >>>> +                     g_get_monotonic_time() - start_us);
> >>>>            if (r < 0) {
> >>>>                goto fail;
> >>>>            }
> >>>> ```
> >>>>
> >>>>     - For L1 guest, compile the code, and start QEMU with two vdpa d=
evice
> >>>> with svq mode on, enable the `ctrl_vq`, `ctrl_vlan` features on,
> >>>> command line like:
> >>>>         -netdev type=3Dvhost-vdpa,x-svq=3Dtrue,...
> >>>>         -device virtio-net-pci,mq=3Don,guest_announce=3Doff,ctrl_vq=
=3Don,
> >>>> ctrl_vlan=3Don...
> >>>>
> >>>>     - For L2 source guest, run the following bash command:
> >>>> ```bash
> >>>> #!/bin/sh
> >>>>
> >>>> for idx in {1..4094}
> >>>> do
> >>>>     ip link add link eth0 name vlan$idx type vlan id $idx
> >>>> done
> >>>> ```
> >>>>
> >>>>     - wait for some time, then execute the live migration in L2 sour=
ce monitor
> >>>>
> >>>>     - Result
> >>>>       * with this series, QEMU should not trigger any warning
> >>>> or error except something like "vhost_vdpa_net_load() =3D 8697 us"
> >>>>       * without this series, QEMU should not trigger any warning
> >>>> or error except something like "vhost_vdpa_net_load() =3D 10023 us"
> >>>>
> >>>> ChangeLog
> >>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>> v3:
> >>>>     - refactor vhost_svq_poll() to accept cmds_in_flight
> >>>> suggested by Jason and Eugenio
> >>>>     - refactor vhost_vdpa_net_cvq_add() to make control commands buf=
fers
> >>>> is not tied to `s->cvq_cmd_out_buffer` and `s->status`, so we can re=
use
> >>>> it suggested by Eugenio
> >>>>     - poll and check when SVQ is full or control commands shadow buf=
fers is
> >>>> full
> >>>>
> >>>> v2: https://lore.kernel.org/all/cover.1683371965.git.yin31149@gmail.=
com/
> >>>>     - recover accidentally deleted rows
> >>>>     - remove extra newline
> >>>>     - refactor `need_poll_len` to `cmds_in_flight`
> >>>>     - return -EINVAL when vhost_svq_poll() return 0 or check
> >>>> on buffers written by device fails
> >>>>     - change the type of `in_cursor`, and refactor the
> >>>> code for updating cursor
> >>>>     - return directly when vhost_vdpa_net_load_{mac,mq}()
> >>>> returns a failure in vhost_vdpa_net_load()
> >>>>
> >>>> v1: https://lore.kernel.org/all/cover.1681732982.git.yin31149@gmail.=
com/
> >>>>
> >>>> Hawkins Jiawei (8):
> >>>>     vhost: Add argument to vhost_svq_poll()
> >>>>     vdpa: Use iovec for vhost_vdpa_net_cvq_add()
> >>>>     vhost: Expose vhost_svq_available_slots()
> >>>>     vdpa: Avoid using vhost_vdpa_net_load_*() outside
> >>>>       vhost_vdpa_net_load()
> >>>>     vdpa: Check device ack in vhost_vdpa_net_load_rx_mode()
> >>>>     vdpa: Move vhost_svq_poll() to the caller of vhost_vdpa_net_cvq_=
add()
> >>>>     vdpa: Add cursors to vhost_vdpa_net_loadx()
> >>>>     vdpa: Send cvq state load commands in parallel
> >>>>
> >>>>    hw/virtio/vhost-shadow-virtqueue.c |  38 ++--
> >>>>    hw/virtio/vhost-shadow-virtqueue.h |   3 +-
> >>>>    net/vhost-vdpa.c                   | 354 ++++++++++++++++++------=
-----
> >>>>    3 files changed, 249 insertions(+), 146 deletions(-)
> >>>>
> >>>> --
> >>>> 2.25.1
> >>>
> >>
> >
>



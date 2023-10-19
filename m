Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 861E87CFD79
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:01:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUWB-0006SB-F8; Thu, 19 Oct 2023 11:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtUW8-0006RE-7n
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:00:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qtUW6-0000Hl-9S
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697727653;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7/aVhq+QiOzWDu/inl/wyWRRuvBnEcox2pup5PdDHg=;
 b=OKGHj1TpTSTkskz2mQvH3GuarUdAnwjoZqY6O5GC1N8KSlyhjdJnrkSHHbFhOP4madybgR
 MgN73gz1g/apMmcP/QloTZeXPw+FannF9YLvtxDLqqlHUOyQeUp8Hue+N/IhMS2dY7VcWA
 8Y1pl1ULG+QPmoL+QQB/bOEUyK2otvA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-Jaj2bckvPlmcj-nTOOKMZg-1; Thu, 19 Oct 2023 11:00:51 -0400
X-MC-Unique: Jaj2bckvPlmcj-nTOOKMZg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-5a7aa161b2fso124887467b3.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 08:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727650; x=1698332450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z7/aVhq+QiOzWDu/inl/wyWRRuvBnEcox2pup5PdDHg=;
 b=xOiMIxXugx5WEEGKB7uYT48gVxsZelDYIR84B8D+KXihsypJUwp5RQJ6unV+Qt19+T
 Jowz+JWPma2FDJ2lhW/1IkpkEX9X9gxxLxb82RK47YAuMd3TSG81i2uE71gDlBEK1aQB
 UotTmyvJwM2x/ObBhodyVm9V7/CH3sgvawseSTaq4lvT0+nV45dNcuNn/PwCzlbNWrez
 gXS73R5Nal41MclcmdzaX6wesNMEz0tFJw/wNEV+cLJDmOIlLZF3tr83IXoKu0Vbzi84
 rF7+SrSmJRzBKnh6jCD9yTsMWKWMO2Wc79lTlDXgAxofPyAHWrQlbJo/y6cw7M8/biRw
 Yx4g==
X-Gm-Message-State: AOJu0YwT5EF+QKuGm/NQvkhg1ndKNc0IrKt1BOiV8nHvCrk5OqkUGIpl
 rRA/irWdvDuPUO2+Bt8xQvVOkd/RNbPQkj5K4x5q4QpMTyATQZZlwIlbBpk0u2Hw7e0Rg6SbO+t
 Obp4JBb1RWO/LY/FjP9yEehxdkft6YQ0=
X-Received: by 2002:a25:8811:0:b0:d9b:d61e:2370 with SMTP id
 c17-20020a258811000000b00d9bd61e2370mr2816418ybl.12.1697727649153; 
 Thu, 19 Oct 2023 08:00:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF95PX07qtmqcjMPey0XulP8HKzCkygRITdMPRMonF9gbN7iwsl0KIQ74YBPmWKkt/7y2Bxn9zPrp3WvXvQK/4=
X-Received: by 2002:a25:8811:0:b0:d9b:d61e:2370 with SMTP id
 c17-20020a258811000000b00d9bd61e2370mr2816379ybl.12.1697727648661; Thu, 19
 Oct 2023 08:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230918044932.1433744-1-yajunw@nvidia.com>
 <CAJaqyWfuXDY7jBSQsS=0Ws7mpZLcsed6bpQbM+eZGLU5AzCw1Q@mail.gmail.com>
 <6d9b034f-fe16-7ed8-6156-9c404a860489@nvidia.com>
In-Reply-To: <6d9b034f-fe16-7ed8-6156-9c404a860489@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Thu, 19 Oct 2023 17:00:12 +0200
Message-ID: <CAJaqyWdLHdXpTdnxdMn6SbvKywFB7oD=m806TebUcR23u7iokg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] virtio-net: Introduce LM early load
To: Yajun Wu <yajunw@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, parav@nvidia.com, jiri@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 18, 2023 at 8:41=E2=80=AFAM Yajun Wu <yajunw@nvidia.com> wrote:
>
>
> On 10/18/2023 12:47 AM, Eugenio Perez Martin wrote:
> > External email: Use caution opening links or attachments
> >
> >
> > On Mon, Sep 18, 2023 at 6:51=E2=80=AFAM Yajun Wu <yajunw@nvidia.com> wr=
ote:
> >> This series of patches aims to minimize the downtime during live migra=
tion of a
> >> virtio-net device with a vhost-user backend. In the case of hardware v=
irtual
> >> Data Path Acceleration (vDPA) implementation, the hardware configurati=
on, which
> >> includes tasks like VQ creation and RSS setting, may take above 200ms.=
 This
> >> significantly increases the downtime of the VM, particularly in terms =
of
> >> networking.
> >>
> > Hi!
> >
> > Sorry I totally missed this email. Please CC me in next versions.
> >
> > Just for completion, there is an ongoing plan to reduce the downtime
> > in vhost-vdpa. You can find more details at [1].
> >
> > To send the state periodically is in the roadmap, but some
> > benchmarking detected that memory pinning and unpinning affects more
> > to downtime. I'll send a RFC soon with this. The plan was to continue
> > with iterative state restoring, so I'm happy to know more people are
> > looking into it!
> >
> > In the case of vhost-vdpa it already restores the state by not
> > enabling dataplane until migration completes. All the load is
> > performed using CVQ, as you can see in
> > net/vhost-vdpa.c:vhost_vdpa_net_load. After that, all dataplane is
> > started again.
> >
> > My idea is to start vhost-vdpa (by calling vhost_vdpa_dev_start) at
> > the destination at the same moment the migration starts, as it will
> > not have dataplane enabled. After that, the source should send the
> > virtio-net vmstate every time it changes. vhost-vdpa net is able to
> > send and receive through CVQ, so it should be able to modify net
> > device configuration as many times as needed. I guess that could be
> > done by calling something in the line of your
> > vhost_user_set_presetup_state.
> This is very good approach. How do you know when virtio-net vmstate
> change? vhost-user and vhost-vdpa should share same code of virtio-net
> vmstate early sync.

CVQ in vhost-vdpa must be shadowed already to be able to migrate.
Everytime the guest places a buffer in CVQ,
net/vhost-vdpa.c:vhost_vdpa_net_handle_ctrl_avail is called, which
calls virtio_net_handle_ctrl_iov.

So virtio_net_handle_ctrl_iov should be able to check if we're
migrating and signal that the state must be re-sent.

> >
> > This can be improved in vhost-vdpa by being able to send only the new s=
tate.
> >
> > When all the migration is completed, vhost-vdpa net dataplane should
> > start as it does now.
> >
> > If you are interested in saving changes to vhost-user protocol, maybe
> > qemu could just disable the dataplane too with
> > VHOST_USER_SET_VRING_ENABLE? If not, I think both approaches have a
> > lot in common, so I'm sure we can develop one backend on top of
> > another.
> >
> > Thanks!
> >
> > [1] https://lists.gnu.org/archive/html/qemu-devel/2023-04/msg00659.html
>
> I'm afraid just like DRIVER_OK as a hint for vhost-user vDPA to apply
> all the configuration to HW. Vhost-user also needs same hint as the end
> of each round vmstate sync to apply configuration to HW. That's why I
> need define new protocol message.
>
> Because of MQ can also change, VQ enable is a valid parameter to HW. HW
> will create only enabled queue, number of enabled queues affects RSS
> setting.
>

I'm not sure I follow 100%, the first part is true for properties like
vq address etc. For that to change, a full device reset in the
destination is needed.

But for the number of queues, the destination QEMU is able to send
multiple CVQ commands before starting the dataplane as long as the
device supports the dataplane late enabling.

>
> >
> >> To reduce the VM downtime, the proposed approach involves capturing th=
e basic
> >> device state/configuration during the VM's running stage and performin=
g the
> >> initial device configuration(presetup). During the normal configuratio=
n process
> >> when the VM is in a stopped state, the second configuration is compare=
d to the
> >> first one, and only the differences are applied to reduce downtime. Id=
eally,
> >> only the vring available index needs to be changed within VM stop.
> >>
> >> This feature is disabled by default, because backend like dpdk also ne=
eds
> >> adding support for vhost new message. New device property "x-early-mig=
ration"
> >> can enable this feature.
> >>
> >> 1. Register a new vmstate for virtio-net with an early_setup flag to s=
end the
> >>     device state during migration setup.
> >> 2. After device state load on destination VM, need to send device stat=
us to
> >>     vhost backend in a new way. Introduce new vhost-user message:
> >>     VHOST_USER_PRESETUP, to notify backend of presetup.
> >> 3. Let virtio-net, vhost-net, vhost-dev support presetup. Main flow:
> >>     a. vhost-dev sending presetup start.
> >>     b. virtio-net setting mtu.
> >>     c. vhost-dev sending vring configuration and setting dummy call/ki=
ck fd.
> >>     d. vhost-net sending vring enable.
> >>     e. vhost-dev sending presetup end.
> >>
> >>
> >> TODOs:
> >> =3D=3D=3D=3D=3D=3D
> >>    - No vhost-vdpa/kernel support. Need to discuss/design new kernel i=
nterface
> >>      if there's same requirement for vhost-vdpa.
> >>
> >>    - No vIOMMU support so far. If there is a need for vIOMMU support, =
it is
> >>      planned to be addressed in a follow-up patchset.
> >>
> >>
> >> Test:
> >> =3D=3D=3D=3D=3D
> >>    - Live migration VM with 2 virtio-net devices, ping can recover.
> >>      Together with DPDK patch [1].
> >>    - The time consumption of DPDK function dev_conf is reduced from 19=
1.4 ms
> >>      to 6.6 ms.
> >>
> >>
> >> References:
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>
> >> [1] https://github.com/Mellanox/dpdk-vhost-vfe/pull/37
> >>
> >> Any comments or feedback are highly appreciated.
> >>
> >> Thanks,
> >> Yajun
> >>
> >>
> >> Yajun Wu (5):
> >>    vhost-user: Add presetup protocol feature and op
> >>    vhost: Add support for presetup
> >>    vhost-net: Add support for presetup
> >>    virtio: Add VMState for early load
> >>    virtio-net: Introduce LM early load
> >>
> >>   docs/interop/vhost-user.rst       |  10 ++
> >>   hw/net/trace-events               |   1 +
> >>   hw/net/vhost_net.c                |  40 +++++++
> >>   hw/net/virtio-net.c               | 100 ++++++++++++++++++
> >>   hw/virtio/vhost-user.c            |  30 ++++++
> >>   hw/virtio/vhost.c                 | 166 +++++++++++++++++++++++++---=
--
> >>   hw/virtio/virtio.c                | 152 ++++++++++++++++-----------
> >>   include/hw/virtio/vhost-backend.h |   3 +
> >>   include/hw/virtio/vhost.h         |  12 +++
> >>   include/hw/virtio/virtio-net.h    |   1 +
> >>   include/hw/virtio/virtio.h        |  10 +-
> >>   include/net/vhost_net.h           |   3 +
> >>   12 files changed, 443 insertions(+), 85 deletions(-)
> >>
> >> --
> >> 2.27.0
> >>
> >>
>



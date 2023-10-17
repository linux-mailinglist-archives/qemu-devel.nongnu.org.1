Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB737CC916
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 18:49:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsnF4-00043n-Gx; Tue, 17 Oct 2023 12:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qsnF1-00042r-IG
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 12:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qsnEz-0006Jd-7Q
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 12:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697561299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o8YcZpngfzzT5fegQMC3eTG4FKOcAdWCAuz4bfn/s30=;
 b=f2NCqgmNIM7JP1tPRqIbtWPyKkqrfP3MK+8SBaNANZrXp+X1kYwZfeB3pSFwYROntdcy5c
 lN6uz5ghN+TJKEGz2I3kt/YBMwLhuZa/yfJkXnw2lJz8VvWQmVG+IctmlqUbod2SmEyy+N
 d7mqR68+9m9Sd6tSylsR1AcYS21mTFA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-dl6C7ZHrN4CRgPAtM-ov5A-1; Tue, 17 Oct 2023 12:48:17 -0400
X-MC-Unique: dl6C7ZHrN4CRgPAtM-ov5A-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-5a7cf717bacso92307417b3.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 09:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697561297; x=1698166097;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8YcZpngfzzT5fegQMC3eTG4FKOcAdWCAuz4bfn/s30=;
 b=HOlHYUpwwxHDYPG59iu7tvsTLIsJMg5I9NTRciggxK5syO77R/f23P4Q0I170AvQS+
 QkZtpYK5ckymOMKf+55OTKo/N05HbEREhq33FKPxbYoUrvWML6OmxxVPNy1D9ZRfm+NS
 4zbPbpEP3lNsm1hsQWgu5LZAW41KJ5LAq9I/gBDakA2KPwjUZ1k3XlSC3d991T5Gt/ni
 gUh1q8IDH8nozizC3KVU8cknUzMI2ZaFzijLZq6BLe5AqBZxFBB1rDm69cb60aZBBCpJ
 VwZ7/eLXApE/dMI1i0awQXlaWaPVeLnqVX/Un70FylLguH9O+weE0i9oQstSXhigpooa
 niXw==
X-Gm-Message-State: AOJu0Yzd6MblKs1I/Jf8tXHuK91uFvUW1ZCJ6uhHDMiJtxCQoG23r1R5
 E+rK2tvCx7LNtUOgHjKQZ4Q+VpbFdirt5zkuWk69o4ncrRD5UiyyXl1+WRBKYks7Ko1odQu3Aua
 JsOLbtcZ28ciWERthE1kK3mT7IYq5NLc=
X-Received: by 2002:a81:4e05:0:b0:59f:65d1:5c55 with SMTP id
 c5-20020a814e05000000b0059f65d15c55mr3005126ywb.34.1697561296882; 
 Tue, 17 Oct 2023 09:48:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHix2k0TUEpTX6xqhqY2J4+VFj4SGSVemuJE6xXZOoTw1BB8QVw61HtiFW0ozzX2XoDt5B4Vi0YsmBU4Ot15PE=
X-Received: by 2002:a81:4e05:0:b0:59f:65d1:5c55 with SMTP id
 c5-20020a814e05000000b0059f65d15c55mr3005114ywb.34.1697561296597; Tue, 17 Oct
 2023 09:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230918044932.1433744-1-yajunw@nvidia.com>
In-Reply-To: <20230918044932.1433744-1-yajunw@nvidia.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 17 Oct 2023 18:47:40 +0200
Message-ID: <CAJaqyWfuXDY7jBSQsS=0Ws7mpZLcsed6bpQbM+eZGLU5AzCw1Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] virtio-net: Introduce LM early load
To: Yajun Wu <yajunw@nvidia.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, mst@redhat.com
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

On Mon, Sep 18, 2023 at 6:51=E2=80=AFAM Yajun Wu <yajunw@nvidia.com> wrote:
>
> This series of patches aims to minimize the downtime during live migratio=
n of a
> virtio-net device with a vhost-user backend. In the case of hardware virt=
ual
> Data Path Acceleration (vDPA) implementation, the hardware configuration,=
 which
> includes tasks like VQ creation and RSS setting, may take above 200ms. Th=
is
> significantly increases the downtime of the VM, particularly in terms of
> networking.
>

Hi!

Sorry I totally missed this email. Please CC me in next versions.

Just for completion, there is an ongoing plan to reduce the downtime
in vhost-vdpa. You can find more details at [1].

To send the state periodically is in the roadmap, but some
benchmarking detected that memory pinning and unpinning affects more
to downtime. I'll send a RFC soon with this. The plan was to continue
with iterative state restoring, so I'm happy to know more people are
looking into it!

In the case of vhost-vdpa it already restores the state by not
enabling dataplane until migration completes. All the load is
performed using CVQ, as you can see in
net/vhost-vdpa.c:vhost_vdpa_net_load. After that, all dataplane is
started again.

My idea is to start vhost-vdpa (by calling vhost_vdpa_dev_start) at
the destination at the same moment the migration starts, as it will
not have dataplane enabled. After that, the source should send the
virtio-net vmstate every time it changes. vhost-vdpa net is able to
send and receive through CVQ, so it should be able to modify net
device configuration as many times as needed. I guess that could be
done by calling something in the line of your
vhost_user_set_presetup_state.

This can be improved in vhost-vdpa by being able to send only the new state=
.

When all the migration is completed, vhost-vdpa net dataplane should
start as it does now.

If you are interested in saving changes to vhost-user protocol, maybe
qemu could just disable the dataplane too with
VHOST_USER_SET_VRING_ENABLE? If not, I think both approaches have a
lot in common, so I'm sure we can develop one backend on top of
another.

Thanks!

[1] https://lists.gnu.org/archive/html/qemu-devel/2023-04/msg00659.html

> To reduce the VM downtime, the proposed approach involves capturing the b=
asic
> device state/configuration during the VM's running stage and performing t=
he
> initial device configuration(presetup). During the normal configuration p=
rocess
> when the VM is in a stopped state, the second configuration is compared t=
o the
> first one, and only the differences are applied to reduce downtime. Ideal=
ly,
> only the vring available index needs to be changed within VM stop.
>
> This feature is disabled by default, because backend like dpdk also needs
> adding support for vhost new message. New device property "x-early-migrat=
ion"
> can enable this feature.
>
> 1. Register a new vmstate for virtio-net with an early_setup flag to send=
 the
>    device state during migration setup.
> 2. After device state load on destination VM, need to send device status =
to
>    vhost backend in a new way. Introduce new vhost-user message:
>    VHOST_USER_PRESETUP, to notify backend of presetup.
> 3. Let virtio-net, vhost-net, vhost-dev support presetup. Main flow:
>    a. vhost-dev sending presetup start.
>    b. virtio-net setting mtu.
>    c. vhost-dev sending vring configuration and setting dummy call/kick f=
d.
>    d. vhost-net sending vring enable.
>    e. vhost-dev sending presetup end.
>
>
> TODOs:
> =3D=3D=3D=3D=3D=3D
>   - No vhost-vdpa/kernel support. Need to discuss/design new kernel inter=
face
>     if there's same requirement for vhost-vdpa.
>
>   - No vIOMMU support so far. If there is a need for vIOMMU support, it i=
s
>     planned to be addressed in a follow-up patchset.
>
>
> Test:
> =3D=3D=3D=3D=3D
>   - Live migration VM with 2 virtio-net devices, ping can recover.
>     Together with DPDK patch [1].
>   - The time consumption of DPDK function dev_conf is reduced from 191.4 =
ms
>     to 6.6 ms.
>
>
> References:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> [1] https://github.com/Mellanox/dpdk-vhost-vfe/pull/37
>
> Any comments or feedback are highly appreciated.
>
> Thanks,
> Yajun
>
>
> Yajun Wu (5):
>   vhost-user: Add presetup protocol feature and op
>   vhost: Add support for presetup
>   vhost-net: Add support for presetup
>   virtio: Add VMState for early load
>   virtio-net: Introduce LM early load
>
>  docs/interop/vhost-user.rst       |  10 ++
>  hw/net/trace-events               |   1 +
>  hw/net/vhost_net.c                |  40 +++++++
>  hw/net/virtio-net.c               | 100 ++++++++++++++++++
>  hw/virtio/vhost-user.c            |  30 ++++++
>  hw/virtio/vhost.c                 | 166 +++++++++++++++++++++++++-----
>  hw/virtio/virtio.c                | 152 ++++++++++++++++-----------
>  include/hw/virtio/vhost-backend.h |   3 +
>  include/hw/virtio/vhost.h         |  12 +++
>  include/hw/virtio/virtio-net.h    |   1 +
>  include/hw/virtio/virtio.h        |  10 +-
>  include/net/vhost_net.h           |   3 +
>  12 files changed, 443 insertions(+), 85 deletions(-)
>
> --
> 2.27.0
>
>



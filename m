Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF17175BF19
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 08:50:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMjwW-0003YR-BX; Fri, 21 Jul 2023 02:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMjwU-0003Y3-44
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 02:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qMjwS-0001MO-AN
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 02:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689922123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qgIMKgu2ikxITgURJavjgnvCUM8sE4s+oI+Lo35D0E=;
 b=hw+PhJbugodzlKZ2J/s6Zb/wVWgXPTGQjxiTb6vsp2r6GS7GNNy1PljVGpWK+W8+lf5uOj
 YRmxqHN+DLSy5mddlvKc9YbGBONYBfeKuvGVRwifR4NFc78K50KR7ijfXfKjKWwmSpiDFt
 yc4BWTxgzkFYV3+qeGtBTbuX0JzcNS0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-XI-OYYFZMneKfgzjxUdn-A-1; Fri, 21 Jul 2023 02:48:41 -0400
X-MC-Unique: XI-OYYFZMneKfgzjxUdn-A-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-521da4c99d4so1067021a12.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 23:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689922120; x=1690526920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+qgIMKgu2ikxITgURJavjgnvCUM8sE4s+oI+Lo35D0E=;
 b=Kmcqk3gKfxsSJpq8zXBVS50KpzTAuWZ/z2LG9BRTNh91NG0kEK9Yuu8JOOfrJe4T6Q
 gRqJCz/Nq86udlngvbb8qKep4X1irIuPFaxxKWAWPeVb3X+UTOURk7FR2FGQLJTfb0vx
 76A8tOs/gwRGl2ghVsxUgVMOigkwyJN30H3LqjgkcZ9AEsyYEemUMeDf2Qw8qvsnXNUr
 4vWq8KGWWoI5WRtXKGyh9eR6XMvx+CZ+kM+BkORmXUek2lnqpN84i/4zNDgcwyQb5FLB
 DuQF16io2wrBguc2Vml4cS0Mi0Ldq03RoL6hJ9OZB5DX2xJ/18DhUOxX4wEEugLyPaf+
 nSQA==
X-Gm-Message-State: ABy/qLbdHD7SaP+6Ab/Dx8Y88SNNtL5NeDHjB72a+e5gsfhjn9QZdE/k
 yMrva/hp5yxj66B8XU6AzSFVElyLRxtzxzicax1hA2AjNqxLcA9RNceEtcaSwazp5CoY78wra3P
 thz06J45bZFdU+SuqpCJN3X3PfVZO7VwHuPUPrxQ=
X-Received: by 2002:a05:6402:12c4:b0:51e:f83:6de6 with SMTP id
 k4-20020a05640212c400b0051e0f836de6mr893133edx.16.1689922120030; 
 Thu, 20 Jul 2023 23:48:40 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFThPvKefi28VdFfoZIb3KzfiOGExOgHFzgRuvVxpEG7SViY8GATYV0kgjqFHtXSGwvd/NRYKi80MxGpSZs2Fk=
X-Received: by 2002:a05:6402:12c4:b0:51e:f83:6de6 with SMTP id
 k4-20020a05640212c400b0051e0f836de6mr893116edx.16.1689922119720; Thu, 20 Jul
 2023 23:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230720181459.607008-1-eperezma@redhat.com>
In-Reply-To: <20230720181459.607008-1-eperezma@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 21 Jul 2023 08:48:02 +0200
Message-ID: <CAJaqyWdkyX9Ha-kd+haqEpfXfpVhSLmRa5hkZZGkvZjrD4Ketg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/12] Prefer to use SVQ to stall dataplane at NIC
 state restore through CVQ
To: qemu-devel@nongnu.org
Cc: yvugenfi@redhat.com, si-wei.liu@oracle.com, 
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Shannon Nelson <snelson@pensando.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Thu, Jul 20, 2023 at 8:15=E2=80=AFPM Eugenio P=C3=A9rez <eperezma@redhat=
.com> wrote:
>
> At this moment the migration of net features that depends on CVQ is not
> possible, as there is no reliable way to restore the device state like ma=
c
> address, number of enabled queues, etc to the destination.  This is mainl=
y
> caused because the device must only read CVQ, and process all the command=
s
> before resuming the dataplane.
>
> This series uses the VirtIO feature _F_RING_RESET to achieve it, adding a=
n
> alternative method to late vq enabling proposed in [1][2].  It expose SVQ=
 to
> the device until it process all the CVQ messages, and then replaces the v=
ring
> for the guest's one.
>

A couple of things I forgot to add:
* Assuming the implementation of _F_RING_RESET in vdpa is calling
kernel vdpa ops .set_vq_ready(vq, false). I'm not sure if this is the
best implementation, but it is currently unused in the kernel. At the
same time, .set_vq_ready(vq, true) also enables the vq again.

> As an advantage, it uses a feature well deviced in the VirtIO standard.  =
As a
> disadvantage, current HW already support the late enabling and it does no=
t
> support RING_RESET.
>
> This patch must be applied on top of the series ("Enable vdpa net migrati=
on
> with features depending on CVQ") [1][2].
>
> The patch has been tested with vp_vdpa, but using high IOVA instead of a
> sepparated ID for shadow CVQ and shadow temporal vrings.
>

And with _F_STATE implementation I sent long ago.

Based on this, my suggestion is:
* Leave the late enable for vDPA devices.
* Make them fail if the vDPA parent device does not support it. This
can be considered as a fix.
* Leave _F_RING_RESET to be added on top, as the semantics are not
implemented in vDPA at the moment.

Would that work?

> [1] Message-id: <20230706191227.835526-1-eperezma@redhat.com>
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg01325.htm=
l
>
> Eugenio P=C3=A9rez (12):
>   vhost: add vhost_reset_queue_op
>   vhost: add vhost_restart_queue_op
>   vhost_net: Use ops->vhost_restart_queue in vhost_net_virtqueue_restart
>   vhost_net: Use ops->vhost_reset_queue in vhost_net_virtqueue_reset
>   vdpa: add vhost_vdpa_set_vring_ready_internal
>   vdpa: add vhost_vdpa_svq_stop
>   vdpa: add vhost_vdpa_reset_queue
>   vdpa: add vhost_vdpa_svq_start
>   vdpa: add vhost_vdpa_restart_queue
>   vdpa: enable all vqs if the device support RING_RESET feature
>   vdpa: use SVQ to stall dataplane while NIC state is being restored
>   vhost: Allow _F_RING_RESET with shadow virtqueue
>
>  include/hw/virtio/vhost-backend.h  |   6 ++
>  hw/net/vhost_net.c                 |  16 ++--
>  hw/virtio/vhost-shadow-virtqueue.c |   1 +
>  hw/virtio/vhost-vdpa.c             | 139 +++++++++++++++++++++--------
>  net/vhost-vdpa.c                   |  55 ++++++++++--
>  hw/virtio/trace-events             |   2 +-
>  6 files changed, 171 insertions(+), 48 deletions(-)
>
> --
> 2.39.3
>
>



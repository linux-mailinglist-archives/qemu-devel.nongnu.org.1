Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E110975FB2A
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 17:49:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNxnu-0008Gg-NF; Mon, 24 Jul 2023 11:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qNxns-0008GP-6l
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:48:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1qNxnq-00088N-Ju
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690213733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lINiZ42RRGjRO+14AWnj19xFSWrp1LAVx7LCIGIhwXQ=;
 b=Y9rVQBqenPw3b3lnuGkf7PhogBzukkS7DUgqNmoFxnLRydbfIZkxaR23cjl7rRDyUL4C1T
 rHGEtWpP3MuOZwvDaP4QCLJ9CH+LI0bgsmRQATKzxfU+KFp0CPQ6Boh2Eue8iVK+lHMDAq
 Y0G56Q0QqO5J4Sq9rYv3l01+Q6RCkSI=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-4e41-xGJNoWbM1Skfa1mxA-1; Mon, 24 Jul 2023 11:48:50 -0400
X-MC-Unique: 4e41-xGJNoWbM1Skfa1mxA-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-d07cb52a768so2705878276.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 08:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690213730; x=1690818530;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lINiZ42RRGjRO+14AWnj19xFSWrp1LAVx7LCIGIhwXQ=;
 b=jq3zqCOb5Udc+HI2YCfmIHAIL66Eov+1SveEyjPEPk7e1siGe1ZyWep9Zn5nsGUVsY
 IIGUixmiwAYEppqd3gka4KhZ9f38X5gamM05AGDqwgaheU2KCGnxe9GVXG7TixrM5iyE
 ZSraUT0DwZ0i9cg73NhM/qTLSi4UiHMZC/VlLEu2L6Ggtt7TAMBmkaTNCH8AvnZ0pOkD
 EIyG/sykA2EgfZOCzKWS3Q4I7poN8cJSAYgnjdwcPXfpqDqJLv38SvK3264tzzNd1iCF
 e22vmFHsLaXNmzkkuIEHWbct03s/xkxqViD0JN4d8clQauWWWh6DYzq/zhrdomRTInCJ
 aFBA==
X-Gm-Message-State: ABy/qLbwkV/myioZM5A0vywSIxBtr4RGhk6J3rpYpHOfk07tUG+nQK+c
 HgXI+MVH3nuphqfkKn0jtRp8dA1MzVRUkLcU/UbnNh9pmgT5pr1pSdvnlvS6pt5fcnOFd/a67Uo
 k7KfJelhVJGrKH+3fJg30gEFQ+p6qf7c=
X-Received: by 2002:a25:40cb:0:b0:d09:7f94:6ea3 with SMTP id
 n194-20020a2540cb000000b00d097f946ea3mr4858013yba.65.1690213730025; 
 Mon, 24 Jul 2023 08:48:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFu8106UFf5eUt4p6ohAjj1pREPTGzz7kF6tPjx8hyAyc1OhU0aAkvA0O+tiDk70nWMpzJ1CuGNyoxhLkhu2JI=
X-Received: by 2002:a25:40cb:0:b0:d09:7f94:6ea3 with SMTP id
 n194-20020a2540cb000000b00d097f946ea3mr4858004yba.65.1690213729708; Mon, 24
 Jul 2023 08:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230711155230.64277-1-hreitz@redhat.com>
 <20230711155230.64277-4-hreitz@redhat.com>
 <CAJaqyWdPjyJF4rijXwpq09E94oR1U4JA3dK4Q1XN4uy+Z6UCLw@mail.gmail.com>
 <720e7cdb-1071-a975-8c63-7d0efe3577d4@redhat.com>
In-Reply-To: <720e7cdb-1071-a975-8c63-7d0efe3577d4@redhat.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 24 Jul 2023 17:48:13 +0200
Message-ID: <CAJaqyWc0Eonb=8WDrvp-xLohaDjDSD7j8rD=c0u7guu_Y3O+ow@mail.gmail.com>
Subject: Re: [PATCH 3/6] vhost: Do not reset suspended devices on stop
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, German Maglione <gmaglione@redhat.com>
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

On Fri, Jul 21, 2023 at 6:07=E2=80=AFPM Hanna Czenczek <hreitz@redhat.com> =
wrote:
>
> On 21.07.23 17:25, Eugenio Perez Martin wrote:
> > On Tue, Jul 11, 2023 at 5:52=E2=80=AFPM Hanna Czenczek <hreitz@redhat.c=
om> wrote:
> >> Move the `suspended` field from vhost_vdpa into the global vhost_dev
> >> struct, so vhost_dev_stop() can check whether the back-end has been
> >> suspended by `vhost_ops->vhost_dev_start(hdev, false)`.  If it has,
> >> there is no need to reset it; the reset is just a fall-back to stop
> >> device operations for back-ends that do not support suspend.
> >>
> >> Unfortunately, for vDPA specifically, RESUME is not yet implemented, s=
o
> >> when the device is re-started, we still have to do the reset to have i=
t
> >> un-suspend.
> >>
> >> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> >> ---
> >>   include/hw/virtio/vhost-vdpa.h |  2 --
> >>   include/hw/virtio/vhost.h      |  8 ++++++++
> >>   hw/virtio/vhost-vdpa.c         | 11 +++++++----
> >>   hw/virtio/vhost.c              |  8 +++++++-
> >>   4 files changed, 22 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-=
vdpa.h
> >> index e64bfc7f98..72c3686b7f 100644
> >> --- a/include/hw/virtio/vhost-vdpa.h
> >> +++ b/include/hw/virtio/vhost-vdpa.h
> >> @@ -42,8 +42,6 @@ typedef struct vhost_vdpa {
> >>       bool shadow_vqs_enabled;
> >>       /* Vdpa must send shadow addresses as IOTLB key for data queues,=
 not GPA */
> >>       bool shadow_data;
> >> -    /* Device suspended successfully */
> >> -    bool suspended;
> >>       /* IOVA mapping used by the Shadow Virtqueue */
> >>       VhostIOVATree *iova_tree;
> >>       GPtrArray *shadow_vqs;
> >> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> >> index 6a173cb9fa..69bf59d630 100644
> >> --- a/include/hw/virtio/vhost.h
> >> +++ b/include/hw/virtio/vhost.h
> >> @@ -120,6 +120,14 @@ struct vhost_dev {
> >>       uint64_t backend_cap;
> >>       /* @started: is the vhost device started? */
> >>       bool started;
> >> +    /**
> >> +     * @suspended: Whether the vhost device is currently suspended.  =
Set
> >> +     * and reset by implementations (vhost-user, vhost-vdpa, ...), wh=
ich
> >> +     * are supposed to automatically suspend/resume in their
> >> +     * vhost_dev_start handlers as required.  Must also be cleared wh=
en
> >> +     * the device is reset.
> >> +     */
> >> +    bool suspended;
> >>       bool log_enabled;
> >>       uint64_t log_size;
> >>       Error *migration_blocker;
> >> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> >> index 7b7dee468e..f7fd19a203 100644
> >> --- a/hw/virtio/vhost-vdpa.c
> >> +++ b/hw/virtio/vhost-vdpa.c
> >> @@ -858,13 +858,12 @@ static int vhost_vdpa_get_device_id(struct vhost=
_dev *dev,
> >>
> >>   static int vhost_vdpa_reset_device(struct vhost_dev *dev)
> >>   {
> >> -    struct vhost_vdpa *v =3D dev->opaque;
> >>       int ret;
> >>       uint8_t status =3D 0;
> >>
> >>       ret =3D vhost_vdpa_call(dev, VHOST_VDPA_SET_STATUS, &status);
> >>       trace_vhost_vdpa_reset_device(dev);
> >> -    v->suspended =3D false;
> >> +    dev->suspended =3D false;
> >>       return ret;
> >>   }
> >>
> >> @@ -1278,7 +1277,7 @@ static void vhost_vdpa_suspend(struct vhost_dev =
*dev)
> >>           if (unlikely(r)) {
> >>               error_report("Cannot suspend: %s(%d)", g_strerror(errno)=
, errno);
> >>           } else {
> >> -            v->suspended =3D true;
> >> +            dev->suspended =3D true;
> >>               return;
> >>           }
> >>       }
> >> @@ -1313,6 +1312,10 @@ static int vhost_vdpa_dev_start(struct vhost_de=
v *dev, bool started)
> >>               return -1;
> >>           }
> >>           vhost_vdpa_set_vring_ready(dev);
> >> +        if (dev->suspended) {
> >> +            /* TODO: When RESUME is available, use it instead of rese=
tting */
> >> +            vhost_vdpa_reset_status(dev);
> > How is that we reset the status at each vhost_vdpa_dev_start? That
> > will clean all the vqs configured, features negotiated, etc. in the
> > vDPA device. Or am I missing something?
>
> What alternative do you propose?  We don=E2=80=99t have RESUME for vDPA i=
n qemu,
> but we somehow need to lift the previous SUSPEND so the device will
> again respond to guest requests, do we not?
>

Reset also clears the suspend state in vDPA, and it should be called
at vhost_dev_stop. So the device should never be in suspended state
here. Does that solve your concerns?

> But more generally, is this any different from what is done before this
> patch?  Before this patch, vhost_dev_stop() unconditionally invokes
> vhost_reset_status(), so the device is reset in every stop/start cycle,
> that doesn=E2=80=99t change.  And we still won=E2=80=99t reset it on the =
first
> vhost_dev_start(), because dev->suspended will be false then, only on
> subsequent stop/start cycles, as before.  So the only difference is that
> now the device is reset on start, not on stop.
>

The difference is that vhost_vdpa_dev_start is called after features
ack (via vhost_dev_start, through vhost_dev_set_features call) and vq
configuration (using vhost_virtqueue_start). A device reset forces the
device to forget about all of that, and qemu cannot configure them
again until qemu acks the features again.



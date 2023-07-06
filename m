Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B99C749A36
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:05:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHMm4-0005nz-2m; Thu, 06 Jul 2023 07:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qHMm1-0005ne-TN
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qHMm0-00043j-3w
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688641422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b6bzGYt61GwzjEB49dmBYSnIesPdHxrz1cSZ7qTitE0=;
 b=bgvQgD/nQV6xU1tn1BMOjdl3mFsnekJoo0X3BfxRmiXQjA7bK5URK3Y2iNTJ6bV26ndOrZ
 wj6IOXxoafWk1Dr7lXo+jTwfuW2juxG8F21xaVBdRUIlmpH5QePj5FzPb3UeZIui/4O5jo
 pcFyOwIn+pn7YrIn9aUg8NOc+eU0Fts=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-eXPMWBEUMSWtGe9bEL8uKg-1; Thu, 06 Jul 2023 07:03:41 -0400
X-MC-Unique: eXPMWBEUMSWtGe9bEL8uKg-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-51df43db167so499323a12.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 04:03:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688641420; x=1691233420;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6bzGYt61GwzjEB49dmBYSnIesPdHxrz1cSZ7qTitE0=;
 b=l5TsTNovUMvdj9CsAcZE4YbTWcwepITUKKk14+nvRB6EPL34a9aOXj1DncTEv4shMm
 et0lzFQa2ZPS+w8J6QGG+iZ7i7PfQmHzRRVxk42YQ1KoMEKNuHhIjlnhbBMdGf0VVifS
 J1HpX2LFQMvi6bnLAX1qp/cW6AS0RXyK826XtSY3xj29BiI0VJZP95fyDmbDN+HqFP0j
 q5imoE+9+ggPKYsE4Onb+cURq783lqP42wt+bmCpNZl5XFVO78o8i37RE3mRVQQ3cer3
 iSLm1k8kay77SYiXh/J1PlwSErPeg+IrZtgneveOebS/ont2U163f9s0iZ6r79kiRt5t
 g9sw==
X-Gm-Message-State: ABy/qLZXl+gZGM52/BI32wXmziD/8DDe8w4hiO6eA/ism12ARiQ/f4nV
 pbs3B1N2WR55bO/lJnbkf1ivfdr0+Yvwn3VnbhCkViSfz+KOfJwUthvytPWoguaEkdj8Npqpy8o
 8ROI2aM4HvYxq3rM1bv4uvqzM/CyGqi8=
X-Received: by 2002:a05:6402:2022:b0:51d:9e0c:1396 with SMTP id
 ay2-20020a056402202200b0051d9e0c1396mr1277562edb.35.1688641419879; 
 Thu, 06 Jul 2023 04:03:39 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE3q7HABt1wMOL2I7tbhqQVb1/Oe5a5RBMCQnIcJ3jrnY95G8JjBwNd7VeTTqNyTEnbaE4l61wp8b+87VN9Ils=
X-Received: by 2002:a05:6402:2022:b0:51d:9e0c:1396 with SMTP id
 ay2-20020a056402202200b0051d9e0c1396mr1277551edb.35.1688641419610; Thu, 06
 Jul 2023 04:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688438055.git.yin31149@gmail.com>
 <CAPpAL=z6+Jhoy3w=itO7JEpkijJPZSZNyLVUQ1qS08gqnjN6hQ@mail.gmail.com>
 <CAKrof1P8dRN+fXAX47iiu892kmCjoq-xcUmXrcChHUUh4hRYKA@mail.gmail.com>
In-Reply-To: <CAKrof1P8dRN+fXAX47iiu892kmCjoq-xcUmXrcChHUUh4hRYKA@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 6 Jul 2023 19:03:03 +0800
Message-ID: <CAPpAL=yX+p3D=O9PHJyNe5W+_mrT2WXe4BcPYpdVKZb=4VvjgQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] vdpa: Return -EIO if device ack is VIRTIO_NET_ERR
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com, 
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
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

On Wed, Jul 5, 2023 at 7:03=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> On 2023/7/5 15:59, Lei Yang wrote:
> > Hello Hawkins
> >
> > QE can help test this series before  it is merged into master, I would
> > like to know what test steps can cover this series related scenario?
> >
>
> Hi, I would like to suggest the following steps to test this patch series=
:
>
> 1.  Modify the QEMU source code to make the device return a
> VIRTIO_NET_ERR for the CVQ command. Please apply the patch
> provided below:
>
> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
> index 373609216f..58ade6d4e0 100644
> --- a/net/vhost-vdpa.c
> +++ b/net/vhost-vdpa.c
> @@ -642,7 +642,7 @@ static int vhost_vdpa_net_load_mac(VhostVDPAState
> *s, const VirtIONet *n)
>       if (virtio_vdev_has_feature(&n->parent_obj,
> VIRTIO_NET_F_CTRL_MAC_ADDR)) {
>           ssize_t dev_written =3D vhost_vdpa_net_load_cmd(s,
> VIRTIO_NET_CTRL_MAC,
>
> VIRTIO_NET_CTRL_MAC_ADDR_SET,
> -                                                  n->mac, sizeof(n->mac)=
);
> +                                                  n->mac,
> sizeof(n->mac) - 1);
>           if (unlikely(dev_written < 0)) {
>               return dev_written;
>           }
>
> 2. Start QEMU with the vdpa device in default state.
> Without the patch series, QEMU should not trigger any errors or warnings.
> With the series applied, QEMU should trigger the warning like
> "qemu-system-x86_64: unable to start vhost net: 5: falling back on
> userspace virtio".

Based on the above steps, QE tests it without the above patch first,
it will not trigger any errors or warnings. Then QE manually applied
the above patch, boot guest again, it can trigger this warning:
qemu-system-x86_64: unable to start vhost net: 5: falling back on
userspace virtio, this is an expected result.

Tested-by: Lei Yang <leiyang@redhat.com>

BR
Lei

>
> Thanks!
>
>
> > Thanks
> > Lei
> >
> > On Tue, Jul 4, 2023 at 11:36=E2=80=AFAM Hawkins Jiawei <yin31149@gmail.=
com> wrote:
> >>
> >> According to VirtIO standard, "The class, command and
> >> command-specific-data are set by the driver,
> >> and the device sets the ack byte.
> >> There is little it can do except issue a diagnostic
> >> if ack is not VIRTIO_NET_OK."
> >>
> >> Therefore, QEMU should stop sending the queued SVQ commands and
> >> cancel the device startup if the device's ack is not VIRTIO_NET_OK.
> >>
> >> Yet the problem is that, vhost_vdpa_net_load_x() returns 1 based on
> >> `*s->status !=3D VIRTIO_NET_OK` when the device's ack is VIRTIO_NET_ER=
R.
> >> As a result, net->nc->info->load() also returns 1, this makes
> >> vhost_net_start_one() incorrectly assume the device state is
> >> successfully loaded by vhost_vdpa_net_load() and return 0, instead of
> >> goto `fail` label to cancel the device startup, as vhost_net_start_one=
()
> >> only cancels the device startup when net->nc->info->load() returns a
> >> negative value.
> >>
> >> This patchset fixes this problem by returning -EIO when the device's
> >> ack is not VIRTIO_NET_OK.
> >>
> >> Changelog
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> v3:
> >>   - split the fixes suggested by Eugenio
> >>   - return -EIO suggested by Michael
> >>
> >> v2: https://lore.kernel.org/all/69010e9ebb5e3729aef595ed92840f43e48e53=
e5.1687875592.git.yin31149@gmail.com/
> >>   - fix the same bug in vhost_vdpa_net_load_offloads()
> >>
> >> v1: https://lore.kernel.org/all/cover.1686746406.git.yin31149@gmail.co=
m/
> >>
> >> Hawkins Jiawei (3):
> >>    vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mac()
> >>    vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_mq()
> >>    vdpa: Return -EIO if device ack is VIRTIO_NET_ERR in _load_offloads=
()
> >>
> >>   net/vhost-vdpa.c | 15 +++++++++++----
> >>   1 file changed, 11 insertions(+), 4 deletions(-)
> >>
> >> --
> >> 2.25.1
> >>
> >>
> >
>



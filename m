Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F645720894
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 19:49:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q58st-0008TU-Dr; Fri, 02 Jun 2023 13:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q58sq-0008TM-O5
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1q58so-0005OD-OQ
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 13:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685728093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gmBrKQZa42QCaQOe30cVofa3hbs1NeT6J2f1pREPb0k=;
 b=LKf+6tnfEee5xRHm/36HTXZoJKkYUCJReCdOLoGd7170dzXCzENs4jXmeWte2LQY0qskPL
 o8MksXU7EaaL3p13CuXuUSCvMPXHus1cMsmW2ZxckKUFkny9DUywEvJQAVbt6qFvOFnFkD
 bduEi5zhs0LFgo5QMr3ljLYT56jRiJs=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651--eIxv0PfNIWaPcliOKuWDw-1; Fri, 02 Jun 2023 13:48:12 -0400
X-MC-Unique: -eIxv0PfNIWaPcliOKuWDw-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-56942667393so19412807b3.2
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 10:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685728092; x=1688320092;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gmBrKQZa42QCaQOe30cVofa3hbs1NeT6J2f1pREPb0k=;
 b=W7xiW1LW0+D6X91dCjbH7eeb345ieuaF2P89Ii9wqQQA4GgydxIDix7RtF7ioZPyjJ
 e1nYttyyOECAAPnt0CJPkehPTe0919u249ukc4H34IAk5JGdx0ipijU0EWlRjRvDnfMQ
 9+6abHsx37QpDH9WLh1G0uk33SSMoMD0owRb9RIqhU0bHz1sQrLxLp0d/4SYVODS44ta
 tb7onfl7VVgN3poZCOkVMfkKNJTuESgBu1pax1Nd5pv/CaDUSIrV5MX/1hrweYWZ69Ew
 6utvS2aQqMKoi+7vKCpr0q8riXKQxVlHA1F8ZMpG7+gim1WVdxAQjq4LPdMHC0Zcikf6
 ucwg==
X-Gm-Message-State: AC+VfDyPpMZcKAQvwsfbMX79HMg7yZm3r/14ekLTBMUkGnwQ9dDb0ST8
 1l2ZH+o7nIxOOz0ypNSGqnO7OZ7Sbcx3GXYU8KFZP5TDG4eJ3sQtjfdSV3K+v30icnz6MT88Fx9
 ngoFJTHtNwHbj+Z1G/IOUiVT3ako8rdU=
X-Received: by 2002:a0d:d515:0:b0:568:ea0e:ae75 with SMTP id
 x21-20020a0dd515000000b00568ea0eae75mr643022ywd.45.1685728092184; 
 Fri, 02 Jun 2023 10:48:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Ljw8o75gJgIa58XXkBmPebc/Z2tv/w3LySe5vFZqk5+/UDhkX6GFtWrQjzj+k0xv1x9cEDxUHyjVTJ1pL4No=
X-Received: by 2002:a0d:d515:0:b0:568:ea0e:ae75 with SMTP id
 x21-20020a0dd515000000b00568ea0eae75mr643002ywd.45.1685728091758; Fri, 02 Jun
 2023 10:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685704856.git.yin31149@gmail.com>
In-Reply-To: <cover.1685704856.git.yin31149@gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 2 Jun 2023 19:47:35 +0200
Message-ID: <CAJaqyWc9P9P0izwF9bk-vN7VnNC3UTjHt55gdJB9qXVfOmgUMA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Vhost-vdpa Shadow Virtqueue Offloads support
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, 
 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jun 2, 2023 at 1:52=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> This series enables shadowed CVQ to intercept Offloads commands
> through shadowed CVQ, update the virtio NIC device model so qemu
> send it in a migration, and the restore of that Offloads state
> in the destination.
>
> Changelog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> v4:
>   - refactor the commit message suggested by Eugenio in patch#4
> "virtio-net: expose virtio_net_supported_guest_offloads()"
>   - fix the wrong "cpu_to_le64()" pointed out by Eugenio in patch$5
> "vdpa: Add vhost_vdpa_net_load_offloads()"
>   - refactor the comment in patch#5
> "vdpa: Add vhost_vdpa_net_load_offloads()"
>
> v3: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00206.htm=
l
>
> v2: https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00044.htm=
l
>
> v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-05/msg07198.htm=
l
>

Please keep all the v2, v3 etc changes here too. A reviewer may see
this newly from an older revision.

Apart from that,
Reviewed-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
Tested-by: Eugenio P=C3=A9rez <eperezma@redhat.com>

I tested it by tracing the value it sends at destination when the
guest enable or disable hw GRO offloads with:
ethtool -K rx-gro-hw off.

As you point in previous series, a migration blocker needs to be
conditionally added. This is done in [1].

While investigating this I discovered two related issues, it might be
in handy if other reviewer wants to test the changes [2][3].

Thanks!

[1] https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00512.html
[2] https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00601.html
[3] https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg00604.html

> Hawkins Jiawei (6):
>   include/hw/virtio: make some VirtIODevice const
>   vdpa: reuse virtio_vdev_has_feature()
>   hw/net/virtio-net: make some VirtIONet const
>   virtio-net: expose virtio_net_supported_guest_offloads()
>   vdpa: Add vhost_vdpa_net_load_offloads()
>   vdpa: Allow VIRTIO_NET_F_CTRL_GUEST_OFFLOADS in SVQ
>
>  hw/net/virtio-net.c            |  2 +-
>  include/hw/virtio/virtio-net.h |  1 +
>  include/hw/virtio/virtio.h     |  2 +-
>  net/vhost-vdpa.c               | 49 +++++++++++++++++++++++++++++++---
>  4 files changed, 48 insertions(+), 6 deletions(-)
>
> --
> 2.25.1
>



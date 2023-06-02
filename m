Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4967207D0
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 18:41:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q57ov-0006DQ-68; Fri, 02 Jun 2023 12:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1q57ot-0006D1-7F
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 12:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1q57or-0006aq-C6
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 12:40:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685724004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJWGOBrIHZ+hyEKRrlndSoWge4DOdV3y93zzCBV/8hA=;
 b=QXihKcH9UYctDZ5o5r6CAkfxFvqkEPCZ8w/qh2cr3v+vuPwdksdfuKnoJy3+EZ6URYJqVJ
 kZvVofSgN5t4b9PogdEg7/NCDKEJGUdPED/JLVupKbvFBzbVtC4lrT7RJ/w/2H3DlEHAKd
 DuBdgfkDMK2q4FMGEKrczTS+U3gJqio=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-zLmgA-D_OgK71LJ_1N1U4g-1; Fri, 02 Jun 2023 12:40:01 -0400
X-MC-Unique: zLmgA-D_OgK71LJ_1N1U4g-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-51494233c2cso1709796a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 09:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685724001; x=1688316001;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJWGOBrIHZ+hyEKRrlndSoWge4DOdV3y93zzCBV/8hA=;
 b=SltWH+cwSTvSng8N3bg6eFAQ7SQCjBGAnYUQ/I7CoLmAIVnuJ9kYkJ8hcmreP3kBUT
 /HQlm+118YMwTU3BQ+PLJk87tTYt10h2GdnLrKWBb8DE0z+J1odVXkYJW3/uXTEQN+1D
 5vwfF5yK6w1pVfr7G+ZmQykultP889Sx2wyKzGZVBJqDyySjnWFUI02BMEpnahVu0UFL
 QxTKv5SQgs5G+0lVvvHQ+BiE13/kHwDsmBMahWrxX5HIpdF0tDQQTeUwpoz3iLVlJNpQ
 vg8lqGou26pIwHx5fdN/Vnuobrnrz1jMJCTbaqL2Rxb9GZaSyq0SJQP/kUq5Aw0jcbXM
 UJzw==
X-Gm-Message-State: AC+VfDw+jWzZ2bZZl1JP6Fb8CpboYMJV7fG9RQutWukaLe3h61nU1fRa
 L6E9O5bih7IqDlFtkeWrCrr2tlj/PMHAd7797C1/mPDhHqsLfYTCmLqNvaMdtVpjZKxP+wLsIcF
 rwQg1ru2XiqYuHlJUf1HZ/O5trNx541M=
X-Received: by 2002:a05:6402:343:b0:514:abb9:7ab1 with SMTP id
 r3-20020a056402034300b00514abb97ab1mr2406545edw.8.1685724000792; 
 Fri, 02 Jun 2023 09:40:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tQwKMPNv607eUw87kvuuzIbPesYkXn4YGM6HAaPvUxVj0cJbFUqMRVGvUTlVnrdZIe0NNjzyT6gH78TUf3hY=
X-Received: by 2002:a05:6402:343:b0:514:abb9:7ab1 with SMTP id
 r3-20020a056402034300b00514abb97ab1mr2406532edw.8.1685724000475; Fri, 02 Jun
 2023 09:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685704856.git.yin31149@gmail.com>
In-Reply-To: <cover.1685704856.git.yin31149@gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Sat, 3 Jun 2023 00:39:23 +0800
Message-ID: <CAPpAL=yXNwjdLNgwQBSHhJbMVMktoGd02F91HJtQKXsuHf57eA@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] Vhost-vdpa Shadow Virtqueue Offloads support
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com, 
 qemu-devel@nongnu.org, 18801353760@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leiyang@redhat.com;
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

QE tested this series v4 on the vp_vdpa device with the following
scenarios: reboot/shutdown, hotplug/unplug, nic driver load/unload,
ping, vDPA control virtqueue(changed the mac address), everything are
working fine. And L1 guest will not appear  error messages "vdpa svq
does not work with features 0x4" after applied this series of patches.

Tested-by: Lei Yang <leiyang@redhat.com>


On Fri, Jun 2, 2023 at 7:55=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com> =
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
>



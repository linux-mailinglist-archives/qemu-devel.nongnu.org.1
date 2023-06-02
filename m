Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C7872005A
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 13:27:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q52vI-0001UY-Bk; Fri, 02 Jun 2023 07:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1q52vG-0001UQ-9k
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:26:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1q52vE-0003au-Ep
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 07:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685705178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tswRMf0PmgiywwBRPI9dmV+fDDs+fyujGVTq2ILoNg4=;
 b=h6RCRnAsx645tbhTfYRAbArDmmsR0H0Y9WeuGVO/uhk7ZgPcv1CHeX6Me6aRfrdCr7KFB1
 Vaaek+dwmro9aUlFrhDy+ibv4XoH97leTcdzb1iLJwV8WnchCGS0GuIuAiiDPP8oH9MtAu
 4IOJ+d7ZEAb1PdwAtecMO4rgspomaWc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-r2h8aQpRMSa_s9gx8Tobvw-1; Fri, 02 Jun 2023 07:26:17 -0400
X-MC-Unique: r2h8aQpRMSa_s9gx8Tobvw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5147e3dfccdso1318508a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 04:26:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685705176; x=1688297176;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tswRMf0PmgiywwBRPI9dmV+fDDs+fyujGVTq2ILoNg4=;
 b=gdSHS3eWBwiAqeX2Ve5u6i4p2iXWnayAiIDchcAMOTTveTYVFlOv9N1bQbby08Wcli
 6sDnEl77ZiJN8WNfPpZ5yWuGhEb12Zphr1nXT8fytXrA0pZbzh7ua9jn6Ngbh+tI56aU
 CVAGfYt2usf9VDS/71J0MQGEG1wpnizk9c8LgWWsOuc4BLFciP37Ibu7kRSx5WF5VTXV
 hGTxS0jlQcpjxPWs6LHPsQ4L5HC/ouqpaFkIjdCsHyqE9a6ubJjQZZtucgjBPgpMZb5a
 WUEkC6KFgfEM/aEpPDClhnAFYO+8fkpwUM75S/piJCmAB3GTVjAXR5/hJ4yTMkO7tVID
 qUNQ==
X-Gm-Message-State: AC+VfDwAGWnLWiEL1Rtg2qwOaJJuvd8g2WYRy9nURUIHBUk0t6zgevUj
 4JlDpQJ2adgTl60tQ/RdHUdBwqfGEQUxpWq3d2Uxx5PtB/Qpa/T6lvnxvbB8B+yoxE2N+J+YBGm
 yBPf3gdI4uZ4svxPJxovZFbqGxK5pmfk=
X-Received: by 2002:a05:6402:658:b0:514:9b64:e16b with SMTP id
 u24-20020a056402065800b005149b64e16bmr1579778edx.35.1685705175909; 
 Fri, 02 Jun 2023 04:26:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4k+wfVBfpmEHgdHXMMEMHyJ4yIkm5fmz8L8w5Sik+kOC0rEDiT7XOoR+a0ejY2mJ8jJ0iUD2VZKkA+346N+Og=
X-Received: by 2002:a05:6402:658:b0:514:9b64:e16b with SMTP id
 u24-20020a056402065800b005149b64e16bmr1579764edx.35.1685705175569; Fri, 02
 Jun 2023 04:26:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1685623090.git.yin31149@gmail.com>
In-Reply-To: <cover.1685623090.git.yin31149@gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Fri, 2 Jun 2023 19:25:39 +0800
Message-ID: <CAPpAL=wCZUghxGqApE6kW6PpFwWWDrrpGt_XwcOU39RUqcwRQw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Vhost-vdpa Shadow Virtqueue Offloads support
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

Hello Hawkins

QE based on the qemu command line [1] to test this series with the
following scenarios: reboot,shutdown,hotplug/unplug,ping, and
offloads(tx,sg,tso,gso,gro), everything is working fine. It's just
that even without applying your patch to test offload there is no
error like "vdpa svq is not available for feature 4".

[1] -device '{"driver": "virtio-net-pci", "mac": "00:11:22:33:44:00",
"id": "net0", "netdev": "hostnet0", "ctrl_guest_offloads": true,
"bus": "pcie-root-port-3", "addr": "0x0"}'  \
-netdev vhost-vdpa,id=3Dhostnet0,vhostdev=3D/dev/vhost-vdpa-0,x-svq=3Don \

Tested-by: Lei Yang <leiyang@redhat.com>




On Thu, Jun 1, 2023 at 9:49=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com> =
wrote:
>
> This series enables shadowed CVQ to intercept Offloads commands
> through shadowed CVQ, update the virtio NIC device model so qemu
> send it in a migration, and the restore of that Offloads state
> in the destination.
>
> Changelog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> v3:
>   - refactor the commit message in patch
> "virtio-net: expose virtio_net_supported_guest_offloads()"
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
>  net/vhost-vdpa.c               | 45 +++++++++++++++++++++++++++++++---
>  4 files changed, 44 insertions(+), 6 deletions(-)
>
> --
> 2.25.1
>
>



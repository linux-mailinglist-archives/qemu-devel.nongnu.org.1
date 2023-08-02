Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC3676DB08
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 00:56:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRKkr-0006lp-Ly; Wed, 02 Aug 2023 18:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qRKkq-0006lg-7L
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 18:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qRKko-0004Oo-Cz
 for qemu-devel@nongnu.org; Wed, 02 Aug 2023 18:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691016940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6bDyJAzi64yzjQteKBSmqGxvVyLdUeoQCUHYBLkYBA=;
 b=E+GfzmjNnhS9o63bgokHPdef+p4f9tCkU0aYYzmsWhaa7cHSW/jcGTFUAtQ09HvUfsnXca
 TG9uyWRxXVZrfT+ZusKuKDmwaDWAUWbjEzwpU5P2QgIIgQIcw1hj7BXWAoKUJxjDuQTd+Q
 Q6qUVFTjj9uj8kL351LeM+OLawuF6Mk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-uw0md-DKNZSEFqAUSFbWyw-1; Wed, 02 Aug 2023 18:55:39 -0400
X-MC-Unique: uw0md-DKNZSEFqAUSFbWyw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-522c1b1e7bbso145807a12.1
 for <qemu-devel@nongnu.org>; Wed, 02 Aug 2023 15:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691016938; x=1691621738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O6bDyJAzi64yzjQteKBSmqGxvVyLdUeoQCUHYBLkYBA=;
 b=EMtt5P0J80yfYrPt/8/v9ltpSPuVhw+G9FRKhzWyG1HszL5+Q6K57hkjvsO9l1vMtz
 fZA9vig05xK9A34vziJhbX8j+2z/X1pLJYfXWegnNEmxv2duUSNQjbsxcmoXZ8CyeN5d
 vmIQFDNyFSuVFN9lf/esQYLA8rX/Gzrplv4XEZ++OWuVJMgxJimKSmWBkt31iA42PvnM
 O4y0+JSLZQve2QmT8wJ5qlTgDJZ79de+TFvgTQ9ikRw8VteCzz7Cqut5Zg2Z5FEw03PD
 Y14nV4v6xASO7S+1EJPB2kAxVpPnx1LsNwPTEGRG0GE9dWgxoFpypUs+18AvCkju/eq5
 Ef0w==
X-Gm-Message-State: ABy/qLaBho3NGI7dt3qISRvFVA0aSm6bSB9g4JsMj1io90E5DYoy4fmb
 zxFfwyC2/W7dOsZkySCvXcUIFXllzdRTwios5ApEPjYjzIANCopKNWBD3jNcdDohcP7TrzZdbgV
 ir4QWGDfLaGUyaML9d3nSVex6Sn+rhtI=
X-Received: by 2002:aa7:d3d8:0:b0:522:37fc:71fb with SMTP id
 o24-20020aa7d3d8000000b0052237fc71fbmr6054215edr.37.1691016938296; 
 Wed, 02 Aug 2023 15:55:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHgmQKQQhUM4Sph53bRNCEx1SYMT7m8WdMbnU+Mm5hpiHWq0sp9fuvoraopp84YG83EdbHQgFCLe+lUuEalSK8=
X-Received: by 2002:aa7:d3d8:0:b0:522:37fc:71fb with SMTP id
 o24-20020aa7d3d8000000b0052237fc71fbmr6054210edr.37.1691016938060; Wed, 02
 Aug 2023 15:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690106284.git.yin31149@gmail.com>
In-Reply-To: <cover.1690106284.git.yin31149@gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 3 Aug 2023 06:55:01 +0800
Message-ID: <CAPpAL=w-vKty0F9j5hTN4i1s_S1KLNU9spn2D+vNZZ2NV1L-6g@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Vhost-vdpa Shadow Virtqueue VLAN support
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com, 
 qemu-devel@nongnu.org, 18801353760@163.com
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

QE tested v3 of this series using the test steps provided by Hawkins
and everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Sun, Jul 23, 2023 at 8:10=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> This series enables shadowed CVQ to intercept VLAN commands
> through shadowed CVQ, update the virtio NIC device model
> so qemu send it in a migration, and the restore of that
> VLAN state in the destination.
>
> ChangeLog
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> v3:
>  - remove the extra "From" line in patch 1
> "virtio-net: do not reset vlan filtering at set_features"
>
> v2: https://lore.kernel.org/all/cover.1690100802.git.yin31149@gmail.com/
>  - remove the extra line pointed out by Eugenio in patch 3
> "vdpa: Restore vlan filtering state"
>
> v1: https://lore.kernel.org/all/cover.1689690854.git.yin31149@gmail.com/
>  - based on patch "[PATCH 0/3] Vhost-vdpa Shadow Virtqueue VLAN support"
> at https://lists.gnu.org/archive/html/qemu-devel/2022-09/msg01016.html
>  - move `MAX_VLAN` macro to include/hw/virtio/virtio-net.h
> instead of net/vhost-vdpa.c
>  - fix conflicts with the master branch
>
>
> TestStep
> =3D=3D=3D=3D=3D=3D=3D=3D
> 1. test the migration using vp-vdpa device
>   - For L0 guest, boot QEMU with two virtio-net-pci net device with
> `ctrl_vq`, `ctrl_vlan` features on, command line like:
>       -device virtio-net-pci,disable-legacy=3Don,disable-modern=3Doff,
> iommu_platform=3Don,mq=3Don,ctrl_vq=3Don,guest_announce=3Doff,
> indirect_desc=3Doff,queue_reset=3Doff,ctrl_vlan=3Don,...
>
>   - For L1 guest, apply the patch series and compile the source code,
> start QEMU with two vdpa device with svq mode on, enable the `ctrl_vq`,
> `ctrl_vlan` features on, command line like:
>       -netdev type=3Dvhost-vdpa,x-svq=3Dtrue,...
>       -device virtio-net-pci,mq=3Don,guest_announce=3Doff,ctrl_vq=3Don,
> ctrl_vlan=3Don,...
>
>   - For L2 source guest, run the following bash command:
> ```bash
> #!/bin/sh
>
> for idx in {1..4094}
> do
>   ip link add link eth0 name vlan$idx type vlan id $idx
> done
> ```
>
>   - gdb attaches the L2 dest VM and break at the
> vhost_vdpa_net_load_single_vlan(), and execute the following
> gdbscript
> ```gdbscript
> ignore 1 4094
> c
> ```
>
>   - Execute the live migration in L2 source monitor
>
>   - Result
>     * with this series, gdb can hit the breakpoint and continue
> the executing without triggering any error or warning.
>
> Eugenio P=C3=A9rez (1):
>   virtio-net: do not reset vlan filtering at set_features
>
> Hawkins Jiawei (3):
>   virtio-net: Expose MAX_VLAN
>   vdpa: Restore vlan filtering state
>   vdpa: Allow VIRTIO_NET_F_CTRL_VLAN in SVQ
>
>  hw/net/virtio-net.c            |  6 +----
>  include/hw/virtio/virtio-net.h |  6 +++++
>  net/vhost-vdpa.c               | 49 ++++++++++++++++++++++++++++++++++
>  3 files changed, 56 insertions(+), 5 deletions(-)
>
> --
> 2.25.1
>
>



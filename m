Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B0E75AA5D
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 11:03:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMPZ1-0008CP-3s; Thu, 20 Jul 2023 05:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qMPYy-0008C2-8V
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 05:03:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leiyang@redhat.com>)
 id 1qMPYw-00075A-GM
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 05:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689843785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AILHHx55pTnATXsXTaW+6GTijwbcfUt62rHvQUeYZjc=;
 b=T059R8JsmiBEU60FbdgR4uYHSgqt4qpZBQpHpMRqsnF+2l4Mx+zYLCvloUbUZ5QwiF+YpP
 D+7yZxXYkvQicD2tL4xVPikPF1dNp6XoOsASwiKxY8/UAONWCI3Hbj8dajHoX+8TaSx0E6
 pPNdUJCR+mkX8qKaCmqVmdvtep94b3o=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-gUBcfHKlPiy03mHNpZKj8Q-1; Thu, 20 Jul 2023 05:03:04 -0400
X-MC-Unique: gUBcfHKlPiy03mHNpZKj8Q-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fb76659d6cso574408e87.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 02:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689843782; x=1690448582;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AILHHx55pTnATXsXTaW+6GTijwbcfUt62rHvQUeYZjc=;
 b=AjkeEiNkDySqNjVWO9vqm2sjuJiLBYZV3ekeSiVTEhCGOLaKRZTLXLQE6ad1DBBHh6
 5KcyUYeg6qgzehB5Sfm1sFYvB02z/UYhtNCHCbmz/UfVRUGVyXsIE+NUJtu3TWQkRQGl
 IkRrXp3DWMM3mPyUWqL5toUSMLlJG74IukxGT2Px0Fp1B6qVk7UmIygSv2lrD1+aX/RW
 3k6+vckJU74OMAJqK7VDgBy4mHf20AlsoD/MFCEcUAjTmfkKhXF5A3pjcrDImblUz/94
 AEsUoB8kROt0RAdRrin4wGPZ5zpfHkVBEy9SOMlibrBJYA4APT1R48z4Lpb15DlGORZN
 o13A==
X-Gm-Message-State: ABy/qLYqsGDt3zYIviK0yoAFabLsqKa6vS0Gr2JLw16Br+LMk8NLnNPg
 FtwJ745bwDaCgvoiooreyNEnsnHUVxpiUBk9xqlVghhrxminBW5ih1JHykPHOWulgrdotflBYg0
 cqHAmd/W52x7bVGEmHy3RHdK14yA4R6Y=
X-Received: by 2002:a19:5f57:0:b0:4fd:d517:fbd8 with SMTP id
 a23-20020a195f57000000b004fdd517fbd8mr1783862lfj.9.1689843782730; 
 Thu, 20 Jul 2023 02:03:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFg1RnrYmC6uabVeOS5CE3NcpbhvK7TbQ3963uYNrY2XsANhyfhYPXZUxcb+swcE3D8rKNIsh4zYfsSCvhqRkU=
X-Received: by 2002:a19:5f57:0:b0:4fd:d517:fbd8 with SMTP id
 a23-20020a195f57000000b004fdd517fbd8mr1783842lfj.9.1689843782330; Thu, 20 Jul
 2023 02:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689690854.git.yin31149@gmail.com>
 <CAKrof1Nn83WbjHgBPjYXtxMOC_OC44Si4-J+HsmRu7yF1+gfNw@mail.gmail.com>
In-Reply-To: <CAKrof1Nn83WbjHgBPjYXtxMOC_OC44Si4-J+HsmRu7yF1+gfNw@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Thu, 20 Jul 2023 17:02:25 +0800
Message-ID: <CAPpAL=z5wkx5X-wbvx8mTL_h7fhUuHC4V57Cqt63gnFHtFbbUA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Vhost-vdpa Shadow Virtqueue VLAN support
To: Hawkins Jiawei <yin31149@gmail.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com, 
 qemu-devel@nongnu.org, 18801353760@163.com
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

QE tested this series patch with real hardware, it can support setup
vlan for the nic, and the vlan id still can be found after finished
migrate. In addition, this series patch also help to test another
patch, can got the expect result.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Jul 19, 2023 at 6:54=E2=80=AFPM Hawkins Jiawei <yin31149@gmail.com>=
 wrote:
>
> =E5=9C=A8 2023/7/19 15:47, Hawkins Jiawei =E5=86=99=E9=81=93:
> > This series enables shadowed CVQ to intercept VLAN commands
> > through shadowed CVQ, update the virtio NIC device model
> > so qemu send it in a migration, and the restore of that
> > VLAN state in the destination.
>
> This patch series is based on
> "[PATCH 0/3] Vhost-vdpa Shadow Virtqueue VLAN support" at [1],
> with these changes:
>
>   - move `MAX_VLAN` macro to include/hw/virtio/virtio-net.h
> instead of net/vhost-vdpa.c
>   - fix conflicts with the master branch
>
> Thanks!
>
> [1]. https://lists.gnu.org/archive/html/qemu-devel/2022-09/msg01016.html
>
>
> >
> > TestStep
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > 1. test the migration using vp-vdpa device
> >    - For L0 guest, boot QEMU with two virtio-net-pci net device with
> > `ctrl_vq`, `ctrl_vlan` features on, command line like:
> >        -device virtio-net-pci,disable-legacy=3Don,disable-modern=3Doff,
> > iommu_platform=3Don,mq=3Don,ctrl_vq=3Don,guest_announce=3Doff,
> > indirect_desc=3Doff,queue_reset=3Doff,ctrl_vlan=3Don,...
> >
> >    - For L1 guest, apply the patch series and compile the source code,
> > start QEMU with two vdpa device with svq mode on, enable the `ctrl_vq`,
> > `ctrl_vlan` features on, command line like:
> >        -netdev type=3Dvhost-vdpa,x-svq=3Dtrue,...
> >        -device virtio-net-pci,mq=3Don,guest_announce=3Doff,ctrl_vq=3Don=
,
> > ctrl_vlan=3Don,...
> >
> >    - For L2 source guest, run the following bash command:
> > ```bash
> > #!/bin/sh
> >
> > for idx in {1..4094}
> > do
> >    ip link add link eth0 name vlan$idx type vlan id $idx
> > done
> > ```
> >
> >    - gdb attaches the L2 dest VM and break at the
> > vhost_vdpa_net_load_single_vlan(), and execute the following
> > gdbscript
> > ```gdbscript
> > ignore 1 4094
> > c
> > ```
> >
> >    - Execute the live migration in L2 source monitor
> >
> >    - Result
> >      * with this series, gdb can hit the breakpoint and continue
> > the executing without triggering any error or warning.
> >
> > Eugenio P=C3=A9rez (1):
> >    virtio-net: do not reset vlan filtering at set_features
> >
> > Hawkins Jiawei (3):
> >    virtio-net: Expose MAX_VLAN
> >    vdpa: Restore vlan filtering state
> >    vdpa: Allow VIRTIO_NET_F_CTRL_VLAN in SVQ
> >
> >   hw/net/virtio-net.c            |  6 +---
> >   include/hw/virtio/virtio-net.h |  6 ++++
> >   net/vhost-vdpa.c               | 50 +++++++++++++++++++++++++++++++++=
+
> >   3 files changed, 57 insertions(+), 5 deletions(-)
> >
>



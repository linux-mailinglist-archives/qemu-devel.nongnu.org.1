Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AE2757A3C
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 13:15:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLig2-0004sV-VF; Tue, 18 Jul 2023 07:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qLift-0004ZV-TC
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 07:15:31 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qLifq-00048K-Dx
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 07:15:24 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b8392076c9so69178761fa.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 04:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1689678920; x=1692270920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8VgM+9b1Vs0QQYAvUZjUGZl7659md+QU8dkD5Epi/zg=;
 b=0rgT7CXf3vgYOVjGliX40nq5CtjUxv2Dbi++9Wt7KDvQX9LDbIYEQLPlOe1QoI3Xk1
 qNukX6yTLRDj3tg479Nflodv83bqtQVni3sOicpXGJIrhpI0iZLOw6hhsVnXqEF9rMQm
 PjwxILMDXiSlXGJEy79GyRS2VY0dbc5rToh7aMOy/E3DMSsRnRkRwNTEHPwpjFtO/25t
 HLQAkBsGsjNFk9+NBSSJV35zvDmk47G4SmwjDGvIHmfC0oN+z5UwI9/a9rsjbgNm9S/b
 lRMfOcdwuTR0N3ur9tDRq9iNtg+sO/bhBQ0UOMsI0Lt+2C9px53uRGN3Gr1ZOxq+Ggo6
 BVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689678920; x=1692270920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8VgM+9b1Vs0QQYAvUZjUGZl7659md+QU8dkD5Epi/zg=;
 b=MP9vT3V4acdgTqH3bEt2aLFNfyIAZol86TVOQ/aWbcGca1vy4qnajtDkbhy8xElaKh
 DQtIvwv5iIyUP64B/w9fiiRVoFsTs0jw9HYIcYmWBqwGR8GdCDHBBk7d9a55fp0FSflt
 09o012V/o+MFzzyiq9tPVwsdCYSwfv0hv83OZkftwgiJ0H3o6wCEEQvYMzxv9sbDWXBi
 UTL5SIA1koJ+7TGG7WMmUsy/eYcUMvjMKtV6HFx5xXf3NScDVpuov4g8aJhaNw3j3ujN
 OFntUkPo0NNdkBUEaGVqII0Nui4hhZGSAUrDB9z1yo9GXr6wK9aMEMNKTmR4LQiBgUWd
 eZQA==
X-Gm-Message-State: ABy/qLZy30z0SzED4lgSFWSHf2gRoGHeI7ous5f27kpBm5yEOotkYxT3
 0NIj/fpk3Ay2hZ7fgxobFWwLpizmZ6TPgaS6Pr4sWEsSspYwPzJiH25rFg==
X-Google-Smtp-Source: APBJJlHAj3JMc6bn5iYPgd7RQmoxHp3LL1o51vKvZYpvGD+ntsjIuiNgzj+AFOEOJXL3mJmBmdk9eGZ6zY8m/+4uoOA=
X-Received: by 2002:a2e:9455:0:b0:2b6:a08d:e142 with SMTP id
 o21-20020a2e9455000000b002b6a08de142mr10264871ljh.7.1689678920458; Tue, 18
 Jul 2023 04:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230626091258.24453-1-viktor@daynix.com>
In-Reply-To: <20230626091258.24453-1-viktor@daynix.com>
From: Viktor Prutyanov <viktor@daynix.com>
Date: Tue, 18 Jul 2023 14:15:09 +0300
Message-ID: <CAPv0NP4cVWZJPBOUO3TE8VDMNRz+6qLws4b3akU-3oLpxthSFg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] vhost: register and change IOMMU flag depending on
 ATS state
To: mst@redhat.com, jasowang@redhat.com
Cc: qemu-devel@nongnu.org, yan@daynix.com, yuri.benditovich@daynix.com, 
 qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::22b;
 envelope-from=viktor@daynix.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Jun 26, 2023 at 12:13=E2=80=AFPM Viktor Prutyanov <viktor@daynix.co=
m> wrote:
>
> When IOMMU and vhost are enabled together, QEMU tracks IOTLB or
> Device-TLB unmap events depending on whether Device-TLB is enabled. But
> even if Device-TLB and PCI ATS is enabled, the guest can reject to use
> it. For example, this situation appears when Windows Server 2022 is
> running with intel-iommu with device-iotlb=3Don and virtio-net-pci with
> vhost=3Don. The guest implies that no address translation info cached in
> device IOTLB and doesn't send device IOTLB invalidation commands. So,
> it leads to irrelevant address translations in vhost-net in the host
> kernel. Therefore network frames from the guest in host tap interface
> contains wrong payload data.
>
> This series adds checking of ATS state for proper unmap flag register
> (IOMMU_NOTIFIER_UNMAP or IOMMU_NOTIFIER_DEVIOTLB_UNMAP).
>
> Tested on Windows Server 2022, Windows 11 and Fedora guests with
>  -device virtio-net-pci,bus=3Dpci.3,netdev=3Dnd0,iommu_platform=3Don,ats=
=3Don
>  -netdev tap,id=3Dnd0,ifname=3Dtap1,script=3Dno,downscript=3Dno,vhost=3Do=
n
>  -device intel-iommu,intremap=3Don,eim=3Don,device-iotlb=3Don/off
> Tested on Fedora guest with
>  -device virtio-iommu
>
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D2001312
>
> v5: add vhost_toggle_device_iotlb to vhost-stub
> v4: call vhost_toggle_device_iotlb regardless of vhost backend,
>     move vhost_started check to generic part
> v3: call virtio_pci_ats_ctrl_trigger directly, remove
>     IOMMU_NOTIFIER_UNMAP fallbacks
> v2: remove memory_region_iommu_notify_flags_changed, move trigger to
>     VirtioDeviceClass, use vhost_ops, use device_iotlb name
>
> Viktor Prutyanov (2):
>   vhost: register and change IOMMU flag depending on Device-TLB state
>   virtio-net: pass Device-TLB enable/disable events to vhost
>
>  hw/net/virtio-net.c       |  1 +
>  hw/virtio/vhost-stub.c    |  4 ++++
>  hw/virtio/vhost.c         | 38 ++++++++++++++++++++++++++------------
>  include/hw/virtio/vhost.h |  1 +
>  4 files changed, 32 insertions(+), 12 deletions(-)
>
> --
> 2.21.0
>

As we discussed with Jason, this series should be also applied to
qemu-stable, as well as "virtio-pci: add handling of PCI ATS and
Device-TLB enable/disable"
https://patchwork.kernel.org/project/qemu-devel/patch/20230512135122.70403-=
2-viktor@daynix.com

Best regards
Viktor Prutyanov


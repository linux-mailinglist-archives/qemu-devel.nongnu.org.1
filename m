Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF3C74574E
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 10:26:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGEsV-0007tZ-Ue; Mon, 03 Jul 2023 04:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qGEsR-0007tF-2s
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 04:25:43 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viktor@daynix.com>) id 1qGEsN-00078D-38
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 04:25:41 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b69e6d324aso65201051fa.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 01:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688372737; x=1690964737;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ifprR0VgQZZO8H8tgbXHfhQcxSVVWpcFS6iQQTmEic=;
 b=kbqzPRB6z73eIxhIaRywm4iFxbECs5XgK8zM3QA76RwCbPMwHHKTcs0Jxj2lt+CH7h
 ZDyig7FuGef/tYw5o9Wr4udIWQ6UcF+gWH7daNzuSz9F4s7/fRyQoAnqjhS4NPdIyz+L
 LfOmsknsLbgUEdAr/Riwg0sJRvn47Sl7/siKsRYhFnM32r/BN/hfsOMDIv0owZljbz3N
 kXretwLoCrVb/k7e445bTAv7HepUoI+HMip4xBv7pOxA6chvF5OcEuW5IkqmsMMKQ8HW
 cLXIS+1uI30guMVW4zHD1p7JD5XZ6Fkv5Q9yFIEAXqJst2TMlq567ViNuDxRD8xW/mC4
 wO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688372737; x=1690964737;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ifprR0VgQZZO8H8tgbXHfhQcxSVVWpcFS6iQQTmEic=;
 b=kmhH12D0YOUSohrNzFy/JfaZykvtn+bV15E8IqjgSwlTihV1NkPZkgTXv8ojbddHm0
 4Dv8NBDsRMRDvDneNbD8JpuX6dXcWeyD3NGGmY0mHakDAOJT7pwR8nEsbj+V2kIr7gil
 ioxQVO9KuK93iQAgR48EYm8ysxD0BqkDtqeFyxEboZwE4AIpU5ypP+amo5Ko1XrtqWVH
 OKPBkeI2BemgxnHs8TtfILBKtvE6BjJxEYrYzgCau84feaG4SMuW5UpleWKudKEueL70
 I7znnB2cSFqTNuuCSxPXtvVlkO3z1pdE1cfkJkPMHg9U+tBoR9S6wRlWcF4qJcd6w9gV
 61hQ==
X-Gm-Message-State: ABy/qLaAUtw3YoBRm2G7w8FTRV2iEvMDaQrCh4v+in+X/cqG3HpZSqcb
 ocVxLKl3uAInBQ2JAUOQW6QII2vBXzdXwtbB8501/A==
X-Google-Smtp-Source: APBJJlGIkuGQB8Hl6xZMfMStYof3ipHO+rrJpEMXLLb5wpv3R4M4BHDU1LU+B6Bx2S1bvjfBiSXH3NQIWwTz5IdGOds=
X-Received: by 2002:a2e:980c:0:b0:2b6:b864:fac6 with SMTP id
 a12-20020a2e980c000000b002b6b864fac6mr5749386ljj.37.1688372736599; Mon, 03
 Jul 2023 01:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230626091258.24453-1-viktor@daynix.com>
In-Reply-To: <20230626091258.24453-1-viktor@daynix.com>
From: Viktor Prutyanov <viktor@daynix.com>
Date: Mon, 3 Jul 2023 11:25:25 +0300
Message-ID: <CAPv0NP5LrA4XzG8xOsQj=7BHJdd=dJf5QMLCf-r6PyWtx4X6hg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] vhost: register and change IOMMU flag depending on
 ATS state
To: mst@redhat.com, jasowang@redhat.com
Cc: qemu-devel@nongnu.org, yan@daynix.com, yuri.benditovich@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2a00:1450:4864:20::231;
 envelope-from=viktor@daynix.com; helo=mail-lj1-x231.google.com
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

ping


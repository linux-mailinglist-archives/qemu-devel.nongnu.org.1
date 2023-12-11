Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A95D680BF79
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 03:54:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCWPn-000878-DT; Sun, 10 Dec 2023 21:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rCWPl-00086k-9X
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 21:53:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rCWPj-00017Z-Ae
 for qemu-devel@nongnu.org; Sun, 10 Dec 2023 21:53:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702263176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=35kwueIVLbohUJWygUGaS7qIW6YOryfOZltIvdLQELo=;
 b=DOj7nPoIKLVlyIGcDwqAy8c2aGNPRWUTJoL3E2pKiH1myBMab4IQqzTzK9zkOiXSArIN9e
 xtNIH2yQXBbKaJLEYP562swZps6bdNTTd61WMFzy9mftUuKskscBFn5vQZogP9mLA/2NTw
 YmcvS0uOvrE5d5geuYU/pCAs1nWvdr8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-eDWDu9FlPCuRhddhPqlOQA-1; Sun, 10 Dec 2023 21:52:54 -0500
X-MC-Unique: eDWDu9FlPCuRhddhPqlOQA-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5b8d4a559ddso3809926a12.1
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 18:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702263174; x=1702867974;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=35kwueIVLbohUJWygUGaS7qIW6YOryfOZltIvdLQELo=;
 b=BVDEpNxCvwiaKp4b7dzPuwn2+YldWh8lRxIKVZh2brgl72cZNhBIoGBd4rUWqHkuQv
 RRX8nhqa46u1ByNGwSXtZyMMKOeH1Pdv1F7GCh5V/DF8B4gn0hg/tOOpqCAWw4aohf+z
 BH9BxX2e3Nqq8J2JkzJ5+a0BsTCV6mr+hyUlFgzwXwE01td6MYrhAqcXH60YTcyoC17l
 bqmwb6v/iz3MhrqTyZU5SRCa1dxpuaDxyTZuQZ0kb6tM9pvcmkjrFcydy20e8kT1+EX7
 2KWBmyCklNMiXuE8Mz66/iDIMowOwD+y5+hdR99iDTIjGqI1ZQ7+YLrpJDfRUjAijGTa
 qYwg==
X-Gm-Message-State: AOJu0YwUIVfjhTz6FKhHeZaT22UWXEKlG/kioKpy5yjvvAoXAgerj2sk
 vTNoqdfFHFXShzaaYnUtZxEyDAF0zF+gPg1iY5CgNt12QawBQkE5TuMVJ0aFt4xXDCsEfJmq9Ny
 kukpq/BE8cGL4Ajg7vIQZ+l6hgNCs4UE=
X-Received: by 2002:a05:6a20:7350:b0:190:85d9:9d4e with SMTP id
 v16-20020a056a20735000b0019085d99d4emr5035747pzc.123.1702263173850; 
 Sun, 10 Dec 2023 18:52:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIWgPvWl1eotlUq16RLnDwu9b3f7Ar++68xQbmRXT4aYvrPMjXwJg8hf9NB/Jf+RqAWnWgBY2+kZ9P0u3H2lU=
X-Received: by 2002:a05:6a20:7350:b0:190:85d9:9d4e with SMTP id
 v16-20020a056a20735000b0019085d99d4emr5035725pzc.123.1702263173459; Sun, 10
 Dec 2023 18:52:53 -0800 (PST)
MIME-Version: 1.0
References: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
In-Reply-To: <20231210-sriov-v2-0-b959e8a6dfaf@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Dec 2023 10:52:41 +0800
Message-ID: <CACGkMEuYa7CUUp6F4D91P0mg=2GadhRESCx2j63P7Fkm42q++w@mail.gmail.com>
Subject: Re: [PATCH RFC v2 00/12] virtio-net: add support for SR-IOV emulation
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Yui Washizu <yui.washidu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sun, Dec 10, 2023 at 12:06=E2=80=AFPM Akihiko Odaki <akihiko.odaki@dayni=
x.com> wrote:
>
> Introduction
> ------------
>
> This series is based on the RFC series submitted by Yui Washizu[1].
> See also [2] for the context.
>
> This series enables SR-IOV emulation for virtio-net. It is useful
> to test SR-IOV support on the guest, or to expose several vDPA devices
> in a VM. vDPA devices can also provide L2 switching feature for
> offloading though it is out of scope to allow the guest to configure
> such a feature.
>
> The PF side code resides in virtio-pci. The VF side code resides in
> the PCI common infrastructure, but it is restricted to work only for
> virtio-net-pci because of lack of validation.
>
> User Interface
> --------------
>
> A user can configure a SR-IOV capable virtio-net device by adding
> virtio-net-pci functions to a bus. Below is a command line example:
>   -netdev user,id=3Dn -netdev user,id=3Do
>   -netdev user,id=3Dp -netdev user,id=3Dq
>   -device pcie-root-port,id=3Db
>   -device virtio-net-pci,bus=3Db,addr=3D0x0.0x3,netdev=3Dq,sriov-pf=3Df
>   -device virtio-net-pci,bus=3Db,addr=3D0x0.0x2,netdev=3Dp,sriov-pf=3Df
>   -device virtio-net-pci,bus=3Db,addr=3D0x0.0x1,netdev=3Do,sriov-pf=3Df
>   -device virtio-net-pci,bus=3Db,addr=3D0x0.0x0,netdev=3Dn,id=3Df
>
> The VFs specify the paired PF with "sriov-pf" property. The PF must be
> added after all VFs. It is user's responsibility to ensure that VFs have
> function numbers larger than one of the PF, and the function numbers
> have a consistent stride.

This seems not user friendly. Any reason we can't just allow user to
specify the stride here?

Btw, I vaguely remember qemu allows the params to be accepted as a
list. If this is true, we can accept a list of netdev here?

>
> Keeping VF instances
> --------------------
>
> A problem with SR-IOV emulation is that it needs to hotplug the VFs as
> the guest requests. Previously, this behavior was implemented by
> realizing and unrealizing VFs at runtime. However, this strategy does
> not work well for the proposed virtio-net emulation; in this proposal,
> device options passed in the command line must be maintained as VFs
> are hotplugged, but they are consumed when the machine starts and not
> available after that, which makes realizing VFs at runtime impossible.

Could we store the device options in the PF?

Thanks

>
> As an strategy alternative to runtime realization/unrealization, this
> series proposes to reuse the code to power down PCI Express devices.
> When a PCI Express device is powered down, it will be hidden from the
> guest but will be kept realized. This effectively implements the
> behavior we need for the SR-IOV emulation.
>
> Summary
> -------
>
> Patch [1, 5] refactors the PCI infrastructure code.
> Patch [6, 10] adds user-created SR-IOV VF infrastructure.
> Patch 11 makes virtio-pci work as SR-IOV PF for user-created VFs.
> Patch 12 allows user to create SR-IOV VFs with virtio-net-pci.
>
> [1] https://patchew.org/QEMU/1689731808-3009-1-git-send-email-yui.washidu=
@gmail.com/
> [2] https://lore.kernel.org/all/5d46f455-f530-4e5e-9ae7-13a2297d4bc5@dayn=
ix.com/
>
> Co-developed-by: Yui Washizu <yui.washidu@gmail.com>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v2:
> - Changed to keep VF instances.
> - Link to v1: https://lore.kernel.org/r/20231202-sriov-v1-0-32b3570f7bd6@=
daynix.com
>
> ---
> Akihiko Odaki (12):
>       hw/pci: Initialize PCI multifunction after realization
>       hw/pci: Determine if rombar is explicitly enabled
>       hw/pci: Do not add ROM BAR for SR-IOV VF
>       vfio: Avoid inspecting option QDict for rombar
>       hw/qdev: Remove opts member
>       pcie_sriov: Reuse SR-IOV VF device instances
>       pcie_sriov: Release VFs failed to realize
>       pcie_sriov: Ensure PF and VF are mutually exclusive
>       pcie_sriov: Check PCI Express for SR-IOV PF
>       pcie_sriov: Allow user to create SR-IOV device
>       virtio-pci: Implement SR-IOV PF
>       virtio-net: Implement SR-IOV VF
>
>  docs/pcie_sriov.txt         |   8 +-
>  include/hw/pci/pci.h        |   2 +-
>  include/hw/pci/pci_device.h |  13 +-
>  include/hw/pci/pcie_sriov.h |  25 ++-
>  include/hw/qdev-core.h      |   4 -
>  hw/core/qdev.c              |   1 -
>  hw/net/igb.c                |   3 +-
>  hw/nvme/ctrl.c              |   3 +-
>  hw/pci/pci.c                |  98 +++++++-----
>  hw/pci/pci_host.c           |   4 +-
>  hw/pci/pcie.c               |   4 +-
>  hw/pci/pcie_sriov.c         | 360 +++++++++++++++++++++++++++++++++-----=
------
>  hw/vfio/pci.c               |   3 +-
>  hw/virtio/virtio-net-pci.c  |   1 +
>  hw/virtio/virtio-pci.c      |   7 +
>  system/qdev-monitor.c       |  12 +-
>  16 files changed, 395 insertions(+), 153 deletions(-)
> ---
> base-commit: 4705fc0c8511d073bee4751c3c974aab2b10a970
> change-id: 20231202-sriov-9402fb262be8
>
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>



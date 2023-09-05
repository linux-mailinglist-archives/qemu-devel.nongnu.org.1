Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF007920FB
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 10:24:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdRL2-0000WO-IM; Tue, 05 Sep 2023 04:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1qdRKy-0000Vn-RL
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 04:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1qdRKw-0007xD-BD
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 04:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693902181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVjPD8AoT+QrHLRRbYATUsSdnhXkyoiXkwqydo/QK3E=;
 b=fFV8BfmUCJ60eJiw1QMR80lycfNRKQ75KzwTQoSyjdgkCRjr8L9AR67Df3zTvdlNDcz8Ac
 /v7H2eEkzsPaiuCO/xrXn/Jpqq16WRjQK+DU0CJkAVNMJ/CSw2QUcHTdoctK1k8os/3Uj3
 SDjnJnXMtKx/TPoWRlrI+TxRF8FbtFY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-B5HD8L0uO9WgUrfMXggAZg-1; Tue, 05 Sep 2023 04:22:59 -0400
X-MC-Unique: B5HD8L0uO9WgUrfMXggAZg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50076a3fd35so2190120e87.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 01:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693902178; x=1694506978;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UVjPD8AoT+QrHLRRbYATUsSdnhXkyoiXkwqydo/QK3E=;
 b=hCb5KWqA8sE791ChINXldduGDbsPyuk6uW/dR31pDbYJ/LjG/dbNUwkDF7uewp7VqF
 cfd/+6J1bToWql7roHc0kzJM9Snd96qN5PS5qs58L3O+zlABO3wlw3ZYMXW7DFAp0qs7
 A1Bqj6kaE1d8qGcinnRb3EKVSXxQ+zEzgjrZREE8yWX3aXk67uZWWL6uJp32xcBbZGKf
 dKoyA5x5XH0Bgx6PL3GlckCwi0gqdwRuy997ZVdLWErl6595At6oqibtpzIasZ6I8nDE
 GDresN+qkHZQRyJaoDL92OpJggRwsKxSaO1Zi8slN06O/u4/2PJv3PfSxqNjX29Kgz/o
 mS+w==
X-Gm-Message-State: AOJu0YyPt/OXRZu1Va/BNi/8IpSmOiioAekatVGAhWuxcKL6lETh/3aQ
 vIwLiMfDKyrwYuHLFVJKAITmt3qZf34wqx2pAWM9jQIA64D8IhOQhH705VfuXcFPE2ezveHKWe2
 0w3fHgkclhfSY5Was6w2wUNJL86l56L8=
X-Received: by 2002:a05:6512:3a94:b0:4fd:fedc:2ce5 with SMTP id
 q20-20020a0565123a9400b004fdfedc2ce5mr9237673lfu.36.1693902177936; 
 Tue, 05 Sep 2023 01:22:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgFex1xlctuIGvf3YeKFI6em5V1OVktnNgZTi8N+zhiESsv2i+gKtTDTKO6R5sEtRS+P7a4tdH52cxxqcAaz4=
X-Received: by 2002:a05:6512:3a94:b0:4fd:fedc:2ce5 with SMTP id
 q20-20020a0565123a9400b004fdfedc2ce5mr9237517lfu.36.1693902172779; Tue, 05
 Sep 2023 01:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230904080451.424731-1-eric.auger@redhat.com>
In-Reply-To: <20230904080451.424731-1-eric.auger@redhat.com>
From: YangHang Liu <yanghliu@redhat.com>
Date: Tue, 5 Sep 2023 16:22:41 +0800
Message-ID: <CAGYh1E9+odNLWuuPQdb4RqcSh-uDHW0DiVCKVJH=oA56BqqPtw@mail.gmail.com>
Subject: Re: [PATCH 00/13] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 alex.williamson@redhat.com, clg@redhat.com, jean-philippe@linaro.org, 
 mst@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yanghliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

I have runned the following two tests, but both tests failed:
[1] start a VM with virtio-iommu + 2 ice PFs only via qemu-kvm 8.1.5
Test result : the qemu-kvm keeps throwing the error:  VFIO_MAP_DMA
failed: File exists. vfio_dma_map(0x56443d20fbe0, 0xffffe000, 0x1000,
0x7fb545709000) =3D -17 (File exists)
[2] start a VM with virtio-iommu + 2 ice PFs via libvirt-9.5 + qemu-kvm 8.1=
.5
Test result: the qemu-kvm core dump with
ERROR:../qom/object.c:1198:object_unref: assertion failed: (obj->ref >
0). Bail out! ERROR:../qom/object.c:1198:object_unref: assertion
failed: (obj->ref > 0)

After removing the 2 PF from the VM, both tests passed.

Tested-by: Yanghang Liu <yanghliu@redhat.com>

Best Regards,
YangHang Liu


On Mon, Sep 4, 2023 at 4:08=E2=80=AFPM Eric Auger <eric.auger@redhat.com> w=
rote:
>
> On x86, when assigning VFIO-PCI devices protected with virtio-iommu
> we encounter the case where the guest tries to map IOVAs beyond 48b
> whereas the physical VTD IOMMU only supports 48b. This ends up with
> VFIO_MAP_DMA failures at qemu level because at kernel level,
> vfio_iommu_iova_dma_valid() check returns false on vfio_map_do_map().
>
> This is due to the fact the virtio-iommu currently unconditionally
> exposes an IOVA range of 64b through its config input range fields.
>
> This series removes this assumption by retrieving the usable IOVA
> regions through the VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE UAPI when
> a VFIO device is attached. This info is communicated to the
> virtio-iommu memory region, transformed into the inversed info, ie.
> the host reserved IOVA regions. Then those latter are combined with the
> reserved IOVA regions set though the virtio-iommu reserved-regions
> property. That way, the guest virtio-iommu driver, unchanged, is
> able to probe the whole set of reserved regions and prevent any IOVA
> belonging to those ranges from beeing used, achieving the original goal.
>
> Best Regards
>
> Eric
>
> This series can be found at:
> https://github.com/eauger/qemu/tree/virtio-iommu_geometry_v1
>
> Eric Auger (13):
>   memory: Let ReservedRegion use Range
>   memory: Introduce memory_region_iommu_set_iova_ranges
>   vfio: Collect container iova range info
>   virtio-iommu: Rename reserved_regions into prop_resv_regions
>   virtio-iommu: Introduce per IOMMUDevice reserved regions
>   range: Introduce range_inverse_array()
>   virtio-iommu: Implement set_iova_ranges() callback
>   range: Make range_compare() public
>   util/reserved-region: Add new ReservedRegion helpers
>   virtio-iommu: Consolidate host reserved regions and property set ones
>   test: Add some tests for range and resv-mem helpers
>   virtio-iommu: Resize memory region according to the max iova info
>   vfio: Remove 64-bit IOVA address space assumption
>
>  include/exec/memory.h            |  30 ++++-
>  include/hw/vfio/vfio-common.h    |   2 +
>  include/hw/virtio/virtio-iommu.h |   7 +-
>  include/qemu/range.h             |   9 ++
>  include/qemu/reserved-region.h   |  32 +++++
>  hw/core/qdev-properties-system.c |   9 +-
>  hw/vfio/common.c                 |  70 ++++++++---
>  hw/virtio/virtio-iommu-pci.c     |   8 +-
>  hw/virtio/virtio-iommu.c         |  85 +++++++++++--
>  softmmu/memory.c                 |  15 +++
>  tests/unit/test-resv-mem.c       | 198 +++++++++++++++++++++++++++++++
>  util/range.c                     |  41 ++++++-
>  util/reserved-region.c           |  94 +++++++++++++++
>  hw/virtio/trace-events           |   1 +
>  tests/unit/meson.build           |   1 +
>  util/meson.build                 |   1 +
>  16 files changed, 562 insertions(+), 41 deletions(-)
>  create mode 100644 include/qemu/reserved-region.h
>  create mode 100644 tests/unit/test-resv-mem.c
>  create mode 100644 util/reserved-region.c
>
> --
> 2.41.0
>
>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF697AE766
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 10:07:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql35s-0002HB-UQ; Tue, 26 Sep 2023 04:06:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1ql35n-0002EM-Ok
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:06:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1ql35W-0008LO-Sd
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695715589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A2xHSU2o24iICT9Grnk7x10hg7dKkfIEckDiSwKpDHk=;
 b=EVv31g0Cy22yrGdWvIEYC4KGDvdMM/Gr/V/KcogZEt2ISoXCKLrT6hSuINVo1wAzokj12m
 Wdw2VVgttzBfimSBuH4TmrBBGXMKf82fmzNmaBjCpwO+XYEFv9iUh2ETXBNuvsMejRJvZX
 1fNcF8ogwjlIbHbCfptjd1DSX/Bt0ls=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-QRoF_iAbPN6wNeWrTrE1vg-1; Tue, 26 Sep 2023 04:06:28 -0400
X-MC-Unique: QRoF_iAbPN6wNeWrTrE1vg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50433ca6d81so10410031e87.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 01:06:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695715586; x=1696320386;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A2xHSU2o24iICT9Grnk7x10hg7dKkfIEckDiSwKpDHk=;
 b=wxibewiSksLEbZb60lT56SzJPZ+oJMQdRbi2Byr0s1nOCv3shB7ph7e9u6mS28UjDN
 noBoyiyDPCsEmujZ6ZF3KFUwsT4OrF22hM1t+2I+YZnhzXWWzfBh+3Avkf2EEzHcY6DK
 Ka99Gik0JgbJDgWIW/NiBfxVeZcKOWVjPFBtyPLGLrl0nr1RX8r9SXDBeWkdHxqkx6Ga
 eZX74XGz73oacKortUYlxtQaJyjctEqtfajTyxc1hvcjo1zTMsDaQkYl8Kxc2cCejrX3
 KTzqSv82dtNj8uaKlvlODUA+M5xQLYUC3ki/aiVxiVytOm3tn0BBnF9clrA/PHjGDob3
 EVww==
X-Gm-Message-State: AOJu0YwLXmruU0yyFRAchskFEn7wQxT8LAQMuwOiDgt1qE79VXt9qsOz
 Q2kQtteW5d4CPK5AHjjWMf7lEUwic4UlqFrHL/OaDCrbUQnlZna9rkTxktMM5uLeKv1nlnIOFnL
 bYKUL36lGAvHpnd7VViTjIqnjK9bXcTA=
X-Received: by 2002:a19:2d07:0:b0:502:d6b2:922e with SMTP id
 k7-20020a192d07000000b00502d6b2922emr6310306lfj.46.1695715586484; 
 Tue, 26 Sep 2023 01:06:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2LMuHYfA1SxFRmxCA/pJmbiWuQr9yf8ygo3H+DLZR/IjczXFIEtFWPlu5l08fkpbJwJby33UAiKyRSAlCWDg=
X-Received: by 2002:a19:2d07:0:b0:502:d6b2:922e with SMTP id
 k7-20020a192d07000000b00502d6b2922emr6310273lfj.46.1695715586060; Tue, 26 Sep
 2023 01:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230913080423.523953-1-eric.auger@redhat.com>
In-Reply-To: <20230913080423.523953-1-eric.auger@redhat.com>
From: YangHang Liu <yanghliu@redhat.com>
Date: Tue, 26 Sep 2023 16:06:14 +0800
Message-ID: <CAGYh1E8QN22gpS5GAWRAOZHNgacrwiKty-LgwpByi-QRVqpoag@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 alex.williamson@redhat.com, clg@redhat.com, jean-philippe@linaro.org, 
 mst@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=yanghliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

The original issue I found : After starting a VM which has two ice PFs
and a virtio-iommu device, qemu-kvm and VM guest dmesg throw lots of
duplicate VFIO_MAP_DMA errors

After testing with Eric's build, the  original issue is gone and the
Tier1 regression test against ice PF and virtio iommu device gets PASS
as well.

Tested-by: Yanghang Liu <yanghliu@redhat.com>



On Wed, Sep 13, 2023 at 4:06=E2=80=AFPM Eric Auger <eric.auger@redhat.com> =
wrote:
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
> https://github.com/eauger/qemu/tree/virtio-iommu_geometry_v2
>
> History:
> v1 -> v2:
> - Remove "[PATCH 12/13] virtio-iommu: Resize memory region according
>   to the max iova info" which causes way too much trouble: trigger
>   a coredump in vhost, causes duplication of IOMMU notifiers causing
>   EEXIST vfio_dma_map errors, ... This looks like a bad usage of the
>   memory API so I prefer removing this from this series. So I was
>   also obliged to remove the vfio_find_hostwin() check in the case
>   of an IOMMU MR.
> - Let range_inverse_array() take low/high args instead of hardcoding
>   0, UINT64_MAX which both complexifies the algo and the tests.
> - Move range function description in header.
> - Check that if set_iova_ranges is called several times, new resv
>   regions are included in previous ones
>
> Eric Auger (12):
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
>   vfio: Remove 64-bit IOVA address space assumption
>
>  include/exec/memory.h            |  30 +++-
>  include/hw/vfio/vfio-common.h    |   2 +
>  include/hw/virtio/virtio-iommu.h |   7 +-
>  include/qemu/range.h             |  14 ++
>  include/qemu/reserved-region.h   |  32 ++++
>  hw/core/qdev-properties-system.c |   9 +-
>  hw/vfio/common.c                 |  70 +++++++--
>  hw/virtio/virtio-iommu-pci.c     |   8 +-
>  hw/virtio/virtio-iommu.c         | 110 ++++++++++++--
>  softmmu/memory.c                 |  15 ++
>  tests/unit/test-resv-mem.c       | 251 +++++++++++++++++++++++++++++++
>  util/range.c                     |  51 ++++++-
>  util/reserved-region.c           |  94 ++++++++++++
>  hw/virtio/trace-events           |   1 +
>  tests/unit/meson.build           |   1 +
>  util/meson.build                 |   1 +
>  16 files changed, 655 insertions(+), 41 deletions(-)
>  create mode 100644 include/qemu/reserved-region.h
>  create mode 100644 tests/unit/test-resv-mem.c
>  create mode 100644 util/reserved-region.c
>
> --
> 2.41.0
>
>



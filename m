Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD4D7CF38F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 11:08:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtP0A-0006wo-AB; Thu, 19 Oct 2023 05:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1qtP08-0006wU-AV
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanghliu@redhat.com>)
 id 1qtP06-0000jw-Jh
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 05:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697706449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=otrf+KyCMw/Ydvi/gAU7O3+mROmgl3QS9I3TKAF2hCY=;
 b=XHxOb9bzn378emFvarY/3HEI6ARWWAkWpMSqKHYbSXmnn9Q2JiV36h8SdhnKontv/B1iau
 W5RADzGhiLCdky+k2w3kAIPhr6spx9TLDXVdEtj4bzjCICY9OaKbmVdINc0Bvt7zkpXnyL
 gUi3Yct4apaMmfY2cmd7DS5+DgO8ugg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-Ehkw11uwOPOL4Uj7uXjVVw-1; Thu, 19 Oct 2023 05:07:24 -0400
X-MC-Unique: Ehkw11uwOPOL4Uj7uXjVVw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6ff15946fso73405951fa.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 02:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697706443; x=1698311243;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=otrf+KyCMw/Ydvi/gAU7O3+mROmgl3QS9I3TKAF2hCY=;
 b=TU+lwRYdrHKceKh7sLEKHJ1AwmzTESQzjl12jxWMClGDOsQDLleLXRJdbI25QXhMOB
 pH9vrUKK+Uf4DY88EX/slbrjE6jY89sKFtPhYFzkxzk8zSzp6t4Ij5XY5iO9xziZoVta
 6YlqxLfNIvIhl8kX7hwagjI25xOVPRMSnpN5pLmoD1NKWvzbyLJycJajpZ+GctVfB3AL
 6QZTw6g2wQ4wUXbOJvYXC4oirFuDrhI4wbuAAjhY1Y46UQVkyIEKk534veTQhHoN0Sc6
 FT02WS+2HHzoCU+iMcgF8IZG1WnGdKuStShwq2oqnwz+qLyPWNbwAEGALVcirtYEi/AI
 POZw==
X-Gm-Message-State: AOJu0YyX5TnhW4pE/8gjzzvkhCfrGl5MDgiO0wmJJ5Fo3MJhJJdSqorI
 zTYoE0uHF5fcdWdGfYhFgM2MT1hvAZcM5JwRc88Y+xqBCv8jows0yWwbv4S7FSNfeCasdHovKgv
 AF8tl6VVg1UqffdnIfSaYdgEWcc4AEEY=
X-Received: by 2002:a05:651c:2109:b0:2c5:fde:e457 with SMTP id
 a9-20020a05651c210900b002c50fdee457mr1099803ljq.3.1697706443171; 
 Thu, 19 Oct 2023 02:07:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUOvnv1nyQr4Y6Wx+zk9m4LTIcPSDmB79o87mZulhgrBRwrLueTrz1AuqJgVOp8C/gg+ml8Cbhv5YfVCHpOQg=
X-Received: by 2002:a05:651c:2109:b0:2c5:fde:e457 with SMTP id
 a9-20020a05651c210900b002c50fdee457mr1099781ljq.3.1697706442781; Thu, 19 Oct
 2023 02:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231011175516.541374-1-eric.auger@redhat.com>
 <20231018093723-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231018093723-mutt-send-email-mst@kernel.org>
From: YangHang Liu <yanghliu@redhat.com>
Date: Thu, 19 Oct 2023 17:07:11 +0800
Message-ID: <CAGYh1E_RQOWkDP+rxfTV-AoVekw_SpuOxOVCZ0V7Gj+keZWXLw@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 jean-philippe@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org, 
 peterx@redhat.com, david@redhat.com, philmd@linaro.org, 
 zhenzhong.duan@intel.com, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=yanghliu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


On Wed, Oct 18, 2023 at 9:45=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Wed, Oct 11, 2023 at 07:52:16PM +0200, Eric Auger wrote:
> > This applies on top of vfio-next:
> > https://github.com/legoater/qemu/, vfio-next branch
>
> virtio things make sense
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
> let me know how you want to merge all this.
>
>
>
> > On x86, when assigning VFIO-PCI devices protected with virtio-iommu
> > we encounter the case where the guest tries to map IOVAs beyond 48b
> > whereas the physical VTD IOMMU only supports 48b. This ends up with
> > VFIO_MAP_DMA failures at qemu level because at kernel level,
> > vfio_iommu_iova_dma_valid() check returns false on vfio_map_do_map().
> >
> > This is due to the fact the virtio-iommu currently unconditionally
> > exposes an IOVA range of 64b through its config input range fields.
> >
> > This series removes this assumption by retrieving the usable IOVA
> > regions through the VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE UAPI when
> > a VFIO device is attached. This info is communicated to the
> > virtio-iommu memory region, transformed into the inversed info, ie.
> > the host reserved IOVA regions. Then those latter are combined with the
> > reserved IOVA regions set though the virtio-iommu reserved-regions
> > property. That way, the guest virtio-iommu driver, unchanged, is
> > able to probe the whole set of reserved regions and prevent any IOVA
> > belonging to those ranges from beeing used, achieving the original goal=
.
> >
> > Best Regards
> >
> > Eric
> >
> > This series can be found at:
> > https://github.com/eauger/qemu/tree/vfio-next-iommu_geometry-v3
> >
> > History:
> > v2 -> v3:
> > - rebase on top of vfio-next (including iommufd prereq)
> > - take into account IOVA range info capability may not be offered by
> >   old kernel and use nr_iovas =3D -1 to encode that [Alex]
> > - use GList * everywhere instead of arrays (in the range_inverse_array)
> >   with the benefice it sorts ranges retrieved from the kernel which are
> >   not garanteed to be sorted. Rework the tests accordingly [Alex]
> > - Make sure resv_regions GList is build before the probe() [Jean]
> >   per device list is first populated with prop resv regions on
> >   IOMMUDevice creation and then rebuilt on set_iova()
> > - Add a warning if set_iova builds a valid list after probe was
> >   called [Jean]
> > - Build host windows on top of IOVA valid ranges if this info can
> >   be retrieved from the kernel. As many windows are created as
> >   valid ranges
> > v1 -> v2:
> > - Remove "[PATCH 12/13] virtio-iommu: Resize memory region according
> >   to the max iova info" which causes way too much trouble: trigger
> >   a coredump in vhost, causes duplication of IOMMU notifiers causing
> >   EEXIST vfio_dma_map errors, ... This looks like a bad usage of the
> >   memory API so I prefer removing this from this series. So I was
> >   also obliged to remove the vfio_find_hostwin() check in the case
> >   of an IOMMU.
> > - Let range_inverse_array() take low/high args instead of hardcoding
> >   0, UINT64_MAX which both complexifies the algo and the tests.
> > - Move range function description in header.
> > - Check that if set_iova_ranges is called several times, new resv
> >   regions are included in previous ones
> >
> > Eric Auger (13):
> >   memory: Let ReservedRegion use Range
> >   memory: Introduce memory_region_iommu_set_iova_ranges
> >   vfio: Collect container iova range info
> >   virtio-iommu: Rename reserved_regions into prop_resv_regions
> >   range: Make range_compare() public
> >   util/reserved-region: Add new ReservedRegion helpers
> >   virtio-iommu: Introduce per IOMMUDevice reserved regions
> >   range: Introduce range_inverse_array()
> >   virtio-iommu: Record whether a probe request has been issued
> >   virtio-iommu: Implement set_iova_ranges() callback
> >   virtio-iommu: Consolidate host reserved regions and property set ones
> >   test: Add some tests for range and resv-mem helpers
> >   vfio: Remove 64-bit IOVA address space assumption
> >
> >  include/exec/memory.h            |  34 +++-
> >  include/hw/vfio/vfio-common.h    |   2 +
> >  include/hw/virtio/virtio-iommu.h |   7 +-
> >  include/qemu/range.h             |  14 ++
> >  include/qemu/reserved-region.h   |  32 ++++
> >  hw/core/qdev-properties-system.c |   9 +-
> >  hw/vfio/common.c                 |  23 ++-
> >  hw/vfio/container.c              |  67 ++++++-
> >  hw/virtio/virtio-iommu-pci.c     |   8 +-
> >  hw/virtio/virtio-iommu.c         | 155 +++++++++++++--
> >  system/memory.c                  |  13 ++
> >  tests/unit/test-resv-mem.c       | 318 +++++++++++++++++++++++++++++++
> >  util/range.c                     |  61 +++++-
> >  util/reserved-region.c           |  91 +++++++++
> >  hw/virtio/trace-events           |   1 +
> >  tests/unit/meson.build           |   1 +
> >  util/meson.build                 |   1 +
> >  17 files changed, 791 insertions(+), 46 deletions(-)
> >  create mode 100644 include/qemu/reserved-region.h
> >  create mode 100644 tests/unit/test-resv-mem.c
> >  create mode 100644 util/reserved-region.c
> >
> > --
> > 2.41.0
>
>



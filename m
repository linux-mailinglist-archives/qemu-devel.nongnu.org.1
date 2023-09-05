Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED927792CE2
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 19:57:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdaHa-0008Vo-47; Tue, 05 Sep 2023 13:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qdaHY-0008Vb-P6
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 13:56:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1qdaHU-0007qk-Pm
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 13:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693936563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IwO1Nf1MzjDI88RLD+/BrPu4iL3TSpccicgjR8SzUmw=;
 b=fhjyIbMBxICv8WuICzqtJq00xgXo4y2owiPYUobGpmMkzFBTXnbkAb4liNJz5ozD/iDBoH
 wPGWS7H22daoo8vEHbwl/WrYIwzHjhdqDRYjfxjA2BIzRLRO0E0P4B9egii3ea/iM0bi60
 flxl89nyg5tKs/Td5kWTePU0FSe920Y=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-ZKEFLYKWOW6IARlm8PwQMw-1; Tue, 05 Sep 2023 13:56:01 -0400
X-MC-Unique: ZKEFLYKWOW6IARlm8PwQMw-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-7954a4f80fbso212109839f.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 10:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693936561; x=1694541361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IwO1Nf1MzjDI88RLD+/BrPu4iL3TSpccicgjR8SzUmw=;
 b=C1KQYudsqlqClUXLF/h99w/P9oxJKsm4dNCEZlp1bdMNwE52Gd96uIOSXF+mZdf/Qc
 w1lGS7r4fL9mGrU7mBORy7/pCgqMxBKHQk6qjVp1A5d8YyzH1Mk2AfIDhI5yezAf6Nxm
 B8fWmKDLZH2502FM479L7gklEybENpriLCxk8bZpOQk+mwdyZo655U6HD+EB7gXEc1/3
 9HdZ4dVIdU86pzv501nKqoMMdzWAe9oddTC0ZAtNOaj7N/h8ZAYGSJfBwO8jpgY/ypuK
 cuLBtskIot1ptzWsjKtIoshmM0XxmRuRGch2MtV2JtnnEKCQrvc8vuUaMp8G9oALToSE
 WigQ==
X-Gm-Message-State: AOJu0Yw1QXrC/m7M7PWDdVPPnlgzWizfOwpkiTW5nl9yb/q9zMNfKAgj
 GhVDxNEt2EN1rzMNuQRss5I6xU8z+JdhYfqD4pZrOlaRbmby/fBxIIpFEwIXotuiCtY8ZRa9YhQ
 1/BLhH4zY8YYx0cs=
X-Received: by 2002:a92:cc4a:0:b0:343:c8b1:b7f0 with SMTP id
 t10-20020a92cc4a000000b00343c8b1b7f0mr14945780ilq.23.1693936561053; 
 Tue, 05 Sep 2023 10:56:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpl0FRFSnuhboBtLmrf2hYNYPwiYKoDY5GyzlkP3Qiwj7tFvISn52jFMDbRLntX51Xk2bL4Q==
X-Received: by 2002:a92:cc4a:0:b0:343:c8b1:b7f0 with SMTP id
 t10-20020a92cc4a000000b00343c8b1b7f0mr14945761ilq.23.1693936560819; 
 Tue, 05 Sep 2023 10:56:00 -0700 (PDT)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 j6-20020a02cb06000000b0042b69cca627sm4142121jap.137.2023.09.05.10.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 10:56:00 -0700 (PDT)
Date: Tue, 5 Sep 2023 11:55:58 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 clg@redhat.com, jean-philippe@linaro.org, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 david@redhat.com, philmd@linaro.org
Subject: Re: [PATCH 00/13] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
Message-ID: <20230905115558.590ea2e5.alex.williamson@redhat.com>
In-Reply-To: <20230904080451.424731-1-eric.auger@redhat.com>
References: <20230904080451.424731-1-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon,  4 Sep 2023 10:03:43 +0200
Eric Auger <eric.auger@redhat.com> wrote:

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

Hi Eric,

I don't quite follow this relative to device hotplug.  Are we
manipulating a per-device memory region which is created at device add
time?  Is that memory region actually shared in some cases, for instance
if we have a PCIe-to-PCI bridge aliasing devices on the conventional
side?  Thanks,

Alex

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



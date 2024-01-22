Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A853D835A12
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 05:31:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRlwr-0004dj-1x; Sun, 21 Jan 2024 23:30:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rRlwo-0004dL-IB
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 23:30:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rRlwl-0006vA-QH
 for qemu-devel@nongnu.org; Sun, 21 Jan 2024 23:30:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705897806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=erv3Y1u6efSHhwn6thl2npoYSOGu3Q2WmZgYTAMrQfM=;
 b=N6h9iPmSLZRVq+5hoAGfNpYn3UcNVw6uDcnSU78jjDyywOZv8c99cDxQnyhRmggoxEVZE7
 fb2g+gTzPAXyyA9LjWumI5XJ3LWbgCFT4niJkZf1Wn8n0FVpUMEJSppnH29cJb1BqYXJ2Z
 ZkVjWYNGIl3iFiCwmfwSRqokVpdG7XQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-taP4X3zsMxCDuSbuQbMV0g-1; Sun, 21 Jan 2024 23:30:04 -0500
X-MC-Unique: taP4X3zsMxCDuSbuQbMV0g-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2904cb3a99fso2191268a91.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jan 2024 20:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705897803; x=1706502603;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=erv3Y1u6efSHhwn6thl2npoYSOGu3Q2WmZgYTAMrQfM=;
 b=v9QsIGAYfUSA/gwjP9MoVZq3PLKACnCTIgDV5se1A8zwtipa4nwX9+YU2czrKP8BUo
 JmLHhmU8PDcKwm5+YJLKwGCasSGAg1SFtmYkq686BoOF3XXoXpM2+WQeIVpVzGEiG2Kl
 lO3vhsy6v2UXl1a2Wl6SvlKBvofP2rXZs8mzLh62Mq2bioIrzpL3vWbfeNTQ0fQKq0Gm
 1/6hNypfNn6UDENC8x2Z+aPvCUL1MVJSUU1pi6FuwhXadEpBDV5XcYTMgW2lAOs9vxDj
 mDJcHpaahDNKOXHNoriMWmsu1ZdjS8e2WBR1m3EVJLpMfjjnvzx2utB2EEdZWr3iiJVh
 eGUw==
X-Gm-Message-State: AOJu0YykNw4woiciySlV3yexVGw8KYl9+T/SebucFJouT8IzLHbD4pmj
 /YxUrl+20isnNwEsC1++AFMwKWGw0A/K9tHayhOU2bmcR6tdcKAyoTNaiifKEpQjLkZcR4afYIv
 i34lEZIMmUmrytqXI6dApDPkA/yQe5KWOYGvIap+otLUOx80GJc63ZPjenxLEZ9ifUpaX6dNVAP
 7nmsRXqiXvAvfj7QxLLQNaHwCcITQ=
X-Received: by 2002:a17:90b:1c86:b0:28d:22ce:6f21 with SMTP id
 oo6-20020a17090b1c8600b0028d22ce6f21mr5511448pjb.38.1705897803235; 
 Sun, 21 Jan 2024 20:30:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnEOi8najWV6VniUGanD1ztG4rbNitLE0e9DGb+YRF4i5ZJo/aqabzWfM7RCXgq5sWrRHGeYiya+P7aPzey+c=
X-Received: by 2002:a17:90b:1c86:b0:28d:22ce:6f21 with SMTP id
 oo6-20020a17090b1c8600b0028d22ce6f21mr5511423pjb.38.1705897802777; Sun, 21
 Jan 2024 20:30:02 -0800 (PST)
MIME-Version: 1.0
References: <20240115103735.132209-1-zhenzhong.duan@intel.com>
In-Reply-To: <20240115103735.132209-1-zhenzhong.duan@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 22 Jan 2024 12:29:51 +0800
Message-ID: <CACGkMEsqUUqHm7VBqHr0Qf7ia+1k0yFCSO-q13LvrxC=_kTBBg@mail.gmail.com>
Subject: Re: [PATCH rfcv1 00/23] intel_iommu: Enable stage-1 translation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: qemu-devel@nongnu.org, alex.williamson@redhat.com, clg@redhat.com, 
 eric.auger@redhat.com, peterx@redhat.com, mst@redhat.com, jgg@nvidia.com, 
 nicolinc@nvidia.com, joao.m.martins@oracle.com, kevin.tian@intel.com, 
 yi.l.liu@intel.com, yi.y.sun@intel.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.287,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jan 15, 2024 at 6:39=E2=80=AFPM Zhenzhong Duan <zhenzhong.duan@inte=
l.com> wrote:
>
> Hi,
>
> This series enables stage-1 translation support in intel iommu which
> we called "modern" mode. In this mode, we don't do shadowing of
> guest page table for passthrough device but pass stage-1 page table
> to host side to construct a nested domain; we also support emulated
> device by translating the stage-1 page table. There was some effort
> to enable this feature in old days, see [1] for details.
>
> The key design is to utilize the dual-stage IOMMU translation
> (also known as IOMMU nested translation) capability in host IOMMU.
> As the below diagram shows, guest I/O page table pointer in GPA
> (guest physical address) is passed to host and be used to perform
> the stage-1 address translation. Along with it, modifications to
> present mappings in the guest I/O page table should be followed
> with an IOTLB invalidation.
>
>         .-------------.  .---------------------------.
>         |   vIOMMU    |  | Guest I/O page table      |
>         |             |  '---------------------------'
>         .----------------/
>         | PASID Entry |--- PASID cache flush --+
>         '-------------'                        |
>         |             |                        V
>         |             |           I/O page table pointer in GPA
>         '-------------'
>     Guest
>     ------| Shadow |---------------------------|--------
>           v        v                           v
>     Host
>         .-------------.  .------------------------.
>         |   pIOMMU    |  |  FS for GIOVA->GPA     |
>         |             |  '------------------------'
>         .----------------/  |
>         | PASID Entry |     V (Nested xlate)
>         '----------------\.----------------------------------.
>         |             |   | SS for GPA->HPA, unmanaged domain|
>         |             |   '----------------------------------'
>         '-------------'
> Where:
>  - FS =3D First stage page tables
>  - SS =3D Second stage page tables
> <Intel VT-d Nested translation>
>
> There are some interactions between VFIO and vIOMMU.
> * vIOMMU registers PCIIOMMUOps to PCI subsystem which VFIO can
>   use to registers/unregisters IOMMUDevice object.
> * VFIO registers an IOMMUFDDevice object at vfio device realize
>   stage to vIOMMU, this is implemented as a prerequisite series[2].
> * vIOMMU calls IOMMUFDDevice interface callback IOMMUFDDeviceOps
>   to bind/unbind device to IOMMUFD backed domains, either nested
>   domain or not.
>
> See below diagram:
>
>         VFIO Device                                 Intel IOMMU
>     .-----------------.                         .-------------------.
>     |                 |                         |                   |
>     |       .---------|PCIIOMMUOps              |.-------------.    |
>     |       | IOMMUFD |(set_iommu_device)       || IOMMUFD     |    |
>     |       | Device  |------------------------>|| Device list |    |
>     |       .---------|(unset_iommu_device)     |.-------------.    |
>     |                 |                         |       |           |
>     |                 |                         |       V           |
>     |       .---------|         IOMMUFDDeviceOps|  .---------.      |
>     |       | IOMMUFD |            (attach_hwpt)|  | IOMMUFD |      |
>     |       | link    |<------------------------|  | Device  |      |
>     |       .---------|            (detach_hwpt)|  .---------.      |
>     |                 |                         |       |           |
>     |                 |                         |       ...         |
>     .-----------------.                         .-------------------.
>
> Based on Yi's suggestion, we updated a new design of managing ioas and
> hwpt, made it support multiple iommufd objects and the ERRATA_772415
> case, meanwhile tried to be optimal to share ioas and hwpt whenever
> possible.
>
> Stage-2 page table could be shared by different devices if there is
> no conflict and devices link to same iommufd object, i.e. devices
> under same host IOMMU can share same stage-2 page table. If there
> is conflict, i.e. there is one device under non cache coherency
> mode which is different from others, it requires a seperate
> stage-2 page table in non-CC mode.
>
> SPR platform has ERRATA_772415 which requires no readonly mappings
> in stage-2 page table. This series supports creating VTDIOASContainer
> with no readonly mappings. I'm not clear if there is a rare case that
> some IOMMUs on a multiple IOMMUs host have ERRATA_772415, this design
> can survive even in that case.
>
> See below example diagram for a full view:
>
>       IntelIOMMUState
>              |
>              V
>     .------------------.    .------------------.    .-------------------.
>     | VTDIOASContainer |--->| VTDIOASContainer |--->| VTDIOASContainer  |=
-->...
>     | (iommufd0,RW&RO) |    | (iommufd1,RW&RO) |    | (iommufd0,RW only)|
>     .------------------.    .------------------.    .-------------------.
>              |                       |                              |
>              |                       .-->...                        |
>              V                                                      V
>       .-------------------.    .-------------------.          .----------=
-----.
>       |   VTDS2Hwpt(CC)   |--->| VTDS2Hwpt(non-CC) |-->...    | VTDS2Hwpt=
(CC) |-->...
>       .-------------------.    .-------------------.          .----------=
-----.
>           |            |               |                            |
>           |            |               |                            |
>     .-----------.  .-----------.  .------------.              .----------=
--.
>     | IOMMUFD   |  | IOMMUFD   |  | IOMMUFD    |              | IOMMUFD  =
  |
>     | Device(CC)|  | Device(CC)|  | Device     |              | Device(CC=
) |
>     | (iommufd0)|  | (iommufd0)|  | (non-CC)   |              | (errata) =
  |
>     |           |  |           |  | (iommufd0) |              | (iommufd0=
) |
>     .-----------.  .-----------.  .------------.              .----------=
--.
>
> This series is also a prerequisite work for vSVA, i.e. Sharing
> guest application address space with passthrough devices.
>
> To enable "modern" mode, only need to add "x-scalable-mode=3Dmodern".
> i.e. -device intel-iommu,x-scalable-mode=3Dmodern,...
>
> Passthrough device should use iommufd backend to work in "modern" mode.
> i.e. -object iommufd,id=3Diommufd0 -device vfio-pci,iommufd=3Diommufd0,..=
.
>
> If host doens't support nested translation, qemu will fail
> with an unsupported report.
>
> Test done:
> - devices hotplug/unplug
> - different devices linked to different iommufds
>
> PATCH1-2:  Some preparing work to update header and IOMMUFD uAPI
> PATCH3-4:  Initialize vfio IOMMUFDDevice interface and pass to vIOMMU
> PATCH5:    Introduce a placeholder variable for scalable modern mode
> PATCH6:    Sync host cap/ecap with vIOMMU default cap/ecap in modern mode
> PATCH7-22: Implement first stage page table for passthrough and emulated =
device

Can we split the series and start from the emulated devices (and have
a qtest for that)? This might help for reviewing.

Thanks



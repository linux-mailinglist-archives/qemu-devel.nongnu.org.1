Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1302BAA0B4
	for <lists+qemu-devel@lfdr.de>; Mon, 29 Sep 2025 18:52:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H6J-0001kf-7P; Mon, 29 Sep 2025 12:51:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3H65-0001eW-4u; Mon, 29 Sep 2025 12:51:33 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1v3H5v-0002Qm-QM; Mon, 29 Sep 2025 12:51:31 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cb6ZP13mQz6M4nf;
 Tue, 30 Sep 2025 00:48:13 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id BB8001402F6;
 Tue, 30 Sep 2025 00:51:18 +0800 (CST)
Received: from localhost (10.47.79.72) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Sep
 2025 17:51:17 +0100
Date: Mon, 29 Sep 2025 17:51:14 +0100
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: Re: [PATCH v4 12/27] hw/arm/smmuv3-accel: Make use of
 get_msi_address_space() callback
Message-ID: <20250929175114.00003b03@huawei.com>
In-Reply-To: <20250929133643.38961-13-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
 <20250929133643.38961-13-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.79.72]
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 29 Sep 2025 14:36:28 +0100
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> Here we return the IOMMU address space if the device has S1 translation
> enabled by Guest. Otherwise return system address space.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Naming question inline.

> ---
>  hw/arm/smmuv3-accel.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 790887ac31..f4e01fba6d 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -387,6 +387,26 @@ static void smmuv3_accel_unset_iommu_device(PCIBus *bus, void *opaque,
>      }
>  }
>  
> +static AddressSpace *smmuv3_accel_find_msi_as(PCIBus *bus, void *opaque,

Why find rather than get for naming?

> +                                              int devfn)
> +{
> +    SMMUState *bs = opaque;
> +    SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
> +    SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, bus, devfn);
> +    SMMUDevice *sdev = &accel_dev->sdev;
> +
> +    /*
> +     * If the assigned vfio-pci dev has S1 translation enabled by
> +     * Guest, return IOMMU address space for MSI translation.
> +     * Otherwise, return system address space.
> +     */
> +    if (accel_dev->s1_hwpt) {
> +        return &sdev->as;
> +    } else {
> +        return &address_space_memory;
> +    }
> +}
> +
>  static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
>  {
>  
> @@ -475,6 +495,7 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>      .get_viommu_flags = smmuv3_accel_get_viommu_flags,
>      .set_iommu_device = smmuv3_accel_set_iommu_device,
>      .unset_iommu_device = smmuv3_accel_unset_iommu_device,
> +    .get_msi_address_space = smmuv3_accel_find_msi_as,
>  };
>  
>  void smmuv3_accel_init(SMMUv3State *s)



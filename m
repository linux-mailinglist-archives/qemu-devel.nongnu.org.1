Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B98ADAD3B
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Jun 2025 12:22:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR6xc-0004yI-JO; Mon, 16 Jun 2025 06:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uR6xO-0004vA-Rf; Mon, 16 Jun 2025 06:20:50 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uR6xL-00062i-Or; Mon, 16 Jun 2025 06:20:50 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bLQwj6yLWz6M53g;
 Mon, 16 Jun 2025 18:19:49 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id E89AF1402F7;
 Mon, 16 Jun 2025 18:20:21 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Jun
 2025 12:20:21 +0200
Date: Mon, 16 Jun 2025 11:20:19 +0100
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 <linuxarm@huawei.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <imammedo@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>
Subject: Re: [PATCH v4 1/7] hw/arm/smmu-common: Check SMMU has PCIe Root
 Complex association
Message-ID: <20250616112019.00003bce@huawei.com>
In-Reply-To: <20250613144449.60156-2-shameerali.kolothum.thodi@huawei.com>
References: <20250613144449.60156-1-shameerali.kolothum.thodi@huawei.com>
 <20250613144449.60156-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, 13 Jun 2025 15:44:43 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> Although this change does not affect functionality at present, it is

Patch title says PCIe.  This check is vs PCI host bridge.

No idea which one you wanted, but if it is PCIe needs to be
TYPC_PCIE_HOST_BRIDGE from pcie_host.h not the pci_host.h one
I think.

> required when we add support for user-creatable SMMUv3 devices in
> future patches.
> 
> Tested-by: Nathan Chen <nathanc@nvidia.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  hw/arm/smmu-common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index f39b99e526..7890aa12c1 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -20,6 +20,7 @@
>  #include "trace.h"
>  #include "exec/target_page.h"
>  #include "hw/core/cpu.h"
> +#include "hw/pci/pci_bridge.h"
>  #include "hw/qdev-properties.h"
>  #include "qapi/error.h"
>  #include "qemu/jhash.h"
> @@ -937,7 +938,8 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
>                                       g_free, g_free);
>      s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
>  
> -    if (s->primary_bus) {
> +    if (s->primary_bus && object_dynamic_cast(OBJECT(s->primary_bus)->parent,
> +                                              TYPE_PCI_HOST_BRIDGE)) {
>          pci_setup_iommu(s->primary_bus, &smmu_ops, s);
>      } else {
>          error_setg(errp, "SMMU is not attached to any PCI bus!");



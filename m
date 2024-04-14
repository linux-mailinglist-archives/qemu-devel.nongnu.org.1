Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAFA8A0ED9
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Apr 2024 12:18:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurVp-0001pp-Kj; Thu, 11 Apr 2024 06:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rurVh-0001Or-Dq
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:18:25 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rurVe-0007ka-41
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:18:24 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VFbBK0msbz6K8wH;
 Thu, 11 Apr 2024 18:13:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id BA4B81400E7;
 Thu, 11 Apr 2024 18:18:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 11 Apr
 2024 11:18:17 +0100
Date: Thu, 11 Apr 2024 11:18:16 +0100
To: Li Zhijian <lizhijian@fujitsu.com>
CC: Fan Ni <fan.ni@samsung.com>, <qemu-devel@nongnu.org>,
 <linux-cxl@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] hw/mem/cxl_type3: reset dvsecs in ct3d_reset()
Message-ID: <20240411111816.0000343c@Huawei.com>
In-Reply-To: <20240409075846.85370-1-lizhijian@fujitsu.com>
References: <20240409075846.85370-1-lizhijian@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue,  9 Apr 2024 15:58:46 +0800
Li Zhijian <lizhijian@fujitsu.com> wrote:

> After the kernel commit
> 0cab68720598 ("cxl/pci: Fix disabling memory if DVSEC CXL Range does not match a CFMWS window")
> CXL type3 devices cannot be enabled again after the reboot because the
> control register(see 8.1.3.2 in CXL specifiction 2.0 for more details) was
> not reset.
> 
> These registers could be changed by the firmware or OS, let them have
> their initial value in reboot so that the OS can read their clean status.
> 
> Fixes: e1706ea83da0 ("hw/cxl/device: Add a memory device (8.2.8.5)")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Hi,

We need to have a close look at what this is actually doing before
considering applying it.  I don't have time to get that this week, but
hopefully will find some time later this month.

I don't want a partial fix for one particular case that causes
us potential trouble in others.

Jonathan

> ---
> root_port, usp and dsp have the same issue, if this patch get approved,
> I will send another patch to fix them later.
> 
> V2:
>    Add fixes tag.
>    Reset all dvsecs registers instead of CTRL only
> ---
>  hw/mem/cxl_type3.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b0a7e9f11b64..4f09d0b8fedc 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -30,6 +30,7 @@
>  #include "hw/pci/msix.h"
>  
>  #define DWORD_BYTE 4
> +#define CT3D_CAP_SN_OFFSET PCI_CONFIG_SPACE_SIZE
>  
>  /* Default CDAT entries for a memory region */
>  enum {
> @@ -284,6 +285,10 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>               range2_size_hi = 0, range2_size_lo = 0,
>               range2_base_hi = 0, range2_base_lo = 0;
>  
> +    cxl_cstate->dvsec_offset = CT3D_CAP_SN_OFFSET;
> +    if (ct3d->sn != UI64_NULL) {
> +        cxl_cstate->dvsec_offset += PCI_EXT_CAP_DSN_SIZEOF;
> +    }
>      /*
>       * Volatile memory is mapped as (0x0)
>       * Persistent memory is mapped at (volatile->size)
> @@ -664,10 +669,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>  
>      pcie_endpoint_cap_init(pci_dev, 0x80);
>      if (ct3d->sn != UI64_NULL) {
> -        pcie_dev_ser_num_init(pci_dev, 0x100, ct3d->sn);
> -        cxl_cstate->dvsec_offset = 0x100 + 0x0c;
> -    } else {
> -        cxl_cstate->dvsec_offset = 0x100;
> +        pcie_dev_ser_num_init(pci_dev, CT3D_CAP_SN_OFFSET, ct3d->sn);
>      }
>  
>      ct3d->cxl_cstate.pdev = pci_dev;
> @@ -907,6 +909,7 @@ static void ct3d_reset(DeviceState *dev)
>  
>      cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
>      cxl_device_register_init_t3(ct3d);
> +    build_dvsecs(ct3d);
>  
>      /*
>       * Bring up an endpoint to target with MCTP over VDM.



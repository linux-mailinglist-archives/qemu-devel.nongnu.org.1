Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A26791BD4
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 19:02:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCy2-0005aA-1L; Mon, 04 Sep 2023 13:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qdCxy-0005Zy-BE
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 13:02:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qdCxu-0002KR-Mn
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 13:02:22 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfZZP32Rqz6J81N;
 Tue,  5 Sep 2023 00:57:49 +0800 (CST)
Received: from localhost (10.48.153.57) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 4 Sep
 2023 18:02:15 +0100
Date: Mon, 4 Sep 2023 18:02:14 +0100
To: Gregory Price <gourry.memverge@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <junhee.ryu@sk.com>, 
 <kwangjin.ko@sk.com>, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 4/5] cxl/type3: add an optional mhd validation function
 for memory accesses
Message-ID: <20230904180214.00007e32@Huawei.com>
In-Reply-To: <20230901012914.226527-5-gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
 <20230901012914.226527-5-gregory.price@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.153.57]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
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

On Thu, 31 Aug 2023 21:29:13 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> When memory accesses are made, some MHSLD's would validate the address
> is within the scope of allocated sections.  To do this, the base device
> must call an optional function set by inherited devices.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

This sort of callback addition can be done via class initialization.
E.g. get_lsa_size()
https://elixir.bootlin.com/qemu/latest/source/hw/mem/cxl_type3.c#L1494
as the callback is the same for all instances of the class which
in next patch is CXLNiagraClass where you already set the
PCIClass callbacks in cxl_niagara_class_init()

You can then use something like:
CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
cvc->mhd_access_valid(ct3d, dpa_offset, size);

Jonathan

> ---
>  hw/mem/cxl_type3.c          | 15 +++++++++++++++
>  include/hw/cxl/cxl_device.h |  3 +++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index a8d4a12f3e..8e1565f2fc 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1034,6 +1034,10 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
>              goto err_release_cdat;
>          }
>      }
> +
> +    /* Devices which inherit ct3d should initialize these after ct3_realize */
> +    ct3d->mhd_access_valid = NULL;
> +
>      return;
>  
>  err_release_cdat:
> @@ -1259,6 +1263,11 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
>          return MEMTX_ERROR;
>      }
>  
> +    if (ct3d->mhd_access_valid &&
> +        !ct3d->mhd_access_valid(d, dpa_offset, size)) {
> +        return MEMTX_ERROR;
> +    }
> +
>      if (sanitize_running(&ct3d->cci)) {
>          qemu_guest_getrandom_nofail(data, size);
>          return MEMTX_OK;
> @@ -1279,6 +1288,12 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>      if (res) {
>          return MEMTX_ERROR;
>      }
> +
> +    if (ct3d->mhd_access_valid &&
> +        !ct3d->mhd_access_valid(d, dpa_offset, size)) {
> +        return MEMTX_ERROR;
> +    }
> +
>      if (sanitize_running(&ct3d->cci)) {
>          return MEMTX_OK;
>      }
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 4ad38b689c..b1b39a9aa0 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -489,6 +489,9 @@ struct CXLType3Dev {
>          uint8_t num_regions; /* 0-8 regions */
>          CXLDCDRegion regions[DCD_MAX_REGION_NUM];
>      } dc;
> +
> +    /* Multi-headed Device */
> +    bool (*mhd_access_valid)(PCIDevice *d, uint64_t addr, unsigned int size);
>  };
>  
>  #define TYPE_CXL_TYPE3 "cxl-type3"



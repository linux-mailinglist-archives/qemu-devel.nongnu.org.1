Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D076770557
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 17:55:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRx96-00018y-2e; Fri, 04 Aug 2023 11:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qRx91-00016y-7z
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 11:55:16 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qRx8v-0003Or-7t
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 11:55:14 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHVZ15Ylkz67R01;
 Fri,  4 Aug 2023 23:51:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 16:55:03 +0100
Date: Fri, 4 Aug 2023 16:55:02 +0100
To: Fan Ni <fan.ni@samsung.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "gregory.price@memverge.com" <gregory.price@memverge.com>,
 "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
 "cbrowy@avery-design.com" <cbrowy@avery-design.com>, "ira.weiny@intel.com"
 <ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>, 
 Adam Manzanares <a.manzanares@samsung.com>, "dave@stgolabs.net"
 <dave@stgolabs.net>, "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>, 
 "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [Qemu PATCH v2 4/9] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Message-ID: <20230804165502.00000ed6@Huawei.com>
In-Reply-To: <20230725183939.2741025-5-fan.ni@samsung.com>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
 <CGME20230725183956uscas1p2008fba59779b70405c74d28a30e4fbaa@uscas1p2.samsung.com>
 <20230725183939.2741025-5-fan.ni@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
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

On Tue, 25 Jul 2023 18:39:55 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> From: Fan Ni <nifan@outlook.com>
> 
> With the change, when setting up memory for type3 memory device, we can
> create DC regions
> A property 'num-dc-regions' is added to ct3_props to allow users to pass the
> number of DC regions to create. To make it easier, other region parameters
> like region base, length, and block size are hard coded. If needed,
> these parameters can be added easily.

Longer term I think we need to have an interface based on one or more
memory backends.  Gets fiddly if we allow live configuration of the regions
but for static regions it should be easy and look like the vmem and pmem
already in place.

This is good for testing in the meantime.

> 
> With the change, we can create DC regions with proper kernel side
> support as below:
> 
> region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
> echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> 
> echo "dc0" >/sys/bus/cxl/devices/decoder2.0/mode
> echo 0x40000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
> 
> echo 0x40000000 > /sys/bus/cxl/devices/$region/size
> echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> echo 1 > /sys/bus/cxl/devices/$region/commit
> echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/mem/cxl_type3.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 3d7acffcb7..b29bb2309a 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -707,6 +707,34 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
>      }
>  }
>  
> +/*
> + * Create a dc region to test "Get Dynamic Capacity Configuration" command.
> + */
> +static int cxl_create_dc_regions(CXLType3Dev *ct3d)
> +{
> +    int i;
> +    uint64_t region_base = (ct3d->hostvmem ? ct3d->hostvmem->size : 0)
> +        + (ct3d->hostpmem ? ct3d->hostpmem->size : 0);

This is getting hard to read. Perhaps long hand version with if statements is easier?

	uint64_t region_base = 0;

	if (ct3d->hostvmem) {
		region_base += ct3d->hostvmem->size;
	}
etc.


> +    uint64_t region_len = (uint64_t)2 * 1024 * 1024 * 1024;

include/qemu/units.h GiB and MiB as appropraite.

> +    uint64_t decode_len = 4; /* 4*256MB */
> +    uint64_t blk_size = 2 * 1024 * 1024;
> +    struct CXLDCD_Region *region;
> +
> +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> +        region = &ct3d->dc.regions[i];
> +        region->base = region_base;
> +        region->decode_len = decode_len;
> +        region->len = region_len;
> +        region->block_size = blk_size;
> +        /* dsmad_handle is set when creating cdat table entries */
> +        region->flags = 0;
> +
> +        region_base += region->len;
> +    }
> +
> +    return 0;
> +}
> +
>  static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>  {
>      DeviceState *ds = DEVICE(ct3d);
> @@ -775,6 +803,10 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>          g_free(p_name);
>      }
>  
> +    if (cxl_create_dc_regions(ct3d)) {
> +        return false;
> +    }
> +
>      return true;
>  }
>  
> @@ -1068,6 +1100,7 @@ static Property ct3_props[] = {
>      DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
>      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
>      DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
> +    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  



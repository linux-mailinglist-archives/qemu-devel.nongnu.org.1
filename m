Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 470617CF5CC
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:51:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQc8-0001zY-Vx; Thu, 19 Oct 2023 06:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qtQc5-0001uc-U5
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:50:49 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qtQc3-0000b8-Dz
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:50:49 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SB4FF68Bdz67Cx4;
 Thu, 19 Oct 2023 18:48:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 19 Oct
 2023 11:50:43 +0100
Date: Thu, 19 Oct 2023 11:50:39 +0100
To: Li Zhijian <lizhijian@fujitsu.com>
CC: <fan.ni@samsung.com>, <qemu-devel@nongnu.org>, <philmd@linaro.org>,
 <mst@redhat.com>
Subject: Re: [PATCH v2 1/2] hw/cxl: Pass CXLComponentState to cache_mem_ops
Message-ID: <20231019115039.0000743c@Huawei.com>
In-Reply-To: <20231018082408.888098-1-lizhijian@fujitsu.com>
References: <20231018082408.888098-1-lizhijian@fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Wed, 18 Oct 2023 16:24:07 +0800
Li Zhijian <lizhijian@fujitsu.com> wrote:

> cache_mem_ops.{read,write}() interprets opaque as
> CXLComponentState(cxl_cstate) instead of ComponentRegisters(cregs).
> 
> Fortunately, cregs is the first member of cxl_cstate, so their values are
> the same.
> 
> Fixes: 9e58f52d3f8 ("hw/cxl/component: Introduce CXL components (8.1.x, 8.2.5)")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Both these lgtm.  I'll carry them on my CXL tree and add them to the next
series I send out for general cleaup etc, but if you send them again
cc Michael Tsirkin so he has the option to pick them up directly if he wishes
(all CXL changes got through Michael currently).

> ---
> V2: change the source side since cache_mem_ops.{read,write}() will use
> cxl_cstate.
> ---
>  hw/cxl/cxl-component-utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index f3bbf0fd131..6214dcdcc12 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -179,7 +179,7 @@ void cxl_component_register_block_init(Object *obj,
>      /* io registers controls link which we don't care about in QEMU */
>      memory_region_init_io(&cregs->io, obj, NULL, cregs, ".io",
>                            CXL2_COMPONENT_IO_REGION_SIZE);
> -    memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cregs,
> +    memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cxl_cstate,
>                            ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);
>  
>      memory_region_add_subregion(&cregs->component_registers, 0, &cregs->io);



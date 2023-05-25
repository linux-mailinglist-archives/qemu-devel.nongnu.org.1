Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20475710B4D
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:43:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q29MQ-0003Mq-EK; Thu, 25 May 2023 07:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q29MF-0003Me-Eb
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:42:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q29M9-0003uf-RY
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:42:15 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QRmMW5PNqz67cHj;
 Thu, 25 May 2023 19:40:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 25 May
 2023 12:42:04 +0100
Date: Thu, 25 May 2023 12:42:03 +0100
To: Li Zhijian <lizhijian@cn.fujitsu.com>
CC: <qemu-devel@nongnu.org>, <ben.widawsky@intel.com>,
 <dan.j.williams@intel.com>, <mst@redhat.com>, <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] docs/cxl: Correct CFMW number
Message-ID: <20230525124203.00000c50@Huawei.com>
In-Reply-To: <20230519085802.2106900-1-lizhijian@cn.fujitsu.com>
References: <20230519085802.2106900-1-lizhijian@cn.fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 19 May 2023 16:58:01 +0800
Li Zhijian <lizhijian@cn.fujitsu.com> wrote:

> The 'Notes:' in this document mentioned CFMW{0-2}, but the figure missed
> CFMW2.
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>

> ---
> I'm totally new to CXL, so i have little confidence to this change :)
I believe this one is already fixed upstream by Brice Goglin
https://gitlab.com/qemu-project/qemu/-/commit/ca4750583a597e97cbf8cec008d228f95d22c4

Otherwise was good!

Thanks,

Jonathan

> ---
>  docs/system/devices/cxl.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index dce43476129..d3577a4d6da 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -162,7 +162,7 @@ Example system Topology. x marks the match in each decoder level::
>    |<------------------SYSTEM PHYSICAL ADDRESS MAP (1)----------------->|
>    |    __________   __________________________________   __________    |
>    |   |          | |                                  | |          |   |
> -  |   | CFMW 0   | |  CXL Fixed Memory Window 1       | | CFMW 1   |   |
> +  |   | CFMW 0   | |  CXL Fixed Memory Window 1       | | CFMW 2   |   |
>    |   | HB0 only | |  Configured to interleave memory | | HB1 only |   |
>    |   |          | |  memory accesses across HB0/HB1  | |          |   |
>    |   |__________| |_____x____________________________| |__________|   |
> @@ -247,7 +247,7 @@ Example topology involving a switch::
>    |<------------------SYSTEM PHYSICAL ADDRESS MAP (1)----------------->|
>    |    __________   __________________________________   __________    |
>    |   |          | |                                  | |          |   |
> -  |   | CFMW 0   | |  CXL Fixed Memory Window 1       | | CFMW 1   |   |
> +  |   | CFMW 0   | |  CXL Fixed Memory Window 1       | | CFMW 2   |   |
>    |   | HB0 only | |  Configured to interleave memory | | HB1 only |   |
>    |   |          | |  memory accesses across HB0/HB1  | |          |   |
>    |   |____x_____| |__________________________________| |__________|   |



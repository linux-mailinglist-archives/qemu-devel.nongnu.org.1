Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D36BD710B6F
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 13:50:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q29TQ-00077B-4F; Thu, 25 May 2023 07:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q29TN-000770-DV
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:49:37 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q29TL-00052M-SC
 for qemu-devel@nongnu.org; Thu, 25 May 2023 07:49:37 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QRmSP64d1z6J7J9;
 Thu, 25 May 2023 19:44:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 25 May
 2023 12:49:31 +0100
Date: Thu, 25 May 2023 12:49:30 +0100
To: Li Zhijian <lizhijian@cn.fujitsu.com>
CC: <qemu-devel@nongnu.org>, <ben.widawsky@intel.com>,
 <dan.j.williams@intel.com>, <mst@redhat.com>, <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs/clx: Change to lowercase as others
Message-ID: <20230525124930.00004ed6@Huawei.com>
In-Reply-To: <20230519085802.2106900-2-lizhijian@cn.fujitsu.com>
References: <20230519085802.2106900-1-lizhijian@cn.fujitsu.com>
 <20230519085802.2106900-2-lizhijian@cn.fujitsu.com>
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

On Fri, 19 May 2023 16:58:02 +0800
Li Zhijian <lizhijian@cn.fujitsu.com> wrote:

> Using the same style except the 'Topo' abbreviation.
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
> I'm not a native speaker, feel free to correct me.

I've edited slightly and applied to my local staging tree for cxl patches.
Includes fixing docs/clx -> docs/cxl in the patch title.

Thanks, I'll queue this up with the next series of refactoring patches etc,

Jonathan


> ---
>  docs/system/devices/cxl.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index d3577a4d6da..56414d25871 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -157,7 +157,7 @@ responsible for allocating appropriate ranges from within the CFMWs
>  and exposing those via normal memory configurations as would be done
>  for system RAM.
>  
> -Example system Topology. x marks the match in each decoder level::
> +Example system topology. x marks the match in each decoder level::
>  
>    |<------------------SYSTEM PHYSICAL ADDRESS MAP (1)----------------->|
>    |    __________   __________________________________   __________    |
> @@ -187,8 +187,8 @@ Example system Topology. x marks the match in each decoder level::
>         ___________|___   __________|__   __|_________   ___|_________
>     (3)|  Root Port 0  | | Root Port 1 | | Root Port 2| | Root Port 3 |
>        |  Appears in   | | Appears in  | | Appears in | | Appear in   |
> -      |  PCI topology | | PCI Topology| | PCI Topo   | | PCI Topo    |
> -      |  As 0c:00.0   | | as 0c:01.0  | | as de:00.0 | | as de:01.0  |
> +      |  PCI topology | | PCI topology| | PCI Topo   | | PCI Topo    |

I've switched to topo for the abbreviation as well.  No particular reason
it should have a capital letter.

> +      |  as 0c:00.0   | | as 0c:01.0  | | as de:00.0 | | as de:01.0  |
>        |_______________| |_____________| |____________| |_____________|
>              |                  |               |              |
>              |                  |               |              |
> @@ -272,7 +272,7 @@ Example topology involving a switch::
>        |  Root Port 0  |
>        |  Appears in   |
>        |  PCI topology |
> -      |  As 0c:00.0   |
> +      |  as 0c:00.0   |
>        |___________x___|
>                    |
>                    |



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A3E7166C6
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 17:15:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q413N-0006bs-HS; Tue, 30 May 2023 11:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q413L-0006Z5-9N
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:14:27 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1q413I-00068J-W1
 for qemu-devel@nongnu.org; Tue, 30 May 2023 11:14:26 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QVwqL3BhWz6DB95;
 Tue, 30 May 2023 23:12:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 30 May
 2023 16:14:21 +0100
Date: Tue, 30 May 2023 16:14:20 +0100
To: Li Zhijian <lizhijian@cn.fujitsu.com>
CC: <fan.ni@samsung.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH] hw/clx: Fix CFMW config memory leak
Message-ID: <20230530161420.00000784@Huawei.com>
In-Reply-To: <20230529075956.2235870-1-lizhijian@cn.fujitsu.com>
References: <20230529075956.2235870-1-lizhijian@cn.fujitsu.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Mon, 29 May 2023 15:59:56 +0800
Li Zhijian <lizhijian@cn.fujitsu.com> wrote:

> Only 'fw' pointer is marked as g_autofree, so we shoud free other
> resource manually in error path.
> 
Good spot.

Patch title typo
hw/cxl: 

It's a bit annoying we can't handle this with more autofree magic.
That would work for fw->targets but not for the string duplicates.

One other comment inline,

Thanks,

Jonathan


> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  hw/cxl/cxl-host.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 034c7805b3e..dd1a7c83f71 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -48,7 +48,7 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
>      if (object->size % (256 * MiB)) {
>          error_setg(errp,
>                     "Size of a CXL fixed memory window must be a multiple of 256MiB");
> -        return;
> +        goto err_free;


>      }
>      fw->size = object->size;
>  
> @@ -57,7 +57,7 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
>              cxl_interleave_granularity_enc(object->interleave_granularity,
>                                             errp);
>          if (*errp) {
> -            return;
> +            goto err_free;
>          }
>      } else {
>          /* Default to 256 byte interleave */
> @@ -68,6 +68,12 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
>                                               g_steal_pointer(&fw));
>  
>      return;
> +
> +err_free:
> +    for (i = 0; i < fw->num_targets && fw->targets[i]; i++) {

No need to check fw->targets[i]

> +        g_free(fw->targets[i]);
> +    }
> +    g_free(fw->targets);
>  }
>  
>  void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)



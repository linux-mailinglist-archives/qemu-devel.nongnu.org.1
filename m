Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E5079EF9B
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 18:58:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgTC2-00024l-CB; Wed, 13 Sep 2023 12:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qgTBz-00024Z-MX
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 12:58:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qgTBx-0004iv-Hw
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 12:58:19 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rm63L5jDgz6D94k;
 Thu, 14 Sep 2023 00:53:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 13 Sep
 2023 17:58:14 +0100
Date: Wed, 13 Sep 2023 17:58:13 +0100
To: Dmitry Frolov <frolov@swemel.ru>
CC: <fan.ni@samsung.com>, <qemu-devel@nongnu.org>, <sdl.qemu@linuxtesting.org>
Subject: Re: [PATCH v2] hw/cxl: Fix out of bound array access
Message-ID: <20230913175813.00005d11@Huawei.com>
In-Reply-To: <20230913132227.823336-1-frolov@swemel.ru>
References: <057bee7c-92e0-1cf2-bcdd-ef7eeb223db4@linaro.org>
 <20230913132227.823336-1-frolov@swemel.ru>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Wed, 13 Sep 2023 16:22:28 +0300
Dmitry Frolov <frolov@swemel.ru> wrote:

> According to cxl_interleave_ways_enc(),
> fw->num_targets is allowed to be up to 16.
> This also corresponds to CXL specs.
> So, the fw->target_hbs[] array is iterated from 0 to 15.
> But it is staticaly declared of length 8.
> Thus, out of bound array access may occur.
> 
> Fixes: c28db9e000 ("hw/pci-bridge: Make PCIe and CXL PXB Devices inherit from TYPE_PXB_DEV")
> 
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>
> ---
> v2: assert added
> ---
>  hw/cxl/cxl-host.c    | 1 +
>  include/hw/cxl/cxl.h | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index 034c7805b3..fe9143409b 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -33,6 +33,7 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
>      for (target = object->targets; target; target = target->next) {
>          fw->num_targets++;
>      }
> +    assert(fw->num_targets <= ARRAY_SIZE(fw->target_hbs));

Just incase it gets lost as I replied late to the v1 comment.

This is both unnecessary and results in an
assert for a case that would otherwise be a nice error message about unsupported
number of interleave ways.

Jonathan

>  
>      fw->enc_int_ways = cxl_interleave_ways_enc(fw->num_targets, errp);
>      if (*errp) {
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 56c9e7676e..4944725849 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -29,7 +29,7 @@ typedef struct PXBCXLDev PXBCXLDev;
>  typedef struct CXLFixedWindow {
>      uint64_t size;
>      char **targets;
> -    PXBCXLDev *target_hbs[8];
> +    PXBCXLDev *target_hbs[16];
>      uint8_t num_targets;
>      uint8_t enc_int_ways;
>      uint8_t enc_int_gran;



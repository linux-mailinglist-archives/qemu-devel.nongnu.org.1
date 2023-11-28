Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECCF7FB9D8
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 13:03:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7wmF-0002pJ-7n; Tue, 28 Nov 2023 07:01:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1r7wm5-0002oz-Lw
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 07:01:13 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1r7wm1-0004Jd-1r
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 07:01:09 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SfgsG1gXrz6J6tW;
 Tue, 28 Nov 2023 19:56:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 0EA5E14025A;
 Tue, 28 Nov 2023 20:00:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 Nov
 2023 12:00:44 +0000
Date: Tue, 28 Nov 2023 12:00:43 +0000
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <mst@redhat.com>, <qemu-devel@nongnu.org>, <peter.maydell@linaro.org>,
 <fan.ni@samsung.com>
Subject: Re: [PATCH] hw/cxl/mbox: Remove dead code
Message-ID: <20231128120043.00006a08@Huawei.com>
In-Reply-To: <20231110232640.11327-1-dave@stgolabs.net>
References: <20231110232640.11327-1-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
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

On Fri, 10 Nov 2023 15:26:40 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Two functions were reported to have dead code, remove the bogus
> branches altogether, as well as a misplaced qemu_log call.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
LGTM.

Michael, if you want to pick this up directly that would be great.
If not I'll roll it into next series of fixes I send you.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c | 43 +++++++++++++-------------------------
>  1 file changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index b36557509710..39642ed93ee6 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1001,15 +1001,8 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>  
>      cxl_dev_disable_media(&ct3d->cxl_dstate);
>  
> -    if (secs > 2) {
> -        /* sanitize when done */
> -        return CXL_MBOX_BG_STARTED;
> -    } else {
> -        __do_sanitization(ct3d);
> -        cxl_dev_enable_media(&ct3d->cxl_dstate);
> -
> -        return CXL_MBOX_SUCCESS;
> -    }
> +    /* sanitize when done */
> +    return CXL_MBOX_BG_STARTED;
>  }
>  
>  static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
> @@ -1387,27 +1380,21 @@ static void bg_timercb(void *opaque)
>  
>          cci->bg.complete_pct = 100;
>          cci->bg.ret_code = ret;
> -        if (ret == CXL_MBOX_SUCCESS) {
> -            switch (cci->bg.opcode) {
> -            case 0x4400: /* sanitize */
> -            {
> -                CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> -
> -                __do_sanitization(ct3d);
> -                cxl_dev_enable_media(&ct3d->cxl_dstate);
> -            }
> +        switch (cci->bg.opcode) {
> +        case 0x4400: /* sanitize */
> +        {
> +            CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +
> +            __do_sanitization(ct3d);
> +            cxl_dev_enable_media(&ct3d->cxl_dstate);
> +        }
> +        break;
> +        case 0x4304: /* TODO: scan media */
> +            break;
> +        default:
> +            __builtin_unreachable();
>              break;
> -            case 0x4304: /* TODO: scan media */
> -                break;
> -            default:
> -                __builtin_unreachable();
> -                break;
> -            }
>          }
> -
> -        qemu_log("Background command %04xh finished: %s\n",
> -                 cci->bg.opcode,
> -                 ret == CXL_MBOX_SUCCESS ? "success" : "aborted");
>      } else {
>          /* estimate only */
>          cci->bg.complete_pct = 100 * now / total_time;



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC737916D8
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:06:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8Iq-0005tz-Ib; Mon, 04 Sep 2023 08:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tugy@chinatelecom.cn>)
 id 1qd8Ia-0005g4-F9
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:03:23 -0400
Received: from smtpnm6-05.21cn.com ([182.42.157.213] helo=chinatelecom.cn)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tugy@chinatelecom.cn>) id 1qd8IV-00038K-VZ
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:03:19 -0400
HMM_SOURCE_IP: 192.168.138.117:33506.6782894
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-36.111.64.85 (unknown [192.168.138.117])
 by chinatelecom.cn (HERMES) with SMTP id EF8968E7B6;
 Mon,  4 Sep 2023 19:55:12 +0800 (CST)
X-189-SAVE-TO-SEND: +tugy@chinatelecom.cn
Received: from  ([36.111.64.85])
 by gateway-ssl-dep-cd7448649-pndrv with ESMTP id
 0dc209813be04f1c8e9fa1cb699e6ec6 for quintela@redhat.com; 
 Mon, 04 Sep 2023 19:55:14 CST
X-Transaction-ID: 0dc209813be04f1c8e9fa1cb699e6ec6
X-Real-From: tugy@chinatelecom.cn
X-Receive-IP: 36.111.64.85
X-MEDUSA-Status: 0
Message-ID: <cbaab79d-ccd7-48df-bb9e-a7c9e29aeb2f@chinatelecom.cn>
Date: Mon, 4 Sep 2023 19:55:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: tugy@chinatelecom.cn, qemu-devel@nongnu.org
Subject: Re: [PATCH] migrate/ram: let ram_save_target_page_legacy() return if
 qemu file got error
Content-Language: en-US
To: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <20ae48e5-006d-4a1b-823e-f2c591ec4fb0@chinatelecom.cn>
From: Guoyi Tu <tugy@chinatelecom.cn>
In-Reply-To: <20ae48e5-006d-4a1b-823e-f2c591ec4fb0@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=182.42.157.213; envelope-from=tugy@chinatelecom.cn;
 helo=chinatelecom.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Juan, what do you think of this patch? Can it be merged into
the upstream?

On 2023/8/15 15:21, Guoyi Tu wrote:
> When the migration process of a virtual machine using huge pages is 
> cancelled,
> QEMU will continue to complete the processing of the current huge page
> through the qemu file object got an error set. These processing, such as
> compression and encryption, will consume a lot of CPU resources which may
> affact the the performance of the other VMs.
> 
> To terminate the migration process more quickly and minimize unnecessary
> resource occupancy, it's neccessary to add logic to check the error status
> of qemu file object in the beginning of ram_save_target_page_legacy 
> function,
> and make sure the function returns immediately if qemu file got an error.
> 
> Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
> ---
>   migration/ram.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 9040d66e61..3e2ebf3004 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2133,6 +2133,10 @@ static int ram_save_target_page_legacy(RAMState 
> *rs, PageSearchStatus *pss)
>       ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>       int res;
> 
> +    if (qemu_file_get_error(pss->pss_channel)) {
> +        return -1;
> +    }
> +
>       if (control_save_page(pss, block, offset, &res)) {
>           return res;
>       }


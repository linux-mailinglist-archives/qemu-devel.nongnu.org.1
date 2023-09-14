Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 298617A0493
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:56:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgls7-0001id-8H; Thu, 14 Sep 2023 08:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qgls3-0001iU-Tf
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:54:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qgls1-0003iq-Qg
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:54:59 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B851C21E55;
 Thu, 14 Sep 2023 15:55:02 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id BD0D828186;
 Thu, 14 Sep 2023 15:54:54 +0300 (MSK)
Message-ID: <d1eac212-91c4-a78d-abbd-15d24a732680@tls.msk.ru>
Date: Thu, 14 Sep 2023 15:54:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/4] hw/cxl: Use available size parameter to index into
 register arrays.
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, qemu-devel@nongnu.org,
 Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: linuxarm@huawei.com
References: <20230913150521.30035-1-Jonathan.Cameron@huawei.com>
 <20230913150521.30035-3-Jonathan.Cameron@huawei.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230913150521.30035-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
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

13.09.2023 18:05, Jonathan Cameron via wrote:
> Indexing has to be done into an array with the right size elements.
> As such, the size parameter always matches the array element size
> and can be used in place of the longer sizeof(*array)
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/cxl/cxl-component-utils.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index f3bbf0fd13..089e10b232 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -76,7 +76,7 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
>       if (cregs->special_ops && cregs->special_ops->read) {
>           return cregs->special_ops->read(cxl_cstate, offset, size);
>       } else {
> -        return cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
> +        return cregs->cache_mem_registers[offset / size];

This is a though one, and smells wrong.

Though because it is not at all obvious where this "size" value comes from,
have to find usage(s) of this function (cache_mem_ops) and think twice about
the other parameters in there.  Also having in mind the previous comparison
with 8.  In this part of the code, size should always be =4, but it takes
hard time to figure this out.

Wrong - no, because of the above - the only 2 possible values are 4 and 8,
but it's difficult to see what's going on, and you're making it worse.

Original code was at least clear you're getting a single register from
an array of registers, with new code it is not clear at all.

What I'd probably use here is to add comment that size can be either 4 or 8,
and use a switch similar to what you've used in first patch in this series.
And have a static_assert(sizeof(register) == 4) or something like that
here in this second branch.

So it is something like:

static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
                                        unsigned size)
{
     CXLComponentState *cxl_cstate = opaque;
     ComponentRegisters *cregs = &cxl_cstate->crb;

     switch (size) {
     case 8:
         qemu_log_mask(LOG_UNIMP,
                       "CXL 8 byte cache mem registers not implemented\n");
         return 0;

     case 4:
         if (cregs->special_ops && cregs->special_ops->read) {
             return cregs->special_ops->read(cxl_cstate, offset, 4);
         } else {
             return cregs->cache_mem_registers[offset /
                                               sizeof(*cregs->cache_mem_registers)];
         }

     default:
         /* this routine is called with size being either 4 or 8 only */
         g_assert_not_reached();
     }
}

Note: I especially left the sizeof() here, instead of using a previously
suggested static_assert() - because a register can be implemented using
larger integers on the host, it does not need to be 4 bytes, - but only
low 4 bytes can actually be used.

This does not shorten the line (it does by wrapping it up), but it keep
code correct and more understandable.  Adding size parameter there makes
it much more cryptic.

Here and in other places.

This is just an example, not a suggestion.

/mjt


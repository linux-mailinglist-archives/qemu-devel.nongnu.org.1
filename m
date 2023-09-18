Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BE97A49A1
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 14:30:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiDNk-0007SW-3u; Mon, 18 Sep 2023 08:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiDNg-0007Qa-Aa
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:29:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qiDNc-0006R2-0a
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 08:29:35 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rq3xM18sLz6K6WS;
 Mon, 18 Sep 2023 20:28:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 18 Sep
 2023 13:29:27 +0100
Date: Mon, 18 Sep 2023 13:29:26 +0100
To: Michael Tokarev <mjt@tls.msk.ru>
CC: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH 2/4] hw/cxl: Use available size parameter to index into
 register arrays.
Message-ID: <20230918132926.00005c97@Huawei.com>
In-Reply-To: <d1eac212-91c4-a78d-abbd-15d24a732680@tls.msk.ru>
References: <20230913150521.30035-1-Jonathan.Cameron@huawei.com>
 <20230913150521.30035-3-Jonathan.Cameron@huawei.com>
 <d1eac212-91c4-a78d-abbd-15d24a732680@tls.msk.ru>
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

On Thu, 14 Sep 2023 15:54:54 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 13.09.2023 18:05, Jonathan Cameron via wrote:
> > Indexing has to be done into an array with the right size elements.
> > As such, the size parameter always matches the array element size
> > and can be used in place of the longer sizeof(*array)
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   hw/cxl/cxl-component-utils.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > index f3bbf0fd13..089e10b232 100644
> > --- a/hw/cxl/cxl-component-utils.c
> > +++ b/hw/cxl/cxl-component-utils.c
> > @@ -76,7 +76,7 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
> >       if (cregs->special_ops && cregs->special_ops->read) {
> >           return cregs->special_ops->read(cxl_cstate, offset, size);
> >       } else {
> > -        return cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
> > +        return cregs->cache_mem_registers[offset / size];  
> 
> This is a though one, and smells wrong.
> 
> Though because it is not at all obvious where this "size" value comes from,
> have to find usage(s) of this function (cache_mem_ops) and think twice about
> the other parameters in there.  Also having in mind the previous comparison
> with 8.  In this part of the code, size should always be =4, but it takes
> hard time to figure this out.
> 
> Wrong - no, because of the above - the only 2 possible values are 4 and 8,
> but it's difficult to see what's going on, and you're making it worse.
> 
> Original code was at least clear you're getting a single register from
> an array of registers, with new code it is not clear at all.

Fair point.

> 
> What I'd probably use here is to add comment that size can be either 4 or 8,
> and use a switch similar to what you've used in first patch in this series.
> And have a static_assert(sizeof(register) == 4) or something like that
> here in this second branch.

Good idea.
> 
> So it is something like:
> 
> static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
>                                         unsigned size)
> {
>      CXLComponentState *cxl_cstate = opaque;
>      ComponentRegisters *cregs = &cxl_cstate->crb;
> 
>      switch (size) {
>      case 8:
>          qemu_log_mask(LOG_UNIMP,
>                        "CXL 8 byte cache mem registers not implemented\n");
>          return 0;
> 
>      case 4:
>          if (cregs->special_ops && cregs->special_ops->read) {
>              return cregs->special_ops->read(cxl_cstate, offset, 4);
>          } else {
>              return cregs->cache_mem_registers[offset /
>                                                sizeof(*cregs->cache_mem_registers)];
>          }
> 
>      default:
>          /* this routine is called with size being either 4 or 8 only */
>          g_assert_not_reached();
>      }
> }
> 
> Note: I especially left the sizeof() here, instead of using a previously
> suggested static_assert() - because a register can be implemented using
> larger integers on the host, it does not need to be 4 bytes, - but only
> low 4 bytes can actually be used.

I don't follow.  Here cache_mem_registers is an array of uint32_t so
it is going to be 4 bytes on any host!  Obviously that's not true for
registers in general.

So I've added the assert as it is always valid and made it a  / 4

Note I ended up with just using size in the first place because I was
planning to add a local variable that was always the same size and that was silly.

> 
> This does not shorten the line (it does by wrapping it up), but it keep
> code correct and more understandable.  Adding size parameter there makes
> it much more cryptic.
> 
> Here and in other places.
> 
> This is just an example, not a suggestion.

It makes sense.  Sorry - thought I'd sent this last week!


Jonathan

> 
> /mjt
> 



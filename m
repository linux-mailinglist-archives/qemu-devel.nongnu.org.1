Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 528E37CE2CA
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:32:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9Sf-0007Eh-KE; Wed, 18 Oct 2023 12:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qt9SY-0007DB-Eh
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:31:50 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qt9SU-0006Wr-VU
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:31:49 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S9br46fjzz6J9ZY;
 Thu, 19 Oct 2023 00:28:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 18 Oct
 2023 17:31:43 +0100
Date: Wed, 18 Oct 2023 17:31:42 +0100
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tokarev
 <mjt@tls.msk.ru>, <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 2/4] hw/cxl: Use switch statements for read and write
 of cachemem registers
Message-ID: <20231018173142.00003739@Huawei.com>
In-Reply-To: <20231018172239.00005f3d@Huawei.com>
References: <20231012140514.3697-1-Jonathan.Cameron@huawei.com>
 <20231012140514.3697-3-Jonathan.Cameron@huawei.com>
 <20231018103907-mutt-send-email-mst@kernel.org>
 <20231018172239.00005f3d@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Wed, 18 Oct 2023 17:22:39 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Wed, 18 Oct 2023 10:40:45 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Oct 12, 2023 at 03:05:12PM +0100, Jonathan Cameron wrote:  
> > > Establishing that only register accesses of size 4 and 8 can occur
> > > using these functions requires looking at their callers. Make it
> > > easier to see that by using switch statements.
> > > Assertions are used to enforce that the register storage is of the
> > > matching size, allowing fixed values to be used for divisors of
> > > the array indices.
> > > 
> > > Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Fan Ni <fan.ni@samsung.com>    
> > 
> > Fails with clang:
> > 
> > ../hw/cxl/cxl-component-utils.c:130:9: error: expected expression
> >         QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_regs_write_mask) != 4);
> >         ^
> > ../include/qemu/compiler.h:76:30: note: expanded from macro 'QEMU_BUILD_BUG_ON'
> > #define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
> >                              ^
> > ../include/qemu/compiler.h:74:36: note: expanded from macro 'QEMU_BUILD_BUG_MSG'
> > #define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
> >                                    ^
> > 1 error generated.
> > 
> > See e.g.
> > 
> > https://gitlab.com/mstredhat/qemu/-/jobs/5320879531  
> 
> Thanks. Will see if I can figure out what is going wrong.
> This code seems cursed.  I need to figure out a way to run the CI again.
> Ran into credit problems I couldn't solve last time I tried.
> 
> In meantime I can replicate this locally but not immediately obvious to me
> why it is failing.

Any clang experts around?  This seems to be fixed by reducing the scope

case 4:
{
	QEMU_BUILD_BUG_ON();
}
I have no idea why though...


> 
> Jonathan
> 
> > 
> > 
> >   
> > > ---
> > > v4: Use QEMU_BUILD_BUG_ON() instead of static_assert with missing
> > >     error message.
> > > 
> > >  hw/cxl/cxl-component-utils.c | 65 +++++++++++++++++++++++-------------
> > >  1 file changed, 42 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > > index f3bbf0fd13..d1997a52e6 100644
> > > --- a/hw/cxl/cxl-component-utils.c
> > > +++ b/hw/cxl/cxl-component-utils.c
> > > @@ -67,16 +67,24 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
> > >      CXLComponentState *cxl_cstate = opaque;
> > >      ComponentRegisters *cregs = &cxl_cstate->crb;
> > >  
> > > -    if (size == 8) {
> > > +    switch (size) {
> > > +    case 4:
> > > +        if (cregs->special_ops && cregs->special_ops->read) {
> > > +            return cregs->special_ops->read(cxl_cstate, offset, 4);
> > > +        } else {
> > > +            QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
> > > +            return cregs->cache_mem_registers[offset / 4];
> > > +        }
> > > +    case 8:
> > >          qemu_log_mask(LOG_UNIMP,
> > >                        "CXL 8 byte cache mem registers not implemented\n");
> > >          return 0;
> > > -    }
> > > -
> > > -    if (cregs->special_ops && cregs->special_ops->read) {
> > > -        return cregs->special_ops->read(cxl_cstate, offset, size);
> > > -    } else {
> > > -        return cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
> > > +    default:
> > > +        /*
> > > +         * In line with specifiction limitaions on access sizes, this
> > > +         * routine is not called with other sizes.
> > > +         */
> > > +        g_assert_not_reached();
> > >      }
> > >  }
> > >  
> > > @@ -117,25 +125,36 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
> > >      ComponentRegisters *cregs = &cxl_cstate->crb;
> > >      uint32_t mask;
> > >  
> > > -    if (size == 8) {
> > > +    switch (size) {
> > > +    case 4:
> > > +        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_regs_write_mask) != 4);
> > > +        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
> > > +        mask = cregs->cache_mem_regs_write_mask[offset / 4];
> > > +        value &= mask;
> > > +        /* RO bits should remain constant. Done by reading existing value */
> > > +        value |= ~mask & cregs->cache_mem_registers[offset / 4];
> > > +        if (cregs->special_ops && cregs->special_ops->write) {
> > > +            cregs->special_ops->write(cxl_cstate, offset, value, size);
> > > +            return;
> > > +        }
> > > +
> > > +        if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
> > > +            offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
> > > +            dumb_hdm_handler(cxl_cstate, offset, value);
> > > +        } else {
> > > +            cregs->cache_mem_registers[offset / 4] = value;
> > > +        }
> > > +        return;
> > > +    case 8:
> > >          qemu_log_mask(LOG_UNIMP,
> > >                        "CXL 8 byte cache mem registers not implemented\n");
> > >          return;
> > > -    }
> > > -    mask = cregs->cache_mem_regs_write_mask[offset / sizeof(*cregs->cache_mem_regs_write_mask)];
> > > -    value &= mask;
> > > -    /* RO bits should remain constant. Done by reading existing value */
> > > -    value |= ~mask & cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
> > > -    if (cregs->special_ops && cregs->special_ops->write) {
> > > -        cregs->special_ops->write(cxl_cstate, offset, value, size);
> > > -        return;
> > > -    }
> > > -
> > > -    if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
> > > -        offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
> > > -        dumb_hdm_handler(cxl_cstate, offset, value);
> > > -    } else {
> > > -        cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)] = value;
> > > +    default:
> > > +        /*
> > > +         * In line with specifiction limitaions on access sizes, this
> > > +         * routine is not called with other sizes.
> > > +         */
> > > +        g_assert_not_reached();
> > >      }
> > >  }
> > >  
> > > -- 
> > > 2.39.2    
> > 
> >   
> 



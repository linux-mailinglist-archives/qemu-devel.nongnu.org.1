Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E0478D71C
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:38:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNGC-00082K-I3; Wed, 30 Aug 2023 11:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qbNG7-00081l-3X
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:37:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qbNG3-0002nC-I8
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:37:30 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbT0f1VYxz6HJZZ;
 Wed, 30 Aug 2023 23:36:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 16:37:21 +0100
Date: Wed, 30 Aug 2023 16:37:20 +0100
To: =?ISO-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>
CC: Fan Ni <fan.ni@samsung.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>, "gregory.price@memverge.com"
 <gregory.price@memverge.com>, "hchkuo@avery-design.com.tw"
 <hchkuo@avery-design.com.tw>, "cbrowy@avery-design.com"
 <cbrowy@avery-design.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>, Adam Manzanares
 <a.manzanares@samsung.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
 "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>, "nifan@outlook.com"
 <nifan@outlook.com>
Subject: Re: [Qemu PATCH v2 9/9] hw/mem/cxl_type3: Add dpa range validation
 for accesses to dc regions
Message-ID: <20230830163720.00000f9c@Huawei.com>
In-Reply-To: <d0d7ca1d-81bc-19b3-4904-d60046ded844@wdc.com>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
 <CGME20230725183957uscas1p2ca5293c7229ab989ad1a2d95395436a6@uscas1p2.samsung.com>
 <20230725183939.2741025-10-fan.ni@samsung.com>
 <d0d7ca1d-81bc-19b3-4904-d60046ded844@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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


> > +
> > +/*
> > + * This function check whether a dpa range [dpa, dpa + len) has been backed
> > + * with dc extents, used when validating read/write to dc regions
> > + */
> > +static bool test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> > +        uint64_t len)
> > +{
> > +    int i;
> > +    CXLDCD_Region *region = &ct3d->dc.regions[0];
> > +    uint64_t nbits;
> > +    long nr;
> > +
> > +    if (dpa < region->base
> > +            || dpa >= region->base + ct3d->dc.total_capacity)
> > +        return false;
> > +
> > +    /*
> > +     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
> > +     * Region 0 being used for the lowest DPA of Dynamic Capacity and
> > +     * Region 7 for the highest DPA.
> > +     * So we check from the last region to find where the dpa belongs.
> > +     * access across multiple regions is not allowed.
> > +     */
> > +    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
> > +        region = &ct3d->dc.regions[i];
> > +        if (dpa >= region->base) {
> > +            break;
> > +        }
> > +    }
> > +
> > +    nr = (dpa - region->base) / region->block_size;  
> 
> > +    nbits = len / region->block_size;
oops. Len is probably always smaller than block_size (typically 8 or less)
so nbits always 0.  Should be 1 in those cases.

> > +    return find_next_zero_bit(region->blk_bitmap, nbits, nr) >= nr + nbits;  
> 
> The 2nd parameter to find_next_zero_bit is the length of the bitmap, so 
> shouldn't this be something like (also considering that len is the 
> read/write len, and will be smaller than the region block size):
> 
>    nbits = DIV_ROUND_UP(len, region->block_size);

>  
> 
>    return find_next_zero_bit(region->blk_bitmap, nbits + nr, nr) ==
>           nbits + nr;

Agreed with your suggestion. I'll carry that in my forward port of this
series for now and update my tree at
gitlab.com/jic23/qemu branch will probably be cxl-2023-08-30
a bit later today.

Jonathan



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B880A7A7A8F
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:42:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiva0-0006uP-FZ; Wed, 20 Sep 2023 07:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qivZx-0006uF-Nk
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:41:13 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qivZi-0006DM-9s
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 07:41:13 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RrGgc4hThz687G6;
 Wed, 20 Sep 2023 19:35:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 20 Sep
 2023 12:40:45 +0100
Date: Wed, 20 Sep 2023 12:40:44 +0100
To: Michael Tokarev <mjt@tls.msk.ru>
CC: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Fan Ni
 <fan.ni@samsung.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH v3 2/4] hw/cxl: Use switch statements for read and write
 of cachemem registers
Message-ID: <20230920124044.00002a76@Huawei.com>
In-Reply-To: <37cba7c1-5614-0269-40bf-5addd6c777fe@tls.msk.ru>
References: <20230919093434.1194-1-Jonathan.Cameron@huawei.com>
 <20230919093434.1194-3-Jonathan.Cameron@huawei.com>
 <37cba7c1-5614-0269-40bf-5addd6c777fe@tls.msk.ru>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Wed, 20 Sep 2023 08:08:39 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 19.09.2023 12:34, Jonathan Cameron via wrote:
> > Establishing that only register accesses of size 4 and 8 can occur
> > using these functions requires looking at their callers. Make it
> > easier to see that by using switch statements.
> > Assertions are used to enforce that the register storage is of the
> > matching size, allowing fixed values to be used for divisors of
> > the array indices.
> > 
> > Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Fan Ni <fan.ni@samsung.com>  
> 
> > @@ -117,25 +125,36 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
> >       ComponentRegisters *cregs = &cxl_cstate->crb;
> >       uint32_t mask;  
> ..
> This hunk does not apply to qemu/master.  Is it based on some other
> change missing in this area?
> 
> I thought about collecting all this and pushing trivial-patches but
> stumbled upon this one.

See the dependencies listed in the cover letter for this set.
The HDM decoder series in particular affects the same code.

There are several series that are more urgent than this one as I'm keen
to get some features upstream as well as cleanup this cycle.
I could reorder the tree, but that would have knock on impacts on those
series. Hopefully nothing that would require re-review, but still noisy.

Thanks for considering / trying these though and for picking up
the ones that were dependency free.

Jonathan


> 
> Thanks,
> 
> /mjt
> 



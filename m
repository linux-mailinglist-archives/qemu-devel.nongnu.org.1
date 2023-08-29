Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEB478C291
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 12:49:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qawGR-0003FR-QC; Tue, 29 Aug 2023 06:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qawGM-0003FD-Rt
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 06:47:59 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qawGH-0004b7-74
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 06:47:58 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RZkXQ69H6z6K6Dt;
 Tue, 29 Aug 2023 18:42:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 11:47:31 +0100
Date: Tue, 29 Aug 2023 11:47:30 +0100
To: Jonathan Cameron via <qemu-devel@nongnu.org>
CC: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Richard Henderson
 <richard.henderson@linaro.org>, Mikhail Tyutin <m.tyutin@yadro.com>,
 <pbonzini@redhat.com>, <alex.bennee@linaro.org>, <peter.maydell@linaro.org>,
 Dmitriy Solovev <d.solovev@yadro.com>
Subject: Re: [PATCH v3] Fix SEGFAULT on getting physical address of MMIO
 region.
Message-ID: <20230829114730.00005669@Huawei.com>
In-Reply-To: <20230810141850.000069c9@Huawei.com>
References: <20230804110903.19968-1-m.tyutin@yadro.com>
 <7d785fc0-06d9-3e4e-b1d2-53ee77fd8ab4@linaro.org>
 <20230810141850.000069c9@Huawei.com>
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

On Thu, 10 Aug 2023 14:18:50 +0100
Jonathan Cameron via <qemu-devel@nongnu.org> wrote:

> On Fri, 4 Aug 2023 09:15:13 -0700
> Richard Henderson <richard.henderson@linaro.org> wrote:
> 
> > On 8/4/23 04:09, Mikhail Tyutin wrote:  
> > > Apply save_iotlb_data() to io_readx() as well as to io_writex(). This fixes
> > > SEGFAULT on qemu_plugin_hwaddr_phys_addr() call plugins for addresses inside of
> > > MMIO region.
> > > 
> > > Signed-off-by: Dmitriy Solovev<d.solovev@yadro.com>
> > > Signed-off-by: Mikhail Tyutin<m.tyutin@yadro.com>
> > > Reviewed-by: Richard Henderson<richard.henderson@linaro.org>
> > > ---
> > > v3:
> > > - commit wording update
> > > 
> > > 
> > >   accel/tcg/cputlb.c | 36 +++++++++++++++++++++---------------
> > >   1 file changed, 21 insertions(+), 15 deletions(-)    
> > 
> > Queued to tcg-next.  
> 
> I'm not 100% sure it's related but with qemu/master as of a few hours ago
> I'm getting a segfault with backtrace (can't copy from relevant machine)
> indicating that
> io_writex () is calling memory_region_dispatch_write() and getting
> a segfault on
> 
> if (mr->alias)
> 
> mr has very suspect content of 0x13001300130013
> 
> The segfault is intermittent (otherwise I get hang later in boot) and
> I can only get it to trigger with multiple cpus.
> 
> x86 max cpu and q35 machine.
Resolved by
https://gitlab.com/rth7680/qemu/-/commit/78e096b365326dd2b287e914b393d914dbae3b66
softmmu: Use async_run_on_cpu in tcg_commit

Thanks Richard.



> 
> Jonathan
> 
> 
> > 
> > 
> > r~
> >   
> 
> 
> 



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F467775EC
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 12:36:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU30m-0000P3-EB; Thu, 10 Aug 2023 06:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qU30j-0000OY-EF
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 06:35:21 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qU30h-00074q-1o
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 06:35:21 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RM3B91FWcz6J6lG;
 Thu, 10 Aug 2023 18:31:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 11:35:12 +0100
Date: Thu, 10 Aug 2023 11:35:12 +0100
To: Maverickk 78 <maverickk1778@gmail.com>
CC: Jonathan Cameron via <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: CXL volatile memory is not listed
Message-ID: <20230810113512.00000516@Huawei.com>
In-Reply-To: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
References: <CALfBBTtUtydebmJuh6JZ5RAXZfx5OgJ+RCug1apbZa4mm17rJQ@mail.gmail.com>
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

On Wed, 9 Aug 2023 04:21:47 +0530
Maverickk 78 <maverickk1778@gmail.com> wrote:

> Hello,
> 
> I am running qemu-system-x86_64
> 
> qemu-system-x86_64 --version
> QEMU emulator version 8.0.92 (v8.1.0-rc2-80-g0450cf0897)
>
+Cc linux-cxl as the answer is more todo with linux than qemu.
 
> qemu-system-x86_64 \
> -m 2G,slots=4,maxmem=4G \
> -smp 4 \
> -machine type=q35,accel=kvm,cxl=on \
> -enable-kvm \
> -nographic \
> -device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 \
> -device cxl-rp,id=rp0,bus=cxl.0,chassis=0,port=0,slot=0 \
> -object memory-backend-file,id=mem0,mem-path=/tmp/mem0,size=1G,share=true \
> -device cxl-type3,bus=rp0,volatile-memdev=mem0,id=cxl-mem0 \
> -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=1G

There are some problems upstream at the moment (probably not cxl related but
I'm digging). So today I can't boot an x86 machine. (goody)


More generally for the flow that would bring the memory up as system ram
you would typically need the bios to have done the CXL enumeration or
a bunch of scripts in the kernel to have done it.  In general it can't
be fully automated, because there are policy decisions to make on things like
interleaving.

I'm not aware of any open source BIOSs that do it yet.  So you have
to rely on the same kernel paths as for persistent memory - manual configuration
etc in the kernel. 

There is support in ndctl for those enabling flows, so I'd look there
for more information

Jonathan


> 
> 
> I was expecting the CXL memory to be listed in "System Ram", the lsmem
> shows only 2G memory which is System RAM, it's not listing the CXL
> memory.
> 
> Do I need to pass any particular parameter in the kernel command line?
> 
> Is there any documentation available? I followed the inputs provided in
> 
> https://lore.kernel.org/linux-mm/Y+CSOeHVLKudN0A6@kroah.com/T/
> 
> Is there any documentation/blog listed?



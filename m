Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E9E784568
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 17:24:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTE7-0003zT-JN; Tue, 22 Aug 2023 11:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qYTE4-0003yx-MR; Tue, 22 Aug 2023 11:23:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qYTE0-0003nV-Ak; Tue, 22 Aug 2023 11:23:24 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RVY0245VBz6J6xl;
 Tue, 22 Aug 2023 23:18:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 16:23:04 +0100
Date: Tue, 22 Aug 2023 16:23:03 +0100
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: qemu-arm <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: CXL Namespaces of ACPI disappearing in Qemu demo
Message-ID: <20230822162303.00007def@Huawei.com>
In-Reply-To: <2023081118312729037834@phytium.com.cn>
References: <2023061615433049315231@phytium.com.cn>
 <2023081118312729037834@phytium.com.cn>
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

On Fri, 11 Aug 2023 18:31:28 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> Hi, 
> On 2023-08-10 21:56,  jonathan.cameron wrote:
>  
> So took a look at your issue - be it on the cxl-2023-08-07 branch rebased on qemu/master
> from today (side effect of looking at the segfault that was stopping me getting to this).
>  
> For me at least the branch does create an ACPI0017 DSDT entry and an ACPI0016 one
> and all the CXL devices turn up in /sys/bus/cxl/devices as expected.
>  
> 
> Oh, thanks for your guidance. It works so now I can get  ACPI0017 & ACPI0016 information in DSDT.   : )
> 
> By the way,  I found that if we add a pcie root port which create the same bus number as we assigned to pxb-cxl, 
> the enumeration of cxl and pcie would be different from what we expected.  In this case,  we cannot find 
> CXL devices in /sys/bus/cxl/devices. 

So this seems to be a case of shooting ourselves in the foot, but not catching the nonsensical configuration
(as you observer later! :)
pxb-pcie complains if you try and add two at the same bus number, but that doesn't protect against overlapping
ranges because they aren't known until after enumeration (which is done by the bios - and I guess the bios
doesn't sanity check for this insanity).  Qemu could take another look when it builds the ACPI tables a
second time though.

Looking at edk2 logs I can see it is happily populating the root bus 1 on my arm64 setup and that it
observes there are no subordinate buses available for the main PCIe bus (0) that QEMU is creating by
default. The _CRS entries look correct but the kernel ignores them it seems. 

It is very much not a valid configuration so there is no reason the kernel should cope with it.

Maybe it's worth considering some hardening code?


> 
> According to my test, the error happened in 
> "devm_cxl_register_pci_bus()"  of  "add_host_bridge_uport" in  "cxl_acpi_probe".
> Actually,  in above case, the incorrect enumeration of pcie will also occur with pxb-pcie except for pxb-cxl, 
> hence I guess the kernel did not deal with such case and users just need to avoid it if they need a correct
> enumeration result.

Agreed - Protecting against ever corner case of impossible configuration is tricky to
do.

> 
> My qemu script (which will cause the incorrect enumeration):
> qemu-system-x86_64 \
> -M q35,nvdimm=on,cxl=on \
> -m 4G,maxmem=8G,slots=8 \
> -smp 1 \
> -object memory-backend-file,id=cxl-mem1,share=on,mem-path=./memfile/cxltest3.raw,size=256M \
> -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=./memfile/lsa3.raw,size=256M \
> -device ioh3420,bus=pcie.0,id=root_port1,chassis=0,slot=1,addr=04 \
> -device qemu-xhci,bus=root_port1 \
> -device pxb-cxl,bus_nr=1,bus=pcie.0,id=cxl.1 \
> -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G \
> ......
> 
> Many thanks
> Yuquan



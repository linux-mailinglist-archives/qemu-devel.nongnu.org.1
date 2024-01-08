Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E8A826BD6
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 11:50:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMnCS-0007iJ-LD; Mon, 08 Jan 2024 05:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rMnCJ-0007g7-KQ
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:49:37 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rMnCG-0001zv-Ju
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:49:35 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T7rNX3YSQz6JBZ3;
 Mon,  8 Jan 2024 18:47:08 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 55DF5140135;
 Mon,  8 Jan 2024 18:49:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 8 Jan
 2024 10:49:21 +0000
Date: Mon, 8 Jan 2024 10:49:20 +0000
To: =?gb18030?Q?=D6=DC=CD=AF?= <273415826@qq.com>
CC: qemu-devel <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
Subject: Re: Question about CXL emulation in QEMU
Message-ID: <20240108104920.00002877@Huawei.com>
In-Reply-To: <tencent_8DDF745FD27897D9F242B6E39129B6B96B06@qq.com>
References: <tencent_8DDF745FD27897D9F242B6E39129B6B96B06@qq.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="gb18030"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 5 Jan 2024 19:05:58 +0800
"÷‹ÕØ" <273415826@qq.com> wrote:

> Dear Experts,
> 

+CC linux-cxl as a lot more CXL focused folk there who may be interested
in this discussion.

> I am writing to seek your assistance about CXL emulation in QEMU. I
> am Zhou Tong and I am researching how to use QEMU to simulate CXL
> over Ethernet°£
> 
> I want to implement remote registration of CXL.mem devices based on
> the QOM model. The general idea is: the CXL slave side notifies the
> master side of the size of the CXL memory and other control
> information through Ethernet, and the master side registers the CXL
> device locally based on the control information. When the master
> accesses the CXL device, KVM is responsible for intercepting the
> action of accessing the memory, and encapsulates the CXL message and
> forwards it to the slave through Ethernet£¨

Qemu is not going to see anything that looks like actual CXL messages,
just memory reads and writes - no different to any other RAM.

>ultimately achieving
> remote CXL memory access.. Ask the experts how to register the CXL
> device locally based on the control information without occupying the
> HVA resources of the master host (OR display the CXL device).

This sounds like it will run into the same problem we have with KVM
and the existing emulation of CXL in qemu.  To trap those operations
you'll need to treat it different from normal memory. That generally
limits you to not putting in instructions in that memory. Even in TCG
the performance is shocking as a result.

You could potentially add a caching layer and rely on page faulting
if you are happy with page granularity.  So any writes would result
in a page fault which QEMU could then handle - reads would fault first
time and fetch into a cache.

There are papers on how to do it... (google quickly gave me this)
https://eric-keller.github.io/papers/2020/FluidMem_ICDCS2020.pdf

I've been meaning to look at improving the perf and enabling KVM usage
for simple interleave configurations - particularly as that's one
potential model for virtualization of dynamic capacity devices but
that won't directly help you.

Perhaps there is existing RAM focused work for remote memory on KVM?

I think there are some existing commercial solutions for doing similar
for conventional RAM and the problem is fundamentally the same - I guess
you care about CXL to get a standard Host software stack?

I'm not sure why you'd get HVA resource usage or the host seeing the CXL
device.  This part is just the same as normal CXL device emulation,
it will absorb GPA space etc on the VM host and the PCIe config space etc
for the CXL device will be emulated as normal.

Jonathan

> 
> 
> Thank you in advance for your attention to this email, and I eagerly
> look forward to any insights or advice you may be able to provide. If
> there is a more convenient time for us to discuss this matter
> further, please let me know, and I will be more than happy to
> accommodate your schedule.
> 
> 
> Once again, thank you for your impactful contributions to the
> open-source community, and I greatly appreciate your time and
> consideration.
> 
> 
> 
> Regard,
> 
> 
> Zhou Tong.
> 
> 
> 
> 
> 
> 
> 
> ÷‹ÕØ
> 273415826@qq.com
> 
> 
> 
> &nbsp;


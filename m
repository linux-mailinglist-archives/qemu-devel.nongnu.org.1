Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9C17B4D41
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 10:24:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnECT-0001cu-8Q; Mon, 02 Oct 2023 04:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qnECQ-0001cf-Rt; Mon, 02 Oct 2023 04:22:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qnECJ-0005VF-2H; Mon, 02 Oct 2023 04:22:38 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzYlZ0brYz6HJH0;
 Mon,  2 Oct 2023 16:19:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 09:22:14 +0100
Date: Mon, 2 Oct 2023 09:22:13 +0100
To: Klaus Jensen <its@irrelevant.dk>
CC: Alistair Francis <alistair23@gmail.com>, <lukas@wunner.de>,
 <wilfred.mallawa@wdc.com>, <jiewen.yao@intel.com>, <qemu-devel@nongnu.org>,
 <kbusch@kernel.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <hchkuo@avery-design.com.tw>, <cbrowy@avery-design.com>,
 <qemu-block@nongnu.org>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/3] hw/nvme: Add SPDM over DOE support
Message-ID: <20231002092213.00005c89@Huawei.com>
In-Reply-To: <ZRpuLrJjTYlHV1OZ@cormorant.local>
References: <20230915112723.2033330-1-alistair.francis@wdc.com>
 <20230915112723.2033330-3-alistair.francis@wdc.com>
 <ZRpuLrJjTYlHV1OZ@cormorant.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Mon, 2 Oct 2023 09:15:58 +0200
Klaus Jensen <its@irrelevant.dk> wrote:

> On Sep 15 21:27, Alistair Francis wrote:
> > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > 
> > Setup Data Object Exchance (DOE) as an extended capability for the NVME
> > controller and connect SPDM to it (CMA) to it.
> > 
> > Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  docs/specs/index.rst        |  1 +
> >  docs/specs/spdm.rst         | 56 +++++++++++++++++++++++++++++++++++++
> >  include/hw/pci/pci_device.h |  5 ++++
> >  include/hw/pci/pcie_doe.h   |  3 ++
> >  hw/nvme/ctrl.c              | 52 ++++++++++++++++++++++++++++++++++
> >  hw/nvme/trace-events        |  1 +
> >  6 files changed, 118 insertions(+)
> >  create mode 100644 docs/specs/spdm.rst
> >   
> 
> This looks reasonable enough, but could this not be implemented at the
> PCI layer? I do not see anything that is tied specifically to the nvme
> device, why can the spdm parameter not be a PCIDevice parameter such
> that all PCIDevice-derived devices gains this functionality?
> 
Whilst a few parts of this feel like they'd reasonably move to PCI core
library code (though may not be worth it as they are trivial wrappers).
I can look at that when we add CXL support on top of this (which will be
simple given Alastair used the SPDM sockets stuff the CXL stuff is
based on.)

I'm not sure it makes sense to have it as a property for all
devices. If we did go that way possible issues would include.
1) Need find some extended config space to put it in and extended config
   space layouts are per device. We'd need to do something like
   pcie_endpoint_cap_init() that provided a suitable address range.
   So other than stashing the address int he PCI core to allow the
   default config_read / config_write to work we don't gain much.
2) This will get more complex and more device specific as there are a whole
   load of device specific protocols that will get layered on top. Sure
   we could do all that with callbacks, but seems simpler just to stick to
   a bit of repeating boiler plate.
3) There will probably be real devices with multiple instances.  Whether
   we emulate the in QEMU is a whole different question. Virtualizing real
   instances of this is going to be interest (if we don't just hide them
   completely in the host).

Anyhow I'd go with a 'maybe' but not yet.  Easy to move this later I think
if it does make sense to move where it is implemented?

Jonathan




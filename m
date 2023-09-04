Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B7744791762
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:44:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8w3-00021f-HM; Mon, 04 Sep 2023 08:44:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qd8w0-0001qe-2f; Mon, 04 Sep 2023 08:44:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qd8vp-0004dS-Op; Mon, 04 Sep 2023 08:44:02 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfSr567tpz6J80Q;
 Mon,  4 Sep 2023 20:39:17 +0800 (CST)
Received: from localhost (10.48.153.57) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 4 Sep
 2023 13:43:43 +0100
Date: Mon, 4 Sep 2023 13:43:42 +0100
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: qemu-arm <qemu-arm@nongnu.org>, "gregory.price@memverge.com"
 <gregory.price@memverge.com>, <qemu-devel@nongnu.org>
Subject: Re: CXL Namespaces of ACPI disappearing in Qemu demo
Message-ID: <20230904134342.000048bf@Huawei.com>
In-Reply-To: <2023090418270957278822@phytium.com.cn>
References: <2023082215220191352877@phytium.com.cn>
 <2023090418270957278822@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.153.57]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 4 Sep 2023 18:27:10 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> Hi, Jonathan
> 
Hi Yuquan

Given this question isn't just ARM specific included qemu-devel in the cc list as
that gets much wider reading than qemu-arm.

> Due to my poor experience and knowledge on cxl development history, I am sorry to continue
> to ask some very simple and fundamental questions  : (
> 
> In hw/arm/virt :
> [VIRT_CXL_HOST] =           { 0x0, 64 * KiB * 16 }, /* 16 UID */
> 
> It seems like the specific space for MMIO of cxl host bridges.  Why not just use the existing "VIRT_PCIE_MMIO" 
> space for them? 

At the system design level, MMIO space of Root complex register space via RCRB
does not map in a similar fashion to PCIE MMIO space (which is handled via
address decoding in the PCIE fabric). It is much more similar to MMIO for platform
devices - as such the implementation handles in like a platform device (well 16 of
them which seemed enough for any sane usecase).


Now the next bit I've only quickly explored so may have some errors!

For instance on a GPEX the main MMIO region is an alias to the sysbus mmio region 1.
https://elixir.bootlin.com/qemu/latest/source/hw/arm/virt.c#L1452
That region is then mapped to a generic pci_root_bus for use by bar
mappings etc.

https://elixir.bootlin.com/qemu/latest/source/hw/pci-host/gpex.c#L136

So in theory we could make some space for the CXL root bridge RCRB registers
but it would make various generic paths more complex.  In a real system
those registers are likely to be far from the PCI MMIO space anyway so the
way it's modeled is probably more realistic than pushing the RCRB into the
existing allocation.

I hope that clarifies our reasoning for handling this MMIO region separately.

Jonathan

> 
> I would be grateful if you have some free time to help check this issue : )
> 
> Many thanks
> Yuquan



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7E49D5109
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Nov 2024 17:56:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEATX-0003ho-SC; Thu, 21 Nov 2024 11:56:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tEATV-0003hI-9g; Thu, 21 Nov 2024 11:56:13 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tEATS-0007pZ-Ht; Thu, 21 Nov 2024 11:56:12 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XvPSh2RXrz6K5qR;
 Fri, 22 Nov 2024 00:53:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id ADDA7140A70;
 Fri, 22 Nov 2024 00:56:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 21 Nov
 2024 17:56:00 +0100
Date: Thu, 21 Nov 2024 16:55:58 +0000
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
CC: Yuquan Wang <wangyuquan1236@phytium.com.cn>, <devel@edk2.groups.io>,
 <ardb+tianocore@kernel.org>, <quic_llindhol@quicinc.com>,
 <peter.maydell@linaro.org>, <chenbaozi@phytium.com.cn>,
 <linux-cxl@vger.kernel.org>, <asa-dev@op-lists.linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: Re: [edk2-devel] [RFC PATCH v2 1/1] hw/arm/sbsa-ref: Support CXL
 Host Bridge & CFMW
Message-ID: <20241121165558.00005f1b@huawei.com>
In-Reply-To: <90513bfa-0888-44fe-8cd0-7b2e7518a41f@linaro.org>
References: <20241105104346.417102-1-wangyuquan1236@phytium.com.cn>
 <20241105104346.417102-2-wangyuquan1236@phytium.com.cn>
 <20241107120457.00006024@Huawei.com>
 <90513bfa-0888-44fe-8cd0-7b2e7518a41f@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, 12 Nov 2024 18:10:56 +0100
Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org> wrote:

> W dniu 7.11.2024 o=A013:04, Jonathan Cameron pisze:
> > On Tue,  5 Nov 2024 18:43:46 +0800
> > "Yuquan Wang"<wangyuquan1236@phytium.com.cn> wrote:
> >  =20
> >> This creates a default pxb-cxl (bus_nr=3D0xc0) bridge with two
> >> cxl root ports on sbsa-ref. And the memory layout places 64K
> >> space for the cxl host bridge register regions(CHBCR) in the
> >> sbsa-ref memmap.
> >>
> >> In addition, this support indepentent mmio32(32M) & mmio64(1M)
> >> space for cxl components. =20
>=20
> > Those are too small.  Might work today but not sustainable.
> >=20
> > I'm a bit surprised it was this simple to move the MMIO Space away
> > from what is normally done for PXBs.
> > I think it might work because the GPEX memory windows are effectively
> > unlimited in size but I'd like some more eyes on this from people
> > familiar with how all that works and whether there might be some
> > corner cases that you haven't seen yet. =20
>=20
> I see the same problem as with multiple PCIe buses (for NUMA systems):
>=20
> pci 0000:c0:00.0: bridge window [io  size 0x1000]: can't assign; no space
> pci 0000:c0:00.0: bridge window [io  size 0x1000]: failed to assign
> pci 0000:c0:01.0: bridge window [io  size 0x1000]: can't assign; no space
> pci 0000:c0:01.0: bridge window [io  size 0x1000]: failed to assign
>=20
> I do not know how it looks on real hardware (all my systems have one
> PCIe bus) but shouldn't each host bridge have own separate resource
> windows for config space, buses, mmio etc.?
>=20
> Now we squeeze all pcie buses as pcie-pxb devices and this patch adds
> cxl to the combo.

In theory fine to break them up because each can have a smaller window
they just happen to be next to each other in this configuration.

CXL PXB (maybe the pcie one was well) doesn't IIRC support IO regions
in general.  So that above is kind of normal and shouldn't matter
unless you emulate an ancient PCI device.

Jonathan



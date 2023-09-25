Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 344837ADD73
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 18:51:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkonW-00027M-F9; Mon, 25 Sep 2023 12:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qkonS-00027C-Kq
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:50:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qkonP-0006uT-Fd
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 12:50:58 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvTN2241sz6DBDW;
 Tue, 26 Sep 2023 00:48:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 25 Sep
 2023 17:50:51 +0100
Date: Mon, 25 Sep 2023 17:50:50 +0100
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, Michael Tsirkin
 <mst@redhat.com>, <linuxarm@huawei.com>
CC: Fan Ni <fan.ni@samsung.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>, Davidlohr Bueso <dave@stgolabs.net>, Gregory Price
 <gregory.price@memverge.com>, Klaus Jensen <its@irrelevant.dk>, "Corey
 Minyard" <cminyard@mvista.com>, Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 00/19] QEMU: CXL mailbox rework and features
Message-ID: <20230925173615.0000262d@huawei.com>
In-Reply-To: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
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

On Mon, 25 Sep 2023 17:11:05 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Based on: [PATCH] hw/cxl: Fix local variable shadowing of cap_hdrs
> Based on: [PATCH v2 0/3] hw/cxl: Add dummy ACPI QTG DSM
Missed one. 
Based on: [PATCH v4 0/4] hw/cxl: Support emulating 4 HDM decoders throughout topology

> Based on: [PATCH V2] hw/pci-bridge/cxl-upstream: Add serial number extended capability support
> Based on: [PATCH v3 0/4] hw/cxl: Line length reduction and related
> Based on: [PATCH v6 0/3] hw/{i2c,nvme}: mctp endpoint, nvme management interface model
> 
> I'm assuming this last dependency will go via a different tree though there
> is an outstanding request for tests. That equally applies to the CXL setup,
> but there are lot of moving parts. I'll experiment with basic testing
> of the MCTP I2C device whilst this is being reviewed.
> 
> Based on: Message ID: 20230904161847.18468-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230913132523.29780-1-Jonathan.Cameron@huawei.com
> Based on: Message ID: 20230913133615.29876-1-Jonathan.Cameron@huawei.com
> Based on: Message ID: 20230919093434.1194-1-Jonathan.Cameron@huawei.com
> Based on: Message ID: 20230925152258.5444-1-Jonathan.Cameron@huawei.com
And to match above, the above should have been first.

> Based on: Message ID: 20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com

So should be
Based on: [PATCH] hw/cxl: Fix local variable shadowing of cap_hdrs
Based on: [PATCH v2 0/3] hw/cxl: Add dummy ACPI QTG DSM
Based on: [PATCH v4 0/4] hw/cxl: Support emulating 4 HDM decoders throughout topology
Based on: [PATCH V2] hw/pci-bridge/cxl-upstream: Add serial number extended capability support
Based on: [PATCH v3 0/4] hw/cxl: Line length reduction and related
Based on: [PATCH v6 0/3] hw/{i2c,nvme}: mctp endpoint, nvme management interface model

Based on: Message ID: 20230904161847.18468-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230904161847.18468-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230913132523.29780-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230913133615.29876-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230919093434.1194-1-Jonathan.Cameron@huawei.com
Based on: Message ID: 20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com

Sorry about that.

Jonathan


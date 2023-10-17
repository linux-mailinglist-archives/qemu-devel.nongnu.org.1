Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A66D7CC008
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 11:59:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsgpQ-00023w-Dy; Tue, 17 Oct 2023 05:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qsgpM-000237-Ka; Tue, 17 Oct 2023 05:57:29 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qsgpJ-0006AC-1r; Tue, 17 Oct 2023 05:57:28 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4S8q8X69swz6K6GQ;
 Tue, 17 Oct 2023 17:54:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 17 Oct
 2023 10:57:12 +0100
Date: Tue, 17 Oct 2023 10:57:11 +0100
To: Alistair Francis <alistair23@gmail.com>
CC: <cbrowy@avery-design.com>, <wilfred.mallawa@wdc.com>, <mst@redhat.com>,
 <lukas@wunner.de>, <kbusch@kernel.org>, <hchkuo@avery-design.com.tw>,
 <its@irrelevant.dk>, <jiewen.yao@intel.com>, <marcel.apfelbaum@gmail.com>,
 <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 <qemu-block@nongnu.org>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 1/3] hw/pci: Add all Data Object Types defined in
 PCIe r6.0
Message-ID: <20231017105711.00001ed8@Huawei.com>
In-Reply-To: <20231017052155.173577-2-alistair.francis@wdc.com>
References: <20231017052155.173577-1-alistair.francis@wdc.com>
 <20231017052155.173577-2-alistair.francis@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

On Tue, 17 Oct 2023 15:21:53 +1000
Alistair Francis <alistair23@gmail.com> wrote:

> Add all of the defined protocols/features from the PCIe-SIG r6.0
> "Table 6-32 PCI-SIG defined Data Object Types (Vendor ID = 0001h)"
> table.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

If you feel like adding the PCIe r6.1 extras you could, but not necessary
at this point though I can see they might become relevant fairly soon,
particularly async messages and the connection ID stuff.

> ---
>  include/hw/pci/pcie_doe.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/hw/pci/pcie_doe.h b/include/hw/pci/pcie_doe.h
> index 87dc17dcef..15d94661f9 100644
> --- a/include/hw/pci/pcie_doe.h
> +++ b/include/hw/pci/pcie_doe.h
> @@ -46,6 +46,8 @@ REG32(PCI_DOE_CAP_STATUS, 0)
>  
>  /* PCI-SIG defined Data Object Types - r6.0 Table 6-32 */
>  #define PCI_SIG_DOE_DISCOVERY       0x00
> +#define PCI_SIG_DOE_CMA             0x01
> +#define PCI_SIG_DOE_SECURED_CMA     0x02
>  
>  #define PCI_DOE_DW_SIZE_MAX         (1 << 18)
>  #define PCI_DOE_PROTOCOL_NUM_MAX    256



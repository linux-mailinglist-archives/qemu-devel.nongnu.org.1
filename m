Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 483E07A7B1C
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 13:49:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qivh0-0001sW-7D; Wed, 20 Sep 2023 07:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qivgx-0001rW-GK; Wed, 20 Sep 2023 07:48:27 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qivgv-0007GL-9o; Wed, 20 Sep 2023 07:48:27 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RrGvZ0qnnz6HJc5;
 Wed, 20 Sep 2023 19:46:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 20 Sep
 2023 12:48:04 +0100
Date: Wed, 20 Sep 2023 12:48:03 +0100
To: Klaus Jensen <its@irrelevant.dk>
CC: Corey Minyard <cminyard@mvista.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Lior Weintraub <liorw@pliops.com>, Jeremy
 Kerr <jk@codeconstruct.com.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, Peter Delevoryas <peter@pjd.dev>,
 <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <qemu-block@nongnu.org>,
 Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH v6 0/3] hw/{i2c,nvme}: mctp endpoint, nvme management
 interface model
Message-ID: <20230920124803.00005ae9@Huawei.com>
In-Reply-To: <20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com>
References: <20230914-nmi-i2c-v6-0-11bbb4f74d18@samsung.com>
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

On Thu, 14 Sep 2023 11:53:40 +0200
Klaus Jensen <its@irrelevant.dk> wrote:

> This adds a generic MCTP endpoint model that other devices may derive
> from.
> 
> Also included is a very basic implementation of an NVMe-MI device,
> supporting only a small subset of the required commands.
> 
> Since this all relies on i2c target mode, this can currently only be
> used with an SoC that includes the Aspeed I2C controller.
> 
> The easiest way to get up and running with this, is to grab my buildroot
> overlay[1] (aspeed_ast2600evb_nmi_defconfig). It includes modified a
> modified dts as well as a couple of required packages.
> 
> QEMU can then be launched along these lines:
> 
>   qemu-system-arm \
>     -nographic \
>     -M ast2600-evb \
>     -kernel output/images/zImage \
>     -initrd output/images/rootfs.cpio \
>     -dtb output/images/aspeed-ast2600-evb-nmi.dtb \
>     -nic user,hostfwd=tcp::2222-:22 \
>     -device nmi-i2c,address=0x3a \
>     -serial mon:stdio
> 
> From within the booted system,
> 
>   mctp addr add 8 dev mctpi2c15
>   mctp link set mctpi2c15 up
>   mctp route add 9 via mctpi2c15
>   mctp neigh add 9 dev mctpi2c15 lladdr 0x3a
>   mi-mctp 1 9 info
> 
> Comments are very welcome!
> 
>   [1]: https://github.com/birkelund/hwtests/tree/main/br2-external
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>

Hi Klaus,

Silly question, but who is likely to pick this up? + likely to be soon?

I'm going to post the CXL stuff that makes use of the core support shortly
and whilst I can point at this patch set on list, I'd keen to see it upstream
to reduce the dependencies (it's got 2 sets ahead of it of CXL stuff
anyway but that will all hopefully go through Michael Tsirkin's tree
for PCI stuff in one go).

Jonathan

> ---
> Changes in v6:
> - Use nmi_scratch_append() directly where it makes sense. Fixes bug
>   observed by Andrew.
> - Link to v5: https://lore.kernel.org/r/20230905-nmi-i2c-v5-0-0001d372a728@samsung.com
> 
> Changes in v5:
> - Added a nmi_scratch_append() that asserts available space in the
>   scratch buffer. This is a similar defensive strategy as used in
>   hw/i2c/mctp.c
> - Various small fixups in response to review (Jonathan)
> - Link to v4: https://lore.kernel.org/r/20230823-nmi-i2c-v4-0-2b0f86e5be25@samsung.com
> 
> ---
> Klaus Jensen (3):
>       hw/i2c: add smbus pec utility function
>       hw/i2c: add mctp core
>       hw/nvme: add nvme management interface model
> 
>  MAINTAINERS                   |   7 +
>  hw/arm/Kconfig                |   1 +
>  hw/i2c/Kconfig                |   4 +
>  hw/i2c/mctp.c                 | 432 ++++++++++++++++++++++++++++++++++++++++++
>  hw/i2c/meson.build            |   1 +
>  hw/i2c/smbus_master.c         |  26 +++
>  hw/i2c/trace-events           |  13 ++
>  hw/nvme/Kconfig               |   4 +
>  hw/nvme/meson.build           |   1 +
>  hw/nvme/nmi-i2c.c             | 407 +++++++++++++++++++++++++++++++++++++++
>  hw/nvme/trace-events          |   6 +
>  include/hw/i2c/mctp.h         | 125 ++++++++++++
>  include/hw/i2c/smbus_master.h |   2 +
>  include/net/mctp.h            |  35 ++++
>  14 files changed, 1064 insertions(+)
> ---
> base-commit: 005ad32358f12fe9313a4a01918a55e60d4f39e5
> change-id: 20230822-nmi-i2c-d804ed5be7e6
> 
> Best regards,



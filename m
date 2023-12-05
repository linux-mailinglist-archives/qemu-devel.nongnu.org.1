Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 973E9804B6D
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 08:50:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAQAc-0005sD-NJ; Tue, 05 Dec 2023 02:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1rAQAa-0005ru-GO; Tue, 05 Dec 2023 02:48:40 -0500
Received: from 60-248-80-70.hinet-ip.hinet.net ([60.248.80.70]
 helo=Atcsqr.andestech.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ethan84@andestech.com>)
 id 1rAQAX-0005IW-8c; Tue, 05 Dec 2023 02:48:40 -0500
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 3B57m629081069;
 Tue, 5 Dec 2023 15:48:06 +0800 (+08)
 (envelope-from ethan84@andestech.com)
Received: from ethan84-VirtualBox (10.0.12.51) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Tue, 5 Dec 2023
 15:48:04 +0800
Date: Tue, 5 Dec 2023 15:47:59 +0800
To: <qemu-devel@nongnu.org>
CC: <peter.maydell@linaro.org>, <edgar.iglesias@gmail.com>,
 <richard.henderson@linaro.org>, <pbonzini@redhat.com>,
 <palmer@dabbelt.com>, <alistair.francis@wdc.com>,
 <in.meng@windriver.com>, <liweiwei@iscas.ac.cn>,
 <dbarboza@ventanamicro.com>, <hiwei_liu@linux.alibaba.com>,
 <qemu-riscv@nongnu.org>, <peterx@redhat.com>, <david@redhat.com>
Subject: Re: [PATCH v4 0/4] Support RISC-V IOPMP
Message-ID: <ZW7Vr1SGnEoHADAY@ethan84-VirtualBox>
References: <20231122053251.440723-1-ethan84@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231122053251.440723-1-ethan84@andestech.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Originating-IP: [10.0.12.51]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 3B57m629081069
Received-SPF: pass client-ip=60.248.80.70; envelope-from=ethan84@andestech.com;
 helo=Atcsqr.andestech.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RDNS_DYNAMIC=0.982,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_RCVD_IP=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reply-to:  Ethan Chen <ethan84@andestech.com>
From:  Ethan Chen via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Ping.
https://patchew.org/QEMU/20231122053251.440723-1-ethan84@andestech.com/

On Wed, Nov 22, 2023 at 01:32:47PM +0800, Ethan Chen wrote:
> This series implements IOPMP specification v1.0.0-draft4 rapid-k model.
> The specification url:
> https://github.com/riscv-non-isa/iopmp-spec/blob/main/riscv_iopmp_specification.pdf
> 
> When IOPMP is enabled, a DMA device ATCDMAC300 is added to RISC-V virt
> platform. This DMA device is connected to the IOPMP and has the functionalities
> required by IOPMP, including:
> - Support setup the connection to IOPMP
> - Support asynchronous I/O to handle stall transactions
> - Send transaction information
> 
> IOPMP takes a transaction which partially match an entry as a partially hit
> error. The transaction size is depending on source device, destination device
> and bus.
> 
> Source device can send a transaction_info to IOPMP. IOPMP will check partially
> hit by transaction_info. If source device does not send a transaction_info,
> IOPMP checks information in IOMMU and dose not check partially hit.
> 
> Changes for v4:
> 
>   - Add descriptions of IOPMP and ATCDMAC300
>   - Refine coding style and comments
>   - config XILINX_AXI does not include file stream.c but selects config STREAM
>     instead.
>   - ATCDMAC300: INT_STATUS is write 1 clear per bit
> 		            Rename iopmp_address_sink to transcation_info_sink
>   - IOPMP: Refine error message and remove unused variable
>   - VIRT: Document new options
> 	        atcdmac300 is only added when iopmp is enabled
>           serial setting should not be changed
> 
> Ethan Chen (4):
>   hw/core: Add config stream
>   Add RISC-V IOPMP support
>   hw/dma: Add Andes ATCDMAC300 support
>   hw/riscv/virt: Add IOPMP support
> 
>  docs/system/riscv/virt.rst                    |  11 +
>  hw/Kconfig                                    |   1 +
>  hw/core/Kconfig                               |   3 +
>  hw/core/meson.build                           |   2 +-
>  hw/dma/Kconfig                                |   4 +
>  hw/dma/atcdmac300.c                           | 566 ++++++++++
>  hw/dma/meson.build                            |   1 +
>  hw/misc/Kconfig                               |   4 +
>  hw/misc/meson.build                           |   1 +
>  hw/misc/riscv_iopmp.c                         | 966 ++++++++++++++++++
>  hw/riscv/Kconfig                              |   2 +
>  hw/riscv/virt.c                               |  65 ++
>  include/hw/dma/atcdmac300.h                   | 180 ++++
>  include/hw/misc/riscv_iopmp.h                 | 341 +++++++
>  .../hw/misc/riscv_iopmp_transaction_info.h    |  28 +
>  include/hw/riscv/virt.h                       |  10 +-
>  16 files changed, 2183 insertions(+), 2 deletions(-)
>  create mode 100644 hw/dma/atcdmac300.c
>  create mode 100644 hw/misc/riscv_iopmp.c
>  create mode 100644 include/hw/dma/atcdmac300.h
>  create mode 100644 include/hw/misc/riscv_iopmp.h
>  create mode 100644 include/hw/misc/riscv_iopmp_transaction_info.h
> 
> -- 
> 2.34.1
> 


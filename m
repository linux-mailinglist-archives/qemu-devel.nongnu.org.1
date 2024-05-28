Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3258D17B9
	for <lists+qemu-devel@lfdr.de>; Tue, 28 May 2024 11:57:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBtZm-0002fD-0W; Tue, 28 May 2024 05:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=HxTW=M7=kaod.org=clg@ozlabs.org>)
 id 1sBtZB-0002Ly-ME; Tue, 28 May 2024 05:56:26 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=HxTW=M7=kaod.org=clg@ozlabs.org>)
 id 1sBtZ2-0001YH-A2; Tue, 28 May 2024 05:56:25 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VpSZf22Ytz4x2v;
 Tue, 28 May 2024 19:56:10 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VpSZX5l6Wz4x2g;
 Tue, 28 May 2024 19:56:04 +1000 (AEST)
Message-ID: <f2c66f47-af78-436b-968c-c267e84b9a18@kaod.org>
Date: Tue, 28 May 2024 11:56:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/16] Add AST2700 support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240527080231.1576609-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=HxTW=M7=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Jamin,

I think you should add your self as a Reviewer to the ASPEED BMCs
machine in the MAINTAINERS files. Would you agree ?

Thanks,

C.



On 5/27/24 10:02, Jamin Lin wrote:
> Changes from v1:
> The patch series supports WDT, SDMC, SMC, SCU, SLI and INTC for AST2700 SoC.
> 
> Changes from v2:
> - replace is_aarch64 with is_bus64bit for sdmc patch review.
> - fix incorrect dram size for AST2700
> 
> Changes from v3:
> - Add AST2700 Evaluation board in ASPEED document
> - Add avocado test cases for AST2700 Evaluation board
> - Fix reviewers review issues and add reviewers suggestions
> - Implement INTC model GICINT 128 to GICINT136 for AST2700
> 
> Changes from v4:
> - support 64 bits dma dram address associated with review issues
> - support dma start length and 1 byte length unit associated with review issues
> - refactor intc model to fix serial console stuck issue and associated with review issues
> 
> Test Version:
> https://github.com/qemu/qemu/commit/0c2a3807483b4ebe360cfa475dbfc9dfd2f6d16d
> 
> Test steps:
> 1. Download the latest openbmc image for AST2700 from AspeedTech-BMC/openbmc
>     repository, https://github.com/AspeedTech-BMC/openbmc/releases/tag/v09.01
>     link: https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.01/ast2700-default-obmc.tar.gz
> 2. untar ast2700-default-obmc.tar.gz
>     ```
>     tar -xf ast2700-default-obmc.tar.gz
>     ```
> 3. Run and the contents of scripts as following
> IMGDIR=ast2700-default
> UBOOT_SIZE=$(stat --format=%s -L ${IMGDIR}/u-boot-nodtb.bin)
> UBOOT_DTB_ADDR=$((0x400000000 + ${UBOOT_SIZE}))
> 
> qemu-system-aarch64 -M ast2700-evb -nographic\
>   -device loader,addr=0x400000000,file=${IMGDIR}/u-boot-nodtb.bin,force-raw=on\
>   -device loader,addr=${UBOOT_DTB_ADDR},file=${IMGDIR}/u-boot.dtb,force-raw=on\
>   -device loader,addr=0x430000000,file=${IMGDIR}/bl31.bin,force-raw=on\
>   -device loader,addr=0x430080000,file=${IMGDIR}/optee/tee-raw.bin,force-raw=on\
>   -device loader,addr=0x430000000,cpu-num=0\
>   -device loader,addr=0x430000000,cpu-num=1\
>   -device loader,addr=0x430000000,cpu-num=2\
>   -device loader,addr=0x430000000,cpu-num=3\
>   -smp 4\
>   -drive file=${IMGDIR}/image-bmc,format=raw,if=mtd\
>   -serial mon:stdio\
>   -snapshot
> 
> Jamin Lin (16):
>    aspeed/wdt: Add AST2700 support
>    aspeed/sli: Add AST2700 support
>    aspeed/sdmc: remove redundant macros
>    aspeed/sdmc: fix coding style
>    aspeed/sdmc: Add AST2700 support
>    aspeed/smc: correct device description
>    aspeed/smc: support dma start length and 1 byte length unit
>    aspeed/smc: support 64 bits dma dram address
>    aspeed/smc: Add AST2700 support
>    aspeed/scu: Add AST2700 support
>    aspeed/intc: Add AST2700 support
>    aspeed/soc: Add AST2700 support
>    aspeed: Add an AST2700 eval board
>    aspeed/soc: fix incorrect dram size for AST2700
>    test/avocado/machine_aspeed.py: Add AST2700 test case
>    docs:aspeed: Add AST2700 Evaluation board
> 
>   docs/system/arm/aspeed.rst       |  39 +-
>   hw/arm/aspeed.c                  |  32 ++
>   hw/arm/aspeed_ast27x0.c          | 655 +++++++++++++++++++++++++++++++
>   hw/arm/meson.build               |   1 +
>   hw/intc/aspeed_intc.c            | 355 +++++++++++++++++
>   hw/intc/meson.build              |   1 +
>   hw/intc/trace-events             |   6 +
>   hw/misc/aspeed_scu.c             | 306 ++++++++++++++-
>   hw/misc/aspeed_sdmc.c            | 216 +++++++++-
>   hw/misc/aspeed_sli.c             | 177 +++++++++
>   hw/misc/meson.build              |   3 +-
>   hw/misc/trace-events             |  11 +
>   hw/ssi/aspeed_smc.c              | 321 ++++++++++++++-
>   hw/ssi/trace-events              |   2 +-
>   hw/watchdog/wdt_aspeed.c         |  24 ++
>   include/hw/arm/aspeed_soc.h      |  27 +-
>   include/hw/intc/aspeed_intc.h    |  46 +++
>   include/hw/misc/aspeed_scu.h     |  47 ++-
>   include/hw/misc/aspeed_sdmc.h    |   5 +-
>   include/hw/misc/aspeed_sli.h     |  27 ++
>   include/hw/ssi/aspeed_smc.h      |   2 +
>   include/hw/watchdog/wdt_aspeed.h |   3 +-
>   tests/avocado/machine_aspeed.py  |  62 +++
>   23 files changed, 2312 insertions(+), 56 deletions(-)
>   create mode 100644 hw/arm/aspeed_ast27x0.c
>   create mode 100644 hw/intc/aspeed_intc.c
>   create mode 100644 hw/misc/aspeed_sli.c
>   create mode 100644 include/hw/intc/aspeed_intc.h
>   create mode 100644 include/hw/misc/aspeed_sli.h
> 



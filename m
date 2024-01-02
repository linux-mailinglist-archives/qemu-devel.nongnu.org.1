Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 277EA821E2C
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 15:57:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKgB6-0007Kv-GV; Tue, 02 Jan 2024 09:55:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hBD0=IM=kaod.org=clg@ozlabs.org>)
 id 1rKgB3-0007KM-Ld; Tue, 02 Jan 2024 09:55:33 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=hBD0=IM=kaod.org=clg@ozlabs.org>)
 id 1rKgAw-0006tq-WA; Tue, 02 Jan 2024 09:55:29 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4T4G9g6t02z4x1P;
 Wed,  3 Jan 2024 01:55:19 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4T4G9X4wtBz4wcc;
 Wed,  3 Jan 2024 01:55:12 +1100 (AEDT)
Message-ID: <03b969d3-1947-4186-b3ee-15e3cddc5f34@kaod.org>
Date: Tue, 2 Jan 2024 15:55:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/33] hw/cpu/arm: Remove one use of qemu_get_cpu() in
 A7/A15 MPCore priv
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Anton Johansson <anjo@rev.ng>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Hao Wu <wuhaotsh@google.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20231212162935.42910-1-philmd@linaro.org>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231212162935.42910-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=hBD0=IM=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 12/12/23 17:29, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> When a MPCore cluster is used, the Cortex-A cores belong the the
> cluster container, not to the board/soc layer. This series move
> the creation of vCPUs to the MPCore private container.
> 
> Doing so we consolidate the QOM model, moving common code in a
> central place (abstract MPCore parent).

Changing the QOM hierarchy has an impact on the state of the machine
and some fixups are then required to maintain migration compatibility.
This can become a real headache for KVM machines like virt for which
migration compatibility is a feature, less for emulated ones.

I don't have a good solution to propose to overcome this problem :/

C.
  

> 
> This eventually allow removing one qemu_get_cpu() use, which we
> want to remove in heterogeneous machines (machines using MPCore
> are candidate for heterogeneous emulation).
> 
> Maybe these hw/cpu/arm/ files belong to hw/arm/...
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (33):
>    hw/arm/boot: Propagate vCPU to arm_load_dtb()
>    hw/arm/fsl-imx6: Add a local 'gic' variable
>    hw/arm/fsl-imx6ul: Add a local 'gic' variable
>    hw/arm/fsl-imx7: Add a local 'gic' variable
>    hw/cpu: Remove dead Kconfig
>    hw/cpu/arm: Rename 'busdev' -> 'gicsbd' in a15mp_priv_realize()
>    hw/cpu/arm: Alias 'num-cpu' property on TYPE_REALVIEW_MPCORE
>    hw/cpu/arm: Declare CPU QOM types using DEFINE_TYPES() macro
>    hw/cpu/arm: Merge {a9mpcore.h, a15mpcore.h} as cortex_mpcore.h
>    hw/cpu/arm: Introduce abstract CORTEX_MPCORE_PRIV QOM type
>    hw/cpu/arm: Have A9MPCORE/A15MPCORE inheritate common
>      CORTEX_MPCORE_PRIV
>    hw/cpu/arm: Create MPCore container in QOM parent
>    hw/cpu/arm: Handle 'num_cores' property once in MPCore parent
>    hw/cpu/arm: Handle 'has_el2/3' properties once in MPCore parent
>    hw/cpu/arm: Handle 'gic-irq' property once in MPCore parent
>    hw/cpu/arm: Handle GIC once in MPCore parent
>    hw/cpu/arm: Document more properties of CORTEX_MPCORE_PRIV QOM type
>    hw/cpu/arm: Replace A15MPPrivState by CortexMPPrivState
>    hw/cpu/arm: Introduce TYPE_A7MPCORE_PRIV for Cortex-A7 MPCore
>    hw/cpu/arm: Consolidate check on max GIC spi supported
>    hw/cpu/arm: Create CPUs once in MPCore parent
>    hw/arm/aspeed_ast2600: Let the A7MPcore create/wire the CPU cores
>    hw/arm/exynos4210: Let the A9MPcore create/wire the CPU cores
>    hw/arm/fsl-imx6: Let the A9MPcore create/wire the CPU cores
>    hw/arm/fsl-imx6ul: Let the A7MPcore create/wire the CPU cores
>    hw/arm/fsl-imx7: Let the A7MPcore create/wire the CPU cores
>    hw/arm/highbank: Let the A9/A15MPcore create/wire the CPU cores
>    hw/arm/vexpress: Let the A9/A15MPcore create/wire the CPU cores
>    hw/arm/xilinx_zynq: Let the A9MPcore create/wire the CPU cores
>    hw/arm/npcm7xx: Let the A9MPcore create/wire the CPU cores
>    hw/cpu/a9mpcore: Remove legacy code
>    hw/cpu/arm: Remove 'num-cpu' property alias
>    hw/cpu/arm: Remove use of qemu_get_cpu() in A7/A15 realize()
> 
>   MAINTAINERS                    |   3 +-
>   include/hw/arm/aspeed_soc.h    |   5 +-
>   include/hw/arm/boot.h          |   4 +-
>   include/hw/arm/exynos4210.h    |   6 +-
>   include/hw/arm/fsl-imx6.h      |   6 +-
>   include/hw/arm/fsl-imx6ul.h    |   8 +-
>   include/hw/arm/fsl-imx7.h      |   8 +-
>   include/hw/arm/npcm7xx.h       |   3 +-
>   include/hw/cpu/a15mpcore.h     |  44 -------
>   include/hw/cpu/a9mpcore.h      |  39 -------
>   include/hw/cpu/cortex_mpcore.h | 135 ++++++++++++++++++++++
>   hw/arm/aspeed_ast2600.c        |  61 ++++------
>   hw/arm/boot.c                  |  11 +-
>   hw/arm/exynos4210.c            |  60 ++++------
>   hw/arm/exynos4_boards.c        |   6 +-
>   hw/arm/fsl-imx6.c              |  84 ++++----------
>   hw/arm/fsl-imx6ul.c            |  65 ++++-------
>   hw/arm/fsl-imx7.c              | 103 +++++------------
>   hw/arm/highbank.c              |  56 ++-------
>   hw/arm/mcimx6ul-evk.c          |   3 +-
>   hw/arm/mcimx7d-sabre.c         |   3 +-
>   hw/arm/npcm7xx.c               |  48 ++------
>   hw/arm/realview.c              |   4 +-
>   hw/arm/sabrelite.c             |   4 +-
>   hw/arm/vexpress.c              |  60 +++-------
>   hw/arm/virt.c                  |   2 +-
>   hw/arm/xilinx_zynq.c           |  30 ++---
>   hw/cpu/a15mpcore.c             | 179 +++++++++++++----------------
>   hw/cpu/a9mpcore.c              | 138 +++++++++-------------
>   hw/cpu/arm11mpcore.c           |  23 ++--
>   hw/cpu/cortex_mpcore.c         | 202 +++++++++++++++++++++++++++++++++
>   hw/cpu/realview_mpcore.c       |  30 ++---
>   hw/arm/Kconfig                 |   8 +-
>   hw/cpu/Kconfig                 |   8 --
>   hw/cpu/meson.build             |   1 +
>   35 files changed, 689 insertions(+), 761 deletions(-)
>   delete mode 100644 include/hw/cpu/a15mpcore.h
>   delete mode 100644 include/hw/cpu/a9mpcore.h
>   create mode 100644 include/hw/cpu/cortex_mpcore.h
>   create mode 100644 hw/cpu/cortex_mpcore.c
>   delete mode 100644 hw/cpu/Kconfig
> 



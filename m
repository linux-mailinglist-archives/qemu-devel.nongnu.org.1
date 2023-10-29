Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D76507DB0C3
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 00:17:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxF0g-0003BH-4e; Sun, 29 Oct 2023 19:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qxF0T-0003Aq-1H
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 19:15:53 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qxF0Q-0002oy-Re
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 19:15:44 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3b2e07e5f3aso2529748b6e.0
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 16:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698621339; x=1699226139; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqTY7M6R4o3VpCAlfPqsMQwMmdaFXsYFtxorkZn6MDg=;
 b=hyhzACxjv97oV+BuDCGxaXFJdNXNEIXD1AbW58toxs3fBy8GeZ5I24jpLfeMrEHA+I
 QQlaHUQjvfzKbpt9HTJtuN9eZzltYAzGqKQSuSCHuCV8IoUpRFa1pJNSdihcfpEi7xM9
 C3cE66ggrJ8aG0ONXCdqekUKPHnP7Iq1Zdw3KEmNk1XkJZmEndoZ8441GLioX1XFnuy+
 tN49gEymIkzBil4ZWlCQdkUFiTI1ZIsYqrbGUwlBHwtY4pHiZG9qVeuvU0jfMRoeOaHi
 sDStG3PYMoms82Q+0YK5ouGgMD/LM+6NDQ8ox3ZDWN2jRa8c9I8c+tS8nxDeLk5MvV/g
 7ACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698621339; x=1699226139;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EqTY7M6R4o3VpCAlfPqsMQwMmdaFXsYFtxorkZn6MDg=;
 b=OrKyUaodtKR8Gqih5cEY/i3sCXSbvDL/A2JBqmySkMVwOzP769jcrdI4PwVMG2Vkq/
 11QMgW79N3zKO9u7964edEjwdGW8PEqrl4x+JdPshxi4RIFZqdR/shIcMCLtq+60otIL
 gYuQWM1iezpG5EBtYxDdwUqPDsmphzeOI7bPTDvCzuUn8BxZ3+1Q+L36h3TlJkNcOvX4
 Z2ULb5SPEf0dXK4T9+OQm8blYeVYlTtoxfOe4Ho5hFq+wFTAuQXru/W77pS3CmCp2M5+
 SKNqvFfF/SvZsdFWkAIUiB1U5gSWIoSue+b3X1irr8VKpfSb7Ao8fkzmkb5BIZ556o7k
 dOAg==
X-Gm-Message-State: AOJu0Yx3bPHL+2tR2MDm1vEYl/fFawSaUQd6hF/30II36ZF/WMiSKMGE
 BIXLEW/BTWEHmuStla+zlYDaa9Wadx1lTFvbj8ttc8nFWELbjQ==
X-Google-Smtp-Source: AGHT+IGBgNRSuQMIRKtINwTDIQesvtJvrX2CQG4JfskrcpFKUspOXg/+C2hC1XiKLp/IrsEl2pfJvAtzZPHCNvCi4To=
X-Received: by 2002:a05:6808:6d5:b0:3b2:e7b0:dd70 with SMTP id
 m21-20020a05680806d500b003b2e7b0dd70mr6703584oih.4.1698621339195; Sun, 29 Oct
 2023 16:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 30 Oct 2023 08:15:27 +0900
Message-ID: <CAJSP0QU1SUqdTbzNT9_fgCyZ1pGDUk47_T2B-JzjnBXFicEWBA@mail.gmail.com>
Subject: Re: [PULL 00/41] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, 27 Oct 2023 at 23:41, Peter Maydell <peter.maydell@linaro.org> wrot=
e:
>
> Hi; here's the latest target-arm queue. Mostly this is refactoring
> and cleanup type patches.
>
> thanks
> -- PMM

Hi Peter,
I can't find this email thread on lore.kernel.org and your git repo
doesn't let me fetch the tag:

  $ git fetch https://git.linaro.org/people/pmaydell/qemu-arm.git
tags/pull-target-arm-20231027
  fatal: couldn't find remote ref tags/pull-target-arm-20231027

cgit shows the tag though, for some reason:
https://git.linaro.org/people/pmaydell/qemu-arm.git/tag/?h=3Dpull-target-ar=
m-20231027

Any idea what's up with this pull request? Thanks!

Stefan

>
> The following changes since commit c60be6e3e38cb36dc66129e757ec4b34152232=
be:
>
>   Merge tag 'pull-sp-20231025' of https://gitlab.com/rth7680/qemu into st=
aging (2023-10-27 09:43:53 +0900)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-ar=
m-20231027
>
> for you to fetch changes up to df93de987f423a0ed918c425f5dbd9a25d3c6229:
>
>   hw/net/cadence_gem: enforce 32 bits variable size for CRC (2023-10-27 1=
5:27:06 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * Correct minor errors in Cortex-A710 definition
>  * Implement Neoverse N2 CPU model
>  * Refactor feature test functions out into separate header
>  * Fix syndrome for FGT traps on ERET
>  * Remove 'hw/arm/boot.h' includes from various header files
>  * pxa2xx: Refactoring/cleanup
>  * Avoid using 'first_cpu' when first ARM CPU is reachable
>  * misc/led: LED state is set opposite of what is expected
>  * hw/net/cadence_gen: clean up to use FIELD macros
>  * hw/net/cadence_gem: perform PHY access on write only
>  * hw/net/cadence_gem: enforce 32 bits variable size for CRC
>
> ----------------------------------------------------------------
> Glenn Miles (1):
>       misc/led: LED state is set opposite of what is expected
>
> Luc Michel (11):
>       hw/net/cadence_gem: use REG32 macro for register definitions
>       hw/net/cadence_gem: use FIELD for screening registers
>       hw/net/cadence_gem: use FIELD to describe NWCTRL register fields
>       hw/net/cadence_gem: use FIELD to describe NWCFG register fields
>       hw/net/cadence_gem: use FIELD to describe DMACFG register fields
>       hw/net/cadence_gem: use FIELD to describe [TX|RX]STATUS register fi=
elds
>       hw/net/cadence_gem: use FIELD to describe IRQ register fields
>       hw/net/cadence_gem: use FIELD to describe DESCONF6 register fields
>       hw/net/cadence_gem: use FIELD to describe PHYMNTNC register fields
>       hw/net/cadence_gem: perform PHY access on write only
>       hw/net/cadence_gem: enforce 32 bits variable size for CRC
>
> Peter Maydell (9):
>       target/arm: Correct minor errors in Cortex-A710 definition
>       target/arm: Implement Neoverse N2 CPU model
>       target/arm: Move feature test functions to their own header
>       target/arm: Move ID_AA64MMFR1 and ID_AA64MMFR2 tests together
>       target/arm: Move ID_AA64MMFR0 tests up to before MMFR1 and MMFR2
>       target/arm: Move ID_AA64ISAR* test functions together
>       target/arm: Move ID_AA64PFR* tests together
>       target/arm: Move ID_AA64DFR* feature tests together
>       target/arm: Fix syndrome for FGT traps on ERET
>
> Philippe Mathieu-Daud=C3=A9 (20):
>       hw/arm/allwinner-a10: Remove 'hw/arm/boot.h' from header
>       hw/arm/allwinner-h3: Remove 'hw/arm/boot.h' from header
>       hw/arm/allwinner-r40: Remove 'hw/arm/boot.h' from header
>       hw/arm/fsl-imx25: Remove 'hw/arm/boot.h' from header
>       hw/arm/fsl-imx31: Remove 'hw/arm/boot.h' from header
>       hw/arm/fsl-imx6: Remove 'hw/arm/boot.h' from header
>       hw/arm/fsl-imx6ul: Remove 'hw/arm/boot.h' from header
>       hw/arm/fsl-imx7: Remove 'hw/arm/boot.h' from header
>       hw/arm/xlnx-versal: Remove 'hw/arm/boot.h' from header
>       hw/arm/xlnx-zynqmp: Remove 'hw/arm/boot.h' from header
>       hw/sd/pxa2xx: Realize sysbus device before accessing it
>       hw/sd/pxa2xx: Do not open-code sysbus_create_simple()
>       hw/pcmcia/pxa2xx: Realize sysbus device before accessing it
>       hw/pcmcia/pxa2xx: Do not open-code sysbus_create_simple()
>       hw/pcmcia/pxa2xx: Inline pxa2xx_pcmcia_init()
>       hw/intc/pxa2xx: Convert to Resettable interface
>       hw/intc/pxa2xx: Pass CPU reference using QOM link property
>       hw/intc/pxa2xx: Factor pxa2xx_pic_realize() out of pxa2xx_pic_init(=
)
>       hw/arm/pxa2xx: Realize PXA2XX_I2C device before accessing it
>       hw/arm: Avoid using 'first_cpu' when first ARM CPU is reachable
>
>  docs/system/arm/virt.rst          |   1 +
>  bsd-user/arm/target_arch.h        |   1 +
>  include/hw/arm/allwinner-a10.h    |   1 -
>  include/hw/arm/allwinner-h3.h     |   1 -
>  include/hw/arm/allwinner-r40.h    |   1 -
>  include/hw/arm/fsl-imx25.h        |   1 -
>  include/hw/arm/fsl-imx31.h        |   1 -
>  include/hw/arm/fsl-imx6.h         |   1 -
>  include/hw/arm/fsl-imx6ul.h       |   1 -
>  include/hw/arm/fsl-imx7.h         |   1 -
>  include/hw/arm/pxa.h              |   2 -
>  include/hw/arm/xlnx-versal.h      |   1 -
>  include/hw/arm/xlnx-zynqmp.h      |   1 -
>  linux-user/aarch64/target_prctl.h |   2 +
>  target/arm/cpu-features.h         | 994 ++++++++++++++++++++++++++++++++=
++++++
>  target/arm/cpu.h                  | 971 --------------------------------=
-----
>  target/arm/internals.h            |   1 +
>  target/arm/tcg/translate.h        |   2 +-
>  hw/arm/armv7m.c                   |   1 +
>  hw/arm/bananapi_m2u.c             |   3 +-
>  hw/arm/cubieboard.c               |   1 +
>  hw/arm/exynos4_boards.c           |   7 +-
>  hw/arm/imx25_pdk.c                |   1 +
>  hw/arm/kzm.c                      |   1 +
>  hw/arm/mcimx6ul-evk.c             |   1 +
>  hw/arm/mcimx7d-sabre.c            |   1 +
>  hw/arm/orangepi.c                 |   3 +-
>  hw/arm/pxa2xx.c                   |  17 +-
>  hw/arm/pxa2xx_pic.c               |  38 +-
>  hw/arm/realview.c                 |   2 +-
>  hw/arm/sabrelite.c                |   1 +
>  hw/arm/sbsa-ref.c                 |   1 +
>  hw/arm/virt.c                     |   1 +
>  hw/arm/xilinx_zynq.c              |   2 +-
>  hw/arm/xlnx-versal-virt.c         |   1 +
>  hw/arm/xlnx-zcu102.c              |   1 +
>  hw/intc/armv7m_nvic.c             |   1 +
>  hw/misc/led.c                     |   2 +-
>  hw/net/cadence_gem.c              | 884 ++++++++++++++++++--------------=
-
>  hw/pcmcia/pxa2xx.c                |  15 -
>  hw/sd/pxa2xx_mmci.c               |   7 +-
>  linux-user/aarch64/cpu_loop.c     |   1 +
>  linux-user/aarch64/signal.c       |   1 +
>  linux-user/arm/signal.c           |   1 +
>  linux-user/elfload.c              |   4 +
>  linux-user/mmap.c                 |   4 +
>  target/arm/arch_dump.c            |   1 +
>  target/arm/cpu.c                  |   1 +
>  target/arm/cpu64.c                |   1 +
>  target/arm/debug_helper.c         |   1 +
>  target/arm/gdbstub.c              |   1 +
>  target/arm/helper.c               |   1 +
>  target/arm/kvm64.c                |   1 +
>  target/arm/machine.c              |   1 +
>  target/arm/ptw.c                  |   1 +
>  target/arm/tcg/cpu64.c            | 115 ++++-
>  target/arm/tcg/hflags.c           |   1 +
>  target/arm/tcg/m_helper.c         |   1 +
>  target/arm/tcg/op_helper.c        |   1 +
>  target/arm/tcg/pauth_helper.c     |   1 +
>  target/arm/tcg/tlb_helper.c       |   1 +
>  target/arm/tcg/translate-a64.c    |   4 +-
>  target/arm/vfp_helper.c           |   1 +
>  63 files changed, 1702 insertions(+), 1419 deletions(-)
>  create mode 100644 target/arm/cpu-features.h
>


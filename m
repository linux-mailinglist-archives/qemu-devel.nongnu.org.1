Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 105FA7DC7AA
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 08:53:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxjXa-0003Pa-FO; Tue, 31 Oct 2023 03:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qxjXY-0003PL-2B
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 03:51:56 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qxjXW-0002OS-5u
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 03:51:55 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-57f0f81b2aeso2942013eaf.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 00:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698738712; x=1699343512; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v81Epd4FjvsMT1IdGIi2stdHexK7L2yzQ3GWb1740KE=;
 b=dY5FCcDHsRJYqABqsQn9Nw27MqVWO7X0K1ElHQX4QGBiT0Muv/wJCtTpS6SN5+tK7Q
 Jewv/NmsDcPpXh3bGUp8b6gctLXADvYnFKXc4PWs/2Rge4orQBajYnWIoh7ka/dW3Dng
 RmoQZmXOXA+3ZGUXo8LshXz6zGHbRKkUCZxC08KhVuSsztA0ua4ab2fGOqtIQ3JMtgYL
 bFVxxHN1G+Jx1HmTfK+Xofs7OZSeMObf0N0IZ3Fu4B8RpI11TzcnMbMiiV2uQp4JsUn9
 Yt1yBwaZd7xFDkx8ITwkNFV59Kt+wfr4kJ45peooG/RAUxYvfDmsP9/lIPNEYmH8tuHK
 v99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698738712; x=1699343512;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v81Epd4FjvsMT1IdGIi2stdHexK7L2yzQ3GWb1740KE=;
 b=gt6dzsPhkAkhyin4eYzqLhsHzydcLfIN1I4Z8D6Inu++gHwVV8Lq2u2YMcV5Ft5KRS
 aME1XtVIGlDUyD6ISYbeiIa68QphCA966DcNXuLnym7hvkK7lbnu5MUFAfSSgu8Z9Io4
 7qPdxl7IbEtdOhLhMrIInzap8sxHnYjU+bAQUN/l8YhqW6XVDFzImKwNlMbZYCUjSv1v
 lmh8u7lVrgMUlyvWhAMGozi4nzWRpCn9hz7H1OAZiZd73peS+kv13/6UrmyKVL0UB0FF
 OuxC/lHaLh+ktJl908XNd2TgRW6qWthtiTkpKNzonJHJA0NjeMJGUpRlkbvxbgaFP4od
 WB+w==
X-Gm-Message-State: AOJu0YwLkYdZufR59LDUm/9mdhJG31hefYut8Rs0WR+ZEPE0ceb8yEIi
 lt03oG0JpvLQpVsAnhh+VFQkfd6tfonoQPHjN3w=
X-Google-Smtp-Source: AGHT+IHVPFBTUxGnbpNWLAkYBpT3qcXkttlD9tfxxIFHuk9yDna4q36Y1ETk+/Toeywe0HNreqFgDTMPJYG7WJ+kS+s=
X-Received: by 2002:a05:6820:a90:b0:581:3e09:2623 with SMTP id
 de16-20020a0568200a9000b005813e092623mr10254151oob.2.1698738712264; Tue, 31
 Oct 2023 00:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231027143942.3413881-1-peter.maydell@linaro.org>
In-Reply-To: <20231027143942.3413881-1-peter.maydell@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 31 Oct 2023 16:51:40 +0900
Message-ID: <CAJSP0QVHmcmDuaVavQCvs1x=pdfz09HpxDpitSsY_yL2Kgx87g@mail.gmail.com>
Subject: Re: [PULL 00/41] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc36.google.com
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

Applied, thanks!

Stefan

>
> thanks
> -- PMM
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


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB515A23A30
	for <lists+qemu-devel@lfdr.de>; Fri, 31 Jan 2025 08:35:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdlXr-0006qh-9h; Fri, 31 Jan 2025 02:34:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GenN=UX=kaod.org=clg@ozlabs.org>)
 id 1tdlXo-0006pO-VA; Fri, 31 Jan 2025 02:34:28 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GenN=UX=kaod.org=clg@ozlabs.org>)
 id 1tdlXm-0005S2-Ew; Fri, 31 Jan 2025 02:34:28 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4YknhG1W90z4x5k;
 Fri, 31 Jan 2025 18:34:06 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Yknh93spRz4wdF;
 Fri, 31 Jan 2025 18:34:01 +1100 (AEDT)
Message-ID: <096e8152-ec19-4b2b-aa56-dd566ce7bb6d@kaod.org>
Date: Fri, 31 Jan 2025 08:34:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/18] Support AST2700 A1
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20250121070424.2465942-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=GenN=UX=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.03, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Jamin,

On 1/21/25 08:04, Jamin Lin wrote:
> v1:
>   1. Refactor INTC model to support both INTC0 and INTC1.
>   2. Support AST2700 A1.
>   3. Create ast2700a0-evb machine.
>   
> With the patch applied, QEMU now supports two machines for running AST2700 SoCs:
> ast2700a0-evb: Designed for AST2700 A0
> ast2700-evb: Designed for AST2700 A1

Let's do that progressively, please add a new ast2700a1-evb machine too and
a machine alias on ast2700a0-evb. Then we will change the alias on the newer
SoC.


> 
> Test information
> 1. QEMU version: https://github.com/qemu/qemu/commit/d6430c17d7113d3c38480dc34e59d00b0504e2f7
> 2. This patch series depends on the following patch series
>     https://patchwork.kernel.org/project/qemu-devel/cover/20250113064455.1660564-1-jamin_lin@aspeedtech.com/
>     https://patchwork.kernel.org/project/qemu-devel/cover/20241114094839.4128404-1-jamin_lin@aspeedtech.com/
> 3. ASPEED SDK v09.05 pre-built image
>     https://github.com/AspeedTech-BMC/openbmc/releases/tag/v09.05
>     ast2700-default-obmc.tar.gz (A1)
>     https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.05/ast2700-default-obmc.tar.gz

We need a functional test case for the new A1 SoC please.



Also, could please split the patchset in 3 and resend :

1. INTC rename/prereqs/cleanups

   hw/intc/aspeed: Rename INTC to INTC0
   hw/intc/aspeed: Support different memory region ops
   hw/intc/aspeed: Introduce a new aspeed_2700_intc0_ops for INTC0
   hw/intc/aspeed: Support setting different memory and register size
   hw/intc/aspeed: Introduce helper functions for enable and status registers
   hw/intc/aspeed: Add ID to trace events for better debugging
   hw/arm/aspeed: Rename IRQ table and machine name for AST2700 A0

2. AST2700A1 support

   hw/misc/aspeed_scu: Add Support for AST2700/AST2750 A1 Silicon Revisions
   hw/intc/aspeed: Introduce AspeedINTCIRQ structure to save the irq index and register address
   hw/intc/aspeed: Introduce IRQ handler function to reduce code duplication
   hw/intc/aspeed: Add Support for Multi-Output IRQ Handling
   hw/intc/aspeed: Add Support for AST2700 INTC1 Controller
   hw/arm/aspeed_ast27x0: Support two levels of INTC controllers for AST2700 A1
   hw/arm/aspeed: Add SoC and Machine Support for AST2700 A1

3. HACE support

   hw/misc/aspeed_hace: Fix coding style
   hw/misc/aspeed_hace: Add AST2700 support
   hw/arm/aspeed_ast27x0: Add HACE support for AST2700
   hw/misc/aspeed_hace: (DROP) Fix boot issue in the Crypto Manager Self Test(WORKAROUND)
   
It seems that 1+3 could be reviewed and merged quickly. 2 is definitely
more complex.
  
> Known Issue:
> The HACE crypto and hash engine is enable by default since AST2700 A1.
> However, aspeed_hace.c(HACE model) currently does not support the CRYPTO command.

Do we need support from the QEMU crypto subsystem or do we only lack
an implementation for the model ?

> To boot AST2700 A1, I have created a Patch 18 which temporarily resolves the
> issue by sending an interrupt to notify the firmware that the cryptographic
> command has completed. It is a temporary workaround to resolve the boot issue
> in the Crypto Manager SelfTest.

could you test the silicon revision in the model for this workaround ?


Thanks,

C.



> As a result, you will encounter the following kernel warning due to the
> Crypto Manager test failure. If you don't want to see these kernel warning,
> please add the following settings in your kernel config.
> 
> ```
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> ```
> 
> ```
> alg: skcipher: aspeed-ctr-tdes encryption test failed (wrong result) on test vector 0, cfg="in-place (one sglist)"
> [    5.035966] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes failed (rc=-22)
> [    5.036139] ------------[ cut here ]------------
> [    5.037188] alg: self-tests for ctr(des3_ede) using aspeed-ctr-tdes failed (rc=-22)
> [    5.037312] WARNING: CPU: 2 PID: 109 at /crypto/testmgr.c:5936 alg_test+0x42c/0x548
> [    5.038049] Modules linked in:
> [    5.038302] CPU: 2 PID: 109 Comm: cryptomgr_test Tainted: G        W          6.6.52-v00.06.04-gf52a0cf7c475 #1
> [    5.038787] Hardware name: AST2700-EVB (DT)
> [    5.038988] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    5.039315] pc : alg_test+0x42c/0x548
> [    5.039505] lr : alg_test+0x42c/0x548
> [    5.039697] sp : ffffffc0825e3d50
> [    5.039862] x29: ffffffc0825e3df0 x28: 0000000000000004 x27: 0000000000000000
> [    5.040226] x26: ffffffc080bcada0 x25: ffffffc081dac9d0 x24: 0000000000000004
> [    5.040700] x23: 0000000000001285 x22: ffffff8003ded280 x21: ffffff8003ded200
> [    5.041458] x20: 00000000ffffffff x19: 00000000ffffffea x18: ffffffffffffffff
> [    5.041915] x17: 282064656c696166 x16: 20736564742d7274 x15: 00000000fffffffe
> [    5.042287] x14: 0000000000000000 x13: ffffffc081ba555c x12: 65742d666c657320
> [    5.042684] x11: 00000000fffeffff x10: ffffffc0818ff048 x9 : ffffffc0800a36e4
> [    5.043077] x8 : 000000000017ffe8 x7 : c0000000fffeffff x6 : 000000000057ffa8
> [    5.043461] x5 : 000000000000ffff x4 : 0000000000000000 x3 : 0000000000000000
> [    5.043751] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffffff800415e740
> [    5.045544] Call trace:
> [    5.045693]  alg_test+0x42c/0x548
> [    5.045878]  cryptomgr_test+0x28/0x48
> [    5.046052]  kthread+0x114/0x120
> [    5.046226]  ret_from_fork+0x10/0x20
> [    5.046413] ---[ end trace 0000000000000000 ]---
> [    5.071510] alg: skcipher: aspeed-ctr-des encryption test failed (wrong result) on test vector 0, cfg="in-place (one sglist)"
> [    5.072145] alg: self-tests for ctr(des) using aspeed-ctr-des failed (rc=-22)
> ```
> 
> 
> Jamin Lin (18):
>    hw/intc/aspeed: Rename INTC to INTC0
>    hw/intc/aspeed: Support different memory region ops
>    hw/intc/aspeed: Introduce a new aspeed_2700_intc0_ops for INTC0
>    hw/intc/aspeed: Support setting different memory and register size
>    hw/intc/aspeed: Introduce helper functions for enable and status
>      registers
>    hw/intc/aspeed: Introduce AspeedINTCIRQ structure to save the irq
>      index and register address
>    hw/intc/aspeed: Introduce IRQ handler function to reduce code
>      duplication
>    hw/intc/aspeed: Add Support for Multi-Output IRQ Handling
>    hw/intc/aspeed: Add ID to trace events for better debugging
>    hw/intc/aspeed: Add Support for AST2700 INTC1 Controller
>    hw/misc/aspeed_scu: Add Support for AST2700/AST2750 A1 Silicon
>      Revisions
>    hw/arm/aspeed_ast27x0: Support two levels of INTC controllers for
>      AST2700 A1
>    hw/arm/aspeed: Rename IRQ table and machine name for AST2700 A0
>    hw/arm/aspeed: Add SoC and Machine Support for AST2700 A1
>    hw/misc/aspeed_hace: Fix coding style
>    hw/misc/aspeed_hace: Add AST2700 support
>    hw/arm/aspeed_ast27x0: Add HACE support for AST2700
>    hw/misc/aspeed_hace: (DROP) Fix boot issue in the Crypto Manager Self
>      Test(WORKAROUND)
> 
>   hw/arm/aspeed.c               |  26 +-
>   hw/arm/aspeed_ast27x0.c       | 229 +++++++++--
>   hw/intc/aspeed_intc.c         | 689 +++++++++++++++++++++++++---------
>   hw/intc/trace-events          |  25 +-
>   hw/misc/aspeed_hace.c         |  44 ++-
>   hw/misc/aspeed_scu.c          |   3 +
>   include/hw/arm/aspeed_soc.h   |   5 +-
>   include/hw/intc/aspeed_intc.h |  35 +-
>   include/hw/misc/aspeed_hace.h |   1 +
>   include/hw/misc/aspeed_scu.h  |   2 +
>   10 files changed, 817 insertions(+), 242 deletions(-)
> 



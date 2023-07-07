Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0095174B30C
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 16:29:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHmSY-00048S-QC; Fri, 07 Jul 2023 10:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHmSV-00047T-4r; Fri, 07 Jul 2023 10:29:19 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHmSR-0001oj-P6; Fri, 07 Jul 2023 10:29:18 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6b72c4038b6so1797952a34.0; 
 Fri, 07 Jul 2023 07:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688740153; x=1691332153;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SQNVQCbwXjGKbu1xnUtQQPxkUnMDuTykR+M9botOCko=;
 b=Z536qvhAK9KIfzc2iYEy594w4mMUFW8OV/LebmukVeoKYIEm/ZgwubGkBvTnusC4Az
 Wqn7B64++LAkmNeuMqp2JZA0aqUShXjYj86LqfH2FFaTRxwSqKdUxYBUOk4LXh4RmFum
 yAA/upnW43Zh2OLDePXN7EcvfGU0Ce0NMVpbVA3DL+HRXeAlMZ9uwPDza4D05aJpEyli
 4Q6YsxIk7HyMnpI/ONiU2yYzNum+qvTUVb0ExO/y+PTXO/he/2Uy7zbf3fVbeEeF6H0s
 Z52cb9/2pjjPMn78I6KQOG5c1FN4MUri1bHarvZCdbwW9gcQTBUwAGKvCcsd80FMByTn
 F9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688740153; x=1691332153;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SQNVQCbwXjGKbu1xnUtQQPxkUnMDuTykR+M9botOCko=;
 b=gLdR/0SRzecrfh1UTmeAdCNLKuLeOpzQGoC2a+f648SA6ICFozEkQIHVB95KJmWK/P
 oXNCnSPzOMf1gGC5Hx7mxeX9ezPclYQ1zixJCG50RV7PmNaZMbG+GPQzu4HuJNjV6tYE
 nRH+cATJWFRXmQoqPj1zoBsl4tK5a/8186uUkkIMJ2rK9nTmmMBAmmv/of5nJccT8n0N
 ExCgtfMGaAdHz7fvIC/SlL2UlBOXP6Bev5zGDDHLEmCHvSnOrsVS7VRGkBTN+t334L64
 8kVr6csY+w5MAHHjL+xAdhfySpXHE02udYnJltoLUzsvwSHKsd8QKr1LMjXc7Xvfv+7S
 UB6w==
X-Gm-Message-State: ABy/qLbiRAV3XcOql4hranLsXMwg/9UOJeRkeSMitvBHYOopDLPP8Veg
 MlmHpZ7OHYf7LewlQjG0O3tBpNufF1Q=
X-Google-Smtp-Source: APBJJlEBI7is8+So/f58sfUMpb48kd+PpvG7a9YaFksXgAil/sP2+RdbMskVUpYvzrzJI6a9mAAYzg==
X-Received: by 2002:a9d:7e8c:0:b0:6b8:8085:64d with SMTP id
 m12-20020a9d7e8c000000b006b88085064dmr5671521otp.5.1688740153127; 
 Fri, 07 Jul 2023 07:29:13 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-19.dial-up.telesp.net.br.
 [201.69.66.19]) by smtp.gmail.com with ESMTPSA id
 z23-20020a0568301db700b006b8b8c7be2bsm1684488oti.81.2023.07.07.07.29.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 07:29:12 -0700 (PDT)
Message-ID: <6c3157e1-a2fc-ce86-a81f-22f2ec10e2cd@gmail.com>
Date: Fri, 7 Jul 2023 11:29:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL 00/60] ppc queue
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, peter.maydell@linaro.org, richard.henderson@linaro.org
References: <20230707113108.7145-1-danielhb413@gmail.com>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20230707113108.7145-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.092,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter, Richard,


Please hold this PR. I'm sending a v2. Patch 60/60 will be dropped.


Thanks,


Daniel

On 7/7/23 08:30, Daniel Henrique Barboza wrote:
> The following changes since commit 97c81ef4b8e203d9620fd46e7eb77004563e3675:
> 
>    Merge tag 'pull-9p-20230706' of https://github.com/cschoenebeck/qemu into staging (2023-07-06 18:19:42 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/danielhb/qemu.git tags/pull-ppc-20230707
> 
> for you to fetch changes up to 2f8ebb98ef8c7e85b23678812d8a7a95c9479673:
> 
>    ppc: Enable 2nd DAWR support on p10 (2023-07-07 06:33:04 -0300)
> 
> ----------------------------------------------------------------
> ppc patch queue for 2023-07-07:
> 
> In this last queue for 8.1 we have a lot of fixes and improvements all
> around: SMT support for powerNV, XIVE fixes, PPC440 cleanups, exception
> handling cleanups and kvm_pph.h cleanups just to name a few.
> 
> Thanks everyone in the qemu-ppc community for all the contributions for
> the next QEMU release.
> 
> ----------------------------------------------------------------
> BALATON Zoltan (22):
>        mv64361: Add dummy gigabit ethernet PHY access registers
>        target/ppc: Remove some superfluous parentheses
>        target/ppc: Remove unneeded parameter from powerpc_reset_wakeup()
>        target/ppc: Move common check in exception handlers to a function
>        target/ppc: Remove some more local CPUState variables only used once
>        target/ppd: Remove unused define
>        target/ppc: Get CPUState in one step
>        ppc/pegasos2: Add support for -initrd command line option
>        ppc440: Change ppc460ex_pcie_init() parameter type
>        ppc440: Add cpu link property to PCIe controller model
>        ppc440: Add a macro to shorten PCIe controller DCR registration
>        ppc440: Rename parent field of PPC460EXPCIEState to match code style
>        ppc440: Rename local variable in dcr_read_pcie()
>        ppc440: Stop using system io region for PCIe buses
>        ppc440: Add busnum property to PCIe controller model
>        ppc440: Remove ppc460ex_pcie_init legacy init function
>        ppc/sam460ex: Remove address_space_mem local variable
>        ppc440_pcix: Don't use iomem for regs
>        ppc440_pcix: Stop using system io region for PCI bus
>        ppc4xx_pci: Rename QOM type name define
>        ppc4xx_pci: Add define for ppc4xx-host-bridge type name
>        ppc440_pcix: Rename QOM type define abd move it to common header
> 
> Frederic Barrat (8):
>        pnv/psi: Allow access to PSI registers through xscom
>        pnv/xive2: Allow indirect TIMA accesses of all sizes
>        pnv/xive2: Fix TIMA offset for indirect access
>        pnv/xive: Add property on xive sources to define PQ state on reset
>        pnv/psi: Initialize the PSIHB interrupts to match hardware
>        pnv/xive: Allow mmio operations of any size on the ESB CI pages
>        pnv/xive: Print CPU target in all TIMA traces
>        pnv/xive2: Always pass a presenter object when accessing the TIMA
> 
> Joel Stanley (7):
>        ppc/pnv: quad xscom callbacks are P9 specific
>        ppc/pnv: Subclass quad xscom callbacks
>        ppc/pnv: Add P10 quad xscom model
>        ppc/pnv: Add P10 core xscom model
>        ppc/pnv: Return zero for core thread state xscom
>        ppc/pnv: Log all unimp warnings with similar message
>        ppc/pnv: Add QME region for P10
> 
> Narayana Murty N (1):
>        target: ppc: Use MSR_HVB bit to get the target endianness for memory dump
> 
> Nicholas Piggin (14):
>        target/ppc: Make HDECR underflow edge triggered
>        hw/ppc: Fix clock update drift
>        target/ppc: Tidy POWER book4 SPR registration
>        target/ppc: Add TFMR SPR implementation with read and write helpers
>        sungem: Add WOL MMIO
>        target/ppc: Fix icount access for some hypervisor instructions
>        tests/avocado: record_replay test for ppc powernv machine
>        target/ppc: Add LPAR-per-core vs per-thread mode flag
>        target/ppc: SMT support for the HID SPR
>        ppc/pnv: SMT support for powernv
>        tests/avocado: Add powernv machine test script
>        ppc/pnv: Set P10 core xscom region size to match hardware
>        tests/qtest: Add xscom tests for powernv10 machine
>        target/ppc: Machine check on invalid real address access on POWER9/10
> 
> Philippe Mathieu-Daudé (7):
>        target/ppc: Only generate decodetree files when TCG is enabled
>        target/ppc: Have 'kvm_ppc.h' include 'sysemu/kvm.h'
>        target/ppc: Reorder #ifdef'ry in kvm_ppc.h
>        target/ppc: Move CPU QOM definitions to cpu-qom.h
>        target/ppc: Define TYPE_HOST_POWERPC_CPU in cpu-qom.h
>        target/ppc: Restrict 'kvm_ppc.h' to sysemu in cpu_init.c
>        target/ppc: Remove pointless checks of CONFIG_USER_ONLY in 'kvm_ppc.h'
> 
> Ravi Bangoria (1):
>        ppc: Enable 2nd DAWR support on p10
> 
>   docs/system/ppc/powernv.rst    |   5 -
>   hw/intc/pnv_xive2.c            |  26 +++-
>   hw/intc/trace-events           |   4 +-
>   hw/intc/xive.c                 |  20 +--
>   hw/intc/xive2.c                |   4 +-
>   hw/net/sungem.c                |  52 ++++++++
>   hw/net/trace-events            |   2 +
>   hw/pci-host/mv64361.c          |   6 +
>   hw/pci-host/mv643xx.h          |   3 +
>   hw/ppc/pegasos2.c              |  32 ++++-
>   hw/ppc/pnv.c                   |  26 +++-
>   hw/ppc/pnv_core.c              | 282 ++++++++++++++++++++++++++++++++++-------
>   hw/ppc/pnv_psi.c               |  33 +++--
>   hw/ppc/ppc.c                   |  49 +++----
>   hw/ppc/ppc440.h                |   1 -
>   hw/ppc/ppc440_bamboo.c         |   3 +-
>   hw/ppc/ppc440_pcix.c           |  28 ++--
>   hw/ppc/ppc440_uc.c             | 192 ++++++++++++----------------
>   hw/ppc/ppc4xx_pci.c            |  10 +-
>   hw/ppc/sam460ex.c              |  33 +++--
>   hw/ppc/spapr.c                 |   7 +-
>   hw/ppc/spapr_caps.c            |  32 +++++
>   hw/ppc/spapr_cpu_core.c        |   2 +
>   include/hw/ppc/pnv_core.h      |  18 ++-
>   include/hw/ppc/pnv_xscom.h     |  15 ++-
>   include/hw/ppc/ppc4xx.h        |   5 +-
>   include/hw/ppc/spapr.h         |   6 +-
>   include/hw/ppc/xive.h          |   1 +
>   target/ppc/arch_dump.c         |   2 +-
>   target/ppc/cpu-qom.h           |   6 +
>   target/ppc/cpu.h               |   9 +-
>   target/ppc/cpu_init.c          | 112 ++++++++++++----
>   target/ppc/excp_helper.c       | 206 ++++++++++++++----------------
>   target/ppc/helper.h            |   3 +
>   target/ppc/internal.h          |   5 +
>   target/ppc/kvm.c               |  12 ++
>   target/ppc/kvm_ppc.h           |  82 ++++++------
>   target/ppc/meson.build         |   2 +-
>   target/ppc/misc_helper.c       |  29 +++++
>   target/ppc/spr_common.h        |   3 +
>   target/ppc/timebase_helper.c   |  13 ++
>   target/ppc/translate.c         |  45 ++++++-
>   tests/avocado/ppc_powernv.py   |  87 +++++++++++++
>   tests/avocado/replay_kernel.py |  17 +++
>   tests/qtest/pnv-xscom-test.c   |  45 +++++--
>   45 files changed, 1123 insertions(+), 452 deletions(-)
>   create mode 100644 tests/avocado/ppc_powernv.py


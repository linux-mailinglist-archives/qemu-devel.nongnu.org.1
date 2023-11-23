Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 283347F64ED
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 18:10:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6DCw-0002EN-6D; Thu, 23 Nov 2023 12:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=WthQ=HE=kaod.org=clg@ozlabs.org>)
 id 1r6DCu-0002CG-4D; Thu, 23 Nov 2023 12:09:40 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=WthQ=HE=kaod.org=clg@ozlabs.org>)
 id 1r6DCs-0007gY-1j; Thu, 23 Nov 2023 12:09:39 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Sbl3001qkz4xRj;
 Fri, 24 Nov 2023 04:09:32 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sbl2x1SmKz4xR5;
 Fri, 24 Nov 2023 04:09:28 +1100 (AEDT)
Message-ID: <18517c0b-f928-4bbc-b31c-8dfdfefdea31@kaod.org>
Date: Thu, 23 Nov 2023 18:09:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] ppc: pnv ChipTOD and various timebase fixes
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 qemu-devel@nongnu.org
References: <20231123103018.172383-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20231123103018.172383-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=WthQ=HE=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 11/23/23 11:30, Nicholas Piggin wrote:
> The chiptod/TFMR/state machine is not really tied to the other
> time register fixes, but they touch some of the same code, and
> logically same facility.
> 
> Changes since v1 of chiptod patches:
> - Split hackish ChipTOD<->TFMR/TBST interface into its own patch
> - Fix multi-socket addressing on P9 / chip ID mode (P10 works)
> - Change chiptod primary/secondary setting to use class properties
> - Add more comments to explain TOD overview and timebase state
>    machine.
> - SMT support for TFMR, some functionality is limited to thread 0.
> - FIRMWARE_CONTROL_ERROR bit implemented in TFMR.
> - Misc cleanups and bug fixes.
> 
> The hacky part, addressing core from chiptod, is still hacky. Is
> there strong objection to it?

Dunno yet :)

> This successfully runs skiboot chiptod initialisation code with
> POWER9 and POWER10 multi-socket, multi-core, SMT. That requires
> skiboot 7.1 (not in-tree), otherwise chiptod init is skipped on
> QEMU machines.

Let's update skiboot at the same time then.

Thanks,

C.

> 
> Thanks,
> Nick
> 
> Nicholas Piggin (7):
>    target/ppc: Rename TBL to TB on 64-bit
>    target/ppc: Improve timebase register defines naming
>    target/ppc: Fix move-to timebase SPR access permissions
>    pnv/chiptod: Add POWER9/10 chiptod model
>    pnv/chiptod: Implement the ChipTOD to Core transfer
>    target/ppc: Implement core timebase state machine and TFMR
>    target/ppc: Add SMT support to time facilities
> 
>   include/hw/ppc/pnv_chip.h    |   3 +
>   include/hw/ppc/pnv_chiptod.h |  55 ++++
>   include/hw/ppc/pnv_core.h    |   4 +
>   include/hw/ppc/pnv_xscom.h   |   9 +
>   target/ppc/cpu.h             |  50 +++-
>   hw/ppc/pnv.c                 |  63 +++++
>   hw/ppc/pnv_chiptod.c         | 509 +++++++++++++++++++++++++++++++++++
>   target/ppc/helper_regs.c     |  39 ++-
>   target/ppc/ppc-qmp-cmds.c    |   4 +
>   target/ppc/timebase_helper.c | 309 ++++++++++++++++++++-
>   target/ppc/translate.c       |  42 ++-
>   hw/ppc/meson.build           |   1 +
>   hw/ppc/trace-events          |   4 +
>   13 files changed, 1067 insertions(+), 25 deletions(-)
>   create mode 100644 include/hw/ppc/pnv_chiptod.h
>   create mode 100644 hw/ppc/pnv_chiptod.c
> 



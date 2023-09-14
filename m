Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 696AA7A01D6
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 12:40:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgjkG-0005jO-2X; Thu, 14 Sep 2023 06:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgjkD-0005Xv-BW
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:38:45 -0400
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1qgjkB-0005qe-UI
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 06:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:Reply-To:MIME-Version:Date:Message-ID:Sender:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Y8BadgFzqBhWSa1uekObvZ1nz7/bRW1kEw3wnUXXlUM=; b=gMdmi9k7OZLknG3dB+R6q+/3AZ
 oYjPERm0eidZ2BCbK06CZlvpETtF8yAk5UR2bHTPZBh1sSSQ4h8BRicPf4wjDTELsgUjxZd7lLOre
 uoGJN0hOJbFyYxJl5WJBmNOPmNwCiB7s/FSCKx2of2pjYNuMtk2VAJz2f8bLEIrzvsZY=;
Message-ID: <cd99c4d3-fd85-4c37-8b08-64a66b728e5f@rev.ng>
Date: Thu, 14 Sep 2023 12:38:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/24] accel/tcg: Replace CPUState.env_ptr with
 cpu_env()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20230914024435.1381329-1-richard.henderson@linaro.org>
 <20230914024435.1381329-14-richard.henderson@linaro.org>
Organization: rev.ng
In-Reply-To: <20230914024435.1381329-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  anjo@rev.ng
X-ACL-Warn: ,  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org


On 9/14/23 04:44, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/cpu-all.h               |  1 -
>   include/hw/core/cpu.h                |  9 ++++++---
>   target/arm/common-semi-target.h      |  2 +-
>   accel/tcg/cpu-exec.c                 |  8 ++++----
>   accel/tcg/cputlb.c                   | 18 +++++++++---------
>   accel/tcg/translate-all.c            |  4 ++--
>   gdbstub/gdbstub.c                    |  4 ++--
>   gdbstub/user-target.c                |  2 +-
>   hw/i386/kvm/clock.c                  |  2 +-
>   hw/intc/mips_gic.c                   |  2 +-
>   hw/intc/riscv_aclint.c               | 12 ++++++------
>   hw/intc/riscv_imsic.c                |  2 +-
>   hw/ppc/e500.c                        |  4 ++--
>   hw/ppc/spapr.c                       |  2 +-
>   linux-user/elfload.c                 |  4 ++--
>   linux-user/i386/cpu_loop.c           |  2 +-
>   linux-user/main.c                    |  4 ++--
>   linux-user/signal.c                  | 15 +++++++--------
>   monitor/hmp-cmds-target.c            |  2 +-
>   semihosting/arm-compat-semi.c        |  6 +++---
>   semihosting/syscalls.c               | 28 ++++++++++++++--------------
>   target/alpha/translate.c             |  4 ++--
>   target/arm/cpu.c                     |  8 ++++----
>   target/arm/helper.c                  |  2 +-
>   target/arm/tcg/translate-a64.c       |  4 ++--
>   target/arm/tcg/translate.c           |  6 +++---
>   target/avr/translate.c               |  2 +-
>   target/cris/translate.c              |  4 ++--
>   target/hexagon/translate.c           |  4 ++--
>   target/hppa/mem_helper.c             |  2 +-
>   target/hppa/translate.c              |  4 ++--
>   target/i386/tcg/sysemu/excp_helper.c |  2 +-
>   target/i386/tcg/tcg-cpu.c            |  2 +-
>   target/i386/tcg/translate.c          |  4 ++--
>   target/loongarch/translate.c         |  4 ++--
>   target/m68k/translate.c              |  4 ++--
>   target/microblaze/translate.c        |  2 +-
>   target/mips/tcg/sysemu/mips-semi.c   |  4 ++--
>   target/mips/tcg/translate.c          |  4 ++--
>   target/nios2/translate.c             |  4 ++--
>   target/openrisc/translate.c          |  2 +-
>   target/ppc/excp_helper.c             | 10 +++++-----
>   target/ppc/translate.c               |  4 ++--
>   target/riscv/translate.c             |  6 +++---
>   target/rx/cpu.c                      |  3 ---
>   target/rx/translate.c                |  2 +-
>   target/s390x/tcg/translate.c         |  2 +-
>   target/sh4/op_helper.c               |  2 +-
>   target/sh4/translate.c               |  4 ++--
>   target/sparc/translate.c             |  4 ++--
>   target/tricore/translate.c           |  4 ++--
>   target/xtensa/translate.c            |  4 ++--
>   target/i386/tcg/decode-new.c.inc     |  2 +-
>   53 files changed, 125 insertions(+), 127 deletions(-)
Reviewed-by: Anton Johansson <anjo@rev.ng>


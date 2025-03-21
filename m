Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D25A6BD0B
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Mar 2025 15:35:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvdSC-000391-5u; Fri, 21 Mar 2025 10:34:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tvdS9-00038c-MZ
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:34:30 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1tvdS5-000553-S3
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 10:34:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=X9tsZldLslFZldfnyo6JC3GgBpLTgjlzSWQ4D19Iguw=; b=upVZMQM0FtpFlPQ
 WFD290GkPEk5+ojFwAC2FVq8I+afyRocSHKC/aohPdV4N5qwmTL4PoAWXS2t0d4NGfJMThE2YYbD4
 2n8lflK80zudxWGgp05m84IQkIUi+MUSkSuhkiht5b9jRwjbotRXM0upQ0Nbmd4PV8nZUBEgcS5Zt
 Yw=;
Date: Fri, 21 Mar 2025 15:34:45 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH-for-10.1 4/4] tcg: Define guest_default_memory_order
 in TCGCPUOps
Message-ID: <un6e6dztt4uwuqywzt74s4fhnbx3nxhh3syfgode7lnkboe6l6@whsyzuebi4w6>
References: <20250321125737.72839-1-philmd@linaro.org>
 <20250321125737.72839-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321125737.72839-5-philmd@linaro.org>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 21/03/25, Philippe Mathieu-Daudé wrote:
> Add the TCGCPUOps::guest_default_memory_order field and have
> each target initialize it.
> 
> Use it to set TCGContext::guest_mo in tb_gen_code(), removing
> the need for the TCG_GUEST_DEFAULT_MO definition.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/accel/tcg/cpu-ops.h   |  8 ++++++++
>  target/alpha/cpu-param.h      |  3 ---
>  target/arm/cpu-param.h        |  3 ---
>  target/avr/cpu-param.h        |  2 --
>  target/hexagon/cpu-param.h    |  3 ---
>  target/hppa/cpu-param.h       |  8 --------
>  target/i386/cpu-param.h       |  3 ---
>  target/loongarch/cpu-param.h  |  2 --
>  target/m68k/cpu-param.h       |  3 ---
>  target/microblaze/cpu-param.h |  3 ---
>  target/mips/cpu-param.h       |  2 --
>  target/openrisc/cpu-param.h   |  2 --
>  target/ppc/cpu-param.h        |  2 --
>  target/riscv/cpu-param.h      |  2 --
>  target/rx/cpu-param.h         |  3 ---
>  target/s390x/cpu-param.h      |  6 ------
>  target/sh4/cpu-param.h        |  3 ---
>  target/sparc/cpu-param.h      | 23 -----------------------
>  target/tricore/cpu-param.h    |  3 ---
>  target/xtensa/cpu-param.h     |  3 ---
>  accel/tcg/translate-all.c     |  2 +-
>  target/alpha/cpu.c            |  3 +++
>  target/arm/cpu.c              |  3 +++
>  target/arm/tcg/cpu-v7m.c      |  3 +++
>  target/avr/cpu.c              |  1 +
>  target/hexagon/cpu.c          |  2 ++
>  target/hppa/cpu.c             |  8 ++++++++
>  target/i386/tcg/tcg-cpu.c     |  5 +++++
>  target/loongarch/cpu.c        |  2 ++
>  target/m68k/cpu.c             |  3 +++
>  target/microblaze/cpu.c       |  3 +++
>  target/mips/cpu.c             |  2 ++
>  target/openrisc/cpu.c         |  2 ++
>  target/ppc/cpu_init.c         |  2 ++
>  target/riscv/tcg/tcg-cpu.c    |  2 ++
>  target/rx/cpu.c               |  3 +++
>  target/s390x/cpu.c            |  6 ++++++
>  target/sh4/cpu.c              |  3 +++
>  target/sparc/cpu.c            | 23 +++++++++++++++++++++++
>  target/tricore/cpu.c          |  2 ++
>  target/xtensa/cpu.c           |  3 +++
>  41 files changed, 90 insertions(+), 80 deletions(-)

This is a nice change!:)

Reviewed-by: Anton Johansson <anjo@rev.ng>


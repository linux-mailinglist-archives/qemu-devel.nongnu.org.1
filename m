Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 609B8838E38
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 13:12:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSFda-0005An-M3; Tue, 23 Jan 2024 07:12:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSFdU-00059o-Ex
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 07:12:12 -0500
Received: from rev.ng ([5.9.113.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1rSFdS-0008Op-7s
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 07:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RFCEqXaYsbjfE3WI5hBYmaEDPRym06irZuJpcai79l0=; b=MSX7Ef6JbTg8Hh8rbruOBNwCKZ
 qnhgqZPE00WsSc/oGB3Z1BQUg9wStK9+8WccuqxGQ6/U5Qy6m6aZpRft3rZU+Ko8smHKlJusrxpFO
 sYCpV85QDEyR8nIyVgH97bIcyerkfrx4KKZOxdHrRq9QlYxaqjfY7aw/pPsAXyv6Un2w=;
Date: Tue, 23 Jan 2024 13:12:17 +0100
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, ale@rev.ng, richard.henderson@linaro.org
Subject: Re: [RFC PATCH 26/34] Wrap target macros in functions
Message-ID: <n2u2ifeti6fqzppvojuyi4i4phzrb4xbk3x2rpjhhesnwxwbdy@lmf3m6fqcr7g>
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-27-anjo@rev.ng>
 <a69519cf-27f6-479e-9ec6-ff7e11454c90@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a69519cf-27f6-479e-9ec6-ff7e11454c90@linaro.org>
Received-SPF: pass client-ip=5.9.113.41; envelope-from=anjo@rev.ng; helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 23/01/24, Philippe Mathieu-Daudé wrote:
> Hi Anton,
> 
> On 19/1/24 15:40, Anton Johansson wrote:
> > Adds wrapper functions around common target specific macros required by
> > accel/tcg.
> > 
> > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > ---
> >   include/hw/core/cpu.h |  9 +++++++
> >   cpu-target.c          | 62 +++++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 71 insertions(+)
> > 
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index 57d100c203..a2d65c1d7a 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -26,6 +26,7 @@
> >   #include "exec/vaddr.h"
> >   #include "exec/memattrs.h"
> >   #include "exec/tlb-common.h"
> > +#include "exec/memop.h"
> >   #include "qapi/qapi-types-run-state.h"
> >   #include "qemu/bitmap.h"
> >   #include "qemu/rcu_queue.h"
> > @@ -1164,6 +1165,14 @@ void cpu_exec_unrealizefn(CPUState *cpu);
> >    * what you are doing!
> >    */
> >   bool target_words_bigendian(void);
> > +bool target_supports_mttcg(void);
> > +bool target_has_precise_smc(void);
> > +int target_long_bits(void);
> > +int target_phys_addr_space_bits(void);
> > +uint8_t target_insn_start_words(void);
> > +uint8_t target_default_memory_order(void);
> > +uint8_t target_tlb_dyn_max_bits(void);
> > +MemOp target_endian_memory_order(void);
> 
> None of these helpers take argument. I don't understand
> how they can be called in heterogeneous context.

No you're right, I was focused mostly on getting accel/tcg to compile 
with hetrogeneous being a goal downt the line.

I like the idea of moving these fields to a struct filled out per 
target, but dispatching would also work.


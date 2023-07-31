Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A679D7695A4
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 14:09:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQRhc-00088E-2q; Mon, 31 Jul 2023 08:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qQRhR-00087Q-87; Mon, 31 Jul 2023 08:08:33 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qQRhO-0004RV-Lp; Mon, 31 Jul 2023 08:08:32 -0400
Received: from [10.12.102.111] (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 74F0240F1DD4;
 Mon, 31 Jul 2023 12:08:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 74F0240F1DD4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1690805306;
 bh=sw9x57e68bXy8A1k+jfYnFxYocjBlVBO4s5sW7fG13A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ibEEzlEOMVsCkf5ugeP/cfg9h+9BH4HFAbLtlDE4bowsV3H61D92FGO87XfWJhhI7
 6fEpfNa0cQhcurwI9AuEhz6E1qszwUYTL+/1p752aKLYU2S5k5deQLp8N2sPiWMJ3g
 z66d33LjvmSlqk4HtaqsDYZIMX2gzsOeMBuJPktY=
Message-ID: <402d4e1c-9634-cc3e-a11b-06044fbbecb5@ispras.ru>
Date: Mon, 31 Jul 2023 15:08:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6/7] tests/avocado: reverse-debugging cope with
 re-executing breakpoints
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230726183532.434380-1-npiggin@gmail.com>
 <20230726183532.434380-7-npiggin@gmail.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20230726183532.434380-7-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>

On 26.07.2023 21:35, Nicholas Piggin wrote:
> The reverse-debugging test creates a trace, then replays it and:
> 
> 1. Steps the first 10 instructions and records their addresses.
> 2. Steps backward and verifies their addresses match.
> 3. Runs to (near) the end of the trace.
> 4. Sets breakpoints on the first 10 instructions.
> 5. Continues backward and verifies execution stops at the last
>     breakpoint.
> 
> Step 5 breaks if any of the other 9 breakpoints are re-executed in the
> trace after the 10th instruction is run, because those will be
> unexpectedly hit when reverse continuing. This situation does arise
> with the ppc pseries machine, the SLOF bios branches to its own entry
> point.
> 
> Permit this breakpoint re-execution by switching steps 4 and 5, so that
> the trace will be run to the end *or* the next breakpoint hit.
> Reversing from there to the 10th intsruction will not hit another
> breakpoint, by definition.
> 
> Another step is added between steps 2 and 3, which steps forward over
> the first 10 instructions and verifies their addresses, to support this.
> 
> Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   tests/avocado/reverse_debugging.py | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
> index 680c314cfc..7d1a478df1 100644
> --- a/tests/avocado/reverse_debugging.py
> +++ b/tests/avocado/reverse_debugging.py
> @@ -150,16 +150,33 @@ def reverse_debugging(self, shift=7, args=None):
>               self.check_pc(g, addr)
>               logger.info('found position %x' % addr)
>   
> -        logger.info('seeking to the end (icount %s)' % (last_icount - 1))
> -        vm.qmp('replay-break', icount=last_icount - 1)
> -        # continue - will return after pausing
> -        g.cmd(b'c', b'T02thread:01;')
> +        # visit the recorded instruction in forward order
> +        logger.info('stepping forward')
> +        for addr in steps:
> +            self.check_pc(g, addr)
> +            self.gdb_step(g)
> +            logger.info('found position %x' % addr)
>   
> +        # set breakpoints for the instructions just stepped over
>           logger.info('setting breakpoints')
>           for addr in steps:
>               # hardware breakpoint at addr with len=1
>               g.cmd(b'Z1,%x,1' % addr, b'OK')
>   
> +        # this may hit a breakpoint if first instructions are executed
> +        # again
> +        logger.info('continuing execution')
> +        vm.qmp('replay-break', icount=last_icount - 1)
> +        # continue - will return after pausing
> +        # This could stop at the end and get a T02 return, or by
> +        # re-executing one of the breakpoints and get a T05 return.
> +        g.cmd(b'c')
> +        if self.vm_get_icount(vm) == last_icount - 1:
> +            logger.info('reached the end (icount %s)' % (last_icount - 1))
> +        else:
> +            logger.info('hit a breakpoint again at %x (icount %s)' %
> +                        (self.get_pc(g), self.vm_get_icount(vm)))
> +
>           logger.info('running reverse continue to reach %x' % steps[-1])
>           # reverse continue - will return after stopping at the breakpoint
>           g.cmd(b'bc', b'T05thread:01;')



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4367330C7
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 14:07:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA8D7-0001gr-Dw; Fri, 16 Jun 2023 08:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1qA8Cz-0001gZ-8w
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 08:05:41 -0400
Received: from forward500c.mail.yandex.net ([2a02:6b8:c03:500:1:45:d181:d500])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viktor.prutyanov@phystech.edu>)
 id 1qA8Cx-00089H-2k
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 08:05:41 -0400
Received: from mail-nwsmtp-mxback-production-main-85.iva.yp-c.yandex.net
 (mail-nwsmtp-mxback-production-main-85.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:b9d:0:640:3b4f:0])
 by forward500c.mail.yandex.net (Yandex) with ESMTP id 6260F5EE92;
 Fri, 16 Jun 2023 15:05:32 +0300 (MSK)
Received: from mail.yandex.ru (2a02:6b8:c0c:2994:0:640:e6a:0
 [2a02:6b8:c0c:2994:0:640:e6a:0])
 by mail-nwsmtp-mxback-production-main-85.iva.yp-c.yandex.net (mxback/Yandex)
 with HTTP id R5cpKa1W6a60-9t5UcV0b; Fri, 16 Jun 2023 15:05:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phystech.edu; s=mail;
 t=1686917131; bh=xf5nRXnuDjCt9CdW4lshA44zlhMobXtFeeIFiQEJBrI=;
 h=Message-Id:References:Date:Cc:Subject:In-Reply-To:To:From;
 b=VR67dobPpT7HdLVKclDgrvBu9dFWMwSQC+J23CKoDZkUwomcnfCyyIEP521ZP387w
 FLPSnrK+F6bZNd/cKPsOe+x8XTGhSjQo6nIYwKL1mrRNB3MGunUoeIsoxbl7wPdQab
 8B9OcP3La3uiVCkvg24rfg17ZyZDO8aEONu0MBY4=
Authentication-Results: mail-nwsmtp-mxback-production-main-85.iva.yp-c.yandex.net;
 dkim=pass header.i=@phystech.edu
Received: by duepvdwsa5dpfj2m.iva.yp-c.yandex.net with HTTP;
 Fri, 16 Jun 2023 15:05:31 +0300
From: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,
	Viktor Prutyanov <viktor@daynix.com>
In-Reply-To: <f1e462f7-67bc-2a4d-72f9-a5a4641d05ce@daynix.com>
References: <20230611033434.14659-1-akihiko.odaki@daynix.com>
 <260451686566561@lduixalyeduyxu6q.myt.yp-c.yandex.net>
 <f1e462f7-67bc-2a4d-72f9-a5a4641d05ce@daynix.com>
Subject: Re: [PATCH] elf2dmp: Don't abandon when Prcb is set to 0
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Fri, 16 Jun 2023 15:05:31 +0300
Message-Id: <5455341686917131@duepvdwsa5dpfj2m.iva.yp-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:d500;
 envelope-from=viktor.prutyanov@phystech.edu; helo=forward500c.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> On 2023/06/12 12:42, Viktor Prutyanov wrote:
> 
>>> Prcb may be set to 0 for some CPUs if the dump was taken before they
>>> start. The dump may still contain valuable information for started CPUs
>>> so don't abandon conversion in such a case.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>> contrib/elf2dmp/main.c | 5 +++++
>>> 1 file changed, 5 insertions(+)
>>>
>>> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
>>> index d77b8f98f7..91c58e4424 100644
>>> --- a/contrib/elf2dmp/main.c
>>> +++ b/contrib/elf2dmp/main.c
>>> @@ -312,6 +312,11 @@ static int fill_context(KDDEBUGGER_DATA64 *kdbg,
>>> return 1;
>>> }
>>>
>>> + if (!Prcb) {
>>> + eprintf("Context for CPU #%d is missing\n", i);
>>> + continue;
>>> + }
>>> +
>>> if (va_space_rw(vs, Prcb + kdbg->OffsetPrcbContext,
>>> &Context, sizeof(Context), 0)) {
>>> eprintf("Failed to read CPU #%d ContextFrame location\n", i);
>>>
>>> --
>>> 2.40.1
>>
>> Hi Akihiko,
>>
>> How this fix can be tested?
> 
> It is a bit difficult to test it as you need to interrupt the very early
> stage of boot. I applied the following change to TCG so that it stops
> immediately after the first processor configures Prcb.
> 
> diff --git a/target/i386/tcg/sysemu/misc_helper.c
> b/target/i386/tcg/sysemu/misc_helper.c
> index e1528b7f80..f68eba9cac 100644
> --- a/target/i386/tcg/sysemu/misc_helper.c
> +++ b/target/i386/tcg/sysemu/misc_helper.c
> @@ -25,6 +25,9 @@
> #include "exec/address-spaces.h"
> #include "exec/exec-all.h"
> #include "tcg/helper-tcg.h"
> +#include "exec/gdbstub.h"
> +#include "hw/core/cpu.h"
> +#include "sysemu/runstate.h"
> 
> void helper_outb(CPUX86State *env, uint32_t port, uint32_t data)
> {
> @@ -217,7 +220,10 @@ void helper_wrmsr(CPUX86State *env)
> env->segs[R_FS].base = val;
> break;
> case MSR_GSBASE:
> + printf("%s: %" PRIx64 "\n", __func__, val);
> env->segs[R_GS].base = val;
> + gdb_set_stop_cpu(current_cpu);
> + vm_stop(RUN_STATE_PAUSED);
> break;
> case MSR_KERNELGSBASE:
> env->kernelgsbase = val;
> 
>> NumberProcessors field is still set to qemu_elf.state_nr, how does WinDbg react to this?
> 
> If Prcb for processor 1 is missing, WinDbg outputs: KiProcessorBlock[1]
> is null.
> You can still debug the started processors with no issue.
> 
> Regards,
> Akihiko Odaki
> 
>> Viktor

Reviewed-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>


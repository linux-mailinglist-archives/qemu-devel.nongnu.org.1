Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64103769300
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 12:21:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQQ1e-0006Xf-Np; Mon, 31 Jul 2023 06:21:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQQ1c-0006XV-Q8
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:21:16 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQQ1b-00064u-55
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 06:21:16 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5222bc91838so6529613a12.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 03:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690798873; x=1691403673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h9dSHzmWlzhVKHC2EFq7b6v+fJY9VFqkVoDQgs8Ym3A=;
 b=fnTJjKcfujoi90Zk2goOwynNdy5mm+ezHOXYot8F2ZrAGfRtrf0hWY4RIUcTyOge6H
 jRhSs+VQE4N+a0npq/cQ4jfEBaDJJshlF/hxaMA3CNTlX4gzjrlObtg4JRDxRHEijyIl
 o3O0jQbB5YC81eynURHnCTlcbCqk0HZvmwt8hEoktXkYUW6PPsFNFpvLMogOKIslBTkC
 /eQXnBbEXe9BVwHLsyiSOtoIpAEill9tM4+6dPiSRDSivZON0bnUQ0GGmBmG98rnzHmv
 6ShTgT5deacnnY/SqF8d7P+0P8m4AxVy7o+2fqNo7TgmuFB0+XLW0uo00k7LovmwJRU1
 d47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690798873; x=1691403673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h9dSHzmWlzhVKHC2EFq7b6v+fJY9VFqkVoDQgs8Ym3A=;
 b=hJLK/dVN5AcJyuwymrWsGDH1TQ3kv4sP/vWZSnpR9YS6CLxws9bKAJ7EuLre5Yzs1W
 tioUqxHwk/D5gxzstVUUlpke4nDjvWqttRNunmgRb1dfl9PGd7xNnhGOkOXj0M1fAa6W
 14aFCFDCehbEYHR4yT4fal0HbQF0RbBO0v/70Jhs3ikpfe8CMPW3p6xoJBp6Y1hQ2mJG
 xq+OfLZTjdJSvoTaRbk+Flvo7yR4X8Hu5fqsx6QMqIEDrgRVbgFeEGu3Uyn/nRFXVq5h
 VSd7WXA7FTAGH1z0qjGYeYVtmFdwpavZ5Ds2QmcOdrYlebA9uhcWnU7GBJQBd1hhewN9
 Y2Jw==
X-Gm-Message-State: ABy/qLYySy2UL0Ccoym2b7W8lhWxCPJFWWXa30MQZb1MDo7SPeIMRx1Z
 G0jtWQUv4WdMr8QfOZTBUbFqjIOPyE75txRiDAtxC8negenQyKfk
X-Google-Smtp-Source: APBJJlHF/mmp759/Lmbavii+JmQkie1n8qAzrksh6Am7UAxpjpJCNIlRbPmhwmJQwucnNixeAuoOSh64LhmjBL+7KIQ=
X-Received: by 2002:aa7:d507:0:b0:522:3a28:feca with SMTP id
 y7-20020aa7d507000000b005223a28fecamr9437179edq.24.1690798873162; Mon, 31 Jul
 2023 03:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230611033434.14659-1-akihiko.odaki@daynix.com>
 <260451686566561@lduixalyeduyxu6q.myt.yp-c.yandex.net>
 <f1e462f7-67bc-2a4d-72f9-a5a4641d05ce@daynix.com>
 <5455341686917131@duepvdwsa5dpfj2m.iva.yp-c.yandex.net>
 <1047181690746739@pyij2bcyucz6ldu4.iva.yp-c.yandex.net>
In-Reply-To: <1047181690746739@pyij2bcyucz6ldu4.iva.yp-c.yandex.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 31 Jul 2023 11:21:02 +0100
Message-ID: <CAFEAcA8Qo0h-oX6Z=PH9GQveUVYQBP0drr-q=6QhzN-MWbjpsw@mail.gmail.com>
Subject: Re: [PATCH] elf2dmp: Don't abandon when Prcb is set to 0
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org,
 viktor@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sun, 30 Jul 2023 at 20:52, Viktor Prutyanov
<viktor.prutyanov@phystech.edu> wrote:
>
>
> >> On 2023/06/12 12:42, Viktor Prutyanov wrote:
> >>
> >>>> Prcb may be set to 0 for some CPUs if the dump was taken before they
> >>>> start. The dump may still contain valuable information for started CPUs
> >>>> so don't abandon conversion in such a case.
> >>>>
> >>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>>> ---
> >>>> contrib/elf2dmp/main.c | 5 +++++
> >>>> 1 file changed, 5 insertions(+)
> >>>>
> >>>> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> >>>> index d77b8f98f7..91c58e4424 100644
> >>>> --- a/contrib/elf2dmp/main.c
> >>>> +++ b/contrib/elf2dmp/main.c
> >>>> @@ -312,6 +312,11 @@ static int fill_context(KDDEBUGGER_DATA64 *kdbg,
> >>>> return 1;
> >>>> }
> >>>>
> >>>> + if (!Prcb) {
> >>>> + eprintf("Context for CPU #%d is missing\n", i);
> >>>> + continue;
> >>>> + }
> >>>> +
> >>>> if (va_space_rw(vs, Prcb + kdbg->OffsetPrcbContext,
> >>>> &Context, sizeof(Context), 0)) {
> >>>> eprintf("Failed to read CPU #%d ContextFrame location\n", i);
> >>>>
> >>>> --
> >>>> 2.40.1
> >>>
> >>> Hi Akihiko,
> >>>
> >>> How this fix can be tested?
> >>
> >> It is a bit difficult to test it as you need to interrupt the very early
> >> stage of boot. I applied the following change to TCG so that it stops
> >> immediately after the first processor configures Prcb.
> >>
> >> diff --git a/target/i386/tcg/sysemu/misc_helper.c
> >> b/target/i386/tcg/sysemu/misc_helper.c
> >> index e1528b7f80..f68eba9cac 100644
> >> --- a/target/i386/tcg/sysemu/misc_helper.c
> >> +++ b/target/i386/tcg/sysemu/misc_helper.c
> >> @@ -25,6 +25,9 @@
> >> #include "exec/address-spaces.h"
> >> #include "exec/exec-all.h"
> >> #include "tcg/helper-tcg.h"
> >> +#include "exec/gdbstub.h"
> >> +#include "hw/core/cpu.h"
> >> +#include "sysemu/runstate.h"
> >>
> >> void helper_outb(CPUX86State *env, uint32_t port, uint32_t data)
> >> {
> >> @@ -217,7 +220,10 @@ void helper_wrmsr(CPUX86State *env)
> >> env->segs[R_FS].base = val;
> >> break;
> >> case MSR_GSBASE:
> >> + printf("%s: %" PRIx64 "\n", __func__, val);
> >> env->segs[R_GS].base = val;
> >> + gdb_set_stop_cpu(current_cpu);
> >> + vm_stop(RUN_STATE_PAUSED);
> >> break;
> >> case MSR_KERNELGSBASE:
> >> env->kernelgsbase = val;
> >>
> >>> NumberProcessors field is still set to qemu_elf.state_nr, how does WinDbg react to this?
> >>
> >> If Prcb for processor 1 is missing, WinDbg outputs: KiProcessorBlock[1]
> >> is null.
> >> You can still debug the started processors with no issue.
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> >>> Viktor
> >
> > Reviewed-by: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
>
> Hi Peter,
>
> Could you please put Akihiko's patch into your branch?

Sure. I've applied this to target-arm.next and should
be doing a pullreq for it later today or tomorrow.

-- PMM


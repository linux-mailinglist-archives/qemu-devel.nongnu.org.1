Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84716704FB0
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 15:44:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyuy8-0002ss-1j; Tue, 16 May 2023 09:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1pyuy6-0002sd-16
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:43:58 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mindentropy@gmail.com>)
 id 1pyuy4-0003Bj-BA
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:43:57 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-561a41db2c0so5857517b3.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684244635; x=1686836635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LGOlUvXt1WK37EvZF0m7cnWY9DwuFqIl241BiyEq5PI=;
 b=LHRnmGMjoG7HYjNCenwatqo2ZEqDbHvE93NmMONIeNo0Ls36r+G69lpRRPS8WrD0xn
 KC+a5eqhtwCGLgz0QuTHUhoETocKs1fjgcuDafoQoPGCz8pJgF+i61yribkDPbH+x3fZ
 JR0PruFjBZsWO1WKjyLeminT7JvfARpkghFq861trQDfjAn9aT64svS0oRnSPpjZWA1w
 3wm/8siiVYBq2jleetFEh4PRM+OeaywNd9iLCxoZNWlwOrakazdboD5fqrnmk94E14JE
 gI+uJhRFwL3Z3t54Gq2DSPs4yc0w4IghXUcXlC5Hq/D5dJi/dfSkvGuMGjENkWX4wISI
 LOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684244635; x=1686836635;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LGOlUvXt1WK37EvZF0m7cnWY9DwuFqIl241BiyEq5PI=;
 b=cuL1w+ITGArYfj8vA8sff4odMlGn19oawveQ92WTvy9ggVwwfH+303RSMULeVbDZgr
 mtOK3VNz1vEY4dV/2FWgLb7fPZUF+XhV4bh2nejdByoCt3RqH6i8TLi5wF172Zltz5bK
 QTrDKAhRxW2Lc/uxxAfQL7uNjpwIZMVv+6V/i5EVo4T+8kv6c4Kx27YSCxRfYxFehR3X
 Qm2PxAeztIb3vwPCZwuLN5WbjzBigqiu5YXSrFIidMK+HH3rhHUr1OtjcKHvPDH//Eqs
 4h0CptFDP7i9NfICy9QmDpFIYh4u20SnFqwHsCThWk76G6rViu0K6lnkbBqKc6wduYZ3
 oERA==
X-Gm-Message-State: AC+VfDyaEPgubZfNNWtO0iUqDgrIO1RDlXfpL9HuYeKjDAY5gRxeTkvj
 swMCkAVmqrTnNqQTSbOuuz7s1Thc//A3B2ZW1CZXOG8p
X-Google-Smtp-Source: ACHHUZ5vCPxfnGkWzktKqbEAojWqOlWifW4NOZiWU+qNKz/kl3bGor9EO1hpRabQpvbO8VATnwuvyWJPM7VpPrILNqE=
X-Received: by 2002:a81:844c:0:b0:561:9d69:22e1 with SMTP id
 u73-20020a81844c000000b005619d6922e1mr1010795ywf.22.1684244634983; Tue, 16
 May 2023 06:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAM2a4uxjURNAUcMemWj+mJOvNjgHbXQ-KgiRdRghByM7pBVROw@mail.gmail.com>
 <875y8tbt2y.fsf@linaro.org>
In-Reply-To: <875y8tbt2y.fsf@linaro.org>
From: Gautam Bhat <mindentropy@gmail.com>
Date: Tue, 16 May 2023 19:13:43 +0530
Message-ID: <CAM2a4uyhfJdDjvk3+VfTtwF=h4WBC+MiMWq58LTSwi0s2-nHkg@mail.gmail.com>
Subject: Re: Resources on deeper understanding of Translation blocks
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=mindentropy@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, May 15, 2023 at 7:22=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
>
> Gautam Bhat <mindentropy@gmail.com> writes:
>
> > Hi,
> >
> > I am going through some translation code for existing targets.
> >
> > I would like to know if there are any good resources on deeper
> > understanding of translation blocks? Also some advice on the best way
> > to read code related to translation in Qemu and trying it out maybe
> > using the debugger, printing etc? I am getting lost trying to make
> > sense of the translation code.
>
> We have a section in the developers manual that gives an overview of the
> translator and how it goes together:
>
>   https://qemu.readthedocs.io/en/latest/devel/index-tcg.html
>
> Generally for following code the best option is to use the debug flags,
> the usual is:
>
>  -d in_asm,op,op_opt,out_asm
>
> which will dump in order:
>
>   - in_asm, the guest instructions
>   - op, the TCG ops they break down into
>   - op_opt, the TCG ops after optimiation
>   - out_asm, the host instructions for the block
>
> as this is a lot of data you can limit to certain address ranges using
> the -dfilter option.
>
> Remember the above options will only dump the code as it is translated,
> not each time the guest runs it.
>
> You can attach to the guest using the gdbstub:
>
>   https://qemu.readthedocs.io/en/latest/system/gdb.html
>
> and stick a breakpoint at the code in question. If you have the HMP
> monitor enabled you can then enable the debug options and single step
> through the code and see each instruction translated and executed in
> turn.
>
>
> >
> > Thanks,
> > Gautam.
>
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

Hi Alex,

Thanks for the resources. I have been going through the documentation
and also running it using a debugger to analyze the code. I am still
not there with the op code emulation.
I am more or less stuck understanding how to handle translator_ops
callbacks and disassembly

I will be specific.

1. Could you please explain what the state machine should be for the
tb_stop(...) callback? I am looking at code from AVR
and Microblaze architecture and I see the following cases:
DISAS_NORETURN, DISAS_NEXT, DISAS_TOO_MANY, DISAS_LOOKUP and
DISAS_EXIT.  Is there some documentation on how to handle these cases
and how the disassembly goes through these states?
2. How should the callback for translate_insn be handled?
3. Do you have more information or a visual diagram of sorts for
TARGET_PAGE_* and PAGE_* and the relation between translation blocks
and pages? Also how
should one handle where architectures don't have any paging?

Thanks,
Gautam.


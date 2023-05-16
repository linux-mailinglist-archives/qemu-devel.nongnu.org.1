Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 739F170520E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 17:26:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pywZC-00017P-43; Tue, 16 May 2023 11:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pywZ9-00016g-TF
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:26:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pywZ4-0006g0-01
 for qemu-devel@nongnu.org; Tue, 16 May 2023 11:26:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f435658d23so79064625e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 08:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684250772; x=1686842772;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JCBhqmMnQF7+7yeGpvflXqQLkYT++++ihnLJPNWJRJ8=;
 b=iN5eUFWySZjxH5s5ItqiQLpGh7OPGtV97PFWOivnwTFknuJif6MTujpgX7/nO5Kfbl
 k0ULppVHhU2N3t2sToWwLqS8duEiadCembEgavQckIBwBiCU/O5hSGZ1LYjCjsVr5IVK
 olRVgPn/hGEOsXAdMD/rgMSmDijoHBwhgafpff+6aUW0kwPtvDCqbFTuO26TN1hQ573m
 fWeg8eBxBPb7ba+qdbfEtF5v5C+Bx2DvQp+YovHMkwTCrqiiUtUJayBigdlkRyAMKvrw
 ADGCszeD4lvwTyp7L8eoaKepxrLgxYbck8CSJPTgp8VWSWGakV/R0SLLPOOyBkrbbaA+
 SXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684250772; x=1686842772;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JCBhqmMnQF7+7yeGpvflXqQLkYT++++ihnLJPNWJRJ8=;
 b=h3QPurz/MpNLJjS3/EopOK3EUhUyiFMYdXBxrgegBeMJzLn0xCRmzSHf0437ei1rhG
 Nn6VF1UD5FTV3oT5fLK9OdCMsSPY+gNAC9YYqtqvpLarn54Lh2aSyJOuT3S2cSsRQ5Ox
 se1EvvTzyIcfDAsLic5Hyvw/+IIehgy2UESOcFKmcHBipNVYhGaZaawoGdbecHsYN0HN
 s1P4AThaFjkRIvSwJIcrckrOBwbd9tUvZwyLkzF4jwrZhOXy6XgyMo4hvPDAqd6VQgtc
 xr77DdlAdQw5JkA5+NKdRyB03wdppdqaFzKkv5lgnIwUFkzQ+kHDKi4ja9W8a9rX/CX5
 6XQg==
X-Gm-Message-State: AC+VfDyNwJw0XUiCUWrXOTEExP1rCJt4TuejDlOZHYiwWeZhgt+XJRc4
 Ro9ZJX/+Iy8mdMfvo1wRHc8QYBkSIIQMBuAMSV+ftw==
X-Google-Smtp-Source: ACHHUZ4znaWUTn9ivZvsmJFg0GGREl4qmYhjq1dBZCuzfcccWDg9aHEFNP2hg8bCPG98cobbZxs1Xw==
X-Received: by 2002:a5d:58c1:0:b0:306:41d4:475a with SMTP id
 o1-20020a5d58c1000000b0030641d4475amr27047629wrf.19.1684250772198; 
 Tue, 16 May 2023 08:26:12 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n12-20020a5d484c000000b00307b5376b2csm381961wrs.90.2023.05.16.08.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 May 2023 08:26:11 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3368E1FFBB;
 Tue, 16 May 2023 16:26:11 +0100 (BST)
References: <CAM2a4uxjURNAUcMemWj+mJOvNjgHbXQ-KgiRdRghByM7pBVROw@mail.gmail.com>
 <875y8tbt2y.fsf@linaro.org>
 <CAM2a4uyhfJdDjvk3+VfTtwF=h4WBC+MiMWq58LTSwi0s2-nHkg@mail.gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gautam Bhat <mindentropy@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Resources on deeper understanding of Translation blocks
Date: Tue, 16 May 2023 15:56:22 +0100
In-reply-to: <CAM2a4uyhfJdDjvk3+VfTtwF=h4WBC+MiMWq58LTSwi0s2-nHkg@mail.gmail.com>
Message-ID: <87ttwcnvqk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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


Gautam Bhat <mindentropy@gmail.com> writes:

> On Mon, May 15, 2023 at 7:22=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>
>>
>> Gautam Bhat <mindentropy@gmail.com> writes:
>>
>> > Hi,
>> >
>> > I am going through some translation code for existing targets.
>> >
>> > I would like to know if there are any good resources on deeper
>> > understanding of translation blocks? Also some advice on the best way
>> > to read code related to translation in Qemu and trying it out maybe
>> > using the debugger, printing etc? I am getting lost trying to make
>> > sense of the translation code.
>>
>> We have a section in the developers manual that gives an overview of the
>> translator and how it goes together:
>>
>>   https://qemu.readthedocs.io/en/latest/devel/index-tcg.html
>>
<snip>
>
> Thanks for the resources. I have been going through the documentation
> and also running it using a debugger to analyze the code. I am still
> not there with the op code emulation.
> I am more or less stuck understanding how to handle translator_ops
> callbacks and disassembly
>
> I will be specific.
>
> 1. Could you please explain what the state machine should be for the
> tb_stop(...) callback? I am looking at code from AVR
> and Microblaze architecture and I see the following cases:
> DISAS_NORETURN, DISAS_NEXT, DISAS_TOO_MANY, DISAS_LOOKUP and
> DISAS_EXIT.  Is there some documentation on how to handle these cases
> and how the disassembly goes through these states?

The core documentation is in translator.h

  /**
   * DisasJumpType:
   * @DISAS_NEXT: Next instruction in program order.
   * @DISAS_TOO_MANY: Too many instructions translated.
   * @DISAS_NORETURN: Following code is dead.
   * @DISAS_TARGET_*: Start of target-specific conditions.
   *
   * What instruction to disassemble next.
   */

but as you can see the various frontends define there own target
specific end cases. Currently you have to look at target specific code
to see what it is handling.

Broadly there are two types of exit:

  - goto_tb + exit_tb

  We create an exit block with two exit cases, typically the two legs of
  a conditional branch. Initially these slots are empty which forces an
  exit to the main loop. Then the translated block matching the next PC
  is looked up and patched into the source TB so next time we jump
  directly.

  - lookup_and_goto_ptr

  We don't know what PC we might reach at the end of the block so we
  need to dynamically find the next TB based on what the PC is at
  execution time. If we can't find a TB we trigger an exit to the main
  loop so one can be translated.

The other cases are various special cases. For example we might not be
executing a branch and just falling through to the next instruction
(DISAS_NEXT). We might know the helper will never return, for example
because and exception is triggered, in which case we return to the main
loop and process it there.
=20

> 2. How should the callback for translate_insn be handled?

It is called for each instruction in a block.

> 3. Do you have more information or a visual diagram of sorts for
> TARGET_PAGE_* and PAGE_* and the relation between translation blocks
> and pages? Also how
> should one handle where architectures don't have any paging?

All system emulation is handled by page size because that is the
fundamental granularity of the softmmu TLB which looks up a translation
from guest address to offset into the memory region. It is not directly
related to if the guest is using paging to implement virtual memory.

>
> Thanks,
> Gautam.


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


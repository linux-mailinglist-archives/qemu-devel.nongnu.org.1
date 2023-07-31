Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 730D7769052
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 10:36:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQONM-0000Br-5D; Mon, 31 Jul 2023 04:35:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qQONJ-0000BY-2s
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:35:33 -0400
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1qQONH-0002pA-A7
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:35:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 890AC60F40
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 08:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F03C433CB
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 08:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1690792522;
 bh=snMdew0fKuETUzgiPrmMqut8AO1uC44xjHMWGD9CkDA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=dfSBTs2zKgbuxtvG4AfceJTxUstUu5TjVLY080AC+43H0ZmNtq9rs8p3NrthraWWW
 GGwmo8i8KASIfNae7nfWb5HoMC4dNrjfOP5geAZ8apB1ORiBaJ/nSZIUurAiGQAsWc
 g2TO96id2wuL10R3mEq+9QB4/n4RlgvKKXsxOm60+uBMQu/PFY6uvbY2qbbkpDFKt6
 7C27ZS8xwHUY0WYN8sxC7rGAPWnw9TS2COhlHu2vv+XAgyNTTYnGT2YTOYaPj15H1Z
 pA4qbSmerL9qzc2L/Qed1u4QVnz3I2nD4EebTgKDvKzUlo7wDhzkM0hZcfCjknVtju
 Ko+c0QXvZUgiA==
Received: by mail-lf1-f53.google.com with SMTP id
 2adb3069b0e04-4f4b2bc1565so6558459e87.2
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 01:35:21 -0700 (PDT)
X-Gm-Message-State: ABy/qLYuGfrZKd3tLoBdk8Ie88EWk+dKnblEHObcA3wTBvIKqaU7IX12
 EMySDF+zLQSC4KlDPc2jXF9lQqODdlMeLQbkDV0=
X-Google-Smtp-Source: APBJJlEVeRiDTxGJs2zFhXFbSJE/lIS5XW2zMcRo7H9TDnIdcjW9CiyQ3aTeYKWrhhHsjlwRy4utptvuHWXP861ipTo=
X-Received: by 2002:a2e:9495:0:b0:2b6:bd09:4d64 with SMTP id
 c21-20020a2e9495000000b002b6bd094d64mr6035588ljh.34.1690792519974; Mon, 31
 Jul 2023 01:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230726081710.1051126-1-ardb@kernel.org>
 <67a8967e-338a-fbd1-1c06-d5a35f2db509@linaro.org>
In-Reply-To: <67a8967e-338a-fbd1-1c06-d5a35f2db509@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 31 Jul 2023 10:35:08 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFeO88bosaJ5=ZTRHPH0zxjaujtRtdYWb9e_AMRp0rYgA@mail.gmail.com>
Message-ID: <CAMj1kXFeO88bosaJ5=ZTRHPH0zxjaujtRtdYWb9e_AMRp0rYgA@mail.gmail.com>
Subject: Re: [RFC PATCH] target/i386: Truncate ESP when exiting from long mode
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=139.178.84.217; envelope-from=ardb@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 26 Jul 2023 at 17:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/26/23 01:17, Ard Biesheuvel wrote:
> > While working on some EFI boot changes for Linux/x86, I noticed that TCG deviates from
> > bare metal when it comes to how it handles the value of the stack pointer register RSP
> > when dropping out of long mode.
> >
> > On bare metal, RSP is truncated to 32 bits, even if the code that runs in 32-bit
> > protected mode never uses the stack at all (and uses a long jump rather than long
> > return to switch back to long mode). This means 64-bit code cannot rely on RSP
> > surviving any excursions into 32-bit protected mode (with paging disabled).
> >
> > Let's align TCG with this behavior, so that code that relies on RSP retaining its value
> > does not inadvertently work while bare metal does not.
> >
> > Observed on Intel Ice Lake cores.
> >
> > Cc: Paolo Bonzini<pbonzini@redhat.com> Cc: Richard
> > Henderson<richard.henderson@linaro.org> Cc: Eduardo Habkost<eduardo@habkost.net>
> > Link:https://lore.kernel.org/all/20230711091453.2543622-11-ardb@kernel.org/
> > Signed-off-by: Ard Biesheuvel<ardb@kernel.org> --- I used this patch locally to
> > reproduce an issue that was reported on Ice Lake but didn't trigger in my QEMU
> > testing.
> >
> > Hints welcome on where the architectural behavior is specified, and in particular,
> > whether or not other 64-bit GPRs can be relied upon to preserve their full 64-bit
> > length values.
>
> No idea about chapter and verse, but it has the feel of being part and parcel with the
> truncation of eip.  While esp is always special, I suspect that none of the GPRs can be
> relied on carrying all bits.
>
> I'm happy with the change though, since similar behaviour can be observed on hw.
>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
>

I experimented with truncating all GPRs that exist in 32-bit mode, and
this actually breaks kexec on Linux if it happens to load the kernel
above 4G (which it appears to do reproducibly when sufficient memory
is available)

This is due to the 4/5 level paging switch trampoline, which is called
while RBX, RBP and RSI are live and refer to assets in memory that may
reside above 4G.

I am fixing that code, but it does mean we should probably limit this
change to ESP (as apparently, current hw only happens to truncate ESP
but no other GPRs)


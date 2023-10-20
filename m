Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8087D0CE5
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 12:12:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtmTG-0000YN-Tb; Fri, 20 Oct 2023 06:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtmTC-0000Y4-NK
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:11:07 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qtmT1-0000po-0k
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 06:11:06 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53f6ccea1eeso862796a12.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 03:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697796653; x=1698401453; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TqZ2ljrEY8Wc2PWBNIUIDvwO3HrrCo8p+oPAPuE3YYM=;
 b=FJ5sCj9KI/NJHWp6WjeUTXDQ9jGV16/Npg9sc3KSnG+Ch6l858QTodfMnqtYc+/XS6
 alKo61RShExgglCApHSZ7M69LAVGJa4v7Cvha3RK1AdUfgkTG2WYiL8SldH9WTxlqXHE
 /qAV7kr89RGCiP6YBTmZm7jaRanzMCTXOvMsBi6lSQIi4jb/h6ohWNRsil0u5s+o3w25
 OLSbJxulP7D07DbpVNOnHLSxEMv7c2iEjbxqUs5aJ8KosX1mUvM5SqLjKWGuUlmcJgt3
 F371kP2PP3sPzrvOqDtV5q98hC2GKt9GP6VJ4yJIqKp3TK2O7qeT5zbzy1bh9JDpieof
 ItJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697796653; x=1698401453;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TqZ2ljrEY8Wc2PWBNIUIDvwO3HrrCo8p+oPAPuE3YYM=;
 b=djxQj6cDX6kH7IhvdXFuuG47gKhRrjZmN47oGp3Hc3d35aEDvUoM36nXMe1rA86wEV
 WJrboB7f2znawdWtaKy3318IfGM864oJNb9wRRteIkuI9I984EUXMFDO2ehaEvkVZPDt
 ElOwxzg7Pfx7GzjR/ZJrkLiSlYMnpxSv3lfXIP7LhJJEd9Sw0Xq3HhQkFwTPRqiQ90+Y
 Cv5KzgrATbVkrWhKttYao9qaDCpguWzpqKVfHB2rT8i8om1nOHn+JDfcYuy7VI5Qj4nb
 uNaptO4pjTmjjNSxJ3hlJxJ9eTNXmTZByifJpAl0S6d97u+dugzNBKTUhCydKIcX4YvQ
 sNug==
X-Gm-Message-State: AOJu0YwYuI+HJE8LwADE3ClXQVsX6m9/FSWRzPjVHm4an/xZYCBdfOuS
 HP/mG4U3NQTLydR9tugo+omG9LcpWkuaMyeYqKn/IA==
X-Google-Smtp-Source: AGHT+IGaUnDxXxfU/qL+phmq18pWW/W+QXhtRK2HMcogf44uXrzlFesBhBsqBaJxeOKndTLKkQLgiCxzX7/zQYopaEc=
X-Received: by 2002:a50:cd95:0:b0:53d:ea81:d021 with SMTP id
 p21-20020a50cd95000000b0053dea81d021mr1049868edi.37.1697796653052; Fri, 20
 Oct 2023 03:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231012041051.2572507-1-alistair.francis@wdc.com>
 <20231012041051.2572507-13-alistair.francis@wdc.com>
 <7dc0b6cc-7112-4f12-b52e-13f217d8dae3@linaro.org>
 <1bc517bb-0902-45a5-ada6-eebe8d12fa74@ventanamicro.com>
In-Reply-To: <1bc517bb-0902-45a5-ada6-eebe8d12fa74@ventanamicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Oct 2023 11:10:42 +0100
Message-ID: <CAFEAcA-Bhf5TfReaaifAzq3oBLz6KZNzfpedQqLnH2qQzPMTfg@mail.gmail.com>
Subject: Re: [PULL 12/54] target/riscv: deprecate the 'any' CPU type
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair23@gmail.com>, 
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, 19 Oct 2023 at 19:32, Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
>
>
> On 10/19/23 15:13, Richard Henderson wrote:
> > On 10/11/23 21:10, Alistair Francis wrote:
> >> From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >>
> >> The 'any' CPU type was introduced in commit dc5bd18fa5725 ("RISC-V CPU
> >> Core Definition"), being around since the beginning. It's not an easy
> >> CPU to use: it's undocumented and its name doesn't tell users much abo=
ut
> >> what the CPU is supposed to bring. 'git log' doesn't help us either in
> >> knowing what was the original design of this CPU type.
> >>
> >> The closest we have is a comment from Alistair [1] where he recalls fr=
om
> >> memory that the 'any' CPU is supposed to behave like the newly added
> >> 'max' CPU. He also suggested that the 'any' CPU should be removed.
> >>
> >> The default CPUs are rv32 and rv64, so removing the 'any' CPU will hav=
e
> >> impact only on users that might have a script that uses '-cpu any'.
> >> And those users are better off using the default CPUs or the new 'max'
> >> CPU.
> >>
> >> We would love to just remove the code and be done with it, but one doe=
s
> >> not simply remove a feature in QEMU. We'll put the CPU in quarantine
> >> first, letting users know that we have the intent of removing it in th=
e
> >> future.
> >>
> >> [1] https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg02891.htm=
l
> >>
> >> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> >> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> >> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> >> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >> Message-ID: <20230912132423.268494-13-dbarboza@ventanamicro.com>
> >> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >> ---
> >>   docs/about/deprecated.rst | 12 ++++++++++++
> >>   target/riscv/cpu.c        |  5 +++++
> >>   2 files changed, 17 insertions(+)
> >>
> >> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> >> index 8b136320e2..5e3965a674 100644
> >> --- a/docs/about/deprecated.rst
> >> +++ b/docs/about/deprecated.rst
> >> @@ -327,6 +327,18 @@ QEMU's ``vhost`` feature, which would eliminate t=
he high latency costs under
> >>   which the 9p ``proxy`` backend currently suffers. However as of to d=
ate nobody
> >>   has indicated plans for such kind of reimplementation unfortunately.
> >> +RISC-V 'any' CPU type ``-cpu any`` (since 8.2)
> >
> > You forgot to update linux-user/riscv/target_elf.h, which still uses "a=
ny", and thus all qemu-riscv64 invocations trigger the warning.
>
> Ouch. I'll send a patch.

This is probably why the 'any' cpu exists in the first place,
incidentally -- linux-user wants a way to say "run any binary
you can", and for a lot of architectures that was done by having
an "any" CPU type that turned on all known features. The idea
of having "max" and making it available to system emulation
as well as usermode is a bit of a later development.

thanks
-- PMM


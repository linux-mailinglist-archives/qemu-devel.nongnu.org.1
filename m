Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBBA737F3F
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 12:00:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBuda-0003CE-3u; Wed, 21 Jun 2023 06:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBudY-0003BG-94
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:00:28 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qBudW-0001lP-91
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:00:27 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3f900cd3f69so41206865e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 03:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687341624; x=1689933624;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0M2GZsK11waFkDX11itgLIoZ/oepbH4ktK7VF3alvqM=;
 b=w3a9SFQqgjPIXjz3MLMdmXpTlHexxUhIiaTCJby5veaMqwiS1/JLrRbHR3XZwo90Ji
 22EopiTKit9bwzaSmybKhAt+cb7E33mM9REG6QGjd8JJQ+wuH/qA0EBimpZdNfe/gCiV
 zth1+//SY+dgtVTxxoef1mj2rYckOCU2xg018QeoKiW2BoVFROzltX+/INblKOtqa5hg
 YG7/X9s4+WPxbOsXOaxkpBSftIvkhn5o/ip0AT9LThSTT2SmrdGsiY9glt5FOY5Ds6IY
 LwXGa0PHzEkUt+hxTn+pvRLmv03GScnQ6+Z9x/d8fzBBx3T1eIBleE3H6/devwTkiqeh
 CPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687341624; x=1689933624;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0M2GZsK11waFkDX11itgLIoZ/oepbH4ktK7VF3alvqM=;
 b=jUc8I5Fp+ym04aU65sFNReiHTXNMSLVByTYQueRKPHYZkgy6FeJtouYBS79LT7G/uL
 aA2G3OUwzXtMzleu1X5s7TZncf7TTPh3td5zT1EQQoIWk3S6WtOILO6MkIeh/1DhUlDJ
 1paXGTm32cyZa47g5uHLm4yvl41iy9IBwAmUeEhqdF8K2TwRUSiPCZHWVMywFuxj+1VJ
 ledGzsECdTbPRHv9Wg2qu5S4OoT+BVCJYDcXrhGQh8F5m9bbRp/K4Gv8DizuyhrZ7vTn
 CQegw6aC3Ime8H1ui3p+982jwGxPa9HznfSECxYBK8EmSge9NokstwI2PYwBPT0MU7rN
 Bnpw==
X-Gm-Message-State: AC+VfDys9oUpJcNBeW4VJCvFP4wGOxAUB+aWAtlf3V/IG5ZSYJ4Q0aXF
 r3OGM11ZuVv9ZKzQpe/xIBNCQA==
X-Google-Smtp-Source: ACHHUZ7GADC/35159LkeZalHaJVZTw+vQLTG40eSVCWIf7Zr3x/vdWNkZtYbsg3nF01t+XKi3kdrkw==
X-Received: by 2002:a7b:c356:0:b0:3f8:f6fe:26bf with SMTP id
 l22-20020a7bc356000000b003f8f6fe26bfmr10183542wmj.12.1687341624282; 
 Wed, 21 Jun 2023 03:00:24 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a7bc3d8000000b003f96d10eafbsm4537701wmj.12.2023.06.21.03.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 03:00:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4B8131FFBB;
 Wed, 21 Jun 2023 11:00:23 +0100 (BST)
References: <CAFEAcA_UkPyic7U8eJkzBdBNoQowMToJkK-ro9re51zwn9-CMw@mail.gmail.com>
 <CAFEAcA_EjzQvy67XpXeEn7zMbkoCPLAs3n5PGK2J5kuGkFEBhQ@mail.gmail.com>
 <87352li6kx.fsf@linaro.org>
 <CAFEAcA9JuKBZSjq6WaztNA74CU1g+b=5GQFO0KPqb2RzT3LcWg@mail.gmail.com>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson
 <richard.henderson@linaro.org>, Phil =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: 'make check-tcg' fails with an assert in
 qemu_plugin_vcpu_init_hook
Date: Wed, 21 Jun 2023 10:55:51 +0100
In-reply-to: <CAFEAcA9JuKBZSjq6WaztNA74CU1g+b=5GQFO0KPqb2RzT3LcWg@mail.gmail.com>
Message-ID: <87y1kdgmo8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 21 Jun 2023 at 09:05, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>> > On Tue, 20 Jun 2023 at 17:56, Peter Maydell <peter.maydell@linaro.org>=
 wrote:
>> >>
>> >> $ make -C build/x86 check-tcg
>> >> make: Entering directory '/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/=
build/x86'
>> >> [...]
>> >>   TEST    munmap-pthread on arm
>> >> **
>> >> ERROR:../../plugins/core.c:221:qemu_plugin_vcpu_init_hook: assertion
>> >> failed: (success)
>> >> **
>> >> ERROR:../../accel/tcg/cpu-exec.c:1024:cpu_exec_setjmp: assertion
>> >> failed: (cpu =3D=3D current_cpu)
>> >
>> > git bisect blames commit d7ee93e2435970:
>> >
>> >     cputlb: Restrict SavedIOTLB to system emulation
>> >
>> > I think that commit is not correct, because it means that
>> > the size of 'struct CPUState' and also the offset of fields
>> > like 'cpu_index' will be different for files which are
>> > compile-per-target-for-usermode and files which are
>> > compile-once-only. The assert happens here because the
>> > code which sets up cpu_index is build-once, but the code
>> > in qemu_plugin_vcpu_init_hook() which reads cpu_index is
>> > build-per-target and now they don't agree about where in
>> > the struct the field is...
>>
>> Hmm two things from that imply:
>>
>>   - I suspect the plugin core stuff could be build once (or maybe twice,
>>     system and user)
>
> It is already build-once, that's why it goes wrong...

I thought it was the other way around:

  specific_ss.add(when: 'CONFIG_PLUGIN', if_true: [files(
    'loader.c',
    'core.c',
    'api.c',
  ), declare_dependency(link_args: plugin_ldflags)])

but if we built it for linux-user and softmmu this could be fixed (until
the next breakage anyway). cpus-common.c is the common code that sets
this once.

>>   - we need to have some guard rails somehow to make sure things don't
>>     go out of sync
>
> We do, this is the poison.h stuff. CONFIG_USER_ONLY is a
> special case which we don't poison because there would be
> too much refactoring required...

I guess a great big honking comment at the top of CPUState telling
people not to do that or pushing softmmu and user specific bits of
CPUState into their own de-referenced structures.

>
> -- PMM


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


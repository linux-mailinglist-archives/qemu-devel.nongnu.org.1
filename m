Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A46E7EAE7A
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:58:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2r6Z-00051p-3r; Tue, 14 Nov 2023 05:57:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r2r6W-00051L-M8
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:57:12 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r2r6T-0004zu-Dr
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:57:12 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32fadd4ad09so3752573f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 02:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699959427; x=1700564227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lziij9RreatelhcVmwRhxBV9sdZ+MO3/jgGNTGLBLc4=;
 b=v0LiNiCraufXHwLB5FDbXVpM3wjvcaBsdye8l0MdQp2hIvcgstxOMcOp1EHtSO0fqk
 EV3ZdtCqvLaZExZDe/EfLcD0WDZWcsdwCwXkx6DVWNEEww8oQmSJ4CtPBd83CKka7tYp
 ocizajLHDg51GXMzz2kkC7cgHTB+DpB7gTJwK72BpQzpSYOQvV3BueCtTScUxs+X/ZPU
 LzvaLpLtiTtynluGXF0OoMNg/K7ij+l+dfF4MbQ/3bx4CQXT81t77LLml5lhCsKrh94S
 5XwSIRg1qock9sLEXZmXhzsrb4UNCwjYdGD645nHVgcpx0/IP3IHFRuJHgLySHbTinkS
 KYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699959427; x=1700564227;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Lziij9RreatelhcVmwRhxBV9sdZ+MO3/jgGNTGLBLc4=;
 b=skCSO2X8eEcBE5JdY/JWNEe17oPY2omtWS0KvKyAH22/LOfxx4wq8+SXxylHozuwss
 SIEyfPuCtB7kdRHNPfdPCn7J3EPekoy2ZhMioyLnclEy6/e43F67tHQuUCt7zDy3xv3T
 kjBgRceEEOJ3X94feQVYjfUhj9QPMtnPBH2zaxfAKPO6FXz45LEtH8/eesH5LVbRwWFO
 51/bCxgxTHsSB27zP0QIONN/5OoY2qFny/81icG2g1Qmh+aYenJJ05HmrLMMvgqSXH6/
 Hx4HfOOw3o0z8T5A232ODN0quptKlDZFbJ4BWeu6Ht2ZcbMbx9FixdPQFvLIeFv+PBFj
 aofg==
X-Gm-Message-State: AOJu0YzG5QyskGBy4n8YPaAtZix003Bj2HkSqTlfODDuKfxNWdD+cf/i
 oxjjFI+tsbq8BlrMJnfUt+/k8g==
X-Google-Smtp-Source: AGHT+IEqtm1qb7mTRNo5l3xCrr/iF9TZY2dahu9pE/SRn038Nvg9ewNJO2IjQIBK4VHqaMHQ/jkC0g==
X-Received: by 2002:a05:6000:1865:b0:32d:a54a:f57c with SMTP id
 d5-20020a056000186500b0032da54af57cmr8583956wri.25.1699959427462; 
 Tue, 14 Nov 2023 02:57:07 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o9-20020a5d58c9000000b0032d9caeab0fsm7546999wrf.77.2023.11.14.02.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Nov 2023 02:57:06 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0FDAC5F751;
 Tue, 14 Nov 2023 10:57:06 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Mikhail Tyutin <m.tyutin@yadro.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  "erdnaxe@crans.org" <erdnaxe@crans.org>,
 "ma.mandourr@gmail.com" <ma.mandourr@gmail.com>
Subject: Re: Instruction virtual address in TCG Plugins
In-Reply-To: <e44e7be4b0b44ea2882fbfe09f3b58f4@yadro.com> (Mikhail Tyutin's
 message of "Tue, 14 Nov 2023 09:14:15 +0000")
References: <d4f2713a4e2d45858c82ff2efb95f8a3@yadro.com>
 <87leb1xtdx.fsf@draig.linaro.org>
 <e44e7be4b0b44ea2882fbfe09f3b58f4@yadro.com>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Tue, 14 Nov 2023 10:57:06 +0000
Message-ID: <874jhoy54t.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Mikhail Tyutin <m.tyutin@yadro.com> writes:

>> > What is the right way to get virtual address of either translation blo=
ck or instruction inside of TCG plugin? Does
>> > plugin API allow that or it needs some extension?
>> >
>> > So far I use qemu_plugin_tb_vaddr() inside of my block translation cal=
lback to get block virtual address and then
>> > pass it as 'userdata' argument into qemu_plugin_register_vcpu_tb_exec_=
cb(). I use it later during code execution.
>> > It works well for user-mode emulation, but sometimes leads to
>> > incorrect addresses in system-mode emulation.
>>=20
>> You can use qemu_plugin_insn_vaddr and qemu_plugin_insn_haddr. But your
>> right something under one vaddr and be executed under another with
>> overlapping mappings. The haddr should be stable though I think.
>
> As far as I see haddr is ok and can be used to identify blocks. However, =
if I have haddr at block execution phase and
> I want to know vaddr, there is no API to get such mapping. Maybe it is po=
ssible to extract from software MMU, but I
> have no clue where to start with.

The translator doesn't know (at least since CF_PCREL) because the whole
point of that change was to avoid re-translating the same code from
multiple mappings. However we do have the ability to resolve a PC at
fault time so we could expose that to a execution callback.

>> > I suspect it is because of memory mappings by guest OS that changes vi=
rtual addresses for that block.
>> >
>> > I also looked at gen_empty_udata_cb() function and considered to exten=
d plugin API to pass a program counter
>> > value as additional callback argument. I thought it would always give =
me valid virtual address of an instruction.
>> > Unfortunately, I didn't find a way to get value of that register in ar=
chitecture agnostic way (it is 'pc' member in
>> > CPUArchState structure).
>>=20
>> When we merge the register api you should be able to do that. Although
>> during testing I realised that PC acted funny compared to everything
>> else because we don't actually update the shadow register every
>> instruction.
>
> We implemented similar API to read registers (by coincidence, I posted th=
is patch at the same time as the API you
> mentioned) and I observe similar behavior. As far as I see, CPU state is =
only updated in between of executed translation
> blocks. Switching to 'singlestep' mode helps to fix that, but execution o=
verhead is huge.
>
> There is also blocks 'chaining' mechanism which is likely contributes to =
corrupted blocks vaddr inside of callbacks.
> My guess is that 'pc' value for those chained blocks points to the first =
block of entire chain. Unfortunately, It is very
> hard to debug, because I can only see block chains when I run whole Linux=
 guest OS. Does Qemu has small test
> application to trigger long enough chain of translation blocks?

No all registers should be resolved by the end of any block. There is
currently no optimisation of register usage between TBs. If you are
seeing PC corruption that would be a bug - but fundamentally things
would break pretty quick if tb_lookup() and friends didn't have an
accurate PC.

As for block chains any moderately complex loop should trigger chaining.

> Having those complexities makes me think to inject appropriate code into =
translation blocks to compute actual block
> vaddr at execution stage. The problem here is to find a variable where
> I can load 'pc' at start of translation block.

I think it would be pretty easy to ensure there is a rectified PC value
written before calling any callback - arguably the QEMU_PLUGIN_CB_R_REGS
flag should do this.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


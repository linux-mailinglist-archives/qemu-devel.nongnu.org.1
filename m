Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B67475884D
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 00:12:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLsv0-0006Kz-JC; Tue, 18 Jul 2023 18:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qLsuw-0006KD-Cr
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 18:11:38 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qLsuu-0000T2-0J
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 18:11:37 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3144bf65ce9so5809309f8f.3
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 15:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689718292; x=1692310292;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1pbIniCuAroTrClB/qLWwdhneADvaQkuz0++0cnRE4c=;
 b=vuODQ8CRVMgPdFy5fz4uTmIV7Eb6omam63N7uLESXlRhJyNeJWFig9fWrs7s1Nz+Rv
 p9xbTPaIw3u5D6h6J7wjLBF/xRStZ02A0YQHYFCU31OZNN+KEHI7Vbflz7b/LyoxzI0N
 XotXDfucNbtjhg/rc16T2GKaaLIP5P/9v+NBgJoolcjKSPrb5ySNL/0QaQO2EhWYy4s9
 A227xR2mDhgzeOBmNGOqHzbbXku5fRqMc82d4WR9X0rLiMN3DI5XUKPAm9XOF1LHZSpH
 UYUu7QegXjXd+YYMktytgr/pGiLeVuzSsIWQKv1dk3dxsI/J7Pdkz44Q63i9A+7Qy+bZ
 uR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689718292; x=1692310292;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1pbIniCuAroTrClB/qLWwdhneADvaQkuz0++0cnRE4c=;
 b=YsT1kfmZlZzharXE284OL+M0Wp7tzZAZHTaB/M9JIkLcS6jipU7njEdzgLf0jYu15p
 MkRgoo6vdHVvMCrnO1wXPQ4d/OIuGDhnjxKG2Ad53pic0zM1acypi+vZLdA0EWCaK9CK
 a31ndmtXk2F4OIjoNrSSFd2sirRwILjA+RYCh/105Xzjf1lttS0E0LIbGZsKqDLAkRoo
 bxnuAnogwAq5eH6SUwejInUIg7xN/addO7EsLhqYlt+HvVw668B4s1mwQK6LeRTbEeaX
 FqXiqtsk+67iITlrWzHRs3YwVZ2Id1/nrKr3wq0sp/aZDKNKn+EL3H1Uvcnx0PcCh7Qk
 AGXQ==
X-Gm-Message-State: ABy/qLZX8IG1F8Y7A1oEvejRRL+pcLCEm1i3H58DhqyAa+TdYhEvHnEp
 rJc4uZaXiu1bMcyJufhAygOYQQ==
X-Google-Smtp-Source: APBJJlGa0gSvvQXfxfXmeSlnG3aDQ/PtdmS+JgJG8Ww6Wz/a5kONyJwzpGW0CMeU9LeoxLcFoi/WCg==
X-Received: by 2002:a5d:4947:0:b0:314:475:bc47 with SMTP id
 r7-20020a5d4947000000b003140475bc47mr654006wrs.69.1689718292260; 
 Tue, 18 Jul 2023 15:11:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a7bc8c2000000b003fb225d414fsm166228wml.21.2023.07.18.15.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 15:11:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B9DF71FFBB;
 Tue, 18 Jul 2023 23:11:30 +0100 (BST)
References: <CADc=-s5RwGViNTR-h5cq3np673W3RRFfhr4vCGJp0EoDUxvhog@mail.gmail.com>
 <874jm2ya3g.fsf@linaro.org> <87sf9mwnzo.fsf@linaro.org>
 <CADc=-s46VkRZiU--59VdeTcACoir1srxV=eTxPwwwut_tSJESQ@mail.gmail.com>
User-agent: mu4e 1.11.10; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Matt Borgerson <contact@mborgerson.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v2] plugins: Set final instruction count in
 plugin_gen_tb_end
Date: Tue, 18 Jul 2023 23:05:16 +0100
In-reply-to: <CADc=-s46VkRZiU--59VdeTcACoir1srxV=eTxPwwwut_tSJESQ@mail.gmail.com>
Message-ID: <87cz0o27l9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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


Matt Borgerson <contact@mborgerson.com> writes:

> Thanks Alex!
>
>
> On Mon, Jul 17, 2023 at 8:34=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lin=
aro.org> wrote:
>>
>>
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>
>> > Matt Borgerson <contact@mborgerson.com> writes:
>> >
>> >> Translation logic may partially decode an instruction, then abort and
>> >> remove the instruction from the TB. This can happen for example when =
an
>> >> instruction spans two pages. In this case, plugins may get an incorre=
ct
>> >> result when calling qemu_plugin_tb_n_insns to query for the number of
>> >> instructions in the TB. This patch updates plugin_gen_tb_end to set t=
he
>> >> final instruction count.
>> >
>> > For some reason this fails to apply cleanly:
>> >
>> >   git am ./v2_20230714_contact_plugins_set_final_instruction_count_in_=
plugin_gen_tb_end.mbx
>> >   Applying: plugins: Set final instruction count in plugin_gen_tb_end
>> >   error: corrupt patch at line 31
>> >   Patch failed at 0001 plugins: Set final instruction count in
>> >   plugin_gen_tb_end
>>
>> I think some newlines crept in, I was able to fix. Queued to
>> for-8.1/misc-fixes with the assert added.

Hmm so I ran into an issue:

  ./qemu-sh4 -plugin tests/plugin/libbb.so -d plugin ./tests/tcg/sh4-linux-=
user/testthread
  ERROR:../../accel/tcg/plugin-gen.c:874:plugin_gen_tb_end: assertion faile=
d: (num_insns <=3D ptb->n)
  Bail out! ERROR:../../accel/tcg/plugin-gen.c:874:plugin_gen_tb_end: asser=
tion failed: (num_insns <=3D ptb->n)
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  bb's: 9202, insns: 42264
  fish: Job 1, './qemu-sh4 -plugin tests/plugin=E2=80=A6' terminated by sig=
nal SIGSEGV (Address boundary error)

Further investigation shows that gUSA sequences can cause the number of
instructions to run ahead, which also makes the setting of the ptb->n =3D
num_insns unsafe, running ahead of the number of instructions signalled
by plugin_gen_insn_start/plugin_gen_insn_end.

  Thread 1 hit Hardware watchpoint 5: *(int *) 0x7ffd410a2904
  Old value =3D 4
  New value =3D 1
  0x000055f148c00ea8 in decode_gusa (ctx=3D0x7ffd410a28f0, env=3D0x55f14a41=
06e8) at ../../target/sh4/translate.c:2167
  2167        ctx->base.num_insns +=3D max_insns - 1;
  (rr) p max_insns
  $6 =3D 4
  (rr) p max_insns -1
  $7 =3D 3
  (rr) p ctx->base.num_insns
  $8 =3D 1

So I think we have to drop this for now until we can either fix
decode_gusa or find something else.

Richard,

Any ideas?



--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


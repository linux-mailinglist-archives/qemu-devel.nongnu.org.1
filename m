Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0344974BD37
	for <lists+qemu-devel@lfdr.de>; Sat,  8 Jul 2023 12:12:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qI4uG-0004pv-Np; Sat, 08 Jul 2023 06:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qI4uF-0004pe-33
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 06:11:11 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qI4uC-00044e-II
 for qemu-devel@nongnu.org; Sat, 08 Jul 2023 06:11:10 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3143ccb0f75so3373318f8f.0
 for <qemu-devel@nongnu.org>; Sat, 08 Jul 2023 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688811067; x=1691403067;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ge3IlNjAw+bE4PJ1Br8Eh7MhXFDmsKrSrMtnqLjGyFw=;
 b=Jm6qFmeN1CT8aki8xfXt7+Siv3Ec6mnJzIR/Fc/VMvs9hZlGYriu9BeC5YcRbCmo15
 oqLy4LdBc1QEALlxN8+PRgbmJCulFN01lGR8RBSSPmxWA1r4lNl30wGXXgQxpXcknGBf
 AHRdU6Fq6/FRPB0ZanKvcA70Td+ufuE1ueQJV+mXdZT/7ZRkgLsCt05TLvL7ZDzLh8ik
 I1shnhlZPdGxbHdeN3tM/Nj36AV//oO509SmACYUEa8XkKmNPE8ivIpESnpsWwZVgF12
 axioQEdQ+l1nNTUQheTbRz0nopsd8LidLkE6H2ESvSDL8RkjELbxWNsZzDn7sRL6KRjC
 9rDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688811067; x=1691403067;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ge3IlNjAw+bE4PJ1Br8Eh7MhXFDmsKrSrMtnqLjGyFw=;
 b=a85JkB1OxeGkn3zJWuD7Y5x/olr2t4ocbDMhSJ6tUeaVx+8qo6my+EtrpCPKddDD0g
 zh0XK3xXkQ6/+Vlv3Kr1MVeYKPAccfM+zCxWjjZmdnsvMlNK0FsFCJxjjc4sYy2w1JgQ
 ZXo/7LGzZ/cdgIeOSJIEKdGO7LJgaY6EGjNmjjzkgNyyeMmqvARtkrVHMWMJoOG8+3Ms
 sgmWNqgsaBWrJ9jx8NyWXxF7+hmuXQJ60C+ufizkd5CteECy5/SXot08mOzzLkZS9M1z
 cPu2M78FsC7I7iyQgJkDLCdj8Sg4ZFn5pZlrP7v2xr0qR3q9Q5JAv/XdoIC/EHs6EpY1
 PNdg==
X-Gm-Message-State: ABy/qLZDcnAydgDs3uRzk85jK5ytd3xsOOARyhhpF/xFF48aj9IhgnCu
 i1x7qCWNo7wuRG03ZxidypQgcflupFfxjyeWi78=
X-Google-Smtp-Source: APBJJlFB5vR0QfMiMevNaWQHh4au6cE/58KsVeVv1SA0l68o+vIThipi/SxRTflyxTsdyxSyowqWRA==
X-Received: by 2002:a5d:684e:0:b0:315:8fbc:4dd with SMTP id
 o14-20020a5d684e000000b003158fbc04ddmr1536343wrw.50.1688811066782; 
 Sat, 08 Jul 2023 03:11:06 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 h5-20020adffd45000000b00313f07ccca4sm6600083wrs.117.2023.07.08.03.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jul 2023 03:11:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BCF371FFBB;
 Sat,  8 Jul 2023 11:11:05 +0100 (BST)
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
 <20230703134427.1389440-30-alex.bennee@linaro.org>
 <dabe52cc-2f1d-ba3e-64c3-5ae2996da7cb@tls.msk.ru>
User-agent: mu4e 1.11.9; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, Nicholas Piggin
 <npiggin@gmail.com>, qemu-stable@nongnu.org, Matheus Tavares Bernardino
 <quic_mathbern@quicinc.com>, Taylor Simpson <tsimpson@quicinc.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PULL 29/38] gdbstub: Permit reverse step/break to provide stop
 response
Date: Sat, 08 Jul 2023 11:10:40 +0100
In-reply-to: <dabe52cc-2f1d-ba3e-64c3-5ae2996da7cb@tls.msk.ru>
Message-ID: <87zg46k91i.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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


Michael Tokarev <mjt@tls.msk.ru> writes:

> 03.07.2023 16:44, Alex Benn=C3=A9e wrote:
>> From: Nicholas Piggin <npiggin@gmail.com>
>> The final part of the reverse step and break handling is to bring
>> the machine back to a debug stop state. gdb expects a response.
>> A gdb 'rsi' command hangs forever because the gdbstub filters out
>> the response (also observable with reverse_debugging.py avocado
>> tests).
>> Fix by setting allow_stop_reply for the gdb backward packets.
>> Fixes: 758370052fb ("gdbstub: only send stop-reply packets when
>> allowed to")
>> Cc: qemu-stable@nongnu.org
>
> Hi!
>
> Are you guys sure this needs to be in -stable?
>
> To me it looks a sort of "partial revert" of a previous commit:
>
> commit 758370052fb602f9f23c3b8ae26a6133373c78e6
> Author: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Date:   Thu May 4 12:37:31 2023 -0300
> Subject: gdbstub: only send stop-reply packets when allowed to
>
> which introduced `allow_stop_reply' field in GdbCmdParseEntry.
> This change ("gdbstub: Permit..") does not work in 8.0 without
> the above mentioned "gdbstub: only send" commit, and I guess
> it is *not* supposed to be in stable. Or is it?
>
> I'm not applying this one to stable for now.

Good catch - your right it's purely fixing something that has been
merged in the current cycle.

>
> Thanks,
>
> /mjt
>
>> Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
>> Cc: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Taylor Simpson <tsimpson@quicinc.com>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> Acked-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
>> Message-Id: <20230623035304.279833-1-npiggin@gmail.com>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20230630180423.558337-30-alex.bennee@linaro.org>
>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>> index be18568d0a..9496d7b175 100644
>> --- a/gdbstub/gdbstub.c
>> +++ b/gdbstub/gdbstub.c
>> @@ -1814,6 +1814,7 @@ static int gdb_handle_packet(const char *line_buf)
>>                   .handler =3D handle_backward,
>>                   .cmd =3D "b",
>>                   .cmd_startswith =3D 1,
>> +                .allow_stop_reply =3D true,
>>                   .schema =3D "o0"
>>               };
>>               cmd_parser =3D &backward_cmd_desc;


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


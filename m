Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFF280C11A
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 07:03:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCZNr-0006hj-MQ; Mon, 11 Dec 2023 01:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1rCZNp-0006h9-GM
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:03:13 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dinahbaum123@gmail.com>)
 id 1rCZNn-0006sh-S3
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 01:03:13 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-50bce78f145so4571879e87.0
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 22:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702274590; x=1702879390; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=f4E0V+60Mv5KLQAJtdG+m6jZI8ZjKTWtshAVxOfgnJQ=;
 b=Qyiy8AN+Bf0Zjr4+sblP1qDlKAP1NVnF+EKQRUrRKgkb+aYSFA4/hNH88RFX1Kio1A
 LJ7soaikRXcpptTM9oxU+eaf52VSnsD3a41FHaLJA94r9G8BwseDZx8RJrdICWIvCOmg
 8IC36mpN6C0NhpyHXWiQq6qodqXRczCkSoFvPUcRnyHFh47WzzMsdbUZnJdGN+plSIFW
 VuetlMzuysLzVFA0zUKXRWcAlBGANtjcaNEX0khdL+wLVWbVHYC+baUevKW+EPe5BnF/
 132Ht7elaXTycoSXB94BWKGSkbuuSONzx6Q5KNh117ufCttwzY0YipmE5QeJT2uUXNGJ
 BBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702274590; x=1702879390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f4E0V+60Mv5KLQAJtdG+m6jZI8ZjKTWtshAVxOfgnJQ=;
 b=HDuOgr1xhEemQC/l40l4r3y+aR8j7/LvHrC5XOcE+cXwSlC8oXJLLv+5x1HNMPveHr
 gpzJ/oo1MxhGRFJTGaOQ13/cEQ/72NTRZEpHyPQ7TqT2vN58IiqRKSBjV++71gQx4fKO
 h0fBCOKkmLvnBtaiA8ORbnwo2N1yzm6En1ga3GQZWQ3WxnvTlVWdbk/9iVxCE7aWh2sp
 1WSZGqrGtv7gRfJiVRGogE7gcWNXDG3QHmjH7LCs+jX3pp9G5QbLX54qW46fBK6e6bdc
 13tBVUuaOnJ+A5Im8CM4ptvVn1A4W/Ls2efnUqMs8MzyIrIgDsM4Y03Uln9a6Q1kgBLC
 FLfw==
X-Gm-Message-State: AOJu0YwqdZgiT2coF/SGJKjZ0eu2Isqo2cGZHRU517WwxHG4WH2ZOHwk
 DvliqZs6zlJKoTxNREfM4CGSGguIPf2n2gXXGPE=
X-Google-Smtp-Source: AGHT+IHZ0lWBE97Mfe4e6NNb5xy9QnEScTZfzr3qFG/R9SEUJycDPvHlFnkCVT2hUkkC8fg257MQLUY5Fp7qbgvXB3s=
X-Received: by 2002:a19:ee0b:0:b0:50b:e695:4158 with SMTP id
 g11-20020a19ee0b000000b0050be6954158mr574604lfb.238.1702274589390; Sun, 10
 Dec 2023 22:03:09 -0800 (PST)
MIME-Version: 1.0
References: <20230730064057.357598-1-dinahbaum123@gmail.com>
 <20230730064057.357598-4-dinahbaum123@gmail.com> <87tttix39v.fsf@pond.sub.org>
 <CAH50XRepiYcR9_e0AtuwTk1Nn34TXvZ87F5VVWg3aSx8BRJHPg@mail.gmail.com>
 <87edkmt397.fsf@pond.sub.org>
 <CAH50XRcOF2Sa0psZt_trCM-F68iR_pgyb8VsqJ_byFtPPgJRaw@mail.gmail.com>
 <87leb0w7ot.fsf@pond.sub.org>
In-Reply-To: <87leb0w7ot.fsf@pond.sub.org>
From: Dinah B <dinahbaum123@gmail.com>
Date: Mon, 11 Dec 2023 01:02:58 -0500
Message-ID: <CAH50XRcZUdnCsd=-GRMcVhCr_69khdpM0qAkrXwP5PbNJ8=d+w@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] cpu, softmmu/vl.c: Change parsing of -cpu argument
 to allow -cpu cpu,
 help to print options for the CPU type similar to how the
 '-device' option works.
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000035fa39060c35b087"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=dinahbaum123@gmail.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--00000000000035fa39060c35b087
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Due to extracting CPU features via a qmp command, it only works on
qemu-system-* builds.
Building qmp for non system builds strikes me as extreme overkill so I need
a way to exclude this from non system builds.
Or maybe there's a way to disentangle querying CPU features independent
from the qom or qmp based data structures it's currently intertwined with.

Thanks,
-Dinah

On Tue, Nov 14, 2023 at 12:44=E2=80=AFPM Markus Armbruster <armbru@redhat.c=
om>
wrote:

> Dinah B <dinahbaum123@gmail.com> writes:
>
> > Hi,
> >
> > Is there a way to distinguish between qemu-system-* vs qemu-* builds?
> > At first I thought #CONFIG_LINUX_USER might be it but not all non-mmu
> > builds set this.
>
> What are you trying to accomplish?
>
>

--00000000000035fa39060c35b087
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Due to extracting CPU fe=
atures via a qmp command, it only works on qemu-system-* builds. <br></div>=
<div>Building qmp for non system builds strikes me as extreme overkill so I=
 need a way to exclude this from non system builds. </div><div>Or maybe the=
re&#39;s a way to disentangle querying CPU features independent from the qo=
m or qmp based data structures it&#39;s currently intertwined with.<br></di=
v><div><div><br></div><div>Thanks,</div><div>-Dinah<br></div></div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, =
Nov 14, 2023 at 12:44=E2=80=AFPM Markus Armbruster &lt;<a href=3D"mailto:ar=
mbru@redhat.com" target=3D"_blank">armbru@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">Dinah B &lt;<a href=3D"=
mailto:dinahbaum123@gmail.com" target=3D"_blank">dinahbaum123@gmail.com</a>=
&gt; writes:<br>
<br>
&gt; Hi,<br>
&gt;<br>
&gt; Is there a way to distinguish between qemu-system-* vs qemu-* builds?<=
br>
&gt; At first I thought #CONFIG_LINUX_USER might be it but not all non-mmu<=
br>
&gt; builds set this.<br>
<br>
What are you trying to accomplish?<br>
<br>
</blockquote></div>

--00000000000035fa39060c35b087--


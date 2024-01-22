Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E03583646F
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 14:27:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRuK7-00022c-P1; Mon, 22 Jan 2024 08:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rRuK3-00022H-Lt
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:26:43 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rRuK1-0006mv-JJ
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 08:26:43 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-55a50649ff6so3302684a12.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 05:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705929999; x=1706534799; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5I8n0R/IucDxDXY9xuCTQCEJrISpDtQ+7W0s/w6EjQk=;
 b=HJbC7udpTJJIQ4GNLxo+Z95uo5xTtNJJqx/BRdoDgjdKfOytToad5UkmOFSlMUlnBw
 xacLbmj1SN38KC8BIY7ENQu9l63uES4JDmwtIdzIs2Y7YPWec+ov05NZd/UGGIa/TXGp
 U+6M4M3hAixcA+YG7JiyYi43kEIrxPvUKMkaubL18LkGSMEHWnd1AQCZAQPcB3nZ/pUI
 tdKE8J/EXyYk+/+ZdZfVzGXKvuo6RNoMPxPLW1D3lANtfaj9sxkv2tUlj7DMbHw0CEql
 /H2DuS0P478r4eCmf+FpZDNm2czrpJOOGBLMLwhVbQ1kfJVk3XM8SsP06UCRpzItRbYx
 Myvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705929999; x=1706534799;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5I8n0R/IucDxDXY9xuCTQCEJrISpDtQ+7W0s/w6EjQk=;
 b=IslxGcBc7w+43VFriI8cScAcCY4lFMbxQ5lhNwHgBrUMTL5xNPaTCJEISR6f7eHEP8
 C5CYi008Qz1lIdOM/SjG7JNX1hN0nRYxXmZ7Nq67yP1hrsllFvWQgW7N1k732mwSLHsk
 to+oXXsrDfA/X/zevVtzdvCI6DXPl2vYsOcjS4QpW4KhRCsYj+7wpdID4JfdUKEz2gxe
 QeRRaiTsfO8+v/AxSbuyzWl7rUfpFlm38Wa2OVvzXvYSQ50b0zMsEd2709a89q75GDeL
 Z2lm/N3S9LG/u5wv6SS1X1CqKnqJr2AO9MCKmLlOAPiiAOo6X6DHs7tiy3ToLvwU8o2K
 ngcA==
X-Gm-Message-State: AOJu0Yy16S6flu/FJo1KwNBYqTV99Hw0ohAC1VkGPHzG8kGrcWP0Yygn
 yKuTI2Vjhv80hPdpOjOiz8vtiUMB4A/GV3KUWUskC6WnhbXPm0ih32/qTdM8nI8DjrlzaU7HaXT
 4J46F46jCXN6q9i8OyQsq6iE0yhc=
X-Google-Smtp-Source: AGHT+IGynJaDsvLqs/5Sr2myktcW2lLuEMlwhI3FqE0b4AnTbkrAzY8IIKcEEz5bb8DlO9CCjcRjAgReEhUZpS6Lu3k=
X-Received: by 2002:aa7:c351:0:b0:55a:5146:aefa with SMTP id
 j17-20020aa7c351000000b0055a5146aefamr1825931edr.36.1705929999002; Mon, 22
 Jan 2024 05:26:39 -0800 (PST)
MIME-Version: 1.0
References: <20240111172546.823263-1-atp.exp@gmail.com>
 <Zal_RMi4wmLGj6k9@redhat.com>
In-Reply-To: <Zal_RMi4wmLGj6k9@redhat.com>
From: atp exp <atp.exp@gmail.com>
Date: Mon, 22 Jan 2024 18:56:26 +0530
Message-ID: <CAFgBtdFpRmdFiPYChzxPEDWHCe=o_2FXhQAXy8W_OPPs6gfz-A@mail.gmail.com>
Subject: Re: [PATCH v3] qemu-img: Fix Column Width and Improve Formatting in
 snapshot list
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com
Content-Type: multipart/alternative; boundary="0000000000009a2f1e060f88c777"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=atp.exp@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000009a2f1e060f88c777
Content-Type: text/plain; charset="UTF-8"

Alright, right now there are 10 digits for ID, don't think a billion
snapshots are feasible anyway.

> Maybe what we should also do is decreasing the width of each field by
> one and instead writing a space character into the format string.

I'm assuming  you are talking about adding spaces between DATE, VM_CLOCK
and ICOUNT, because spaces already exist for ID and TAGS.

Will send a patch soon.

Abhiram

On Fri, 19 Jan 2024 at 01:13, Kevin Wolf <kwolf@redhat.com> wrote:

> Am 11.01.2024 um 18:25 hat Abhiram Tilak geschrieben:
> > When running the command `qemu-img snapshot -l SNAPSHOT` the output of
> > VM_CLOCK (measures the offset between host and VM clock) cannot to
> > accommodate values in the order of thousands (4-digit).
> >
> > This line [1] hints on the problem. Additionally, the column width for
> > the VM_CLOCK field was reduced from 15 to 13 spaces in commit b39847a5
> > in line [2], resulting in a shortage of space.
> >
> > [1]:
> https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L753
> > [2]:
> https://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=heads#L763
> >
> > This patch restores the column width to 15 spaces and makes adjustments
> > to the affected iotests accordingly. Furthermore, addresses a potential
> source
> > of confusion by removing whitespace in column headers. Example, VM CLOCK
> > is modified to VM_CLOCK. Additionally a '--' symbol is introduced when
> > ICOUNT returns no output for clarity.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2062
> > Fixes: b39847a50553 (migration: introduce icount field for snapshots )
> > Signed-off-by: Abhiram Tilak <atp.exp@gmail.com>
>
> We can tweak the format a bit, but then we need to save those two
> characters somewhere else so that the output still fits in 80
> characters. We can probably reduce the size of the ID column.
>
> Maybe what we should also do is decreasing the width of each field by
> one and instead writing a space character into the format string. So if
> we ever use up the space for one of the fields again, we would lose the
> nice column alignment, but you could still recognise the individual
> fields.
>
> Kevin
>
>

--0000000000009a2f1e060f88c777
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Alright, right now there=
 are 10 digits for ID, don&#39;t think a billion snapshots are feasible any=
way.<br><br>&gt; Maybe what we should also do is decreasing the width of ea=
ch field by<br>&gt; one and instead writing a space character into the form=
at string.<br><div><br></div><div>I&#39;m assuming=C2=A0 you are talking ab=
out adding spaces between DATE, VM_CLOCK</div><div>and ICOUNT, because spac=
es already exist for ID and TAGS.</div><div><br></div><div>Will send a patc=
h soon.</div><div><br></div><div>Abhiram</div></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 19 Jan 2024 at =
01:13, Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com">kwolf@redhat.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">A=
m 11.01.2024 um 18:25 hat Abhiram Tilak geschrieben:<br>
&gt; When running the command `qemu-img snapshot -l SNAPSHOT` the output of=
<br>
&gt; VM_CLOCK (measures the offset between host and VM clock) cannot to<br>
&gt; accommodate values in the order of thousands (4-digit).<br>
&gt; <br>
&gt; This line [1] hints on the problem. Additionally, the column width for=
<br>
&gt; the VM_CLOCK field was reduced from 15 to 13 spaces in commit b39847a5=
<br>
&gt; in line [2], resulting in a shortage of space.<br>
&gt; <br>
&gt; [1]: <a href=3D"https://gitlab.com/qemu-project/qemu/-/blob/master/blo=
ck/qapi.c?ref_type=3Dheads#L753" rel=3D"noreferrer" target=3D"_blank">https=
://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=3Dheads=
#L753</a><br>
&gt; [2]: <a href=3D"https://gitlab.com/qemu-project/qemu/-/blob/master/blo=
ck/qapi.c?ref_type=3Dheads#L763" rel=3D"noreferrer" target=3D"_blank">https=
://gitlab.com/qemu-project/qemu/-/blob/master/block/qapi.c?ref_type=3Dheads=
#L763</a><br>
&gt; <br>
&gt; This patch restores the column width to 15 spaces and makes adjustment=
s<br>
&gt; to the affected iotests accordingly. Furthermore, addresses a potentia=
l source<br>
&gt; of confusion by removing whitespace in column headers. Example, VM CLO=
CK<br>
&gt; is modified to VM_CLOCK. Additionally a &#39;--&#39; symbol is introdu=
ced when<br>
&gt; ICOUNT returns no output for clarity.<br>
&gt; <br>
&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/206=
2" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qem=
u/-/issues/2062</a><br>
&gt; Fixes: b39847a50553 (migration: introduce icount field for snapshots )=
<br>
&gt; Signed-off-by: Abhiram Tilak &lt;<a href=3D"mailto:atp.exp@gmail.com" =
target=3D"_blank">atp.exp@gmail.com</a>&gt;<br>
<br>
We can tweak the format a bit, but then we need to save those two<br>
characters somewhere else so that the output still fits in 80<br>
characters. We can probably reduce the size of the ID column.<br>
<br>
Maybe what we should also do is decreasing the width of each field by<br>
one and instead writing a space character into the format string. So if<br>
we ever use up the space for one of the fields again, we would lose the<br>
nice column alignment, but you could still recognise the individual<br>
fields.<br>
<br>
Kevin<br>
<br>
</blockquote></div></div>

--0000000000009a2f1e060f88c777--


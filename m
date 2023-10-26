Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DE39E7D8830
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 20:22:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw4zB-000530-VK; Thu, 26 Oct 2023 14:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanmaynpatil105@gmail.com>)
 id 1qw4z8-00051p-1i
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 14:21:34 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanmaynpatil105@gmail.com>)
 id 1qw4z6-0007MS-2y
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 14:21:33 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53df747cfe5so2056718a12.2
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698344490; x=1698949290; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UbKcKvdMHgwb1P1dFRNC5YPzHstM+FIyvk7RetDlF10=;
 b=kQe+4HIGu03JlTytO2Y2Ij2aeXKMr0E4Fjmk6pRxmnmdxHMF0lGAiUZiIJjMp2kvQ5
 7UoHn6SJW4+EGmEaoUV07WALl9yibiZcbXX/2JBhPBahfyktSkmrd+mNag2bcyvt+ZgR
 Y2yZ1OS/rqsj6nz0zioJCZ1h4ba589SmR0cwDP+4faVRCPuXMvOONEJELQ1PILVEATmz
 HwebEbLhbDnLLdStGoqp6dZ9l0vTemO8zUp3GnddvVfmsp29UFGdfqfnsquhAfvZLzxm
 5foMbbk8zzjWoNRJYeLEEWUfS0f2+71wm4Guxux3XuiBnbW3JSD3OgYy3bnSwhcDUgUD
 I2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698344490; x=1698949290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UbKcKvdMHgwb1P1dFRNC5YPzHstM+FIyvk7RetDlF10=;
 b=VW/3DtB4wPWyJuYisXdx08jrdCTqyvuZ50eo74hhIsParywVDuvuWBXFiThKemIk17
 n0LmBTZ3fp/wteKSQWguUl0MXjeco7q5vShT3OXO4ayOi9TyOkYMCYwKB+i/29oGDN5J
 PtsvWyPxW68vxc2Ldtki78qrW0NFhtnx4MjPYoBlEafSjGdf1M3yPuptV6yx/vVUwH1N
 fmn/zKjWhXCfDWpAnP0/wbuw6O4a+X5JH6s72GeodE2E1WzAI1oqVjnwYxkrmIIl12x2
 QGNx6rWTjk4SfkraQMH+aFr/b0pJAcv6btw5sqMybnUphkNU2g7pIGpdo7zQyEmZF94Y
 T/pg==
X-Gm-Message-State: AOJu0Yyrol13eJwh0j5NelPQzzX90yR1S8haaaOpssZZj4LHQBTp5SNw
 g95u3gn0/zudZldRFfR5Zkwf6T1WSEi8fovZ+Dc=
X-Google-Smtp-Source: AGHT+IE1DmzrMtjMZwr8UYvIf9SL46TkVX3Jjzeh9MSO8YChrpEkKTqya/o3qQqygCFCPoHNedjDq4varfsmoZ7Htfw=
X-Received: by 2002:a17:907:1c2a:b0:9b2:cf77:a105 with SMTP id
 nc42-20020a1709071c2a00b009b2cf77a105mr532999ejc.15.1698344489805; Thu, 26
 Oct 2023 11:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHnsOnP-8PY=pZw3n2jPKeMmiFqsQwp-Dai+dADpe+hskO2kQA@mail.gmail.com>
 <CAFEAcA83xO3XxuWTK1vdqnH6PKaBpPfNL8A8EyBC1AaGcqhZcg@mail.gmail.com>
In-Reply-To: <CAFEAcA83xO3XxuWTK1vdqnH6PKaBpPfNL8A8EyBC1AaGcqhZcg@mail.gmail.com>
From: Tanmay <tanmaynpatil105@gmail.com>
Date: Thu, 26 Oct 2023 23:51:18 +0530
Message-ID: <CAHnsOnM1tuwbr7tkF6-jE7bGMPEJs+uXPW-JyA_5AoPe1miTnA@mail.gmail.com>
Subject: Re: Replace calls to functions named cpu_physical_memory_* with
 address_space_*.
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "jsnow@redhat.com" <jsnow@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000056d0c0608a2a4c2"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=tanmaynpatil105@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000056d0c0608a2a4c2
Content-Type: text/plain; charset="UTF-8"

Yeah, I felt that it may not be a cakewalk as it might sound.

You're right, trying to understand the whole code is overwhelming. I'll
start with a small section instead.

I have interest in working on x86_64 and Aarch64 architectures within qemu.
Please let me know if there are any specific tasks from where I can start
exploring.

Thanks,
Tanmay

On Thu, 26 Oct 2023 at 22:16, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Thu, 26 Oct 2023 at 13:48, Tanmay <tanmaynpatil105@gmail.com> wrote:
> > I'm really interested in contributing to qemu. I wanted to
> > work on the renaming API calls cpu_physical_memory_* to
> > address_space_*. I couldn't find any related issues on the
> > GItlab tracker. Can I work on this issue?
>
> You're welcome to, but be aware that this is unfortunately
> one of the items in the "BiteSizedTasks" list that is
> not as simple as the one-line description makes it sound.
> (I have a personal project to try to go through that page and
> either expand entries into issues in gitlab that describe the
> task in more detail, or else delete them if they don't really
> seem to be "bite sized". But I haven't got very far with it yet,
> so there are still quite a few unhelpful "landmine" tasks on it.
> Sorry about that :-(  )
>
> It also is something where the right thing to do is going to
> depend on the call-site and what that particular device or piece
> of code is trying to do -- it is not a mechanical conversion.
> (This is partly why the conversion is not yet complete.)
>
> Most of the devices which use these functions should indeed
> use address_space_* functions instead, but the question then
> is "what address space should they access?". That usually ought
> to be one passed into them by the board code. (commit 112a829f8f0a
> is an example of that kind of conversion.) Unfortunately many
> of the remaining uses of cpu_physical_memory_* in hw/ are
> in very old code which hasn't even been converted to the
> kind of new device model coding style that would allow you to
> provide an address space by a QOM property that way. So for
> those devices this would be just one of a whole pile of
> "modernizations" and refactorings that need to be done.
>
> I think what I would suggest is that rather than starting
> with this task in general, that you start with what part
> of QEMU you're interested in working on in particular (eg
> whether you're interested in a particular target architecture
> or a particular subsystem like migration, etc), and then
> we can probably find some tasks that relate to that specific
> interest and help in starting to understand that part of the
> code. (QEMU as a whole is too big for anybody to understand
> all of it...) If what you want to work on turns out to
> involve one of the bits of code which needs this API upgrade,
> maybe we can help you work on that; but it might turn out that
> the two don't overlap at all, or that there's a better starting
> task.
>
> thanks
> -- PMM
>

--000000000000056d0c0608a2a4c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Yeah, I felt that it may not be a cakewalk as it might sou=
nd.<br><br>You&#39;re right, trying to understand the whole=C2=A0code is ov=
erwhelming. I&#39;ll start with a small section instead.<div><br>I have int=
erest in working on x86_64 and Aarch64 architectures within qemu.<div><div>=
Please let me know if there are any specific tasks from where I can start e=
xploring.</div><div><br></div><div>Thanks,</div><div>Tanmay</div></div></di=
v></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr=
">On Thu, 26 Oct 2023 at 22:16, Peter Maydell &lt;<a href=3D"mailto:peter.m=
aydell@linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">On Thu, 26 Oct 2023 at 13:48, Ta=
nmay &lt;<a href=3D"mailto:tanmaynpatil105@gmail.com" target=3D"_blank">tan=
maynpatil105@gmail.com</a>&gt; wrote:<br>
&gt; I&#39;m really interested in contributing to qemu. I wanted to<br>
&gt; work on the renaming API calls cpu_physical_memory_* to<br>
&gt; address_space_*. I couldn&#39;t find any related issues on the<br>
&gt; GItlab tracker. Can I work on this issue?<br>
<br>
You&#39;re welcome to, but be aware that this is unfortunately<br>
one of the items in the &quot;BiteSizedTasks&quot; list that is<br>
not as simple as the one-line description makes it sound.<br>
(I have a personal project to try to go through that page and<br>
either expand entries into issues in gitlab that describe the<br>
task in more detail, or else delete them if they don&#39;t really<br>
seem to be &quot;bite sized&quot;. But I haven&#39;t got very far with it y=
et,<br>
so there are still quite a few unhelpful &quot;landmine&quot; tasks on it.<=
br>
Sorry about that :-(=C2=A0 )<br>
<br>
It also is something where the right thing to do is going to<br>
depend on the call-site and what that particular device or piece<br>
of code is trying to do -- it is not a mechanical conversion.<br>
(This is partly why the conversion is not yet complete.)<br>
<br>
Most of the devices which use these functions should indeed<br>
use address_space_* functions instead, but the question then<br>
is &quot;what address space should they access?&quot;. That usually ought<b=
r>
to be one passed into them by the board code. (commit 112a829f8f0a<br>
is an example of that kind of conversion.) Unfortunately many<br>
of the remaining uses of cpu_physical_memory_* in hw/ are<br>
in very old code which hasn&#39;t even been converted to the<br>
kind of new device model coding style that would allow you to<br>
provide an address space by a QOM property that way. So for<br>
those devices this would be just one of a whole pile of<br>
&quot;modernizations&quot; and refactorings that need to be done.<br>
<br>
I think what I would suggest is that rather than starting<br>
with this task in general, that you start with what part<br>
of QEMU you&#39;re interested in working on in particular (eg<br>
whether you&#39;re interested in a particular target architecture<br>
or a particular subsystem like migration, etc), and then<br>
we can probably find some tasks that relate to that specific<br>
interest and help in starting to understand that part of the<br>
code. (QEMU as a whole is too big for anybody to understand<br>
all of it...) If what you want to work on turns out to<br>
involve one of the bits of code which needs this API upgrade,<br>
maybe we can help you work on that; but it might turn out that<br>
the two don&#39;t overlap at all, or that there&#39;s a better starting<br>
task.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000056d0c0608a2a4c2--


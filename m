Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0508E81920A
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 22:06:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFhGw-0001M0-If; Tue, 19 Dec 2023 16:05:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rFhGe-0001LT-6m
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 16:04:46 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1rFhGa-0004BS-GA
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 16:04:42 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a265d4f78bfso81953866b.0
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 13:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1703019877; x=1703624677;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3Ddt+4BUG81GQftfDLv9WS5F8tOZLI/o5Hu4dbsCS50=;
 b=XIuw8jeI8/+cqSu0YQ6p4cBluGnn3Rtr/3RfhE6iiQVKbd03Lzp8MDJUrd7wXNoGHV
 kA92TbGXjev/ExJsUS0rXQbPk1kGX3sLjcC+I4OhZL7CtUXjZk6pmqt30Nuu0T8pqHwH
 z8JJGw1Oqe5EFnywIcPQlrVRz2slmldHxfhKhkZimesF1mbqSxVJTmkFd96OazEfkY3+
 LZdn2REpEDfaNGXbO3xhwdIIn8fj7D0MerYLO8p6ihlU+Z0FTgidDiaxVGYgIb81C7rF
 H3d3CrhifPcKKqF8VnqUaklspRqOs+fdxVRkbH5SJblDAh2iL4bhErsrZEssOlzQwqhd
 X86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703019877; x=1703624677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Ddt+4BUG81GQftfDLv9WS5F8tOZLI/o5Hu4dbsCS50=;
 b=PcTGjnAXF92e/a65Tb/bxx1k0krHU67g2HFUs8k2LhLmbnSmP+KdYbVVEP4JhAGGpy
 1Tw0uR5kgGrfT0b2cNY6zjLVByfKkRdSL9/4rnvm1jOX3i8e0BEcCFyaghHa/vqcySGS
 W3EGhzg+YoRtX2zFgo/TxJrvpu0bfoLfsxhC8U2y27jWIzpo8uxBbY5qaIf265WkUm5/
 6cA+wtPnAToU8LY/gPa8l7/25U4oim42N6auG3sM64OWYG2mZfaIUajDtkCmYGrXYU6m
 lt3XQXm1EnDOhxfXuyYstNcZW++l6lFTFsxQktF2sNXFglHeY8NX578xsKD/8oW5Wz95
 +c/A==
X-Gm-Message-State: AOJu0Yw6cBURgeFGmK9h1iguZidWoiOSsxmaTBo45925yNApPWOpNbAn
 S96AO8M/mfjpND/qAoIxSQNa9GHMDrrIfMQGCLYTCsd9Ko4QPiKfuo0=
X-Google-Smtp-Source: AGHT+IFAgrqCJMQhpvehcXmV1EZcLs0mf34/C05ZgT/NC4xRQTX0dDznNUtZZx9ILcosPBExOo+kRxLq9Gw/gHSyWEc=
X-Received: by 2002:a17:906:270a:b0:a23:54a3:696e with SMTP id
 z10-20020a170906270a00b00a2354a3696emr2453766ejc.13.1703019876980; Tue, 19
 Dec 2023 13:04:36 -0800 (PST)
MIME-Version: 1.0
References: <20231219132135.c4bff4807c9d7215b179f240@killthe.net>
 <87plz22d9r.fsf@suse.de>
 <CAFEAcA-RJUUZo0KYujQskkAim_qXkJxtuSb9wtgxoP0XSEtKYQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-RJUUZo0KYujQskkAim_qXkJxtuSb9wtgxoP0XSEtKYQ@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 19 Dec 2023 14:04:25 -0700
Message-ID: <CANCZdfqX=URh2C+upKQPF9sg9TX6oZpHfrYF6rGRNz-6SdbhLw@mail.gmail.com>
Subject: Re: Qemu resets terminal to crazy defaults
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fabiano Rosas <farosas@suse.de>, Dave Blanchard <dave@killthe.net>, 
 QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000d02ed2060ce3362a"
Received-SPF: none client-ip=2a00:1450:4864:20::632;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

--000000000000d02ed2060ce3362a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023, 1:55=E2=80=AFPM Peter Maydell <peter.maydell@linaro.o=
rg>
wrote:

> On Tue, 19 Dec 2023 at 19:40, Fabiano Rosas <farosas@suse.de> wrote:
> >
> > Dave Blanchard <dave@killthe.net> writes:
> >
> > > Hello all, can you please help me to understand what Qemu is doing
> here?
> > >
> > > When connecting to the guest for example using a serial/tcp/telnet
> link, some kind of code is being immediately transmitted over the link
> which screws up my Xterm terminal settings, including changing the text
> cursor shape and most notably, disabling wraparound of long lines, so tha=
t
> they get truncated at the edge of the window instead.
> > >
> > > Can this behavior be disabled by command line, and if not, what is th=
e
> code doing exactly so I can know where to disable it? I tried disabling a=
ll
> calls to tcsetattr() but that had no effect.
>
> > I looked into the automatic margins issue a long time ago and I seem to
> > remember it was caused by the firmware (SeaBIOS) configuring the
> > terminal and QEMU just never returning it to the original state. I
> > eventually gave up trying to fix it because I was having trouble findin=
g
> > a reliable point in QEMU shutdown sequence to enable the capability
> > back. Nowadays I just run 'tput smam' after quitting QEMU.
>
> To check whether this is happening because of the BIOS (or other
> guest code) vs QEMU itself, you can try running QEMU in a configuration
> where it doesn't run any BIOS code. One I happen to know offhand
> is an arm one:
>
>    qemu-system-aarch64 -M virt -serial stdio
>
> This won't print anything, because we haven't loaded any guest
> code at all and there's no default BIOS on this machine type.
> (The emulated CPU is sat in effectively a tight loop taking
> exceptions.) If that messes up the terminal settings, then it's
> likely being done by something inside QEMU. If it doesn't, then
> it sounds like as you say it'll be because of the SeaBIOS
> firmware writing stuff to the terminal.
>
> (There might be a way to run the x86 PC machine without it
> running a BIOS, for a similar test, but I don't know if there
> is or how to do it off the top of my head.)
>
> I do know that QEMU doesn't clean up things the guest does
> to the terminal, because for instance if you have a serial
> terminal and the guest puts it into "emit boldface/bright",
> that doesn't go back to normal non-bold text when QEMU exits.
> (It would be nice if it did do that...)
>

It would be nice indeed. Trouble is quarrying the state beforehand to know
what to reset by random software producing effectively random bytes..

ESC c

is the reset sequence as well...but that's likely too big a hammer.

Warner

thanks
> -- PMM
>
>

--000000000000d02ed2060ce3362a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Dec 19, 2023, 1:55=E2=80=AFPM Peter Maydell &l=
t;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Tue, 19 Dec 2023 at 1=
9:40, Fabiano Rosas &lt;<a href=3D"mailto:farosas@suse.de" target=3D"_blank=
" rel=3D"noreferrer">farosas@suse.de</a>&gt; wrote:<br>
&gt;<br>
&gt; Dave Blanchard &lt;<a href=3D"mailto:dave@killthe.net" target=3D"_blan=
k" rel=3D"noreferrer">dave@killthe.net</a>&gt; writes:<br>
&gt;<br>
&gt; &gt; Hello all, can you please help me to understand what Qemu is doin=
g here?<br>
&gt; &gt;<br>
&gt; &gt; When connecting to the guest for example using a serial/tcp/telne=
t link, some kind of code is being immediately transmitted over the link wh=
ich screws up my Xterm terminal settings, including changing the text curso=
r shape and most notably, disabling wraparound of long lines, so that they =
get truncated at the edge of the window instead.<br>
&gt; &gt;<br>
&gt; &gt; Can this behavior be disabled by command line, and if not, what i=
s the code doing exactly so I can know where to disable it? I tried disabli=
ng all calls to tcsetattr() but that had no effect.<br>
<br>
&gt; I looked into the automatic margins issue a long time ago and I seem t=
o<br>
&gt; remember it was caused by the firmware (SeaBIOS) configuring the<br>
&gt; terminal and QEMU just never returning it to the original state. I<br>
&gt; eventually gave up trying to fix it because I was having trouble findi=
ng<br>
&gt; a reliable point in QEMU shutdown sequence to enable the capability<br=
>
&gt; back. Nowadays I just run &#39;tput smam&#39; after quitting QEMU.<br>
<br>
To check whether this is happening because of the BIOS (or other<br>
guest code) vs QEMU itself, you can try running QEMU in a configuration<br>
where it doesn&#39;t run any BIOS code. One I happen to know offhand<br>
is an arm one:<br>
<br>
=C2=A0 =C2=A0qemu-system-aarch64 -M virt -serial stdio<br>
<br>
This won&#39;t print anything, because we haven&#39;t loaded any guest<br>
code at all and there&#39;s no default BIOS on this machine type.<br>
(The emulated CPU is sat in effectively a tight loop taking<br>
exceptions.) If that messes up the terminal settings, then it&#39;s<br>
likely being done by something inside QEMU. If it doesn&#39;t, then<br>
it sounds like as you say it&#39;ll be because of the SeaBIOS<br>
firmware writing stuff to the terminal.<br>
<br>
(There might be a way to run the x86 PC machine without it<br>
running a BIOS, for a similar test, but I don&#39;t know if there<br>
is or how to do it off the top of my head.)<br>
<br>
I do know that QEMU doesn&#39;t clean up things the guest does<br>
to the terminal, because for instance if you have a serial<br>
terminal and the guest puts it into &quot;emit boldface/bright&quot;,<br>
that doesn&#39;t go back to normal non-bold text when QEMU exits.<br>
(It would be nice if it did do that...)<br></blockquote></div></div><div di=
r=3D"auto"><br></div><div dir=3D"auto">It would be nice indeed. Trouble is =
quarrying the state beforehand to know what to reset by random software pro=
ducing effectively random bytes..=C2=A0</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">ESC c</div><div dir=3D"auto"><br></div><div dir=3D"auto">is=
 the reset sequence as well...but that&#39;s likely too big a hammer.</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Warner</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
thanks<br>
-- PMM<br>
<br>
</blockquote></div></div></div>

--000000000000d02ed2060ce3362a--


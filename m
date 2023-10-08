Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F467BCFCE
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 21:31:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpZTd-0001hX-C6; Sun, 08 Oct 2023 15:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1qpZTa-0001hJ-QY
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 15:30:06 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1qpZTY-0000Ir-Bd
 for qemu-devel@nongnu.org; Sun, 08 Oct 2023 15:30:06 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d86a0c97ae6so4192169276.2
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 12:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1696793402; x=1697398202;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u7djnZdrNohL0cuEnDQEPH+lLV5//9FwK9zXMhWp3rs=;
 b=qjhaq5YICNWQKHxCyqL18cufcHnIaZchPedPl2C3hSSwuUHthbrRaQl+Ns5mQKFXI/
 252jn+v+J8PuceyYe79R/2cn+NSSj07x3xe/AbmPhDDMvEkXrlQPf1OuO8/bvZku6CtL
 xBDcDnM1fCgY964IszTbIeEK2d1YjV//np3s7ZGCakS3JmbfQwVGDoFhD4B39iWJPq7V
 V6Kgd8/0Ws2sTkAZD51L+blI1c/cDjbbS25qxpOSGOHWqh7Zur1L84GDfkEf4PG+npAA
 m5yV+JDplzhNVXXKvkRlUnWHdirdda2MtrqHUEZFw4HwgGI7PUFFF+GPhFxnwiU6OSFF
 ukSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696793402; x=1697398202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u7djnZdrNohL0cuEnDQEPH+lLV5//9FwK9zXMhWp3rs=;
 b=PxoLsDEYLza+TVW8jJi0Y4KTZNeWAJZj7Qy7AvYu4tjzeQKqgR3kKKaq9KhEAQU9fY
 CDeN9HBUJ8X8v25YovIMXcFw2akSySCXUmCB3nl+eSIFObOaLT1I7TPeiTSCX1EFucyZ
 iNz9JF5yUmSwrqU9dpnOpH7NuBQ+VzsrCmovF/dkJ1Bpn0/4alI1kl9f71ZvEsTL37Vc
 7YCCd4fEulfUu6IELi13WS9dDtB7hvEbUo8KR4r6zU4+9kgVUbey502UeKHndoBNbuYr
 4nioC4bJSIR+FFR8J5UrdVhDQslvuLKHiahxKtKyuZk+ppOkK9oAC3us/DC9tEfgNMY9
 vkhw==
X-Gm-Message-State: AOJu0Yx6Ecei+neURbZ/5+OQFanxN1qOFgVgrmcGjduQQH6gJdtliGMR
 Kth49R2lch90QEo+WmS0mmLpHKvvTMgqjl8ViEZrrA==
X-Google-Smtp-Source: AGHT+IHMkVZCuzpVuc8UXXlxo/I7qHnhcjTJCnF8zxNdonb4Gz6d3+0A1BJqg8IMv/qk38QDh1Au5i99wWfOhFyQRAY=
X-Received: by 2002:a05:6902:c7:b0:d80:4533:9556 with SMTP id
 i7-20020a05690200c700b00d8045339556mr10276901ybs.63.1696793402085; Sun, 08
 Oct 2023 12:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230922140914.13906-1-phil@philjordan.eu>
 <20230922140914.13906-3-phil@philjordan.eu>
 <ZSLzq33DgMNYBsQT@roolebo.dev>
 <CAAibmn35JypPWfUophMgONTkgbYFvaaRhuD9+1kif9EOFx9HxQ@mail.gmail.com>
 <ZSMAr3hhxJryGpya@roolebo.dev>
In-Reply-To: <ZSMAr3hhxJryGpya@roolebo.dev>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sun, 8 Oct 2023 21:29:51 +0200
Message-ID: <CAAibmn3cMjnNWsQs8yCetc__Kr+ujn6Gn_ohGubVA3hCQbBy1w@mail.gmail.com>
Subject: Re: [PATCH 2/3] i386: hvf: In kick_vcpu use hv_vcpu_interrupt to
 force exit
To: Roman Bolshakov <roman@roolebo.dev>
Cc: qemu-devel@nongnu.org, dirty@apple.com, rbolshakov@ddn.com, 
 lists@philjordan.eu
Content-Type: multipart/alternative; boundary="000000000000fd29850607397f90"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::b30;
 envelope-from=phil@philjordan.eu; helo=mail-yb1-xb30.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000fd29850607397f90
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 8 Oct 2023 at 21:19, Roman Bolshakov <roman@roolebo.dev> wrote:

> > I assume that's with patch 3/3 applied as well? The fact you've
> > repro'd it with just these patch would explain why I've not been able
> > to fix it on the APIC side=E2=80=A6
> >
>
> Yes, I applied with patch 3/3 and then retested only with the first two
> patches.
>

OK, interesting that it would happen without patch 3 as well.


> > > FWIW. I recall a few years ago I submitted a similar patch that does
> > > something similar but addresses a few more issues:
> > >
> > >
> https://patchwork.kernel.org/project/qemu-devel/patch/20200729124832.7937=
5-1-r.bolshakov@yadro.com/
> > >
> > > I don't remember why it never got merged.
> > >
> >
> > Looks like the VM kick might be a more complex undertaking than I was
> > anticipating. I'll try to repro the problem you ran into, and then look
> > over your original patch and make sense of it. Hopefully an updated
> version
> > of your 'kick' implementation will work well in combination with the
> > newer hv_vcpu_run_until() API from patch 3/3. I'll keep you posted.
> >
>
> Apparently I left a note that some interrupts weren't delivered even
> with my patch and I was not able figure out the reason back then. I had
> another attempt to debug this two weeks later after I submitted v4 and I
> can find a WIP branch on github where I added a Debug Registers support
> patch and some tracepoints:
>
> https://github.com/qemu/qemu/compare/master...roolebo:qemu:hvf-debug-kick
>
> Perhaps that's where we should start from besides the obvious need of
> rebase.
>

Sounds good, I'll take a look at those changes and try to work out what to
do next.


> With regards to hv_vcpu_run_until() I can find the following thread:
> https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg09468.html
>
> > hv_vcpu_run_until() was also evaluated on macOS 10.15.5 but it degrades
> > VM performance significantly compared to explicit setting of
> > VMX-preepmtion timer value and hv_vcpu_run(). The performance issue was
> > observed on Broadwell-based MacBook Air and Ivy Bridge-based MacBook
> > Pro.
> >
> > macOS 11.0 Beta deprecated hv_vcpu_run() and introduced a special
> > declaration for hv_vcpu_run_until(), that's not available 10.15 -
> > HV_DEADLINE_FOREVER (UINT64_MAX, which is bigger than maximum value of
> > VMX-preeemption counter). Perhaps the performance issue is addressed
> > there.
>
> All discussion with Paolo might be helpful, particurlarly:
> https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg09893.html
>
> > So, I've tried Big Sur Beta and it has exactly the same performance
> > issue with hv_vcpu_run_until() while hv_vcpu_run() works as good as it
> > worked on 10.15.5. I've submitted FB7827341 to Apple wrt the issue.
>
> In November 2020, Apple responded to FB7827341 that there's an issue on
> QEMU side.
>

Hmm, that's interesting. I'll need to work my way through that thread, but
I'll point out that in my testing with SMP guests, I measured a performance
*improvement* with the hv_vcpu_run_until() API (and the forever deadline)
versus hv_vcpu_run(), as it significantly reduced BQL contention - with so
many VMEXITs, vCPU threads were spending a lot of time waiting for the lock=
.

--000000000000fd29850607397f90
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Sun, 8 Oct 2023 at 21:19, Roman Bolsha=
kov &lt;<a href=3D"mailto:roman@roolebo.dev">roman@roolebo.dev</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; I assume=
 that&#39;s with patch 3/3 applied as well? The fact you&#39;ve<br>
&gt; repro&#39;d it with just these patch would explain why I&#39;ve not be=
en able<br>
&gt; to fix it on the APIC side=E2=80=A6<br>
&gt; <br>
<br>
Yes, I applied with patch 3/3 and then retested only with the first two<br>
patches.<br></blockquote><div><br></div><div>OK, interesting that it would =
happen without patch 3 as well.</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
&gt; &gt; FWIW. I recall a few years ago I submitted a similar patch that d=
oes<br>
&gt; &gt; something similar but addresses a few more issues:<br>
&gt; &gt;<br>
&gt; &gt; <a href=3D"https://patchwork.kernel.org/project/qemu-devel/patch/=
20200729124832.79375-1-r.bolshakov@yadro.com/" rel=3D"noreferrer" target=3D=
"_blank">https://patchwork.kernel.org/project/qemu-devel/patch/202007291248=
32.79375-1-r.bolshakov@yadro.com/</a><br>
&gt; &gt;<br>
&gt; &gt; I don&#39;t remember why it never got merged.<br>
&gt; &gt;<br>
&gt; <br>
&gt; Looks like the VM kick might be a more complex undertaking than I was<=
br>
&gt; anticipating. I&#39;ll try to repro the problem you ran into, and then=
 look<br>
&gt; over your original patch and make sense of it. Hopefully an updated ve=
rsion<br>
&gt; of your &#39;kick&#39; implementation will work well in combination wi=
th the<br>
&gt; newer hv_vcpu_run_until() API from patch 3/3. I&#39;ll keep you posted=
.<br>
&gt; <br>
<br>
Apparently I left a note that some interrupts weren&#39;t delivered even<br=
>
with my patch and I was not able figure out the reason back then. I had<br>
another attempt to debug this two weeks later after I submitted v4 and I<br=
>
can find a WIP branch on github where I added a Debug Registers support<br>
patch and some tracepoints:<br>
<br>
<a href=3D"https://github.com/qemu/qemu/compare/master...roolebo:qemu:hvf-d=
ebug-kick" rel=3D"noreferrer" target=3D"_blank">https://github.com/qemu/qem=
u/compare/master...roolebo:qemu:hvf-debug-kick</a><br>
<br>
Perhaps that&#39;s where we should start from besides the obvious need of<b=
r>
rebase.<br></blockquote><div><br></div><div>Sounds good, I&#39;ll take a lo=
ok at those changes and try to work out what to do next.</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
With regards to hv_vcpu_run_until() I can find the following thread:<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg0946=
8.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/archi=
ve/html/qemu-devel/2020-06/msg09468.html</a><br>
<br>
&gt; hv_vcpu_run_until() was also evaluated on macOS 10.15.5 but it degrade=
s<br>
&gt; VM performance significantly compared to explicit setting of<br>
&gt; VMX-preepmtion timer value and hv_vcpu_run(). The performance issue wa=
s<br>
&gt; observed on Broadwell-based MacBook Air and Ivy Bridge-based MacBook<b=
r>
&gt; Pro.<br>
&gt; <br>
&gt; macOS 11.0 Beta deprecated hv_vcpu_run() and introduced a special<br>
&gt; declaration for hv_vcpu_run_until(), that&#39;s not available 10.15 -<=
br>
&gt; HV_DEADLINE_FOREVER (UINT64_MAX, which is bigger than maximum value of=
<br>
&gt; VMX-preeemption counter). Perhaps the performance issue is addressed<b=
r>
&gt; there.<br>
<br>
All discussion with Paolo might be helpful, particurlarly:<br>
<a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2020-06/msg0989=
3.html" rel=3D"noreferrer" target=3D"_blank">https://lists.nongnu.org/archi=
ve/html/qemu-devel/2020-06/msg09893.html</a><br>
<br>
&gt; So, I&#39;ve tried Big Sur Beta and it has exactly the same performanc=
e<br>
&gt; issue with hv_vcpu_run_until() while hv_vcpu_run() works as good as it=
<br>
&gt; worked on 10.15.5. I&#39;ve submitted FB7827341 to Apple wrt the issue=
.<br>
<br>
In November 2020, Apple responded to FB7827341 that there&#39;s an issue on=
<br>
QEMU side.<br></blockquote><div><br></div><div>Hmm, that&#39;s interesting.=
 I&#39;ll need to work my way through that thread, but I&#39;ll point out t=
hat in my testing with SMP guests, I measured a performance *improvement* w=
ith the=C2=A0hv_vcpu_run_until() API (and the forever deadline) versus hv_v=
cpu_run(), as it significantly reduced BQL contention - with so many VMEXIT=
s, vCPU threads were spending a lot of time waiting for the lock.</div><div=
><br></div><div><br></div></div></div>

--000000000000fd29850607397f90--


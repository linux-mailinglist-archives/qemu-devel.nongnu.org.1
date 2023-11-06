Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5727E266E
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:16:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00OH-0007fB-H5; Mon, 06 Nov 2023 09:15:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1r00O8-0007ZV-UK
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:15:37 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1r00O6-0004H7-Qp
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:15:36 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a7fb84f6ceso47847337b3.1
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1699280132; x=1699884932;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qKJ9yAKrrbkrYK2WaAH0CGJg5UQnpLX4LeD1O8VDjBI=;
 b=RPGkSKpEJn1hO7LykNqCtqWLODBMv3k2EFj1cmU5DB6Y4QhDQcvmEN3NZuIIP0BBdK
 SQQDTLxItR1YVgY4mZjnQgYtV53ViREHQ+Zsd0dNqTKwCpBvigv/hgaPUbmcZEpKUOy1
 m/+kYoI+yfz7/U6TGkDllOtcGxb1hG1EB9PCC2/xSt6NAaPcD5frFreoTpOoVXNf7zKQ
 6dV8R7OMpi/6i193mZVXgJTPE7hkCKzSZO4qO0T0NT7yv11+Sk31m22bCFWHrLHYwDhz
 ccsD37QgIiIwfaBg6iFZNUpEURz92RThLSrI+96q9+jsLTYw0DbcWEYvUjoo665tSDxE
 qyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699280132; x=1699884932;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qKJ9yAKrrbkrYK2WaAH0CGJg5UQnpLX4LeD1O8VDjBI=;
 b=XnprtLKTC1ceh/UqLVvMcB7n1KSCwi9vO2Ie9IhaiTlA2XA+dh7xVi0SrT+4UeeU9c
 R4IW5UQq0qWn9VUmnCuwcG9rJmC8+p4wSw7ajGZe2S/usCSKxTk9A6BJHSFsf73fjkOG
 ZWmweshxn3N6mKXXAS6mCJg9DBu7TmX2CUt02NLOxl4MOLFKFdINbwD/WU9h1Hr+gFmd
 E9O4oN1kFlXQsmRYjiQkV+rTtNGfB2zaTXYYePMI29gaYdS0Q41fAGHfCSGxl1rvnDsN
 jyYDNARWTg/ifGbZn7Ux1a+CxAVNZtTkHWtkckahg70JlKGM4bnfYetdtvoeT+5w56d7
 z3pg==
X-Gm-Message-State: AOJu0Yw1gNhijcGQfGY6UkQgJPFMMdUVA5PdaUgFAIQWWn+lr9LGAEx1
 LPt2ZD5673dHOwEsfUREbMKVk0p3xA0Lngk9MsYASA==
X-Google-Smtp-Source: AGHT+IHeLHDwgHqC31J+ig0cLMT+WJOmHmm/l+VIs661N/8s/W81gLZ31emhhP3oJisRw6T2SIYIM7+uTnkA4W3PhYc=
X-Received: by 2002:a25:410e:0:b0:d9c:a3b8:f39d with SMTP id
 o14-20020a25410e000000b00d9ca3b8f39dmr23055569yba.65.1699280132268; Mon, 06
 Nov 2023 06:15:32 -0800 (PST)
MIME-Version: 1.0
References: <20230922140914.13906-1-phil@philjordan.eu>
 <20230922140914.13906-3-phil@philjordan.eu>
 <ZSLzq33DgMNYBsQT@roolebo.dev>
 <CAAibmn35JypPWfUophMgONTkgbYFvaaRhuD9+1kif9EOFx9HxQ@mail.gmail.com>
 <ZSMAr3hhxJryGpya@roolebo.dev>
 <CAAibmn3cMjnNWsQs8yCetc__Kr+ujn6Gn_ohGubVA3hCQbBy1w@mail.gmail.com>
 <CAGCz3vu=sX1m4PJiOvtTBza4iNUy6Hj+AtSAFi33zJ=dz_r7UA@mail.gmail.com>
 <CAGCz3vt2VB9i8+o-qFPpDptu81p3r00-TKfCV3O+=dQ0r3d88w@mail.gmail.com>
 <ZUey_ZynRm9XwQLD@roolebo.dev>
In-Reply-To: <ZUey_ZynRm9XwQLD@roolebo.dev>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Mon, 6 Nov 2023 15:15:21 +0100
Message-ID: <CAAibmn30d9EjtDrXrR8d1dg=hsA96WbajdiFdQkR=LXsbz_PYA@mail.gmail.com>
Subject: Re: [PATCH 2/3] i386: hvf: In kick_vcpu use hv_vcpu_interrupt to
 force exit
To: Roman Bolshakov <roman@roolebo.dev>
Cc: Phil Dennis-Jordan <lists@philjordan.eu>, qemu-devel@nongnu.org,
 dirty@apple.com, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000a896a106097c7c94"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::112d;
 envelope-from=phil@philjordan.eu; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

--000000000000a896a106097c7c94
Content-Type: text/plain; charset="UTF-8"

Hi Roman,

On Sun, 5 Nov 2023 at 16:21, Roman Bolshakov <roman@roolebo.dev> wrote:

> > This got me digging into how dirty memory tracking is actually
> > implemented in the Qemu hvf backend, and basically, it should never
> > have worked in the first place. When we get a write fault, the code
> > marks the *whole* 'logged' memory range as writable rather than just
> > the page that's just been dirtied. It just so happens that hv_vcpu_run
> > was causing EPT fault exits on those pages even after marking them
> > writable (?), and hv_vcpu_run_until() no longer does that. So
> > basically, this has been a Qemu bug masked by undesirable
> > hv_vcpu_run() behaviour. I'll start putting together a fix for this.
> >
>
> Sounds good, have you got anything to test or review? Meanwhile, I'll
> review the pending patches you sent.
>

Sorry, I've likewise been busy with other things the last 2-3 weeks.

As far as I'm aware, we don't actually know 100% for certain if there's a
race condition when using hv_vcpu_interrupt(), right? (As I mentioned, the
patches with hv_vcpu_run_until and a hv_vcpu_interrupt-only kick have been
running without issue for months on dozens to hundreds of VMs.) So before
we add the complexity of the hybrid hv_vcpu_interrupt & signal-based kick
to the codebase, I'd like to test out hv_vcpu_interrupt's behaviour in
isolation and actually force the edge cases we're worried about. But yeah,
I haven't got around to doing that yet. :-) I'm hoping to take a crack at
it later this week or next week, probably using
https://github.com/mist64/hvdos as a starting point.

Thanks for reviewing and testing the first set of patches!

Phil

--000000000000a896a106097c7c94
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Roman,</div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Sun, 5 Nov 2023 at 16:21, Roman Bolshakov=
 &lt;<a href=3D"mailto:roman@roolebo.dev">roman@roolebo.dev</a>&gt; wrote:<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; This got me digging into how dirty memory tracking is actually<br>
&gt; implemented in the Qemu hvf backend, and basically, it should never<br=
>
&gt; have worked in the first place. When we get a write fault, the code<br=
>
&gt; marks the *whole* &#39;logged&#39; memory range as writable rather tha=
n just<br>
&gt; the page that&#39;s just been dirtied. It just so happens that hv_vcpu=
_run<br>
&gt; was causing EPT fault exits on those pages even after marking them<br>
&gt; writable (?), and hv_vcpu_run_until() no longer does that. So<br>
&gt; basically, this has been a Qemu bug masked by undesirable<br>
&gt; hv_vcpu_run() behaviour. I&#39;ll start putting together a fix for thi=
s.<br>
&gt; <br>
<br>
Sounds good, have you got anything to test or review? Meanwhile, I&#39;ll<b=
r>
review the pending patches you sent.<br></blockquote><div><br></div><div>So=
rry, I&#39;ve likewise been busy with other things the last 2-3 weeks.</div=
><div><br></div><div>As far as I&#39;m aware, we don&#39;t actually know 10=
0% for certain if there&#39;s a race condition when using hv_vcpu_interrupt=
(), right? (As I mentioned, the patches with=C2=A0hv_vcpu_run_until and a h=
v_vcpu_interrupt-only kick have been running without issue for months on do=
zens to hundreds of VMs.) So before we add the complexity of the hybrid hv_=
vcpu_interrupt &amp; signal-based kick to the codebase, I&#39;d like to tes=
t out=C2=A0hv_vcpu_interrupt&#39;s behaviour in isolation and actually forc=
e the edge cases we&#39;re worried about. But yeah, I haven&#39;t got aroun=
d to doing that yet. :-) I&#39;m hoping to take a crack at it later this we=
ek or next week, probably using <a href=3D"https://github.com/mist64/hvdos"=
>https://github.com/mist64/hvdos</a> as a starting point.</div><div><br></d=
iv><div>Thanks for reviewing and testing the first set of patches!</div><di=
v><br></div><div>Phil</div><div><br></div></div></div>

--000000000000a896a106097c7c94--


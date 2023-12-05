Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACD8804DC9
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 10:28:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rARi4-0000Q9-Sk; Tue, 05 Dec 2023 04:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tianren@smartx.com>)
 id 1rARi1-0000PY-Mh
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 04:27:17 -0500
Received: from mail-vs1-xe29.google.com ([2607:f8b0:4864:20::e29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tianren@smartx.com>)
 id 1rARhy-0005bT-GA
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 04:27:17 -0500
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-46487cb65f4so675795137.2
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 01:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1701768311; x=1702373111;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=alfYEO8YL6mCXRCYARWwyhLx9ixkmPWCkgCFxwmvq0Q=;
 b=eLrLy+cbI3lrbywDvZ+W7Bs+dCeD+RrGEj5gFRsqYyMv2qJr4KeGfStcXIS0zXWTEH
 zknSV7Re1UXzc7gQcarSlP7twwjdPI12UlLN4gKEp1XVSGYuqUhpDCUH2XAj4Rd7k8a5
 fTZ07se85jROABAbAtRHM1MUa/zhr9iUAmOgUAxFCqrWp88WAYz1CcC+b+Sxwn3Ev/Uy
 T8at72Kbt/oGu5dS0RKa0Dw8y6O0Ow8RCqI/Ur/CyU/XkwoF9lCaKGLous699K+j8qEH
 jVJkQZXGw7v54Mrk3HaVR0aYxBxMVt62OaDlPsqGHqHUoglClBJ6r5QWGr244itlPRRc
 CLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701768311; x=1702373111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=alfYEO8YL6mCXRCYARWwyhLx9ixkmPWCkgCFxwmvq0Q=;
 b=QV7m5p+/vn12C7ZEmmnaR0Wa4GIgh7c4N2O9WLDraAkHI6NSgwnFHdrroIMQIx4y8W
 ekBXHGljvePXrDKU5RUfZCWIIY2nqlIVGH0HEfy557sgY5y2uLnNPJwzaoFGmeu/itGB
 du9bgP2+0437IstnYp6sUKo4Qm5rkVM5LIe9os5Mif1ryv7bbE6NW+U/d2BdmXyQmn8y
 MBfFE0YF/OCZNRBSfPfx4qW6AK0vRONN/fXkE12h7u0sAnU0wnhGp8mxkC4CCQATqYtJ
 SMEk97O811EfJqY/85Kd667Ptyeuq5WshvADbB72DJD14w6qb3WnFQ/kB7PsJYpKCR8w
 zNPA==
X-Gm-Message-State: AOJu0YwRXGrH0DKXamWJS48D3eJ58Iv1r3FVjmacbYMmeyuOjSgRlncW
 mhhBwSgU18pdctcS7ZT7E/EuIc8crY+DzzraeDAhYg==
X-Google-Smtp-Source: AGHT+IFrqvJlUNX+7q8hi5fGqIffSJp0KfpCPyIttdfD/2DJfJLbgGm3zlKE98RPYxqPAMtDqISB48k2rGTpgczqqQU=
X-Received: by 2002:a67:b64d:0:b0:464:77f2:556 with SMTP id
 e13-20020a67b64d000000b0046477f20556mr2938126vsm.40.1701768310710; Tue, 05
 Dec 2023 01:25:10 -0800 (PST)
MIME-Version: 1.0
References: <20231205064826.5000-1-tianren@smartx.com>
 <ZW7b0SwY6SKMC6zo@redhat.com>
In-Reply-To: <ZW7b0SwY6SKMC6zo@redhat.com>
From: Tianren Zhang <tianren@smartx.com>
Date: Tue, 5 Dec 2023 17:24:59 +0800
Message-ID: <CAL8o+bgMYYzGYA_Qhr+TbkFYeDxox2v+-HCqc4A7Bsh4zv59FQ@mail.gmail.com>
Subject: Re: [PATCH v2] qemu: send stop event after bdrv_flush_all
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com
Content-Type: multipart/alternative; boundary="000000000000a678d4060bbfcfba"
Received-SPF: none client-ip=2607:f8b0:4864:20::e29;
 envelope-from=tianren@smartx.com; helo=mail-vs1-xe29.google.com
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

--000000000000a678d4060bbfcfba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the update. I have sent the v3 removing the irrelevant
information:
https://patchew.org/QEMU/20231205091903.3640-1-tianren@smartx.com/

Best,
Tianren Zhang

On Tue, Dec 5, 2023 at 4:14=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

> On Tue, Dec 05, 2023 at 01:48:26AM -0500, tianren@smartx.com wrote:
> > From: Tianren Zhang <tianren@smartx.com>
> >
> > The stop process is not finished until bdrv_flush_all
> > is done. Some users (e.g., libvirt) detect the STOP
> > event and invokes some lock release logic to revoke
> > the disk lock held by current qemu when such event is
> > emitted. In such case, if the bdrv_flush_all is after
> > the stop event, it's possible that the disk lock is
> > released while the qemu is still waiting for I/O.
> > Therefore, it's better to have the stop event generated
> > after the whole stop process is done, so we can
> > guarantee to users that the stop process is finished
> > when they get the STOP event.
> >
> > Change-Id: Ia2f95cd55edfdeb71ee2e04005ac216cfabffa22
>
> Please don't include this in commit messages for patches posted.
> QEMU does not use Gerrit and so this is irrelevant to upstream.
>
> > Signed-off-by: Tianren Zhang <tianren@smartx.com>
> > ---
> > v2: do not call runstate_is_running twice
> > ---
> >  system/cpus.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> >
> > diff --git a/system/cpus.c b/system/cpus.c
> > index a444a747f0..49af0f92b5 100644
> > --- a/system/cpus.c
> > +++ b/system/cpus.c
> > @@ -262,21 +262,24 @@ void cpu_interrupt(CPUState *cpu, int mask)
> >  static int do_vm_stop(RunState state, bool send_stop)
> >  {
> >      int ret =3D 0;
> > +    bool do_send_stop =3D false;
> >
> >      if (runstate_is_running()) {
> >          runstate_set(state);
> >          cpu_disable_ticks();
> >          pause_all_vcpus();
> >          vm_state_notify(0, state);
> > -        if (send_stop) {
> > -            qapi_event_send_stop();
> > -        }
> > +        do_send_stop =3D send_stop;
> >      }
> >
> >      bdrv_drain_all();
> >      ret =3D bdrv_flush_all();
> >      trace_vm_stop_flush_all(ret);
> >
> > +    if (do_send_stop) {
> > +        qapi_event_send_stop();
> > +    }
> > +
> >      return ret;
> >  }
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--000000000000a678d4060bbfcfba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks for the update. I have sent the v3 removing the irr=
elevant information:=C2=A0<a href=3D"https://patchew.org/QEMU/2023120509190=
3.3640-1-tianren@smartx.com/">https://patchew.org/QEMU/20231205091903.3640-=
1-tianren@smartx.com/</a><div><br></div><div>Best,</div><div>Tianren Zhang<=
/div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Tue, Dec 5, 2023 at 4:14=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a =
href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Dec 05, 2023=
 at 01:48:26AM -0500, <a href=3D"mailto:tianren@smartx.com" target=3D"_blan=
k">tianren@smartx.com</a> wrote:<br>
&gt; From: Tianren Zhang &lt;<a href=3D"mailto:tianren@smartx.com" target=
=3D"_blank">tianren@smartx.com</a>&gt;<br>
&gt; <br>
&gt; The stop process is not finished until bdrv_flush_all<br>
&gt; is done. Some users (e.g., libvirt) detect the STOP<br>
&gt; event and invokes some lock release logic to revoke<br>
&gt; the disk lock held by current qemu when such event is<br>
&gt; emitted. In such case, if the bdrv_flush_all is after<br>
&gt; the stop event, it&#39;s possible that the disk lock is<br>
&gt; released while the qemu is still waiting for I/O.<br>
&gt; Therefore, it&#39;s better to have the stop event generated<br>
&gt; after the whole stop process is done, so we can<br>
&gt; guarantee to users that the stop process is finished<br>
&gt; when they get the STOP event.<br>
&gt;<br>
&gt; Change-Id: Ia2f95cd55edfdeb71ee2e04005ac216cfabffa22<br>
<br>
Please don&#39;t include this in commit messages for patches posted.<br>
QEMU does not use Gerrit and so this is irrelevant to upstream.<br>
<br>
&gt; Signed-off-by: Tianren Zhang &lt;<a href=3D"mailto:tianren@smartx.com"=
 target=3D"_blank">tianren@smartx.com</a>&gt;<br>
&gt; ---<br>
&gt; v2: do not call runstate_is_running twice<br>
&gt; ---<br>
&gt;=C2=A0 system/cpus.c | 9 ++++++---<br>
&gt;=C2=A0 1 file changed, 6 insertions(+), 3 deletions(-)<br>
<br>
Reviewed-by: Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.=
com" target=3D"_blank">berrange@redhat.com</a>&gt;<br>
<br>
&gt; <br>
&gt; diff --git a/system/cpus.c b/system/cpus.c<br>
&gt; index a444a747f0..49af0f92b5 100644<br>
&gt; --- a/system/cpus.c<br>
&gt; +++ b/system/cpus.c<br>
&gt; @@ -262,21 +262,24 @@ void cpu_interrupt(CPUState *cpu, int mask)<br>
&gt;=C2=A0 static int do_vm_stop(RunState state, bool send_stop)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int ret =3D 0;<br>
&gt; +=C2=A0 =C2=A0 bool do_send_stop =3D false;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (runstate_is_running()) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 runstate_set(state);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_disable_ticks();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pause_all_vcpus();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vm_state_notify(0, state);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (send_stop) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_event_send_stop();<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 do_send_stop =3D send_stop;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 bdrv_drain_all();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ret =3D bdrv_flush_all();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 trace_vm_stop_flush_all(ret);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 if (do_send_stop) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qapi_event_send_stop();<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 return ret;<br>
&gt;=C2=A0 }<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div>

--000000000000a678d4060bbfcfba--


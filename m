Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22996763E60
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 20:27:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOiDE-0000mb-J5; Wed, 26 Jul 2023 13:22:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qOiDB-0000mG-TL
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qOiD9-000274-QX
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 13:22:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690392126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xL6mGaKw2iv+tvrPBW3SG1zUzyFUA3y5rmCU+D8ZWPU=;
 b=NjE2V8KAGr0qGxjq9Fs1ewjNrgrGFPj1K1DvxAHtnuAPis/NENAeo88FoVavLOsOJ3FwX7
 095wfya5ZfPZKKTSC9kKOmrIFyFIHN3j8uniFuMwrFvXA3B8Eebens+w31oASAuflHvKdo
 st6ScPlkZg7aM7YGhX4OO/Cfpiw2F8g=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-E4MGoIzpMDeV0ia-wZ9_lQ-1; Wed, 26 Jul 2023 13:22:04 -0400
X-MC-Unique: E4MGoIzpMDeV0ia-wZ9_lQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2680007cdeaso70239a91.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jul 2023 10:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690392123; x=1690996923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xL6mGaKw2iv+tvrPBW3SG1zUzyFUA3y5rmCU+D8ZWPU=;
 b=ecBflTqxJH7Cldsmn5La6WWv4PSkpHaTfN6dkdR3tMpqY5jucHLyYrSTmKRlwun8gw
 VagdePRJgQMnNXVk13Yr85HOQ8heNnxCxasm0GQcr/cuRtNlN3Wz1/UkUopxugRhOivj
 QQ7Rba83i8uOS5J3wr1/ymWwOIBs0xZsBo42nZtozkkGGvqFSjYKnsyCZjv9X3/zKEbh
 wgNITX5KuFZZRabmBsL6wRPcl98qUvIVjcyoPE/CFlg7nvrJLt9YKRGo9RGiGHMIhtf9
 N05UchlXtIDR3YGcaMpigDwGxpGG9u+Oe/BkZHsOxWg3QIOQmnzYg27GbdDj5xMOmJqZ
 SQIw==
X-Gm-Message-State: ABy/qLZhcARys/+Azp/8UJ+m17pko9hgNjL0h3vFuvSzEC6dqUOwJh8H
 BL/5mLo/w3odcCEnr03RRZo9GCDalZ3MFLuel52FdwKgKHl3LYPm+UZx0Y5E0y7E2Zd/dHLSEvW
 iTjo5h+VUDQ023qa5ZE3NkfXxptqmvcY=
X-Received: by 2002:a17:90a:c253:b0:263:f590:f231 with SMTP id
 d19-20020a17090ac25300b00263f590f231mr2218099pjx.26.1690392123350; 
 Wed, 26 Jul 2023 10:22:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFXMw61I3WFx3UFGMpvwTMgrmgqFd7sX1LmAWxKtKNl9aoSxC4gaMCFVcz6ZQpiqLYv7fPJ6XgssLoO/862208=
X-Received: by 2002:a17:90a:c253:b0:263:f590:f231 with SMTP id
 d19-20020a17090ac25300b00263f590f231mr2218093pjx.26.1690392123058; Wed, 26
 Jul 2023 10:22:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230725180337.2937292-1-jsnow@redhat.com>
 <20230725180337.2937292-5-jsnow@redhat.com>
 <B867C4E8-24FC-4C4E-9FE8-2353CC21320C@redhat.com>
In-Reply-To: <B867C4E8-24FC-4C4E-9FE8-2353CC21320C@redhat.com>
From: John Snow <jsnow@redhat.com>
Date: Wed, 26 Jul 2023 13:21:51 -0400
Message-ID: <CAFn=p-bdA5cVMmsUkE0os0CVT6XMXzWk2M3UcKb0DFQmi130Mg@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] python/machine: use socketpair() for console
 connections
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, 
 Qemu-block <qemu-block@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>,
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, Daniel Berrange <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000006c7cd06016716db"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000006c7cd06016716db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2023, 6:50 AM Ani Sinha <anisinha@redhat.com> wrote:

>
>
> > On 25-Jul-2023, at 11:33 PM, John Snow <jsnow@redhat.com> wrote:
> >
> > Create a socketpair for the console output. This should help eliminate
> > race conditions around console text early in the boot process that migh=
t
> > otherwise have been dropped on the floor before being able to connect t=
o
> > QEMU under "server,nowait".
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Thanks for doing this. I recall we spoke about this late last year in the
> context of fixing my bios-bits avocado test and adding a console output
> there.
>

Yep! I think you need a few more changes to do what you wanted. IIRC, you
also want to be able to drain the console log while waiting for the vm to
terminate of its own accord, which I don't support yet.

(If you use console socket's self draining mode, it should be possible to
forego the early termination of the console socket and allow this behavior.
Maybe I can work that in now...)

Anything else I'm forgetting ...?

Except the concern below,
>
> Reviewed-by: Ani Sinha <anisinha@redhat.com>
>

Thanks =F0=9F=98=8A


>
> > ---
> > python/qemu/machine/machine.py | 30 +++++++++++++++++++++++++++---
> > 1 file changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/python/qemu/machine/machine.py
> b/python/qemu/machine/machine.py
> > index 26f0fb8a81..09f214c95c 100644
> > --- a/python/qemu/machine/machine.py
> > +++ b/python/qemu/machine/machine.py
> > @@ -159,6 +159,8 @@ def __init__(self,
> >
> >         self._name =3D name or f"{id(self):x}"
> >         self._sock_pair: Optional[Tuple[socket.socket, socket.socket]] =
=3D
> None
> > +        self._cons_sock_pair: Optional[
> > +            Tuple[socket.socket, socket.socket]] =3D None
> >         self._temp_dir: Optional[str] =3D None
> >         self._base_temp_dir =3D base_temp_dir
> >         self._sock_dir =3D sock_dir
> > @@ -315,8 +317,9 @@ def _base_args(self) -> List[str]:
> >         for _ in range(self._console_index):
> >             args.extend(['-serial', 'null'])
> >         if self._console_set:
> > -            chardev =3D ('socket,id=3Dconsole,path=3D%s,server=3Don,wa=
it=3Doff' %
> > -                       self._console_address)
> > +            assert self._cons_sock_pair is not None
> > +            fd =3D self._cons_sock_pair[0].fileno()
> > +            chardev =3D f"socket,id=3Dconsole,fd=3D{fd}"
> >             args.extend(['-chardev', chardev])
> >             if self._console_device_type is None:
> >                 args.extend(['-serial', 'chardev:console'])
> > @@ -351,6 +354,10 @@ def _pre_launch(self) -> None:
> >                 nickname=3Dself._name
> >             )
> >
> > +        if self._console_set:
> > +            self._cons_sock_pair =3D socket.socketpair()
> > +            os.set_inheritable(self._cons_sock_pair[0].fileno(), True)
> > +
> >         # NOTE: Make sure any opened resources are *definitely* freed i=
n
> >         # _post_shutdown()!
> >         # pylint: disable=3Dconsider-using-with
> > @@ -368,6 +375,9 @@ def _pre_launch(self) -> None:
> >     def _post_launch(self) -> None:
> >         if self._sock_pair:
> >             self._sock_pair[0].close()
> > +        if self._cons_sock_pair:
> > +            self._cons_sock_pair[0].close()
> > +
> >         if self._qmp_connection:
> >             if self._sock_pair:
> >                 self._qmp.connect()
> > @@ -518,6 +528,11 @@ def _early_cleanup(self) -> None:
> >             self._console_socket.close()
> >             self._console_socket =3D None
> >
> > +        if self._cons_sock_pair:
> > +            self._cons_sock_pair[0].close()
> > +            self._cons_sock_pair[1].close()
> > +            self._cons_sock_pair =3D None
> > +
> >     def _hard_shutdown(self) -> None:
> >         """
> >         Perform early cleanup, kill the VM, and wait for it to terminat=
e.
> > @@ -878,10 +893,19 @@ def console_socket(self) -> socket.socket:
> >         Returns a socket connected to the console
> >         """
> >         if self._console_socket is None:
> > +            if not self._console_set:
> > +                raise QEMUMachineError(
> > +                    "Attempt to access console socket with no
> connection")
> > +            assert self._cons_sock_pair is not None
> > +            # os.dup() is used here for sock_fd because otherwise we'd
> > +            # have two rich python socket objects that would each try =
to
> > +            # close the same underlying fd when either one gets garbag=
e
> > +            # collected.
> >             self._console_socket =3D console_socket.ConsoleSocket(
> > -                self._console_address,
> > +                sock_fd=3Dos.dup(self._cons_sock_pair[1].fileno()),
> >                 file=3Dself._console_log_path,
> >                 drain=3Dself._drain_console)
> > +            self._cons_sock_pair[1].close()
>
> I am not 100% sure but should we save the new sock_fd here? Like
> self._cons_sock_pair[1] =3D sock_fd ;
>
> Then next time console_socket() is invoked, the correct fd will be duped.
>

It should be cached to self._console_socket, so it should return the same
instance every time, no second call to os.dup().

self._console_socket takes ownership of the duplicated fd and we retain
ownership of _cons_sock_pair[1] which we then close right after.

All three sockets are closed and None'd if applicable during
_early_cleanup().


> >         return self._console_socket
> >
> >     @property
> > --
> > 2.41.0
> >
>
>

--00000000000006c7cd06016716db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Jul 26, 2023, 6:50 AM Ani Sinha &lt;<a href=3D=
"mailto:anisinha@redhat.com">anisinha@redhat.com</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex"><br>
<br>
&gt; On 25-Jul-2023, at 11:33 PM, John Snow &lt;<a href=3D"mailto:jsnow@red=
hat.com" target=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt; wrot=
e:<br>
&gt; <br>
&gt; Create a socketpair for the console output. This should help eliminate=
<br>
&gt; race conditions around console text early in the boot process that mig=
ht<br>
&gt; otherwise have been dropped on the floor before being able to connect =
to<br>
&gt; QEMU under &quot;server,nowait&quot;.<br>
&gt; <br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
Thanks for doing this. I recall we spoke about this late last year in the c=
ontext of fixing my bios-bits avocado test and adding a console output ther=
e.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto=
">Yep! I think you need a few more changes to do what you wanted. IIRC, you=
 also want to be able to drain the console log while waiting for the vm to =
terminate of its own accord, which I don&#39;t support yet.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">(If you use console socket&#39;s self=
 draining mode, it should be possible to forego the early termination of th=
e console socket and allow this behavior. Maybe I can work that in now...)<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Anything else I&#39;m fo=
rgetting ...?</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
Except the concern below,<br>
<br>
Reviewed-by: Ani Sinha &lt;<a href=3D"mailto:anisinha@redhat.com" target=3D=
"_blank" rel=3D"noreferrer">anisinha@redhat.com</a>&gt;<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks =F0=9F=98=8A=
=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
&gt; ---<br>
&gt; python/qemu/machine/machine.py | 30 +++++++++++++++++++++++++++---<br>
&gt; 1 file changed, 27 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/mach=
ine.py<br>
&gt; index 26f0fb8a81..09f214c95c 100644<br>
&gt; --- a/python/qemu/machine/machine.py<br>
&gt; +++ b/python/qemu/machine/machine.py<br>
&gt; @@ -159,6 +159,8 @@ def __init__(self,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._name =3D name or f&quot;{id(sel=
f):x}&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._sock_pair: Optional[Tuple[socke=
t.socket, socket.socket]] =3D None<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._cons_sock_pair: Optional[<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Tuple[socket.socket, socket=
.socket]] =3D None<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._temp_dir: Optional[str] =3D Non=
e<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._base_temp_dir =3D base_temp_dir=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._sock_dir =3D sock_dir<br>
&gt; @@ -315,8 +317,9 @@ def _base_args(self) -&gt; List[str]:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for _ in range(self._console_index):<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args.extend([&#39;-seri=
al&#39;, &#39;null&#39;])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self._console_set:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chardev =3D (&#39;socket,id=
=3Dconsole,path=3D%s,server=3Don,wait=3Doff&#39; %<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0self._console_address)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._cons_sock_pair=
 is not None<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fd =3D self._cons_sock_pair=
[0].fileno()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 chardev =3D f&quot;socket,i=
d=3Dconsole,fd=3D{fd}&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args.extend([&#39;-char=
dev&#39;, chardev])<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self._console_device=
_type is None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0args.exte=
nd([&#39;-serial&#39;, &#39;chardev:console&#39;])<br>
&gt; @@ -351,6 +354,10 @@ def _pre_launch(self) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nickname=
=3Dself._name<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
&gt; <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._console_set:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._cons_sock_pair =3D so=
cket.socketpair()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.set_inheritable(self._co=
ns_sock_pair[0].fileno(), True)<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# NOTE: Make sure any opened resource=
s are *definitely* freed in<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# _post_shutdown()!<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# pylint: disable=3Dconsider-using-wi=
th<br>
&gt; @@ -368,6 +375,9 @@ def _pre_launch(self) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0def _post_launch(self) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self._sock_pair:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._sock_pair[0].clos=
e()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._cons_sock_pair:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._cons_sock_pair[0].clo=
se()<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self._qmp_connection:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self._sock_pair:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._qmp=
.connect()<br>
&gt; @@ -518,6 +528,11 @@ def _early_cleanup(self) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._console_socket.cl=
ose()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._console_socket =
=3D None<br>
&gt; <br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self._cons_sock_pair:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._cons_sock_pair[0].clo=
se()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._cons_sock_pair[1].clo=
se()<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._cons_sock_pair =3D No=
ne<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0def _hard_shutdown(self) -&gt; None:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Perform early cleanup, kill the VM, a=
nd wait for it to terminate.<br>
&gt; @@ -878,10 +893,19 @@ def console_socket(self) -&gt; socket.socket:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Returns a socket connected to the con=
sole<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if self._console_socket is None:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not self._console_set:<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise QEMUMac=
hineError(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 &quot;Attempt to access console socket with no connection&quot;)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert self._cons_sock_pair=
 is not None<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # os.dup() is used here for=
 sock_fd because otherwise we&#39;d<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # have two rich python sock=
et objects that would each try to<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # close the same underlying=
 fd when either one gets garbage<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # collected.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self._console_socket =
=3D console_socket.ConsoleSocket(<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._console=
_address,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sock_fd=3Dos.=
dup(self._cons_sock_pair[1].fileno()),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file=3Dse=
lf._console_log_path,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0drain=3Ds=
elf._drain_console)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._cons_sock_pair[1].clo=
se()<br>
<br>
I am not 100% sure but should we save the new sock_fd here? Like<br>
self._cons_sock_pair[1] =3D sock_fd ;<br>
<br>
Then next time console_socket() is invoked, the correct fd will be duped.<b=
r></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It=
 should be cached to self._console_socket, so it should return the same ins=
tance every time, no second call to os.dup().</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">self._console_socket takes ownership of the duplicate=
d fd and we retain ownership of _cons_sock_pair[1] which we then close righ=
t after.</div><div dir=3D"auto"><br></div><div dir=3D"auto">All three socke=
ts are closed and None&#39;d if applicable during _early_cleanup().</div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return self._console_socket<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0@property<br>
&gt; -- <br>
&gt; 2.41.0<br>
&gt; <br>
<br>
</blockquote></div></div></div>

--00000000000006c7cd06016716db--



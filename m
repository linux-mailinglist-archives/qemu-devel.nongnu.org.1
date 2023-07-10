Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0811374D72D
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 15:15:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIqiX-0006m1-G9; Mon, 10 Jul 2023 09:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qIqiV-0006eX-Jw
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:14:15 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qIqiT-0006cm-Kd
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:14:15 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7679d444210so341130785a.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 06:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688994852; x=1691586852;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YA41Itv2rCfFX00uf4Et5h6dTGK46XMcK8LlA9PLpbE=;
 b=lXyjp77hXTt4V5tEIuJeduYQ9rLTEdkVqvIEsWMRHmQ4Svi56O+M4gfIR3TZ4EjiLa
 DTOXl/fLtNm6SvPaibmBer2Z+fFD1gEbB8kZBDC8DlqMpLM8zfKuje1zHQ4Tmq+X83RB
 u33RG8XD6Ubb16LLRgy/ID+R7DmpxhXUIj6lGVvM9mUw27uZUpu6dK4Fma+mIliNDkSs
 efkYSlZhyTvIzChYsnH3TSdbKMgfAJ+Akf/EUbkZo6M3HX8t6VEK25h95BS2PvoRKPgY
 JdhCSxHEwH8/YmX8iLKgTCnb4Q1eHPYZeFpYC+LlE6YoVMhAz8czYL33rjNq8uajCcal
 OyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688994852; x=1691586852;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YA41Itv2rCfFX00uf4Et5h6dTGK46XMcK8LlA9PLpbE=;
 b=eR5Q255UnPkvCnJP4K7dKfrVQIiT0ykKu+PmRE9zu0CZNRy+uzd6c3043N/NxTrLgA
 wBj97VCSlwZEYxRMZjIMhiUaNiKnq3iXjA9GIqqrR5OsBuZAme3I9r9qlNRwIAvx4wvQ
 NFnIK6P/Yaswkd6inMom2vpSLi0oqzx33ISPNWj6Dxn0V2E5O1I+D6TV3TTR333ZQWXG
 IkMiQ3BUV8Li9OVwier6c5p04D3KvgTFJAprIQ7DMK7Sonv6H0BsM8HZZ96p93pLAgRl
 PUsoVFu8BURkgH0Set4yoQ3Zt2zhzkudafXQxeUBVAVkblt6nsvcaNbTaJnlp0uCMTUJ
 NtXg==
X-Gm-Message-State: ABy/qLYpGFWEI8vuAVyVCRGNMzvgSFK1Vb08+smWumBF1ymp48tJRRhR
 /U4jJCRyn2/UeC3TFwu+DG7dW0ZoCW6QaTfti7g=
X-Google-Smtp-Source: APBJJlE0aGss0CGQBe6ouz7tJ6MaA/Cmu06tLNjAcRYHusOYGgtY7TLsLd9AAzzsr6Du6wnhMqgE5lofJtDLnn2SmDQ=
X-Received: by 2002:a05:622a:1744:b0:403:a707:4ce8 with SMTP id
 l4-20020a05622a174400b00403a7074ce8mr7091094qtk.14.1688994852061; Mon, 10 Jul
 2023 06:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <20170227104956.24729-1-marcandre.lureau@redhat.com>
 <99e31308-3ca6-40aa-a980-bea665dde39d@fungible.com>
In-Reply-To: <99e31308-3ca6-40aa-a980-bea665dde39d@fungible.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 10 Jul 2023 17:14:00 +0400
Message-ID: <CAJ+F1CLhLzCwmjWNPHq-0KYP-XXCikWk4yMm=En9Agph8UB0UA@mail.gmail.com>
Subject: Re: [PATCH v3] vhost-user: delay vhost_user_stop
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, den@openvz.org
Content-Type: multipart/alternative; boundary="0000000000002f51d7060021c25b"
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x733.google.com
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

--0000000000002f51d7060021c25b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jul 5, 2023 at 2:02=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> Hi Marc-Andr=C3=A9,
>
> [very old patch...]
>
> On 27/2/17 11:49, Marc-Andr=C3=A9 Lureau wrote:
> > Since commit b0a335e351103bf92f3f9d0bd5759311be8156ac, a socket write
> > may trigger a disconnect events, calling vhost_user_stop() and clearing
> > all the vhost_dev strutures holding data that vhost.c functions expect
> > to remain valid. Delay the cleanup to keep the vhost_dev structure
> > valid during the vhost.c functions.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> > v3:
> >   - use aio_bh_schedule_oneshot(), as suggest by Paolo
> > v2:
> >   - fix reconnect race
> >
> > net/vhost-user.c | 53
> ++++++++++++++++++++++++++++++++++++++++++++++-------
> >   1 file changed, 46 insertions(+), 7 deletions(-)
> >
> > diff --git a/net/vhost-user.c b/net/vhost-user.c
> > index 77b8110f8c..e7e63408a1 100644
> > --- a/net/vhost-user.c
> > +++ b/net/vhost-user.c
> > @@ -190,7 +190,35 @@ static gboolean net_vhost_user_watch(GIOChannel
> *chan, GIOCondition cond,
> >
> >       qemu_chr_fe_disconnect(&s->chr);
> >
> > -    return FALSE;
> > +    return TRUE;
>
> Do you mind explaining this change again, it is not clear from
> the commit description. We listen to G_IO_HUP, got a SIGHUP so
> we disconnect the chardev but keep listening for future HUP?
> In which case can that happen? How can we get a chardev connected
> and initialized here without calling net_init_vhost_user() again?
>

I think the point was simply to keep the source ID valid, until the cleanup
happens and calls g_source_remove().

Is there any issue with that? we can probably set s->watch =3D 0 in the
source callback instead and check the watch before removing it.


> > +}
> > +
> > +static void net_vhost_user_event(void *opaque, int event);
> > +
> > +static void chr_closed_bh(void *opaque)
> > +{
> > +    const char *name =3D opaque;
> > +    NetClientState *ncs[MAX_QUEUE_NUM];
> > +    VhostUserState *s;
> > +    Error *err =3D NULL;
> > +    int queues;
> > +
> > +    queues =3D qemu_find_net_clients_except(name, ncs,
> > +                                          NET_CLIENT_DRIVER_NIC,
> > +                                          MAX_QUEUE_NUM);
> > +    assert(queues < MAX_QUEUE_NUM);
> > +
> > +    s =3D DO_UPCAST(VhostUserState, nc, ncs[0]);
> > +
> > +    qmp_set_link(name, false, &err);
> > +    vhost_user_stop(queues, ncs);
> > +
> > +    qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event=
,
> > +                             opaque, NULL, true);
> > +
> > +    if (err) {
> > +        error_report_err(err);
> > +    }
> >   }
> >
> >   static void net_vhost_user_event(void *opaque, int event)
> > @@ -212,20 +240,31 @@ static void net_vhost_user_event(void *opaque, in=
t
> event)
> >       trace_vhost_user_event(chr->label, event);
> >       switch (event) {
> >       case CHR_EVENT_OPENED:
> > -        s->watch =3D qemu_chr_fe_add_watch(&s->chr, G_IO_HUP,
> > -                                         net_vhost_user_watch, s);
> >           if (vhost_user_start(queues, ncs, &s->chr) < 0) {
> >               qemu_chr_fe_disconnect(&s->chr);
> >               return;
> >           }
> > +        s->watch =3D qemu_chr_fe_add_watch(&s->chr, G_IO_HUP,
> > +                                         net_vhost_user_watch, s);
> >           qmp_set_link(name, true, &err);
> >           s->started =3D true;
> >           break;
> >       case CHR_EVENT_CLOSED:
> > -        qmp_set_link(name, false, &err);
> > -        vhost_user_stop(queues, ncs);
> > -        g_source_remove(s->watch);
> > -        s->watch =3D 0;
> > +        /* a close event may happen during a read/write, but vhost
> > +         * code assumes the vhost_dev remains setup, so delay the
> > +         * stop & clear to idle.
> > +         * FIXME: better handle failure in vhost code, remove bh
> > +         */
> > +        if (s->watch) {
> > +            AioContext *ctx =3D qemu_get_current_aio_context();
> > +
> > +            g_source_remove(s->watch);
> > +            s->watch =3D 0;
> > +            qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL,
> > +                                     NULL, NULL, false);
> > +
> > +            aio_bh_schedule_oneshot(ctx, chr_closed_bh, opaque);
> > +        }
> >           break;
> >       }
> >
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000002f51d7060021c25b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 5, 2023 at 2:02=E2=80=
=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">=
philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Hi Marc-Andr=C3=A9,<br>
<br>
[very old patch...]<br>
<br>
On 27/2/17 11:49, Marc-Andr=C3=A9 Lureau wrote:<br>
&gt; Since commit b0a335e351103bf92f3f9d0bd5759311be8156ac, a socket write<=
br>
&gt; may trigger a disconnect events, calling vhost_user_stop() and clearin=
g<br>
&gt; all the vhost_dev strutures holding data that vhost.c functions expect=
<br>
&gt; to remain valid. Delay the cleanup to keep the vhost_dev structure<br>
&gt; valid during the vhost.c functions.<br>
&gt; <br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; ---<br>
&gt; v3:<br>
&gt;=C2=A0 =C2=A0- use aio_bh_schedule_oneshot(), as suggest by Paolo<br>
&gt; v2:<br>
&gt;=C2=A0 =C2=A0- fix reconnect race<br>
&gt; <br>
&gt; net/vhost-user.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++--=
-----<br>
&gt;=C2=A0 =C2=A01 file changed, 46 insertions(+), 7 deletions(-)<br>
&gt; <br>
&gt; diff --git a/net/vhost-user.c b/net/vhost-user.c<br>
&gt; index 77b8110f8c..e7e63408a1 100644<br>
&gt; --- a/net/vhost-user.c<br>
&gt; +++ b/net/vhost-user.c<br>
&gt; @@ -190,7 +190,35 @@ static gboolean net_vhost_user_watch(GIOChannel *=
chan, GIOCondition cond,<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_chr_fe_disconnect(&amp;s-&gt;chr);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 return FALSE;<br>
&gt; +=C2=A0 =C2=A0 return TRUE;<br>
<br>
Do you mind explaining this change again, it is not clear from<br>
the commit description. We listen to G_IO_HUP, got a SIGHUP so<br>
we disconnect the chardev but keep listening for future HUP?<br>
In which case can that happen? How can we get a chardev connected<br>
and initialized here without calling net_init_vhost_user() again?<br></bloc=
kquote><div><br></div><div>I think the point was simply to keep the source =
ID valid, until the cleanup happens and calls g_source_remove().</div><div>=
<br></div><div>Is there any issue with that? we can probably set  s-&gt;wat=
ch =3D 0 in the source callback instead and check the watch before removing=
 it.<br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void net_vhost_user_event(void *opaque, int event);<br>
&gt; +<br>
&gt; +static void chr_closed_bh(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 const char *name =3D opaque;<br>
&gt; +=C2=A0 =C2=A0 NetClientState *ncs[MAX_QUEUE_NUM];<br>
&gt; +=C2=A0 =C2=A0 VhostUserState *s;<br>
&gt; +=C2=A0 =C2=A0 Error *err =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 int queues;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 queues =3D qemu_find_net_clients_except(name, ncs,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 NET_CLIENT_DRIVER_NIC,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 MAX_QUEUE_NUM);<br>
&gt; +=C2=A0 =C2=A0 assert(queues &lt; MAX_QUEUE_NUM);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s =3D DO_UPCAST(VhostUserState, nc, ncs[0]);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qmp_set_link(name, false, &amp;err);<br>
&gt; +=C2=A0 =C2=A0 vhost_user_stop(queues, ncs);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 qemu_chr_fe_set_handlers(&amp;s-&gt;chr, NULL, NULL, ne=
t_vhost_user_event,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0opaque, NULL, true);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (err) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(err);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static void net_vhost_user_event(void *opaque, int event)<=
br>
&gt; @@ -212,20 +240,31 @@ static void net_vhost_user_event(void *opaque, i=
nt event)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0trace_vhost_user_event(chr-&gt;label, event)=
;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (event) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHR_EVENT_OPENED:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;watch =3D qemu_chr_fe_add_watch(&am=
p;s-&gt;chr, G_IO_HUP,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0net_vhost_user_watch, s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (vhost_user_start(queues, n=
cs, &amp;s-&gt;chr) &lt; 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_chr_fe_disc=
onnect(&amp;s-&gt;chr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;watch =3D qemu_chr_fe_add_watch(&am=
p;s-&gt;chr, G_IO_HUP,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0net_vhost_user_watch, s);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qmp_set_link(name, true, &amp;=
err);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;started =3D true;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case CHR_EVENT_CLOSED:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qmp_set_link(name, false, &amp;err);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 vhost_user_stop(queues, ncs);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_source_remove(s-&gt;watch);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;watch =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* a close event may happen during a read=
/write, but vhost<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* code assumes the vhost_dev remain=
s setup, so delay the<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* stop &amp; clear to idle.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* FIXME: better handle failure in v=
host code, remove bh<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;watch) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AioContext *ctx =3D qemu_ge=
t_current_aio_context();<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_source_remove(s-&gt;watch=
);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;watch =3D 0;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_chr_fe_set_handlers(&a=
mp;s-&gt;chr, NULL, NULL, NULL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, =
false);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 aio_bh_schedule_oneshot(ctx=
, chr_closed_bh, opaque);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000002f51d7060021c25b--


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C237DF1E5
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 13:01:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyWO1-0005gM-Ll; Thu, 02 Nov 2023 08:01:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qyWNl-0005Vg-M2
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:01:07 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1qyWNi-000567-Fl
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 08:01:04 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c4fdf94666so11147931fa.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698926459; x=1699531259;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=owRR1/WmNiNh8kfqUtaMfSvZwJFYaQ28xuyjQ4uAfqU=;
 b=PVXde1zOYhDC3Dz2eDVKcjBM+tMSOssU73CZ0M9fcf1usApXklaYwF/r0upXaOyStv
 wlvcaXrhFt10SMBibwhIJ8RrNojofCm3qHyyAHG6soQX49vH9DUVJIjR7DqAAz2/mOt/
 tWAwuiIfbzPsVw9YqUAIndxJFGBf8KwXqe1CHGBWqqkn+mdswKHmARjvzIL5N6F2EBd1
 ZcMiIfruBrem2nKekWmYfPZH3W3dJNqIosij2AEzae1+lXpPBaUHgAicC+NZJLhtsC6t
 Mhb1Qld4tf4FqEKvYQHYuHRtL+5lZmW6+MdboP8NO2ZwYJmDmjnRUhdfyQZWVhexsyhc
 HzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698926459; x=1699531259;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=owRR1/WmNiNh8kfqUtaMfSvZwJFYaQ28xuyjQ4uAfqU=;
 b=sYFZFepUGLoW08u34lFXkTXUaasOBI+2aVlEkDVe+skbbksvwrsMIB2fLT5U0W8M2U
 mmMFtvDKu+sqJqGCRJjCecCp0EAn29g6vSnhUyDHfrz0S5u31sWECxF7lNg4J5x7CE08
 suGfIEImIbvlxjo4M9vTVB6foRRcYjxnR/T2Plzx6Gh+BtPiA+KZXEVCIt80jAxEpx6p
 EMiSYoQh6VoZo0OygPSvvPQjRineFym4d2kE4I1r984Z7OUCHpg1uiIyRTPovJLXLDsg
 HjApMT5ov/NAo0CawKVC+phMKrKf4UHoYJh+sexhpAiAXgBGrcWmX3mHKl/Y2nSWVdaR
 jSog==
X-Gm-Message-State: AOJu0YyeoUSqv4AqUT28YqCKOV3j4hWPzwmHtEmUxIfpTTPwMH4Osi9W
 A1C6g8hF9WWSf7tH5IlQphMBScWdzuABTnSFSa3Sqg==
X-Google-Smtp-Source: AGHT+IF0vDanModCEa3HUB6OtCRy6XdDjdJYKvW2tQ/kiTt5RJO/7eufMo2BoW6uyzvbWciA37Mo0G6jpBbzaXsVC9k=
X-Received: by 2002:a05:651c:333:b0:2c5:1542:57e4 with SMTP id
 b19-20020a05651c033300b002c5154257e4mr13684955ljp.31.1698926458794; Thu, 02
 Nov 2023 05:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
 <CACGkMEv=A0KS-LtgZmsMehdoUL=EuQzhkfNipKaV1kdUr2Y5Bw@mail.gmail.com>
 <d0db0fb1-0a58-45b7-a623-df6ee9096e2e@daynix.com>
 <20231101023805-mutt-send-email-mst@kernel.org>
 <39a02a4c-f8fa-437c-892f-caca84b8d85d@daynix.com>
 <20231101050838-mutt-send-email-mst@kernel.org>
 <e469b33b-c3f3-4d88-bdf2-508c4a35c827@daynix.com>
 <CAOEp5OcDMdKKPHSVd-GxT-GkBpvbWkMijSBgwihPsEnxmDR7eA@mail.gmail.com>
 <20231102053202-mutt-send-email-mst@kernel.org>
 <CAOEp5OefD2LN2MDnEkE=DOMSX0Jw8Z6gAiKAag4dtkecmr1Jgg@mail.gmail.com>
 <20231102072540-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231102072540-mutt-send-email-mst@kernel.org>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Thu, 2 Nov 2023 14:00:46 +0200
Message-ID: <CAOEp5OdEudOFXuitG2NSBfuCQiwFJ72rYZsyvLFRfKR4kQvTDg@mail.gmail.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Andrew Melnychenko <andrew@daynix.com>
Content-Type: multipart/alternative; boundary="000000000000138ae406092a2411"
Received-SPF: none client-ip=2a00:1450:4864:20::230;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-lj1-x230.google.com
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

--000000000000138ae406092a2411
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 2, 2023 at 1:26=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:

> On Thu, Nov 02, 2023 at 12:20:39PM +0200, Yuri Benditovich wrote:
> >
> >
> > On Thu, Nov 2, 2023 at 11:33=E2=80=AFAM Michael S. Tsirkin <mst@redhat.=
com>
> wrote:
> >
> >     On Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri Benditovich wrote:
> >     > Probably we mix two different patches in this discussion.
> >     > Focusing on the patch in the e-mail header:
> >     >
> >     > IMO it is not acceptable to fail QEMU run for one feature that we
> can't
> >     make
> >     > active when we silently drop all other features in such a case.
> >
> >     If the feature is off by default then it seems more reasonable
> >     and silent masking can be seen as a bug.
> >     Most virtio features are on by default this is why it's
> >     reasonable to mask them.
> >
> >
> >
> > If we are talking about RSS: setting it initially off is the developmen=
t
> time
> > decision.
> > When it will be completely stable there is no reason to keep it off by
> default,
> > so this is more a question of time and of a readiness of libvirt.
>
> Well when we flip the default we'll need compat machinery for sure ;)
>

Of course, on the flip or default we'll need to keep compatibility to
earlier machine types.
But, because in the perspective it makes sense to make the RSS is on by
default, I do not think we need _now_ to make qemu fail to start if the
ebpf can't be loaded.


>
> --
> MST
>
>

--000000000000138ae406092a2411
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 2, 2023 at 1:26=E2=80=AFP=
M Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redhat.com">mst@redhat.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On=
 Thu, Nov 02, 2023 at 12:20:39PM +0200, Yuri Benditovich wrote:<br>
&gt; <br>
&gt; <br>
&gt; On Thu, Nov 2, 2023 at 11:33=E2=80=AFAM Michael S. Tsirkin &lt;<a href=
=3D"mailto:mst@redhat.com" target=3D"_blank">mst@redhat.com</a>&gt; wrote:<=
br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri Bend=
itovich wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Probably we mix two different patches in this =
discussion.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Focusing on the patch in the e-mail header:<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; IMO it is not acceptable to fail QEMU run for =
one feature that we can&#39;t<br>
&gt;=C2=A0 =C2=A0 =C2=A0make<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; active when we silently drop all other feature=
s in such a case.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0If the feature is off by default then it seems more=
 reasonable<br>
&gt;=C2=A0 =C2=A0 =C2=A0and silent masking can be seen as a bug.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Most virtio features are on by default this is why =
it&#39;s<br>
&gt;=C2=A0 =C2=A0 =C2=A0reasonable to mask them.<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; If we are talking about RSS: setting it initially off is the developme=
nt time<br>
&gt; decision.=C2=A0<br>
&gt; When it will be completely stable there is no reason to keep it off by=
 default,<br>
&gt; so this is more a question of time and of a readiness of libvirt.=C2=
=A0<br>
<br>
Well when we flip the default we&#39;ll need compat machinery for sure ;)<b=
r></blockquote><div><br></div><div>Of course, on the flip or default we&#39=
;ll need to keep compatibility to earlier machine types.</div><div>But, bec=
ause in the perspective it makes sense to make the RSS is on by default, I =
do not think we need _now_ to make qemu fail to start if the ebpf can&#39;t=
 be loaded.</div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
<br>
-- <br>
MST<br>
<br>
</blockquote></div></div>

--000000000000138ae406092a2411--


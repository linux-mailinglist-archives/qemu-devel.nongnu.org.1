Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4127AF40C
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 21:21:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlDcS-0007Xv-Nf; Tue, 26 Sep 2023 15:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qlDcN-0007Xl-BT
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:21:11 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qlDcL-0001IT-1Y
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 15:21:11 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-57b68556d6dso4419788eaf.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 12:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695756067; x=1696360867; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ElC9pDf0OUSTJpo3eVhZwyUVxLr2sItJBaKtKHF5Nfk=;
 b=G9p+0sqpL9nnHHVDDyYsToK0DsKpGpsO12pdeiFadJWt6vgDROCA+4WP3sEN5csOjr
 EEfXx80aTQ94qQMAU0U53MYvmo0l6hXWBx268Q9aWjV9ij6HUvCyZGMqTDgWtcY+VKzJ
 usPuzIzEvzCBJfvzdNZbSOnOGZR8zuITkN7rKoPU3FpME1vSqF0cT3i+40cgzaMy4xlt
 y7JEPgkPmwU7ih7tDU6Fo+axvckkbPiZGOyisgWntdJdfqfVvfXiTPR1Lpo40AUvjg8O
 Izmi0jVb97eDcZn5JSVlXtFbEYTRvR3NP10Rrr8QEppqRONTeax1TynXiROTYRWgfpI0
 oXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695756067; x=1696360867;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ElC9pDf0OUSTJpo3eVhZwyUVxLr2sItJBaKtKHF5Nfk=;
 b=X3W9PdTLxHkzIdr8Nml0j5nAyNOdRSlZGQGIXkGASu0uI/+RBtXj5UblALfa9yhR5M
 HUNCjS4SrXwlijrEQuGPmeQDnpm1V619FUvRrdb5jd9G4UKONMUCVPtZ/N3Shll9tpYx
 zs3p7BqRPv/akrOJRDbyizeonTbc/aUTbotacbTTbEaf78vECslWcggxll/9M73xukZT
 pV7/yQhK26OMP1Tydhc+yevarwLdE0BrO2IHa5DKLLXqsCH82t81/dwdHoFhCsoO3t4R
 revUflHnOG3lvytJkrVTSIWPs3jjcuv1BRdZ4hIJ8TnwdyjOfkBZ7JokcMzEbF9NWVtD
 Nteg==
X-Gm-Message-State: AOJu0Yy3F6fY9B8HPzXe0XmqRr1i0xjwOJxuuyvFX+dj7/fVJu7HSJ8/
 uINSa6r0Xfi2hdVrEZhr4JReogiKVolsK2rEQe8=
X-Google-Smtp-Source: AGHT+IFmlb+3ZRg+DldNlyCeYUEbuBXmg6kL6Y+of23VWpxkdMLTZ0p7CUpPzdqaNqfVyyyCksIs5hhoiTzAnUYlLs4=
X-Received: by 2002:a4a:9183:0:b0:57b:7ac4:7a94 with SMTP id
 d3-20020a4a9183000000b0057b7ac47a94mr10599ooh.2.1695756067201; Tue, 26 Sep
 2023 12:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230915102531.55894-1-hreitz@redhat.com>
 <20230925204852.GG323580@fedora>
 <fc005d50-03ba-0b8f-d9af-64a5297395a3@redhat.com>
In-Reply-To: <fc005d50-03ba-0b8f-d9af-64a5297395a3@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 26 Sep 2023 15:20:54 -0400
Message-ID: <CAJSP0QWwo6rqwY7F-OZgXBnRCLbF4C=66zLf35Jy43jKHebjDw@mail.gmail.com>
Subject: Re: [Virtio-fs] [PATCH v3 0/5] vhost-user: Back-end state migration
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "open list:virtiofs" <virtio-fs@redhat.com>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000002e71a060647fa64"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000002e71a060647fa64
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023, 09:33 Hanna Czenczek <hreitz@redhat.com> wrote:

> On 25.09.23 22:48, Stefan Hajnoczi wrote:
> > On Fri, Sep 15, 2023 at 12:25:25PM +0200, Hanna Czenczek wrote:
> >> RFC:
> >> https://lists.nongnu.org/archive/html/qemu-devel/2023-03/msg04263.html
> >>
> >> v1:
> >> https://lists.nongnu.org/archive/html/qemu-devel/2023-04/msg01575.html
> >>
> >> v2:
> >> https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg02604.html
> >>
> >> Hi,
> >>
> >> I=E2=80=99ve decided not to work on vhost-user SUSPEND/RESUME for now =
=E2=80=93 it is
> >> not technically required for virtio-fs migration, which is the actual
> >> priority for me now.  While we do want to have SUSPEND/RESUME at some
> >> point, the only practically existing reason for it is to be able to
> >> implement vhost-level resetting in virtiofsd, but that is not related =
to
> >> migration.
> > QEMU sends VHOST_USER_SET_STATUS 0 in vhost_dev_stop(). Are you assumin=
g
> > that virtiofs back-ends do not reset the device upon receiving this
> > message?
>

> Absolutely.  vhost_dev_stop() is not in the migration-specific path, but
> is called whenever the vCPUs are stopped, which indeed happens to be
> part of migration, but is also used in other cases, like QMP stop.  We
> have identified that it is wrong that we reset the back-end just because
> the vCPUs are stopped (e.g. on migration), but it is what we do right
> now when the VM is paused (e.g. through QMP stop).
>
> Therefore, stateful back-ends cannot implement reset lest stop/cont
> breaks the device.  I don=E2=80=99t think anybody really cares whether a
> vhost-user back-end actually resets its internal state (if there is any)
> when the guest driver asks for a reset on the virtio level, as long as
> the guest driver is then able to initialize the device afterwards.


Some devices send configuration change notifications. For example,
virtio-net speed and duplex changes.

Imagine a network boot ROM runs and the firmware resets the virtio-net
device when transferring control to the loaded kernel. Before the kernel
driver initializes the device again, the vhost-user-net back-end reports a
speed or duplex change and sends a Configuration Change Notification to the
guest. The guest receives a spurious interrupt because the vhost-user-net
device wasn't actually reset.

I'm concerned that ignoring reset matters (admittedly in corner cases) and
think that stateful device functionality shouldn't be added to the
vhost-user protocol without a solution for reset. This patch series changes
the vhost-user protocol, which is used by many different devices, not just
virtiofs. The solution should work for vhost-user devices of any type and
not be based on what we can get away with when running the current QEMU +
virtiofsd.

I do
> think people care that stop/cont works, so it follows to me that no
> stateful back-end will reset its internal state when receiving a
> virtio/vhost reset.  If they do, stop/cont breaks, which is a
> user-visible bug that needs to be addressed =E2=80=93 either properly by
> implementing SUSPEND/RESUME in both qemu and the affected back-ends, or
> by using a similar work-around to virtiofsd, which is to ignore reset
> commands.
>

Properly, please.


> It=E2=80=99s hard for me to imagine that people don=E2=80=99t care that s=
top/cont breaks
> some vhost-user back-end, but suddenly would start to care that
> migration doesn=E2=80=99t work =E2=80=93 especially given that first of a=
ll someone will
> need to manually implement any migration support in that back-end even
> with this series, which means that really, the only back-end we are
> talking about here is our virtiofsd.  To this day I=E2=80=99m not even aw=
are of
> any other back-end that has internal state.
>

Another one I can think of is vhost-user-gpu.

Why did you give up on implementing SUSPEND/RESUME?

Stefan


> Hanna
>
>
>

--00000000000002e71a060647fa64
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"auto"><div><=
br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Tue, Sep 26, 2023, 09:33 Hanna Czenczek &lt;<a href=3D"mailto:hreitz@redhat=
.com" target=3D"_blank">hreitz@redhat.com</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On 25.09.23 22:48, Stefan Hajnoczi=
 wrote:<br>
&gt; On Fri, Sep 15, 2023 at 12:25:25PM +0200, Hanna Czenczek wrote:<br>
&gt;&gt; RFC:<br>
&gt;&gt; <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2023-0=
3/msg04263.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://li=
sts.nongnu.org/archive/html/qemu-devel/2023-03/msg04263.html</a><br>
&gt;&gt;<br>
&gt;&gt; v1:<br>
&gt;&gt; <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2023-0=
4/msg01575.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://li=
sts.nongnu.org/archive/html/qemu-devel/2023-04/msg01575.html</a><br>
&gt;&gt;<br>
&gt;&gt; v2:<br>
&gt;&gt; <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/2023-0=
7/msg02604.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https://li=
sts.nongnu.org/archive/html/qemu-devel/2023-07/msg02604.html</a><br>
&gt;&gt;<br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; I=E2=80=99ve decided not to work on vhost-user SUSPEND/RESUME for =
now =E2=80=93 it is<br>
&gt;&gt; not technically required for virtio-fs migration, which is the act=
ual<br>
&gt;&gt; priority for me now.=C2=A0 While we do want to have SUSPEND/RESUME=
 at some<br>
&gt;&gt; point, the only practically existing reason for it is to be able t=
o<br>
&gt;&gt; implement vhost-level resetting in virtiofsd, but that is not rela=
ted to<br>
&gt;&gt; migration.<br>
&gt; QEMU sends VHOST_USER_SET_STATUS 0 in vhost_dev_stop(). Are you assumi=
ng<br>
&gt; that virtiofs back-ends do not reset the device upon receiving this<br=
>
&gt; message?<br></blockquote></div></div><div dir=3D"auto"><div class=3D"g=
mail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Absolutely.=C2=A0 vhost_dev_stop() is not in the migration-specific path, b=
ut <br>
is called whenever the vCPUs are stopped, which indeed happens to be <br>
part of migration, but is also used in other cases, like QMP stop.=C2=A0 We=
 <br>
have identified that it is wrong that we reset the back-end just because <b=
r>
the vCPUs are stopped (e.g. on migration), but it is what we do right <br>
now when the VM is paused (e.g. through QMP stop).<br>
<br>
Therefore, stateful back-ends cannot implement reset lest stop/cont <br>
breaks the device.=C2=A0 I don=E2=80=99t think anybody really cares whether=
 a <br>
vhost-user back-end actually resets its internal state (if there is any) <b=
r>
when the guest driver asks for a reset on the virtio level, as long as <br>
the guest driver is then able to initialize the device afterwards.</blockqu=
ote><div><br></div><div>Some devices send configuration change notification=
s. For example, virtio-net speed and duplex changes.</div><div><br></div><d=
iv>Imagine a network boot ROM runs and the firmware resets the virtio-net d=
evice when transferring control to the loaded kernel. Before the kernel dri=
ver initializes the device again, the vhost-user-net back-end reports a spe=
ed or duplex change and sends a Configuration Change Notification to the gu=
est. The guest receives a spurious interrupt because the vhost-user-net dev=
ice wasn&#39;t actually reset.</div><div><br></div><div>I&#39;m concerned t=
hat ignoring reset matters (admittedly in corner cases) and think that stat=
eful device functionality shouldn&#39;t be added to the vhost-user protocol=
 without a solution for reset. This patch series changes the vhost-user pro=
tocol, which is used by many different devices, not just virtiofs. The solu=
tion should work for vhost-user devices of any type and not be based on wha=
t we can get away with when running the current QEMU + virtiofsd.<br></div>=
<div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I do <br>
think people care that stop/cont works, so it follows to me that no <br>
stateful back-end will reset its internal state when receiving a <br>
virtio/vhost reset.=C2=A0 If they do, stop/cont breaks, which is a <br>
user-visible bug that needs to be addressed =E2=80=93 either properly by <b=
r>
implementing SUSPEND/RESUME in both qemu and the affected back-ends, or <br=
>
by using a similar work-around to virtiofsd, which is to ignore reset <br>
commands.<br></blockquote></div></div><div dir=3D"auto"><br></div><div>Prop=
erly, please.<br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
It=E2=80=99s hard for me to imagine that people don=E2=80=99t care that sto=
p/cont breaks <br>
some vhost-user back-end, but suddenly would start to care that <br>
migration doesn=E2=80=99t work =E2=80=93 especially given that first of all=
 someone will <br>
need to manually implement any migration support in that back-end even <br>
with this series, which means that really, the only back-end we are <br>
talking about here is our virtiofsd.=C2=A0 To this day I=E2=80=99m not even=
 aware of <br>
any other back-end that has internal state.<br></blockquote><div><br></div>=
<div>Another one I can think of is vhost-user-gpu.</div><div><br></div><div=
>Why did you give up on implementing SUSPEND/RESUME?<br></div><div><br></di=
v><div>Stefan<br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
Hanna<br>
<br>
<br>
</blockquote></div></div></div>
</div></div></div>

--00000000000002e71a060647fa64--


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6F77BBF97
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 21:10:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoqCH-0000vG-F1; Fri, 06 Oct 2023 15:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qoqC8-0000uu-MQ
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 15:09:04 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qoqC5-0005YY-Jb
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 15:09:04 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-523100882f2so4137796a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696619337; x=1697224137;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SUXx8T2//uz8UUco5mu2RsPDkxSaSJf8WBC6TYT0VkU=;
 b=xYc1Xh5MU6Xos3fCJnJ3trM9kfjJa8wdpd3kmNO9OYlp0A5gBbbQ9XRFJh8hM5emWr
 GN+q3SsqN/P9lClnIE2BdQVXaza84qNqVS8i1NrE/WamSFRIMwr/EPzrNDpXB/a2D8Zk
 lyPw0dTkXBwPGgnc3ReJZ+pkxGUOWYRfEq3q4GEOkFpdHqjrQdaWcCSYz/HWQrc1aTdR
 fMQ2CtdHOjOZQiYl4wp0t5vjozgEw+vgIAR20/CUQ9O8fp1eOBlPvwvl9wLwqqG0XpWH
 Iae5S6aPq3kDvL1Vi2EiBTv3sWQVH1YjaJNz6bP6sN+CEIWUt7B39kYXpUm2qaVQcdyo
 ipnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696619337; x=1697224137;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SUXx8T2//uz8UUco5mu2RsPDkxSaSJf8WBC6TYT0VkU=;
 b=WAnM561ooAWhEmfIo2nRxNaQwzlYkfdskzXSy8jEbXcBl82xxcc4j8+eRrXdn1j/Sn
 SEkHlRq2dzMnoM/2/FRWlEWCrpg9WfIdmp61H+96CJp4OtXB74/0qStn2aCjwdQ3ZB84
 /eqsFBIZd0gamQ5Mfu5s4e5PsEJhc4I/dYWxTmjD3gDsoOJOEGmIs3iUXoHhlW8O7KuR
 wsK3vr+l8gYEQIEWKIXZJWLCDddCZRATzygjTi9zzJnhoQDTbItsBvOsZcLsEbq8Z6tJ
 ZLcTbhS4RzJzrFPbzU822eSm16dCmZYJ60MVsUQemuJRxQYxPxMwS0lm/pD2ii8XLgLj
 VJwg==
X-Gm-Message-State: AOJu0YyP48oRviWLhyk89c+mc+NEMYP5rYTdACe0K/L53BbTQgeB2mq3
 bqXjcLDbhM4g6dADyRAtF4YYs/5jZTV9pwMBOiRNLQ==
X-Google-Smtp-Source: AGHT+IHF0TesG1e5eQCM6RtKwqKe4VQZ+gZvO9k5413a2kA0GnuFo0lojAAGrdUe76uzaVKOomR/27HIJEzcrICdU+c=
X-Received: by 2002:a05:6402:1357:b0:533:4a9a:b0e6 with SMTP id
 y23-20020a056402135700b005334a9ab0e6mr8646542edw.20.1696619336667; Fri, 06
 Oct 2023 12:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <87mswvg683.fsf@pond.sub.org>
 <12397ede-8e20-cb55-b759-d2fbf7732f46@redhat.com>
 <884f4d8c-4ee4-3ee2-ff62-5d7166a75adb@redhat.com>
In-Reply-To: <884f4d8c-4ee4-3ee2-ff62-5d7166a75adb@redhat.com>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 6 Oct 2023 13:08:38 -0600
Message-ID: <CANCZdfpU1eCM0fatVBuQJW9bLzTZfvp3HNQ=2Kfz9ni90PbmEg@mail.gmail.com>
Subject: Re: [v3] Help wanted for enabling -Wshadow=local
To: Thomas Huth <thuth@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e1a698060710f818"
Received-SPF: none client-ip=2a00:1450:4864:20::52d;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000e1a698060710f818
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 6, 2023, 11:55 AM Thomas Huth <thuth@redhat.com> wrote:

> On 06/10/2023 18.18, Thomas Huth wrote:
> > On 06/10/2023 16.45, Markus Armbruster wrote:
> >> Local variables shadowing other local variables or parameters make the
> >> code needlessly hard to understand.  Bugs love to hide in such code.
> >> Evidence: "[PATCH v3 1/7] migration/rdma: Fix save_page method to fail
> >> on polling error".
> >>
> >> Enabling -Wshadow would prevent bugs like this one.  But we have to
> >> clean up all the offenders first.
> >>
> >> Quite a few people responded to my calls for help.  Thank you so much!
> >>
> >> I'm collecting patches in my git repo at
> >> https://repo.or.cz/qemu/armbru.git in branch shadow-next.  All but the
> >> last two are in a pending pull request.
> >>
> >> My test build is down to seven files with warnings.  "[PATCH v2 0/3]
> >> hexagon: GETPC() and shadowing fixes" takes care of four, but it needs=
 a
> >> rebase.
> >>
> >> Remaining three:
> >>
> >>      In file included from ../hw/display/virtio-gpu-virgl.c:19:
> >>      ../hw/display/virtio-gpu-virgl.c: In function
> =E2=80=98virgl_cmd_submit_3d=E2=80=99:
> >>      /work/armbru/qemu/include/hw/virtio/virtio-gpu.h:228:16: warning:
> >> declaration of =E2=80=98s=E2=80=99 shadows a previous local [-Wshadow=
=3Dcompatible-local]
> >>        228 |         size_t
> >> s;                                                       \
> >>            |                ^
> >>      ../hw/display/virtio-gpu-virgl.c:215:5: note: in expansion of
> macro
> >> =E2=80=98VIRTIO_GPU_FILL_CMD=E2=80=99
> >>        215 |     VIRTIO_GPU_FILL_CMD(cs);
> >>            |     ^~~~~~~~~~~~~~~~~~~
> >>      ../hw/display/virtio-gpu-virgl.c:213:12: note: shadowed
> declaration
> >> is here
> >>        213 |     size_t s;
> >>            |            ^
> >>
> >>      In file included from ../contrib/vhost-user-gpu/virgl.h:18,
> >>                       from ../contrib/vhost-user-gpu/virgl.c:17:
> >>      ../contrib/vhost-user-gpu/virgl.c: In function
> =E2=80=98virgl_cmd_submit_3d=E2=80=99:
> >>      ../contrib/vhost-user-gpu/vugpu.h:167:16: warning: declaration of
> =E2=80=98s=E2=80=99
> >> shadows a previous local [-Wshadow=3Dcompatible-local]
> >>        167 |         size_t
> >> s;                                               \
> >>            |                ^
> >>      ../contrib/vhost-user-gpu/virgl.c:203:5: note: in expansion of
> macro
> >> =E2=80=98VUGPU_FILL_CMD=E2=80=99
> >>        203 |     VUGPU_FILL_CMD(cs);
> >>            |     ^~~~~~~~~~~~~~
> >>      ../contrib/vhost-user-gpu/virgl.c:201:12: note: shadowed
> declaration
> >> is here
> >>        201 |     size_t s;
> >>            |            ^
> >>
> >>      ../contrib/vhost-user-gpu/vhost-user-gpu.c: In function
> >> =E2=80=98vg_resource_flush=E2=80=99:
> >>      ../contrib/vhost-user-gpu/vhost-user-gpu.c:837:29: warning:
> >> declaration of =E2=80=98i=E2=80=99 shadows a previous local [-Wshadow=
=3Dlocal]
> >>        837 |             pixman_image_t *i =3D
> >>            |                             ^
> >>      ../contrib/vhost-user-gpu/vhost-user-gpu.c:757:9: note: shadowed
> >> declaration is here
> >>        757 |     int i;
> >>            |         ^
> >>
> >> Gerd, Marc-Andr=C3=A9, or anybody else?
> >>
> >> More warnings may lurk in code my test build doesn't compile.  Need a
> >> full CI build with -Wshadow=3Dlocal to find them.  Anybody care to kic=
k
> >> one off?
> >
> > I ran a build here (with -Werror enabled, so that it's easier to see
> where
> > it breaks):
> >
> >   https://gitlab.com/thuth/qemu/-/pipelines/1028023489
> >
> > ... but I didn't see any additional spots in the logs beside the ones
> that
> > you already listed.
>
> After adding two more patches to fix the above warnings, things look
> pretty
> good:
>
>   https://gitlab.com/thuth/qemu/-/pipelines/1028413030
>
> There are just some warnings left in the BSD code, as Warner already
> mentioned in his reply to v2 of your mail:
>
>   https://gitlab.com/thuth/qemu/-/jobs/5241420713


I think I have fixes for these. I need to merge what just landed into
bsd-user fork, rebase, test, the apply them to qemu master branch, retest
and send them off...

My illness has hung on longer than I thought so I'm still behind...

Warner


>   Thomas
>
>

--000000000000e1a698060710f818
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Fri, Oct 6, 2023, 11:55 AM Thomas Huth &lt;<a href=
=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrote:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">On 06/10/2023 18.18, Thomas Huth wrote:<br>
&gt; On 06/10/2023 16.45, Markus Armbruster wrote:<br>
&gt;&gt; Local variables shadowing other local variables or parameters make=
 the<br>
&gt;&gt; code needlessly hard to understand.=C2=A0 Bugs love to hide in suc=
h code.<br>
&gt;&gt; Evidence: &quot;[PATCH v3 1/7] migration/rdma: Fix save_page metho=
d to fail<br>
&gt;&gt; on polling error&quot;.<br>
&gt;&gt;<br>
&gt;&gt; Enabling -Wshadow would prevent bugs like this one.=C2=A0 But we h=
ave to<br>
&gt;&gt; clean up all the offenders first.<br>
&gt;&gt;<br>
&gt;&gt; Quite a few people responded to my calls for help.=C2=A0 Thank you=
 so much!<br>
&gt;&gt;<br>
&gt;&gt; I&#39;m collecting patches in my git repo at<br>
&gt;&gt; <a href=3D"https://repo.or.cz/qemu/armbru.git" rel=3D"noreferrer n=
oreferrer" target=3D"_blank">https://repo.or.cz/qemu/armbru.git</a> in bran=
ch shadow-next.=C2=A0 All but the<br>
&gt;&gt; last two are in a pending pull request.<br>
&gt;&gt;<br>
&gt;&gt; My test build is down to seven files with warnings.=C2=A0 &quot;[P=
ATCH v2 0/3]<br>
&gt;&gt; hexagon: GETPC() and shadowing fixes&quot; takes care of four, but=
 it needs a<br>
&gt;&gt; rebase.<br>
&gt;&gt;<br>
&gt;&gt; Remaining three:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 In file included from ../hw/display/virti=
o-gpu-virgl.c:19:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 ../hw/display/virtio-gpu-virgl.c: In func=
tion =E2=80=98virgl_cmd_submit_3d=E2=80=99:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 /work/armbru/qemu/include/hw/virtio/virti=
o-gpu.h:228:16: warning: <br>
&gt;&gt; declaration of =E2=80=98s=E2=80=99 shadows a previous local [-Wsha=
dow=3Dcompatible-local]<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 228 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 size_t <br>
&gt;&gt; s;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ^<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 ../hw/display/virtio-gpu-virgl.c:215:5: n=
ote: in expansion of macro <br>
&gt;&gt; =E2=80=98VIRTIO_GPU_FILL_CMD=E2=80=99<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 215 |=C2=A0=C2=A0=C2=A0=C2=A0=
 VIRTIO_GPU_FILL_CMD(cs);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~~<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 ../hw/display/virtio-gpu-virgl.c:213:12: =
note: shadowed declaration <br>
&gt;&gt; is here<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 213 |=C2=A0=C2=A0=C2=A0=C2=A0=
 size_t s;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 In file included from ../contrib/vhost-us=
er-gpu/virgl.h:18,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from ../contri=
b/vhost-user-gpu/virgl.c:17:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 ../contrib/vhost-user-gpu/virgl.c: In fun=
ction =E2=80=98virgl_cmd_submit_3d=E2=80=99:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 ../contrib/vhost-user-gpu/vugpu.h:167:16:=
 warning: declaration of =E2=80=98s=E2=80=99 <br>
&gt;&gt; shadows a previous local [-Wshadow=3Dcompatible-local]<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 167 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 size_t <br>
&gt;&gt; s;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 \<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ^<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 ../contrib/vhost-user-gpu/virgl.c:203:5: =
note: in expansion of macro <br>
&gt;&gt; =E2=80=98VUGPU_FILL_CMD=E2=80=99<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 203 |=C2=A0=C2=A0=C2=A0=C2=A0=
 VUGPU_FILL_CMD(cs);<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 ../contrib/vhost-user-gpu/virgl.c:201:12:=
 note: shadowed declaration <br>
&gt;&gt; is here<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 201 |=C2=A0=C2=A0=C2=A0=C2=A0=
 size_t s;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 ../contrib/vhost-user-gpu/vhost-user-gpu.=
c: In function <br>
&gt;&gt; =E2=80=98vg_resource_flush=E2=80=99:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 ../contrib/vhost-user-gpu/vhost-user-gpu.=
c:837:29: warning: <br>
&gt;&gt; declaration of =E2=80=98i=E2=80=99 shadows a previous local [-Wsha=
dow=3Dlocal]<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 837 |=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pixman_image_t *i =3D<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 ../contrib/vhost-user-gpu/vhost-user-gpu.=
c:757:9: note: shadowed <br>
&gt;&gt; declaration is here<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 757 |=C2=A0=C2=A0=C2=A0=C2=A0=
 int i;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^<br>
&gt;&gt;<br>
&gt;&gt; Gerd, Marc-Andr=C3=A9, or anybody else?<br>
&gt;&gt;<br>
&gt;&gt; More warnings may lurk in code my test build doesn&#39;t compile.=
=C2=A0 Need a<br>
&gt;&gt; full CI build with -Wshadow=3Dlocal to find them.=C2=A0 Anybody ca=
re to kick<br>
&gt;&gt; one off?<br>
&gt; <br>
&gt; I ran a build here (with -Werror enabled, so that it&#39;s easier to s=
ee where <br>
&gt; it breaks):<br>
&gt; <br>
&gt;=C2=A0 =C2=A0<a href=3D"https://gitlab.com/thuth/qemu/-/pipelines/10280=
23489" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/t=
huth/qemu/-/pipelines/1028023489</a><br>
&gt; <br>
&gt; ... but I didn&#39;t see any additional spots in the logs beside the o=
nes that <br>
&gt; you already listed.<br>
<br>
After adding two more patches to fix the above warnings, things look pretty=
 <br>
good:<br>
<br>
=C2=A0 <a href=3D"https://gitlab.com/thuth/qemu/-/pipelines/1028413030" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/thuth/qemu/=
-/pipelines/1028413030</a><br>
<br>
There are just some warnings left in the BSD code, as Warner already <br>
mentioned in his reply to v2 of your mail:<br>
<br>
=C2=A0 <a href=3D"https://gitlab.com/thuth/qemu/-/jobs/5241420713" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://gitlab.com/thuth/qemu/-/job=
s/5241420713</a></blockquote></div></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">I think I have fixes for these. I need to merge what just lande=
d into bsd-user fork, rebase, test, the apply them to qemu master branch, r=
etest and send them off...</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">My illness has hung on longer than I thought so I&#39;m still behind...<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Warner=C2=A0</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><br>
=C2=A0 Thomas<br>
<br>
</blockquote></div></div></div>

--000000000000e1a698060710f818--


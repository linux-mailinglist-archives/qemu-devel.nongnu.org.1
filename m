Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C2C78D6C0
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 16:59:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMeb-0001vx-8i; Wed, 30 Aug 2023 10:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qbMeY-0001vC-Gi
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:58:42 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qbMeV-0001o5-Qo
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 10:58:42 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso736819166b.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 07:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693407518; x=1694012318;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rlER/J8YB532KhzSLw22hT3a4ef/Pi6m9PU+LLsj0JM=;
 b=hH6ovB8NRPY6cRu6UXmvKVvbkvFOgS3HDfMkShyDrgtAzpyeE3przu9syJI/1Xcxcp
 CsAa1CdLh6OF4ZHptR1bw0lapq87AkuPFcxMM7HrxJuQOATVBrFZff6B2m+YIoWXN0Ba
 ntvw/5s+hCh/oyo5i6pNn035T7nbRB1yx4Dm2+wAu5SAJIo6F7wPkQJlro+aIb4nwgAO
 m93TbWscdzYNw0D0Q+zIm+MkMNaQYdwofpxJA+nbUd5tlyXk81rw+pL4eA2UFBUkU8HI
 9VMtuOTAwAWeYix1R8o8HMMteMI9IWQ+61MNFThebcFCQjJLQZi02Uvo4Cg8srqjwEwh
 Ua8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407518; x=1694012318;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rlER/J8YB532KhzSLw22hT3a4ef/Pi6m9PU+LLsj0JM=;
 b=Z+JFJH7BG599JMY6Ma8pPnsicoUj1hYPpgFOjFlyPJBBFqX23Is0IUsc5oghnvX9Py
 lvyzacTvmxpBD26gca25R8xvkfCKYd4wUzQ9jOQvCeSoyVqpf0+PUgEKd8/clJDijcXr
 CcIA396/JiP5YiTfp69poE83YkW5kVOllUTUp3aWtn4rrR3vitBtdwTlZQnubcbbSj+c
 f/woTTuoFKXDam7U/mnKGQ7rGHRqq0fkKVNyU2/mdgkiNWtpdIJ6XZ1maEm+tSKN9+RW
 BSCttbWjnTCVZLZpj09a1Tx+fUvShQm037fROZ3N53i3VViJaFG2eyn5mNXw7tbbLbhy
 XZLw==
X-Gm-Message-State: AOJu0YxIA+j5SLjBmdspR5FPNNwCkd1givoXVOY5E0Ha6jliQrx/EMB2
 ekk1fxB8KcIT29zPVka6QPBgMbuA4F4lUwB9SFCz0Q==
X-Google-Smtp-Source: AGHT+IGCfjv5FzbmPM3c7RYZcJrY6qBSJBvVj0G5o20+rmI1Q8md+xYzMHanAChncT8Ui7fZlRamlK77u3nRbBKUpcA=
X-Received: by 2002:a17:906:3145:b0:9a5:7c4c:5799 with SMTP id
 e5-20020a170906314500b009a57c4c5799mr1768102eje.58.1693407517907; Wed, 30 Aug
 2023 07:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230830144743.53770-1-imp@bsdimp.com>
 <CAFEAcA9LNyxEe42cBBWYLE2TxQKD39Qv_Ud+-TbbWdvMR=wNCg@mail.gmail.com>
In-Reply-To: <CAFEAcA9LNyxEe42cBBWYLE2TxQKD39Qv_Ud+-TbbWdvMR=wNCg@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 30 Aug 2023 08:58:26 -0600
Message-ID: <CANCZdfqZjbm96zVQuFi0sjFH+H+AsCWc9yyvxNBs2JKQ-u67Og@mail.gmail.com>
Subject: Re: [PATCH v3] bsd-user: Move PRAGMA_DISABLE_PACKED_WARNING etc to
 qemu.h
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Laurent Vivier <laurent@vivier.eu>, Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000090b43e06042529ed"
Received-SPF: none client-ip=2a00:1450:4864:20::629;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x629.google.com
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

--00000000000090b43e06042529ed
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 30, 2023 at 8:55=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Wed, 30 Aug 2023 at 15:51, Warner Losh <imp@bsdimp.com> wrote:
> >
> > For the moment, move PRAGMA_DISABLE_PACKED_WARNING and
> > PRAGMA_ENABLE_PACKED_WARNING back to bsd-user/qemu.h.
> >
> > Of course, these should be in compiler.h, but that interferes with too
> > many things at the moment, so take one step back to unbreak clang
> > linux-user builds first. Use the exact same version that's in
> > linux-user/qemu.h since that's what should be in compiler.h.
> > ---
> >  bsd-user/qemu.h         | 27 +++++++++++++++++++++++++++
> >  include/qemu/compiler.h | 30 ------------------------------
> >  2 files changed, 27 insertions(+), 30 deletions(-)
>
> Yeah, let's un-break CI first and then think about a neater
> thing afterwards.
>

Yea. And in 2 days I'll have minutes again and in 7 I'll be past a deadline
at $WORK and have time to setup local gitlab CI... but trying to play
whack-a-mole
with this w/o either is going to take days...


> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM
>

--00000000000090b43e06042529ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 30, 2023 at 8:55=E2=80=AF=
AM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.mayd=
ell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On Wed, 30 Aug 2023 at 15:51, Warner Losh &lt;<a href=3D"mail=
to:imp@bsdimp.com" target=3D"_blank">imp@bsdimp.com</a>&gt; wrote:<br>
&gt;<br>
&gt; For the moment, move PRAGMA_DISABLE_PACKED_WARNING and<br>
&gt; PRAGMA_ENABLE_PACKED_WARNING back to bsd-user/qemu.h.<br>
&gt;<br>
&gt; Of course, these should be in compiler.h, but that interferes with too=
<br>
&gt; many things at the moment, so take one step back to unbreak clang<br>
&gt; linux-user builds first. Use the exact same version that&#39;s in<br>
&gt; linux-user/qemu.h since that&#39;s what should be in compiler.h.<br>
&gt; ---<br>
&gt;=C2=A0 bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 27 ++++++++++=
+++++++++++++++++<br>
&gt;=C2=A0 include/qemu/compiler.h | 30 ------------------------------<br>
&gt;=C2=A0 2 files changed, 27 insertions(+), 30 deletions(-)<br>
<br>
Yeah, let&#39;s un-break CI first and then think about a neater<br>
thing afterwards.<br></blockquote><div><br></div><div>Yea. And in 2 days I&=
#39;ll have minutes again and in 7 I&#39;ll be past a deadline</div><div>at=
 $WORK and have time to setup=C2=A0local gitlab CI... but trying to play wh=
ack-a-mole</div><div>with this w/o either is going to take days...</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Reviewed-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" =
target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--00000000000090b43e06042529ed--


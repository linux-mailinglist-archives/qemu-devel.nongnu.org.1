Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15219746D49
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 11:26:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGcIL-0007CF-UN; Tue, 04 Jul 2023 05:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qGcIK-0007C5-Jd
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:26:00 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qGcII-0005aY-Ui
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 05:26:00 -0400
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-40353537485so15516441cf.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 02:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688462757; x=1691054757;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yykKIq5SXhkS3WNzQV2/mpvtQMSXY7qupGfgSgtGTpM=;
 b=LcRCaTlFAVveYzwG9Iu3MCjRmPhdUoBLKH+mHiukG1A7E/1ZXe7FfyJWu1acgF35XW
 qIx8EXWk1Fg7qO0Fy3eIReJ9D1D9DNIDTCEBbxQiiTjXXzxiZ5kt2FYsK+RtmB4byERE
 8DX2OhW3l0jWJtazJlBkxc9oywIuHLE6uPJs8NDQgc8GDNaXptR+rp5GTxykVB8leHDA
 bUH6GeNJwmskrH2I9CkanNTlGtm2AxBoQbZaIqd6w9oTt2wWedWSQweyoxpTcVAbl7kn
 gD6Kg7i762+A4oU1bn4w12YzJNRwgB/eIDz0xnkxBfNfO1HKsxNWI2ZWPh6z65DfIsRg
 lf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688462757; x=1691054757;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yykKIq5SXhkS3WNzQV2/mpvtQMSXY7qupGfgSgtGTpM=;
 b=Tdh49ijvB0qQU6XKPFBvxQ2euEse2xkU9T9xX+LGLq6eQBjkmWoWMCEbVYcOM296RP
 Co3Hhkdc2iTk40UbdCkHX3peyIK69Sa4rAQQpl2ehl6txVjM+fgde6qNDPfVsOMe6k6k
 UkZWn6f9/Ibm+aS5pnHGnCVFjZ6kSXtRF/J+o1OU57lSluuU1YtKosnjC9vbdtBGqi/2
 NXOEc+csMeMEY2Nbw5i7XibXIG0sBynhzOKm/cHxdg5wL8fCbqVyh88lbXOplFSk1ZVN
 myAELttUnPspBic3dr30ug+yuSMc/qSD0D4wyL5uY3oGLFPHlq5XSwUWMezTnMgWvb2Z
 CdRw==
X-Gm-Message-State: AC+VfDwOp9uOvvdrdy3JStOhJOjIxIuplVqoc7W4eQEbzh5t2UleFL3R
 oPEkqzANrMplRqZ/fOqkZqjZiv/fjZIMh2rTHerbSRst3QB+OQ==
X-Google-Smtp-Source: ACHHUZ7J5JB+fu3HPXHzHBig0qIpSJmyjAFa3O+vPs4HZ8Z23QxCvT8IueJHto2n4zKfpbI/4U9VjDHYkdESNKEHNX0=
X-Received: by 2002:ac8:5710:0:b0:3fd:ecc5:7c5e with SMTP id
 16-20020ac85710000000b003fdecc57c5emr15651071qtw.50.1688462757599; Tue, 04
 Jul 2023 02:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230704091933.2342193-1-marcandre.lureau@redhat.com>
 <8637f500-88af-1f57-9f4b-88a9405e89cf@redhat.com>
In-Reply-To: <8637f500-88af-1f57-9f4b-88a9405e89cf@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 4 Jul 2023 11:25:46 +0200
Message-ID: <CAJ+F1CLCVVXo2hOOVU2YUirYeCSRsKsyba6BHjH0iFNTMJfvgA@mail.gmail.com>
Subject: Re: [PATCH] virtio-gpu: fix potential divide-by-zero regression
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, alxndr@bu.edu, Gerd Hoffmann <kraxel@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000e2213105ffa5de4e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82d.google.com
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

--000000000000e2213105ffa5de4e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 4, 2023 at 11:24=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:

> On 04/07/2023 11.19, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Commit 9462ff4695aa0 ("virtio-gpu/win32: allocate shareable 2d
> > resources/images") introduces a division, which can lead to crashes whe=
n
> > "height" is 0.
> >
> > Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1744
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> ...
> > diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> > index b0f44f929a..c8971e90ac 160000
> > --- a/tests/lcitool/libvirt-ci
> > +++ b/tests/lcitool/libvirt-ci
> > @@ -1 +1 @@
> > -Subproject commit b0f44f929a81c0a604fb7fbf8afc34d37ab0eae9
> > +Subproject commit c8971e90ac169ee2b539c747f74d96c876debdf9
>
> That submodule update looks like an accident?
>
>
Oops.. thanks for noticing


--=20
Marc-Andr=C3=A9 Lureau

--000000000000e2213105ffa5de4e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 4, 2023 at 11:24=E2=80=AF=
AM Thomas Huth &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 0=
4/07/2023 11.19, <a href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_=
blank">marcandre.lureau@redhat.com</a> wrote:<br>
&gt; From: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@re=
dhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; <br>
&gt; Commit 9462ff4695aa0 (&quot;virtio-gpu/win32: allocate shareable 2d<br=
>
&gt; resources/images&quot;) introduces a division, which can lead to crash=
es when<br>
&gt; &quot;height&quot; is 0.<br>
&gt; <br>
&gt; Fixes: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/1744" =
rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-=
/issues/1744</a><br>
&gt; Signed-off-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.=
lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br=
>
&gt; ---<br>
...<br>
&gt; diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci<br>
&gt; index b0f44f929a..c8971e90ac 160000<br>
&gt; --- a/tests/lcitool/libvirt-ci<br>
&gt; +++ b/tests/lcitool/libvirt-ci<br>
&gt; @@ -1 +1 @@<br>
&gt; -Subproject commit b0f44f929a81c0a604fb7fbf8afc34d37ab0eae9<br>
&gt; +Subproject commit c8971e90ac169ee2b539c747f74d96c876debdf9<br>
<br>
That submodule update looks like an accident?<br>
<br></blockquote><div><br></div><div>Oops.. thanks for noticing <br></div><=
/div><br clear=3D"all"><br><span class=3D"gmail_signature_prefix">-- </span=
><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br><=
/div></div>

--000000000000e2213105ffa5de4e--


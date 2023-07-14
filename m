Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6057F75438E
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 22:04:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKP0m-0004vK-3E; Fri, 14 Jul 2023 16:03:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qKP0k-0004vB-Jl
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 16:03:30 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qKP0i-0005g8-S7
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 16:03:30 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-403b6b7c0f7so17196071cf.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 13:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689365007; x=1691957007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TQmfZZ+QNcfaiN/CBf24pucBr13xeOBGxcxuyyBv0bg=;
 b=s1ULAj6Gd1mug+Vu9eGv7MnSoAof2Myj/fWxcnEkNt8Ai8/uhYyKdDh4q1gIdSdw/f
 yUwty5rNMsfL9o3LcKRfIfrVtOOqhZzAiK6nmCu+kwmOgBptSo6wa+mgimLIdMLvmG8c
 tqbdC7ArnawQ6jKBR701ESmTETFkfXeYuXRckNy1UAM1BA5Xya1EhtKS4YgBtZbuobXi
 lzUR4cprPRUvDRys4EfGm3or8xblimg9Q476kwphCXw9ne+kYLuiPwgK5IkjU2b8q0hD
 BH6zY9HKwrcjMh8UjKc9pOTcEH73XBIbIj6RELsTw8ssMtOwxOqQvKYNcBQmNrUR4dCR
 /Krw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689365007; x=1691957007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TQmfZZ+QNcfaiN/CBf24pucBr13xeOBGxcxuyyBv0bg=;
 b=DvpNlo4tckhLkZefChbaHXVvnW1YdhZpcE7FZxq3Z2KQYeE/DZAIg8fDYWLNiDEaWj
 ar9I0J2wTLfaIfKbfOITK0zIq7NKLKHuwCSxwzRpD4EAP1iIGEdiaU4oKq8/POOaFUjx
 HyiABNYyllMuzSDSJd2S/8WdatyvI12yxyyTFVLqyLv38Kg1EjhPUcqUePSR05tJOOWr
 uxB9hYcc1CtIPG26Gi5GM1CTLxtzEjzk10Ej1xKkZNWqR+MFHQkSnwPjeupJWUSMmlBM
 AbhbdSh7cjKU/SjdkSSADL1nEe/xm06gganLeALJKLaOEHgulnY5VF4EUkJDAaO+1nLn
 f4Pg==
X-Gm-Message-State: ABy/qLY1KcbUB4WrSOjni6VJCL0Pb+gXLeml5/RQG1Q+PYHrtheBR27w
 z2eX3qe8Es4cUGLuYs2E9uWsGP8+L/39iIArJLo=
X-Google-Smtp-Source: APBJJlE/u9BeEHv0iv/rFPfS3PJEBif9NJ5SFjY/Ox7O/OZ4Rkl7csp4n17wZ5tfamKO7yXRjEtx9kJYhckzlQYs3c4=
X-Received: by 2002:a05:622a:11c2:b0:403:b23f:9aab with SMTP id
 n2-20020a05622a11c200b00403b23f9aabmr7582571qtk.7.1689365007426; Fri, 14 Jul
 2023 13:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230714153900.475857-1-ernunes@redhat.com>
In-Reply-To: <20230714153900.475857-1-ernunes@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 15 Jul 2023 00:03:16 +0400
Message-ID: <CAJ+F1C+3SGHOwCsZt7nTY8_4EVD4j8M7cA1Sc=Dh_-qYn_DVkw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vhost-user-gpu: support dmabuf modifiers
To: Erico Nunes <ernunes@redhat.com>
Cc: qemu-devel@nongnu.org, slp@redhat.com
Content-Type: multipart/alternative; boundary="00000000000029e720060077f1a4"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82b.google.com
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

--00000000000029e720060077f1a4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Jul 14, 2023 at 7:42=E2=80=AFPM Erico Nunes <ernunes@redhat.com> wr=
ote:

> virglrenderer recently added virgl_renderer_resource_get_info_ext as a
> new api, which gets resource information, including dmabuf modifiers.
> https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_requests/1024
>
> We have to support dmabuf modifiers since the driver may choose to
> allocate buffers with these modifiers to improve performance, and
> importing buffers without modifiers information may result in completely
> broken rendering.
>
> Currently trying to use vhost-user-gpu for rendering backend and using
> the qemu dbus ui as a ui backend results in a broken framebuffer with
> Intel GPUs as the buffer is allocated with a modifier. With this
> patchset, that is fixed.
>
>
> It is tricky to support since it requires to keep compatibility at the
> same time with:
> (1) build against older virglrenderer which do not provide
> virgl_renderer_resource_get_info_ext;
> (2) runtime between frontend (qemu) and backend (vhost-user-gpu) due to
> increased size and a new field in the VHOST_USER_GPU_DMABUF_SCANOUT
> message.
>
> I tried to reach a compromise here by not defining a completely new
> message and duplicate VHOST_USER_GPU_DMABUF_SCANOUT but it still feels
> like a bit of a hack, so I appreciate feedback if there is a better way
> (or naming) to handle it.
>

looks fine to me, we may consider this as a fix for 8.1 imho
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>
>
> Erico Nunes (3):
>   docs: vhost-user-gpu: add protocol changes for dmabuf modifiers
>   contrib/vhost-user-gpu: add support for sending dmabuf modifiers
>   vhost-user-gpu: support dmabuf modifiers
>
>  contrib/vhost-user-gpu/vhost-user-gpu.c |  5 ++-
>  contrib/vhost-user-gpu/virgl.c          | 51 +++++++++++++++++++++++--
>  contrib/vhost-user-gpu/vugpu.h          |  9 +++++
>  docs/interop/vhost-user-gpu.rst         | 26 ++++++++++++-
>  hw/display/vhost-user-gpu.c             | 17 ++++++++-
>  5 files changed, 102 insertions(+), 6 deletions(-)
>
> --
> 2.40.1
>
>
>

--=20
Marc-Andr=C3=A9 Lureau

--00000000000029e720060077f1a4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 14, 2023 at 7:42=E2=80=
=AFPM Erico Nunes &lt;<a href=3D"mailto:ernunes@redhat.com">ernunes@redhat.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">virglrenderer recently added virgl_renderer_resource_get_info_ext as a<b=
r>
new api, which gets resource information, including dmabuf modifiers.<br>
<a href=3D"https://gitlab.freedesktop.org/virgl/virglrenderer/-/merge_reque=
sts/1024" rel=3D"noreferrer" target=3D"_blank">https://gitlab.freedesktop.o=
rg/virgl/virglrenderer/-/merge_requests/1024</a><br>
<br>
We have to support dmabuf modifiers since the driver may choose to<br>
allocate buffers with these modifiers to improve performance, and<br>
importing buffers without modifiers information may result in completely<br=
>
broken rendering.<br>
<br>
Currently trying to use vhost-user-gpu for rendering backend and using<br>
the qemu dbus ui as a ui backend results in a broken framebuffer with<br>
Intel GPUs as the buffer is allocated with a modifier. With this<br>
patchset, that is fixed.<br>
<br>
<br>
It is tricky to support since it requires to keep compatibility at the<br>
same time with:<br>
(1) build against older virglrenderer which do not provide<br>
virgl_renderer_resource_get_info_ext;<br>
(2) runtime between frontend (qemu) and backend (vhost-user-gpu) due to<br>
increased size and a new field in the VHOST_USER_GPU_DMABUF_SCANOUT<br>
message.<br>
<br>
I tried to reach a compromise here by not defining a completely new<br>
message and duplicate VHOST_USER_GPU_DMABUF_SCANOUT but it still feels<br>
like a bit of a hack, so I appreciate feedback if there is a better way<br>
(or naming) to handle it.<br></blockquote><div><br></div><div>looks fine to=
 me, we may consider this as a fix for 8.1 imho<br></div><div>Reviewed-by: =
Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@redhat.com">m=
arcandre.lureau@redhat.com</a>&gt;</div><div>=C2=A0<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
<br>
Erico Nunes (3):<br>
=C2=A0 docs: vhost-user-gpu: add protocol changes for dmabuf modifiers<br>
=C2=A0 contrib/vhost-user-gpu: add support for sending dmabuf modifiers<br>
=C2=A0 vhost-user-gpu: support dmabuf modifiers<br>
<br>
=C2=A0contrib/vhost-user-gpu/vhost-user-gpu.c |=C2=A0 5 ++-<br>
=C2=A0contrib/vhost-user-gpu/virgl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 51=
 +++++++++++++++++++++++--<br>
=C2=A0contrib/vhost-user-gpu/vugpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 9 +++++<br>
=C2=A0docs/interop/vhost-user-gpu.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 26=
 ++++++++++++-<br>
=C2=A0hw/display/vhost-user-gpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 17 ++++++++-<br>
=C2=A05 files changed, 102 insertions(+), 6 deletions(-)<br>
<br>
-- <br>
2.40.1<br>
<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--00000000000029e720060077f1a4--


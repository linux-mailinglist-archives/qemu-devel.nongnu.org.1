Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B36C82D433
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:29:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPGTM-00081q-7H; Mon, 15 Jan 2024 01:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rPGTI-00081O-GQ
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:29:20 -0500
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rPGTG-0004qW-EI
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:29:20 -0500
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-28e1f11d300so1556131a91.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 22:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1705300034; x=1705904834;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UDqqtEHtTjh2AgP4j+3/SOSLmLXoEgOyQhCZQv9z3DU=;
 b=tnYOodWaQdrFkjM8wppesitxlkSjWv6Ty0345Rzj7LDElvHL/ILZYbVuZ+AMjpOcgv
 JwE8BJX6ROOhtfpcrKLpkV4oefY7YqTsSxIDwvCIWqL/3I6KTXVAp8j+w4VkctYRSxnK
 xDub/QQ7qcCsp+Ebdg79uSW2dsu7sdVqw5NT+OVM9HxLVxCEIofExf/XExgZ3Gqbgcn7
 ehORzopU+uKEyVUlBOwLnTUMZLizNY0SioSJCbOo0ZX7LyyYT0o1PqECnSKsF9HseOvy
 Gmg9mAXFUVSlTCXqkilLBYSKcOxkFnC6VoUSytO83G4Spdgor2vyDqEpceQj49aOpMfc
 bi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705300034; x=1705904834;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UDqqtEHtTjh2AgP4j+3/SOSLmLXoEgOyQhCZQv9z3DU=;
 b=uUBQXTBb3CjfBXvBQJjn7vH+pBkO7NEOj5TBSBwd0ex6AF9+wCcZ2Q3esdBXq+hEmX
 z5ohcbTnbqavlub/OXm30v0DomhFLKkP0tdYnQUefxcLZ+XSKp3kAnC/k6wUH9VB5PBP
 6vuGrHJJ7hIqxIUqn22xEVq7gOZzXDgSzkVOygWD7VxDeQ+QGA2vZEI5wYJvwVx5igvE
 PSkZRJ9Mq37WuwYShHTUSqWhsnjTsBBrlAH6/Xnw2+t78Bzt6N9BaGPH60FOYb3IBaXA
 LuuIZgSPKjqlf78maYNfOmJYqdPxDibzcFApDDF/zDc2zxYGGI8CCHjtHwwmtRAXs/Cn
 47Qw==
X-Gm-Message-State: AOJu0YwslkaKeHHP1FoNXKkD3LtL71wrB9RY8+1JwLe6NNYQ7UqmzRrf
 Ik31CDDZW4DUo3Ulgyt2PfarwNm5nSni8nFKQEbo5pMkIC46LXFTqLj8qRq9ImM=
X-Google-Smtp-Source: AGHT+IHLujhSxM+mQZz8KYYb/9DvCMb2GPq5LFpbOqZFzSnMdPtsSGmhKIrvr1qSlXVCP45ci28F2naoVF6deNWvsFA=
X-Received: by 2002:a17:90b:3651:b0:28c:1eff:ac4a with SMTP id
 nh17-20020a17090b365100b0028c1effac4amr3078049pjb.90.1705300033231; Sun, 14
 Jan 2024 22:27:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1704626686.git.yong.huang@smartx.com>
In-Reply-To: <cover.1704626686.git.yong.huang@smartx.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Mon, 15 Jan 2024 14:26:57 +0800
Message-ID: <CAK9dgmZt2q_=E+QQaDMx7jGkHVv0OwWK+FBEKV9i7AX360EGEw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Nitpick at the error message's output
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000b76d52060ef61a8c"
Received-SPF: none client-ip=2607:f8b0:4864:20::1030;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1030.google.com
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

--000000000000b76d52060ef61a8c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping

On Sun, Jan 7, 2024 at 7:53=E2=80=AFPM Hyman Huang <yong.huang@smartx.com> =
wrote:

> v2:
> - rebase on master
> - add a commit to sort the error message so that an explanation
>   error number can be returned on all failure paths
>
> Hyman Huang (2):
>   i386/sev: Sort the error message
>   i386/sev: Nitpick at the error message's output
>
>  target/i386/sev.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> --
> 2.39.1
>
>

--=20
Best regards

--000000000000b76d52060ef61a8c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:comic sa=
ns ms,sans-serif">Ping</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sun, Jan 7, 2024 at 7:53=E2=80=AFPM Hyman =
Huang &lt;<a href=3D"mailto:yong.huang@smartx.com">yong.huang@smartx.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-co=
lor:rgb(204,204,204);padding-left:1ex">v2:<br>
- rebase on master<br>
- add a commit to sort the error message so that an explanation<br>
=C2=A0 error number can be returned on all failure paths<br>
<br>
Hyman Huang (2):<br>
=C2=A0 i386/sev: Sort the error message<br>
=C2=A0 i386/sev: Nitpick at the error message&#39;s output<br>
<br>
=C2=A0target/i386/sev.c | 10 +++++++---<br>
=C2=A01 file changed, 7 insertions(+), 3 deletions(-)<br>
<br>
-- <br>
2.39.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div>

--000000000000b76d52060ef61a8c--


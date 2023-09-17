Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A243F7A3524
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Sep 2023 12:35:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhp6G-00032u-NC; Sun, 17 Sep 2023 06:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qhp6E-00032h-DK
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 06:33:58 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qhp6C-0000Ds-D6
 for qemu-devel@nongnu.org; Sun, 17 Sep 2023 06:33:58 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2bffa8578feso9066591fa.2
 for <qemu-devel@nongnu.org>; Sun, 17 Sep 2023 03:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1694946833; x=1695551633;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XH4ZIcpAPKee0Y2Ck7XnVkjJ79hA8L4gJJDQJ6JBXnc=;
 b=2MMS+NQMcYc1S5sl67T2JBUmqog4plmeCN+ocmm1PkKc9aOLIiRaxflq7KQ0z3vKpU
 EwZMYGR/eyW2pPg+EsPn5T+wEQrMY4hbLUwO+lF7Dp6bOaC1eEjv2LRH5RDpw4M/Rq/k
 hLtY9su9oqx6scpq9W/X+u1iBo3OsOa5MTTrZg7dV1lvO6ZgDC22qhRCclbaEQzanE3y
 4sB/0EttjLv01Gn5TL6hBd790JFbMwgBt3Qy1U/0KKV69UieLyOG2DJzbb3CKzgRwboP
 WkCEUIZ55KmQMUyCv08gerHmfJWzWwIex7wxyHPV7jfATErIB42ByJdkVMdviMOHFQ1z
 2pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694946833; x=1695551633;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XH4ZIcpAPKee0Y2Ck7XnVkjJ79hA8L4gJJDQJ6JBXnc=;
 b=iHFNaaXDTqc2m9h97zGdHKeiNLz/0uUGBfRYoECz9TCq5urcE8CHXYdUoAqSfWdyfM
 8X7PD5tPrBlPzgnOoeAc9oufuuOm1XhVXyak/HL5QaC1+jH9YiZ8SfS+63XAeoJW7aR6
 gmfSzc3Ywq+W1CTDNiFKn0ct2SbH3p6BzsFBK8SVgIgDqs1114GQ4hD2fBhqsB/iEpZj
 BsKZhixA4ld6XaqCycExrcQtWNl3LUlLUN5w32Y/qalALfLaSYTTnF75TMkrLZrrOLyx
 XNOxDKwL7Gy/lOku0WUaEeSobcRAN0Kf3E+IlAWKHsb+lZVk60Dd/g4Y455ggeeiGRn5
 CbZw==
X-Gm-Message-State: AOJu0YyNa+TYy0RWJtOjHh5R+hhHj8Hi7bgl3B0cW1FNU1LoBRLWR6Bs
 HMJSYtjBTwX7HEL8GsEU12GpUiftmb2A9GqFu6VpLQ==
X-Google-Smtp-Source: AGHT+IFO88lmMkJ/xxqmoFsYDmvwgyS4AHMKDZc2OriIAo0Cot3nh8xYNnFQxoUZi/NH+RT9m4P/2AqtwJSQLaq8cI4=
X-Received: by 2002:ac2:4831:0:b0:500:9dd4:2969 with SMTP id
 17-20020ac24831000000b005009dd42969mr4530668lft.59.1694946832576; Sun, 17 Sep
 2023 03:33:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
 <20230914204107.23778-6-kariem.taha2.7@gmail.com>
In-Reply-To: <20230914204107.23778-6-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sun, 17 Sep 2023 11:33:41 +0100
Message-ID: <CANCZdfobohsagMjCWyzs3--EC5PiCbmHcnpyC+9TgxZrC=03xw@mail.gmail.com>
Subject: Re: [PATCH v5 05/23] bsd-user: Implement shm_open2(2) system call
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000de8a4706058b8f44"
Received-SPF: none client-ip=2a00:1450:4864:20::22b;
 envelope-from=wlosh@bsdimp.com; helo=mail-lj1-x22b.google.com
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

--000000000000de8a4706058b8f44
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 9:42=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/freebsd/os-misc.h    | 42 +++++++++++++++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c | 10 +++++++++
>  2 files changed, 52 insertions(+)
>


Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000de8a4706058b8f44
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Sep 14, 2023 at 9:42=E2=80=AF=
PM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Signed-off-by: Kyle Evans &lt;kevans@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/freebsd/os-misc.h=C2=A0 =C2=A0 | 42 ++++++++++++++++++++++++=
+++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c | 10 +++++++++<br>
=C2=A02 files changed, 52 insertions(+)<br></blockquote><div><br></div><div=
><br></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.c=
om">imp@bsdimp.com</a>&gt;</div><div><br></div></div></div>

--000000000000de8a4706058b8f44--


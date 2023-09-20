Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A527A8C0A
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:50:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj2Gg-00039Q-Lu; Wed, 20 Sep 2023 14:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2GW-00036e-Ee
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:49:36 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj2GU-000630-RV
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:49:36 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-503f39d3236so360388e87.0
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695235773; x=1695840573;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZkaBfPMZ7yFbgbT36BW23+hezAMyGluBi7UkJxuL9iI=;
 b=MKZpP2IDvNLWFRCeuKL5GOZI7tFRFoy/PnOzo/J6Ykp4UhzY9zMiaJTW12snjj4Bxn
 oIigbNSq9whm/AGUwm5iLK+q39oxww/wdJTM9KUk5QBniO0oEzEFSEKtxxDyzFTs5PTA
 9lABPcm5nRo5DVN8Dzvh1i+NYkCY4DtHGWxUEtZ0s89auBqMpssoyqW7t0gAyXR9sCSv
 A7fyuEKMRGCZ4DJ9udBxRjgzDVpB+F09c7ho8YBovlbrDhx4ARgG1oxbFYgEWDBokZts
 Kjkd1j8JJrmAAIppJ1CegrcFs3+Q8SaFfgIqtVXnc2h73VxrwUj/7XNvwQxgLRWTPkWM
 ojjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695235773; x=1695840573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZkaBfPMZ7yFbgbT36BW23+hezAMyGluBi7UkJxuL9iI=;
 b=ZdkwdA6tlXk3DO974MPtOIz5+NP0o0wRtSL9Ueybc1jdbe3o8VudhHSXaZLV6TnkWg
 WBloUCXctYswk+qO3ovUmDs0GZhaev9cJd0gPBNqbe2K4sDMd2CXCGi9nsjbtUdak1xp
 dndOUX8gKlRKHOZdkvep0bwi3PebALW4YDqKk6pYkr0McI0UGhq9v54bRSXSVzT+OuWE
 HQivBSJtv1HVRLfeGzLuJ5F05syYjNed0lwz2kz59boUCCZs0jKVGYpU1VT0fzMaKoYx
 TC2AvDmbPH5LlCMXZZWSzC5QAKcfXbftJQzFp1YCv1qsdhTnZaZZ1qjW0eZnyN7IZW1B
 ymiQ==
X-Gm-Message-State: AOJu0YwiMKtpd8oJkDv3m8akscJi9o5purx17dDNYQTRr30W6wpEeOOC
 xTkc7oKejz4zRNf142PgR6XKXV5JBr4S7ZYQwZQRpg==
X-Google-Smtp-Source: AGHT+IFUfGD1HdCBreoun8hRFD/inCM0+g6I1y1ciAChZ2fUHfrIOpEpvjn69ufJ9oBgIw+hlZZOvcbPshVphd62Ono=
X-Received: by 2002:ac2:4bd4:0:b0:4fd:faa5:64ed with SMTP id
 o20-20020ac24bd4000000b004fdfaa564edmr3614741lfq.11.1695235773060; Wed, 20
 Sep 2023 11:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-20-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-20-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:49:22 +0100
Message-ID: <CANCZdfox0Bi3Hg1RxEOvDam+EwdNua8wbzSNUj0gW0m=uOWd+Q@mail.gmail.com>
Subject: Re: [PATCH v2 19/28] bsd-user: Implement get_filename_from_fd.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000010720e0605ced626"
Received-SPF: none client-ip=2a00:1450:4864:20::130;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x130.google.com
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

--00000000000010720e0605ced626
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/freebsd/meson.build |  1 +
>  bsd-user/freebsd/os-proc.c   | 80 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 81 insertions(+)
>  create mode 100644 bsd-user/freebsd/os-proc.c
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--00000000000010720e0605ced626
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 17, 2023 at 10:39=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/freebsd/meson.build |=C2=A0 1 +<br>
=C2=A0bsd-user/freebsd/os-proc.c=C2=A0 =C2=A0| 80 +++++++++++++++++++++++++=
+++++++++++<br>
=C2=A02 files changed, 81 insertions(+)<br>
=C2=A0create mode 100644 bsd-user/freebsd/os-proc.c<br></blockquote><div><b=
r></div><div>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com"=
>imp@bsdimp.com</a>&gt;</div></div></div>

--00000000000010720e0605ced626--


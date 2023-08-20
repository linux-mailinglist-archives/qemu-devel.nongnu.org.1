Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 764E0781C69
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:43:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXaHT-0007xt-4z; Sun, 20 Aug 2023 00:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaHP-0007xe-AK
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:43:11 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaHN-0002Rj-7O
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:43:11 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-99c0cb7285fso271958766b.0
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692506587; x=1693111387;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2TM2jGSDfDMPqHid/mn3h9umFtxNljf6p+kNCwRMMHg=;
 b=HFcDB0/AzfARRvtafRpmvtR9d8+BfXQhEf3HJaABFXNhErkIKrqB5ow65JMSSN2nCp
 piwB5FL+fNjjr/9xx7JTGirTr2iubLAs33MAfJR5ot1LQAzQoAtoHGH1dWvEpQtOBLDV
 /1pwx3AfsXvyFrxz6jsiT+8xkE819dGEEWlXcX61TMjfVO8iLA/F6ki8vBlh5gpkOMLw
 8lANc87SpyM9gR/aiSRXkt86eTCp59ALhD+/3NGez2DVx6riTIeQs28EUCeoos5fwuLF
 XgYdMD5ipsKTiOAFiipukGceMKE395gn0e9WaNbxh0S1atA/pDsQMrc+ZZhUVi0iGWO+
 L/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692506587; x=1693111387;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2TM2jGSDfDMPqHid/mn3h9umFtxNljf6p+kNCwRMMHg=;
 b=S+aE5NaEkIs7wgPnIp7ze6ki193B2KeM/dlpqM7OUbmDgDvTLzPmoJgy0d66S8ZDUx
 4AvU6OuJkj6TidC70GM9SB2fn9wJgnPVB+x5ksg1vK3o0zeVR4cZc+G5JesqDaNAm3rc
 agKYTXSvWStP5udsKHnZJb6e7SkEN6a2Kg+oUGgxtaVmjmzmCbLo0zU46Nt6BedCInzY
 vvrVB0bzGhitVaU+N2X58S+FJqmx8wBF+k0qewpcO2b2szg2wI0VZNuEkskFOpI88O2+
 VosiMIV938qZoZZLLk/He61S2+SPJK/zU97maD5myM2mXPFlTjwiWboE1Wggs2y6JZkE
 oEcA==
X-Gm-Message-State: AOJu0Yw2VlDjsnrzn5Uvi1bwM7yXwBjVRVAK7vK1WwKE0iU+YaGpnHv+
 tFbERNrloDVbr8kzqc6VTf5MzfezF1TMplluIyurqA==
X-Google-Smtp-Source: AGHT+IHpRfu+dQhvjFILDnf/+ti5yTYvbSReUe9mN+uw9Z84OkcZKJJ8Pf65G+QXAXg9EzqWdieyC/IbwovX4QeqApA=
X-Received: by 2002:a17:906:30c3:b0:9a1:83a4:6979 with SMTP id
 b3-20020a17090630c300b009a183a46979mr1097344ejb.73.1692506586825; Sat, 19 Aug
 2023 21:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-20-kariem.taha2.7@gmail.com>
In-Reply-To: <20230819094806.14965-20-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:42:59 -0600
Message-ID: <CANCZdfqaokMoA1M8PtLcFyXOBb0_9L1gWXYZWb-+Nw0LoQP4KQ@mail.gmail.com>
Subject: Re: [PATCH 19/22] Implement shm_unlink(2) and shmget(2)
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000e356eb06035365c1"
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

--000000000000e356eb06035365c1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 3:49=E2=80=AFAM Karim Taha <kariem.taha2.7@gmail.co=
m> wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
> ---
>  bsd-user/bsd-mem.h            | 23 +++++++++++++++++++++++
>  bsd-user/freebsd/os-syscall.c |  8 ++++++++
>  2 files changed, 31 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000e356eb06035365c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 19, 2023 at 3:49=E2=80=AF=
AM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.taha2.=
7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-mem.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 23 ++++=
+++++++++++++++++++<br>
=C2=A0bsd-user/freebsd/os-syscall.c |=C2=A0 8 ++++++++<br>
=C2=A02 files changed, 31 insertions(+)<br></blockquote><div><br></div><div=
>Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.=
com</a>&gt; <br></div></div></div>

--000000000000e356eb06035365c1--


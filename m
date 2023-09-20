Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 403427A8B15
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:04:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1Yj-0002cc-1l; Wed, 20 Sep 2023 14:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1Ye-0002bz-9f
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:04:16 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1YY-0006QQ-7G
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:04:16 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9a21b6d105cso1489766b.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695233042; x=1695837842;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZRJHYrNWduWBda1NCCT63Vk/Vg//Gv64R4hzlcOI9jo=;
 b=nuqm1R88jxinDM8Oy5AFL8okEc24IQdD+jwegbMGuzHtmbrb/T9DnYwIF2GOfB2u7V
 ov4NvqljGgdnodv0TjCmpyfLbc2vxq3mM3WtuFn0v0tsQNJ9xEvolSJDY8xsgqC2D4gE
 qWTfMrj4zC9RP1xwK3RHjyywVaEpv2iwZ8sMvOELCq3lbVYtAU1OSH6FfBr+N9rUHWPZ
 kYkj1EM8SxQ/Wdvm2zs9ABeUacaRC7DPC63LOg/LWzYACyTzf2kM9DsxnxCVGEia1nUX
 UziYzQv1cwFigsGoyCWVa84HrmTbG54pgNWIRqhgXiHQdiasvOAmgYmZZT/k1QOlTbD4
 8H7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695233042; x=1695837842;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZRJHYrNWduWBda1NCCT63Vk/Vg//Gv64R4hzlcOI9jo=;
 b=AV3svPAO3dvM2TGalzlUMzQHmgP4FbXThfhIvVzpV/7T8BobNe8rrIHA+tLvVIlhDi
 Mhs+tZfQRsXseYBWd2pwdaRAKdpYw9ZTynliAZv+R7oS6ebQ69U4Ct3auGzplcNxrY2N
 PSQkpKrDOKkEvvk6ZSC5MVQ7TbtJMGiNBDZtefU13asW37eOPusbYZ3hNdi+X8/vdPug
 CTdW2XW7dk+yBefYE2R1nK5A/NpErNzXSkn0lSqb8GOc3LSnEg7yhm20oPAD9YH7U5Pq
 U9xKtpK8HbCceQ11LFyWIcYAr1lCYNR3YLTLidnmSOFtVxk9nUz6WDR0pBDi/tAR/3Qc
 UHxg==
X-Gm-Message-State: AOJu0YzVJmz+VTZY40qZT6G9ZjxrRGRxfPm2TE2H20sTmGLI2Eyz0Fsl
 uYyg8nlfnu3YvoxJXBugtylYg7brHSHZaSCqrp/cuw==
X-Google-Smtp-Source: AGHT+IFYIVIdA+aYHrfngTs9C1NojWHs4WtoKDKFJ59n+rM4+Ce6J2G0qtqdutGmLnFR5durzBKNNKpEXR3HDJuDdA4=
X-Received: by 2002:a05:6402:1b1b:b0:52b:db31:3c5c with SMTP id
 by27-20020a0564021b1b00b0052bdb313c5cmr2949929edb.0.1695233042157; Wed, 20
 Sep 2023 11:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-3-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-3-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:03:51 +0100
Message-ID: <CANCZdfpXkoASdbcwoV6UXkk+CZrBFXBrB0m4Qt0B61eFdnsXwg@mail.gmail.com>
Subject: Re: [PATCH v2 02/28] bsd-user: Define procctl(2) related structs
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000004a264f0605ce3355"
Received-SPF: none client-ip=2a00:1450:4864:20::62f;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62f.google.com
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

--0000000000004a264f0605ce3355
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Implement procctl flags and related structs:
> struct target_procctl_reaper_status
> struct target_procctl_reaper_pidinfo
> struct target_procctl_reaper_pids
> struct target_procctl_reaper_kill
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/syscall_defs.h | 42 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--0000000000004a264f0605ce3355
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 17, 2023 at 10:39=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Implement procctl flags and related structs:<br>
struct target_procctl_reaper_status<br>
struct target_procctl_reaper_pidinfo<br>
struct target_procctl_reaper_pids<br>
struct target_procctl_reaper_kill<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/syscall_defs.h | 42 ++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 42 insertions(+)<br></blockquote><div><br></div><div>=
Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.c=
om</a>&gt;=C2=A0=C2=A0</div></div></div>

--0000000000004a264f0605ce3355--


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 980067A8B64
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 20:14:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj1id-0008RD-Cw; Wed, 20 Sep 2023 14:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1ia-0008QT-VK
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:14:32 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qj1iX-0008Te-Va
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 14:14:31 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50305abe5f0so234527e87.2
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 11:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1695233666; x=1695838466;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ozwdcTHnO9noS/J0IM3lEmwxgqkRpTB2OCXCUWSmqQQ=;
 b=EjCff4kYhKxx0SE/r8yODB2fhDC0q3yXY7jbrLODqcBOAGy7VKIkWsHGavvR4DpU1F
 jZoRBQV8vG3SypK78iTfQKYEQJs4ejlozp/VEJ9v42K2eU57wJzoiyyOe4dcq1fbgccm
 qTb9CmMY4Ys+O/GwD4B/a4tnUeGzlob5n7UMbrZmvO78iOHEMl2LHflw3SW+nWpoz9Mn
 d5KWN6+J9cq42JKxFulZQWX0o8b2m08n2AFKGFOsSkekPGVbsWfY2dLnFXoA7XX6bUzc
 RiXtywEhamSm1BbwcYbScJoE1mC/u3vXGXFYs1nKl8sF+wNqT0rWEOoU7Mc8JLPdC5K0
 UaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695233666; x=1695838466;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ozwdcTHnO9noS/J0IM3lEmwxgqkRpTB2OCXCUWSmqQQ=;
 b=ELdFuEgUZdo40lZiXlI+mxoPapK8sT+MKQKmUviwtL4tKpMlchtEk7aPqFjNNiL1FE
 OD3QoZbLg2Ig/zye5+KFY+JpV8HC8kNaJXlc8lBDn6JYVgNuVvnpkJaaWxpMarkKTd65
 aZvhtKKpekkhpFfH5VpO5IXxVSu9MtOW55npXedjImG21rtCBlplXklbgRPSd2xlnYUk
 aM2DJbmhr9dQCRiDX2o0Y6i5tW/Yq7QGqToAk11mXeucnbxE2D89YpUVwrB9Z+X6dik2
 ro5E8Nk+68yP9c7LvpSo6JL1okwXCEG4a7PEXiKpveOdxabsQOmw2mPRHoMtzDL4Or4l
 Bn7g==
X-Gm-Message-State: AOJu0YzppnPs8wwdN66afjBY0vKBMInzg6IWEvhC02Tygljgea/0ofJO
 CxrTHLvFFGrSe+pYR99fLdOzbDs9EJ4jIDwsghxYuQ==
X-Google-Smtp-Source: AGHT+IFvO03lWtzkcUz/jfyQ9B5ACcEUTKU0Dk6uKxe6WA7K4SuqBthKgns2zIRH3knq6dZJdpoGcNJNwWa4yagcd7k=
X-Received: by 2002:ac2:5dd7:0:b0:500:7806:4f96 with SMTP id
 x23-20020ac25dd7000000b0050078064f96mr3005530lfq.28.1695233666322; Wed, 20
 Sep 2023 11:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230917213803.20683-1-kariem.taha2.7@gmail.com>
 <20230917213803.20683-10-kariem.taha2.7@gmail.com>
In-Reply-To: <20230917213803.20683-10-kariem.taha2.7@gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Wed, 20 Sep 2023 19:14:15 +0100
Message-ID: <CANCZdfqHrmZqvv_K+A9vO2AhHxG65mprNdAx0GjyQ7BK665Mwg@mail.gmail.com>
Subject: Re: [PATCH v2 09/28] bsd-user: Implement host_to_target_waitstatus
 conversion.
To: Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000007e2b7b0605ce589f"
Received-SPF: none client-ip=2a00:1450:4864:20::134;
 envelope-from=wlosh@bsdimp.com; helo=mail-lf1-x134.google.com
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

--0000000000007e2b7b0605ce589f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 17, 2023 at 10:39=E2=80=AFPM Karim Taha <kariem.taha2.7@gmail.c=
om>
wrote:

> From: Stacey Son <sson@FreeBSD.org>
>
> Signed-off-by: Stacey Son <sson@FreeBSD.org>
> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/bsd-proc.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>

Reviewed-by: Warner Losh <imp@bsdimp.com>

--0000000000007e2b7b0605ce589f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sun, Sep 17, 2023 at 10:39=E2=80=
=AFPM Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com">kariem.tah=
a2.7@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
<br>
Signed-off-by: Stacey Son &lt;sson@FreeBSD.org&gt;<br>
Signed-off-by: Karim Taha &lt;<a href=3D"mailto:kariem.taha2.7@gmail.com" t=
arget=3D"_blank">kariem.taha2.7@gmail.com</a>&gt;<br>
<br>
Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/bsd-proc.c | 17 +++++++++++++++++<br>
=C2=A01 file changed, 17 insertions(+)<br></blockquote><div><br></div><div>=
Reviewed-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.c=
om</a>&gt;=C2=A0</div></div></div>

--0000000000007e2b7b0605ce589f--


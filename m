Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C50781C77
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 06:54:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXaRD-00036c-Dg; Sun, 20 Aug 2023 00:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaR9-00036R-7o
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:53:15 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qXaR7-0004BI-22
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 00:53:14 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99c0290f0a8so271073766b.1
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 21:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692507191; x=1693111991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oGqLu/mYFY2m3RDIHm2xkcbAEyxlzP5zAYIyIhCi13Q=;
 b=tMjp4sudoGXT0rF/LH5ql66PheGIyTtx0l555jYoKDA0rrpye/nxkqM/DqFM77aBG+
 LbGTa0vjlqMdj1J3Mo95CE0OGD78bLfGRGIWeyX7NbujTXu/fUPUaOWrxgxMj/BN8Jl5
 hNYneyQZ3EU3J4FahjZ9+6qZdic/AvEWip1xwi7yZeO+nG4ULihA8X1MfP+PO8dX7Qay
 mkjYMw6rKSAuSq18jiBmDDHAJAR2sBixaX+NK22z44TvKlyzr/RNDSz16lkcDH8W9VW3
 BUCP+j6SEvZ71Nrzt99Xtc2gtY1paeoOzdIItWcW8OvGwdf73HdnOaIDTlJLy7JTnAgQ
 OLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692507191; x=1693111991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oGqLu/mYFY2m3RDIHm2xkcbAEyxlzP5zAYIyIhCi13Q=;
 b=GzdedKmmVyQSuwk4PZjA7ktb33dYS4hvFFmuQ0vghu9gJzesBuo7bXjIpZwehYkDRt
 TqtWiQC0UFkeANxUlmduStFxe+VlxEsZtTKwtDuYP6BTHPXchwrVFHbcjuS3lfnnTrDN
 I2oszIB0uwNEGpgbvZCOSuj6nozbk6kEie41P6X7rA6AiIu0Y342/WQB6xIdx1gW5NWW
 +eYfCKaHec4z3QFemlz/F7r/+MbZzOgyWyoA3S+2y80Hy/Ie19umjtlxohb51Lw0H6EH
 TIvDR2rayj610OSjjWYbqbR+01d+QB2OcNUCf7lvTvhEBIG88i6/GyWam9K4AYetdEL1
 wmEQ==
X-Gm-Message-State: AOJu0YwlNoFaQGA1rAMagzdE0jURMaYXZQ5PqfGh707sZR3Z3qegx9Yu
 wIt+jxRIwiUpl7DnatJJO2LN/bZd/jw/g2Jfo5SAyA==
X-Google-Smtp-Source: AGHT+IFvUpGGBrhyyfdWfYjO2ifV0UTeNKVjMMNq59RPuoYq70Gt1oXrNqkbM3Hinb7tzWGqVE1MQdAg1Q4OL/ZjPVs=
X-Received: by 2002:a17:906:30c3:b0:9a1:83a4:6979 with SMTP id
 b3-20020a17090630c300b009a183a46979mr1104775ejb.73.1692507191363; Sat, 19 Aug
 2023 21:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230818175736.144194-1-richard.henderson@linaro.org>
 <7dbdecd7-e3f1-beae-9fbc-55973c8035e2@linaro.org>
In-Reply-To: <7dbdecd7-e3f1-beae-9fbc-55973c8035e2@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 19 Aug 2023 22:53:04 -0600
Message-ID: <CANCZdfpPBdM0LKoL_Ao-Wd6kxyKxtcgBOiB8b9-wDgEQHb9GNQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] bsd-user: image_info cleanups
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ebd9fe0603538930"
Received-SPF: none client-ip=2a00:1450:4864:20::62d;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x62d.google.com
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

--000000000000ebd9fe0603538930
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 19, 2023 at 4:44=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> On 18/8/23 19:57, Richard Henderson wrote:
>
> > Richard Henderson (3):
> >    bsd-user: Remove ELF_START_MMAP and image_info.start_mmap
> >    bsd-user: Remove image_info.mmap
> >    bsd-user: Remove image_info.start_brk
>
> Series:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>

Queued for post release freeze pull request.

--000000000000ebd9fe0603538930
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Sat, Aug 19, 2023 at 4:44=E2=80=AF=
AM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phi=
lmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">On 18/8/23 19:57, Richard Henderson wrote:<br>
<br>
&gt; Richard Henderson (3):<br>
&gt;=C2=A0 =C2=A0 bsd-user: Remove ELF_START_MMAP and image_info.start_mmap=
<br>
&gt;=C2=A0 =C2=A0 bsd-user: Remove image_info.mmap<br>
&gt;=C2=A0 =C2=A0 bsd-user: Remove image_info.start_brk<br>
<br>
Series:<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br></blockquote><div><br=
></div><div>Queued for post release freeze pull request. <br></div></div></=
div>

--000000000000ebd9fe0603538930--


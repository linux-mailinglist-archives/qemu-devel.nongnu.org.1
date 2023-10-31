Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 734417DC972
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 10:25:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxl00-0002UP-T8; Tue, 31 Oct 2023 05:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qxkzy-0002Ta-Vg; Tue, 31 Oct 2023 05:25:23 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <faithilikerun@gmail.com>)
 id 1qxkzx-0002u2-6I; Tue, 31 Oct 2023 05:25:22 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5409bc907edso8424911a12.0; 
 Tue, 31 Oct 2023 02:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698744318; x=1699349118; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gzEZSFmVnJjd1dq4g2w3IjSukfJRXU3CgyhMASuj36k=;
 b=Bw03e5Lbzu/snYcMWcxBtqddSwKoUO8O+AmZ+J6kzg9UCRsvxtcRXpFXllEKCSPGI/
 GA3PL6b14xy+sHopMo7EBbt8LJLu0TrnFsJJsx5YMRe0ul0jAKuHBoh3CtfXi74u++cF
 o8ezz+ki4xLux3GhsCM4ME0OdNiVyso6h68FGMMBmNMuv3p/r4PnWRSndsKTDMhprc9t
 J76IEJD25dG16B10uRIrYzmFyjvFQUCArW5pzfreMhDG5KHIpcCslHpcl2VIYyUO/spw
 zpyzSNUe1Nl/0CN0PFA4LTGvWv6Q75aA6KsdNGywMCGqlxtnL7QKcaSwZf6qtlGVdyXb
 ZDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698744318; x=1699349118;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gzEZSFmVnJjd1dq4g2w3IjSukfJRXU3CgyhMASuj36k=;
 b=SArpYAT5EkIF6Bg6TOt9++DnO/XyfTKqAiYBZva9MhmwEoRam+WM9MjJJeb9y5TiH5
 fGXZbOa4685j3GhqcwzAapJDGrBhgC5wgwLu/R5490IsVkHyP0hol7h+rZge8VK/CdzV
 h9Futf5oLWQDmaB+B83OHPITHSLsBppT8EfSRK1Ix6rjVhIDdLmrPTRKqJvCvRLvxUmZ
 cVO5/0caVryJC8S8IH1vloD/wOjjkNXI/0SilE3Nb4GdoK/5X0EwuPumUXnLKS9BrqOJ
 mD/yc4z1Ulz8TVtUTUq4q6nhlYGLh7CuFxfVItgj8hwVQBL1vBa1NhUSrVPLUGhQhFdo
 f9dQ==
X-Gm-Message-State: AOJu0Yxq+SKPY6AhAWzugX1Qmq/A+1cU52BL8BU7+ru6F/c0YSMNZ08g
 L6cjeHDsqVPKAV2at6sPYZ/NNtwhBwrq2Y9DyiM=
X-Google-Smtp-Source: AGHT+IGsbsK4XKExctlPkS6emIi7hzHZUHc+dQ5t6zmv54w2U6tr3FMYv+r4mYNlRGqn4BdwR/KNf6Fm+a7v1BtRDD8=
X-Received: by 2002:a05:6402:1646:b0:53d:fde3:a99 with SMTP id
 s6-20020a056402164600b0053dfde30a99mr10032433edx.17.1698744317204; Tue, 31
 Oct 2023 02:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230825040556.4217-1-faithilikerun@gmail.com>
 <56a64662-ce50-4ab0-92e5-d23abdcb7358@redhat.com>
In-Reply-To: <56a64662-ce50-4ab0-92e5-d23abdcb7358@redhat.com>
From: Sam Li <faithilikerun@gmail.com>
Date: Tue, 31 Oct 2023 17:25:06 +0800
Message-ID: <CAAAx-8+_t+uRbYORZw+AjqJ2R1pTe2vsfpJYjhM6=L=YQe6BZQ@mail.gmail.com>
Subject: Re: [PATCH v2] block/file-posix: fix update_zones_wp() caller
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org, dmitry.fomichev@wdc.com,
 hare@suse.de, qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 stefanha@redhat.com
Content-Type: multipart/alternative; boundary="000000000000975c780608ffbbc8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=faithilikerun@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000975c780608ffbbc8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looks good, thanks!

Hanna Czenczek <hreitz@redhat.com>=E4=BA=8E2023=E5=B9=B410=E6=9C=8831=E6=97=
=A5 =E5=91=A8=E4=BA=8C17:24=E5=86=99=E9=81=93=EF=BC=9A

> On 25.08.23 06:05, Sam Li wrote:
>
> When the zoned request fail, it needs to update only the wp of
> the target zones for not disrupting the in-flight writes on
> these other zones. The wp is updated successfully after the
> request completes.
>
> Fixed the callers with right offset and nr_zones.
>
> Signed-off-by: Sam Li <faithilikerun@gmail.com> <faithilikerun@gmail.com>
> ---
>  block/file-posix.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
>
> Thanks, applied to my block branch:
>
> https://gitlab.com/hreitz/qemu/-/commits/block
>
> (Rebased on master, and I=E2=80=99ve also fixed the comment to read =E2=
=80=9Cboundaries=E2=80=9D
> instead of =E2=80=9Cbounaries=E2=80=9D.  Hope that=E2=80=99s OK!)
>
>
> Hanna
>

--000000000000975c780608ffbbc8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div>Looks good, thanks!</div><div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Hanna Czenczek &lt;<a href=3D"mailto:hreitz@r=
edhat.com">hreitz@redhat.com</a>&gt;=E4=BA=8E2023=E5=B9=B410=E6=9C=8831=E6=
=97=A5 =E5=91=A8=E4=BA=8C17:24=E5=86=99=E9=81=93=EF=BC=9A<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><u></u>

 =20
   =20
 =20
  <div>
    <div>On 25.08.23 06:05, Sam Li wrote:<br>
    </div>
    <blockquote type=3D"cite">
      <pre>When the zoned request fail, it needs to update only the wp of
the target zones for not disrupting the in-flight writes on
these other zones. The wp is updated successfully after the
request completes.

Fixed the callers with right offset and nr_zones.

Signed-off-by: Sam Li <a href=3D"mailto:faithilikerun@gmail.com" target=3D"=
_blank">&lt;faithilikerun@gmail.com&gt;</a>
---
 block/file-posix.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
</pre>
    </blockquote>
    <br>
    Thanks, applied to my block branch:<br>
    <br>
    <a href=3D"https://gitlab.com/hreitz/qemu/-/commits/block" target=3D"_b=
lank">https://gitlab.com/hreitz/qemu/-/commits/block</a><br>
    <br>
    (Rebased on master, and I=E2=80=99ve also fixed the comment to read
    =E2=80=9Cboundaries=E2=80=9D instead of =E2=80=9Cbounaries=E2=80=9D.=C2=
=A0 Hope that=E2=80=99s OK!)</div><div><br>
    <br>
    Hanna<br>
  </div>

</blockquote></div></div>

--000000000000975c780608ffbbc8--


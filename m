Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E94C79D3F3
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 16:43:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg4ad-0003C7-Ip; Tue, 12 Sep 2023 10:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qg4aY-0003BY-MW
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:42:03 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qg4aW-0003Pw-7b
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 10:42:02 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99c1d03e124so708617566b.2
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 07:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1694529718; x=1695134518;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vUKHpgqm2iAf2/dABtDx/F3pyl52yT4elio4vAfKCc8=;
 b=aFkY+d9/nXXBRuOH5kMCvxZh+qqkqP8eRJuN9HVAuF7KNelHCLdXbApCkzf9d3iOSt
 SK0nQonci+b2abuHb5/u+pc+/8P8XvcqxtHsw+N0bq1s/kMSJwEhLkyU6kEqgEUaU4M1
 A/h2NLR6drm8XjP0/wDNzkFO4mqouzKGenR0SLf+TLt6JjZ8UMJbSzv7HhGuvUYRhBLA
 73z6cxtDUZgE5ViG1VZK6Ei2Ycpb9qe8EgT7p4JLLMsPSPNZgSupCkWpTj0tBb/Ahtr1
 JyFcwuKRWOxJBJ0o4Qr6NCF9yAx0kv7ia3dGLG15xq/miRqy8foCPCH1pNQzu1f0YdpD
 5pKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694529718; x=1695134518;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vUKHpgqm2iAf2/dABtDx/F3pyl52yT4elio4vAfKCc8=;
 b=bHOlkqhzEe9U4IUh+IAPqVS0By6VYPYYkDj556qeVwAfazisSKviHMQz0dxzYrM3RC
 24oqt42jhNdxrWq6E8bYKdj3SWXdvlDyzTf4RHkhLewM7j2SDhfG0/fxZAhobtqHVW6J
 kKVvirLzNrnQuEGBTU+Bxx0YhuWINwquL7SVRzMOk+mlikqp7Mknlyegjqocfl13SSK0
 5Hs3ZV2C0zQRzVcLeXFOOq6tUUh70aygIawZbfNtohxc0AqDorQDSL2Ubfjje2uBb7AU
 UuRfC5q6W6s9/SxRecL/WV0p+Stte/pmcJRGg/5lGCN3tswix3+j/WFY5CftT2CyqFPm
 XOAQ==
X-Gm-Message-State: AOJu0YyOyQcZsWe8qhTxf48dILWOipaeW0pv4mcJaq9oxfpP/tZTKltl
 96iWib9v7rQn6Ui4dOM2XBAvk1sbSM4HbyTAJT8jgw==
X-Google-Smtp-Source: AGHT+IEthlxM/u4JRpesHRXncrj89CpcRBs21oHMZfSUlKSn7L4l1sxHSo5Lyj8aOqZgrA36z4bJyb0+lNAFBD7nTF0=
X-Received: by 2002:a17:907:2ceb:b0:9ad:8ef8:a7e8 with SMTP id
 hz11-20020a1709072ceb00b009ad8ef8a7e8mr1133664ejc.25.1694529718089; Tue, 12
 Sep 2023 07:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <e6385fc7-0889-ea16-4fc0-337796814636@tls.msk.ru>
 <CAJSP0QUfF64wWQbbAqKpeUWGEOz6jB2ZHkmJhaRXfRDFLpD_kw@mail.gmail.com>
In-Reply-To: <CAJSP0QUfF64wWQbbAqKpeUWGEOz6jB2ZHkmJhaRXfRDFLpD_kw@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 12 Sep 2023 08:41:46 -0600
Message-ID: <CANCZdfptn3UMMpgxSJYb7YFmt8YOxg2tB+y68Jb878vQyQWOGQ@mail.gmail.com>
Subject: Re: cherry-picking something to -stable which might require other
 changes
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>, 
 qemu-stable <qemu-stable@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Bin Meng <bmeng@tinylab.org>, 
 Paul Menzel <pmenzel@molgen.mpg.de>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e8950d06052a71d2"
Received-SPF: none client-ip=2a00:1450:4864:20::633;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x633.google.com
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

--000000000000e8950d06052a71d2
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 12, 2023, 8:01 AM Stefan Hajnoczi <stefanha@gmail.com> wrote:

> When I backport patches into RHEL, the general process I follow is:
> 1. For context conflicts, just adjust the patch to resolve them.
> 2. For real dependencies, backport the dependencies, if possible.
> 3. If backporting the dependencies is not possible, think of a
> downstream-only solution. This should be rare.
>
> People make different backporting decisions (just like structuring
> patch series). It can be a matter of taste.
>

We've done almost exactly the same thing in FreeBSD for the past almost 30
years (with varying degrees of success and nuance, to be true, often
limited by early tools). It's an excellent ideal to shoot for, and we've
had troubles more often than not the further one gets aways from it.

Warner


Stefan
>
>

--000000000000e8950d06052a71d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Sep 12, 2023, 8:01 AM Stefan Hajnoczi &lt;<a h=
ref=3D"mailto:stefanha@gmail.com">stefanha@gmail.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">When I backport patches into RHEL, the gen=
eral process I follow is:<br>
1. For context conflicts, just adjust the patch to resolve them.<br>
2. For real dependencies, backport the dependencies, if possible.<br>
3. If backporting the dependencies is not possible, think of a<br>
downstream-only solution. This should be rare.<br>
<br>
People make different backporting decisions (just like structuring<br>
patch series). It can be a matter of taste.<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">We&#39;ve done almost exactly=C2=
=A0the same thing in FreeBSD for the past almost 30 years (with varying deg=
rees of success and nuance, to be true, often limited by early tools). It&#=
39;s an excellent ideal to shoot for, and we&#39;ve had troubles more often=
 than not the further one gets aways from it.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">Warner</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">
Stefan<br>
<br>
</blockquote></div></div></div>

--000000000000e8950d06052a71d2--


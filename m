Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B745476725A
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 18:48:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPQCr-00035X-SM; Fri, 28 Jul 2023 12:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qPQCn-00034d-Us
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:20:42 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qPQCl-0005F8-BI
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:20:41 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5221c6a2d3dso2978018a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 09:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1690561237; x=1691166037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+RSbA4mXyK12rFwle3H4YPRbgRLBslwKD2gReW+3Y2k=;
 b=qMroxNyvXIhVyIVRki0yJdxwz+YHcEaUjjw6/W8ivbVzZrnBTX4F9/QQK1NVjdI2LA
 gQzzCtStCKHEUX/Gno2KufKbHdqcfK9geGtIy7MLT+pYUv1pWA5MOBpB+2IzY267l6yW
 GFQYW05FPsr2DzRZM3oHJqF3CnT9TM1/aRpIymDC0A3EmciBFWpjp9pqk+5hRFQB3ZvT
 g11vrDlaXA4fSIDD/U6RaMS9UEMFG8DLxJ+vW47ubfFrZyaZEwMu8b5zYOecsx76jyNN
 lpGa74oDxgj/4w59ToqNTRNndFfjzVRxjZfGzQ/g6tj996LJzauRjpEWJ3ejQg5Co84G
 mvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690561237; x=1691166037;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+RSbA4mXyK12rFwle3H4YPRbgRLBslwKD2gReW+3Y2k=;
 b=IN7GKHYJof+7gGbNf1MRV9QDslT/QOya45x2FUAoOv9L+309wt6pkQ1rmisNQuQVIw
 ds9nNutt9VeE/APB5ZYkURb3dibOFXcVEnXdrGflkOy+GwOYXpdzmmUxi6+MxdhPCR+p
 iWExy2BWFNfcsthBvdefz77MdkqjI67h0OVvnz4DIX4ME0wtgrYklgdCGZOcjmWt9hCi
 BoLrtxMaLxwJFmu6QIQwinVWguXTT6MRgMy/9uwpnXfKyrpGa3r6A92u+OW0V2c0Oluz
 p/jZ8Efwo1pDMYHssK+6G6i3iKJuAiN2PFeTGJWsA9k/MacPNGgUZkDfb1lXv17TX27N
 aDow==
X-Gm-Message-State: ABy/qLbaiFBtXzQ3XgwDGr0wL1XfLvirfJe3BfTX0Xcb0uSGnqzrWpnv
 gNvWORBshd6A/v1lR6aaXE6YcKtTyoOJO07akFxS6f29EWvPLcYQBLU=
X-Google-Smtp-Source: APBJJlFm7hL0LuHklUKp4LByz+21DMnml83kgMi1zcMrcXKE+1lRl/fChEz6hWP51bGwtxHvt7N87CrRPURKk5B/77c=
X-Received: by 2002:aa7:d995:0:b0:521:77dd:c8d3 with SMTP id
 u21-20020aa7d995000000b0052177ddc8d3mr2218361eds.27.1690561237557; Fri, 28
 Jul 2023 09:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230728035456.99066-1-imp@bsdimp.com>
 <10ae7649-7712-9884-0604-645cb12068aa@linaro.org>
 <3f2d28ff-8746-b7fb-d2ee-0d8e08403281@linaro.org>
In-Reply-To: <3f2d28ff-8746-b7fb-d2ee-0d8e08403281@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 28 Jul 2023 10:20:26 -0600
Message-ID: <CANCZdfqNppRSpHXojjcVgHfkG678t0EytwSHdjGXthzdKAvO+g@mail.gmail.com>
Subject: Re: [PATCH] bsd-user: Specify host page alignment if none specified
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000093e8606018e764e"
Received-SPF: none client-ip=2a00:1450:4864:20::531;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x531.google.com
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

--000000000000093e8606018e764e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 7:41=E2=80=AFAM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/28/23 06:34, Richard Henderson wrote:
> > On 7/27/23 20:54, Warner Losh wrote:
> >> We're hitting an assert when we pass in alignment =3D=3D 0 since that'=
s not
> >> a power of two. so pass in the ideal page size.
> >>
> >> Signed-off-by: Warner Losh <imp@bsdimp.com>
> >> ---
> >>   bsd-user/mmap.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> >
> >
> > r~
> >
> >>
> >> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> >> index 74ed00b9fe3..e3ce4ab1fc7 100644
> >> --- a/bsd-user/mmap.c
> >> +++ b/bsd-user/mmap.c
> >> @@ -260,7 +260,7 @@ static abi_ulong mmap_find_vma_aligned(abi_ulong
> start, abi_ulong size,
> >>       if (reserved_va) {
> >>           return mmap_find_vma_reserved(start, size,
> >> -            (alignment !=3D 0 ? 1 << alignment : 0));
> >> +            (alignment !=3D 0 ? 1 << alignment : qemu_host_page_size)=
);
>
> Actually, it probably should be MAX(qemu_host_page_size, TARGET_PAGE_SIZE=
).
>
> Does freebsd currently support any hosts with a page size that is not 4k?
> It would have
> been true in the past, certainly, but perhaps they've all been deprecated
> and removed.
>

arm64 supports 64k pages now too... I'll update the patch...

Warner

--000000000000093e8606018e764e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 28, 2023 at 7:41=E2=80=AF=
AM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 7/28/23 06:34, Richard Henderson wrote:<br>
&gt; On 7/27/23 20:54, Warner Losh wrote:<br>
&gt;&gt; We&#39;re hitting an assert when we pass in alignment =3D=3D 0 sin=
ce that&#39;s not<br>
&gt;&gt; a power of two. so pass in the ideal page size.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" t=
arget=3D"_blank">imp@bsdimp.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 bsd-user/mmap.c | 2 +-<br>
&gt;&gt; =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)<br>
&gt; <br>
&gt; Reviewed-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson=
@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
&gt; <br>
&gt; <br>
&gt; r~<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt; diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c<br>
&gt;&gt; index 74ed00b9fe3..e3ce4ab1fc7 100644<br>
&gt;&gt; --- a/bsd-user/mmap.c<br>
&gt;&gt; +++ b/bsd-user/mmap.c<br>
&gt;&gt; @@ -260,7 +260,7 @@ static abi_ulong mmap_find_vma_aligned(abi_ulo=
ng start, abi_ulong size,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (reserved_va) {<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return mmap=
_find_vma_reserved(start, size,<br>
&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (alignment !=3D 0 ? 1 &lt;&lt; alignment : 0));<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 (alignment !=3D 0 ? 1 &lt;&lt; alignment : qemu_host_page_size));<br>
<br>
Actually, it probably should be MAX(qemu_host_page_size, TARGET_PAGE_SIZE).=
<br>
<br>
Does freebsd currently support any hosts with a page size that is not 4k? I=
t would have <br>
been true in the past, certainly, but perhaps they&#39;ve all been deprecat=
ed and removed.<br></blockquote><div><br></div><div>arm64 supports 64k page=
s now too... I&#39;ll update the patch...</div><div><br></div><div>Warner=
=C2=A0</div></div></div>

--000000000000093e8606018e764e--


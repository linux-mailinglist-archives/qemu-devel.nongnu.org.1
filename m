Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E228F775101
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 04:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTZAj-0003YW-7R; Tue, 08 Aug 2023 22:43:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTZAg-0003Y2-M6
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:43:38 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTZAf-0006Qi-9b
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 22:43:38 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5230ac6dbc5so8530124a12.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 19:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1691549015; x=1692153815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oWUcHkE10cO/4ZK06nWwOLoMC85VZnSurKJPM/URX2M=;
 b=kfJT9alWa+2EM3QFw3vYOgQwdK6xhai2ZuIdjeGk1rfw3BR9mOjDa8fxosQTin43Y3
 RgpuJZQzEPM+38Pk0JZMCc29zTL/Q6yMoZL9PEh6FZYltYeRdoXrY+iTCLWE08PWMWaU
 /EZRiamtBD6I66GGp1JqOQbdzXiAp7vTd3QJvkkH+q8nPp+oUGsmZnvMsA4SZYAd6cUl
 KGhesNe3ds/iHjCP2fAvjXcrYV3l/XtXUd+5jaApACmMiinPce6Z29wEbkUCP8r/WQzh
 nu68px0HNHjHiIVbRI2bVKB0MO0v2Z6AwAzMoIGE+CRTsTNlsZr98OOltir+thZqVR4b
 9xHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691549015; x=1692153815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oWUcHkE10cO/4ZK06nWwOLoMC85VZnSurKJPM/URX2M=;
 b=EpA8NPRs8yjgyhgLR5FSDbskoXtfXhVv6jzrcFxMnmQJZil5vBBBn5wcytFFYNwcmy
 iw0lEjeCO1B9xSCnfp5qGwYI007xORSz4wsufYB05m7L63W9eormdqZ5s0qZmsJsv5s5
 jTU5/cN3Oxzi91VyvpYbnu/F79Bo8oadye2Fu3L12cf0KwKXnQJnu2AhgH+N6EdmPoal
 SWM89gVc20RAe72FFSXUjwTLrqRz8j8fFVxVuHQQlNRtdUx3y8y8Zsu5adh2oJ2fN/l4
 D9aGNms7By5z91PfSgoEmDNmeCje828VoVRJopaYPc0YDj8DrsuCO3sjIWl4VNT6hJLX
 Hfhw==
X-Gm-Message-State: AOJu0YzttCUfXrN5ngKhtCtxq2Ch9Ejg+qgI+ORROi7awOnLfCvgaLni
 0XBQuWaM4w/7kDwHjCP2xiY/ErhPgcSY80CU+jYFuWAvO0tK06UlINI=
X-Google-Smtp-Source: AGHT+IGuGKkYzgh4grGlSsETZGK0gPIB86yUv3Ogyh0oYv7xDw245ZeAwm5RbZOBfMkqBziydzNRE9YFb4flne6n1ZM=
X-Received: by 2002:a17:907:75f6:b0:994:539d:f97f with SMTP id
 jz22-20020a17090775f600b00994539df97fmr1037781ejc.37.1691549015331; Tue, 08
 Aug 2023 19:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-7-kariem.taha2.7@gmail.com>
 <05c85989-b7b3-572a-57b5-3e9c68de52fd@linaro.org>
In-Reply-To: <05c85989-b7b3-572a-57b5-3e9c68de52fd@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 8 Aug 2023 20:43:26 -0600
Message-ID: <CANCZdfoEqO4o77zwgO+cniN1-5xXAHv2QysYMmVioEsfx6q6nw@mail.gmail.com>
Subject: Re: [PATCH 06/33] Add struct target_freebsd11_stat to
 bsd-user/syscall_defs
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="0000000000002de821060274722e"
Received-SPF: none client-ip=2a00:1450:4864:20::532;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x532.google.com
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

--0000000000002de821060274722e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 8, 2023 at 3:23=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/7/23 23:07, Karim Taha wrote:
> > +    uint32_t   st_flags;    /* user defined flags for file */
> > +    __uint32_t st_gen;      /* file generation number */
> > +    __int32_t  st_lspare;
>
> Oh, drop the __ types.
>

Agreed. The original from the blitz branch copied from FreeBSD's stat.h
file which
used the __ types to avoid namespace pollution... a constraint we don't
have here.

Warner

--0000000000002de821060274722e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 8, 2023 at 3:23=E2=80=AFP=
M Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ric=
hard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">On 8/7/23 23:07, Karim Taha wrote:<br>
&gt; +=C2=A0 =C2=A0 uint32_t=C2=A0 =C2=A0st_flags;=C2=A0 =C2=A0 /* user def=
ined flags for file */<br>
&gt; +=C2=A0 =C2=A0 __uint32_t st_gen;=C2=A0 =C2=A0 =C2=A0 /* file generati=
on number */<br>
&gt; +=C2=A0 =C2=A0 __int32_t=C2=A0 st_lspare;<br>
<br>
Oh, drop the __ types.<br></blockquote><div><br></div><div>Agreed. The orig=
inal from the blitz branch copied from FreeBSD&#39;s stat.h file which</div=
><div>used the __ types to avoid namespace pollution... a constraint we don=
&#39;t have here.</div><div><br></div><div>Warner <br></div></div></div>

--0000000000002de821060274722e--


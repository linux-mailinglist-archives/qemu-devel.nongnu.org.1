Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4BE78F729
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:32:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtx5-0000ai-Ho; Thu, 31 Aug 2023 22:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qbtx3-0000U7-3W
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:32:01 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qbtx0-0003E1-Sl
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:32:00 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-52a39a1c4d5so1910674a12.3
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1693535516; x=1694140316;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jIXHXxMzQD7uO3+uExuhlXOEOC4qn6XCXwUYC+CauiI=;
 b=AfYCQntE973Vhh0MeKM9cqqdXUSOeKpmR4K3uB4jR3LarWrtPuOQg4Y++eFiuXlIby
 3YpOw7q4q/huJnOJqes/BQ/pVbDkyw01M8T+pdGiGVh/IQddpkt+qpRfblc7ADLwlXHf
 7kxB00i3rza9T4zv5AzPv55gnEeU6JLLbAWRsZLVgf5aP5kC6264exlMciCrmJ4S/WsV
 gqLGarfXOwrWoSCfggZyxSGn3EkXtko0+UFT0GVH8/4IisR6juUgc/j/TGP+97dW9mbC
 +R4qK27DaGAM7DVC+uHETt7kkmTAs/kCzS8fVxIP1u2YG3cQQg266wXSP5t+wA/BNCYe
 EXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535516; x=1694140316;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jIXHXxMzQD7uO3+uExuhlXOEOC4qn6XCXwUYC+CauiI=;
 b=InIXIslf2s3V6fLK3amTE0UGuCj4oSXxYVgmAgVcArqVjemMnGcSutKW3NdegVzeHJ
 s+1LfZeuD0Of0F8JzPwPPEdhRufIxnjCH0KxLktoZ6nbIJwfdGLH+eaRnlH+NEXdB2Na
 +hoo3yeDva3Yz7RzWUgZJ1SOZwBdgSKmEeucwyX5C3jRMdlGLZJNU1YKGWku0GOha0WZ
 4aA6cz+zC9SIxMPxdvzIGwSHVsA0D6FQovpLdTKMUVQI3ghZP4NJwvb9+1Lwds6BvlHR
 0EQe3ZXMA0A5WcqHdS/8TvJ9zUQVS7PfVAMVFqrlsfm0INf3eWUx7uWyK50WDxMGloTX
 XsiA==
X-Gm-Message-State: AOJu0YyeXeHrj3XNsav6OsIhgpNR7Fj2S8/SqyBDuTR+uKhqi4M3ZaFi
 Gko2neBUuwVJE6bwDKyklPZMoIXetsfuTvEe/fhTZXvYXROv5tPV
X-Google-Smtp-Source: AGHT+IETSL1STpt2JBH4iFsTF0/iSjPGNU2TEgJVph+/y94zyiwwQzrSCfgmoKONETjAIwcNC2rGh7Fqchdtn2dCNGk=
X-Received: by 2002:aa7:d407:0:b0:52a:3ee9:a786 with SMTP id
 z7-20020aa7d407000000b0052a3ee9a786mr851471edq.26.1693535516610; Thu, 31 Aug
 2023 19:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230901022331.115247-1-richard.henderson@linaro.org>
 <20230901022331.115247-28-richard.henderson@linaro.org>
In-Reply-To: <20230901022331.115247-28-richard.henderson@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 31 Aug 2023 20:31:47 -0600
Message-ID: <CANCZdfqOmp1mkodcGtdvLPtokbF4waZoybJdROn29J_+fBhbBQ@mail.gmail.com>
Subject: Re: [PATCH v2 27/33] cpu: Remove page_size_init
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, alex.bennee@linaro.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e1e3fd060442f689"
Received-SPF: none client-ip=2a00:1450:4864:20::534;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x534.google.com
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

--000000000000e1e3fd060442f689
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 8:23=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> Move qemu_host_page_{size,mask} and HOST_PAGE_ALIGN into bsd-user.
> It should be removed from bsd-user as well, but defer that cleanup.
>
> Cc: Warner Losh <imp@bsdimp.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  bsd-user/qemu.h           |  7 +++++++
>  include/exec/cpu-common.h |  7 -------
>  include/hw/core/cpu.h     |  2 --
>  accel/tcg/translate-all.c |  1 -
>  bsd-user/main.c           | 12 ++++++++++++
>  cpu.c                     | 13 -------------
>  softmmu/vl.c              |  1 -
>  7 files changed, 19 insertions(+), 24 deletions(-)
>

ACK on the todo... My student is close to submitting the mmap series of his
patches, so I appreciate the 'quick fix' to not disrupt that effort.

Reviewed-by: Warner Losh <imp@bsdimp.com>

--000000000000e1e3fd060442f689
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 31, 2023 at 8:23=E2=80=AF=
PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">Move qemu_host_page_{size,mask} and HOST_PAGE_ALI=
GN into bsd-user.<br>
It should be removed from bsd-user as well, but defer that cleanup.<br>
<br>
Cc: Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp=
@bsdimp.com</a>&gt;<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.henderson@li=
naro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>
---<br>
=C2=A0bsd-user/qemu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 7 +++=
++++<br>
=C2=A0include/exec/cpu-common.h |=C2=A0 7 -------<br>
=C2=A0include/hw/core/cpu.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 --<br>
=C2=A0accel/tcg/translate-all.c |=C2=A0 1 -<br>
=C2=A0bsd-user/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 12 ++++++++=
++++<br>
=C2=A0cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 13 -------------<br>
=C2=A0softmmu/vl.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
1 -<br>
=C2=A07 files changed, 19 insertions(+), 24 deletions(-)<br></blockquote><d=
iv><br></div><div>ACK on the todo... My student is close to submitting the =
mmap series of his</div><div>patches, so I appreciate the &#39;quick fix&#3=
9; to not disrupt that effort.</div><div><br></div><div>Reviewed-by: Warner=
 Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;</div></d=
iv></div>

--000000000000e1e3fd060442f689--


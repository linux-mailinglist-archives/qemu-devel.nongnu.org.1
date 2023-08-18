Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C22BD7802BF
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 02:37:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWnSj-0006Q4-Q2; Thu, 17 Aug 2023 20:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qWnSg-0006Oz-Fj
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 20:35:34 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qWnSc-0005SQ-8Q
 for qemu-devel@nongnu.org; Thu, 17 Aug 2023 20:35:32 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-99c0290f0a8so38153266b.1
 for <qemu-devel@nongnu.org>; Thu, 17 Aug 2023 17:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1692318927; x=1692923727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tiK0SinM1YW0vtKVxdAaRSDSrgBcmsKx6HKozrNO2Ro=;
 b=rFZO75l0sZSQWEeLgRBajy+nrFakjhIRUwQOuoG/szxTmx/9H/i/yUeWTj5+3QBgRY
 D45Z7Xa5RJ0Yq2LakmjGCjVMUcE556pxZ0Xv+mv0OxHif6y3i1z2q98nLmPcE78oLzQ/
 gXipC2dHQnAIH5iweXn+Dgz6jhQBRvxqC/ubZYRZ4O8QZkYvU+BIJmHqmAAhtEviwNNe
 FCAuPyBRTMlUHuQU4FB1YBLSnUapAodDAfahN2h1UzbptNqD261nSjQ/rGnJNhTpkps2
 r+wdcUCeVh4+nrrJNxQwuzpXXe1RTpS+o8a7kl6lgdwvmBeEcuMxBd9/bfvZj0jS3crj
 sTbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318927; x=1692923727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tiK0SinM1YW0vtKVxdAaRSDSrgBcmsKx6HKozrNO2Ro=;
 b=PGAo2OIaqbvncylQG8LCJHfDzcgnU7TVpQN8G1B+jH0AYnYek2rB5z/caKmP49uiPW
 Wpq9EVF36wSY+oXl3WPnI5R4FQYDK7QBb5ojoB95X8XYjHQaAuqbXPCgPUXQnQkFiKDi
 S00AXVYgphHfRK5fFVx8MTXMy5r310g0VEzk7++63lrmInpzdY5STanRuc8w05+EI55D
 cJWRSJNbY8tyDHWYEFFLUgUw6XLbgN5XxHZK4aHWAemraAXaNEY0WKMxeQ9eFeAa1ZRO
 oVjfHCqQhVRcQqkIO5qzTkSvNlHTjgo5BcBebYKE1QaBFVhEybTIogtF/qGDsNLg1fD/
 RSVQ==
X-Gm-Message-State: AOJu0YyyE5NPI6YzyUu+2aTn+bazq1gPiyNO8jkGE8L+0WF9qilNwDpg
 Wqx35r8hWKfGVmVAz4aGWL3/bL74+SVE69iVvOHN7A==
X-Google-Smtp-Source: AGHT+IFX2nt3C/+M1s94oWnyTDeBjZg3q/2e11kVWRkWgm1xmzYqaCPJ38zycEy8oGhVx/NzWUPS+yhmIHeMs4Q4kmI=
X-Received: by 2002:a17:906:4d:b0:994:536c:ab45 with SMTP id
 13-20020a170906004d00b00994536cab45mr730549ejg.50.1692318926714; Thu, 17 Aug
 2023 17:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230816181437.572997-1-richard.henderson@linaro.org>
 <20230816181437.572997-6-richard.henderson@linaro.org>
 <3b8a822c-cdf7-bdae-4cb4-5c66d93479d5@linaro.org>
 <19bd7b77-9add-e418-c0fe-800a90fd8383@linaro.org>
In-Reply-To: <19bd7b77-9add-e418-c0fe-800a90fd8383@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 17 Aug 2023 18:35:15 -0600
Message-ID: <CANCZdfq1c7hQ2=TtL=w7a_jw4dKd+-7LMW9WVS35x7OoZ300Tw@mail.gmail.com>
Subject: Re: [PATCH 5/6] linux-user: Remove ELF_START_MMAP and
 image_info.start_mmap
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, iii@linux.ibm.com, deller@gmx.de
Content-Type: multipart/alternative; boundary="0000000000007949f2060327b4e4"
Received-SPF: none client-ip=2a00:1450:4864:20::630;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x630.google.com
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

--0000000000007949f2060327b4e4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 6:19=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/17/23 02:00, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 16/8/23 20:14, Richard Henderson wrote:
> >> The start_mmap value is write-only.
> >> Remove the field and the defines that populated it.
> >> Logically, this has been replaced by task_unmapped_base.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>   linux-user/qemu.h    |  1 -
> >>   linux-user/elfload.c | 38 --------------------------------------
> >>   2 files changed, 39 deletions(-)
> >
> > Can we squash similar removal in bsd-user?
> > Either that or in a different patch:
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> >
>
> A different patch, for sure.  I don't want trivial patches to interfere
> with the ongoing
> merge process.
>

CC me on the patch. I'll queue it with the other patches that have been
reviewed and act
as conductor to make sure there's no interference with ongoing work.

Warner

--0000000000007949f2060327b4e4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 17, 2023 at 6:19=E2=80=AFPM R=
ichard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">richar=
d.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">On 8/17/23 02:00, Philippe Mathieu-Daud=C3=A9 wrote:<=
br>
&gt; On 16/8/23 20:14, Richard Henderson wrote:<br>
&gt;&gt; The start_mmap value is write-only.<br>
&gt;&gt; Remove the field and the defines that populated it.<br>
&gt;&gt; Logically, this has been replaced by task_unmapped_base.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Richard Henderson &lt;<a href=3D"mailto:richard.hen=
derson@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<b=
r>
&gt;&gt; ---<br>
&gt;&gt; =C2=A0 linux-user/qemu.h=C2=A0=C2=A0=C2=A0 |=C2=A0 1 -<br>
&gt;&gt; =C2=A0 linux-user/elfload.c | 38 ---------------------------------=
-----<br>
&gt;&gt; =C2=A0 2 files changed, 39 deletions(-)<br>
&gt; <br>
&gt; Can we squash similar removal in bsd-user?<br>
&gt; Either that or in a different patch:<br>
&gt; Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@=
linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
&gt; <br>
<br>
A different patch, for sure.=C2=A0 I don&#39;t want trivial patches to inte=
rfere with the ongoing <br>
merge process.<br></blockquote><div><br></div><div>CC me on the patch. I&#3=
9;ll queue it with the other patches that have been reviewed and act</div><=
div>as conductor to make sure there&#39;s no interference with ongoing work=
.</div><div><br></div><div>Warner=C2=A0</div></div></div>

--0000000000007949f2060327b4e4--


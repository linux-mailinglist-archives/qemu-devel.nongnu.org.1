Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1929F766318
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 06:23:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPEkU-0007Tp-F0; Fri, 28 Jul 2023 00:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qPEkR-0007Tf-Iu
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 00:06:40 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qPEkP-0004lj-EL
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 00:06:38 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5217ad95029so2113138a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 21:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1690517195; x=1691121995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OYqwPrOvEJcNhOCzvVu6MlUuXOiESkVjn8UsnlqvapA=;
 b=w79XQlU2YuJQjh6UsjTe5F5hijXwnFRPifhg7bcJSxdtdnBX+26xNjXiG9IFUzLjKm
 LyxYSvqIEym3dKlfTuM92wvcqsxB++UPtxEN/jKwX0s5RBMc0bjzjdSic6XdG3NO0SNL
 WeJXDrZhxC7wYzqzufKD14vmxiqdMyp+y48dXoFd7kJ+jXR9uoN2oa3PxHC/fGNETxom
 pkLFIMNIfHqyXbn9fUGXanYMlRyekHET2UV5qnvFDf+F9eVxxsvQEPHjo0DkLzteHe5C
 80QB27qslmwX9loWi1indi1ZihJRtWsp+fl6EkoyJVuGpRmsScJp7zu6xggUfrfojMe8
 ag3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690517195; x=1691121995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OYqwPrOvEJcNhOCzvVu6MlUuXOiESkVjn8UsnlqvapA=;
 b=JoBxfMcvYDQ6kxtsDu07N//zyJ9Tmeg4abP9KBLRI9ZuuPc8KG7IGG9cRqO9i4o9dm
 fdx7PnMoKnQBs9wQuRgy9dXLreyA3/YAJg2FgY1e6BioWhWpcQxC2N9Hg4UHDXZ8aJLG
 /7i0vAHjePMPYt3CLhUxFx2ASEo9SlXJHinE4fIAq/1yN0Zj1eNYSANuIsMAN6lqdPGv
 8ujDlA4RDgzimhuXmj37kikgZGFLocW1TsJi3erifmPjJAtvgOS3adJykxDHTE3D5RGI
 2+18hH6pzpDQyTvf2zINShtWX0S3OCiuPYb8fSvtGhve3zr3SmLsdu1zZuJMT9Lb+oNG
 6ssQ==
X-Gm-Message-State: ABy/qLZ3H3jAUOHW0GUQU7Td9vu7OZiD/0X+drI5003v8vqLFshrMZDH
 OsNPX+TIEXYeipt/tKDO7R2LBxVi9WrlPbchJLLn35ORGEtx5NYeSfs=
X-Google-Smtp-Source: APBJJlH6/bPKmrf2iPHqLLN2ROdzMZiFXp6NFoRhDM4XkYrZ+lLvN5cMleY9sOHMNn3wCUpu20erZ+qQLVDdhXSrO8A=
X-Received: by 2002:a05:6402:38d:b0:522:274c:376c with SMTP id
 o13-20020a056402038d00b00522274c376cmr743271edv.38.1690517195405; Thu, 27 Jul
 2023 21:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230727161148.444988-1-richard.henderson@linaro.org>
 <CANCZdfrLKgVJhXqZ8nJdyoKOsLKscFPYSsZ=w6mSbusn0aX5Ww@mail.gmail.com>
 <8faebb0b-b70b-101f-2f4a-9e434cb765f1@linaro.org>
In-Reply-To: <8faebb0b-b70b-101f-2f4a-9e434cb765f1@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 27 Jul 2023 22:06:24 -0600
Message-ID: <CANCZdfrxyYnoaTztRs9nMXajT284GvZfr5VittNSP2OPHUp7LQ@mail.gmail.com>
Subject: Re: [PATCH] bsd-user: Properly allocate guest virtual address space
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000eb50fe06018434a2"
Received-SPF: none client-ip=2a00:1450:4864:20::535;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x535.google.com
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

--000000000000eb50fe06018434a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 6:31=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/27/23 17:09, Warner Losh wrote:
> > Yes. FreeBSD's bsd-user binary will only run on 64-bit hosts. The proje=
ct
> > has started phasing out support for 32-bit hosts, and the role of
> bsd-user
> > (package builder tool) is such that 32-bit hosts don't make sense.
>
> Ok, fine.
>
> > I've tested this out, and it works for me. Any chance we can get this
> into
> > 8.1 as a bug fix for the last minute breakage of bsd-user (without this
> and
> > another patch, the static hello world that used to work broke). I can
> send
> > that second patch out for review. I can queue this fix in the mean time
> for
> > whenever the tree opens up.
>
> Yes. I can queue this to tcg-next, which will have another round before
> rc2.
> Send the alignment patch tomorrow and I can include that too.
>

Great!  I've just sent the patch. Thanks! With it, I can now get 'hello
world'
working again...  This should also give my GSoC student a good place to
merge
against to finish off his mmap and other patches.

Warner

--000000000000eb50fe06018434a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jul 27, 2023 at 6:31=E2=80=AF=
PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 7/27/23 17:09, Warner Losh wrote:<br>
&gt; Yes. FreeBSD&#39;s bsd-user binary will only run on 64-bit hosts. The =
project<br>
&gt; has started phasing out support for 32-bit hosts, and the role of bsd-=
user<br>
&gt; (package builder tool) is such that 32-bit hosts don&#39;t make sense.=
<br>
<br>
Ok, fine.<br>
<br>
&gt; I&#39;ve tested this out, and it works for me. Any chance we can get t=
his into<br>
&gt; 8.1 as a bug fix for the last minute breakage of bsd-user (without thi=
s and<br>
&gt; another patch, the static hello world that used to work broke). I can =
send<br>
&gt; that second patch out for review. I can queue this fix in the mean tim=
e for<br>
&gt; whenever the tree opens up.<br>
<br>
Yes. I can queue this to tcg-next, which will have another round before rc2=
.<br>
Send the alignment patch tomorrow and I can include that too.<br></blockquo=
te><div><br></div><div>Great!=C2=A0 I&#39;ve just sent the patch. Thanks! W=
ith it, I can now get &#39;hello world&#39;</div><div>working again...=C2=
=A0 This should also give my GSoC student a good place to merge</div><div>a=
gainst to finish off his mmap and other patches.<br></div><div><br></div><d=
iv>Warner<br></div></div></div>

--000000000000eb50fe06018434a2--


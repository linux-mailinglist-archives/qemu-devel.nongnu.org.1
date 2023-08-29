Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B53F578C8A5
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 17:33:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb0hq-00081p-2z; Tue, 29 Aug 2023 11:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb0hl-00081d-Ik
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:32:35 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb0hi-0007JU-Pe
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 11:32:33 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-52a1ce529fdso6045422a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 08:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693323148; x=1693927948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iT9utkjxF4q6o661MYhqizcItFn94HoqldPBeYHMltI=;
 b=1wZdFTrFvkjyR5/VZTF+cv8+oVCf1+zBNBh9WlHVp/3KTXDJHGe4yGTTffs+taesgz
 1RzyqnE15swD26kYoPBLVie3bLjVl23Qs1uR6s2GdFE/iQrZi2m7Z7Dm+4hcHasLgHHF
 evOtNneh7dlsQqyaAtzpwzM2y+IUJjYB3Kn2UQv2nEXjyti/7KLgpcWsLtLQP4//ykEn
 tFGMYQnHgfyzAJWNV05OTPCnO9Yu5JNO2V2A9YIxVFVAJIdeM64UUY6h0qiDItN3MMtS
 p6J9B1SdzSnqujYl9GTWqojl4XwmWYqICfKXXOlKqJkcZeDgYZAx0rEjRgPevW23hZ07
 iA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693323148; x=1693927948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iT9utkjxF4q6o661MYhqizcItFn94HoqldPBeYHMltI=;
 b=O59cL0AK7Tp9Wes1Mzh0TVf1Q93GpnxfZWF2DGUqZ8D+NjHF0dhq6YQlfFzWFzzNpU
 KjRcufHrduiSTxo7dzNGwoOnzlr5LUw9wfpkp1nb7efcD9MT9UH3XrF4hhyoLjGmnk7g
 YwO9D7sC7TIVtwJiptufqFQvUz8luOktiZJwv40GDWlHjWxIw2sR0G/s4fa9QqKKojZY
 0jtw3Fgxs+u32lWfAsD+4eNdhp3ni1nti9At8IERxhPy0lnrf/KIKnFmNJidnizhsG87
 wTXUrrLPwPM6l0dq6JQ/DAUlj/lcGE5qdLMM+spOwEdlgFeW3IvASWoY9Xni9Y8U+bYB
 5Ceg==
X-Gm-Message-State: AOJu0Yy8+7/Z/HyVTKYGCWehrb5oyw53UH7Oz/PMvY0EYuM2LO8TXRMn
 qzr9Aabj7UJJo7RI8L+ndk5rqm+AOaNYJZLXh01eSA==
X-Google-Smtp-Source: AGHT+IGJuDPuIe2oqWy4Wu6Jdv7hMNfz8zTOdWg7Aosiub2vi2i3QNM9dqZrcba/LWYhW5jNuV/U+e0InxxKKqfCCTI=
X-Received: by 2002:a17:907:2709:b0:9a1:eb67:c0ce with SMTP id
 w9-20020a170907270900b009a1eb67c0cemr14010128ejk.50.1693323148304; Tue, 29
 Aug 2023 08:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230828233821.43074-1-imp@bsdimp.com>
 <20230829135009.GA179554@fedora>
In-Reply-To: <20230829135009.GA179554@fedora>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 29 Aug 2023 09:32:16 -0600
Message-ID: <CANCZdfr-QvabpjzmUtkjXkzV6Q+QGSzk3w0RQqi9n6QCdgPZqQ@mail.gmail.com>
Subject: Re: [PULL 00/36] 2023q3 bsd user patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Reinoud Zandijk <reinoud@netbsd.org>, 
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000beb78906041184aa"
Received-SPF: none client-ip=2a00:1450:4864:20::529;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x529.google.com
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

--000000000000beb78906041184aa
Content-Type: text/plain; charset="UTF-8"

On Tue, Aug 29, 2023, 7:50 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:

> Applied, thanks. In the future, please invoke git-request-pull(1) with
> the public HTTPS repo URL to make it easier for anyone to fetch the
> changes:
>
> > are available in the Git repository at:
> >
> >  git@gitlab.com:bsdimp/qemu.git tags/2023q3-bsd-user-pull-request
>    ^^^^^^^^^^^^^^
>

Will do. Sorry about that...

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for any
> user-visible changes.
>

Once the mmap branch lands... I'll update to include hello world working...
soon I hope...

Warner

Thanks!
>

--000000000000beb78906041184aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Tue, Aug 29, 2023, 7:50 AM Stefan Hajnoczi &lt;<a h=
ref=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a>&gt; wrote:<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">Applied, thanks. In the future, please i=
nvoke git-request-pull(1) with<br>
the public HTTPS repo URL to make it easier for anyone to fetch the<br>
changes:<br>
<br>
&gt; are available in the Git repository at:<br>
&gt;<br>
&gt;=C2=A0 git@gitlab.com:bsdimp/qemu.git tags/2023q3-bsd-user-pull-request=
<br>
=C2=A0 =C2=A0^^^^^^^^^^^^^^<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Will do. Sorry about that...=C2=A0</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
Please update the changelog at <a href=3D"https://wiki.qemu.org/ChangeLog/8=
.2" rel=3D"noreferrer noreferrer" target=3D"_blank">https://wiki.qemu.org/C=
hangeLog/8.2</a> for any user-visible changes.<br></blockquote></div></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto">Once the mmap branch lands...=
 I&#39;ll update to include hello world working... soon I hope...</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Warner</div><div dir=3D"auto"><br=
></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
Thanks!<br>
</blockquote></div></div></div>

--000000000000beb78906041184aa--


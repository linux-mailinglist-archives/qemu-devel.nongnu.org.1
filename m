Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BD478D019
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:14:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mr-0000h0-Ah; Tue, 29 Aug 2023 19:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb6rj-0004pT-Ku
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:07:15 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qb6rg-00051P-Pq
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:07:15 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso635982566b.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693346830; x=1693951630;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YbVxZPhvJAAn5rSWVnOB4JqhAlt2LGL7KQR9yMgftOg=;
 b=ys3TSm6824TL9IUs/MYTdNxJ9pg22gjwmBLv8WQb5uD0nfO6D4vU2JMV7ni+8UWtDk
 BDhaU4C4QpTBaw2MJSbPS3ZfYsY6YXMsYkvuiqZ9RJEFpm6WIWQNuKT9LA+X2KwwUeT0
 6Rl9wjKZE6jSsvv5Q7K/pQTHEgd2liPSp4T/Z/LmrR1xYppaLU6Qf0REh2NtmYKLKZeI
 /w9+4AfKaMICgCuFZ4o9gVJ0HYs+/ioAuuZkia03Gkvty/lGK1XoimYHiLP5AdRuwCER
 gnUJIvHn2RgWqqASOwku8g7/sYx8gsersHkAhrSGNiKN7Rk9bAmPz8rjbSBZX9g3IF6D
 1qfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346830; x=1693951630;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YbVxZPhvJAAn5rSWVnOB4JqhAlt2LGL7KQR9yMgftOg=;
 b=SmgzOczc1WVxwUvrGFy5z3TAWn4nIF7raNo6jdzTXQrZe3xzRNPymqkNqUZ6CzZ0BO
 KDE4FT/WVqso0wnJR02llIe073BUSMq18x7cVy3yuZoza2OgLLY1VvOOY7I5KxLDLRf9
 BHRJ+h8a3mRIXqwt3RYGaDyv3qtB4rtB8TqWM3Wj27bmugqxf3zuRKGmePwfJyqwM639
 S4ULIH7vKhkbR5pLGJfXZlkJhafmn29zVnUy3X56VQPgHwBQnPOhhgChVK9Bl3vite4U
 G3U91pgutgAk0tNpzk55C/P4XFG3XqM/MM06PGOanW40OJnBRj8+7RdnqfGM89PlSGP7
 89uA==
X-Gm-Message-State: AOJu0YyMbXWDnyTrdincC7y/rpWoqJY1H8NW7qpnCu0g6RfCkv7nmU+U
 D1WNiUGgh7Vt/TyJjFGVCTk682ZY1av5hkLxcmD95w==
X-Google-Smtp-Source: AGHT+IE7HZenmLsJr+rdc62lAV1FoQnZVlXHXGAxRuGVx2KlRR439l50QgX7hmrvn4Xwl2HiSZFjnye3chH+aAt7qBk=
X-Received: by 2002:a17:906:738d:b0:9a5:9f3c:9615 with SMTP id
 f13-20020a170906738d00b009a59f3c9615mr189036ejl.63.1693346829814; Tue, 29 Aug
 2023 15:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-33-kariem.taha2.7@gmail.com>
 <02510730-72e8-9b0e-483c-048c7301328f@linaro.org>
 <CANCZdfoKOotS+S01bFbSXYFrqwOaFYf6xb_aAOR5eq13jYeKmg@mail.gmail.com>
 <f63aeecc-00f7-850b-c02c-bf2a2246f780@linaro.org>
In-Reply-To: <f63aeecc-00f7-850b-c02c-bf2a2246f780@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 29 Aug 2023 16:06:58 -0600
Message-ID: <CANCZdfq3D-67ddnBcgm7ni3d08ZnHnZUce+PGmn0YFcotkVCng@mail.gmail.com>
Subject: Re: [PATCH 32/32] bsd-user: Implement pdfork(2) system call.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000045debf0604170855"
Received-SPF: none client-ip=2a00:1450:4864:20::636;
 envelope-from=wlosh@bsdimp.com; helo=mail-ej1-x636.google.com
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

--00000000000045debf0604170855
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 3:53=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/29/23 14:27, Warner Losh wrote:
> >      > +    if (put_user_s32(fd, target_fdp)) {
> >      > +        return -TARGET_EFAULT;
> >      > +    }
> >
> >     I *think* this copy belongs in the parent?
> >
> >
> > I think that it's copied out in both cases. For normal fork, this would
> > be 0 for the pid. However, it appears to return the same FD to both
> > the parent and child (see your next comment), so it should be in both
> > paths. And even if it returned something different for parent and child
> > (which seems unlikely given how the code is setup), we want to return
> > the fd each one sees. So either way, I think this code is correct.
> >
> >     It's really hard to follow the path of new
> >     process creation within the freebsd kernel.
> >
> >
> > Agreed.
>
> I think that the child never returns from do_fork.  The child pid =3D=3D =
0
> happens as part of
> do_fork or vm_forkproc or somesuch, but the new process definitely begins
> life at fork_return.
>

I confused the 'returns twice' behavior in userland with the gymnastics the
kernel does
on creating a new process (where things don't return twice). Having looked
at that code,
I'm sure you are right now and it should only be set in the parent. I don't
see where it is
set in the fork_return path. For normal fork, the return value register is
cleared, as is the
carry bit, used to signal errors from system calls on FreeBSD. And having
asked someone
whose more of an expert, he confirms it is not set in the child.

Therefore only the parent passes returns from fork1 to set *fdp.
>

I agree. We should move that code to the parent branch.

Warner


>
> r~
>

--00000000000045debf0604170855
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 29, 2023 at 3:53=E2=80=AF=
PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 8/29/23 14:27, Warner Losh wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 if (put_user_s32(fd, target_fd=
p)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -TARGET_E=
FAULT;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 }<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I *think* this copy belongs in the parent?<br>
&gt; <br>
&gt; <br>
&gt; I think that it&#39;s copied out in both cases. For normal fork, this =
would<br>
&gt; be 0 for the pid. However, it appears to return the same FD to both<br=
>
&gt; the parent and child (see your next comment), so it should be in both<=
br>
&gt; paths. And even if it returned something different for parent and chil=
d<br>
&gt; (which seems unlikely given how the code is setup), we want to return<=
br>
&gt; the fd each one sees. So either way, I think this code is correct.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0It&#39;s really hard to follow the path of new<br>
&gt;=C2=A0 =C2=A0 =C2=A0process creation within the freebsd kernel.<br>
&gt; <br>
&gt; <br>
&gt; Agreed.<br>
<br>
I think that the child never returns from do_fork.=C2=A0 The child pid =3D=
=3D 0 happens as part of <br>
do_fork or vm_forkproc or somesuch, but the new process definitely begins l=
ife at fork_return.<br></blockquote><div><br></div><div>I confused the &#39=
;returns twice&#39; behavior in userland with the gymnastics the kernel doe=
s</div><div>on creating a new process (where things don&#39;t return twice)=
. Having looked at that code,</div><div>I&#39;m sure you are right now and =
it should only be set in the parent. I don&#39;t see where it is</div><div>=
set in the fork_return path. For normal fork, the return value register is =
cleared, as is the</div><div>carry bit, used to signal errors from system c=
alls on FreeBSD. And having asked someone</div><div>whose more of an expert=
, he confirms it is not set in the child.</div><div><br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">
Therefore only the parent passes returns from fork1 to set *fdp.<br></block=
quote><div><br></div><div>I agree. We should move that code to the parent b=
ranch.</div><div><br></div><div>Warner</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">
<br>
r~<br>
</blockquote></div></div>

--00000000000045debf0604170855--


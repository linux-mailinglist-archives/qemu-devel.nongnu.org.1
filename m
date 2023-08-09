Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0FD7775229
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 07:07:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTbOk-0006zD-JG; Wed, 09 Aug 2023 01:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTbOe-0006yr-Jd
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 01:06:12 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1qTbOb-0000xq-01
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 01:06:12 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-522382c4840so9034344a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 22:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1691557566; x=1692162366;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/sKgl1c3UZ+jNQufFALCwfgMrJGTqt3EP8kTL+4Hu4s=;
 b=fgnSKWfyJc4xsIZTKxqyLd7TpJVgm7lIRColIl4+7kBZo4jMZwDYc2092y3ING4McH
 yx3PQmmVVsLbuNwXLxqGStgzJD30UsxHrRCUv4fJRfmHS7ctWNo9Y9PfIP76FBs5/hXW
 PltXU2Q0v5mbyxZ66Z6tlARgMz2283lX6ULAP2BJDOAMpx10Hnsouc/OTv1ce1kVpeWz
 wc3cv7N1ySrHh0QecZevbi4GxkcPHPNwKMn+2zckl2N2hali+m1R5hJS6j3STMR5RF9u
 tfONYv/tD6QVpsEHOB6BPA3HqpkWz+Ao72wZ8CdPgiEza8xTm5yyZZcvEJ6xquamHyxr
 bYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691557566; x=1692162366;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/sKgl1c3UZ+jNQufFALCwfgMrJGTqt3EP8kTL+4Hu4s=;
 b=VSXfMh0Z1EspbaW8+BwCtEX+1Lc4CO6oyU1t15GqeKZZiROXxnNzE0TUMmyjiHy8Df
 6gNDWun4Rtfy3KkUqeOppWNnGWRRHXO9oFaGqpulKbNWL80E9pU59PYNDTLu+yq413em
 gDAjGdD7YtAssJEjXzVi4IhO4n9OVcK/RJWQA3HQJHc1ZAVG+ihQw1WtJaL6vx3kQrZV
 kIKvdzevCeImMP5sPrynaJGTTW/waTPjqWhfgfxerIuO+iRFv4phqxjEgNbCnL5kPmOz
 KYNSMSm/QoRns3+efGs903t1FDUb7MIXsej4uB52LXWl/3NCIr2kUVRN3Zfh3q4+edwS
 63RQ==
X-Gm-Message-State: AOJu0Yy9Q/I0OKinxqTTPiyiV8M7LqqbuRWfxVUesqfsCmSl+ZubwZjP
 FX20Ph+uNfkKWpzqZBbVfh3ZNApl+ruGf+Ylr4H/8Q==
X-Google-Smtp-Source: AGHT+IGlhNzxabr5J2hDAXJ9TyZMRGBGCLyn/0Nk9faPHYFNmDhoOzxP1kBnBXvAp6VuBFAvbsnb9PO7rKYxPvCXoCI=
X-Received: by 2002:a17:906:1090:b0:99b:ea8f:9003 with SMTP id
 u16-20020a170906109000b0099bea8f9003mr1448526eju.50.1691557566047; Tue, 08
 Aug 2023 22:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-9-kariem.taha2.7@gmail.com>
 <14d3fa60-0c91-66b7-7887-7854a6a5125a@linaro.org>
 <CANCZdfokHaz0PiLyesK9abDB6CGWzYBhtN=MRhY=JJo1x_DKFw@mail.gmail.com>
 <b8651c48-b8bf-e7ec-564d-1077d9e58cfb@linaro.org>
 <CANCZdfpwQAPLYxsf18RPyr1GDz6h1uT9MNLuhADG-dT0B7HOFw@mail.gmail.com>
In-Reply-To: <CANCZdfpwQAPLYxsf18RPyr1GDz6h1uT9MNLuhADG-dT0B7HOFw@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 8 Aug 2023 23:05:56 -0600
Message-ID: <CANCZdfpNDOM_PQBPXSdSnuJ-q96t=Yr_Rqgbss8H0e2mfFz=Cg@mail.gmail.com>
Subject: Re: [PATCH 08/33] Add structs target_freebsd11_nstat and
 target_freebsd11_statfs to bsd-user/syscall_defs.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org, 
 Stacey Son <sson@freebsd.org>
Content-Type: multipart/alternative; boundary="000000000000d7775b0602766f6b"
Received-SPF: none client-ip=2a00:1450:4864:20::533;
 envelope-from=wlosh@bsdimp.com; helo=mail-ed1-x533.google.com
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

--000000000000d7775b0602766f6b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 8, 2023 at 10:41=E2=80=AFPM Warner Losh <imp@bsdimp.com> wrote:

>
>
> On Tue, Aug 8, 2023 at 9:12=E2=80=AFPM Richard Henderson <
> richard.henderson@linaro.org> wrote:
>
>> On 8/8/23 19:51, Warner Losh wrote:
>> >      > +    /* __int32_t  st_lspare; */
>> >
>> >     Why commented out?
>> >
>> >
>> > I believe that the element was a padding one ....
>> >
>> >      > +    struct target_freebsd_timespec st_birthtim; /* time of fil=
e
>> creation */
>> >
>> >     Does that not place st_birthtim at the wrong place?
>> >
>> >
>> > So this winds up in the right place because there's a hole...
>> >
>> > However, having said that, I don't think it should be commented out.
>> It's not
>> > in the bsd-user branch. And the state of the upstream code is such tha=
t
>> we can't
>> > run full tests easily on the system calls, so we're making sure they
>> basically
>> > work, but will run the full regression test once some other changes ar=
e
>> made
>> > to allow shared libraries to work (many of the calls in this patch are
>> needed
>> > to make 'hello world' work).
>>
>> I think there is not a hole, because the struct is __packed.
>>
>> (Also, QEMU_PACKED vs __packed?)
>
>
> There's a nstat that's an older stat w/o this field. I'm not entirely sur=
e
> __packed should
> be on either one of these, honestly. nstat is quite old, and I'm not at
> all sure what's up
> with it. I think it dates from a time when there was only i386 and then w=
e
> expanded to
> alpha and needed to 'fix' this interface... Not sure why it got the
> freebsd11_ prefix, so
> I'll have to chase those details down to see if this is an extra cut and
> paste or what.
> That may take a little bit to chase down in the logs and in people's
> memory. I think
> that's the back story. Normally, nstat is only defined in the kernel, and
> this is a binary
> interface from ages ago that we likely don't need to implement, but I nee=
d
> to confirm
> that, and make sure rust or go don't have some weird, misguided mistake..=
.
>
> But nstat and stat are supposed to be the same, except nstat omits
> st_spare, so that's
> why it's commented out. stat's supposed to be carefully laid out so packe=
d
> or not
> doesn't matter. But testing that would take a little bit as well.
>

OK. Back in 1998, John Dyson added nstat and friends:
commit 1f5621728039a2009fc163d345508d0ee9fae2e9
Author: John Dyson <dyson@FreeBSD.org>
Date:   Mon May 11 03:55:28 1998 +0000

    Fix the futimes/undelete/utrace conflict with other BSD's.  Note that
    the only common  usage of utrace (the possible problem with this
    commit) is with malloc, so this should be a real problem.  Add
    the various NetBSD syscalls that allow full emulation of their
    development environment.

such emulation hasn't worked since the ELF cut over in FreeSBD 3.2
in 1999,if it even did before that (there's some code to implement these,
but
it's not at all clear to me it ever worked)... This was all preserved when
FreeBSD 11 converted to 64-bit inodes.

So I guess we should preserve it, but I still need to find out the layout
of nstat vs stat on different platforms (though the only systems we ran
on at the time were i386, so after grubbing around with git blame,
I completely retract my 'it was related to alpha' comments: they were
completely wrong). But even so, I guess it was only ever used in
life fire with a.out to run old netbsd a.out files from 25 years ago and
it's relevance is zero since nobody has used it since then and all
maintenance since then in FreeBSD has been basically useless.

I may try to do a regression build of rust w/o it to see if it's used there
or not...

So today I learned...

Warner

--000000000000d7775b0602766f6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 8, 2023 at 10:41=E2=80=AF=
PM Warner Losh &lt;<a href=3D"mailto:imp@bsdimp.com">imp@bsdimp.com</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Aug 8, 2023 at 9:12=E2=80=AFPM Richar=
d Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org" target=3D"_=
blank">richard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On 8/8/23 19:51, Warner Losh wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 /* __int32_t=C2=A0 st_lspare; =
*/<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Why commented out?<br>
&gt; <br>
&gt; <br>
&gt; I believe that the element was a padding one ....<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; +=C2=A0 =C2=A0 struct target_freebsd_timespec=
 st_birthtim; /* time of file creation */<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Does that not place st_birthtim at the wrong place?=
<br>
&gt; <br>
&gt; <br>
&gt; So this winds up in the right place because there&#39;s a hole...<br>
&gt; <br>
&gt; However, having said that, I don&#39;t think it should be commented ou=
t. It&#39;s not<br>
&gt; in the bsd-user branch. And the state of the upstream code is such tha=
t we can&#39;t<br>
&gt; run full tests easily on the system calls, so we&#39;re making sure th=
ey basically<br>
&gt; work, but will run the full regression test once some other changes ar=
e made<br>
&gt; to allow shared libraries to work (many of the calls in this patch are=
 needed<br>
&gt; to make &#39;hello world&#39; work).<br>
<br>
I think there is not a hole, because the struct is __packed.<br>
<br>
(Also, QEMU_PACKED vs __packed?)</blockquote><div><br></div><div>There&#39;=
s a nstat that&#39;s an older stat w/o this field. I&#39;m not entirely sur=
e __packed should</div><div>be on either one of these, honestly. nstat is q=
uite old, and I&#39;m not at all sure what&#39;s up</div><div>with it. I th=
ink it dates from a time when there was only i386 and then we expanded to</=
div><div>alpha and needed to &#39;fix&#39; this interface... Not sure why i=
t got the freebsd11_ prefix, so</div><div>I&#39;ll have to chase those deta=
ils down to see if this is an extra cut and paste or what.</div><div>That m=
ay take a little bit to chase down in the logs and in people&#39;s memory. =
I think</div><div>that&#39;s the back story. Normally, nstat is only define=
d in the kernel, and this is a binary</div><div>interface from ages ago tha=
t we likely don&#39;t need to implement, but I need to confirm</div><div>th=
at, and make sure rust or go don&#39;t have some weird, misguided mistake..=
.<br></div><div><br></div><div>But nstat and stat are supposed to be the sa=
me, except nstat omits st_spare, so that&#39;s</div><div>why it&#39;s comme=
nted out. stat&#39;s supposed to be carefully laid out so packed or not</di=
v><div>doesn&#39;t matter. But testing that would take a little bit as well=
.<br></div></div></div></blockquote><div><br></div><div>OK. Back in 1998, J=
ohn Dyson added nstat and friends:</div><div>commit 1f5621728039a2009fc163d=
345508d0ee9fae2e9<br>Author: John Dyson &lt;dyson@FreeBSD.org&gt;<br>Date: =
=C2=A0 Mon May 11 03:55:28 1998 +0000<br><br>=C2=A0 =C2=A0 Fix the futimes/=
undelete/utrace conflict with other BSD&#39;s.=C2=A0 Note that<br>=C2=A0 =
=C2=A0 the only common =C2=A0usage of utrace (the possible problem with thi=
s<br>=C2=A0 =C2=A0 commit) is with malloc, so this should be a real problem=
.=C2=A0 Add<br>=C2=A0 =C2=A0 the various NetBSD syscalls that allow full em=
ulation of their<br>=C2=A0 =C2=A0 development environment.<br></div><div>=
=C2=A0</div><div>such emulation hasn&#39;t worked since the ELF cut over in=
 FreeSBD 3.2</div><div>in 1999,if it even did before that (there&#39;s some=
 code to implement these, but</div><div>it&#39;s not at all clear to me it =
ever worked)... This was all preserved when</div><div>FreeBSD 11 converted =
to 64-bit inodes.</div><div><br></div><div>So I guess we should preserve it=
, but I still need to find out the layout</div><div>of nstat vs stat on dif=
ferent platforms (though the only systems we ran</div><div>on at the time w=
ere i386, so after grubbing around with git blame,</div><div>I completely r=
etract my &#39;it was related to alpha&#39; comments: they were</div><div>c=
ompletely wrong). But even so, I guess it was only ever used in</div><div>l=
ife fire with a.out to run old netbsd a.out files from 25 years ago and</di=
v><div>it&#39;s relevance is zero since nobody has used it since then and a=
ll</div><div>maintenance since then in FreeBSD has been basically useless.<=
/div><div><br></div><div>I may try to do a regression build of rust w/o it =
to see if it&#39;s used there</div><div>or not...</div><div><br></div><div>=
So today I learned...<br></div><div><br></div><div>Warner<br></div></div></=
div>

--000000000000d7775b0602766f6b--


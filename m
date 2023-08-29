Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C75578C1C4
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 11:54:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qavP3-0000lo-T4; Tue, 29 Aug 2023 05:52:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qavOz-0000lV-E4
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 05:52:49 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qavOs-0008Pk-Ik
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 05:52:45 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51a52a7d859so10558034a12.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 02:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693302760; x=1693907560; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q5I1qkKNeXVt7TErrMs1FKHQ3bBUNUnFS/HiPK8VwA8=;
 b=udAZ9rUD34kk8T6o8dKvRe8TjhYjXxCq8vfPFDwURm9YxcIri67LF4ooh9SIZteCiK
 jP9IpZhxOzD2s4xB870RmwroRdgFWJf+/IwX1i57FpIYqFDJfZvpSErVEviqp3vAWYLy
 k0Z9e56zKrX2kIbEKfq06x6KV0Pf0CYRpFIdw3gFeK/E8Kw6TKbue07X6uOAmQLhQKPO
 MkTtKMPnj7lnN2pd5W1r6cYyLlJf3aKin0WZE8nnustWDGYc/trqAswdDi6u2CC0Utyn
 WWfrVqILEM4sUVux3AR8WC9e2RNtDvAh8ZASp3eR8sVHr/vNdLNmOK/xaHmhehNG4d7v
 sSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693302760; x=1693907560;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q5I1qkKNeXVt7TErrMs1FKHQ3bBUNUnFS/HiPK8VwA8=;
 b=c03mAJZftTtZdV10eB/9UlmPm41OUQKyyMnFY9tWzz7JCRkcmL3ibD7CEGCynH4eH5
 xIRvc+7jJ/svNpWRLkNQPiISlPd7JcXy6tqUBI/DVU0np48J+NQSboJtRdCRrV1aVoYk
 XU8k0UmQOjj28dvtD2aO7OdDPKNiS/8P8iwl3uzN15+U833nhfY+A+vW/eatOwemXWuL
 UTSd1QMlkOnKv6FHNGEXpdyA6XzStzgYo9izEUBuDbBgI1sx8l5DR1NTO3qwVzGHEq6Q
 rYLeY9aAZqkGDZ/A5wsrBh//u0mPfJDI9HR5gCREn1oMPcX/DIkQsUCS6udZiwzxZzwY
 4AyQ==
X-Gm-Message-State: AOJu0Yyq7gPuhdmRIPBr47PvKiQQ9xnz0SUGDK7boNy2BMCjSSBSlS4K
 /dZzqMspAJVbG6G0BdudcqM0WpKtfyswZM/sopFCvw==
X-Google-Smtp-Source: AGHT+IHyCficAVBKXWF5yrSEJC7Tyb+8wSeRmsTP+holBlYYLWnmpl1isrFoo8NwBbGSQIzevDOlKLIHrYSCpFQZHnw=
X-Received: by 2002:a17:907:a089:b0:9a5:c38d:6b75 with SMTP id
 hu9-20020a170907a08900b009a5c38d6b75mr2308749ejc.15.1693302760263; Tue, 29
 Aug 2023 02:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230824165740.2653919-1-peter.maydell@linaro.org>
 <20230824171512.GA1690425@fedora>
In-Reply-To: <20230824171512.GA1690425@fedora>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 10:52:29 +0100
Message-ID: <CAFEAcA9TvRQsdTzvTO6asWOyYiLheDwngGY3ohVyRhCVzAMJ1Q@mail.gmail.com>
Subject: Re: [PATCH] hw/block/dataplane/virtio-block: Avoid dynamic stack
 allocation
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000085e4f106040cc5ed"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--00000000000085e4f106040cc5ed
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Aug 2023 at 18:15, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Aug 24, 2023 at 05:57:40PM +0100, Peter Maydell wrote:
> > Instead of using a variable length array in notify_guest_bh(), always
> > use a fixed sized bitmap (this will be 128 bytes).  This means we
> > need to avoid assuming that bitmap and the s->batch_notify_vqs bitmap
> > are the same size; the neatest way to do this is to switch to using
> > bitmap.h APIs to declare, copy and clear, because then we can specify
> > the length in bits, exactly as we did when creating
> > s->batch_notify_vqs with bitmap_new().
> >
> > The codebase has very few VLAs, and if we can get rid of them all we
> > can make the compiler error on new additions.  This is a defensive
> > measure against security bugs where an on-stack dynamic allocation
> > isn't correctly size-checked (e.g.  CVE-2021-3527).
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > In discussion on Philippe's attempt at getting rid of this VLA:
> >
https://patchew.org/QEMU/20210505211047.1496765-1-philmd@redhat.com/20210505211047.1496765-7-philmd@redhat.com/
> > Stefan suggested getting rid of the local bitmap array entirely.
> > But I don't know this code at all and have no idea of the
> > implications (presumably there is a reason we have the local
> > array rather than iterating directly on batch_notify_vqs),
> > so I have opted for the more minimal change.
> >
> > Usual disclaimer: tested only with "make check" and
> > "make check-avocado".
> > ---
> >  hw/block/dataplane/virtio-blk.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
>
> Hi Peter,
> I recently sent a patch series that removes notify_guest_bh() completely:
>
https://lore.kernel.org/qemu-devel/20230817155847.3605115-5-stefanha@redhat.com/
>
> If it's urgent we can merge your patch immediately, though I hope my
> series will be merged soon anyway:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Great. There's no hurry here, so your change looks like the
best approach.

-- PMM

--00000000000085e4f106040cc5ed
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Thu, 24 Aug 2023 at 18:15, Stefan Hajnoczi &lt;=
<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a>&gt; wrote:<b=
r>&gt;<br>&gt; On Thu, Aug 24, 2023 at 05:57:40PM +0100, Peter Maydell wrot=
e:<br>&gt; &gt; Instead of using a variable length array in notify_guest_bh=
(), always<br>&gt; &gt; use a fixed sized bitmap (this will be 128 bytes).=
=C2=A0 This means we<br>&gt; &gt; need to avoid assuming that bitmap and th=
e s-&gt;batch_notify_vqs bitmap<br>&gt; &gt; are the same size; the neatest=
 way to do this is to switch to using<br>&gt; &gt; bitmap.h APIs to declare=
, copy and clear, because then we can specify<br>&gt; &gt; the length in bi=
ts, exactly as we did when creating<br>&gt; &gt; s-&gt;batch_notify_vqs wit=
h bitmap_new().<br>&gt; &gt;<br>&gt; &gt; The codebase has very few VLAs, a=
nd if we can get rid of them all we<br>&gt; &gt; can make the compiler erro=
r on new additions.=C2=A0 This is a defensive<br>&gt; &gt; measure against =
security bugs where an on-stack dynamic allocation<br>&gt; &gt; isn&#39;t c=
orrectly size-checked (e.g.=C2=A0 CVE-2021-3527).<br>&gt; &gt;<br>&gt; &gt;=
 Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.or=
g">peter.maydell@linaro.org</a>&gt;<br>&gt; &gt; ---<br>&gt; &gt; In discus=
sion on Philippe&#39;s attempt at getting rid of this VLA:<br>&gt; &gt; <a =
href=3D"https://patchew.org/QEMU/20210505211047.1496765-1-philmd@redhat.com=
/20210505211047.1496765-7-philmd@redhat.com/">https://patchew.org/QEMU/2021=
0505211047.1496765-1-philmd@redhat.com/20210505211047.1496765-7-philmd@redh=
at.com/</a><br>&gt; &gt; Stefan suggested getting rid of the local bitmap a=
rray entirely.<br>&gt; &gt; But I don&#39;t know this code at all and have =
no idea of the<br>&gt; &gt; implications (presumably there is a reason we h=
ave the local<br>&gt; &gt; array rather than iterating directly on batch_no=
tify_vqs),<br>&gt; &gt; so I have opted for the more minimal change.<br>&gt=
; &gt;<br>&gt; &gt; Usual disclaimer: tested only with &quot;make check&quo=
t; and<br>&gt; &gt; &quot;make check-avocado&quot;.<br>&gt; &gt; ---<br>&gt=
; &gt; =C2=A0hw/block/dataplane/virtio-blk.c | 11 ++++++++---<br>&gt; &gt; =
=C2=A01 file changed, 8 insertions(+), 3 deletions(-)<br>&gt;<br>&gt; Hi Pe=
ter,<br>&gt; I recently sent a patch series that removes notify_guest_bh() =
completely:<br>&gt; <a href=3D"https://lore.kernel.org/qemu-devel/202308171=
55847.3605115-5-stefanha@redhat.com/">https://lore.kernel.org/qemu-devel/20=
230817155847.3605115-5-stefanha@redhat.com/</a><br>&gt;<br>&gt; If it&#39;s=
 urgent we can merge your patch immediately, though I hope my<br>&gt; serie=
s will be merged soon anyway:<br><div>&gt; Reviewed-by: Stefan Hajnoczi &lt=
;<a href=3D"mailto:stefanha@redhat.com">stefanha@redhat.com</a>&gt;</div><d=
iv><br></div><div><div style=3D"font-family:monospace,monospace" class=3D"g=
mail_default">Great. There&#39;s no hurry here, so your change looks like t=
he</div><div style=3D"font-family:monospace,monospace" class=3D"gmail_defau=
lt">best approach.</div><div style=3D"font-family:monospace,monospace" clas=
s=3D"gmail_default"><br></div><div style=3D"font-family:monospace,monospace=
" class=3D"gmail_default">-- PMM</div><div style=3D"font-family:monospace,m=
onospace" class=3D"gmail_default"><br></div></div></div>

--00000000000085e4f106040cc5ed--


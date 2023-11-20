Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EA37F1481
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 14:37:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r54Rb-000443-67; Mon, 20 Nov 2023 08:36:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r54RY-00043f-6X; Mon, 20 Nov 2023 08:36:04 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r54RV-00058T-5j; Mon, 20 Nov 2023 08:36:02 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1cf69f1163aso1160265ad.3; 
 Mon, 20 Nov 2023 05:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700487359; x=1701092159; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yVSIBwGW/LKHkZiz/2s/wS4fLe692J0zjzS8RQDpQig=;
 b=FI3jZwd1KwrtERtXzMuZc6+3mrXpF8dbpgH0wG1c0BusaQKppdSpQb2KT6f97qhSP2
 eOtP6bZeEqSfaYkPqCtwqxTpnUcnu/Cq3avycM2aZK9648HRz7s1Dh/LrREArX0g1HFN
 3F/LTm8shNCnaaaYIYk4niHMZlXDvej5TEh4eMCICwyyJutQSZQnjj06A4EAZOQxgjVb
 LZ/CcEtycRzYtyKYxcKKFWuaGbeXg3Z8peqbVHXY9CUuvP4VSe4QimtcsgQ5vI5dEuum
 fVr6Y7s+NYX8fpjP3NsH5bJZufUla80nGLNgv8wpIyIUjuj+vIJXlUm+Qcv+GUHFcke7
 LHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700487359; x=1701092159;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yVSIBwGW/LKHkZiz/2s/wS4fLe692J0zjzS8RQDpQig=;
 b=docyy3nB7QRgoWyAqjRLt3abeumzbY6UCIef5+k0Uqmi903B+CCuPHzhX6FJ3SydLG
 D48oxmISsRGn4VvnYpIr/4dUue4ojDJnDnPqtftx+ajyWxRhUkS8YnBxP50l9r9HGm6r
 nSeOezerKkySiEsqW3i3nhwt/AskrsOHPc4g6cjwrNnDW5xDWmJJliXUrZFEUftec0bd
 1bLq7g5waYUBMCayLKek+IXPY+2gT83GKHbgBdT5+IV1s0fF//DOojxYvNBXeUoGjRwm
 ftEbEGEWIplI2Q84H/l17/QbzPe3zCxfOyp+PonJm0YWPHKBhhODhPojQOMqbD39JVz5
 c1fA==
X-Gm-Message-State: AOJu0YxqapdlgSBXayZc9Elqrdj3NMA58dThe5c5PlJ3DhyGmvTqBFQi
 mmnbblu9dWAznyE36z51EfA=
X-Google-Smtp-Source: AGHT+IF8Jc4R6RKObesbHgPssITgZNjdfx3LD08teq+ffbu7g5re0zJy9Wzlli4RB4lWxXA87bZegg==
X-Received: by 2002:a17:902:d503:b0:1cc:b09a:b811 with SMTP id
 b3-20020a170902d50300b001ccb09ab811mr6107388plg.14.1700487358925; 
 Mon, 20 Nov 2023 05:35:58 -0800 (PST)
Received: from localhost (203-219-179-16.tpgi.com.au. [203.219.179.16])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a170902d38400b001ca2484e87asm6047828pld.262.2023.11.20.05.35.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Nov 2023 05:35:58 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Nov 2023 23:35:50 +1000
Message-Id: <CX3OGGIB0IAN.1CDYNM9U7M5Y3@wheely>
Cc: <qemu-devel@nongnu.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "Pavel
 Dovgalyuk" <pavel.dovgaluk@ispras.ru>, "Cleber Rosa" <crosa@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 "Ani Sinha" <anisinha@redhat.com>, =?utf-8?b?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?=
 <berrange@redhat.com>, "Thomas Huth" <thuth@redhat.com>, "John Snow"
 <jsnow@redhat.com>, <qemu-ppc@nongnu.org>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Subject: Re: [PATCH 2/3] chardev: report blocked write to chardev backend
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Mailer: aerc 0.15.2
References: <20231116115354.228678-1-npiggin@gmail.com>
 <20231116115354.228678-2-npiggin@gmail.com>
 <CAMxuvawXTrQ3Mu-aGbELnQyBRU4W9kuMQo-XM_zm4FbRymHkqA@mail.gmail.com>
In-Reply-To: <CAMxuvawXTrQ3Mu-aGbELnQyBRU4W9kuMQo-XM_zm4FbRymHkqA@mail.gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon Nov 20, 2023 at 10:06 PM AEST, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Thu, Nov 16, 2023 at 3:54=E2=80=AFPM Nicholas Piggin <npiggin@gmail.co=
m> wrote:
> >
> > If a chardev socket is not read, it will eventually fill and QEMU
> > can block attempting to write to it. A difficult bug in avocado
> > tests where the console socket was not being read from caused this
> > hang.
> >
> > warn if a chardev write is blocked for 100ms.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > This is not necessary for the fix but it does trigger in the
> > failing avocado test without the previous patch applied. Maybe
> > it would be helpful?
> >
> > Thanks,
> > Nick
> >
> >  chardev/char.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/chardev/char.c b/chardev/char.c
> > index 996a024c7a..7c375e3cc4 100644
> > --- a/chardev/char.c
> > +++ b/chardev/char.c
> > @@ -114,6 +114,8 @@ static int qemu_chr_write_buffer(Chardev *s,
> >  {
> >      ChardevClass *cc =3D CHARDEV_GET_CLASS(s);
> >      int res =3D 0;
> > +    int nr_retries =3D 0;
> > +
> >      *offset =3D 0;
> >
> >      qemu_mutex_lock(&s->chr_write_lock);
> > @@ -126,6 +128,10 @@ static int qemu_chr_write_buffer(Chardev *s,
> >              } else {
> >                  g_usleep(100);
> >              }
> > +            if (++nr_retries =3D=3D 1000) { /* 100ms */
> > +                warn_report("Chardev '%s' write blocked for > 100ms, "
> > +                            "socket buffer full?", s->label);
> > +            }
>
> That shouldn't happen, the frontend should poll and only write when it
> can. What is the qemu command being used here?

You can follow it through the thread here

https://lore.kernel.org/qemu-devel/ZVT-bY9YOr69QTPX@redhat.com/

In short, a console device is attached to a socket pair and nothing
ever reads from it. It eventually fills, and writing to it fails
indefinitely here.

It can be reproduced with:

make check-avocado
AVOCADO_TESTS=3Dtests/avocado/reverse_debugging.py:test_ppc64_pseries


> I think this change can be worth for debugging though.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks,
Nick


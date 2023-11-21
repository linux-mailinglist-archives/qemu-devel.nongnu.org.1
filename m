Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 329087F2913
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 10:40:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5NED-0006fW-97; Tue, 21 Nov 2023 04:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r5NEB-0006eh-79
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 04:39:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r5NE0-00055g-Nn
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 04:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700559557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4zJx5FHFwi1JtcId0flSHLfurnsSd39yPczHUwUqMlc=;
 b=LZIZN5MQ776BkcqJtmtxfULnDdR8A+J8wLxNZZ2dix3eh0UxlCvt294Vey8lM2GUJ8KQVp
 1ukEjjkrO1Mu1HUtMRui5Oqeaud/CifrT6//bcfcvRYlQ1Br1hMv26IYXBtsFtQ0pSWhG/
 GRg79N36xS6lpsrDqmEdjW7uLAsb5/8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-7-AtGoBxMo-pgZ7keRGdyw-1; Tue, 21 Nov 2023 04:39:16 -0500
X-MC-Unique: 7-AtGoBxMo-pgZ7keRGdyw-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-548f23c0310so559111a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 01:39:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700559555; x=1701164355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4zJx5FHFwi1JtcId0flSHLfurnsSd39yPczHUwUqMlc=;
 b=cRGC22mLzXK3fR5s9MyJvC/L5ZQ/wYcfHjb9+uXsYB6ZT9aGHLB4xPa0kthYQBAxVR
 7/W9r0LofuovkgRGgSPVhm9Gx0dnSWGl7LmXgdip2zm3XCqiPkLEfiS2cDCzJSRaefjC
 JVEokjy2x8I34o3oZ2gyQ0pkRM8zCdm4+S/9Fp3PRu+4J5SF1zbIIXFUwP3pLMFuygHx
 bSek2oZuJoKGIWp8gEAOtOgnOwPdEz4ML8UWrXUV6JJuEn/hwXiXBbyxlBXMHoaGCNgd
 YKU9Am97m77joIQy5Laun7RWVnSuVQ3mw4tSuZZrtPyFwASPbOtt/yy74+Ob+uAUAfgx
 0+/A==
X-Gm-Message-State: AOJu0YzUkcgy90vy2W/mQ4SQyAvHsLNymnY5i2oykiA47DLGo/R9qIwg
 6FQOuUK0nNJAH0XtS/eQ1+tpx4voXNN6tS3ZuOVsExblD5H9dEdF7AbHu6PvoDsk5GdK258o9Q3
 ydsHOihjmqQI6yHT3O4D4GFRgkZ+/VcE=
X-Received: by 2002:aa7:c2d1:0:b0:548:615c:33aa with SMTP id
 m17-20020aa7c2d1000000b00548615c33aamr1423508edp.20.1700559555112; 
 Tue, 21 Nov 2023 01:39:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgYF+6ggnxEw/OcoTbiZxsriOxCykYQkszohmDjMblCMqLeZG4BC/oztMcUR396LFFSyS7fZwj+afcGfFdSbw=
X-Received: by 2002:aa7:c2d1:0:b0:548:615c:33aa with SMTP id
 m17-20020aa7c2d1000000b00548615c33aamr1423494edp.20.1700559554859; Tue, 21
 Nov 2023 01:39:14 -0800 (PST)
MIME-Version: 1.0
References: <20231116115354.228678-1-npiggin@gmail.com>
 <20231116115354.228678-2-npiggin@gmail.com>
 <CAMxuvawXTrQ3Mu-aGbELnQyBRU4W9kuMQo-XM_zm4FbRymHkqA@mail.gmail.com>
 <CX3OGGIB0IAN.1CDYNM9U7M5Y3@wheely>
In-Reply-To: <CX3OGGIB0IAN.1CDYNM9U7M5Y3@wheely>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Nov 2023 13:39:03 +0400
Message-ID: <CAMxuvayyULsyM0bQvCr-WRP39JwbTcDknBYEhj=eDrRQ2+9dUQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] chardev: report blocked write to chardev backend
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi

On Mon, Nov 20, 2023 at 5:36=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com>=
 wrote:
>
> On Mon Nov 20, 2023 at 10:06 PM AEST, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Thu, Nov 16, 2023 at 3:54=E2=80=AFPM Nicholas Piggin <npiggin@gmail.=
com> wrote:
> > >
> > > If a chardev socket is not read, it will eventually fill and QEMU
> > > can block attempting to write to it. A difficult bug in avocado
> > > tests where the console socket was not being read from caused this
> > > hang.
> > >
> > > warn if a chardev write is blocked for 100ms.
> > >
> > > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > > ---
> > > This is not necessary for the fix but it does trigger in the
> > > failing avocado test without the previous patch applied. Maybe
> > > it would be helpful?
> > >
> > > Thanks,
> > > Nick
> > >
> > >  chardev/char.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/chardev/char.c b/chardev/char.c
> > > index 996a024c7a..7c375e3cc4 100644
> > > --- a/chardev/char.c
> > > +++ b/chardev/char.c
> > > @@ -114,6 +114,8 @@ static int qemu_chr_write_buffer(Chardev *s,
> > >  {
> > >      ChardevClass *cc =3D CHARDEV_GET_CLASS(s);
> > >      int res =3D 0;
> > > +    int nr_retries =3D 0;
> > > +
> > >      *offset =3D 0;
> > >
> > >      qemu_mutex_lock(&s->chr_write_lock);
> > > @@ -126,6 +128,10 @@ static int qemu_chr_write_buffer(Chardev *s,
> > >              } else {
> > >                  g_usleep(100);
> > >              }
> > > +            if (++nr_retries =3D=3D 1000) { /* 100ms */
> > > +                warn_report("Chardev '%s' write blocked for > 100ms,=
 "
> > > +                            "socket buffer full?", s->label);
> > > +            }
> >
> > That shouldn't happen, the frontend should poll and only write when it
> > can. What is the qemu command being used here?
>
> You can follow it through the thread here
>
> https://lore.kernel.org/qemu-devel/ZVT-bY9YOr69QTPX@redhat.com/
>
> In short, a console device is attached to a socket pair and nothing
> ever reads from it. It eventually fills, and writing to it fails
> indefinitely here.
>
> It can be reproduced with:
>
> make check-avocado
> AVOCADO_TESTS=3Dtests/avocado/reverse_debugging.py:test_ppc64_pseries
>
>

How reliably? I tried 10/10.

> > I think this change can be worth for debugging though.
> >
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Thanks,
> Nick
>



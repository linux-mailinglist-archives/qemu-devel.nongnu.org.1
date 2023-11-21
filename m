Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D337F2C0A
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 12:49:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5PEj-00012G-Be; Tue, 21 Nov 2023 06:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r5PEh-000109-8f
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:48:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1r5PEf-00033p-Dh
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 06:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700567288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ns7IEpHzLzTnO+XNb37aLvzLgqnXzGEAkVq5Q7NYnrk=;
 b=BmBvKpdzc/Xa3jJywtzGiozbYctZ9Gndk6FYLJN1U71P+ouwIg7rxURK6+XMLlIdCS/L8Y
 21j9VKepBrMrsXAqU2NSz69eMzftpbSpEwyCDmRHiu5j8Nol3+STg7E7ObeXR31piqIDiU
 dzo8tndC15+IjCSOlrsjBFtneIadmm0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-YeZbkZXiNeCtabQvGJUaVw-1; Tue, 21 Nov 2023 06:48:06 -0500
X-MC-Unique: YeZbkZXiNeCtabQvGJUaVw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-53e3bfec5bdso4053665a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 03:48:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700567285; x=1701172085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ns7IEpHzLzTnO+XNb37aLvzLgqnXzGEAkVq5Q7NYnrk=;
 b=uFC9nxVxogd8Sw3iNbeVczKqfBbPvDc9rJUiuZlm8I44MLHHwBSVBv2iMqOsG78CvI
 DGVE5cceIfKgsMBw5ZVHi9aQMs9LnEbvi0IUxOSKqgqhsPR98rT4e4LTHHgQhLxWzHew
 srgr7LEkP5tqg8/sck2a3VJGVxm6VFek9mv3L1mg5MfDry1FCrkshM8b5Ryh949wjgbV
 xwScQ5PR3Erj9rMjY7J067w3d0Vg17lXBFeKhn3IgqsVEzsDQCpv5wb1TbW17rBkO33R
 Qk+ZQFMXZk5+BR4T/5Kj48cl/uvU3rhV9fJG1E5d06G8ZgjG0PGQGqozy1j53YaOaijF
 UymA==
X-Gm-Message-State: AOJu0YzEXw9Wak+2BhL/VUeGkbhpwvSPc314NnMsTojInZfB6/3LikDU
 p1RVR6vn22UOxSZ8Wk4tYINQjmfuAhoGiNVlCZoylI8Kx9yCSwF8xm8hMw1DhMNh13tWG9bdJj8
 WpykGtxuRkgF+cxpa51q+nEOto7uEX4I=
X-Received: by 2002:a50:9b18:0:b0:543:7c4f:7ed0 with SMTP id
 o24-20020a509b18000000b005437c4f7ed0mr1996738edi.18.1700567285599; 
 Tue, 21 Nov 2023 03:48:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESWMN/X8n/ry+41GzRYd7eeLrxWH3NDvWaPIx/AgJPUb/tnEZfDv/18qqdBeNvSJLgYAtYlwS5ckypYDvjEvA=
X-Received: by 2002:a50:9b18:0:b0:543:7c4f:7ed0 with SMTP id
 o24-20020a509b18000000b005437c4f7ed0mr1996717edi.18.1700567285333; Tue, 21
 Nov 2023 03:48:05 -0800 (PST)
MIME-Version: 1.0
References: <20231116115354.228678-1-npiggin@gmail.com>
 <20231116115354.228678-2-npiggin@gmail.com>
 <CAMxuvawXTrQ3Mu-aGbELnQyBRU4W9kuMQo-XM_zm4FbRymHkqA@mail.gmail.com>
 <CX3OGGIB0IAN.1CDYNM9U7M5Y3@wheely>
 <CAMxuvayyULsyM0bQvCr-WRP39JwbTcDknBYEhj=eDrRQ2+9dUQ@mail.gmail.com>
 <13f96104-9d9d-4f57-9c40-06352b6a6b87@redhat.com>
In-Reply-To: <13f96104-9d9d-4f57-9c40-06352b6a6b87@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 21 Nov 2023 15:47:53 +0400
Message-ID: <CAMxuvay+vfg+tCq3ZQt5WkLxH69QXTC1vS_7QmEKCPxCoC840g@mail.gmail.com>
Subject: Re: [PATCH 2/3] chardev: report blocked write to chardev backend
To: Thomas Huth <thuth@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
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

On Tue, Nov 21, 2023 at 1:45=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 21/11/2023 10.39, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Mon, Nov 20, 2023 at 5:36=E2=80=AFPM Nicholas Piggin <npiggin@gmail.=
com> wrote:
> >>
> >> On Mon Nov 20, 2023 at 10:06 PM AEST, Marc-Andr=C3=A9 Lureau wrote:
> >>> Hi
> >>>
> >>> On Thu, Nov 16, 2023 at 3:54=E2=80=AFPM Nicholas Piggin <npiggin@gmai=
l.com> wrote:
> >>>>
> >>>> If a chardev socket is not read, it will eventually fill and QEMU
> >>>> can block attempting to write to it. A difficult bug in avocado
> >>>> tests where the console socket was not being read from caused this
> >>>> hang.
> >>>>
> >>>> warn if a chardev write is blocked for 100ms.
> >>>>
> >>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>>> ---
> >>>> This is not necessary for the fix but it does trigger in the
> >>>> failing avocado test without the previous patch applied. Maybe
> >>>> it would be helpful?
> >>>>
> >>>> Thanks,
> >>>> Nick
> >>>>
> >>>>   chardev/char.c | 6 ++++++
> >>>>   1 file changed, 6 insertions(+)
> >>>>
> >>>> diff --git a/chardev/char.c b/chardev/char.c
> >>>> index 996a024c7a..7c375e3cc4 100644
> >>>> --- a/chardev/char.c
> >>>> +++ b/chardev/char.c
> >>>> @@ -114,6 +114,8 @@ static int qemu_chr_write_buffer(Chardev *s,
> >>>>   {
> >>>>       ChardevClass *cc =3D CHARDEV_GET_CLASS(s);
> >>>>       int res =3D 0;
> >>>> +    int nr_retries =3D 0;
> >>>> +
> >>>>       *offset =3D 0;
> >>>>
> >>>>       qemu_mutex_lock(&s->chr_write_lock);
> >>>> @@ -126,6 +128,10 @@ static int qemu_chr_write_buffer(Chardev *s,
> >>>>               } else {
> >>>>                   g_usleep(100);
> >>>>               }
> >>>> +            if (++nr_retries =3D=3D 1000) { /* 100ms */
> >>>> +                warn_report("Chardev '%s' write blocked for > 100ms=
, "
> >>>> +                            "socket buffer full?", s->label);
> >>>> +            }
> >>>
> >>> That shouldn't happen, the frontend should poll and only write when i=
t
> >>> can. What is the qemu command being used here?
> >>
> >> You can follow it through the thread here
> >>
> >> https://lore.kernel.org/qemu-devel/ZVT-bY9YOr69QTPX@redhat.com/
> >>
> >> In short, a console device is attached to a socket pair and nothing
> >> ever reads from it. It eventually fills, and writing to it fails
> >> indefinitely here.
> >>
> >> It can be reproduced with:
> >>
> >> make check-avocado
> >> AVOCADO_TESTS=3Dtests/avocado/reverse_debugging.py:test_ppc64_pseries
> >>
> >>
> >
> > How reliably? I tried 10/10.
>
> It used to fail for me every time I tried - but the fix has already been
> merged yesterday (commit cd43f00524070c026), so if you updated today, you=
'll
> see the test passing again.

Ok so the "frontend" is spapr-vty and there:

void vty_putchars(SpaprVioDevice *sdev, uint8_t *buf, int len)
{
    SpaprVioVty *dev =3D VIO_SPAPR_VTY_DEVICE(sdev);

    /* XXX this blocks entire thread. Rewrite to use
     * qemu_chr_fe_write and background I/O callbacks */
    qemu_chr_fe_write_all(&dev->chardev, buf, len);
}

(grep "XXX this blocks", we have a lot...)

Can H_PUT_TERM_CHAR return the number of bytes written?

Is there a way to tell the guest the console is ready to accept more bytes?



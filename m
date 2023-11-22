Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 251C17F42F3
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 10:56:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5jxd-0005w6-6n; Wed, 22 Nov 2023 04:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r5jxY-0005vY-6h
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 04:55:52 -0500
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r5jxW-0003P5-E9
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 04:55:51 -0500
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c8879a1570so32915971fa.1
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 01:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700646948; x=1701251748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bHHpUSEAUAqxVBFttOKnMmiA4w4u6on18LXh3/Xh/T0=;
 b=gYlOUhmZWfnpRRxTq3FpeqLIs0snNvW9zN06JCUiG2JbMzJ4jNu8C7kUcowUekLYCf
 +a6xPgsY7ULKN3lyxEMs1kInZnVgsS+gnJ6M9xSzgEmzBZEUCDDW6ZHdzrfw1f7VtFL9
 SBWFMakJBchiQ3Paa8YHohpFr0uHoR+2l2xRsGNFf0NMo1OR8My2zdNw8BWRmkqiYtxc
 BJArE3/PWfuGRy/998UnQlcgQnWWTLl2J14oM4exD0+wm26aoITRvLWSyQLsOc3TOoUz
 Gb32HEUfakAREoRLY2qYsx7NEIAkR9jWlpZNY0lKeerFFBEG5Ng5qbdZ+E2gfPOh5Za5
 fPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700646948; x=1701251748;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bHHpUSEAUAqxVBFttOKnMmiA4w4u6on18LXh3/Xh/T0=;
 b=hVqdM+DuqYCJ9bgcx0/ZFzi2AX0Es8ft4iWkvZ1r/mqHPhRRSx3+lThRpGEuJyIzWY
 qz2V7wefEO5fgTo7NlWhOFktdU51m8nNePTyvJnJGGPnGzcd33klzNa/Cfm48eUb2aEa
 m4U2Z+B8tRooIM9mFdosuI4yoJ9wDHrdAdIjaqECSGZZAB/6I7TYri8vtiMY6QopxYlj
 3c4xM54oM3hC9effsohNMHeGNQ2Blm9bAvyLRd+6O184DBwwij+GlxeWL0ZsicR9yEfW
 YPnlcgmUjDpLo34veXkCwgw3189A4RCgBDg7o4hUWEYtnGR7RfJUVNHqAU1/eLR5oTPO
 jw3g==
X-Gm-Message-State: AOJu0YxGhWpRbFzoEqgNdWTwF8g4jrO73g4tRgjzzjd466C6WpjIOJo2
 QleJKCDH58JR8LxmmtRXtFd8Jg==
X-Google-Smtp-Source: AGHT+IEYqT7wkq9OndgRHsQhWwJta10Yp0GArZ4dXD5SwJgclttSdsnZk9LncgK6MrWmCs2LfTVc4Q==
X-Received: by 2002:a2e:9645:0:b0:2b6:da88:a2d0 with SMTP id
 z5-20020a2e9645000000b002b6da88a2d0mr1338264ljh.47.1700646948108; 
 Wed, 22 Nov 2023 01:55:48 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 m3-20020a05600c4f4300b0040b297fce5fsm1659544wmq.10.2023.11.22.01.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 01:55:47 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6918D5F769;
 Wed, 22 Nov 2023 09:55:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,  Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Pavel
 Dovgalyuk <pavel.dovgaluk@ispras.ru>,  Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Wainer dos
 Santos Moschetta
 <wainersm@redhat.com>,  Beraldo Leal <bleal@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  John Snow <jsnow@redhat.com>,  qemu-ppc@nongnu.org
Subject: Re: [PATCH 2/3] chardev: report blocked write to chardev backend
In-Reply-To: <CAMxuvay+vfg+tCq3ZQt5WkLxH69QXTC1vS_7QmEKCPxCoC840g@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 21 Nov 2023
 15:47:53 +0400")
References: <20231116115354.228678-1-npiggin@gmail.com>
 <20231116115354.228678-2-npiggin@gmail.com>
 <CAMxuvawXTrQ3Mu-aGbELnQyBRU4W9kuMQo-XM_zm4FbRymHkqA@mail.gmail.com>
 <CX3OGGIB0IAN.1CDYNM9U7M5Y3@wheely>
 <CAMxuvayyULsyM0bQvCr-WRP39JwbTcDknBYEhj=eDrRQ2+9dUQ@mail.gmail.com>
 <13f96104-9d9d-4f57-9c40-06352b6a6b87@redhat.com>
 <CAMxuvay+vfg+tCq3ZQt5WkLxH69QXTC1vS_7QmEKCPxCoC840g@mail.gmail.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Wed, 22 Nov 2023 09:55:47 +0000
Message-ID: <8734wyf6xo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Tue, Nov 21, 2023 at 1:45=E2=80=AFPM Thomas Huth <thuth@redhat.com> wr=
ote:
>>
>> On 21/11/2023 10.39, Marc-Andr=C3=A9 Lureau wrote:
>> > Hi
>> >
>> > On Mon, Nov 20, 2023 at 5:36=E2=80=AFPM Nicholas Piggin <npiggin@gmail=
.com> wrote:
>> >>
>> >> On Mon Nov 20, 2023 at 10:06 PM AEST, Marc-Andr=C3=A9 Lureau wrote:
>> >>> Hi
>> >>>
>> >>> On Thu, Nov 16, 2023 at 3:54=E2=80=AFPM Nicholas Piggin <npiggin@gma=
il.com> wrote:
>> >>>>
>> >>>> If a chardev socket is not read, it will eventually fill and QEMU
>> >>>> can block attempting to write to it. A difficult bug in avocado
>> >>>> tests where the console socket was not being read from caused this
>> >>>> hang.
>> >>>>
>> >>>> warn if a chardev write is blocked for 100ms.
>> >>>>
>> >>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
<snip>
>> >>>> index 996a024c7a..7c375e3cc4 100644
>> >>>> --- a/chardev/char.c
>> >>>> +++ b/chardev/char.c
>> >>>> @@ -114,6 +114,8 @@ static int qemu_chr_write_buffer(Chardev *s,
>> >>>>   {
>> >>>>       ChardevClass *cc =3D CHARDEV_GET_CLASS(s);
>> >>>>       int res =3D 0;
>> >>>> +    int nr_retries =3D 0;
>> >>>> +
>> >>>>       *offset =3D 0;
>> >>>>
>> >>>>       qemu_mutex_lock(&s->chr_write_lock);
>> >>>> @@ -126,6 +128,10 @@ static int qemu_chr_write_buffer(Chardev *s,
>> >>>>               } else {
>> >>>>                   g_usleep(100);
>> >>>>               }
>> >>>> +            if (++nr_retries =3D=3D 1000) { /* 100ms */
>> >>>> +                warn_report("Chardev '%s' write blocked for > 100m=
s, "
>> >>>> +                            "socket buffer full?", s->label);
>> >>>> +            }
>> >>>
>> >>> That shouldn't happen, the frontend should poll and only write when =
it
>> >>> can. What is the qemu command being used here?
<snip>
>
> Ok so the "frontend" is spapr-vty and there:
>
> void vty_putchars(SpaprVioDevice *sdev, uint8_t *buf, int len)
> {
>     SpaprVioVty *dev =3D VIO_SPAPR_VTY_DEVICE(sdev);
>
>     /* XXX this blocks entire thread. Rewrite to use
>      * qemu_chr_fe_write and background I/O callbacks */
>     qemu_chr_fe_write_all(&dev->chardev, buf, len);
> }
>
> (grep "XXX this blocks", we have a lot...)
>
> Can H_PUT_TERM_CHAR return the number of bytes written?
>
> Is there a way to tell the guest the console is ready to accept more byte=
s?

See also:

  Message-ID: <20231109192814.95977-1-philmd@linaro.org>
  Date: Thu,  9 Nov 2023 20:28:04 +0100
  Subject: [PATCH-for-8.2 v4 00/10] hw/char/pl011: Implement TX (async) FIF=
O to avoid blocking the main loop
  From: =3D?UTF-8?q?Philippe=3D20Mathieu-Daud=3DC3=3DA9?=3D <philmd@linaro.=
org>

Although it didn't make it into 8.2. I was hoping it would be a template
for fixing up the other cases.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro


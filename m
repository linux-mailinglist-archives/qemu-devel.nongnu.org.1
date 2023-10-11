Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C0A7C4A9C
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 08:32:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqSka-0001pR-9h; Wed, 11 Oct 2023 02:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qqSkR-0001o0-IH; Wed, 11 Oct 2023 02:31:11 -0400
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qqSkP-0006qh-Mn; Wed, 11 Oct 2023 02:31:10 -0400
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-41983b83e53so43393271cf.2; 
 Tue, 10 Oct 2023 23:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697005868; x=1697610668; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3yrW//dl7KVHpd83yCnjW2xNDbCB39pK10w3JdJ6i5Q=;
 b=jhTDS2yFPdl405cqlraiaD4JaelMerE8QLe0pPycuYin0NOd2YDDeS605F+HGll783
 FhkhZjdnwEk7fDVVbjA5rHrrSc5zIF3QAPzMep5qg7mW8ulhBw26pLPf/fRfkBA0/Cn/
 FtI+NSoNH43YLRQmO9D9W+jTOP0xXNlDxJCD73yESW3LI0GaJb0xznmPhbbRC6of+7P5
 pkBhKLo68vPtAG51AIQJ1BYnPXnBUW4n7REFEP9G35sT7CrYBbSf/byGxONT05u8hQUJ
 TzYZWqMVr0ybuoTHdSZfylWu6Jy/rQsTs5JfKPe8/rQyTFyPoT9dcLnX+Hde39wnztZb
 8flQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697005868; x=1697610668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3yrW//dl7KVHpd83yCnjW2xNDbCB39pK10w3JdJ6i5Q=;
 b=oVX2UDufmzr0dMvymjxrZbdJMGHugtzwgoQt7/jJo4kZO8xzFOtY/DkC8VyRBzkbKE
 AE3dBDSEfQJ/0sz98fW0AqyVUSINbm+qor5Hh/URGOQjpnqom/1X7bhwuZcSOFEFZ3EZ
 3mGfCsFxmneY0LrVXXOFfCRkeMRVOTDYbxHtVLV7MF/l1xFC/soXfQsy8pxnXG+EKUTM
 HHeHa4xLX0UVKtxgPVXlEPNnkzEUdd9atS+Eh852hi7zLGXbCzU2EW2nBxMd121akNFb
 3hXdPqAq51VmkTNCHBdP0R6x0W5cdRTHCU8Aw37vw6UXTyiZegW93qlh8Dwtk2PIuXEd
 Zmgg==
X-Gm-Message-State: AOJu0YzIpfGCBpXu5YSxetbfo3oavnfucwpU9x8l3EgU2F38RZx8T0VG
 SiHhx6Sp2ljLnK7WwOpopCzB3kkz77ThiyvIZh0=
X-Google-Smtp-Source: AGHT+IELgj5BNMM0NqPyQX3x5ZT0u9otMTeXZx9TgXzYCY3hoY0jyjhx1B3XN5ZWqJLQ/ABKIfBnxF51qgANN6nPyXU=
X-Received: by 2002:ac8:7f93:0:b0:418:110e:6179 with SMTP id
 z19-20020ac87f93000000b00418110e6179mr27725753qtj.1.1697005868158; Tue, 10
 Oct 2023 23:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <cfc5a196-9939-44b5-8716-9525f1a08a2a@t-online.de>
 <74bd8b1f-7db4-9385-0d1b-64c505200cd3@eik.bme.hu>
In-Reply-To: <74bd8b1f-7db4-9385-0d1b-64c505200cd3@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 11 Oct 2023 10:30:56 +0400
Message-ID: <CAJ+F1CLqRDLqugBkxbt5gejOmd9CmeiZW=eAdAjHoVxcwrU38A@mail.gmail.com>
Subject: Re: [PATCH 0/8] hw/audio/es1370: bug fix
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 10, 2023 at 4:26=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Sun, 17 Sep 2023, Volker R=C3=BCmelin wrote:
> > Cc: qemu-stable. Patch 1/8 is a bug fix.
> > Cc: more people. The maintainer of hw/audio is busy with other projects=
.
> >
> > Earlier this year I was asked if I could help to debug an audio playbac=
k
> > speed issue with the es1370 device. While debugging the playback speed
> > error, I noticed that the debug code of the ES1370 device has not been
> > compiled for a long time and has bit-rotted. This patch series fixes th=
e
> > rotten code and also fixes a bug I found while debugging the code. The
> > bug fix is in patch 1/8 and prevents corrupted data streams. The
> > playback speed issue was caused by lost interrupts. Patch 8/8 helps to
> > debug this kind of issues.
> >
> > Volker R=C3=BCmelin (8):
> >   hw/audio/es1370: reset current sample counter
> >   hw/audio/es1370: replace bit-rotted code with tracepoints
> >   hw/audio/es1370: remove unused dolog macro
> >   hw/audio/es1370: remove #ifdef ES1370_DEBUG to avoid bit rot
> >   hw/audio/es1370: remove #ifdef ES1370_VERBOSE to avoid bit rot
> >   hw/audio/es1370: block structure coding style fixes
> >   hw/audio/es1370: change variable type and name
> >   hw/audio/es1370: trace lost interrupts
> >
> >  hw/audio/es1370.c     | 289 +++++++++++++++++++-----------------------
> >  hw/audio/trace-events |  11 ++
> >  2 files changed, 143 insertions(+), 157 deletions(-)
>
> Tested-by: BALATON Zoltan <balaton@eik.bme.hu>
>
> The whole series also got a reirwed-by from Marc-Andre already so maybe
> Gerd should have a look merging this.

I am going to send a PR.

thanks

--=20
Marc-Andr=C3=A9 Lureau


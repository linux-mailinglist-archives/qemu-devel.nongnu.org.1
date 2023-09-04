Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A287917B4
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 15:00:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd9BF-0004sN-Dc; Mon, 04 Sep 2023 08:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qd9BC-0004oT-7L
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:59:46 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qd9B9-00026Y-US
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:59:45 -0400
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-414a929a6f9so7512491cf.2
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 05:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693832382; x=1694437182; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0kIZjdOmfH1h2zfXpR8abzXykNwg0vQ0eDp5fzJ02R4=;
 b=Fi9D1BLzU6t2/3/HkMAy2vaD+MiO7gKR0fHIWBTpAcZGbRtJ8kUtcMmF5dCncNKIqN
 4Er4WDTXWtEZYP5+8gVjKkUYO6A+Fl2nExKjCnr129N9AzJjfloB8heSf8CH2WCxrTY+
 ROOvh7IXGT4ZIfzeNg3iBLhwQxSK+q+yPECzeAtQx1M6g/56rDBNdrqjbyPHbAU6N7vM
 8LOnjpN3jNrR8arV24nZDZzVfNKa+LdwZCRas+1SjpM7XQuQcm1+HllSVPWWRbBpBrDR
 hh007xePcP/M7fC9nKTFeDyGFjScLwdAAJwaTCkGxU1xpNEGtKVtPRTHm8xb3kaL04/7
 9neQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693832382; x=1694437182;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0kIZjdOmfH1h2zfXpR8abzXykNwg0vQ0eDp5fzJ02R4=;
 b=E2Qxh/FwSQCQ/zx3+Ihi8YFVse20NYKbzVIe9fksf4xGuxbSEKYmgY9CKgG88+oKDZ
 ddxUAMXPvU1u93ktsLGiXTi5Sv+U9LIJ2rudZZHOVZWWOuff2nZ3FpPP/HvqhbYEcbCr
 ZqmGLqMfEWGAvD0JdHddi5oXu0qpRu1fXklAzsmp4GQDt8Qsi7576rinp/a8C0CAQfxe
 EW6SsGCMl67paafq1DN0R3/QtRGyPJX6PHCIoZE/TkwP5rnrInJHajstExVhEuzZLhTw
 W3f30DuqbK1xX062TXLvh05ZdLvezBLzWmn4CBL47w/8HWb1I6qu6jlfvL4I+gxsuKvs
 lwaw==
X-Gm-Message-State: AOJu0YyU/QLLPHhczNTbwZKIq8HSbwfnDDnEa08y7cgpgR/krGKANEtR
 /RI+mWCkWxOSReLYBoCJhqbvoFHxZ3W3kR231oyu6oC6DEI=
X-Google-Smtp-Source: AGHT+IExrDCoq01DIaINc+EQmBivbWFE0cskm+tooVUglsMEjog2i7gUkfDvxyx8SgqfWT/lwCoE8Uh2kw60L91JZE0=
X-Received: by 2002:ac8:5f52:0:b0:403:9a33:5f53 with SMTP id
 y18-20020ac85f52000000b004039a335f53mr9708405qta.38.1693832382350; Mon, 04
 Sep 2023 05:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-51-marcandre.lureau@redhat.com>
 <ZPIeP6Gwm5AtfUgF@redhat.com>
In-Reply-To: <ZPIeP6Gwm5AtfUgF@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 4 Sep 2023 16:59:31 +0400
Message-ID: <CAJ+F1C+wwdoDV6bnuRbkHxpmmnrMAD_gcR3DU5-kD1dsQ2iuqA@mail.gmail.com>
Subject: Re: [PATCH 50/67] ui/console: move DisplaySurface to its own header
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::834;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x834.google.com
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

On Fri, Sep 1, 2023 at 9:24=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Wed, Aug 30, 2023 at 01:38:24PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Mostly for readability reasons.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  include/ui/console.h | 84 +---------------------------------------
> >  include/ui/surface.h | 91 ++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 92 insertions(+), 83 deletions(-)
> >  create mode 100644 include/ui/surface.h
> >
>
> > diff --git a/include/ui/surface.h b/include/ui/surface.h
> > new file mode 100644
> > index 0000000000..37725a303e
> > --- /dev/null
> > +++ b/include/ui/surface.h
> > @@ -0,0 +1,91 @@
>
> When you moved the VC bits out of console.h you added a GPL-2.0-or-later
> SPDX tag, so by implication this ought to gain the same.
>


Done. R-B with that change?


--=20
Marc-Andr=C3=A9 Lureau


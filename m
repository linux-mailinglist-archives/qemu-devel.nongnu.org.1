Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B4179C700
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 08:35:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfwya-00086p-7R; Tue, 12 Sep 2023 02:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qfwyY-00086S-MG
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:34:18 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qfwyW-00038c-IG
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 02:34:18 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-770ef96aa01so207407185a.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 23:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694500455; x=1695105255; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=onWGGLkxM/AvYKworx+I2K8oIhrZGL/ZKUj+lLyqhF8=;
 b=J3Y+DQ4nAdlzXrlCsAm/RogfoMke+kjitYxlzaqtOoxzw6ZBZOP7hUxf/5TWre0bJH
 awBTpBqy48teJeYflrU2BTFWW8qGTgCIsGlTk8auNWbh41ObeHmumvEeAmiQ9zvicEdS
 cIGp7FGlC6I6x7KgjljZworFhO4sFDfgIixrTIR2QXxzaHR7pGftzH1pZ9Sul6T4ojk2
 uwenFf4GMRbV9oY6b7zHLblMS1WidOHBEQLJsf8+Fc1CQm8XyyXrlFZsoLn7UUOr1KwW
 t20KwImUoO2NQ7wFYN7O1A6nlr5lLIgYPQh5ErvMgz5qRhW2rPtJrw8OEWTL+syi2cSt
 Wfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694500455; x=1695105255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=onWGGLkxM/AvYKworx+I2K8oIhrZGL/ZKUj+lLyqhF8=;
 b=GPssxD9bfFIMAYj0uUDAYo7p4WXZYKZkSNjCIgd3nzlBYKDbF/Magevi2TN1fAefaz
 qSX+0HCke3wpLRhms3JtT3vPA6AD9HJ/ojxaNWDQP8cCGkldFhrcPFRIHxBpM5r7WwI4
 PrDJYUY0FfhYQG8OrfOnFkEREyeSwJiXLUOiu5AvFPgjW/KuI7U0qoBD2bI5+VzWXVng
 pVh0nQhpgqbb2nHGqMHDKjY/74OQdLysJDm/fyKe2PT5ltpvvPZUQaexzn0fV8ivxQrP
 AUoXeH4L0WJ6lcZfMbLv260+apKiGv8cIiUdcOdC1dd4YrcwzBBLtC1X3KbAek3ig4fB
 fjxw==
X-Gm-Message-State: AOJu0YxBFyFRLlg4UkIOKvwgWvrSK6hQupFzES4GXcdyEVSauv34d1ty
 2iAgQLqhYeoIrPFaGJqVqla5uYoXx2He+1JK1QY=
X-Google-Smtp-Source: AGHT+IEwG7IMnlk+3dd3kF4c0WLSVq9R1hVLF/BsLH2QXtlnPrKs6PeB8dKvU882EYmGQINwqq0JjDdZ6Rkmw0N7RNM=
X-Received: by 2002:a05:620a:e92:b0:766:4a28:69ed with SMTP id
 w18-20020a05620a0e9200b007664a2869edmr11779876qkm.13.1694500455619; Mon, 11
 Sep 2023 23:34:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230717163855.7383-1-stephen.s.brennan@oracle.com>
 <20230717163855.7383-3-stephen.s.brennan@oracle.com>
 <CAJ+F1C+VFpU=xpqOPjJU1VLt4kofVqV8EN4pj5MjkkwWvVuxZw@mail.gmail.com>
 <87edl4d9wi.fsf@oracle.com> <87fs4aha4t.fsf@oracle.com>
 <CAJ+F1CKCdy3J8AD9EGvVO+CU6-yFPrLZ2Lum1SDgdj_kghFdQw@mail.gmail.com>
In-Reply-To: <CAJ+F1CKCdy3J8AD9EGvVO+CU6-yFPrLZ2Lum1SDgdj_kghFdQw@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 12 Sep 2023 10:34:04 +0400
Message-ID: <CAJ+F1CK0PTM-wHaK90EiuvvsG5OBVXQ4X8iV-AbBxdc6_=RvPQ@mail.gmail.com>
Subject: Re: [PATCH qemu 2/2] dump: Only use the makedumpfile flattened format
 when necessary
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, linux-debuggers@vger.kernel.org, 
 joao.m.martins@oracle.com, Richard Henderson <richard.henderson@linaro.org>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x72a.google.com
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

On Wed, Aug 23, 2023 at 2:03=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Wed, Aug 23, 2023 at 4:31=E2=80=AFAM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
> >
> > Stephen Brennan <stephen.s.brennan@oracle.com> writes:
> > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
> > >> I am a bit reluctant to change the dump format by default. But since=
 the
> > >> flatten format is more "complicated" than the "normal" format, perha=
ps we
> > >> can assume all users will handle it.
> > >>
> > >> The change is probably late for 8.1 though..
> > >
> > > Thank you for your review and testing!
> > >
> > > I totally understand the concern about making the change by default. =
I
> > > do believe that nobody should notice too much because the normal form=
at
> > > should be easier to work with, and more broadly compatible. I don't k=
now
> > > of any tool which deals with the flattened format that can't handle t=
he
> > > normal format, except for "makedumpfile -R" itself.
> > >
> > > If it's a blocker, I can go ahead and add a new flag to the command t=
o
> > > enable the behavior. However there are a few good justifications not =
to
> > > add a new flag. I think it's going to be difficult to explain the
> > > difference between the two formats in documentation, as the
> > > implementation of the formats is a bit "into the weeds". The libvirt =
API
> > > also specifies each format separately (kdump-zlib, kdump-lzo,
> > > kdump-snappy) and so adding several new options there would be
> > > unfortunate for end-users as well.
> > >
> > > At the end of the day, it's your judgment call, and I'll implement it
> > > how you prefer.
> >
> > I just wanted to check back on this to clarify the next step. Are you
> > satisfied with this and waiting to apply it until the right time? Or
> > would you prefer me to send a new version making this opt-in?
> >
>
> Nobody seems to raise concerns. If it would be just me, I would change
> it. But we should rather be safe, so let's make it this opt-in please.
>
>

Alex, Daniel, Thomas .. Do you have an opinion on changing the dump format?

Stephen, do you have a new version of the patches to make it opt-in?

thanks



--=20
Marc-Andr=C3=A9 Lureau


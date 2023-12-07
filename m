Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8783808B39
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 15:59:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBFpo-0003E7-CH; Thu, 07 Dec 2023 09:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <talhak2111@gmail.com>)
 id 1rBBC8-0005wL-Nv
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 05:01:24 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <talhak2111@gmail.com>)
 id 1rBBC7-0000zO-7o
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 05:01:24 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5d226f51f71so5076997b3.3
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 02:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701943276; x=1702548076; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oGpqZnZDjSFzvv3ic0waLr4K/O9G44Bc3lTA7DmFUVY=;
 b=hRXJE1JlLSxXVFx3GAjCd3J8RbpiXnl8hTGItquZlsid1sOkhetrsc+NRNmu3n+Jlq
 LDVmRFMq6nK61wZK0KJ9sv7YJPIb+b/391rq6aR/YowHMIY8MJi1u5Zu+XmRg7nZaLST
 QoyJQJvhmPswDsyvl23WydR5+XZMsCz/IH5Bs2XZ5RoVYi8IcYUuBhxkhO7RcWhybnn8
 ZZLqJggHiAgch0aDn6aDJOvZe58qNDMk3Tjd2U6tCXhJW5UzV2vz4pIVUsJUG3oZi50A
 lv0qYXdXTnD8t813Bq+4bCLhKZywug4QVFyWk/OzvqArAZOiFygtjiaF3PXT1WAg1MmN
 Rgsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701943276; x=1702548076;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oGpqZnZDjSFzvv3ic0waLr4K/O9G44Bc3lTA7DmFUVY=;
 b=ICJX1B+9o/Hd0xnG70UQPoqpf9TNrY1PCK7W/FZTCFa2nIithcjSft499jhbbC2VIP
 rjb6SULqVREnrvrcwR5dOIhtIqVY7UuGhcopt6ESMoTBnJKedsMfQnYDWy6tjzs4wYvP
 A36hjW/Sirsh50XPoD0qOIzZ+cy3yYtYGMEYn3kZzMyRXFg/zhMV7/uQiyS8P6hYCgFx
 GDxgJ1xdYs71qR5HoBe5oKsOs5tOQBw4jsQ3dyLR78HGs0KFzbPpCOSIUg52ierhzK+G
 yFhBM6OM04Gji6LJC7wb3NleX9earm5TXQMGSSNeFwS2CLiXkVgW9qdM7nRXr+kT3xOp
 kJQQ==
X-Gm-Message-State: AOJu0YxiCwoejidO7Ki+RYS/HKaOgrnBKqw57jAhPXgKZduZLPPSSiba
 UvYpCVvclAaqvlRE5ESZclIH8McWrBiVbvUuYiM675UH
X-Google-Smtp-Source: AGHT+IF1r5cSLn8YjWNauPlme82cYpN2OQhz3xZsWIt/F/GwfA0JRaRHWmvITQKFbrPRk0dAt6uz5By6xBJYlsuS1XQ=
X-Received: by 2002:a0d:ccce:0:b0:5a8:960d:e538 with SMTP id
 o197-20020a0dccce000000b005a8960de538mr2292536ywd.47.1701943276060; Thu, 07
 Dec 2023 02:01:16 -0800 (PST)
MIME-Version: 1.0
References: <CAMnsxbAr3GyB6bpvrYMt-31Q+ZKuEoLm+i++CWs6thQmQUXtVw@mail.gmail.com>
In-Reply-To: <CAMnsxbAr3GyB6bpvrYMt-31Q+ZKuEoLm+i++CWs6thQmQUXtVw@mail.gmail.com>
From: Talha Khan <talhak2111@gmail.com>
Date: Thu, 7 Dec 2023 15:31:04 +0530
Message-ID: <CAMnsxbB+yhePg60yd1x0MskJiQ1hBzwKpe94x8XQTDD5Jh2HPg@mail.gmail.com>
Subject: Re: Build qemu without USB,network devices
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000065c439060be88c43"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=talhak2111@gmail.com; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 07 Dec 2023 09:58:37 -0500
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

--00000000000065c439060be88c43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

And if this is not the right place to ask the question can someone point me
in the right direction or forum where i should ask this?

On Thu, Dec 7, 2023 at 1:27=E2=80=AFPM Talha Khan <talhak2111@gmail.com> wr=
ote:

> Hey all,
> I want to build qemu without network devices( nic ), usb and vga. So
> basically a very lightweight emulator without the things i need.
> Any help and leads would be appreciated.
> Yours Truly
> Talha
>

--00000000000065c439060be88c43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">And if this is not the right place to ask the question can=
 someone point me in the right direction or forum where i should ask this?<=
br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">On Thu, Dec 7, 2023 at 1:27=E2=80=AFPM Talha Khan &lt;<a href=3D"mailto:=
talhak2111@gmail.com">talhak2111@gmail.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>Hey all,</d=
iv><div>I want to build qemu without network devices( nic ), usb and vga. S=
o basically a very lightweight emulator without the things i need. <br></di=
v><div>Any help and leads would be appreciated.</div><div>Yours Truly</div>=
<div>Talha<br></div></div>
</blockquote></div>

--00000000000065c439060be88c43--


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA207F25E5
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 07:46:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5KVp-0006bI-VH; Tue, 21 Nov 2023 01:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r5KVj-0006az-RT
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 01:45:27 -0500
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1r5KVe-0004iL-FE
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 01:45:25 -0500
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-7bac330d396so1703139241.1
 for <qemu-devel@nongnu.org>; Mon, 20 Nov 2023 22:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700549119; x=1701153919; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M6u4chK15i/CtcJUlNb7t46hctwp7HufqyLKK/eSXIg=;
 b=bc6brjFDt9syuyGwSpcc/EyT8NJnoeydf3bKecpIdk0Fw2IOqsJMUGTVQURVkoLU9q
 R+LTIZ8u3K+cQXQkYTNWz96f51Z9QE9EmQ8RvK1tdhlv3IPX5rzFPUuMXmbAm4kzwoSI
 Kyys5TUE41aQEY6Nhe6X2ayTpFcGCn7drfe4Gu5XYDMjjAxoZ6bUrKMHr20cx4rBhq9t
 C8drBz9Vv79gXRCBlIBdDlCz+fJXYSjLMn4ZQfVbtNh25YoPE7JL7VERSnUZdGs4qNSh
 Mb3OADIatf3AcNhaOKNC56cV+3frtEJ93CBkCMgUd0pJ7zNRk5IRGwojJhYbftG9+8CU
 if1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700549119; x=1701153919;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M6u4chK15i/CtcJUlNb7t46hctwp7HufqyLKK/eSXIg=;
 b=gn9KHa3BtRKSlAh99jq1ii1C1d/cvlz4CudpL29ZTVnKSM4nx27bAl1l3hsqGg7Rsa
 L5ULjONFgdVZXKxy/w9X9qsDSs7TWQiiYxWZddEIwtul370NpeK2+SlTJpFszh1aMo0P
 8M4n9TY4fKZfEACg6BVB/KTtVNUEDkbbXe/DfaYYIpw4R7ukrUvYulKG1Ab29EOIliY2
 o5MrSceMm2ZFpWAodmxVQVoHPoulQT7Aq5EN5ZPD3cArxLRnNJ9v9auD6/SMQHG6zaDQ
 jxW16iCNARYhqJcuW7z1Qn4AZe5nwWa2MRZQoQzyfp3bWomw9Ra07pfgmVTd76meF20r
 7SGQ==
X-Gm-Message-State: AOJu0YweL/j3gecAWMobyBrySwLeS+XZcvoQ43ixY+ElP8kftVpdM60Q
 V1EX7Ta2BR7PJwRjoZ7rJXufXaM+7gSBgW+fnmS2DOqR50u8ZQ==
X-Google-Smtp-Source: AGHT+IE2DPp81GmWUTss82oy2RZQ0y/Nvk4voHG1jVuHXuIPjZpWd7LyIqTW80p2fMX+IhyqfXNij50wrGEuSZJiE9k=
X-Received: by 2002:a05:6102:4709:b0:45f:a41:b405 with SMTP id
 ei9-20020a056102470900b0045f0a41b405mr9668073vsb.21.1700549119560; Mon, 20
 Nov 2023 22:45:19 -0800 (PST)
MIME-Version: 1.0
References: <20231117141735.1511211-1-marcandre.lureau@redhat.com>
In-Reply-To: <20231117141735.1511211-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 21 Nov 2023 10:45:07 +0400
Message-ID: <CAJ+F1CKFWtor6nJfP35Ya3+AXc8zAAD3UZPPU5gW=J+2iWDhDQ@mail.gmail.com>
Subject: Re: [PATCH] vl: add missing display_remote++
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ua1-x934.google.com
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

Hi

On Fri, Nov 17, 2023 at 6:18=E2=80=AFPM <marcandre.lureau@redhat.com> wrote=
:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> We should also consider -display vnc=3D as setting up a remote display,
> and not attempt to add another default one.
>
> The display_remote++ in qemu_setup_display() isn't necessary at this
> point, but is there for completeness and further usages of the variable.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

It turns out this fixes a regression:
https://gitlab.com/qemu-project/qemu/-/issues/1988

Fixes: 484629fc81 ("vl: simplify display_remote logic ")

> ---
>  system/vl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/system/vl.c b/system/vl.c
> index 5af7ced2a1..f95ae77b5a 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -1110,6 +1110,7 @@ static void parse_display(const char *p)
>           */
>          if (*opts =3D=3D '=3D') {
>              vnc_parse(opts + 1);
> +            display_remote++;
>          } else {
>              error_report("VNC requires a display argument vnc=3D<display=
>");
>              exit(1);
> @@ -1359,6 +1360,7 @@ static void qemu_setup_display(void)
>              dpy.type =3D DISPLAY_TYPE_NONE;
>  #if defined(CONFIG_VNC)
>              vnc_parse("localhost:0,to=3D99,id=3Ddefault");
> +            display_remote++;
>  #endif
>          }
>      }
> --
> 2.41.0
>
>


--=20
Marc-Andr=C3=A9 Lureau


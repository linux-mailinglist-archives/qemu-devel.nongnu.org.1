Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F944784642
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 17:52:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTgD-00074X-S8; Tue, 22 Aug 2023 11:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qYTgB-00074K-Rx
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:52:27 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qYTg9-00034w-Q6
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:52:27 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3a5a7e7cd61so2472248b6e.0
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692719543; x=1693324343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kd2W0Yb4HzopopEBRMk2VWZ5RfC00CcPglE6Eqyndks=;
 b=p02PromxlPv70FpczFhbwSsc1T5ysNHKG0UiohKAFWvO6uLO5rvuEwX4TdiHUoS1m+
 ShRFCmtIzRJAL6d7xEV/bfdhuPRPKXmVm+RCBXrVtovMIiQHyUYi1674sPN1Ki2a8cwS
 vCGL9gPpIFE2MHLVgq4hMgj2sy+KgdkiV3Iu5hmh6evg/BOOLGTkZ6K4rcChJJwQdEpa
 rOwKt2kqDHgCYHWnUjec/s26lCcCv9UC9GrYZAqfu4WQV4U95NiAst05AUGQ1RxDpyTY
 bHg8KWOF++W+3Bke3w1+nKsDbC1p+5jUZaNlohzL3ao/xtP+5zzciWOAAoxmJX5l1egZ
 9iOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692719543; x=1693324343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kd2W0Yb4HzopopEBRMk2VWZ5RfC00CcPglE6Eqyndks=;
 b=Mm+kFqPhHa62fpVbmle46hMkuZXmPMTrY2VNuEOhcJ1G3X8z40aH5stKPgPiddXiLN
 h2ZrruSDfxmlI5mEJLCIb7LZ//iTBCSOhiYm8Hd9vdjQgqNFj5yyYGhxn3SAjKVrhi93
 yGxDDBZw8dPDTlO0M3DSnNh2NC7K1MBT2LtFxbEdg8paG7685FavAqOMK4pZPIi5inyq
 7M6HfW8sX+2+5s1n/Of7ur9+/mX2VZH8g0Fo6WVf8RViGTXcwUYeHWhpnGhLcBSHCegX
 9j++pwqUCl2cfrI4NJHGufc62GrtyRBEDCCMbmezJoVu+MoaVVXJ9iCNzJWajF8a3C5R
 fprA==
X-Gm-Message-State: AOJu0Yzom0D0oiTzG+McMAuXuiu0DpC9VUASj+WQwI6u7iIFWhH6fRUW
 lk1fdTB3hcyKi9GANML1UpPm1sEk2+CuiBeDR4U=
X-Google-Smtp-Source: AGHT+IEjRMG95bBL/VpwPo5aTVD1wHcwotDxuLjhiyTTAZLEMXL9+dcHohHO87bEuM8UiYM+9i8HBVrbsd8OHmyiFPc=
X-Received: by 2002:a05:6808:1388:b0:3a8:18d2:1e22 with SMTP id
 c8-20020a056808138800b003a818d21e22mr7529535oiw.11.1692719543346; Tue, 22 Aug
 2023 08:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230822155004.1158931-1-alex.bennee@linaro.org>
In-Reply-To: <20230822155004.1158931-1-alex.bennee@linaro.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 22 Aug 2023 11:52:11 -0400
Message-ID: <CAJSP0QXpFuWf6kaMt3nVuMH1khzrpBu3i9LkUnP3UiFf2Ohwrw@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/style: permit inline loop variables
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=stefanha@gmail.com; helo=mail-oi1-x22a.google.com
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

On Tue, 22 Aug 2023 at 11:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> I've already wasted enough of my time debugging aliased variables in
> deeply nested loops. While not scattering variable declarations around
> is a good aim I think we can make an exception for stuff used inside a
> loop.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/devel/style.rst | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

>
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index 3cfcdeb9cd..2f68b50079 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -204,7 +204,14 @@ Declarations
>
>  Mixed declarations (interleaving statements and declarations within
>  blocks) are generally not allowed; declarations should be at the beginni=
ng
> -of blocks.
> +of blocks. To avoid accidental re-use it is permissible to declare
> +loop variables inside for loops:
> +
> +.. code-block:: c
> +
> +    for (int i =3D 0; i < ARRAY_SIZE(thing); i++) {
> +        /* do something loopy */
> +    }
>
>  Every now and then, an exception is made for declarations inside a
>  #ifdef or #ifndef block: if the code looks nicer, such declarations can
> --
> 2.39.2
>
>


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5B078701E
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 15:20:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZAF3-00020q-77; Thu, 24 Aug 2023 09:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZAEu-0001yv-Rx
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 09:19:08 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZAEs-0002sd-FT
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 09:19:08 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4ff8a1746e0so10398480e87.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 06:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692883144; x=1693487944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Moo8cDcdvHf0qm7ia/7M+vakxIi5DcjaqjQsftVoRAw=;
 b=odcHVDIFWFES5btDrGisbcuSbTaRFHZbZ0LWdX7LoDLW6vi8r6E/dCafSCOaqQKeKI
 9ngpQOSb8mCKTaYf2tS7A1Dg2WqabM2oxz2ceyPeAF8HN1AEaQ0EhzYMsG7F1c0nMDza
 ijsl6oHSxGz8Bl0ulC4NZaGqbgOKhbnvaRGc3heGC7D40VtqgCsOY4D4WdKwg6pupT4a
 UaMj0xTKUTjxzyOm9LpYVkDXK4nmeUPz2XWbUq2Qb6aUFvsvNwyLw2lBmJp1KzGY3OaF
 61PLgksUMKAGu7sc7u5gQ4zgtIn8qriWZZNKd2aGkcvBsaKLwyerO7brH1YcsXPZ/Lz7
 dlpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692883144; x=1693487944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Moo8cDcdvHf0qm7ia/7M+vakxIi5DcjaqjQsftVoRAw=;
 b=HNo7JCMDATuQA0SfCluXZSMq0+LS+npq410bJfVhvuHJtI706RLwCj+0uf/dJBdb2a
 j5ULwvBztNtuTswzbHag1iH7HpoPIJeruXKvCYEiGukEJa6TP1j8rAF2MIdI0KCr8ZID
 BNiG3bczimonGe91pZgrfwUZUm6pIYXXmcZJgLmBVfQonXQYEb6lxD05cfNbn+l5fcsW
 hzOQuW3Ma9PZylFivXUbiW5v3blWnzyL5Em/JLm1ugy6/RyifCJg9c0TTEQcu5TAYh4b
 RV9jYkFdgsQNtqTP1yXZrNtcFbhuFthKmqp8YPr/8TAIolIem/U0d4Niz+hTo/zwt0bN
 aP1g==
X-Gm-Message-State: AOJu0YyOQ2Pd/VtnnW6Ex5mdWIKUwfHgn9mifHwGRRnywlN2JKokT7Rz
 7nneJ9uuFbw7ax0VhWVtrOtBNvxXQ9FGL+VkgoTIl06SsehsgnLH
X-Google-Smtp-Source: AGHT+IEt6+3pEzgAc94Vc2LGTnwTvuCf5+MkkIRblsnwidlzzQXIKuXG4PBXfIFEaG3X86OSi9UjuDSwEe/1gC0YVM4=
X-Received: by 2002:a05:6512:2038:b0:500:a2ad:bb2 with SMTP id
 s24-20020a056512203800b00500a2ad0bb2mr678257lfs.35.1692883144441; Thu, 24 Aug
 2023 06:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230822155004.1158931-1-alex.bennee@linaro.org>
 <CAFEAcA8_tqboXDen6OPY-AeZ3BY7p3vYMeG77YQJ=cKA_GRMaQ@mail.gmail.com>
 <87jztmz4bu.fsf@pond.sub.org>
In-Reply-To: <87jztmz4bu.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Aug 2023 14:18:53 +0100
Message-ID: <CAFEAcA8wobO5F16vYhbQCjeadfN5Zwx5CQ7L4vQ3fh8c_6ngJg@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/style: permit inline loop variables
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 23 Aug 2023 at 06:59, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Tue, 22 Aug 2023 at 16:50, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >> I've already wasted enough of my time debugging aliased variables in
> >> deeply nested loops.
> >
> > In theory we could try to enable -Wshadow and deal with
> > all the existing cases of aliasing, which would then
> > allow us to turn it into an error and catch your bugs :-)
>
> In practice, a quick compile with -Wshadow -Wno-error=3Dshadow coughs up
> almost 6000 warnings.  There are duplicates since we compile many files
> multiple times, so I piped through sort -u | wc -l, and got about 1200.

-Wshadow=3Dlocal has only 211 non-duplicate warnings, which
is almost tractable...

(A lot of the duplicates are from local variables declared in macros
like MAX(), MIN() and QOBJECT(), when those macros are used in a nested
way, like MIN(MIN(x,y),z). We could deal with those by using the
__COUNTER__ trick, I guess.)

-- PMM


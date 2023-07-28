Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE767670D8
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 17:44:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPPAZ-0007CU-TK; Fri, 28 Jul 2023 11:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPPAS-00076U-Bn
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 11:14:15 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPPAM-0004jG-HD
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 11:14:08 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5222bc91838so3006521a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 08:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690557239; x=1691162039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QqW0uEQu3PEVo0JJ/G3xlN537a/9d5SWJwlkmmRfwGg=;
 b=uQWYfvaz11pQC7HyaJqYnOvc6WbHnry7ACiDBEeYyvAMjGcdOdNMXU8FoCpfjnO8eI
 8YtBdtW5ATRJUMtpjdB0eokKSwPSKycJntW07AFBMNYYeWEBntGNKNdMqhkTwQN/xfF4
 cVqII1DnWjueDXU+yxvwsxsEMMaXv0GxGtd4SbBEOWTa6ct8gcQUdjd8S76hr1+FK6GZ
 fDizjDlmaJFDLcLWsQi8TBs/F5fl0rBqOsWB8zPbvXlUiIsFtS2VMtI95dmB1N0f7BRP
 gGN0TDF+5XYZ6K7JHI9eaIj28xp5jSqoQ64Oz/2m4sAA4xXJ2vuAiyV8cjIIjpesMPAd
 G0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690557239; x=1691162039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QqW0uEQu3PEVo0JJ/G3xlN537a/9d5SWJwlkmmRfwGg=;
 b=kVQUsQJjKf+MLgWTLFT6pWbSa7IylF3Fb8l37wXXjn78/yBEvMHo0QsHahTT+762l4
 iWLb1XfZW+6TTuZWTeCgenIHhqakzsWRtO5SxdPGzedUXiPo428migYCwQJF3weDtRwE
 okzGiNnpjiw3ZwolAuaQA3RjbDeX708YpW+LuxFZzMfjyZHjuNjHzt5PAjeZCZIjC/QK
 VVopaTcQRjZ8ypBX6vWnSefXEpbzxHEj61P+InchzhaAWN5Hs7j/JzaUrGrh7zc3LOns
 NQJx2+Y/B2kPOt9K7ZSg8mfpioy0vHvcjYo6M+XdtuLJit4lllWnrg+ZVt/rzHbatRjL
 ZCRQ==
X-Gm-Message-State: ABy/qLYRw19iFSvew1Mq4DjQyq75y4AoVuuyUv3W00pkeOjzGAnadEx2
 /FZfhhO7g/HjMa9CvcN+//RBC+e1aJBmVJPjE5ZUfQ==
X-Google-Smtp-Source: APBJJlFY+fW4qoq1+Gi+xJGieW0+Ihy7fZQtYptLpqsoKyWh0E/tshnAsqTpTjxZq77T/QW4rAwZGd6GRwxqE06WPw0=
X-Received: by 2002:a05:6402:78e:b0:522:1fb4:1c6b with SMTP id
 d14-20020a056402078e00b005221fb41c6bmr2097210edy.23.1690557239426; Fri, 28
 Jul 2023 08:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230728142748.305341-1-thuth@redhat.com>
 <20230728142748.305341-6-thuth@redhat.com>
In-Reply-To: <20230728142748.305341-6-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2023 16:13:48 +0100
Message-ID: <CAFEAcA9PuwSzaWXJYrF9PTs8Yz9oG6_sUY=p7S5rnx6NiS1HeQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] include/qemu/compiler: Fix problem with
 gcc_struct and Clang
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Stefan Weil <sw@weilnetz.de>, Yonggang Luo <luoyonggang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 28 Jul 2023 at 15:28, Thomas Huth <thuth@redhat.com> wrote:
>
> Clang on Windows does not seem to know the "gcc_struct" attribute
> and emits a warning when we try to use it. Add an additional check
> here with __has_attribute() to avoid this problem.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  include/qemu/compiler.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index a309f90c76..5065b4447c 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -22,7 +22,7 @@
>  #define QEMU_EXTERN_C extern
>  #endif
>
> -#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__))
> +#if defined(_WIN32) && (defined(__x86_64__) || defined(__i386__)) && !defined(__clang__)
>  # define QEMU_PACKED __attribute__((gcc_struct, packed))
>  #else
>  # define QEMU_PACKED __attribute__((packed))

I'm not sure about this. The idea of QEMU_PACKED is that
it's supposed to give you the same struct layout
regardless of compiler. With this change it no longer
does that, and there's no compile-time guard against
using something in a packed struct that has a different
layout on Windows clang vs everything else.

If it was OK to use plain attribute(packed) we wouldn't
need the ifdef at all because we could use it on GCC too.

thanks
-- PMM


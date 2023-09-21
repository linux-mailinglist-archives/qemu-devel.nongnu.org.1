Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4D27A9390
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 12:22:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjGoc-0008Gg-DN; Thu, 21 Sep 2023 06:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjGoS-0008GC-Ip
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 06:21:36 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qjGoQ-0006CT-TC
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 06:21:36 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2c012232792so12939911fa.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 03:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695291693; x=1695896493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tTmfuhXjULK1UxM7hF3sQgzzTcEhrxV7YsCyyhDgqwE=;
 b=NpRGEK/i09CvMRiQEgcgz9y7JUe1MMMgR7fLYmZBRSGkpVpsDECkpvRxTTaR+jmtH2
 mMofDnpkjW6lyerD+jS+YPrNCSUkgOjZVhj2V6cfOaKSP5vMWqt9g7FB0a+/UmM8UvgI
 uMyS32xig05svy0uAp9mqiAiSUrO9WN12eZS7dnaG+XeVT3914bVswi4eV9g+EHWEkRp
 q5cHr3y+hRP+6P83UFsT2B6HVHhF2rpeok2PRdXrQbTca0a0OqGsrm9CmSxVXpcm9Mho
 mRyKJQ1YhaWRrLEnJ1imWB9zvMlqjAjD33J6zm7fl3W386CYM/UuZmBdFSVBFUrqg/QP
 PppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695291693; x=1695896493;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tTmfuhXjULK1UxM7hF3sQgzzTcEhrxV7YsCyyhDgqwE=;
 b=cOjYmOuHJ5ztdx8GlO/9DkDCpZKtRhtZvdLB8FZHbvaEcQdEHe/U/2W/IebKpuxrkX
 h7CAFjhJUR6hEggG43EVlT6AFgq8TfeQRHzswIdwTBPuBL5pkqBx2eb2ZJ7D3qHKoQsx
 6AV2myIep1AWHplugHYPrZqHMvbjspYJbPqIm2I1SVA7EipkDBbCpItMwHAjTx5xsaTl
 fdqh7+6FVV06I+nnp1i75oJtZ9/rtqvqxNUBqjKnx0E2uB6a2CpaoJx9NjCFaT0+LFDP
 7hFWFpV0k4xS/t/iUnm0aJaOPE2KakoPFucCAjZ9+aTQgsJHcz1hPDvq9r0IGGHbZJx6
 VF1w==
X-Gm-Message-State: AOJu0YznYNohbgwdIprUCJqmOLzYWYZC353+6KOpK1RxhSy7mRUFXZnL
 85OSSaPDnF/aNps5c3uZ5rV7Mw==
X-Google-Smtp-Source: AGHT+IEERV6iQ6qmmSnJbYUGzaIw2fBHpBYYZuWbkowsou248hOgYN22iLchIXej99CUjLn1D62koQ==
X-Received: by 2002:a2e:9457:0:b0:2bd:c3d:1dd5 with SMTP id
 o23-20020a2e9457000000b002bd0c3d1dd5mr4222240ljh.32.1695291692909; 
 Thu, 21 Sep 2023 03:21:32 -0700 (PDT)
Received: from [172.20.41.70] (static-212-193-78-212.thenetworkfactory.nl.
 [212.78.193.212]) by smtp.gmail.com with ESMTPSA id
 h1-20020a1709063c0100b0099bc038eb2bsm820045ejg.58.2023.09.21.03.21.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 03:21:32 -0700 (PDT)
Message-ID: <2d127900-9d75-affb-34fa-2c1b7bc3b44b@linaro.org>
Date: Thu, 21 Sep 2023 12:21:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] cutils: Fix get_relocated_path on Windows
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang
 <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
References: <20221031005908.3393-1-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221031005908.3393-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 31/10/22 01:59, Akihiko Odaki wrote:
> get_relocated_path() did not have error handling for PathCchSkipRoot()
> because a path given to get_relocated_path() was expected to be a valid
> path containing a drive letter or UNC server/share path elements on
> Windows, but sometimes it turned out otherwise.
> 
> The paths passed to get_relocated_path() are defined by macros generated
> by Meson. Meson in turn uses a prefix given by the configure script to
> generate them. For Windows, the script passes /qemu as a prefix to
> Meson by default.
> 
> As documented in docs/about/build-platforms.rst, typically MSYS2 is used
> for the build system, but it is also possible to use Linux as well. When
> MSYS2 is used, its Bash variant recognizes /qemu as a MSYS2 path, and
> converts it to a Windows path, adding the MSYS2 prefix including a drive
> letter or UNC server/share path elements. Such a conversion does not
> happen on a shell on Linux however, and /qemu will be passed as is in
> the case.
> 
> Implement a proper error handling of PathCchSkipRoot() in
> get_relocated_path() so that it can handle a path without a drive letter
> or UNC server/share path elements.
> 
> Reported-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   util/cutils.c | 18 +++++++++++-------
>   1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/util/cutils.c b/util/cutils.c
> index cb43dda213..932c741d2b 100644
> --- a/util/cutils.c
> +++ b/util/cutils.c
> @@ -1088,17 +1088,21 @@ char *get_relocated_path(const char *dir)
>       g_string_append(result, "/qemu-bundle");
>       if (access(result->str, R_OK) == 0) {
>   #ifdef G_OS_WIN32
> -        size_t size = mbsrtowcs(NULL, &dir, 0, &(mbstate_t){0}) + 1;
> +        const char *src = dir;
> +        size_t size = mbsrtowcs(NULL, &src, 0, &(mbstate_t){0}) + 1;
>           PWSTR wdir = g_new(WCHAR, size);
> -        mbsrtowcs(wdir, &dir, size, &(mbstate_t){0});
> +        mbsrtowcs(wdir, &src, size, &(mbstate_t){0});
>   
>           PCWSTR wdir_skipped_root;
> -        PathCchSkipRoot(wdir, &wdir_skipped_root);
> +        if (PathCchSkipRoot(wdir, &wdir_skipped_root)) {

Maybe for clarity this is the error path:

   if (PathCchSkipRoot(wdir, &wdir_skipped_root) != S_OK) {

Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +            g_string_append(result, dir);
> +        } else {
> +            size = wcsrtombs(NULL, &wdir_skipped_root, 0, &(mbstate_t){0});
> +            char *cursor = result->str + result->len;
> +            g_string_set_size(result, result->len + size);
> +            wcsrtombs(cursor, &wdir_skipped_root, size + 1, &(mbstate_t){0});
> +        }
>   
> -        size = wcsrtombs(NULL, &wdir_skipped_root, 0, &(mbstate_t){0});
> -        char *cursor = result->str + result->len;
> -        g_string_set_size(result, result->len + size);
> -        wcsrtombs(cursor, &wdir_skipped_root, size + 1, &(mbstate_t){0});
>           g_free(wdir);
>   #else
>           g_string_append(result, dir);



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E357A9284
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 10:12:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjElr-0003ZQ-WE; Thu, 21 Sep 2023 04:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjEll-0003X9-S5
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:10:43 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qjElk-0004cp-3W
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 04:10:41 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-690bfd4f3ebso522069b3a.3
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 01:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1695283838; x=1695888638;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8e65L93qkbtY1qk0JNfRwLRDJPlhtTbjlBgXKAt3sbo=;
 b=jqppYsuXPUJ01u6nzo0wUJu/IZTz7d/wOvinuTpte1INmBks7WLIR3pa1ew594ciDO
 5BU9eoR4f3q+Cp/hYV6gfjwRBS+RncmRjMM/a5n/oP9WgN8tp8FlcPRD2HThNI8/yy68
 EFlLq74K9zArrBDo5CrKtNSRw/xbsDw7++vLphGaQn35g0lBxN9D9EM4ldiDPMlQ1plp
 mqAYWrM8A2zrfjmVxS3JLGB5gJl/HJwqJYrJdqdVY3sa1dz5PVp77gT18xONkeMsSWbI
 VxAa/rTAnfQIUOlRXPK6DXv//cGIzK/tZU2ZSJp242nvdLumYaPprBmvW4Ow6iC7ClQt
 n/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695283838; x=1695888638;
 h=content-transfer-encoding:in-reply-to:from:references:cc
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8e65L93qkbtY1qk0JNfRwLRDJPlhtTbjlBgXKAt3sbo=;
 b=gXEAdE0GvepaCJSrVa/IQdTbZaJfrpx7n075pkCT+MNItRyY6su/dpdZFn8lEANmjC
 u5b/TKXQvOP0cnjLs0Jid0umKEihGwHTCVgrbFWZFAYP1JVFidezQxVUdO2RfkTDLbrg
 VgviVc3TTRjkY8ubcbbWMgvIlqsQvzXbdTUIlOqChUpFLJdhmI9P5eUx/jLXDU8djm6F
 FC097n6nvC9y0Y/7mZymkz/BOmdBYmmST9FSfa1R3jAIM5KROxSRnm+uf1BuOQtk7LPH
 OfO37552Gya8LEDzMPiSXAzq/wQiSXrJFEbJ9jsDG/5i5PdBF8Sab61tnamX8eNFIxDE
 6UnQ==
X-Gm-Message-State: AOJu0YyaAv9gtHFk2Gicv+ylD3ny+Y3k59Xop00DlKQZXGtqgQGe76OX
 YsZnYLDKGAybI0HyyriVpGr1WA==
X-Google-Smtp-Source: AGHT+IHN2yCtyFPVA3z4Zpmy2MOJheoDzpaXDiIKjlBZB80yQaAeoJt4AafaM7xoRzUZx0j/CgRzAw==
X-Received: by 2002:a05:6a20:d417:b0:15d:3a20:d87d with SMTP id
 il23-20020a056a20d41700b0015d3a20d87dmr996256pzb.61.1695283838545; 
 Thu, 21 Sep 2023 01:10:38 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 z1-20020a170902708100b001bb0eebd90asm791244plk.245.2023.09.21.01.10.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 01:10:38 -0700 (PDT)
Message-ID: <4dc445cd-20e5-4763-9415-5ee941f65720@daynix.com>
Date: Thu, 21 Sep 2023 17:10:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cutils: Fix get_relocated_path on Windows
Content-Language: en-US
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang
 <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
References: <20221031005908.3393-1-akihiko.odaki@daynix.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20221031005908.3393-1-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

On 2022/10/31 9:59, Akihiko Odaki wrote:
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

Hi,

Can anyone have a look at this patch?

Regards,
Akihiko Odaki


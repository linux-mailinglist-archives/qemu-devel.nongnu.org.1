Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 471C078D372
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 08:59:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbFAL-0005jM-07; Wed, 30 Aug 2023 02:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbFAJ-0005jD-1O
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 02:58:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qbFAF-0002zK-2b
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 02:58:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693378733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yv8xpHUrTB2RFEJWhFkP/tCK917WqL0ZkqjFMFMF6/g=;
 b=SP+7wVKhir8j8Hul4mfE6ekamUkXK+XBnpDSKxjVLeJAI+WemgnwYh+4UGBiwjybezlRu1
 r+sLcr6/bdo/2fTOWobezN8I3eQE6rnh84QTxp4XtFFxied2brUZz6zHHyNqu4MDIf3n57
 S3ZBROHqbqcSEAHFCFBcc1OeWZH+Zdc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-hN_QRPqQMaOlgts21mKU2w-1; Wed, 30 Aug 2023 02:58:51 -0400
X-MC-Unique: hN_QRPqQMaOlgts21mKU2w-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31c554c8867so3244506f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 23:58:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693378731; x=1693983531;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yv8xpHUrTB2RFEJWhFkP/tCK917WqL0ZkqjFMFMF6/g=;
 b=HdbdVDbGdFeHmBlru9Y6x7lhwjc+k9zDoBKlukq8uFYR0VOB1vJcDLp6V2raEiK/5K
 4ndwICjX35HHlp2hO2aZyuEFf+0/fEwI0lPOwsXYQUEK9ZpMNqH7aD/ewQ19kDPEWWem
 0QdT+6uI1eNl1W/WSl+E0Rg7rw+imF1d11OXdX+PquIDMgXyO/gi+305T48HJ2hWvnXh
 Y7bUZAd5n5BiWRQUJ6f6tGkTW1UxrJQ1ZNNmDhD7A/e+SqTsYsZW73IJ9Vg5luaTzP+t
 4vgSbblGlxFlTSWhfAWkVSf9y1Beblw/QbMNoPrMVyyzYWZ8cIxf+9UI8tKPIU7f/VWX
 hj1w==
X-Gm-Message-State: AOJu0Yy5nMdzaMcC72F910P+PwXTEZ/lssgGLMYJYbYFALOeTbjF4eFS
 knuUvC6RAm9ru+ziknFNr3yOpsyGp+jor2qkm77PNYEeEKdW2v+IE1oEa5ZUz+rHd5kHPIuUHuk
 kw2SEn6/VnxxL8OU=
X-Received: by 2002:a5d:4049:0:b0:31c:3136:60af with SMTP id
 w9-20020a5d4049000000b0031c313660afmr883499wrp.61.1693378730827; 
 Tue, 29 Aug 2023 23:58:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfXo25NO+pMMhsndADsr9U5TjTr3xnghFlRZJNsPxz90lncKwkNW7ewhq9R7q9CH48/i+OtQ==
X-Received: by 2002:a5d:4049:0:b0:31c:3136:60af with SMTP id
 w9-20020a5d4049000000b0031c313660afmr883490wrp.61.1693378730453; 
 Tue, 29 Aug 2023 23:58:50 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-145.web.vodafone.de.
 [109.43.179.145]) by smtp.gmail.com with ESMTPSA id
 n9-20020a5d6609000000b0030647449730sm15681021wru.74.2023.08.29.23.58.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 23:58:49 -0700 (PDT)
Message-ID: <fa076f54-2aad-2838-3bc2-6b4fea571b8a@redhat.com>
Date: Wed, 30 Aug 2023 08:58:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] linux-user: Move PRAGMA_DISABLE_PACKED_WARNING to
 compiler.h
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Beraldo Leal <bleal@redhat.com>
References: <20230829184509.54434-1-imp@bsdimp.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230829184509.54434-1-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.242, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 29/08/2023 20.45, Warner Losh wrote:
> Replace the slightly older version of this in include/qemu/compiler.h
> that was commit as part of bsd-user changes with the newer one from

s/commit/committed/ ?

> linux-user. bsd-user has no regreassions with this.

s/regreassions/regressions/
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> ---
>   include/qemu/compiler.h  |  3 +--
>   linux-user/qemu.h        | 26 --------------------------
>   tests/lcitool/libvirt-ci |  2 +-
>   3 files changed, 2 insertions(+), 29 deletions(-)
> 
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index b0374425180..9496a65ea57 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -38,10 +38,9 @@
>    *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 -- so we only
>    *   include the warning-suppression pragmas for clang
>    */
> -#ifdef __clang__
> +#if defined(__clang__) && __has_warning("-Waddress-of-packed-member")
>   #define PRAGMA_DISABLE_PACKED_WARNING                                   \
>       _Pragma("GCC diagnostic push");                                     \
> -    _Pragma("GCC diagnostic ignored \"-Wpragmas\"");                    \
>       _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"")
>   
>   #define PRAGMA_REENABLE_PACKED_WARNING          \
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 4f8b55e2fb0..12821e54d0a 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -193,32 +193,6 @@ static inline bool access_ok(CPUState *cpu, int type,
>      These are usually used to access struct data members once the struct has
>      been locked - usually with lock_user_struct.  */
>   
> -/*
> - * Tricky points:
> - * - Use __builtin_choose_expr to avoid type promotion from ?:,
> - * - Invalid sizes result in a compile time error stemming from
> - *   the fact that abort has no parameters.
> - * - It's easier to use the endian-specific unaligned load/store
> - *   functions than host-endian unaligned load/store plus tswapN.
> - * - The pragmas are necessary only to silence a clang false-positive
> - *   warning: see https://bugs.llvm.org/show_bug.cgi?id=39113 .
> - * - gcc has bugs in its _Pragma() support in some versions, eg
> - *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=83256 -- so we only
> - *   include the warning-suppression pragmas for clang
> - */
> -#if defined(__clang__) && __has_warning("-Waddress-of-packed-member")
> -#define PRAGMA_DISABLE_PACKED_WARNING                                   \
> -    _Pragma("GCC diagnostic push");                                     \
> -    _Pragma("GCC diagnostic ignored \"-Waddress-of-packed-member\"")
> -
> -#define PRAGMA_REENABLE_PACKED_WARNING          \
> -    _Pragma("GCC diagnostic pop")
> -
> -#else
> -#define PRAGMA_DISABLE_PACKED_WARNING
> -#define PRAGMA_REENABLE_PACKED_WARNING
> -#endif
> -
>   #define __put_user_e(x, hptr, e)                                            \
>       do {                                                                    \
>           PRAGMA_DISABLE_PACKED_WARNING;                                      \
> diff --git a/tests/lcitool/libvirt-ci b/tests/lcitool/libvirt-ci
> index bbd55b4d18c..9bff3b763b5 160000
> --- a/tests/lcitool/libvirt-ci
> +++ b/tests/lcitool/libvirt-ci
> @@ -1 +1 @@
> -Subproject commit bbd55b4d18cce8f89b5167675e434a6941315634
> +Subproject commit 9bff3b763b5531a1490e238bfbf77306dc3a6dbb

Accidentially committed the libvirt-ci submodule change?

  Thomas



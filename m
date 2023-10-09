Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4603C7BD692
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:17:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmNd-0005kk-5q; Mon, 09 Oct 2023 05:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpmNb-0005kV-22
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:16:47 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpmNZ-0000B5-1d
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:16:46 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c6219307b2so24960535ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696843003; x=1697447803;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OWSHfyAjW797A519M/6pFLZSbKbkwJmCFgKutmPS5SE=;
 b=dChkYhxSRZ3ESeR16Fsqj4t1q1x3PQpRCSRA2+fLYJUx9GGGmjFCojC/PajDc/mm5W
 0zNpiQIKqVh7OmTIzcpdMTst1L+86nz9M8/7PyLuKZ5y7uK7zbhksFl2Ml7DKOESpguv
 /nG9xbwRzIVre+Gcyl+qNDIpn8TBwt9tXZtg0uoeowLGkqoV93Q6SkzxQb0BHSGHv+0x
 sLzTwY1AqpLRhTvd4+IMlDj9QKCgT4O8vdmJcsak5vkYUlNjegFxd771Z1POTAbuPi9b
 mP9l9uJyFddYRbN/XvwFlBbkiyEFUvItnTDJ6ly14leLv8b0jf+n2FN62W/X8FsFK2dK
 jbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696843003; x=1697447803;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OWSHfyAjW797A519M/6pFLZSbKbkwJmCFgKutmPS5SE=;
 b=FVwVbsasROq8GXE4K74E1X0hdR/lu2sBW3xK2EYmZzUWjo68kjFyG6P/RuBgPMRDaj
 ck3AMdqYKCTTGxtUbW9KnMIGNuT8MfyDFs8ynYAivm0ZTQ9nOT6k1WIFvbH7BFtKnJtD
 12dkGNo6LNtskwMWcW/Isy5oWpfH5CTLyY/uXy8igNI7uB78karNIfLR7QWMuQh3xYPP
 5E40GYKoQluTH3a3T8Fj142VovhO4PknJryw1ga6I3fdNapYvOnatPS51Wr4nsSd74xA
 xL3Ci7jc+JtkuCU4EFxsNebokiB7P3CVAAr32tGZNXIfs9HmV2qy0+b9cpTVtewRyRLW
 jsXA==
X-Gm-Message-State: AOJu0YwQnfm9thdr3pm9ReNZ2xVUVwVfzDvd+YfIFcBzmCCxmCgqLYHN
 oCFdt9xFdHO22PBfQjsfHWbw0w==
X-Google-Smtp-Source: AGHT+IHmJajEdNIMmiRl8mzOqZ8tqWtSoSa/kPfSajRgzlWshRecs81DLkrQhHb8qjN0+VbrDd9N3Q==
X-Received: by 2002:a17:902:db10:b0:1bd:f7d7:3bcd with SMTP id
 m16-20020a170902db1000b001bdf7d73bcdmr12991560plx.50.1696843003104; 
 Mon, 09 Oct 2023 02:16:43 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 j5-20020a170902c3c500b001c61bde04a7sm4672492plj.276.2023.10.09.02.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 02:16:42 -0700 (PDT)
Message-ID: <9f000212-5389-4146-a472-40173054eaf8@daynix.com>
Date: Mon, 9 Oct 2023 18:16:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] buildsys: Only display Objective-C information when
 Objective-C is used
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20231009091356.48713-1-philmd@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231009091356.48713-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62e;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/09 18:13, Philippe Mathieu-Daudé wrote:
> When configuring with '--disable-cocoa --disable-coreaudio'
> on Darwin, we get:
> 
>   meson.build:4081:58: ERROR: Tried to access compiler for language "objc", not specified for host machine.
>   meson.build:4097:47: ERROR: Tried to access unknown option 'objc_args'.
> 
> Instead of unconditionally display Objective-C informations
> on Darwin, display them when Objective-C is discovered.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 3bb64b536c..da1a9a7228 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4074,7 +4074,7 @@ if 'cpp' in all_languages
>   else
>     summary_info += {'C++ compiler':      false}
>   endif
> -if targetos == 'darwin'
> +if 'objc' in all_languages
>     summary_info += {'Objective-C compiler': ' '.join(meson.get_compiler('objc').cmd_array())}
>   endif

Probably it's more kind if it emits "Objective-C compiler: false" as it 
does for C++ when the compiler is not available.


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DFA7BD751
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:39:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmjP-0006Xu-Ub; Mon, 09 Oct 2023 05:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpmjL-0006WP-FA
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:39:15 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qpmjJ-000491-22
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:39:15 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-694ed84c981so3125017b3a.3
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696844351; x=1697449151;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BBt1yqvrabi75E1uHNkR2i07wsB4oaOAADSQopZEWcU=;
 b=hIK003wygUuQN/Mswkg2a46c43ek4bG+WnaRV2ZmV+1JNBoCp9WzpsbI9rBWAgS6SZ
 ZkEU/ai7Ey5L9iKemGRbP//ersKT9mubZmSo6Y++nTNmdYsXb5Ao/u7z5g7piwEIS8M1
 vBjIRtQSWd8td9rtbLZNXiy0roks5/zOASUDO30B1Lb0UYp0aam2BxTrZdd1OhrX1cxf
 iSebPm7FLlTVrOg0o9EM9vJHQvFM5/pDVflcJYUMSSbw5aPMenKCgumcKAYBmP4B0Dd/
 wOU69+9xWxPnXoPgOQlGw735SA5eJpKgllLR3GxHI3AU6qCVIllf40KUvbYNOIL1hdtR
 +Bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696844351; x=1697449151;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BBt1yqvrabi75E1uHNkR2i07wsB4oaOAADSQopZEWcU=;
 b=ce3oIg5dN1y72lAEJ9K1ds0SAJGcqViKRWjZ0BnCy3J3MlxVnJIm5XmxWBIEmCNACX
 Vn7pKGVkpabvJgsUaH8RAM/eLtjTdKpSrQUOr3elXnAUrFWdwMLCvlhFzCO+o5hzRlhP
 4POyQLJQo2+8WuVcrBQW9I30PrFa381qC1dpZ3V5M5wAkQAmVEXUjxEgiXw2ko1rgpsy
 kF2Ln83MZMplnRf3j2JOxLGWEzi5UsaERmeHDg3LfxiBTBJr8xZbVFqbTTJdGPgT/GZ1
 kxQi1/N+djbyK5pEVW9ifbiCDFo2ibtkBbrzRoJ7JqJxYUgwFS52DclydKm9p4NvTrkZ
 q4Zg==
X-Gm-Message-State: AOJu0YxLdJxKorjUaBpzZaSaIBXZwuCMPhXAGfQlWX1idpTpqnGzdKlU
 YZkwUHep4jgTBZy5cintG1BiC7kBnLXuiJh/5YCPFg==
X-Google-Smtp-Source: AGHT+IElNR9vopIExUVlz3F0qr2yx4zRFKJ4+W5OdOMBADCxZsee6WZ47bKztf3KCm32ifvV7TqS0g==
X-Received: by 2002:a05:6a00:2393:b0:68e:4955:c405 with SMTP id
 f19-20020a056a00239300b0068e4955c405mr13095691pfc.27.1696844351453; 
 Mon, 09 Oct 2023 02:39:11 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a62ed16000000b00690fe1c928csm6074738pfh.147.2023.10.09.02.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 02:39:11 -0700 (PDT)
Message-ID: <3cba450e-a4ba-47f7-ae6c-2e73304762e2@daynix.com>
Date: Mon, 9 Oct 2023 18:39:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] buildsys: Only display Objective-C information when
 Objective-C is used
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20231009093812.52915-1-philmd@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231009093812.52915-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
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

On 2023/10/09 18:38, Philippe Mathieu-Daudé wrote:
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
> v2: Emit 'false' (Akihiko)
> ---
>   meson.build | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 3bb64b536c..567c1c9add 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -4074,8 +4074,10 @@ if 'cpp' in all_languages
>   else
>     summary_info += {'C++ compiler':      false}
>   endif
> -if targetos == 'darwin'
> +if 'objc' in all_languages
>     summary_info += {'Objective-C compiler': ' '.join(meson.get_compiler('objc').cmd_array())}
> +else
> +  summary_info += {'Objective-C compiler': false}
>   endif
>   option_cflags = (get_option('debug') ? ['-g'] : [])
>   if get_option('optimization') != 'plain'
> @@ -4085,7 +4087,7 @@ summary_info += {'CFLAGS':            ' '.join(get_option('c_args') + option_cfl
>   if 'cpp' in all_languages
>     summary_info += {'CXXFLAGS':        ' '.join(get_option('cpp_args') + option_cflags)}
>   endif
> -if targetos == 'darwin'
> +if 'objc' in all_languages
>     summary_info += {'OBJCFLAGS':       ' '.join(get_option('objc_args') + option_cflags)}
>   endif
>   link_args = get_option('c_link_args')

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>


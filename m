Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C436722001
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 09:48:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q64va-0000no-Us; Mon, 05 Jun 2023 03:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q64vS-0000nV-73
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 03:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q64vQ-0006kd-Ha
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 03:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685951206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=edJgCGLV3+aoZ4arLr3WhsZ7qMxPWdZcVxo1nvT3QH8=;
 b=Tk0scT5qaPuxzpHhiuXGr3wajxK34/Lx2+lEzwe/vnR1GrhdcEdx9pVYlaWeoZtPM5D/Hq
 6KELzIiJGs1k2DgyqssAl6Zwi5P+0S1Kr3G3E1e5+lDE+79g6EcvnUXGTXGzLPzfudJ3Wl
 iv9M5y1GLrbBvDgCFzATAGfmgapRp+A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-YXXvmsIEPRaVhWPDukohsQ-1; Mon, 05 Jun 2023 03:46:45 -0400
X-MC-Unique: YXXvmsIEPRaVhWPDukohsQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f60fb7b31fso18700275e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 00:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685951204; x=1688543204;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=edJgCGLV3+aoZ4arLr3WhsZ7qMxPWdZcVxo1nvT3QH8=;
 b=CjmxleLu1byd8OEK/9xD1n0VXZ8WQ2OYq1tAguU7sqg3Wuq/EIjrFKbs0DvOquVaci
 dKCgYrZSq1DF9V8rkr527KEngWE/pwv29DPUiXhfYIHAixXjfjsZDFlP7ogaMfmPUsag
 kaHTu5Zdaeh1hqbhBUxZMoef8eeO4qpUSV3pReJtXNAqcxUxlVdoCO/C8eoki6lfaVQ/
 LqouewDiYBsq2NMJ9+/TD3HmYvFnU805OOQoSWFP+mnb5Qhfh61+tDgI/0uQdook2MJ8
 epFjm0QGZP7V+QWSpFnRaHupIn91jcq5J+KTAnvZidT4Gw9k3Ac5jRwrki+kkIgWZoWT
 6RnA==
X-Gm-Message-State: AC+VfDz77gl0iLj/7lduL2MqLrYqPepvcL2QbIzjlfvLsU/t5O5EmjDx
 id+T0VThDR0LoYNz2Xrj9R6owPsAz/6FpD8QknwcB5DKpW9OXGzpL38OKZ3/lGt84kmTgIj9oa3
 +k9rK0rxgtp4Zw2k=
X-Received: by 2002:a1c:f310:0:b0:3f6:174:8c32 with SMTP id
 q16-20020a1cf310000000b003f601748c32mr6464814wmq.6.1685951204352; 
 Mon, 05 Jun 2023 00:46:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5N2VT5V6lGhGPDb371mH6soWVYBr6UKWcr9W5hbDomd65jW5V0wBchm18OZ4e/Qtx+WHMcjQ==
X-Received: by 2002:a1c:f310:0:b0:3f6:174:8c32 with SMTP id
 q16-20020a1cf310000000b003f601748c32mr6464803wmq.6.1685951204057; 
 Mon, 05 Jun 2023 00:46:44 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-115-143.web.vodafone.de.
 [109.42.115.143]) by smtp.gmail.com with ESMTPSA id
 h8-20020adfe988000000b0030ae5a0516csm8909753wrm.17.2023.06.05.00.46.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 00:46:43 -0700 (PDT)
Message-ID: <624698fd-d353-20a4-6a35-c6195af62318@redhat.com>
Date: Mon, 5 Jun 2023 09:46:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] meson.build: Use -Wno-undef only for SDL2 versions
 that need it
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org
References: <20230602163452.521305-1-thuth@redhat.com>
In-Reply-To: <20230602163452.521305-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 02/06/2023 18.34, Thomas Huth wrote:
> There is no need to disable this useful compiler warning for
> all versions of the SDL. Unfortunately, various versions are
> buggy (beside SDL 2.0.8, the version 2.26.0 and 2.26.1 are
> broken, too, see https://github.com/libsdl-org/SDL/issues/6619 ),
> but we can use a simple compiler check to see whether we need
> the -Wno-undef or not.
> 
> This also enables the printing of the version number with
> good versions of the SDL in the summary of the meson output
> again.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Compile test code instead of hard-coding the version number
> 
>   meson.build | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index a61d3e9b06..a4c69616c3 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1273,10 +1273,16 @@ if not get_option('sdl').auto() or have_system
>     sdl_image = not_found
>   endif
>   if sdl.found()
> -  # work around 2.0.8 bug
> -  sdl = declare_dependency(compile_args: '-Wno-undef',
> -                           dependencies: sdl,
> -                           version: sdl.version())
> +  # Some versions of SDL have problems with -Wundef
> +  if not cc.compiles('''
> +                     #include <SDL.h>
> +                     #include <SDL_syswm.h>
> +                     int main(int argc, char *argv[]) { return 0; }
> +                     ''', dependencies: sdl, args: '-Wundef')
> +    sdl = declare_dependency(compile_args: '-Wno-undef',
> +                             dependencies: sdl,
> +                             version: sdl.version())
> +  endif
>     sdl_image = dependency('SDL2_image', required: get_option('sdl_image'),
>                            method: 'pkg-config')
>   else

Hmm, there must still be something wrong with this patch, I'm still getting 
build failures with this in the CI ... no clue why yet, but please disregard 
this patch.

  Thomas



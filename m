Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 547407D9CE1
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 17:25:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwOhp-0007mR-Ds; Fri, 27 Oct 2023 11:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qwOhl-0007lo-89
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:24:57 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qwOhj-0003Yx-9N
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 11:24:56 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c9d407bb15so19940405ad.0
 for <qemu-devel@nongnu.org>; Fri, 27 Oct 2023 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698420294; x=1699025094;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sp8vvAg6/x8wzHPenADw0Ygsw3nKQTNfd1r3WaByQm4=;
 b=KRnvJ2Lw5kB8lWYrM02VccgJ6SwW/uirP8igDYEDkq3pwibut/6qc6b2cQvN4vUgCK
 CWVUzh37/3GGUcrhuoxkf4i1aV2sbUR7gt1zVyPK4ds5emAhjYBpp4TxBwURaMpSS2rJ
 7tAu/rJ63Y6HTJZx3CXyO3U9HonvHDh2MQzKrXXPNy9E/fSV+334N/EPQVrTVIDJXWVX
 13/DiYZF4IseGTY+SV8A8EOA7bAQpHATBCX0Ea3vMfNnbz8ucN+gYdEIHpGV2r9s9zVF
 eVFNgIs1U8Cr5HpVXQ5lppz4OmYrgEfMT9FU0s9c4eXBAnr4BFKGJNT0LWDls/RuC8qq
 t68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698420294; x=1699025094;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sp8vvAg6/x8wzHPenADw0Ygsw3nKQTNfd1r3WaByQm4=;
 b=w6VTdOKxbi0AixC0Iq5HAWh9MKtemdJJp0fgdi7nNklFktPDNys8TY53l8DqaCOLIP
 y95IQ8SqXdazm7MMy94a0O+LzKzQwAdfI9MVXiCHGju9syNhVrNkUP+j8ReCBKdvINip
 VxL5jKKqUnwhZIHh3W7JIj+yuxGj97W2FiW/FGhRo3aOHie160awNQ6aaXwVepi8nn+N
 JuGeKGXCTCFD1grbdIR8DMNHhN0nKUyiABZb7EGtMfqjp6izc+ZVuNEfwnoQaYaUl6Vi
 ctEdwyh0L+x6qi85w6uiNMgaKl/7+19ilGz1sAOMqsUHLWVIIY94IQC96u1WLvD9uIJc
 gvaw==
X-Gm-Message-State: AOJu0YxtCrwTe8df6WJFzMvWg1HSBesTrAdZQhiaQrInUaBnAisWDOJx
 Rinq/K6yxIHhnoO2EH5BSCzSgw==
X-Google-Smtp-Source: AGHT+IELvT+HSgSU6d1iZJd0kunugmOrTYT/OtVr6TgVnsPwmiUXXhdNEEXDB6tjN8T7DJySUPj5Uw==
X-Received: by 2002:a17:902:e84a:b0:1bf:4a1f:2b57 with SMTP id
 t10-20020a170902e84a00b001bf4a1f2b57mr3550735plg.13.1698420293866; 
 Fri, 27 Oct 2023 08:24:53 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 f1-20020a170902684100b001c60ba709b7sm1723622pln.125.2023.10.27.08.24.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 08:24:53 -0700 (PDT)
Message-ID: <e49bbe11-42e2-4251-843e-18b2d6bbca7c@daynix.com>
Date: Sat, 28 Oct 2023 00:24:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] ui/cocoa: add zoom-to-fit display option
To: carwynellis@gmail.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, kraxel@redhat.com,
 marcandre.lureau@redhat.com
References: <20231027150942.72357-1-carwynellis@gmail.com>
 <20231027150942.72357-2-carwynellis@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231027150942.72357-2-carwynellis@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
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

On 2023/10/28 0:09, carwynellis@gmail.com wrote:
> From: Carwyn Ellis <carwynellis@gmail.com>
> 
> Provides a display option, zoom-to-fit, that enables scaling of the
> display when full-screen mode is enabled.
> 
> Also ensures that the corresponding menu item is marked as enabled when
> the option is set to on.
> 
> Signed-off-by: Carwyn Ellis <carwynellis@gmail.com>
> ---
>   qapi/ui.json |  8 ++++++--
>   ui/cocoa.m   | 35 ++++++++++++++++++++---------------
>   2 files changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/qapi/ui.json b/qapi/ui.json
> index 006616aa77..fd12791ff9 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1409,13 +1409,17 @@
>   #     codes match their position on non-Mac keyboards and you can use
>   #     Meta/Super and Alt where you expect them.  (default: off)
>   #
> -# Since: 7.0
> +# @zoom-to-fit: Scale display to fit when full-screen enabled.
> +#     Defaults to "off".
> +#
> +# Since: 8.2

I don't think this new option will affect only when full-screen enabled, 
but probably it will affect also in a windowed mode. Perhaps you can 
just copy the description for DisplayGTK except the statement regarding 
virtio-gpu.

Also don't replace "Since: 7.0". It denotes the version that introduced 
the structure, not an individual member.

>   ##
>   { 'struct': 'DisplayCocoa',
>     'data': {
>         '*left-command-key': 'bool',
>         '*full-grab': 'bool',
> -      '*swap-opt-cmd': 'bool'
> +      '*swap-opt-cmd': 'bool',
> +      '*zoom-to-fit': 'bool'
>     } }
>   
>   ##
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index d95276013c..903adb85a1 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -104,7 +104,7 @@ static void cocoa_switch(DisplayChangeListener *dcl,
>   static int left_command_key_enabled = 1;
>   static bool swap_opt_cmd;
>   
> -static bool stretch_video;
> +static bool stretch_video = false;

You don't need to assign false here. C initializes it as false by default.


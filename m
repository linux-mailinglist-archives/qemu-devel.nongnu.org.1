Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDAB79FB67
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 07:57:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgfLT-00053q-Bz; Thu, 14 Sep 2023 01:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfLP-00053Q-Az
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 01:56:51 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgfLM-0003kV-Q0
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 01:56:51 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-402d0eda361so6249705e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 22:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694671005; x=1695275805; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZqSH6L6nYuacgJsGR2OSSZqdZBClH3egLrrNryqn13c=;
 b=uPBqnCz9W9thm9w0bdQCyrLNTRVPhIReoq8OATTTIHQErP9iuYR/9jvF4BZ5ZfuLEw
 bpvzWlm+Yli1L8pEDzFcmw5XvXAzH2KnNue5Qb8ZWoeIIfQw+tmzYyoKVSZxrjdpSZF3
 p08fadc/jVQ0rss0SVhPY0kiLrbnGX8we7YcSrqOMDjGD4dveE4eIiWbb4mJzfYn2sLv
 llvwDPA3Bdv0R/aYIK4YJoPBRtR8lBEyyyuko82saAmy49PjewuIqOdh6OcxSlyAE6Z9
 p1Jo4F7AGgaBC9ZcAA0ZAH301iY2gnOZLB0a7+bNdd8suBtTuYqJblkftXTj8oTdiy8S
 of1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694671005; x=1695275805;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZqSH6L6nYuacgJsGR2OSSZqdZBClH3egLrrNryqn13c=;
 b=dfHnThyn4SsSmopZSsdpo3LL0IE8XSLKd1OhTTJojWKXEWgk9ogTT/++igrDOXaQfr
 qUzeyfyj2VOei+KX8VZIGcZMMdofsyIaBhTzsXLX3S7yZKLr6Mat9IKF2EzUXYZclJp3
 +KxcJzqGsKI0F+36mxUBIDFC8u7k/yzRoxxDwTnVQc3H1bKjfDkpbtSuaeVrHrrChoVB
 jjsXlwWcrZgtlW4dsBaGj6Vb27n0ZQcIAqC0ooUu7UO+6e3ILgrrKeYzS/HgssKJmGJp
 ge0QCstKvuRKmvsEVVCC1zGtz39M4BouYfXS65XkSkGkHSLRXilce/3MiBl/X0vBs2xW
 AbKQ==
X-Gm-Message-State: AOJu0YyaTE8Mu+9OX7TM04S4Iexv3YI9UJ8Z9LiqCx+i+nnVCbRNgh5M
 B0Bi/+q8o5kdX1b22S0hN8fBZFw9PP2TbfpQR4I=
X-Google-Smtp-Source: AGHT+IHWkJZ57kD9h7S0txNgxC4MTp0U/Glj3HlAkpZ9LcH08Kn7lL0AVY6siMe/suaKQVTDpsYtVw==
X-Received: by 2002:a05:600c:290:b0:3fe:2011:a7ce with SMTP id
 16-20020a05600c029000b003fe2011a7cemr3935993wmk.6.1694671005029; 
 Wed, 13 Sep 2023 22:56:45 -0700 (PDT)
Received: from [192.168.69.115] (sem44-h01-176-172-56-29.dsl.sta.abo.bbox.fr.
 [176.172.56.29]) by smtp.gmail.com with ESMTPSA id
 y6-20020a05600c364600b003fe2bea77ccsm965828wmq.5.2023.09.13.22.56.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Sep 2023 22:56:44 -0700 (PDT)
Message-ID: <7f5c855b-221d-637a-73a6-59b1db739921@linaro.org>
Date: Thu, 14 Sep 2023 07:56:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] ui: add XBGR8888 and ABGR8888 in drm_format_pixman_map
Content-Language: en-US
To: Ken Xue <Ken.Xue@amd.com>, qemu-devel@nongnu.org
Cc: pierre-eric.pelloux-prayer@amd.com, Hui.Yu@amd.com,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230914013151.805363-1-Ken.Xue@amd.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230914013151.805363-1-Ken.Xue@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Cc'ing maintainers:

$ ./scripts/get_maintainer.pl -f ui/qemu-pixman.c
Gerd Hoffmann <kraxel@redhat.com> (odd fixer:Graphics)
"Marc-André Lureau" <marcandre.lureau@redhat.com> (odd fixer:Graphics)

On 14/9/23 03:31, Ken Xue wrote:
> Android uses XBGR8888 and ABGR8888 as default scanout buffer, But qemu
> does not support them for qemu_pixman_to_drm_format conversion within
> virtio_gpu_create_dmabuf for virtio gpu.
> 
> so, add those 2 formats into drm_format_pixman_map.
> 
> Signed-off-by: Ken Xue <Ken.Xue@amd.com>
> ---
>   include/ui/qemu-pixman.h | 4 ++++
>   ui/qemu-pixman.c         | 4 +++-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/include/ui/qemu-pixman.h b/include/ui/qemu-pixman.h
> index 51f870932791..e587c48b1fde 100644
> --- a/include/ui/qemu-pixman.h
> +++ b/include/ui/qemu-pixman.h
> @@ -32,6 +32,8 @@
>   # define PIXMAN_LE_r8g8b8     PIXMAN_b8g8r8
>   # define PIXMAN_LE_a8r8g8b8   PIXMAN_b8g8r8a8
>   # define PIXMAN_LE_x8r8g8b8   PIXMAN_b8g8r8x8
> +# define PIXMAN_LE_a8b8g8r8   PIXMAN_r8g8b8a8
> +# define PIXMAN_LE_x8b8g8r8   PIXMAN_r8g8b8x8
>   #else
>   # define PIXMAN_BE_r8g8b8     PIXMAN_b8g8r8
>   # define PIXMAN_BE_x8r8g8b8   PIXMAN_b8g8r8x8
> @@ -45,6 +47,8 @@
>   # define PIXMAN_LE_r8g8b8     PIXMAN_r8g8b8
>   # define PIXMAN_LE_a8r8g8b8   PIXMAN_a8r8g8b8
>   # define PIXMAN_LE_x8r8g8b8   PIXMAN_x8r8g8b8
> +# define PIXMAN_LE_a8b8g8r8   PIXMAN_a8b8g8r8
> +# define PIXMAN_LE_x8b8g8r8   PIXMAN_x8b8g8r8
>   #endif
>   
>   #define QEMU_PIXMAN_COLOR(r, g, b)                                               \
> diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
> index be00a96340d3..b43ec38bf0e9 100644
> --- a/ui/qemu-pixman.c
> +++ b/ui/qemu-pixman.c
> @@ -96,7 +96,9 @@ static const struct {
>   } drm_format_pixman_map[] = {
>       { DRM_FORMAT_RGB888,   PIXMAN_LE_r8g8b8   },
>       { DRM_FORMAT_ARGB8888, PIXMAN_LE_a8r8g8b8 },
> -    { DRM_FORMAT_XRGB8888, PIXMAN_LE_x8r8g8b8 }
> +    { DRM_FORMAT_XRGB8888, PIXMAN_LE_x8r8g8b8 },
> +    { DRM_FORMAT_XBGR8888, PIXMAN_LE_x8b8g8r8 },
> +    { DRM_FORMAT_ABGR8888, PIXMAN_LE_a8b8g8r8 },
>   };
>   
>   pixman_format_code_t qemu_drm_format_to_pixman(uint32_t drm_format)
> 
> base-commit: 9a8af699677cdf58e92ff43f38ea74bbe9d37ab0



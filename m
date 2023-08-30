Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB8078D6F1
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:22:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbN0r-0007Rk-Vq; Wed, 30 Aug 2023 11:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbN0p-0007RU-KV
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:21:43 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbN0n-00083e-BA
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:21:43 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so50848985e9.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693408897; x=1694013697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oOG+vBLRPp0GDKSzEkbsSiNMuXCyb9yC6bhsQMypvEY=;
 b=f/2H7Aa/w5PpQeU8JRrXVUWjuUFL0QStVtVxkvDCnXwApVzYfdaM23LfL8/W7JWovr
 2vQXrTCvnqdrAgDf2EP8MrzJEHt6AnT4bHa3upY7H3uWYjxtcSyxNTfuhXoNiXjA3Zgl
 dbad/RtyT00l1UWmPV9cStICXUfJI4MS7msUh/gkuozmVHIMVhq/8JgZKkR+Ax+vgw+j
 2vEYYCONsVQogIfC/gicQbXqMWKhN6MSCrQFt9lVKot06qv2eza+Rr3k08XHvZImSMae
 +yJMP0K4ubYmAW3kRACKiHpaCa5v/penzsLWwZ3o2LmvmW2vW1i7SCgVEYqU1jmO23Rm
 1++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693408897; x=1694013697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oOG+vBLRPp0GDKSzEkbsSiNMuXCyb9yC6bhsQMypvEY=;
 b=J3TCOPxw47qptNk58ee8ZPJRoAeEQx1Q0x8FN2CwoHKD/zyS9lhRu3lEqVJPsBJwtO
 VrN+Em8cfOZJYpVtxHTQXHhVddTiNtZC35j5LUWTQVvDNjUokhSFiEl89XGl+8HjMU6d
 MX/Fp9oUDSiaSqdkStBKCgiZ7G1oNv5yS7ruDr2ZBP3w2Kh4PwNB0xNJRpvp2Rs4njSK
 5NykK7b7uHJV31m/EMz6DMunOJe5EDDxsTA96ePpumKzPMxOFE4EDAefHba9DWUsBFAT
 2bXagwd7rvgJ8b2v7uLbNEWF2ij+RQcD9LQGZib3GvYSdG/Yxu72iK2XBST4FljSRCOj
 Q+5A==
X-Gm-Message-State: AOJu0YxpQ4QEV2CcS+Q+nMlyucTPSa0LxX8aFm+Sj+RlLL1NAI1ZFTwW
 MhEu4JSHGE3EH6BjzytMi9mIlQ==
X-Google-Smtp-Source: AGHT+IFNHmi7AQKluQyTC2b7T5gQgZGlfobli8PyrsQ/fWec3MeEAk1zQ2BfQIBAvaKEAl8Tf/E1iw==
X-Received: by 2002:a5d:4f05:0:b0:314:1b36:f440 with SMTP id
 c5-20020a5d4f05000000b003141b36f440mr1597659wru.70.1693408896733; 
 Wed, 30 Aug 2023 08:21:36 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 z12-20020adff1cc000000b00317f29ad113sm16954576wro.32.2023.08.30.08.21.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 08:21:36 -0700 (PDT)
Message-ID: <10228ad3-2eb8-7f0e-58e2-93024af81950@linaro.org>
Date: Wed, 30 Aug 2023 17:21:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 61/67] ui/spice: SPICE/QXL requires PIXMAN
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-62-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830093843.3531473-62-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 30/8/23 11:38, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/display/Kconfig |  2 +-
>   ui/meson.build     | 12 ++++++------
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 7b3da68d1c..4d8b0cec40 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -93,7 +93,7 @@ config VGA
>   
>   config QXL
>       bool
> -    depends on SPICE && PCI
> +    depends on SPICE && PCI && PIXMAN

Shouldn't this be:

--- a/Kconfig.host
+++ b/Kconfig.host
@@ -14,4 +14,5 @@ config X11
  config SPICE
      bool
+    depends on PIXMAN

---

?

>   
>   config VIRTIO_GPU
> diff --git a/ui/meson.build b/ui/meson.build
> index b3525ef064..08d845d43a 100644
> --- a/ui/meson.build
> +++ b/ui/meson.build
> @@ -133,7 +133,7 @@ if sdl.found()
>     ui_modules += {'sdl' : sdl_ss}
>   endif
>   
> -if spice.found()
> +if spice.found() and pixman.found()
>     spice_core_ss = ss.source_set()
>     spice_core_ss.add(spice, pixman, files(
>       'spice-core.c',
> @@ -141,12 +141,12 @@ if spice.found()
>       'spice-display.c'
>     ))
>     ui_modules += {'spice-core' : spice_core_ss}
> -endif
>   
> -if spice.found() and gio.found()
> -  spice_ss = ss.source_set()
> -  spice_ss.add(spice, gio, pixman, files('spice-app.c'))
> -  ui_modules += {'spice-app': spice_ss}
> +  if gio.found()
> +    spice_ss = ss.source_set()
> +    spice_ss.add(spice, gio, pixman, files('spice-app.c'))
> +    ui_modules += {'spice-app': spice_ss}
> +  endif
>   endif
>   
>   keymaps = [



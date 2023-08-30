Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B12A678D6F7
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:28:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbN6s-00023i-Ik; Wed, 30 Aug 2023 11:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbN6h-00022y-1N
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:27:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbN6c-0000pY-Ss
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:27:44 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401d10e3e54so25242485e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693409261; x=1694014061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NyTkGwzMuSmN+msqEOXmvCZn1EpBuljFmbrUhOFAvvw=;
 b=lAqmzawz2mp+ODe/YXNxo1M0/IljNDmvxtoC1Gbey6c666t6leyyr7UOJ4SVtt3FiD
 YbwcqQY0cMiTuoQdEK6aEqSVITfnz21U6OVUMMFImSOZDLqMTteMoOygAcyFID1KWK9d
 HOhmToY4ruKHmdrCa33qZCRyC2OciTyP8ttAeJslXkNAbrM1ZxK0CCWOMZ3gdCVnAtie
 1VaiK2tTiDs4PKy0i9SwzlFbmYnAHk6eSET9G9SNQ5gYuwcyVinvURf7/XztZfXFQiv9
 aZXgMvx6EHbGg2VO7XqWeSOKVpxOiP4BK8BhOF1LblnNZKPgIcMaAjy0PN+WIw0WrdoP
 6m4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693409261; x=1694014061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NyTkGwzMuSmN+msqEOXmvCZn1EpBuljFmbrUhOFAvvw=;
 b=L+bUBhnwBh0BUCZzPBbfYh6HHZoYkAtoxNpaneQzmWALTjdhC7CutQzIPX06MpVgWq
 2idnr3XF4FeQhNLuBkJgDl5uzXiWekGfj37V7Bn0SdNlDKKmOYwEOH4HlelVYrMFvLdy
 OInw82cHWFT9tsXrC/4D2mwvLcBESjVBea/Rrb3dLMInCVCjPlkw9675oLUSkd5Rg8N5
 9AaarPfxVXAsmObQBjLmIXiAXznKVP8OJp7u7zcPl7CZkbJ+3kJyJSfIfGDeq6SLspGO
 Mp9ZfNUR7vAemUiMTZp5LMFHfgow21VAxHhqgzXkn+F/9vhvtkB2mXn9lMPlhicIAmhL
 oVCA==
X-Gm-Message-State: AOJu0YxlHFXSMuqSRzZJzRgUycHDd2fVQQwtfCstAgS6DB2LVP4eTVxb
 /QFoI+hcZO/iIukIZRvgeC0ttg==
X-Google-Smtp-Source: AGHT+IE2mt734RccB7AaiRSeF9OFKmcSokmn7hI7HaWcSHQu/5aavulUpGIKF1au4ctz1eTdbXXHUw==
X-Received: by 2002:adf:e80e:0:b0:315:8a13:ef17 with SMTP id
 o14-20020adfe80e000000b003158a13ef17mr1959916wrm.65.1693409261520; 
 Wed, 30 Aug 2023 08:27:41 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 n8-20020a1c7208000000b003fefaf299b6sm2595630wmc.38.2023.08.30.08.27.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 08:27:41 -0700 (PDT)
Message-ID: <39fc098c-e1fb-ebb9-763a-03d2384163af@linaro.org>
Date: Wed, 30 Aug 2023 17:27:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 67/67] display/kconfig: make SM501 depend on PIXMAN
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-68-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830093843.3531473-68-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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
>   hw/display/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index 4d8b0cec40..e8077c16d8 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -74,6 +74,7 @@ config FRAMEBUFFER
>   
>   config SM501
>       bool
> +    depends on PIXMAN
>       select I2C
>       select DDC
>       select SERIAL

SM501 optionally use pixman, so by adding some CONFIG_PIXMAN
#ifdefry in hw/display/sm501.c we can compile it without pixman.


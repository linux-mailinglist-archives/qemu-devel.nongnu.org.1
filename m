Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A28678D503
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:05:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbI4H-0003Yn-4w; Wed, 30 Aug 2023 06:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbI3z-0003T1-Ue
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:04:41 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbI3w-0006Sb-MT
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:04:39 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31adc5c899fso4859832f8f.2
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 03:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693389875; x=1693994675; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZrgR9mGtdTOzlaFsSKDppdk2RaA42joyZI5Tg5ioe4M=;
 b=NAHDEjBgbjzwBAtPtXw7dGi2f4XKIR8oMptxw8U3itZ6C6w5199WGBSQNhcQMXSYpk
 /Msd/RMrLKISMpfH9pT5JrRWmvrkE4NXYZL79l9/YF6rYuySD31w69e07LQJt1bP/qWu
 xt7a1pgCxc0UXzg7EX1wXR28NCxzp2KeLTBZ91ho+C5ixgD47Z7tL1l80I4IW9yrIQxY
 KJ6KDgBlMsPeoOdsW08HDcZ6qqbqZbG8xqkDWpkkUNQTpGnhYSpxZWZfbfEXJF0SKnZS
 N7kBKLYHo3WmoFYCDV8tZHjnN+xszxZ8AL4oVhKKR8twZ7e91DUM/mSWffMo3kiQXDtd
 mXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693389875; x=1693994675;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZrgR9mGtdTOzlaFsSKDppdk2RaA42joyZI5Tg5ioe4M=;
 b=KMIpg6mbLlWZb9HjXlqzyBhN8AY/NcSsCsosl6ygaARm03QqLSlFIEBZy711RxAOOJ
 Hpb8ti8fYoRITWUxjsEei77D2AsK66O+Mu8O3aORxu/QSvXBkzg9kki8dPoHtEIn1aXe
 lcwApS02kK/yHscf3tEdWei/p4agU801hM0FwDRk/5CBgr/4pVg2AyI21nY1Q+/pdcrW
 9Obgx89hn95CqJEljnQvpNkyY/8cf0fF2gg0sngqcSryo+16apLPi2FzRZEcnX5TRK8Y
 O30XH935uF7Tr2S0sWG1mKgTfuZT2tOubhmadQyeqrQju8U8TOt7iXAtKXdxQR1c0kwE
 723A==
X-Gm-Message-State: AOJu0Yzuosd30C0VOtVfNccpqTl28JzedvJSi0+IXfuURZ4FW59kJZP7
 kgIG8BfDKlvfezUBHhE/GAEpRw==
X-Google-Smtp-Source: AGHT+IFlUqHvYB/jr8t5ZooWQp4vpLZzBqdiHRrS5oPhojxhfjPRSPYMD2zdxXkevv8OZxZJBoJa9w==
X-Received: by 2002:adf:e809:0:b0:317:61af:d64a with SMTP id
 o9-20020adfe809000000b0031761afd64amr1503056wrm.3.1693389875174; 
 Wed, 30 Aug 2023 03:04:35 -0700 (PDT)
Received: from [192.168.18.115] ([91.219.21.246])
 by smtp.gmail.com with ESMTPSA id
 v19-20020a05600c215300b003fef3180e7asm1757214wml.44.2023.08.30.03.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 03:04:34 -0700 (PDT)
Message-ID: <379e994d-1ee6-11ce-422f-302cbecf6e69@linaro.org>
Date: Wed, 30 Aug 2023 12:04:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 04/67] ui/vc: replace vc_chr_write() with generic
 qemu_chr_write()
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-5-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830093843.3531473-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 30/8/23 11:37, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> We shouldn't call the callback directly, but use the chardev API, unless
> there is a clear reason.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/console.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



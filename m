Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFC678D6E8
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:19:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMy1-0006dH-Uz; Wed, 30 Aug 2023 11:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbMxz-0006d4-P5
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:18:47 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbMxx-0007CC-LA
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:18:47 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-401c90ed2ecso34931155e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693408724; x=1694013524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z+3iAQwI8glRistoUcxv2eLBx2/i4GIey4VpWdD/k5k=;
 b=jHgyYRPUqcSXFfiHFnMukdbUxF1mPrvJFr4ivwPhkns58NN9jpeLe5ZxMNHDUvzeQx
 ngiQlnNWg+vChFZtTkovbsu+Y4m9bmwUPXAp8NOWqmWdjK8NglolMUnNpDrjyab1rgI/
 jiKZRve0a5g6YHcpH43Lrg+DyifymBxdugfkOsjLg+UdR9UBQzZDizQrgfRscZj9I1gI
 pspX+JuqnUyNLtFYcEBPuVbkF6m1tf3hPFgs0TEV6rvZzzK8+dlje9p8FMZvKhjL+BrO
 CR9cblKzYqz4lbhqRi9mgmU999x67Sg3DFawxDQkNPk4xfcq3VhZZMyi6GkkmuRH4Doy
 Y+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693408724; x=1694013524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z+3iAQwI8glRistoUcxv2eLBx2/i4GIey4VpWdD/k5k=;
 b=iTiikW11doLqG7B2shJFw2KqveGBn4cZQjRqlP4+Y9agtASdX+km0rgJbnGp43xxPs
 xsApcHoFeL8M/e7L5WI23AiMrxvdOdoKDVZ+GPnrSI1aVWBi8H1zgRU85VDF5K2xthUp
 StzcRwh0YoOKv4yvSbDvgo37iC7+D1op+418za5M3iZW/OtxB62UgMFuQIGOchUohN6a
 UbRO/MsIP3ceoQ8oZoD2IEgBPt3sqMN6rV+iVlynMFfK6nOlHyviVHp9SrcMMsdfVHPE
 ZBhJVmnO7l80UwmqUEBpUn3vhGVvYx1rTNOdpAxq3ed6z4F4YmUs3tXx2mk/Cj1qZdm7
 dd5g==
X-Gm-Message-State: AOJu0YzKhfsFefmAewrVeI/z/kG1+tcQQpX3h05OxQAgbG+hDhOpMPTT
 v2NYdXpqLwQqrAT3u1I8MVJJUw==
X-Google-Smtp-Source: AGHT+IFRCJ5ZRcnTXqEbRlkWUnyelm1BBOgy9Pe289TW1veIVo36wZQKjxrghQQZ7Advpi7eI7qghw==
X-Received: by 2002:a1c:7c05:0:b0:401:be77:9a50 with SMTP id
 x5-20020a1c7c05000000b00401be779a50mr2483491wmc.8.1693408723955; 
 Wed, 30 Aug 2023 08:18:43 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a7bcb89000000b003fe26244858sm2562232wmi.46.2023.08.30.08.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 08:18:43 -0700 (PDT)
Message-ID: <3ec16092-ba7a-e0ac-7466-ebf162315899@linaro.org>
Date: Wed, 30 Aug 2023 17:18:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 55/67] qmp/hmp: disable screendump if PIXMAN is missing
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-56-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230830093843.3531473-56-marcandre.lureau@redhat.com>
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
> The command requires color conversion and line-by-line feeding. We could
> have a simple fallback for simple formats though.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   qapi/ui.json     | 3 ++-
>   ui/ui-hmp-cmds.c | 2 ++
>   ui/ui-qmp-cmds.c | 2 ++
>   hmp-commands.hx  | 2 ++
>   4 files changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



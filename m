Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA627D7D84
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 09:19:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvue5-0003pq-3l; Thu, 26 Oct 2023 03:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvue1-0003ph-Tb
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 03:19:05 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qvue0-0006Nf-A2
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 03:19:05 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53e3e7e478bso791696a12.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 00:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698304742; x=1698909542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KGrieHBEUpuuwMAl0bMHfU/Njlldei0oxHoIC7yKXk0=;
 b=bf9AhIFz75mofEzP9xWyXbQgI7erEVl4IiMDmaEE3DDHpZwcGukFw6cmTg0m9/k1Tf
 rO9HvvQWyxAbhKM/fDgyuEdeCXHAoALILtflEv+tZuECsE+3WTkEazn8VTmhwcbz0zRv
 3BI+rs6d3MLd4eVY0i3pmFj2m/6HRzHscG83p6FIPxUL6zjpp6jeN2mxtxVqlTat66uB
 OyGWrbBHc9mTbW/s71hBwFS6+wXNAO6yiAYChzOstCwbJsVzPP9NM8ab18jQwV4LF59B
 cCbU8V4NwGx81A/9hIU4vorraeB2OHCsQ4hhGL3RP5hd0xZk3Yd6U86//RPCFjN4gXxW
 qZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698304742; x=1698909542;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KGrieHBEUpuuwMAl0bMHfU/Njlldei0oxHoIC7yKXk0=;
 b=fKdzsXAwMa3vmvXoZfjtTI8+UnkRGgUD07uW044y03gEJs1js71r9zLK/exNsKFC7m
 R2KiGdBslZ6UlqZzCim7K7Y4eYPTMgnYunGZMUShNMKraIlQNeOUauouZLXiaxAW4BpV
 HiQHDz2yLi75vhYaTVesb+L50VihRyZRUncGMM2/+0c1F26IrA096fwHQzSGs2dbeEK+
 d6qj1sFQDY6ScApmfS7TlnVh4VB9JKN4hUivR7bizp1ImnH6D/tneGJmiSSCRlOSitBv
 szmBh4aSFrVmEnGGx8xQd37gserm5Zj+JCjVs6bM63GsxXvn3e8UcoqXVLfFrFchriex
 kSFQ==
X-Gm-Message-State: AOJu0YypMAlUSgNDDNoLAeQtJFBH/TziUuEmH3Q+zzvIFOJ1jKZoNHpa
 /xbffdnc5iIzfmjA1woI+YaZFA==
X-Google-Smtp-Source: AGHT+IGOQ3fUPtU7P0Ce9Xc1jbDFZG9VlJhJyyz139r7ZRz/lFxvrAYwhM63t4EeohcfNa6yx3nWMg==
X-Received: by 2002:a17:907:1c92:b0:9ae:69b8:322b with SMTP id
 nb18-20020a1709071c9200b009ae69b8322bmr16788969ejc.60.1698304741952; 
 Thu, 26 Oct 2023 00:19:01 -0700 (PDT)
Received: from [192.168.69.115]
 (aif79-h01-176-172-114-150.dsl.sta.abo.bbox.fr. [176.172.114.150])
 by smtp.gmail.com with ESMTPSA id
 30-20020a170906209e00b009a1b857e3a5sm11095198ejq.54.2023.10.26.00.18.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Oct 2023 00:19:01 -0700 (PDT)
Message-ID: <aa5e542d-097a-e101-f874-3b550ba8599b@linaro.org>
Date: Thu, 26 Oct 2023 09:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] util/uuid: Remove UUID_FMT_LEN
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev"
 <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>
References: <20231026070636.1165037-1-clg@redhat.com>
 <20231026070636.1165037-4-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231026070636.1165037-4-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 26/10/23 09:06, Cédric Le Goater wrote:
> Dangerous and now unused.
> 
> Cc: Fam Zheng <fam@euphon.net>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/qemu/uuid.h | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> index 4e7afaf1d5bd5d382fefbd6f6275d69cf25e7483..356efe7b5797911640ed347fc08f4ef5ebbd0476 100644
> --- a/include/qemu/uuid.h
> +++ b/include/qemu/uuid.h
> @@ -78,8 +78,7 @@ typedef struct {
>                    "%02hhx%02hhx-" \
>                    "%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
>   
> -#define UUID_FMT_LEN 36
> -#define UUID_STR_LEN (UUID_FMT_LEN + 1)
> +#define UUID_STR_LEN (36 + 1)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   
>   #define UUID_NONE "00000000-0000-0000-0000-000000000000"

but just noticing that ^^^ :) So I'd go with:

   QEMU_BUILD_BUG_ON(sizeof(UUID_NONE) - 1 != 36);
   #define UUID_STR_LEN sizeof(UUID_NONE)


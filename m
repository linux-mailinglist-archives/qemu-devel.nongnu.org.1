Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2019D756033
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 12:15:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLLFW-0001M5-6Z; Mon, 17 Jul 2023 06:14:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLLFU-0001LY-81
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:14:36 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qLLFS-0004uE-OX
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:14:36 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so4649351f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 03:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689588873; x=1692180873;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hIFpU9SZozFQDnZrh+I9xMw+MSshQOsyZx4sMRb2Sfw=;
 b=Gdk4atNTqQa1MDZXlKBp29gm7NpAcd11TyyX3v+i3lD/99EojDqfb7IFmK0NDW8no/
 4mZ57ovdwV97PWreziYqldyDbd5wk3vtnERoNAx/ocbvPMoRTatgjo+tU14CvqDbQIij
 hNaWIovKHuK84i5p5SF7+gDgZbb9LXML0gbyCCp5QUzZUuYeKQYwzCtODrQBfamk/RsN
 arZBAlIbos/EMlj8VSVoVx+yBIJyRjLOQf3j8mh+pHAyeA8H5wSPxxAygDXosW/1r0sz
 RMuK7PZQj/BG1ST4Nq8LHsoztNleDNd1CdfV5ObCf/DYrboUfiO3Oh9DAh0yShi/aPr5
 Y05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689588873; x=1692180873;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hIFpU9SZozFQDnZrh+I9xMw+MSshQOsyZx4sMRb2Sfw=;
 b=Jt0YPVfAkFesAj3rZxn54Ybcs7sfukH5RcgQxYDNV0eg/YTM3EBN4f0dj8ZFgvyDyg
 6/WzQu5Mq9/qU+anDEVfKVlOj8Ix4wHCJ5krs2DOhVlnvDOC4JMsbHHtrIK8nWdKybm9
 hGlvZMtXfsmXBLEGvOwEAynXeMdlWD3a4VPouYw7rkc5YxOxxuPU+QWwDg2/UHmhjRFA
 6F39vu78Qd2rgGEwKAwyOrA7L8kiDzgZz2oVjzSymAluf9SkVWd3Z8ZekccpBhFDLXv+
 6CpESFdlZ4M606233P6ZfWmZMSG1ig3anEFPOmjkBT/4/B8kv9Pjh53fhJggoNiXN45u
 2Njw==
X-Gm-Message-State: ABy/qLYkEdmkLg8Fvnma1OmQ03FVP02CKXyDWymafiOjlXrxxLqA/UXs
 FG4BP/LNrtZ0pZxzjSjQObpzAw==
X-Google-Smtp-Source: APBJJlEx4SgsUVuFiDhvLBmd5n5BO47arAi/xTpbD9gkJwB+z6/8afEpUnL6SIhKvvogSGHfUbiXTA==
X-Received: by 2002:a5d:67d0:0:b0:313:fbd0:9813 with SMTP id
 n16-20020a5d67d0000000b00313fbd09813mr9487632wrw.28.1689588873124; 
 Mon, 17 Jul 2023 03:14:33 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.144.39])
 by smtp.gmail.com with ESMTPSA id
 i17-20020adff311000000b003143853590csm18698302wro.104.2023.07.17.03.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jul 2023 03:14:32 -0700 (PDT)
Message-ID: <82565d45-9665-fc45-9083-44dab73a0eba@linaro.org>
Date: Mon, 17 Jul 2023 12:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH] vhost: disable VHOST_OPS_DEBUG by default
Content-Language: en-US
To: Zhu Lingshan <lingshan.zhu@intel.com>, jasowang@redhat.com,
 mst@redhat.com, eperezma@redhat.com
Cc: qemu-devel@nongnu.org
References: <20230717174405.293668-1-lingshan.zhu@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230717174405.293668-1-lingshan.zhu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

On 17/7/23 19:44, Zhu Lingshan wrote:
> This commit disables VHOST_OPS_DEBUG by default
> These information are ususally only required in development
> environment
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>   hw/virtio/vhost.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 82394331bf..ec435a3079 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -29,7 +29,9 @@
>   #include "trace.h"
>   
>   /* enabled until disconnected backend stabilizes */
> -#define _VHOST_DEBUG 1
> +
> +/* uncomment macro _VHOST_DEBUG to enable VHOST_OPS_DEBUG */
> +/* #define _VHOST_DEBUG 1 */

Since you are looking at this, it would be more useful to
convert VHOST_OPS_DEBUG() to trace events (see for example
commit 163b8663b8 and other "Convert DPRINTF() debug macro
to trace events" commits).

Regards,

Phil.



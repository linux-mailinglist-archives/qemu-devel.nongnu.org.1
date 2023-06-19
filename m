Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7964A734C01
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 09:00:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB8ro-0002Yt-Gm; Mon, 19 Jun 2023 03:00:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB8rg-0002YY-V0
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 02:59:53 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qB8re-0003nE-J0
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 02:59:52 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5186a157b85so4572741a12.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 23:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687157988; x=1689749988;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v0bjX897cKkTr+QGHXfVJFQj7qsJcrHGU9tUpY/7pm4=;
 b=hyyhU2zmafPzJv/rjJDCXrpTyQPks8JXbS7ELY8WDOZqUcTO9fNFubk7X6PtB9VJcS
 Xxbz73rX0J3i24LadzUh/igGdnIF1cVi56+Wp7qUH3cce7Yn798G6T4bIu/gNYc3HarG
 UAtAjn1ZcY2JVcWvc66KtL0EKzGTVKz7dmjJtp86skhwnTHNNRjH+/wlWiiDdM99j0+r
 tTjnrVnZZSPg7tzXkijCvrM3EfxW0b5c6QRaw4W2D+o9fzhE6gaXDxhTaDR3TEagpQG7
 5Ah9Z69ExTofAArB4Ml/vYkwlHTNaogKD3uczf9LsSFd1HwOdddJNN5ECRPNOGgplWtb
 RpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687157988; x=1689749988;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v0bjX897cKkTr+QGHXfVJFQj7qsJcrHGU9tUpY/7pm4=;
 b=QpFtkr4rBXeZjxhHMDYYauDEGDbXHBNLYgxyecVkJ7hrl8Ovl23s0njJFEBhxmjb5A
 cdEVyfsEnFelVYRmeUm8givakBVAumUWRQvuEL+MS/RywkwuVfsCs75CsHLV/ISihjrn
 UCPTHGduBbWtrOWt0CDuSSAzz2O4unbI3S+aR7zMihA7eOHYyPrXnCz5rsE0o0gIo8sW
 L5jz4W6zdczOZhlsdIr6x51mCkl9HyNSNkOxVT+SBluORyAP5WHtkhhShlUoggI9YZMH
 Od9yqABtcmi7uSQl0iYftjIyPFQ5AG0dHKmWRv7QW8wE99/P1tlAges3Z4RUG4Gv+RSL
 350w==
X-Gm-Message-State: AC+VfDzsKRd2LVBuAKwrguSBodr7jAhQYxnLY5zpiQYqvNswHwpG4Wi2
 V70dkQidOSxSRU/fgzsoWeDhcYb9UXxyWM4owjjfZujX
X-Google-Smtp-Source: ACHHUZ4dt+DtLo5X2130Tcxu1OGgB8Yui2BXgdJ6zV56hPxiSg++0bV0KgA1MOVIYmleroNHNdXpHw==
X-Received: by 2002:a50:ed0d:0:b0:510:72b1:5f4e with SMTP id
 j13-20020a50ed0d000000b0051072b15f4emr5442970eds.22.1687157988018; 
 Sun, 18 Jun 2023 23:59:48 -0700 (PDT)
Received: from [192.168.69.129] (sar95-h02-176-184-10-225.dsl.sta.abo.bbox.fr.
 [176.184.10.225]) by smtp.gmail.com with ESMTPSA id
 u8-20020aa7d988000000b0051a4c1dc813sm1866529eds.82.2023.06.18.23.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jun 2023 23:59:47 -0700 (PDT)
Message-ID: <c1e1c570-828a-f943-adfe-7d0fc05a2389@linaro.org>
Date: Mon, 19 Jun 2023 08:59:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/6] util/async-teardown: Fall back to close fds one by
 one
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, qemu-devel@nongnu.org
Cc: Zhangjin Wu <falcon@tinylab.org>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20230616152737.23545-1-bmeng@tinylab.org>
 <20230616152737.23545-4-bmeng@tinylab.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230616152737.23545-4-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/16/23 17:27, Bin Meng wrote:
> When opening /proc/self/fd fails, current codes just return directly,
> but we can fall back to close fds one by one.
> 
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
> 
> (no changes since v1)
> 
>   util/async-teardown.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/util/async-teardown.c b/util/async-teardown.c
> index 3ab19c8740..7e0177a8da 100644
> --- a/util/async-teardown.c
> +++ b/util/async-teardown.c
> @@ -48,7 +48,11 @@ static void close_all_open_fd(void)
>   
>       dir = opendir("/proc/self/fd");
>       if (!dir) {
> -        /* If /proc is not mounted, there is nothing that can be done. */
> +        /* If /proc is not mounted, close fds one by one. */
> +        int open_max = sysconf(_SC_OPEN_MAX), i;
> +        for (i = 0; i < open_max; i++) {
> +                close(i);
> +        }
>           return;
>       }
>       /* Avoid closing the directory. */

Do we really need to make the 1M close calls?
The process is on its way to exit anyway...


r~


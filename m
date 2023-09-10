Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4A3799C92
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 06:22:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfBwO-0002zl-JT; Sun, 10 Sep 2023 00:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfBwJ-0002vv-SE
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 00:20:51 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qfBwH-0008AW-72
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 00:20:51 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a9f88b663cso2462197b6e.3
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 21:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694319647; x=1694924447;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Idn4SpoXhTBIcUWssorGxVnrnkjVjGBeBPgU3vnJMx4=;
 b=Cko+fK6OTVdOcRuRrYfZw4O/gQpAtwG7xzrUfrNFne9HI/Xw3h8BPkUqeeg21uDscr
 ljO2ruesKvm8upjFrPQw9mpbZKUCq9JR6SQAPJmGH4lXPnUpzEYc8AIcOSAJHQNpdDuf
 9BkhxAgcJdFoXubOFYMF56pOBZAG/VvbbnkHnWEsqV+SwzXWNUz81svzAF460UyokYGT
 s+FS+WXBruTIIZ9dtIB/aZc9n6blJG3aELtIzyiIpG5Bdwle/SPxwRqWQNFkTom8OG+M
 MVa9hYPgGaEF/9DwHK0NSNxpQkdtnrAVNDcQNM4kZRh2M2Bs2WIf0pocz1WIBjiS3OQh
 3l9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694319647; x=1694924447;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Idn4SpoXhTBIcUWssorGxVnrnkjVjGBeBPgU3vnJMx4=;
 b=Uppi/Iq/acmyU+YdeFBLD1aPvFP8yu/x3YX+Qd12s84SHcrhMQPXxk/W+8ZKMCGpk1
 E3eiMZC7dD298Ri2z4rQ1ojvYz8I5aSyP4wTE5xUUqh56f7vfi6PZh1BAERsOSpoZ8lr
 tT+xS/pHn4XVgZ3lYOuflwNtIZGSqiTdngNbGOD6qFmYmn5dR+P5Vgwzh4JNBFuTXVCk
 w6Hk7y/pPnk3ihlf3xhvpVSSj/xh4jOHuxxuDoCYLvif/Q6nwoOFtKio/MJHflBVIgIw
 E3Hs9jqsJ31G7bmMg+9h3QaY9JGggr2Ah/yQb35vvBtlwwCLePO1uwMpGkBUcvGuEYVE
 gUEA==
X-Gm-Message-State: AOJu0YwUiXqUAadtDOT2yDG7g8oxaGcsKDeOg/u6MsYOug7DLUtoZWg+
 3gTOO7kjhcPCKJskz07HwPgy2g==
X-Google-Smtp-Source: AGHT+IHWv9s+gQ8piEw+C7whJoevz4bSBF9Lx0BWIWe6u1p1wqyeXbM0ufzWv+7T9voRxdjHCE6+AQ==
X-Received: by 2002:a05:6808:198:b0:3a7:215c:e34 with SMTP id
 w24-20020a056808019800b003a7215c0e34mr8060616oic.15.1694319647632; 
 Sat, 09 Sep 2023 21:20:47 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 t5-20020a63b705000000b0056afdbd0a24sm142840pgf.9.2023.09.09.21.20.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Sep 2023 21:20:47 -0700 (PDT)
Message-ID: <fd472f38-e45d-4174-a179-926a6f501bb5@daynix.com>
Date: Sun, 10 Sep 2023 13:20:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/22] net/eth: Clean up local variable shadowing
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>
References: <20230904161235.84651-1-philmd@linaro.org>
 <20230904161235.84651-16-philmd@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230904161235.84651-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::235;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2023/09/05 1:12, Philippe Mathieu-Daudé wrote:
> Fix:
> 
>    net/eth.c:435:20: error: declaration shadows a local variable [-Werror,-Wshadow]
>              size_t input_size = iov_size(pkt, pkt_frags);
>                     ^
>    net/eth.c:413:16: note: previous declaration is here
>          size_t input_size = iov_size(pkt, pkt_frags);
>                 ^
> 
> Suggested-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   net/eth.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/net/eth.c b/net/eth.c
> index 649e66bb1f..3f680cc033 100644
> --- a/net/eth.c
> +++ b/net/eth.c
> @@ -432,8 +432,6 @@ _eth_get_rss_ex_src_addr(const struct iovec *pkt, int pkt_frags,
>           }
>   
>           if (opthdr.type == IP6_OPT_HOME) {
> -            size_t input_size = iov_size(pkt, pkt_frags);
> -
>               if (input_size < opt_offset + sizeof(opthdr)) {
>                   return false;
>               }

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>


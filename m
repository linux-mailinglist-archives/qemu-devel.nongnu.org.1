Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C8765821967
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 11:06:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKbes-0006oF-SG; Tue, 02 Jan 2024 05:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKber-0006o3-E0
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:06:01 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKbep-00069W-UH
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:06:01 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d858c56cbso22095095e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 02:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704189958; x=1704794758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ysrj5n0jlwnMyoQQzsjldGfRm4gY6TPT1Kj8UkAGcj4=;
 b=Tr11ovPKcuTAAuagf8psoStHujpf63MHWiyPrkN1QDWGn56jRoU4W9EmEl5C0KQ5Xg
 943m98twHWgNz0/Y+G53gZSUCOlNpAZFYg7yXWZomAiUBBGMglxob4FjWVc1V5k9HO6o
 G7FbvpqTNOFj/qEBN4ld5bWn7s3cbGLohk8TAJ3Z86B14c9AFfPZPiZWj0RwVu4zqcSF
 gB6nJj17BBUQM0V1PqKw6SYEDJpQe+s78rZuwqTr9Z4gZyOQF1awoV+/ZHNf7RI38EQg
 pjKppx3nJcF4tvmxPpGuQdUhfA5yuVJmqYotrRMBxLVnw7uc41BAmcmU+B7ovZNWwZ7n
 xWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704189958; x=1704794758;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ysrj5n0jlwnMyoQQzsjldGfRm4gY6TPT1Kj8UkAGcj4=;
 b=FK1RsWPLZDDqifXsm2P5qgzjFheK0EjPbYn72l+9MSGOuIJhI97W+IM2zAdyG/3j4/
 nXyP3eZjE6NVmFmDaK4JQRynmKWfLgG3ODemBZjotESJgvvnZoViDvF4TsxUlVs6GZ8Q
 Aqpag/edWcAxPxSih/kjKAePGjFFlx1CgFZ6F6Xj+hZzekvIjmoXmB8/KEUVeH2KzsDO
 jWAR0GgLDGb9hgHz/ncV79NXRL65Lbmie4h88osnr/USomlSxT5N8ZkfyktnPLEsomXk
 fZkxbaCO3PjJedr/ZudVvisYDpVtwZYHV0Oeh9LbwieNYBHPs4Z4GvPML89jafuopprc
 4+OQ==
X-Gm-Message-State: AOJu0Yz+lQD17jZ6Mb0nYXMPUskxtaJFmburiCCHNy0RyQALejMH26dk
 /xqvLcpUfr+VlN9EZ3Zi7w+B3AyNuXVfTQ==
X-Google-Smtp-Source: AGHT+IHhFiqOGjoLXbqXV6sFfQEFEfuNwVnhaHGBGa7p8f9IvU88GPbzwhF9wWh0AdrP5V5s5P13Pg==
X-Received: by 2002:a05:600c:4208:b0:40d:39bb:b8eb with SMTP id
 x8-20020a05600c420800b0040d39bbb8ebmr9459446wmh.118.1704189958361; 
 Tue, 02 Jan 2024 02:05:58 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 k16-20020a5d6e90000000b0033667867a66sm27932048wrz.101.2024.01.02.02.05.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 02:05:57 -0800 (PST)
Message-ID: <dafc11b4-3f56-4c22-b776-a8f644b2ad26@linaro.org>
Date: Tue, 2 Jan 2024 11:05:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11] migration: Fix migration_channel_read_peek() error
 path
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
 <20231231093016.14204-10-avihaih@nvidia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231231093016.14204-10-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

+Markus

On 31/12/23 10:30, Avihai Horon wrote:
> migration_channel_read_peek() calls qio_channel_readv_full() and handles
> both cases of return value == 0 and return value < 0 the same way, by
> calling error_setg() with errp. However, if return value < 0, errp is
> already set, so calling error_setg() with errp will lead to an assert.

I suppose the API would be safer by passing &len as argument and
return a boolean.

> Fix it by handling these cases separately, calling error_setg() with
> errp only in return value == 0 case.
> 
> Fixes: 6720c2b32725 ("migration: check magic value for deciding the mapping of channels")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   migration/channel.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index ca3319a309..f9de064f3b 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -117,9 +117,12 @@ int migration_channel_read_peek(QIOChannel *ioc,
>           len = qio_channel_readv_full(ioc, &iov, 1, NULL, NULL,
>                                        QIO_CHANNEL_READ_FLAG_MSG_PEEK, errp);
>   
> -        if (len <= 0 && len != QIO_CHANNEL_ERR_BLOCK) {
> -            error_setg(errp,
> -                       "Failed to peek at channel");
> +        if (len < 0 && len != QIO_CHANNEL_ERR_BLOCK) {
> +            return -1;
> +        }
> +
> +        if (len == 0) {
> +            error_setg(errp, "Failed to peek at channel");
>               return -1;
>           }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



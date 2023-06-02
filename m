Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 81389720516
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 17:00:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q56FP-0007UD-Jg; Fri, 02 Jun 2023 10:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q56FL-0007Tk-Ns
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:59:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q56FK-00050D-2t
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 10:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685717956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QjGRM76U77ZPsh9a0C/FR4KUEyHtTJsJCBGz7WUNJbw=;
 b=PHtTE5ouAePY2whV95kyml9lcq9Iay+9YZNnbx9n+q7BE5XresTZRX2/OVXHkdjtXLyodN
 WyI+kreCjzfQkE9754FPm+aGxAQ46qZdTYq3qmoaVefD9SiO6U1FNkxqjU2LCw7evlCqFe
 U1XkSAc693rzyDDirKLL/2NFI3WW/Ew=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-ET5JNGVLNbqPRsQ89dChww-1; Fri, 02 Jun 2023 10:59:15 -0400
X-MC-Unique: ET5JNGVLNbqPRsQ89dChww-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-514a4cfa313so1519251a12.0
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 07:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685717954; x=1688309954;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QjGRM76U77ZPsh9a0C/FR4KUEyHtTJsJCBGz7WUNJbw=;
 b=SSW5YTvQLO/JUeAEPyKtXO30FyBpqxlnRHm/aGGgk/BOlNUPel2icZbsoIJRPu5uNJ
 cQoGHoMUoit7Ha9vNj1n1IEtkCIT6+dqQBIt3QBGzP1TV2aO24AmmtMm32tFaYMVVZ5I
 6D5lPYHiE5v6zFsC4qpHFiX1+xgrHQMnIYerDLhqGikcfTO8JuQpeULbkxSFb9AyGO5O
 QmdBF+0plHnSOiQEzSqUWRCLdYcLBxXt+YYkw8KsGW5FfW4mhtTVLh5UlF3hblNG6A3X
 dIKFVeBObtA0ezblyyN1JzT4FSEoBr800KE90A3lj4+U22DS19dHmjcOu4N8vZ0pzqYC
 3ZqQ==
X-Gm-Message-State: AC+VfDyB/tY5LRyeI8AJ/dZ0CzKL6iotts3fd0cMP+WHt8QJbRE+XUNE
 dYvo778ttbZ7Y9QfU5gp/MmzjdKGRdZXTaSSHbBCPhmKbDwJ6OJB3/zDw2T6baJ0UrUUBLVSjTa
 AS4a+7GoGvMA9dNA=
X-Received: by 2002:aa7:c909:0:b0:514:97dc:9d4e with SMTP id
 b9-20020aa7c909000000b0051497dc9d4emr2160619edt.7.1685717954522; 
 Fri, 02 Jun 2023 07:59:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6b8r4KupietKJsVrV/so2HsjJ33HNwIzeRU7cQGMOpFjd4jxjHH3TyfY7rWBptuITpYTgbmw==
X-Received: by 2002:aa7:c909:0:b0:514:97dc:9d4e with SMTP id
 b9-20020aa7c909000000b0051497dc9d4emr2160610edt.7.1685717954266; 
 Fri, 02 Jun 2023 07:59:14 -0700 (PDT)
Received: from ?IPV6:2003:cf:d72e:f7e0:e1ec:6307:c799:c188?
 (p200300cfd72ef7e0e1ec6307c799c188.dip0.t-ipconnect.de.
 [2003:cf:d72e:f7e0:e1ec:6307:c799:c188])
 by smtp.gmail.com with ESMTPSA id
 r21-20020aa7c155000000b0051421010690sm762752edp.21.2023.06.02.07.59.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 07:59:13 -0700 (PDT)
Message-ID: <32385c08-0c72-bf53-d5bb-5fa13dce7089@redhat.com>
Date: Fri, 2 Jun 2023 16:59:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 5/5] parallels: Image repairing in parallels_open()
Content-Language: en-US
To: Alexander Ivanov <alexander.ivanov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, stefanha@redhat.com,
 vsementsov@yandex-team.ru, kwolf@redhat.com
References: <20230529151503.34006-1-alexander.ivanov@virtuozzo.com>
 <20230529151503.34006-6-alexander.ivanov@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230529151503.34006-6-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 29.05.23 17:15, Alexander Ivanov wrote:
> Repair an image at opening if the image is unclean or out-of-image
> corruption was detected.
>
> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
> ---
>   block/parallels.c | 65 +++++++++++++++++++++++++----------------------
>   1 file changed, 35 insertions(+), 30 deletions(-)
>
> diff --git a/block/parallels.c b/block/parallels.c
> index d64e8007d5..7bbd5cb112 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c

[...]

> @@ -1130,6 +1101,40 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>           goto fail;
>       }
>       qemu_co_mutex_init(&s->lock);
> +
> +    if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
> +        s->header_unclean = true;
> +    }
> +
> +    for (i = 0; i < s->bat_size; i++) {
> +        sector = bat2sect(s, i);
> +        if (sector + s->tracks > s->data_end) {
> +            s->data_end = sector + s->tracks;
> +        }
> +    }
> +
> +    /*
> +     * We don't repair the image here if it's opened for checks. Also we don't
> +     * want to change inactive images and can't change readonly images.
> +     */
> +    if ((flags & (BDRV_O_CHECK | BDRV_O_INACTIVE)) || !(flags & BDRV_O_RDWR)) {
> +        return 0;
> +    }
> +
> +    /*
> +     * Repair the image if it's dirty or
> +     * out-of-image corruption was detected.
> +     */
> +    if (s->data_end > file_nb_sectors || s->header_unclean) {
> +        BdrvCheckResult res;
> +        ret = bdrv_check(bs, &res, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
> +        if (ret < 0) {

Should we also verify that res->corruptions == res->corruptions_fixed && 
res->check_errors == 0?

> +            error_free(s->migration_blocker);

I’d move this clean-up to a new error path below, then we could even 
reuse that where migrate_add_blocker() fails.

Anyway, not wrong as-is, just suggestion, so:

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

> +            error_setg_errno(errp, -ret, "Could not repair corrupted image");
> +            goto fail;
> +        }
> +    }
> +
>       return 0;
>   
>   fail_format:



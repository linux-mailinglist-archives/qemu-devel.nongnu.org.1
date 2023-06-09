Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 679BB729F79
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 18:00:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7cNR-0004io-DC; Fri, 09 Jun 2023 09:42:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q7cNQ-0004iJ-0F
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 09:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q7cNO-0003ta-C8
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 09:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686318121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+Evb9H/2A9WJhBqIkLWtUG0H0Udea+11YBS1tu+WaiE=;
 b=RwKscqzZX2LEp8GAJrvlb2VZVb4mWE0Y4d+Z1V2ET1npxXK2FRqmBoW0ro80/nfR05fPTO
 tt/XXC94iBVh7sGsLzXTXaFFHcJEbbtOkB0WkFBlGV0j8td7kHZyeRVjkGnIAPrbqCFo4l
 yjfbS6RUhFY5lGR6253QyZFB4axIDy4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-3xC8EhjyOcamfsYUwlJxrA-1; Fri, 09 Jun 2023 09:41:59 -0400
X-MC-Unique: 3xC8EhjyOcamfsYUwlJxrA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9750bb0695dso337701666b.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jun 2023 06:41:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686318118; x=1688910118;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+Evb9H/2A9WJhBqIkLWtUG0H0Udea+11YBS1tu+WaiE=;
 b=Auw2HuIWzU4KQtD3heFYdlyqHJEsxOuYolku/sSH4P1dWmL8n3C4pbDMN9jmVYvjoL
 k9/70pJXkgbkoF8VgrycQt5hIPSVAIjMj1S61lDnlQj7g6jnhykcNXQClpXWBlW9v43O
 h4H6FirnlJ+63Iv4hWEIOEs9Ci8dSg5IPtWm4LNFP/BLMveTerNLMfV0vVL2gi/tXV+J
 KcplJLCAGeX0TioHfyxNZBGx/oH0kRwvJBVhpi/f64YJH/2Lwy7uA1GY8L0v3qXbYlp0
 U0nJh7hVft2ltIauLI3olqb1t1dusK0SfHPiiQ4FcMKMvyxTHLOUXtHjKMlY+eP3Po3W
 Xjeg==
X-Gm-Message-State: AC+VfDzDWyTcq8qYjcByJ43t2F2iEINnGURGiJDv8XxyKiuZmfV5Entp
 PUsp09cSzhqFwH0wPFzunHeRIKfIZksb2ZePnWR/i2pKWQak0CDyJjzu+m8fI5eKhtpH5Ny6KIz
 dwognN+GUldsuDYA=
X-Received: by 2002:a17:907:3f91:b0:978:8a30:a8b with SMTP id
 hr17-20020a1709073f9100b009788a300a8bmr2084856ejc.27.1686318118591; 
 Fri, 09 Jun 2023 06:41:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7EWtgidvI5IeDbVa5SlkQrcWdD0OVjFj9rsiDbejtURstfo4FAtt7CMO8qBBm01FRQNErWZA==
X-Received: by 2002:a17:907:3f91:b0:978:8a30:a8b with SMTP id
 hr17-20020a1709073f9100b009788a300a8bmr2084831ejc.27.1686318118270; 
 Fri, 09 Jun 2023 06:41:58 -0700 (PDT)
Received: from ?IPV6:2003:cf:d727:f67d:a473:8b17:9e70:3186?
 (p200300cfd727f67da4738b179e703186.dip0.t-ipconnect.de.
 [2003:cf:d727:f67d:a473:8b17:9e70:3186])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a170906c31400b0096f71ace804sm1306647ejz.99.2023.06.09.06.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jun 2023 06:41:57 -0700 (PDT)
Message-ID: <fd771f6f-8f5f-cb2f-a20c-da0f149a06a6@redhat.com>
Date: Fri, 9 Jun 2023 15:41:56 +0200
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
 <32385c08-0c72-bf53-d5bb-5fa13dce7089@redhat.com>
 <e22757a4-9853-9044-3a3f-6d8f0e486bb3@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <e22757a4-9853-9044-3a3f-6d8f0e486bb3@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 09.06.23 15:21, Alexander Ivanov wrote:
>
>
> On 6/2/23 16:59, Hanna Czenczek wrote:
>> On 29.05.23 17:15, Alexander Ivanov wrote:
>>> Repair an image at opening if the image is unclean or out-of-image
>>> corruption was detected.
>>>
>>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>>> ---
>>>   block/parallels.c | 65 
>>> +++++++++++++++++++++++++----------------------
>>>   1 file changed, 35 insertions(+), 30 deletions(-)
>>>
>>> diff --git a/block/parallels.c b/block/parallels.c
>>> index d64e8007d5..7bbd5cb112 100644
>>> --- a/block/parallels.c
>>> +++ b/block/parallels.c
>>
>> [...]
>>
>>> @@ -1130,6 +1101,40 @@ static int parallels_open(BlockDriverState 
>>> *bs, QDict *options, int flags,
>>>           goto fail;
>>>       }
>>>       qemu_co_mutex_init(&s->lock);
>>> +
>>> +    if (le32_to_cpu(ph.inuse) == HEADER_INUSE_MAGIC) {
>>> +        s->header_unclean = true;
>>> +    }
>>> +
>>> +    for (i = 0; i < s->bat_size; i++) {
>>> +        sector = bat2sect(s, i);
>>> +        if (sector + s->tracks > s->data_end) {
>>> +            s->data_end = sector + s->tracks;
>>> +        }
>>> +    }
>>> +
>>> +    /*
>>> +     * We don't repair the image here if it's opened for checks. 
>>> Also we don't
>>> +     * want to change inactive images and can't change readonly 
>>> images.
>>> +     */
>>> +    if ((flags & (BDRV_O_CHECK | BDRV_O_INACTIVE)) || !(flags & 
>>> BDRV_O_RDWR)) {
>>> +        return 0;
>>> +    }
>>> +
>>> +    /*
>>> +     * Repair the image if it's dirty or
>>> +     * out-of-image corruption was detected.
>>> +     */
>>> +    if (s->data_end > file_nb_sectors || s->header_unclean) {
>>> +        BdrvCheckResult res;
>>> +        ret = bdrv_check(bs, &res, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
>>> +        if (ret < 0) {
>>
>> Should we also verify that res->corruptions == res->corruptions_fixed 
>> && res->check_errors == 0?
> If ret == 0 there must be res->check_errors == 0 and res->corruptions 
> == res->corruptions_fixed.

OK.

>>
>>> + error_free(s->migration_blocker);
>>
>> I’d move this clean-up to a new error path below, then we could even 
>> reuse that where migrate_add_blocker() fails.
> Is this guaranteed that s->migration_blocker is NULL at the function 
> parallels_open() beginning? If so it could be easy to move the clean-up,
> otherwise it could lead to code complication.

Three answers here:

First, I just realized that we probably need to undo the 
migrate_add_blocker() call, too, i.e. call migrate_del_blocker() here.

Second, I’m pretty sure that s->migration_blocker must be NULL before 
the error_setg(&s->migration_blocker) call, because error_setg() asserts 
that the *errp passed to it is NULL.

Third, I meant to add a new path e.g.:

```
fail_blocker:
     error_free(s->migration_blocker);
fail_format:
[...]
```

And then use `goto fail_blocker;` here and in the migrate_add_blocker() 
error path, so it shouldn’t really matter whether s->migration_blocker 
is NULL before the error_setg() call.  But then again, I think the 
probably necessary migrate_del_blocker() call complicates things further.

Hanna

>>
>> Anyway, not wrong as-is, just suggestion, so:
>>
>> Reviewed-by: Hanna Czenczek <hreitz@redhat.com>
>>
>>> +            error_setg_errno(errp, -ret, "Could not repair 
>>> corrupted image");
>>> +            goto fail;
>>> +        }
>>> +    }
>>> +
>>>       return 0;
>>>     fail_format:
>>
>



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C59C4C24123
	for <lists+qemu-devel@lfdr.de>; Fri, 31 Oct 2025 10:16:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElEh-0004sc-DH; Fri, 31 Oct 2025 05:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vElEe-0004s2-QQ
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:15:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vElEZ-0000m7-Qn
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:15:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761902132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=awSnR3nJBJHP6MIYuOm9cYKKBoRc3PPSOdT9HWoYXKs=;
 b=T3p7qPSaJUrHDYzC1pUuikanAkoT3j2u5gxNMGi7utfUVLpIOKJvJMopWWni5P0tkHfBdS
 ClkoBqGlL/iiy0dJHzRHd9ebUvXlEXDPtoKkowEauJbOVqvi75HtVbaquDrYRyRMdLmg4H
 ZuEpYaCM7l4eRR3sTz/tuB7zso10X9c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-RBny8SwJOKGC5hen-8dqDw-1; Fri, 31 Oct 2025 05:15:30 -0400
X-MC-Unique: RBny8SwJOKGC5hen-8dqDw-1
X-Mimecast-MFC-AGG-ID: RBny8SwJOKGC5hen-8dqDw_1761902130
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-40cfb98eddbso1470885f8f.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 02:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761902129; x=1762506929;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=awSnR3nJBJHP6MIYuOm9cYKKBoRc3PPSOdT9HWoYXKs=;
 b=pcvXikd1agddbDtRWg73Rre1dzzAkS5wFx6rNPItEgMrr8H7eoPYjtoJtoJIQEniLv
 SCBR8752FqED3wr7sI7e0h8AbC4iAJYU5IK7NcYK5oTO7BSWS5+D1KYh5aWTB5NFNmqI
 cKOxsSmXZp/tmx5t2e/a7r0Ux7uXsRxYavKMcnvZpJS1q4muWiAM8RgRiPIi739UcLSt
 TRH5tcSYqqteURyR6AU3RuCyIURwzjKlZ23aITIo254/hmRBkZgv5f6r988kS9Mv0Mn/
 qAQeh5hcuwfe20b0LHVoC6TbsuGbNv2rX7h0w216cpdD7pGQ/WKNAD/B56MrwiMpFImy
 pebw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2KiwPs1LL7VzWHYXrrbOsvHIQGtsel38byjXD7vsmOvboQVVAeLIfQoKSG610vbdrJA+Va2E2ZKo8@nongnu.org
X-Gm-Message-State: AOJu0YwCDCNdG5uPI4GSv8p9oVwDZRWgQ/03qi6MsrVBibhSESV9L/AU
 Z5xGKMP3ShXDAuX53qJvtyjfI93e0aXrRcGvd//ivG1h9tnvWn5Ta1fJO/8CdzcIVMh+0WMyhG4
 K4WcfGKqIrSLYuLdBa2mueOdfX1biX4UPMy7N7r6oBqaYnbw10mD5o8VG
X-Gm-Gg: ASbGncv90DK19dv9W4P7boAq2GoYMlODERQLxuIf+VpTqF39Zte2mu855dfSQgxyxoc
 U38gz2UM+pClQmTwys/uPJtVOg8s3JsuGaBbdz7FhtUTis62eX2hH/7hHhaqxQ43jQYBzfA0ymt
 oQJ0bVBwd0o48VtT5GVAM8hjQLf9YthJyaoGS+1jtXlryrdlUHGxoXe2aH55irysOg8sSNvS3IH
 kBv2R52cmt2eF7Ojg3rLg1d5y2F7xYVD5si7aSXJ35fC56X5v4nLqcNjTTuRZa7TFlM4kUk1qzU
 8FrlrFc54s4eGC1/2R24Mt8d5kVEBJC9VGcmJZz9KB1aLKNLeO1iTo8Q9mtD1srUkLUta9IlzN9
 +h2gmDDSyRvpDYRGN+zJj3SYjJ2m8vIK82xYa2uuFpvuuuWTJEk0YcEE7KG9+LaB8FhJl+XqJCC
 0pi26CLGw4erssR8zpJGOwDwLj/WpM
X-Received: by 2002:a05:6000:2b07:b0:429:b857:6fce with SMTP id
 ffacd0b85a97d-429b8577366mr3028681f8f.8.1761902129486; 
 Fri, 31 Oct 2025 02:15:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdM55TvrEnWiyKpVVjMcvnP5xSDS0BcGlHctTlyfN9cV7w8zWvT+k4jORQxciLCRh0DfjZCw==
X-Received: by 2002:a05:6000:2b07:b0:429:b857:6fce with SMTP id
 ffacd0b85a97d-429b8577366mr3028653f8f.8.1761902129018; 
 Fri, 31 Oct 2025 02:15:29 -0700 (PDT)
Received: from ?IPV6:2003:cf:d717:1f4c:b757:9963:8006:395e?
 (p200300cfd7171f4cb75799638006395e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f4c:b757:9963:8006:395e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c13e16e3sm2513723f8f.28.2025.10.31.02.15.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Oct 2025 02:15:28 -0700 (PDT)
Message-ID: <102c3064-6615-4958-b3dc-00fd2ba99b10@redhat.com>
Date: Fri, 31 Oct 2025 10:15:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] curl: Fix coroutine waking
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
References: <20251028163343.116249-1-hreitz@redhat.com>
 <20251028163343.116249-6-hreitz@redhat.com> <aQJHebvyff9rKAsz@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <aQJHebvyff9rKAsz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29.10.25 17:57, Kevin Wolf wrote:
> Am 28.10.2025 um 17:33 hat Hanna Czenczek geschrieben:
>> If we wake a coroutine from a different context, we must ensure that it
>> will yield exactly once (now or later), awaiting that wake.
>>
>> curl’s current .ret == -EINPROGRESS loop may lead to the coroutine not
>> yielding if the request finishes before the loop gets run.  To fix it,
>> drop the loop and just yield exactly once, unless the request is served
>> from the cache or failed before it was submitted – that last part makes
>> it a bit complicated, as the result of curl_find_buf() now needs to be a
>> tristate.
>>
>> (Can be reproduced with multiqueue by adding a usleep(100000) before the
>> `while (acb.ret == -EINPROGRESS)` loop.)
>>
>> Also, add a comment why aio_co_wake() is safe regardless of whether the
>> coroutine and curl_multi_check_completion() run in the same context.
>>
>> Cc: qemu-stable@nongnu.org
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>   block/curl.c | 55 +++++++++++++++++++++++++++++++++++-----------------
>>   1 file changed, 37 insertions(+), 18 deletions(-)
>>
>> diff --git a/block/curl.c b/block/curl.c
>> index 68cf83ce55..65996a8866 100644
>> --- a/block/curl.c
>> +++ b/block/curl.c
>> @@ -124,6 +124,16 @@ typedef struct BDRVCURLState {
>>       char *proxypassword;
>>   } BDRVCURLState;
>>   
>> +/** Possible result states of curl_find_buf() */
>> +typedef enum {
>> +    /* No buffer found, need to create new request */
>> +    CURL_NO_BUF_FOUND,
>> +    /* Buffer found, request filled and done */
>> +    CURL_REQUEST_FILLED,
>> +    /* Ongoing request found, need to yield */
>> +    CURL_REQUEST_ONGOING,
>> +} CURLFindBufResult;
>> +
>>   static void curl_clean_state(CURLState *s);
>>   static void curl_multi_do(void *arg);
>>   
>> @@ -258,8 +268,8 @@ read_end:
>>   }
>>   
>>   /* Called with s->mutex held.  */
>> -static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
>> -                          CURLAIOCB *acb)
>> +static CURLFindBufResult curl_find_buf(BDRVCURLState *s, uint64_t start,
>> +                                       uint64_t len, CURLAIOCB *acb)
>>   {
>>       int i;
>>       uint64_t end = start + len;
>> @@ -289,7 +299,7 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
>>                   qemu_iovec_memset(acb->qiov, clamped_len, 0, len - clamped_len);
>>               }
>>               acb->ret = 0;
>> -            return true;
>> +            return CURL_REQUEST_FILLED;
>>           }
>>   
>>           // Wait for unfinished chunks
>> @@ -307,13 +317,13 @@ static bool curl_find_buf(BDRVCURLState *s, uint64_t start, uint64_t len,
>>               for (j=0; j<CURL_NUM_ACB; j++) {
>>                   if (!state->acb[j]) {
>>                       state->acb[j] = acb;
>> -                    return true;
>> +                    return CURL_REQUEST_ONGOING;
>>                   }
>>               }
>>           }
>>       }
>>   
>> -    return false;
>> +    return CURL_NO_BUF_FOUND;
>>   }
>>   
>>   /* Called with s->mutex held.  */
>> @@ -378,6 +388,16 @@ static void curl_multi_check_completion(BDRVCURLState *s)
>>                   acb->ret = error ? -EIO : 0;
>>                   state->acb[i] = NULL;
>>                   qemu_mutex_unlock(&s->mutex);
>> +                /*
>> +                 * Current AioContext is the BDS context, which may or may not
>> +                 * be the request (coroutine) context.
>> +                 * - If it is, the coroutine must have yielded or the FD handler
>> +                 *   (curl_multi_do()/curl_multi_timeout_do()) could not have
>> +                 *   been called and we would not be here
>> +                 * - If it is not, it doesn't matter whether it has already
>> +                 *   yielded or not; it will be scheduled once it does yield
>> +                 * So aio_co_wake() is safe to call.
>> +                 */
>>                   aio_co_wake(acb->co);
>>                   qemu_mutex_lock(&s->mutex);
>>               }
>> @@ -868,7 +888,8 @@ out_noclean:
>>       return -EINVAL;
>>   }
>>   
>> -static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
>> +/* Return whether a request was submitted that requires yielding */
>> +static bool coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
>>   {
>>       CURLState *state;
>>       int running;
>> @@ -877,13 +898,15 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
>>   
>>       uint64_t start = acb->offset;
>>       uint64_t end;
>> +    CURLFindBufResult find_buf_res;
>>   
>> -    qemu_mutex_lock(&s->mutex);
>> +    QEMU_LOCK_GUARD(&s->mutex);
>>   
>>       // In case we have the requested data already (e.g. read-ahead),
>>       // we can just call the callback and be done.
>> -    if (curl_find_buf(s, start, acb->bytes, acb)) {
>> -        goto out;
>> +    find_buf_res = curl_find_buf(s, start, acb->bytes, acb);
>> +    if (find_buf_res != CURL_NO_BUF_FOUND) {
>> +        return find_buf_res == CURL_REQUEST_ONGOING;
>>       }
>>   
>>       // No cache found, so let's start a new request
>> @@ -898,7 +921,7 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
>>       if (curl_init_state(s, state) < 0) {
>>           curl_clean_state(state);
>>           acb->ret = -EIO;
>> -        goto out;
>> +        return false;
>>       }
>>   
>>       acb->start = 0;
>> @@ -913,7 +936,7 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
>>       if (state->buf_len && state->orig_buf == NULL) {
>>           curl_clean_state(state);
>>           acb->ret = -ENOMEM;
>> -        goto out;
>> +        return false;
>>       }
>>       state->acb[0] = acb;
>>   
>> @@ -925,14 +948,12 @@ static void coroutine_fn curl_setup_preadv(BlockDriverState *bs, CURLAIOCB *acb)
>>           acb->ret = -EIO;
>>   
>>           curl_clean_state(state);
>> -        goto out;
>> +        return false;
>>       }
>>   
>>       /* Tell curl it needs to kick things off */
>>       curl_multi_socket_action(s->multi, CURL_SOCKET_TIMEOUT, 0, &running);
>> -
>> -out:
>> -    qemu_mutex_unlock(&s->mutex);
>> +    return true;
>>   }
>>   
>>   static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
>> @@ -941,14 +962,12 @@ static int coroutine_fn curl_co_preadv(BlockDriverState *bs,
>>   {
>>       CURLAIOCB acb = {
>>           .co = qemu_coroutine_self(),
>> -        .ret = -EINPROGRESS,
>>           .qiov = qiov,
>>           .offset = offset,
>>           .bytes = bytes
>>       };
> Let's leave -EINPROGRESS here even if no other code checks for this
> value any more. It can be helpful for debugging when you can distinguish
> "completed successfully" from "still running".

Does that mean you want me to keep the `complete` field on rbd and nfs, too?

>>   
>> -    curl_setup_preadv(bs, &acb);
>> -    while (acb.ret == -EINPROGRESS) {
>> +    if (curl_setup_preadv(bs, &acb)) {
>>           qemu_coroutine_yield();
>>       }
>>       return acb.ret;
> That whole pattern of returning true and false or even a new enum
> everywhere to tell if we are waiting for something felt strange to me.
> Took me a while, but I think now I know what I expected instead: Why
> don't these places just yield immediately instead of requiring the outer
> layer to understand what happened in the functions it called?

I was considering the same.  My result was, if they yielded immediately, 
we might as well fully inline curl_setup_preadv() into this function.  I 
didn’t want to do that at the time, but if you prefer, no problem.

Hanna



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB86C75CC38
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 17:43:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMsHM-0007U4-RP; Fri, 21 Jul 2023 11:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMsHK-0007Sp-CZ
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 11:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMsHI-0000Gy-Og
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 11:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689954168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fqttlbINTJGWWWyvdd+kGVH6UkxxjhXACDFdQmoaMCU=;
 b=I09s0X9064pvF+8CUORuRAP6g/jW7RxOBKTefd99ICqw7Ka76m8UdBPA1tLRCkwEA42xeB
 mORH94dTUP2O66joPRIaHAKViXrgqgYxXIHuTOUbtVX6CRSdIP/BjXTi6iyd0OXMykVFzw
 lSyW9QO3T+dbQqsGa1nAixA3uxamdUM=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-rrpXDvq2O-iZzJMR-2vnpQ-1; Fri, 21 Jul 2023 11:42:46 -0400
X-MC-Unique: rrpXDvq2O-iZzJMR-2vnpQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b70bfcd15aso19506421fa.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 08:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689954165; x=1690558965;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fqttlbINTJGWWWyvdd+kGVH6UkxxjhXACDFdQmoaMCU=;
 b=gJID2ANA8WrLB7uEiaV18w5E/EsqAx6F2FKMx3bXa/5pOZkweMrCvVeXEV1Dl2uSVI
 YmMbYYWwCw4TKLj4yPKbuviclVQ35X1iRo6zFj7cqzEOJZPejCxKLBTbCMrssr+uU6JG
 3sdrcx1zsyG3j52VUtsxh0tFA9uSWSNITtBwXlO5nipFA+Dd9kuVW0LdITooGPOjOxQ8
 +RA9XqPmaMSGYEgmdKQjWDK7AU1qNhtZ7RiLe0q0EEfSPs8WogxwvmHUvbxawICyGya0
 qmTmpSLuz1uE7alYLtFa9ZU7I6IzXimocfz77amkTWqQRAqe6Y91MPd5o/8eoYlbIjGn
 21Zg==
X-Gm-Message-State: ABy/qLa06GIBX/atl6mJPalrszUfSj+VFU19WwsLetyvS5kU708iY2OQ
 gE0NW7zLL89aihTlaxtNq8C34pEzMM764WjjEllsF5IfI828py6HLxLG4TOhKSAtatzPgciF3YW
 pv2JgRJdGH8/KfUU=
X-Received: by 2002:a05:651c:102d:b0:2b9:5c2b:6da4 with SMTP id
 w13-20020a05651c102d00b002b95c2b6da4mr1987840ljm.27.1689954165342; 
 Fri, 21 Jul 2023 08:42:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE/RhSDUgGN1H9YpAcNViQfJi3YsiEypjjDO+wsIzNDCNK5Qq6Xyc4yrgL78R9JDa9BVvC2bQ==
X-Received: by 2002:a05:651c:102d:b0:2b9:5c2b:6da4 with SMTP id
 w13-20020a05651c102d00b002b95c2b6da4mr1987821ljm.27.1689954165023; 
 Fri, 21 Jul 2023 08:42:45 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 m26-20020a170906849a00b00982a352f078sm2279206ejx.124.2023.07.21.08.42.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 08:42:44 -0700 (PDT)
Message-ID: <7b99795b-68b0-d71d-8ded-9b7fd2517215@redhat.com>
Date: Fri, 21 Jul 2023 17:42:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PATCH v3 3/6] throttle: support read-only and write-only
To: zhenwei pi <pizhenwei@bytedance.com>, berto@igalia.com, kwolf@redhat.com, 
 groug@kaod.org, qemu_oss@crudebyte.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com
References: <20230713064111.558652-1-pizhenwei@bytedance.com>
 <20230713064111.558652-4-pizhenwei@bytedance.com>
Content-Language: en-US
In-Reply-To: <20230713064111.558652-4-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 13.07.23 08:41, zhenwei pi wrote:
> Only one direction is necessary in several scenarios:
> - a read-only disk
> - operations on a device are considered as *write* only. For example,
>    encrypt/decrypt/sign/verify operations on a cryptodev use a single
>    *write* timer(read timer callback is defined, but never invoked).
>
> Allow a single direction in throttle, this reduces memory, and uplayer
> does not need a dummy callback any more.
>
> Reviewed-by: Alberto Garcia<berto@igalia.com>
> Signed-off-by: zhenwei pi<pizhenwei@bytedance.com>
> ---
>   util/throttle.c | 32 ++++++++++++++++++++++----------
>   1 file changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/util/throttle.c b/util/throttle.c
> index 5642e61763..c0bd0c26c3 100644
> --- a/util/throttle.c
> +++ b/util/throttle.c
> @@ -199,12 +199,17 @@ static bool throttle_compute_timer(ThrottleState *ts,
>   void throttle_timers_attach_aio_context(ThrottleTimers *tt,
>                                           AioContext *new_context)
>   {
> -    tt->timers[THROTTLE_READ] =
> -        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
> -                      tt->timer_cb[THROTTLE_READ], tt->timer_opaque);
> -    tt->timers[THROTTLE_WRITE] =
> -        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
> -                      tt->timer_cb[THROTTLE_WRITE], tt->timer_opaque);
> +    if (tt->timer_cb[THROTTLE_READ]) {
> +        tt->timers[THROTTLE_READ] =
> +            aio_timer_new(new_context, tt->clock_type, SCALE_NS,
> +                          tt->timer_cb[THROTTLE_READ], tt->timer_opaque);
> +    }
> +
> +    if (tt->timer_cb[THROTTLE_WRITE]) {
> +        tt->timers[THROTTLE_WRITE] =
> +            aio_timer_new(new_context, tt->clock_type, SCALE_NS,
> +                          tt->timer_cb[THROTTLE_WRITE], tt->timer_opaque);
> +    }

  I think a `for (int i = 0; i < THROTTLE_MAX; i++)` loop would make 
this nicer.  (Again: Optional.)

>   }
>   
>   /*

[...]

> @@ -272,7 +280,7 @@ void throttle_timers_destroy(ThrottleTimers *tt)
>   /* is any throttling timer configured */
>   bool throttle_timers_are_initialized(ThrottleTimers *tt)
>   {
> -    if (tt->timers[0]) {
> +    if (tt->timers[THROTTLE_READ] || tt->timers[THROTTLE_WRITE]) {

Not wrong, but I’d prefer the more general

```
for (int i = 0; i < THROTTLE_MAX; i++) {
     if (tt->timers[i]) {
         return true;
     }
}
return false;
```

>           return true;
>       }
>   
> @@ -424,8 +432,12 @@ bool throttle_schedule_timer(ThrottleState *ts,
>   {
>       int64_t now = qemu_clock_get_ns(tt->clock_type);
>       int64_t next_timestamp;
> +    QEMUTimer *timer;
>       bool must_wait;
>   
> +    timer = is_write ? tt->timers[THROTTLE_WRITE] : tt->timers[THROTTLE_READ];

Could be shorter as `timer = tt->timers[is_write ? THROTTLE_WRITE : 
THROTTLE_READ];`.

Anyway, I only have style suggestion to offer, so either way:

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

> +    assert(timer);
> +
>       must_wait = throttle_compute_timer(ts,
>                                          is_write,
>                                          now,



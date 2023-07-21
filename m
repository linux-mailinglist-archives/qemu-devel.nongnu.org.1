Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A306D75CD1C
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 18:05:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMsbf-0000Yb-Ru; Fri, 21 Jul 2023 12:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMsba-0000Sv-Hh
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 12:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMsbX-0005ve-9X
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 12:03:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689955421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRMLVhFOooTCIj9VXUc3/ml+7iqjzNRXoHoeE7aNh/w=;
 b=DsWd4bRs2X870dLmXxRb9UaHBPmUnq744kTYb08Xy3lT5qPSOl9qzsdnswLZ1ODhbZlFph
 gAHZD7WYKM2GvYxT/4PG0aY2mXC+NcaCMa/84YGbzqU03HxW2IViOW3MRxcuaR4sfGrUr6
 PAmltv/FmWHr2+0xeM9LzpXv/Tx7SYM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-q4dCVeenNWejOK-Z8m1f-g-1; Fri, 21 Jul 2023 12:03:40 -0400
X-MC-Unique: q4dCVeenNWejOK-Z8m1f-g-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-51e10b6148cso2582882a12.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 09:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689955419; x=1690560219;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tRMLVhFOooTCIj9VXUc3/ml+7iqjzNRXoHoeE7aNh/w=;
 b=hsutdusjdwSWi1p22tEg808lYAEIoiWvHy6aHUHrX6RTt7j2q+0B9TJmqDc7X8vBq3
 KmNicriZAkWaskNBEJSmrgobQaBDHUU24y5JDTM7FtD/2eL0SbaQjFajtdXEl1KhNKTM
 oyYV2TkDpxHtFTfQ0Fs5vDiUJoHAncPrO05aRroZLcjtdOAKkQepnQBgbb1rymfBS+T6
 VlFC+MiortahuVEJlwqrgM/muhjOooJnW5fEKxw0q/Bv/OO0JYwMgTb3MrTB+SvN+dOL
 VUL0wvOq4tlYt8b42C1HjZm+66VM/nl8T5pAH7q1pF2jzFuNXq0QCRATpB462ccf41zo
 XRsw==
X-Gm-Message-State: ABy/qLY47Rdc1UnOoJK2ZSnKXTaDBobkuHDzX8kRTkGggegP7tZiq5Tw
 gfMo6tuZjQLhXTf7OD6y5ZzGmJNlNzen/MpcEm6v0sJ+SbGfc7vsvPqD4UCQrLO9cnho6X5Gky9
 erSwSclhTqbMb/Kk=
X-Received: by 2002:a50:ee97:0:b0:51e:1c5c:b97f with SMTP id
 f23-20020a50ee97000000b0051e1c5cb97fmr2693373edr.2.1689955418792; 
 Fri, 21 Jul 2023 09:03:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEMznlUctBhFTVaBaDTA0YC2FICmDuHOy6ZJ0EdMNVH+RJ3NqzGU3fSaKEeFZGf8P6oRPZEQQ==
X-Received: by 2002:a50:ee97:0:b0:51e:1c5c:b97f with SMTP id
 f23-20020a50ee97000000b0051e1c5cb97fmr2693342edr.2.1689955418408; 
 Fri, 21 Jul 2023 09:03:38 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 c18-20020aa7c752000000b00521830574c1sm2310124eds.2.2023.07.21.09.03.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 09:03:37 -0700 (PDT)
Message-ID: <60cc355f-1ea4-5f96-e3c6-d9f1a8c768da@redhat.com>
Date: Fri, 21 Jul 2023 18:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 6/6] throttle: use enum ThrottleType instead of bool
 is_write
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, berto@igalia.com, kwolf@redhat.com, 
 groug@kaod.org, qemu_oss@crudebyte.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com
References: <20230713064111.558652-1-pizhenwei@bytedance.com>
 <20230713064111.558652-7-pizhenwei@bytedance.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230713064111.558652-7-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 13.07.23 08:41, zhenwei pi wrote:
> enum ThrottleType is already there, use ThrottleType instead of
> 'bool is_write' for throttle API, also modify related codes from
> block, fsdev, cryptodev and tests.
>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   backends/cryptodev.c        |  9 +++++----
>   block/throttle-groups.c     |  6 ++++--
>   fsdev/qemu-fsdev-throttle.c |  8 +++++---
>   include/qemu/throttle.h     |  4 ++--
>   tests/unit/test-throttle.c  |  4 ++--
>   util/throttle.c             | 30 ++++++++++++++++--------------
>   6 files changed, 34 insertions(+), 27 deletions(-)

Something not addressed in this patch that I would like to see: 
schedule_next_request() in block/throttle-groups.c runs 
`timer_mod(tt->timers[is_write], now)`.  I think that at least should be 
`tt->timers[is_write ? THROTTLE_WRITE : THROTTLE_READ]`.  Even better 
would be to have it take a `ThrottleType` instead of `bool is_write`, 
too, and use this enum throughout throttle-groups.c, too (i.e. for 
ThrottleGroupMember.throttled_reqs[], 
ThrottleGroupMember.pending_reqs[], ThrottleGroup.tokens[], and 
ThrottleGroup.any_timer_armed[]).  Then throttle_group_schedule_timer() 
could also take a `ThrottleType`.

But I understand asking for throttle-groups.c to be ThrottleType-ified 
is very much, so this is just a suggestion.  But I do ask for that one 
`timer_mod()` call to use THROTTLE_READ and THROTTLE_WRITE to index 
`tt->timers[]` instead of `is_write` directly.

[...]

> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index fb203c3ced..429b9d1dae 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -270,6 +270,7 @@ static bool throttle_group_schedule_timer(ThrottleGroupMember *tgm,
>       ThrottleState *ts = tgm->throttle_state;
>       ThrottleGroup *tg = container_of(ts, ThrottleGroup, ts);
>       ThrottleTimers *tt = &tgm->throttle_timers;
> +    ThrottleType throttle = is_write ? THROTTLE_WRITE : THROTTLE_READ;

Again, another stylistic suggestion (for all similar places in this 
patch): It isn’t clear what just `throttle` means. `throttle_direction` 
for example would be clear, or maybe just `direction`, this is throttle 
code, so it’s clear that everything that isn’t given a context is about 
throttling (it wasn’t `is_throttled_write` either, after all, but just 
`is_write`).

>       bool must_wait;
>   
>       if (qatomic_read(&tgm->io_limits_disabled)) {

[...]

> diff --git a/util/throttle.c b/util/throttle.c
> index c0bd0c26c3..5e4dc0bfdd 100644
> --- a/util/throttle.c
> +++ b/util/throttle.c
> @@ -136,11 +136,11 @@ int64_t throttle_compute_wait(LeakyBucket *bkt)
>   
>   /* This function compute the time that must be waited while this IO
>    *
> - * @is_write:   true if the current IO is a write, false if it's a read
> + * @throttle:   throttle type

I’m not too happy about “throttle type” as a description here, because 
“type” can be anything (naïvely, I’d rather interpret it to mean the 
algorithm used for throttling, or whether we’re throttling on bytes or 
IOPS).  “throttle direction” would be better.  This also applies to 
other functions’ interface documentation.

(Yes, this also means that I don’t like the type name ThrottleType very 
much, and would prefer it to be ThrottleDirection, but that would be an 
invasive change all over this series (when Berto has already reviewed 
it), so I’m not really asking for a change there.)

>    * @ret:        time to wait
>    */
>   static int64_t throttle_compute_wait_for(ThrottleState *ts,
> -                                         bool is_write)
> +                                         ThrottleType throttle)
>   {
>       BucketType to_check[2][4] = { {THROTTLE_BPS_TOTAL,

Since we’re now using a ThrottleType to index the first dimension of 
this array, I’d prefer to make this to_check[THROTTLE_MAX][4].

(Also, but very much unrelated to this patch: Why isn’t this lookup 
table a `const static`?)

>                                      THROTTLE_OPS_TOTAL,

[...]

> @@ -460,10 +461,10 @@ bool throttle_schedule_timer(ThrottleState *ts,
>   
>   /* do the accounting for this operation
>    *
> - * @is_write: the type of operation (read/write)
> + * @throttle: throttle type
>    * @size:     the size of the operation
>    */
> -void throttle_account(ThrottleState *ts, bool is_write, uint64_t size)
> +void throttle_account(ThrottleState *ts, ThrottleType throttle, uint64_t size)
>   {
>       const BucketType bucket_types_size[2][2] = {
>           { THROTTLE_BPS_TOTAL, THROTTLE_BPS_READ },

Like in throttle_compute_wait_for(), I’d prefer bucket_types_size and 
bucket_types_units to have [THROTTLE_MAX] in the first dimension.

(Interesting that these lookup tables are const, but not static.  I 
think they should be static, too.)

Hanna



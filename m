Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A58C75CC36
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 17:43:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMsHG-0007RZ-46; Fri, 21 Jul 2023 11:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMsHE-0007R0-KA
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 11:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMsHB-0000G3-Oc
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 11:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689954161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4QTb+M8ZepyiDipM8nRCOSMyjsw5G3maroe0zfsdbQ=;
 b=Ht+VetrEAGK7Lx75rKQ/eJ83Cac9DY5eXRZJE4NLmQ5LIJBhamKtu4d8ioT/tOSgoCqawA
 dheeaTnZ2YtMZLacSjieRQp3muICM4kBj4XxvFr0vG99JCmHazbD+7uRomCp/OfPyTnRk3
 RgRTyag8l+asUxi4+2QbWis0x235a28=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-Q0iq1ruFOuyD3hFZbos_gw-1; Fri, 21 Jul 2023 11:42:39 -0400
X-MC-Unique: Q0iq1ruFOuyD3hFZbos_gw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a356c74e0so137200366b.2
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 08:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689954158; x=1690558958;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T4QTb+M8ZepyiDipM8nRCOSMyjsw5G3maroe0zfsdbQ=;
 b=kkl4ffjALygzU9lFadlzs9poT5mH5yzg7Jbno87vkFqsvj9Z0abujekupnsYFb/ib5
 KmSw3SWyhm3Hh3yj3I5mDBUhpBl8EWdhMzzGz4Is5yA/8hW3aQRawvgF+qIaYKWyHWKE
 YDUxJmEKe/60w9F7PIK5D4tqjOP54zFjsMIOijGU+iznYpK+glPyHaUvWRyE7O3tXVQm
 OdeZPaTmRF+KO6Kx9v7w5DwEqyfZRivIDlv91i1KPtm6V2wHeCCbcGiyqgMvhSfGh5jv
 oGnfu8AZgejueSak2U+4+/CAocyjJgvvxl7IMty2Llv+pjELhZEQmKsU0dEw4u2IhD3V
 5eTw==
X-Gm-Message-State: ABy/qLZMa7gFzpCT6CtVSQQntCqpQPQCuoOVNLqKsFL2UEPm0VK35Pge
 K60HiJLJ2T1g+lhS8FpUpzqMgk+aT5VeGFE+WumHuWNM0R2LfECR8/hvf+rvqTLcvwYD0mnnyvP
 znloFQQnNFfAze5s=
X-Received: by 2002:a17:906:53d9:b0:992:47d7:35d7 with SMTP id
 p25-20020a17090653d900b0099247d735d7mr2088267ejo.14.1689954158743; 
 Fri, 21 Jul 2023 08:42:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFIabQcT4SwATaJ0aRYxN2eXromuqsqTqVatWa0LnUXyHcjtUb6mtphl26+oXpKdXdD8ao1aQ==
X-Received: by 2002:a17:906:53d9:b0:992:47d7:35d7 with SMTP id
 p25-20020a17090653d900b0099247d735d7mr2088257ejo.14.1689954158541; 
 Fri, 21 Jul 2023 08:42:38 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 um26-20020a170906cf9a00b0098e42bef732sm2309573ejb.183.2023.07.21.08.42.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 08:42:38 -0700 (PDT)
Message-ID: <1357b600-8431-9360-29f9-7fb73dce5eb4@redhat.com>
Date: Fri, 21 Jul 2023 17:42:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PATCH v3 1/6] throttle: introduce enum ThrottleType
To: zhenwei pi <pizhenwei@bytedance.com>, berto@igalia.com, kwolf@redhat.com, 
 groug@kaod.org, qemu_oss@crudebyte.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com
References: <20230713064111.558652-1-pizhenwei@bytedance.com>
 <20230713064111.558652-2-pizhenwei@bytedance.com>
Content-Language: en-US
In-Reply-To: <20230713064111.558652-2-pizhenwei@bytedance.com>
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
> Use enum ThrottleType instead of number index.
>
> Reviewed-by: Alberto Garcia<berto@igalia.com>
> Signed-off-by: zhenwei pi<pizhenwei@bytedance.com>
> ---
>   include/qemu/throttle.h | 11 ++++++++---
>   util/throttle.c         | 16 +++++++++-------
>   2 files changed, 17 insertions(+), 10 deletions(-)

[...]

> diff --git a/util/throttle.c b/util/throttle.c
> index 81f247a8d1..5642e61763 100644
> --- a/util/throttle.c
> +++ b/util/throttle.c
> @@ -199,10 +199,12 @@ static bool throttle_compute_timer(ThrottleState *ts,
>   void throttle_timers_attach_aio_context(ThrottleTimers *tt,
>                                           AioContext *new_context)
>   {
> -    tt->timers[0] = aio_timer_new(new_context, tt->clock_type, SCALE_NS,
> -                                  tt->read_timer_cb, tt->timer_opaque);
> -    tt->timers[1] = aio_timer_new(new_context, tt->clock_type, SCALE_NS,
> -                                  tt->write_timer_cb, tt->timer_opaque);
> +    tt->timers[THROTTLE_READ] =
> +        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
> +                      tt->timer_cb[THROTTLE_READ], tt->timer_opaque);
> +    tt->timers[THROTTLE_WRITE] =
> +        aio_timer_new(new_context, tt->clock_type, SCALE_NS,
> +                      tt->timer_cb[THROTTLE_WRITE], tt->timer_opaque);

This could benefit from the new structure:

```
for (int i = 0; i < THROTTLE_MAX; i++) {
     tt->timers[i] = aio_timer_new(..., tt->timer_cb[i], ...);
}
```

Even more so after patch 3.  Still, optional, of course, so either way:

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

Of note is that we still have instances in util/throttle.c and 
block/throttle-groups.c that don’t use these enums to access the 
tt->timers[] array, and that’s a bit unfortunate now (i.e. 
`tt->timers[is_write]` should rather be `tt->timers[is_write ? 
THROTTLE_WRITE : THROTTLE_READ]` instead).  But functionally it’s OK and 
I believe patches 3 and 6 do address this.



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1DC75CC37
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 17:43:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMsGw-0007Jc-37; Fri, 21 Jul 2023 11:42:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMsGu-0007JB-2Q
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 11:42:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMsGs-000051-Oo
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 11:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689954141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7Y5/wx8l9jPDtXh1LgRXQZ2RV4q+qkqCcpSND4Ya8KA=;
 b=h5MtXEAZ1ua6CimSkt+dSy+p/mwkm9Ax+DYeeit6j76t9nS65suDafnseK6GTu3rgiLFdt
 MHJGK2xC9+v1sLt9ynSL9o0jSaowVQnH21ozs3Mu/DogvX+Mm1VihmyVwBPtok7gmXAu+9
 ytoLFQhowL5OCAgVRKRDyD38TykmYhU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-M5YxdqhVOVKHs_Dt1ALK1w-1; Fri, 21 Jul 2023 11:42:20 -0400
X-MC-Unique: M5YxdqhVOVKHs_Dt1ALK1w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-993d7ca4607so130255366b.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 08:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689954137; x=1690558937;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Y5/wx8l9jPDtXh1LgRXQZ2RV4q+qkqCcpSND4Ya8KA=;
 b=kLEtjKdQ5KGSV7EQuG8Kh/F93tEF6FbTL9IyGtgGPAkfJZz2FzH3mZZG/jpzuRTMyx
 jQzFW46yI6inv8+mKNcNa3u+2WP0Hd9+9OlY/4+aYVqdu/Uzb4HJX5HSrZMCHzlIwSZk
 x0w9puLpbfVDGQK06i2HJ47XLJE+V9xuJwl9XrGn16vgtWVy7sVTtFyJJnerQ0SoBDK5
 Xf0ScGkLxXi4jJA4Tl7YbhfiDf7jFDNXfOaj07VmEgbrxcaqXFG/f4dU5uQYhRgwvOoQ
 Yi9tT6iX6RSbNH2s5XUw2aHEs/B3ZzM+gtMVfh/Rxl9T+o8s+MSpdepWh4iIXucCIUPc
 TIMg==
X-Gm-Message-State: ABy/qLaxyhRZRmOf0MWr+j3wSqEeVdWSPpBDOU/jPEdQqzIu3LVRltUP
 /Oyq5IEuyUBZLxJyz83wzka7fBqDf6EXnUA6ijmds0mmZ53GfBmBiZVPMvfYnIyGWAR1QxXIyYR
 EVeZOtbxWdWCI7DQ=
X-Received: by 2002:a17:906:3042:b0:98e:16b7:e038 with SMTP id
 d2-20020a170906304200b0098e16b7e038mr1858079ejd.23.1689954137560; 
 Fri, 21 Jul 2023 08:42:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGQCwZzs0U+UEPP2TWVHUjfwTt8LkPL+PNlvsX6sOeue0jhIvIBGIwhCvs7Cha71ehgYUCeeQ==
X-Received: by 2002:a17:906:3042:b0:98e:16b7:e038 with SMTP id
 d2-20020a170906304200b0098e16b7e038mr1858062ejd.23.1689954137265; 
 Fri, 21 Jul 2023 08:42:17 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a17090694c400b009930042510csm2340086ejy.222.2023.07.21.08.42.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 08:42:16 -0700 (PDT)
Message-ID: <a1eb5f47-60c4-9d52-7df7-16e0cfc44783@redhat.com>
Date: Fri, 21 Jul 2023 17:42:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 5/6] cryptodev: use NULL throttle timer cb for read
 direction
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, berto@igalia.com, kwolf@redhat.com, 
 groug@kaod.org, qemu_oss@crudebyte.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com
References: <20230713064111.558652-1-pizhenwei@bytedance.com>
 <20230713064111.558652-6-pizhenwei@bytedance.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230713064111.558652-6-pizhenwei@bytedance.com>
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
> Operations on a crytpodev are considered as *write* only, the callback

s/crytpodev/cryptodev/

> of read direction is never invoked. Use NULL instead of an unreachable
> path(cryptodev_backend_throttle_timer_cb on read direction).
>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   backends/cryptodev.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/backends/cryptodev.c b/backends/cryptodev.c
> index 7d29517843..5cfa25c61c 100644
> --- a/backends/cryptodev.c
> +++ b/backends/cryptodev.c
> @@ -331,8 +331,7 @@ static void cryptodev_backend_set_throttle(CryptoDevBackend *backend, int field,
>       if (!enabled) {
>           throttle_init(&backend->ts);
>           throttle_timers_init(&backend->tt, qemu_get_aio_context(),
> -                             QEMU_CLOCK_REALTIME,
> -                             cryptodev_backend_throttle_timer_cb, /* FIXME */

Now it’ll be gone (good), but if you happen to add a FIXME again, it 
would be nice to explain in the same comment in the code what exactly 
needs fixing, and why it isn‘t being fixed at this point.

> +                             QEMU_CLOCK_REALTIME, NULL,
>                                cryptodev_backend_throttle_timer_cb, backend);
>       }

With the typo in the commit message fixed:

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>



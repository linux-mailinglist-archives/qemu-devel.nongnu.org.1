Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2A575CC45
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 17:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMsJ8-0001nL-BH; Fri, 21 Jul 2023 11:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMsJ6-0001mx-19
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 11:44:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMsJ4-0000fr-Ow
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 11:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689954278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=06zRUgCoeEkrWETKjwBSX5roDW2rg/nPZnmpoJgTvEA=;
 b=AtJHYmNj8EE4Zw34nAPpdmH7Kv0DDNqI0UnvXDpWh1C0SbHc/fx1TeUG9w7moPqMCNbxgJ
 7qh5L8NyBxnbIjaK8fNfIe1m+JUc/bihXgQFYpMwq5uiCq/ben1PyeZ7nG6R2bif2PpiuM
 j47nslqnHvGABK+EuBdFvXQhfPSpwJs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-CSf1707xPfeJAawlYJbLVA-1; Fri, 21 Jul 2023 11:43:34 -0400
X-MC-Unique: CSf1707xPfeJAawlYJbLVA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-518676b6d09so1313152a12.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 08:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689954201; x=1690559001;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=06zRUgCoeEkrWETKjwBSX5roDW2rg/nPZnmpoJgTvEA=;
 b=Im9Vv0nxf70nsKDxbR5C58LOAdpkk0i6zWKHCQL7jvUTfUuSvAKVwpF6AJqwQuttPq
 lZ4hO5slA4EJ8qqUq8Zy5fLB12yGzRGoalHE8UsXnCMMURtZxl3Y3vfS9p/qbePnna9F
 tYYxJtAsij6UWLdzjtRtheiLMMm5q0LBQqoUSnDK6hGw5fAQWdVKBczsfiB1tA9HNEJD
 qCKeh5gH+d0CCsiaImCPc8PB+WwWXIx9s6u2MxEtLvjD8JMrAsj/pN4yEddJN595uSXS
 MX/OX1cUa/gTvwKlnrw6G7f5LvnoUgzWDxxjOghywFwpg0GcdX+cekZuPD1IHnsmKaaH
 ulig==
X-Gm-Message-State: ABy/qLbA+Z2E7XHiLR0HJ1HuSSO7IS13mESqbe1u/edd/V/ogh0Imdgi
 8z+4QvNgjqI3ZoLurr+HF5cipx0IPcMQ17WFfKNpmZ8pN++tZ25DyayRbcq130OlfWd9scB3M4i
 AZHomiNxWeYIWxuI=
X-Received: by 2002:aa7:d0cc:0:b0:521:a4fd:baaa with SMTP id
 u12-20020aa7d0cc000000b00521a4fdbaaamr1543363edo.42.1689954200831; 
 Fri, 21 Jul 2023 08:43:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGJCp4ERmPzusn3FbOnS4REI5DByGbEBbwDe6dJOCKSXv8Gjp/hoeQusjMb6sUeqBb+mORxWA==
X-Received: by 2002:aa7:d0cc:0:b0:521:a4fd:baaa with SMTP id
 u12-20020aa7d0cc000000b00521a4fdbaaamr1543350edo.42.1689954200542; 
 Fri, 21 Jul 2023 08:43:20 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 f5-20020a056402068500b0051ded17b30bsm2247046edy.40.2023.07.21.08.43.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 08:43:19 -0700 (PDT)
Message-ID: <caaddc1c-1bbb-6c40-5be1-b10831ee84a5@redhat.com>
Date: Fri, 21 Jul 2023 17:43:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/6] test-throttle: use enum ThrottleType
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, berto@igalia.com, kwolf@redhat.com, 
 groug@kaod.org, qemu_oss@crudebyte.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com
References: <20230713064111.558652-1-pizhenwei@bytedance.com>
 <20230713064111.558652-3-pizhenwei@bytedance.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230713064111.558652-3-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> Use enum ThrottleType instead in the throttle test codes.
>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   tests/unit/test-throttle.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>



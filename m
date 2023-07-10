Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3B374D4FF
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 14:12:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIpj8-000610-MV; Mon, 10 Jul 2023 08:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qIpj1-0005zN-FE
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:10:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qIpiw-0001WA-T7
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 08:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688991021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gdTr8BL1QqjOHeJW1mInqXvq2dQjyUmS1Hr705+Z67I=;
 b=RfiXqXArPuq/sqqmRA/w4QCqJ46oDjAMf2LeoD0Q0Tg8iPLlRx4XZN6lHBf0c3JI6NoiYm
 eLfIBuD0RrbVOe74hAdIoAx4hJIHXalDpNlrFS7cxDAW5bsmhWMQmSHDh97C7CbZb7e6NM
 I9Gd6C5AQudyvX7VNkhJQ7KQXZkHQ74=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-9M4etXC_NVKf5gqWksPKHw-1; Mon, 10 Jul 2023 08:10:20 -0400
X-MC-Unique: 9M4etXC_NVKf5gqWksPKHw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-993831c639aso285166166b.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 05:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688991019; x=1691583019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gdTr8BL1QqjOHeJW1mInqXvq2dQjyUmS1Hr705+Z67I=;
 b=mChVuvhrxFQcqu+vARXy+XSHFGD2mKg4Ut6KAXL0JoRJwla+18EXQbTFTwkHvJ1BGZ
 aMD/kMYFB0S6hcTHhzcUpwVlxwIF1nNWnO+YMBNZEh5ixjBxpQ6j1Sum0HD27/xonsev
 0lv5fvGhPz0DoWekYyYcfc5aMnNDxD8O7Yx1rodhitq+CSDJFZt9AO1ctE5Rk9ItknQi
 remEb2LJrE506f/p0bUdyYL+5lj/vNtw2nCumkSD+WxOjGzJ4jdzw1FBVgngS3avQQ9b
 u4zzDj/AMgZXc9rdlAzscfUTMKGFvqFEC63nraRCcubl35sUjA2jfRnpIqVABxGmXdOt
 FbNQ==
X-Gm-Message-State: ABy/qLagrzCQOpqlj1SDms1vUKgIe6qNXXFxZyWgXB7/RMXv6b1e6m97
 VnGL5/ey5uM4m5koOGYwfFQoVSmBqt82eeCDN9B0gdtoShAQ5JCMBtYfjzFvfMLJ5cOLVPJeH19
 io68teSvdR/qBSVU=
X-Received: by 2002:a17:906:8052:b0:992:9d41:875b with SMTP id
 x18-20020a170906805200b009929d41875bmr10684097ejw.32.1688991019485; 
 Mon, 10 Jul 2023 05:10:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFhr3NuFQto33l/sVCahxhrBVvrINTBJctbouj5L62E1UsCPy3c2yh92MOHE6MzFxk7GAjuhQ==
X-Received: by 2002:a17:906:8052:b0:992:9d41:875b with SMTP id
 x18-20020a170906805200b009929d41875bmr10684073ejw.32.1688991019021; 
 Mon, 10 Jul 2023 05:10:19 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:dd11:f574:b001:d931?
 (p200300cfd71af311dd11f574b001d931.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:dd11:f574:b001:d931])
 by smtp.gmail.com with ESMTPSA id
 c21-20020a170906925500b00992d122af63sm6028236ejx.89.2023.07.10.05.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 05:10:18 -0700 (PDT)
Message-ID: <92a653c1-254b-6991-79d4-df4ef07c4b5b@redhat.com>
Date: Mon, 10 Jul 2023 14:10:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] block: Fix pad_request's request restriction
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20230609083316.24629-1-hreitz@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230609083316.24629-1-hreitz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 09.06.23 10:33, Hanna Czenczek wrote:
> bdrv_pad_request() relies on requests' lengths not to exceed SIZE_MAX,
> which bdrv_check_qiov_request() does not guarantee.
>
> bdrv_check_request32() however will guarantee this, and both of
> bdrv_pad_request()'s callers (bdrv_co_preadv_part() and
> bdrv_co_pwritev_part()) already run it before calling
> bdrv_pad_request().  Therefore, bdrv_pad_request() can safely call
> bdrv_check_request32() without expecting error, too.
>
> There is one difference between bdrv_check_qiov_request() and
> bdrv_check_request32(): The former takes an errp, the latter does not,
> so we can no longer just pass &error_abort.  Instead, we need to check
> the returned value.  While we do expect success (because the callers
> have already run this function), an assert(ret == 0) is not much simpler
> than just to return an error if it occurs, so let us handle errors by
> returning them up the stack now.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 18743311b829cafc1737a5f20bc3248d5f91ee2a
>         ("block: Collapse padded I/O vecs exceeding IOV_MAX")
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
> ---
>   block/io.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)

Ping



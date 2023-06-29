Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8307422EC
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 11:08:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEndi-0003m7-OD; Thu, 29 Jun 2023 05:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qEndg-0003lj-OM
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qEndf-00014x-2c
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 05:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688029710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dgFJ7Te5p4TvQXUHUP2S/a4Q7UpLjbrVUKLDNsvFzdE=;
 b=VJO5ZA1cLlAg6iuaKIlbm1XVPzgKTp/KlGevglSmtDclyVBpBNObt+l7VQZS/uiA2weHWb
 1A4v0DxYPjl/UlyVH93HAHkTC2CaDrkCcBSnNOkYLxhdL2AAD7d5ImdytHTjn+bnrx79Jn
 pQjeTFyIfNmoEofzkW5Gg3fIN0JMBw4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-pm5JYTc2PvGpJSxtj1HdNA-1; Thu, 29 Jun 2023 05:08:27 -0400
X-MC-Unique: pm5JYTc2PvGpJSxtj1HdNA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5fa06debcso2758915e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 02:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688029706; x=1690621706;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dgFJ7Te5p4TvQXUHUP2S/a4Q7UpLjbrVUKLDNsvFzdE=;
 b=MMAzXzDIYmJaolou1gjQoVKKnW2vjOX60cnYKluI4mF8dPfRiPBzM9Oq03rtJddsFq
 Z9vEtF83bYPdoAYOTPc4444+RNUhfnrHWiDErZk3akn9dcaBeSgSpR6q4dnov2H/n8/v
 iKgI8XlsmQEP/uK+8Bt1DnU0gGCBsPztiMGFzmmHnCR4cUjOwBf/r+pL5HW1j8hDNXkl
 3aRjGzsWQ3zCeXhzTZDXUxL1kFqHWZSpGvwOVkth00LovkHekQCPUKvGCrRwOx9JpQP7
 AKL8EMQfRAqlny42JNB/9Ytzj+/H7N1Ll1Tj+RX3rkO2woWwfJJdzaNEaIQwovjcdiSA
 UD6g==
X-Gm-Message-State: AC+VfDwEfK8XT99ilGK46a3ZFc+NtZ0eGm7v4Be425AIznYkW5ej1Mi+
 MHEx2xMGlVnE9CqaJ0iHzq5XIxvjwX7RACemrmpAzvni8kv1Yyklo5Ss9cdPF80WjIB4ixfYWgm
 ufnxpL/HFVQNPoF0=
X-Received: by 2002:a7b:cc15:0:b0:3f9:846:d892 with SMTP id
 f21-20020a7bcc15000000b003f90846d892mr29240220wmh.9.1688029706324; 
 Thu, 29 Jun 2023 02:08:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5AUet4+A6QZ8Ju2uqvhQ/33KcCLFV7obxiSvcVG7L/b2dkLm1Ihy8FGVnQGdT4ifSjS/TCtQ==
X-Received: by 2002:a7b:cc15:0:b0:3f9:846:d892 with SMTP id
 f21-20020a7bcc15000000b003f90846d892mr29240207wmh.9.1688029706011; 
 Thu, 29 Jun 2023 02:08:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a1cf314000000b003f90b9b2c31sm19129997wmq.28.2023.06.29.02.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 02:08:25 -0700 (PDT)
Message-ID: <e0897f0c-f1a2-9e11-09a6-06f0c076985e@redhat.com>
Date: Thu, 29 Jun 2023 11:08:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] accel/tcg: fix start page passed to
 tb_invalidate_phys_page_range__locked()
Content-Language: en-US
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 richard.henderson@linaro.org, hsp.cat7@gmail.com, qemu-devel@nongnu.org
References: <20230629082522.606219-1-mark.cave-ayland@ilande.co.uk>
 <20230629082522.606219-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230629082522.606219-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 6/29/23 10:25, Mark Cave-Ayland wrote:
> Due to a copy-paste error in tb_invalidate_phys_range() the start address of the
> invalidation range was being passed to tb_invalidate_phys_page_range__locked()
> instead of the start address of the current page.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Fixes: e506ad6a05 ("accel/tcg: Pass last not end to tb_invalidate_phys_range")


Cc: qemu-stable@nongnu.org

> ---
>   accel/tcg/tb-maint.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index 3541419845..33ea1aadd1 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -1182,15 +1182,17 @@ void tb_invalidate_phys_range(tb_page_addr_t start, tb_page_addr_t last)
>       index_last = last >> TARGET_PAGE_BITS;
>       for (index = start >> TARGET_PAGE_BITS; index <= index_last; index++) {
>           PageDesc *pd = page_find(index);
> -        tb_page_addr_t bound;
> +        tb_page_addr_t page_start, page_last;
>   
>           if (pd == NULL) {
>               continue;
>           }
>           assert_page_locked(pd);
> -        bound = (index << TARGET_PAGE_BITS) | ~TARGET_PAGE_MASK;
> -        bound = MIN(bound, last);
> -        tb_invalidate_phys_page_range__locked(pages, pd, start, bound, 0);
> +        page_start = index << TARGET_PAGE_BITS;
> +        page_last = page_start | ~TARGET_PAGE_MASK;
> +        page_last = MIN(page_last, last);
> +        tb_invalidate_phys_page_range__locked(pages, pd,
> +                                              page_start, page_last, 0);
>       }
>       page_collection_unlock(pages);
>   }



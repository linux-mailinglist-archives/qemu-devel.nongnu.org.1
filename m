Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CE7759036
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 10:28:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM2XB-0000AD-1A; Wed, 19 Jul 2023 04:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qM2Wr-0008SM-Lq
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 04:27:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qM2Wp-00038u-SQ
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 04:27:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689755243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOsRe1VloVh306T/GMaGH9Uh8TDqoJb84iXfRPGYKP0=;
 b=T6PCd/yzP6kVpbXxq0ImbtmBntF0HBxrpdNJDjLA4Wgkm5eaihAEhOpFB1S0BAKcx0H3jr
 DHL7hPWKGgwEGlIUlU/s4k3LpbOha7dPK/gFxh7lFzMtEKm8YBsaOLEml78AcnMHePnyvs
 zXF3xEHi2Umm6n3nBe6aV+3Ipn0IJy8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-QFrMUL_pPcuTkI7e1WnxPQ-1; Wed, 19 Jul 2023 04:27:21 -0400
X-MC-Unique: QFrMUL_pPcuTkI7e1WnxPQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbdf34184eso35657885e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 01:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689755240; x=1692347240;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AOsRe1VloVh306T/GMaGH9Uh8TDqoJb84iXfRPGYKP0=;
 b=eJSfJ7XX6YyRwpQaXsCn+RBOafRK3nNKKdVze6fPnPqoMJexVASWI8RHwYklihzgQz
 Xls1wo19Bq/xDSIcuOX/BiUebphvwVZQBzoLB2i4OKeRnfxwwYxqdooVZOHtcNqQK/HW
 AlqVmL1eyQ7b3rYqwVEZupQWAjRhXpuyuCAm5Y2rJUaHFraGJP/uvLjG1+UIxsAq0tfV
 VGceIIpXLST9n7JagXwNgBxnp8lOrZNv9aNGOrrr0r0e+HA/THxtbXsCr0FURL1mAk6n
 07/p6j8UuSmzymuJunV19u7pBc2WQdrKbsn3Ms6FiiLsCSnyr5FFq57ZXZ2u3C6tVkRH
 9dPA==
X-Gm-Message-State: ABy/qLaQBgc44WuYWan5JjrlOFUnSsRuQR/ZWK75t3jtuSysNzgNB81v
 IRglg5oyjX7tHA7NjE+8sNxI5+Q+z9uWGDy6lLsaF4ezVpJrjW3omZKchfNQ3WrhUPUZo4mOHGJ
 ItvQQzvstPffcCmg=
X-Received: by 2002:a05:600c:b50:b0:3fc:a8:dc3c with SMTP id
 k16-20020a05600c0b5000b003fc00a8dc3cmr1354153wmr.37.1689755240301; 
 Wed, 19 Jul 2023 01:27:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGNW2vR/ZcdRVznPYMI+YUKgXrjoxn1ddtOXIlAQ5Zw3Iq1pIVEaNthBcL6lw2pG7ze0ZcnuQ==
X-Received: by 2002:a05:600c:b50:b0:3fc:a8:dc3c with SMTP id
 k16-20020a05600c0b5000b003fc00a8dc3cmr1354135wmr.37.1689755239887; 
 Wed, 19 Jul 2023 01:27:19 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63?
 (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de.
 [2003:cb:c74b:4f00:b030:1632:49f2:63])
 by smtp.gmail.com with ESMTPSA id
 u9-20020a7bc049000000b003fba6a0c881sm1044953wmc.43.2023.07.19.01.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 01:27:19 -0700 (PDT)
Message-ID: <c6c0811a-df6d-4b2f-da05-867919fea3bd@redhat.com>
Date: Wed, 19 Jul 2023 10:27:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 02/14] target/s390x: Fix CLM with M3=0
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230718213531.117976-1-iii@linux.ibm.com>
 <20230718213531.117976-3-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230718213531.117976-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 18.07.23 23:21, Ilya Leoshkevich wrote:
> When the mask is zero, access exceptions should still be recognized for
> 1 byte at the second-operand address. CC should be set to 0.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: defb0e3157af ("s390x: Implement opcode helpers")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/mem_helper.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/target/s390x/tcg/mem_helper.c b/target/s390x/tcg/mem_helper.c
> index f417fb1183c..d6dc8b32620 100644
> --- a/target/s390x/tcg/mem_helper.c
> +++ b/target/s390x/tcg/mem_helper.c
> @@ -667,6 +667,11 @@ uint32_t HELPER(clm)(CPUS390XState *env, uint32_t r1, uint32_t mask,
>       HELPER_LOG("%s: r1 0x%x mask 0x%x addr 0x%" PRIx64 "\n", __func__, r1,
>                  mask, addr);
>   
> +    if (!mask) {
> +        /* Recognize access exceptions for the first byte */
> +        cpu_ldub_data_ra(env, addr, ra);
> +    }
> +
>       while (mask) {
>           if (mask & 8) {
>               uint8_t d = cpu_ldub_data_ra(env, addr, ra);

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



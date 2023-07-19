Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE28759058
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 10:33:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM2bz-0002Y6-Bk; Wed, 19 Jul 2023 04:32:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qM2bw-0002XB-Ni
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 04:32:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qM2bu-0005Xe-OO
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 04:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689755558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/APXFK6RT7rQOw7NY2jixNHfFahauIugIDGBaeW0u0Y=;
 b=WAbML5K67FbDMJJOYFJILT/lAhEWa4emT1EXf4i+wc+LXeBtsnMky3wRQSdeaW7yqTP83B
 d5MlCD4Lq5vPHFUxIWUqQHrYrzwqDUDd75w9q0JxWr+kTWMj9duJSljBc2FBTzVKAEm9Dy
 N1QUWYWfECgzCIV1/k720OWeO9LJgBI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-qzvagpaoPWiNVCfa058Y_A-1; Wed, 19 Jul 2023 04:32:36 -0400
X-MC-Unique: qzvagpaoPWiNVCfa058Y_A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fa8f8fb7b3so38575265e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 01:32:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689755555; x=1692347555;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/APXFK6RT7rQOw7NY2jixNHfFahauIugIDGBaeW0u0Y=;
 b=KUsty5K7NDs+a/+uZY47bxUdcAQLO2YBfEgzx5aSeMUC+YSOCyh1y3j3jnJsGONAxK
 a+eLOh64o26oUj2qUerOP0kGjbcDzkCBVhaVxMyKCq0OyVs5UVKgeSYMiaubxZixDJ4/
 wMeNgQVrH5cWfCgixo0C+vfETEcMV1Fp16JOlYHxYHdSv8Bs41khh5haMFfCDcFUeceb
 MSOW+yAFhAL5mqBDj/FbF7kcvRjU2gAodlAnb0VvNzgLo/kzu5zsnqWErEBMQ6wy4EgA
 IOyfb66yoBi2UcjWV0V8zHpaATQRYw+7bMsYmR+SulAza6wAE/2Pa7Ups96nZRupnMrD
 bItQ==
X-Gm-Message-State: ABy/qLb6VODFslsrjRH7QPAmwhIexLBrHYuB7j4Tyh3mp/ZWbrcq+Gwk
 NFradlPQ61ySycALCsay11zKvYla8giN4G1CmjrBIA7X5j9LR11Ik41M4G3SnN3J959JFiT38ME
 z2sAeKAMDpF+kZVo=
X-Received: by 2002:a1c:4b0e:0:b0:3fc:855:db42 with SMTP id
 y14-20020a1c4b0e000000b003fc0855db42mr4098781wma.34.1689755555604; 
 Wed, 19 Jul 2023 01:32:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGxcUQdomNVkfGZpSma6Vj4hp48etGDESEi4cev3mCLQruwD3T1Y1PsDsS+uLIaC5MDbH4CzQ==
X-Received: by 2002:a1c:4b0e:0:b0:3fc:855:db42 with SMTP id
 y14-20020a1c4b0e000000b003fc0855db42mr4098767wma.34.1689755555222; 
 Wed, 19 Jul 2023 01:32:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63?
 (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de.
 [2003:cb:c74b:4f00:b030:1632:49f2:63])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a5d5507000000b003142ea7a661sm4605230wrv.21.2023.07.19.01.32.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 01:32:34 -0700 (PDT)
Message-ID: <227c0023-068a-6d18-560b-cd096de87311@redhat.com>
Date: Wed, 19 Jul 2023 10:32:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 04/14] target/s390x: Fix ICM with M3=0
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230718213531.117976-1-iii@linux.ibm.com>
 <20230718213531.117976-5-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230718213531.117976-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 18.07.23 23:21, Ilya Leoshkevich wrote:
> When the mask is zero, access exceptions should still be recognized for
> 1 byte at the second-operand address. CC should be set to 0.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: e023e832d0ac ("s390x: translate engine for s390x CPU")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/translate.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index 2f61e879878..2d7cc8963b4 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -2516,6 +2516,12 @@ static DisasJumpType op_icm(DisasContext *s, DisasOps *o)
>           len = 8;
>           goto one_insert;
>   
> +    case 0:
> +        /* Recognize access exceptions for the first byte.  */
> +        tcg_gen_qemu_ld_i64(tmp, o->in2, get_mem_index(s), MO_UB);
> +        gen_op_movi_cc(s, 0);
> +        return DISAS_NEXT;
> +
>       one_insert:
>           pos = base + ctz32(m3) * 8;
>           tcg_gen_deposit_i64(o->out, o->out, tmp, pos, len);

That label in there is really nasty.

I would just have but the "case 0" right at the top (or right in front 
of the "default") and left all of that nasty stuff involving that label 
alone.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F08746B35
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:54:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGarw-000173-HK; Tue, 04 Jul 2023 03:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGaru-00016c-D6
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGars-0006Ey-58
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688457275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eh0YeMbHIYVccUY17N+S/Lm9oyRTYdiGWoB6xgqvPuA=;
 b=T2Ha/H/E2APVub3+NWbtSQ9ukwJGszxJOWVnR4Npuhc1G8KOLFvkmydSAj+FP4fXOLSLVT
 RpHG72cstP6qn6cf6/av1FarzkajH+Q6K2NUBEEEYCcwHfjlntpjkTRfSqgZJfaZvYvBn1
 3L/HNp+o6m1GyHY5nd+MO4UTg2FweNA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-HYmbNzFOMQ-pLyuHd5t8fg-1; Tue, 04 Jul 2023 03:54:33 -0400
X-MC-Unique: HYmbNzFOMQ-pLyuHd5t8fg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fb40d0623bso24376505e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 00:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688457272; x=1691049272;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eh0YeMbHIYVccUY17N+S/Lm9oyRTYdiGWoB6xgqvPuA=;
 b=TqP+bXMVHpSq/GbfqPQXX2GaNiHNR/wx8o0JUbnVIIVHzQM7xb6Kl2ZDimyHiW9vUl
 4ndA+GeEFCf/4bPEpn5DOfyH72OcCYLfu+x1TSiOxFBkriKoDubbROyORaMRExXYnjmU
 5+Cfsefv+CXhilej1CGKigs7MmAmv5ssm6Vkui+k8LLhti55g1O/nUFBnDKkfbqE5Ucr
 Mj1puMPeHczl7fYNw5UGn6rglAQN6JX/ivkyJJRpjJMJm6z5evOahirQ44ZKa2e1VvWH
 FHUQxaTgIlN+OoJPxOUGSeeKZu86WqODUL2ypzcjTgek1/XOiq2y4F/KJnGeknW4ECXM
 zGjQ==
X-Gm-Message-State: AC+VfDxQULWiT4GZpqqqgQ6+GrHFz3500FqgYeSZXLH53+eVAUZJGzaE
 c1H9Zq0gTNkzwBjIIWhEWBfTwPZCsjQouzQZLoqjHfjhcEB0rrJEF3+ZJ+N5LwLu2Zmq9nMsBDS
 D+RK486VzgJj2Hp4=
X-Received: by 2002:a05:600c:b4d:b0:3f6:8ba:6ea2 with SMTP id
 k13-20020a05600c0b4d00b003f608ba6ea2mr11473921wmr.15.1688457272216; 
 Tue, 04 Jul 2023 00:54:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5CWee+g/jiR307xIbU3VxA5C87zahScWmHBu7yajSJmRGoZxDybKLLJYWfYLsDnRynyhCywQ==
X-Received: by 2002:a05:600c:b4d:b0:3f6:8ba:6ea2 with SMTP id
 k13-20020a05600c0b4d00b003f608ba6ea2mr11473905wmr.15.1688457271877; 
 Tue, 04 Jul 2023 00:54:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2?
 (p200300d82f305a00b30de6bc74c3d6f2.dip0.t-ipconnect.de.
 [2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a05600c314900b003fa9a00d74csm11698110wmo.3.2023.07.04.00.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 00:54:31 -0700 (PDT)
Message-ID: <c391d299-877c-dc82-4e08-65f1d64f7b5a@redhat.com>
Date: Tue, 4 Jul 2023 09:54:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 07/12] target/s390x: Fix relative long instructions with
 large offsets
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-8-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230703155801.179167-8-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 03.07.23 17:50, Ilya Leoshkevich wrote:
> The expression "imm * 2" in gen_ri2() can wrap around if imm is large
> enough.
> 
> Fix by casting imm to int64_t, like it's done in disas_jdest().
> 
> Fixes: e8ecdfeb30f0 ("Fix EXECUTE of relative branches")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
> index a6079ab7b4f..6661b27efa4 100644
> --- a/target/s390x/tcg/translate.c
> +++ b/target/s390x/tcg/translate.c
> @@ -5794,7 +5794,7 @@ static TCGv gen_ri2(DisasContext *s)
>   
>       disas_jdest(s, i2, is_imm, imm, ri2);
>       if (is_imm) {
> -        ri2 = tcg_constant_i64(s->base.pc_next + imm * 2);
> +        ri2 = tcg_constant_i64(s->base.pc_next + (int64_t)imm * 2);
>       }
>   
>       return ri2;

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



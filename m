Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7F4770E9C
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 09:59:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSCBk-00044p-9X; Sat, 05 Aug 2023 03:59:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qSCBi-00044W-6J
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 03:59:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qSCBg-0006hB-Qb
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 03:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691222340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u732zGm+ucnwGOVOgo4q5rn9BiyQXeIlgn2PnbixNAI=;
 b=C4RuS4zn8EYCbwv5nHblSrMtli4X3s3lZAVYaVfJZgWR/8phHtUmPaNrrwXtDuYQw53d/G
 SR+OWq7qnQeJdcZVm1cZ1n/XRUs/6gIQOO1SkX/UhiHFt2/R16gf4DOpv6RfBNSxGEPEhV
 T8UaM3YXr0jOSXBbOTdU8q9xJN9OJs0=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-PVzIdn8MMQeIYEl7I0iP-g-1; Sat, 05 Aug 2023 03:58:56 -0400
X-MC-Unique: PVzIdn8MMQeIYEl7I0iP-g-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9c5cba6d1so29612681fa.1
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 00:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691222335; x=1691827135;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u732zGm+ucnwGOVOgo4q5rn9BiyQXeIlgn2PnbixNAI=;
 b=ZG3ocwUu/9ytEaYqiVpLcuJPxmGdMHkVzlbhkX2Apo/elz1+0R03Cbiwil02fKJjAC
 sqXffionF0hqHQl2yey4njh9BtK/BIT6Er86XzYF0ep7uNTRsc8+LG9mVi/HeUlkvuWo
 xtvHN4+zzl1yBJWEHinZeC6iakYK3Rq2SsBnPAvHCxGyp5/PrB3BjJsQfTvgDhAKj+A3
 Xyt4shnDhEsaxVXMKARp78oQi6ne60QaPaWTelMkrkPBojr/UaPiA9t/t95RKAW184RY
 OOe4vylHLu5icGfRxSbFoc5uNJOZIVVnu/PAbVWiTYdDSN73UR+a195XOqH9CTd2xLCA
 FInQ==
X-Gm-Message-State: AOJu0Yz9uKMqp++n5CaPOdZKvGwsicpmrrDT5VGLXpn7EYlmgmJtmhlR
 01J16JSeAqHg/1gkeQC1PvN96pQgEVQ7gixG8Esn4dCCu1VysLHpx4Er7jI8nnSC1swZeebgajJ
 DvMVPFvL3862HreU=
X-Received: by 2002:a2e:3815:0:b0:2b5:7a87:a85a with SMTP id
 f21-20020a2e3815000000b002b57a87a85amr2731179lja.13.1691222335213; 
 Sat, 05 Aug 2023 00:58:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGcvAbppJcrAhpdsLMjDfT4u+k7QZRYbVcqjRMwluT2vx7lkpLCgraoC8u0J8UqASJuDf+P/g==
X-Received: by 2002:a2e:3815:0:b0:2b5:7a87:a85a with SMTP id
 f21-20020a2e3815000000b002b57a87a85amr2731172lja.13.1691222334828; 
 Sat, 05 Aug 2023 00:58:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2d:8e00:a20e:59bc:3c13:4806?
 (p200300d82f2d8e00a20e59bc3c134806.dip0.t-ipconnect.de.
 [2003:d8:2f2d:8e00:a20e:59bc:3c13:4806])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a7bc396000000b003fc0505be19sm4276942wmj.37.2023.08.05.00.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Aug 2023 00:58:54 -0700 (PDT)
Message-ID: <368c9db2-e930-fb4e-193d-8a8156db072b@redhat.com>
Date: Sat, 5 Aug 2023 09:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] target/s390x: Fix VSTL with a large length
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-stable@nongnu.org
References: <20230804235624.263260-1-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230804235624.263260-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 05.08.23 01:55, Ilya Leoshkevich wrote:
> The length is always truncated to 16 bytes. Do not probe more than
> that.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 0e0a5b49ad58 ("s390x/tcg: Implement VECTOR STORE WITH LENGTH")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/vec_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/s390x/tcg/vec_helper.c b/target/s390x/tcg/vec_helper.c
> index 48d86722b2d..dafc4c3582c 100644
> --- a/target/s390x/tcg/vec_helper.c
> +++ b/target/s390x/tcg/vec_helper.c
> @@ -193,7 +193,7 @@ void HELPER(vstl)(CPUS390XState *env, const void *v1, uint64_t addr,
>                     uint64_t bytes)
>   {
>       /* Probe write access before actually modifying memory */
> -    probe_write_access(env, addr, bytes, GETPC());
> +    probe_write_access(env, addr, MIN(bytes, 16), GETPC());
>   
>       if (likely(bytes >= 16)) {
>           cpu_stq_data_ra(env, addr, s390_vec_read_element64(v1, 0), GETPC());

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



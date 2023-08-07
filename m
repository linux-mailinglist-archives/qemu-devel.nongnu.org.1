Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 580DE772BEF
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 19:02:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT3b7-0005vT-AN; Mon, 07 Aug 2023 13:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qT3aj-0005qv-5b
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 13:00:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qT3ag-0007Wx-IF
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 13:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691427620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=akGQJgzYBANsmEik8dZNtmG/sAckthz12THGYMxuntQ=;
 b=KFnnM9p3MjUvuLTrsuQKHCa4jaaXspAk5DZRjFpWRAccvoj0tBx2gXd3Qm9qRG8DP6htk9
 I+vjTPa0Kk4P3yQkRGDX2cNTrmWVC+C51nm58KxgK9UzIlC15FXrQaPngqHZBwZBI3o6up
 NsTRCwviPysdd1wHu4EVFHbwqdxYYdg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-jse0jpeVM4e0qDAi4GTaBw-1; Mon, 07 Aug 2023 13:00:17 -0400
X-MC-Unique: jse0jpeVM4e0qDAi4GTaBw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fe45e71db3so21751465e9.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 10:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691427616; x=1692032416;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=akGQJgzYBANsmEik8dZNtmG/sAckthz12THGYMxuntQ=;
 b=HOQHG3rcIWJAxNmYu5TGYkFyhzTE2UjdqQiiKejvezXyb/701fuUYggKphpQmajC3i
 TKdpo2Ny/HZVC40PksOabMD38JQTkyWPo789pur6YWZmahwImS1rqXwXG1fE4m/ILra7
 /kYVv//HINj5WEiqxAd9HHWbBQKQ0KnoV1cVZyiwtlWyqL/Pak4fJlzRqPFJJT31k58E
 0ReX2+0OrOTzLZCXZvsxcewtIqQhbVnWOGiL3PSls6N6tjwV7vYStTRyZ4uA4+1h/KTY
 gqf6rZ2iseWSQTDJf9TKc1qd30Z+aU8bnr5jdnZmtMxofiHhIIH6afpt7eitOgjv7l22
 ubxA==
X-Gm-Message-State: AOJu0YxPkBVrThAhPWbM+wmKmD47yz+fQTfstnrI7cogmXWVWHNQd2Hh
 yAdwrmElvhZBzSnSJ8ikHLG1UnErqOKegAMjtkacelpA78l0ciRfxwZXSUdzpmjNWCjP8nKCe1m
 tnvz6cVWeQ1Eq2eo=
X-Received: by 2002:a1c:f715:0:b0:3fe:196f:b5f5 with SMTP id
 v21-20020a1cf715000000b003fe196fb5f5mr7838742wmh.16.1691427616603; 
 Mon, 07 Aug 2023 10:00:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+Z0B5fcQdZ5h4JdGndvmn5Mf54inI+5wxiipbQjx8OqTYEB6PzqTGtSP9eIpQfzc3GTe9dA==
X-Received: by 2002:a1c:f715:0:b0:3fe:196f:b5f5 with SMTP id
 v21-20020a1cf715000000b003fe196fb5f5mr7838728wmh.16.1691427616236; 
 Mon, 07 Aug 2023 10:00:16 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:5d00:5143:1cd2:a300:ceff?
 (p200300cbc7405d0051431cd2a300ceff.dip0.t-ipconnect.de.
 [2003:cb:c740:5d00:5143:1cd2:a300:ceff])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a05600c11cd00b003fba6709c68sm11233113wmi.47.2023.08.07.10.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 10:00:15 -0700 (PDT)
Message-ID: <baa436ac-ffe4-8c7d-6eee-af9c26fe3c0f@redhat.com>
Date: Mon, 7 Aug 2023 19:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] target/s390x: Use a 16-bit immediate in VREP
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230807163459.849766-1-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230807163459.849766-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.809, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 07.08.23 18:34, Ilya Leoshkevich wrote:
> Unlike most other instructions that contain an immediate element index,
> VREP's one is 16-bit, and not 4-bit. The code uses only 8 bits, so
> using, e.g., 0x101 does not lead to a specification exception.
> 
> Fix by checking all 16 bits.
> 
> Cc: qemu-stable@nongnu.org

Just curious, why stable? Are there valid programs that set invalid 
element size and they are fixed by this?

LGTM

Reviewed-by: David Hildenbrand <david@redhat.com>

> Fixes: 28d08731b1d8 ("s390x/tcg: Implement VECTOR REPLICATE")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/translate_vx.c.inc | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/tcg/translate_vx.c.inc b/target/s390x/tcg/translate_vx.c.inc
> index f8df121d3d3..a6d840d4065 100644
> --- a/target/s390x/tcg/translate_vx.c.inc
> +++ b/target/s390x/tcg/translate_vx.c.inc
> @@ -57,7 +57,7 @@
>   #define FPF_LONG        3
>   #define FPF_EXT         4
>   
> -static inline bool valid_vec_element(uint8_t enr, MemOp es)
> +static inline bool valid_vec_element(uint16_t enr, MemOp es)
>   {
>       return !(enr & ~(NUM_VEC_ELEMENTS(es) - 1));
>   }
> @@ -964,7 +964,7 @@ static DisasJumpType op_vpdi(DisasContext *s, DisasOps *o)
>   
>   static DisasJumpType op_vrep(DisasContext *s, DisasOps *o)
>   {
> -    const uint8_t enr = get_field(s, i2);
> +    const uint16_t enr = get_field(s, i2);
>       const uint8_t es = get_field(s, m4);
>   
>       if (es > ES_64 || !valid_vec_element(enr, es)) {

-- 
Cheers,

David / dhildenb



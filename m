Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A71C759040
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 10:29:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM2Y3-0001RX-Vi; Wed, 19 Jul 2023 04:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qM2Y2-0001Qo-CR
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 04:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qM2Y0-0003Mc-BZ
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 04:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689755315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JdaUsERgXqeAn4uQo9ztWWzVIuNW8HbeEbB+KWwSYfA=;
 b=NjtGE7brD440IfWQKJ915x32Zo7mQAQbunG/IUDSka1iqgRIiyqRACLO1FfIvGXrm8TfoW
 va99QEUGDjzho8WCDj2vp1DU4R3Eh05MRm1dfd/hT/mNM3MjojcbQ2eUt4hk8w1+hWrh4Z
 H5gYxWRBzHnaCkBTCCm1GJrCB12YNes=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-h2uu8vFdOda4ZnocE0GrgA-1; Wed, 19 Jul 2023 04:28:33 -0400
X-MC-Unique: h2uu8vFdOda4ZnocE0GrgA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f5df65fa35so37961335e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 01:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689755313; x=1692347313;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JdaUsERgXqeAn4uQo9ztWWzVIuNW8HbeEbB+KWwSYfA=;
 b=ZuNjLMF3i1FxsxK6EBxZ4FOCaa0Ye/JtL06RVE8YIE5GIVRgCNBnqWpSJbS6p5zCQq
 d0pGvGH7mvD8YELOWDsZ7rDYuG36aRNuog7EweVAEXOfSOH8jgPBEaWxF/8BCJBErPA8
 7tZt/k/IKe3ai/sCfVRwRm9HkyaNNb/hW72gSmy36gluexPvZXzdxnhb8B2S7BDO6fnE
 X30jcmWNsgBrsHl849/yQg7vu8VaxacTT5n90sTb/tbTcUi3r37KI4VRCwW+1Zs97oER
 svuC8RpABPPciD93Kquhqd3II912wtkxXg7x0+uP2l8jD62Gc4LkJ1YbNjFTpFDc7QuU
 epWQ==
X-Gm-Message-State: ABy/qLYMIt2idKK+ICIXGna60QPXg+4cPEAP5j9EqQwM5wnWhdrcTp0l
 J81vNxo6dgFKXlii7bBkv8HBdtIuTEcqQlYkbEERt1nIpgXJ7jJyAnZaGFdXh38aFyxhaY4ktZU
 NeS+z6NrRpHP9M5k=
X-Received: by 2002:a1c:7703:0:b0:3fb:403d:90c5 with SMTP id
 t3-20020a1c7703000000b003fb403d90c5mr3441002wmi.39.1689755312794; 
 Wed, 19 Jul 2023 01:28:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGmTDYo2Xa+zvdDIZERgDC4jd5fj9+0xFLt1wu99vNu+Bs7lthDvAOmrY4jSal4C9jMHNaGQQ==
X-Received: by 2002:a1c:7703:0:b0:3fb:403d:90c5 with SMTP id
 t3-20020a1c7703000000b003fb403d90c5mr3440989wmi.39.1689755312468; 
 Wed, 19 Jul 2023 01:28:32 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:4f00:b030:1632:49f2:63?
 (p200300cbc74b4f00b030163249f20063.dip0.t-ipconnect.de.
 [2003:cb:c74b:4f00:b030:1632:49f2:63])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a1c4c13000000b003fbe791a0e8sm1113058wmf.0.2023.07.19.01.28.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 01:28:32 -0700 (PDT)
Message-ID: <286ec1fd-e71c-363a-7a60-63f561429f25@redhat.com>
Date: Wed, 19 Jul 2023 10:28:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 03/14] target/s390x: Fix CONVERT TO LOGICAL/FIXED with
 out-of-range inputs
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230718213531.117976-1-iii@linux.ibm.com>
 <20230718213531.117976-4-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230718213531.117976-4-iii@linux.ibm.com>
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
> CONVERT TO LOGICAL/FIXED deviate from IEEE 754 in that they raise an
> inexact exception on out-of-range inputs. float_flag_invalid_cvti
> aligns nicely with that behavior, so convert it to
> S390_IEEE_MASK_INEXACT.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: defb0e3157af ("s390x: Implement opcode helpers")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   target/s390x/tcg/fpu_helper.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/s390x/tcg/fpu_helper.c b/target/s390x/tcg/fpu_helper.c
> index 4b7fa58af3e..3d941ed2d28 100644
> --- a/target/s390x/tcg/fpu_helper.c
> +++ b/target/s390x/tcg/fpu_helper.c
> @@ -52,7 +52,8 @@ uint8_t s390_softfloat_exc_to_ieee(unsigned int exc)
>       s390_exc |= (exc & float_flag_divbyzero) ? S390_IEEE_MASK_DIVBYZERO : 0;
>       s390_exc |= (exc & float_flag_overflow) ? S390_IEEE_MASK_OVERFLOW : 0;
>       s390_exc |= (exc & float_flag_underflow) ? S390_IEEE_MASK_UNDERFLOW : 0;
> -    s390_exc |= (exc & float_flag_inexact) ? S390_IEEE_MASK_INEXACT : 0;
> +    s390_exc |= (exc & (float_flag_inexact | float_flag_invalid_cvti)) ?
> +                S390_IEEE_MASK_INEXACT : 0;
>   
>       return s390_exc;
>   }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



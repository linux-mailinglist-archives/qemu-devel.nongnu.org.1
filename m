Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F030270B7D2
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 10:37:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q111O-0001q8-AH; Mon, 22 May 2023 04:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q111M-0001q0-9b
 for qemu-devel@nongnu.org; Mon, 22 May 2023 04:36:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q111E-0006FG-87
 for qemu-devel@nongnu.org; Mon, 22 May 2023 04:36:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684744551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5rQjupu9GicA/BOA6PlqXcc1t9Dba2HBp8MZe7eVLPk=;
 b=DDFWOIOCb/VrlAZLlVC9rYvAGXonUosegxHJZJjmh73v04/gifDE2FUF1N6mEJsjL93jil
 vMz505jFot74aXiVMybVKqEqqx1fN9T8mFoYPHLUqGF8lQ/Jq/i17q2an+tfo0HJFEcVah
 RqChrf5Z0PBNmMOeIt9gtYrNx1UR06U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-6NSGzyCzMT2aJYlvP5QB0A-1; Mon, 22 May 2023 04:35:49 -0400
X-MC-Unique: 6NSGzyCzMT2aJYlvP5QB0A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-30793c16c78so3678578f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 01:35:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684744548; x=1687336548;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5rQjupu9GicA/BOA6PlqXcc1t9Dba2HBp8MZe7eVLPk=;
 b=VbWjeAFZYDcbpD6DYEt2HfeBvXcv9OJPYPAzMAsxEbaqHCf2mw4RYd4ztunzHdFVCg
 NV+/LVZiow7gkKo3Tz51sI3ZnbMw2I2pPA2mM6jAD0riocBqME/gIKd+eEPK2YxmTG/i
 HXQItxbRaeTxyDyX8W3d7jPLmYl/KOD/yuM/XmB75e0iX5Uh5Cd3CSdKIwsATfv7m4sv
 8J58naVFhqfHDqkqybcdC+fq0Z/pPvzrIfss7prxZlcqhW2wT/whfNJ720vTP2SGodvJ
 5xfiL001yfjJF1ncBluKc7C2m3ChfPPjBrCdT6jBKZEqemMtVoJe37z5I0+asYiJtGzU
 GSew==
X-Gm-Message-State: AC+VfDxIp9Oil10ZheLDI4P/mpK7Lzk7QMgMH9eiDbtfGnCxUWbckOw0
 Q1C40ZLKhH9PmW6iwj9D6PXjOCV6nvkYS+EEdKR0O1+buNNfrTYTulE2cEWjUyavCGjP9HEVtJy
 HwE6+f+f/fZK9XsE=
X-Received: by 2002:adf:f28d:0:b0:307:82e3:70cd with SMTP id
 k13-20020adff28d000000b0030782e370cdmr7323646wro.14.1684744547935; 
 Mon, 22 May 2023 01:35:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ745A50B6DiBchE1TZy9jQWoffORZbiIlR/Q3c6SdCONnl2RpIoYQrcAGeWHxV8sNCkIdoXvA==
X-Received: by 2002:adf:f28d:0:b0:307:82e3:70cd with SMTP id
 k13-20020adff28d000000b0030782e370cdmr7323626wro.14.1684744547527; 
 Mon, 22 May 2023 01:35:47 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:c800:d74f:aec6:f8ac:558?
 (p200300cbc742c800d74faec6f8ac0558.dip0.t-ipconnect.de.
 [2003:cb:c742:c800:d74f:aec6:f8ac:558])
 by smtp.gmail.com with ESMTPSA id
 r14-20020adfce8e000000b00306c5900c10sm7006192wrn.9.2023.05.22.01.35.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 01:35:47 -0700 (PDT)
Message-ID: <698d17f4-8018-41dd-4551-749d715bf71e@redhat.com>
Date: Mon, 22 May 2023 10:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 15/27] target/s390x: Use tcg_gen_qemu_{ld,st}_i128 for
 LPQ, STPQ
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
 <20230520162634.3991009-16-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230520162634.3991009-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.098, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 20.05.23 18:26, Richard Henderson wrote:
> No need to roll our own, as this is now provided by tcg.
> This was the last use of retxl, so remove that too.

That's nice!

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Cc: qemu-s390x@nongnu.org
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

[...]

>       /* psw.addr */
> @@ -3130,15 +3125,9 @@ static DisasJumpType op_lpd(DisasContext *s, DisasOps *o)
>   
>   static DisasJumpType op_lpq(DisasContext *s, DisasOps *o)
>   {
> -    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
> -        gen_helper_lpq(o->out, cpu_env, o->in2);
> -    } else if (HAVE_ATOMIC128) {
> -        gen_helper_lpq_parallel(o->out, cpu_env, o->in2);
> -    } else {
> -        gen_helper_exit_atomic(cpu_env);
> -        return DISAS_NORETURN;
> -    }
> -    return_low128(o->out2);
> +    o->out_128 = tcg_temp_new_i128();
> +    tcg_gen_qemu_ld_i128(o->out_128, o->in2, get_mem_index(s),
> +                         MO_TE | MO_128 | MO_ALIGN);
>       return DISAS_NEXT;
>   }
>   
> @@ -4533,14 +4522,11 @@ static DisasJumpType op_stmh(DisasContext *s, DisasOps *o)
>   
>   static DisasJumpType op_stpq(DisasContext *s, DisasOps *o)
>   {
> -    if (!(tb_cflags(s->base.tb) & CF_PARALLEL)) {
> -        gen_helper_stpq(cpu_env, o->in2, o->out2, o->out);
> -    } else if (HAVE_ATOMIC128) {
> -        gen_helper_stpq_parallel(cpu_env, o->in2, o->out2, o->out);
> -    } else {
> -        gen_helper_exit_atomic(cpu_env);
> -        return DISAS_NORETURN;
> -    }
> +    TCGv_i128 t16 = tcg_temp_new_i128();
> +
> +    tcg_gen_concat_i64_i128(t16, o->out2, o->out);
> +    tcg_gen_qemu_st_i128(t16, o->in2, get_mem_index(s),
> +                         MO_TE | MO_128 | MO_ALIGN);

I briefly glimpsed at tcg_gen_qemu_ld_i128_int (and 
use_two_i64_for_i128()), does this really provide the atomic guarantees 
we need in all cases?

-- 
Thanks,

David / dhildenb



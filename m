Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5B87069A4
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 15:21:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzH51-0004Qe-32; Wed, 17 May 2023 09:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzH4y-0004QB-8X
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:20:32 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzH4w-0001bf-G6
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:20:31 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-64ab2a37812so13015365b3a.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 06:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684329629; x=1686921629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GqCTTpj4T03s0/2I/TdXK9OXfwQAWqDjr5KeOX4anX8=;
 b=PbcI/+UqV+LFZe3Rk9gF0SKAtbbIlSRRHcv13kX004Z5HSeoBkJQu2qQNfGSSgPjwI
 VUJa6fqyxek+DsV9YG0txhZLEzzh3kWkvjP7rkGD7MW9/+h3O6paxN6Zr8VRZfB0rEBr
 Cv9IueqJey7YcAWdClXTRkXHacbxZD9J88p6+ORMORzH0Ddp0OH4Eh412Pp1431ltqdk
 gepDSPdrhHaM4+PV2HIbcpex3N24oeelMVTw6NcWK349OQLvbuhSUYHjeWkfO4os59JJ
 mVNIysR/plORfGg45ZeCkzH+NYEHPxQxdT00gnYIq7MAvMroYV17wLu3aO73YnEmoQBN
 kSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684329629; x=1686921629;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GqCTTpj4T03s0/2I/TdXK9OXfwQAWqDjr5KeOX4anX8=;
 b=b377ovqXghMC1HlxLHuSweGYGw44azsaviVQikx7ymmdMC0Y9VMM/XmzNf+2NhRbAO
 TlmaYWtyzA++8/yXntRZLFaCD2OIm00IUVWUmRYHw88ECgEsGHR4n6UfcLgPeQSGUqdI
 Jtg2Ioq8a0Lkg7DfqT/7ZVmtQJTuvGjQnEn1GjCScrlq/XnBHmuW1hyfoNSgzds5zeOc
 twbihTVzhBzVi4HZRLYpj8Hup1TTS08Z0ASlXSPO/gBn1KbKK0sGKTYOTnsFHpcVOVP6
 mgLUdTTmA9rPE5iO1X16dVP4QJb94n0XBLfH7aTSdHep8EUUyUoIekl0zqWN5YJGg9X2
 6oEw==
X-Gm-Message-State: AC+VfDxe1YxqgRvVrRUWQp1KIgYvASR7BEC1aTJyU75/uiUhiCsQ8c1L
 pYp7EjViWPj8QZpSbQ0TzUXBmQ==
X-Google-Smtp-Source: ACHHUZ4V3r5iYE3akHnzj8KwtGM3yp7IocDPfizcsg4ajZKtCkL3GhnQVFuvChdFS/YRp3C6LZZB8g==
X-Received: by 2002:a05:6a00:291a:b0:63f:2959:a271 with SMTP id
 cg26-20020a056a00291a00b0063f2959a271mr900549pfb.6.1684329628681; 
 Wed, 17 May 2023 06:20:28 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7?
 ([2602:ae:1598:4c01:17a4:1aa0:c49d:e8f7])
 by smtp.gmail.com with ESMTPSA id
 s24-20020aa78298000000b0062a7462d398sm15655995pfm.170.2023.05.17.06.20.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 06:20:28 -0700 (PDT)
Message-ID: <59f86761-effc-9cf0-ee17-4e8e81a8a47d@linaro.org>
Date: Wed, 17 May 2023 06:20:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] include/exec: Make ld*_p and st*_p functions
 available for generic code, too
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Burton <mburton@qti.qualcomm.com>
References: <20230517074222.766683-1-thuth@redhat.com>
 <20230517074222.766683-2-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230517074222.766683-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.412,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/17/23 00:42, Thomas Huth wrote:
> +static inline int ldl_p(const void *ptr)
> +{
> +    return tswap32(ldl_he_p(ptr));

Not an ideal formulation for some hosts, e.g. Power < 3.0, because there is no separate 
bswap instruction.  Power 2.07 only has bswapping-load/store.  Keeping the bswap adjacent 
to the memory operation helps the compiler.


> +static inline uint64_t ldn_p(const void *ptr, int sz)
> +{
> +    if (target_needs_bswap()) {
> +#if HOST_BIG_ENDIAN
> +        return ldn_le_p(ptr, sz);
> +#else
> +        return ldn_be_p(ptr, sz);
> +#endif
> +    } else {
> +        return ldn_he_p(ptr, sz);
> +    }

Better to avoid #if for if.  And even better to merge to one test:

     if (HOST_BIG_ENDIAN ^ target_needs_bswap()) {
         return ldn_le_p(ptr, sz);
     } else {
         return ldn_be_p(ptr, sz);
     }


r~


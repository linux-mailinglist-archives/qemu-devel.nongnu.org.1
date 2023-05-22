Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A072270B7E4
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 10:44:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q118L-0004N7-Kg; Mon, 22 May 2023 04:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q118I-0004Lb-4e
 for qemu-devel@nongnu.org; Mon, 22 May 2023 04:43:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q118G-0007bw-8V
 for qemu-devel@nongnu.org; Mon, 22 May 2023 04:43:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684744987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y7GJx2IGxEO28u6y8JGl1yjARhQ3bV/zpE/5r1Md8os=;
 b=WPW+JuR0E8JlzsdohcWrLfEMj7J0e1H2Yob8hWw+XXi86dlkFk6Y6rimdvjCnDM6+ZouAe
 zX8eB+Oeg8VSil2A1dRa0ccJRboLBpfmFyKg3jbo0XK38LkAlf1Uz/jcixT3RvbmDRaxTx
 97u9tpVAY2tu4l539ayuGcVUT4DZ7P0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-BJ9sP0gbOtG6WPbVOpYRtA-1; Mon, 22 May 2023 04:43:05 -0400
X-MC-Unique: BJ9sP0gbOtG6WPbVOpYRtA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30a8ba2debdso343199f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 01:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684744984; x=1687336984;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y7GJx2IGxEO28u6y8JGl1yjARhQ3bV/zpE/5r1Md8os=;
 b=OisfhrdSahhwgz1W6XUGv3AlLXmvzhUCkMQyURp6gCoMrQV6WEGy13f2MeX1NiHg7q
 T3ywgo+z2sWWqyreudVp2mJbqM+aklTSPll+Gobx9YQxwmIaYjgWG0MUQJ52689qEgBA
 IpcJ3HxFfAve1jlXoTdV+1HzABg0dW2vN7lof/us8nVQkCThoBd5M9owh0WbqfdGqq/e
 U4l0D7uwu3pd7hmAD7svqaU/lj4bhU8+CWmTQ+/u6ngHNelXX3ffOQ+OqG1WVX74+aig
 9BuTuQcQ/y480eStv/dVI0guMspSyugAQ28DoiJzu5lOpg+Qs2ZNxO+HGIe2ot/t+1qY
 +t3g==
X-Gm-Message-State: AC+VfDzNjbMLarjOQRVE0Z7mKvwwCbHv8/tahmdYRkgBo7Hwzp1NeLCC
 fD7DJmDUPIUDJdA9fOdIOUtfomoBZnGtns9OdVR9u8wFqxD1vMD6bvbuPtiOQlqR3yonmLrvFC/
 v7lyg6y3cVmQJ3vE=
X-Received: by 2002:adf:de10:0:b0:306:2fab:1f81 with SMTP id
 b16-20020adfde10000000b003062fab1f81mr7831055wrm.21.1684744984659; 
 Mon, 22 May 2023 01:43:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ46onyGzyJPN87swWNeAYqsVm5yT6eodg9JAN4FBycxJ8/rCQk8GOV4+uPL1RHKI7ZP0xg7tQ==
X-Received: by 2002:adf:de10:0:b0:306:2fab:1f81 with SMTP id
 b16-20020adfde10000000b003062fab1f81mr7831036wrm.21.1684744984280; 
 Mon, 22 May 2023 01:43:04 -0700 (PDT)
Received: from ?IPV6:2003:cb:c742:c800:d74f:aec6:f8ac:558?
 (p200300cbc742c800d74faec6f8ac0558.dip0.t-ipconnect.de.
 [2003:cb:c742:c800:d74f:aec6:f8ac:558])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a5d61c2000000b00309382eb047sm6940657wrv.112.2023.05.22.01.43.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 01:43:03 -0700 (PDT)
Message-ID: <c4f01a0f-17af-ddc0-3b8a-27a735a60371@redhat.com>
Date: Mon, 22 May 2023 10:43:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
 <20230520162634.3991009-18-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 17/27] target/s390x: Use cpu_{ld,st}*_mmu in do_csst
In-Reply-To: <20230520162634.3991009-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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
> Use cpu_ld16_mmu and cpu_st16_mmu to eliminate the special case,
> and change all of the *_data_ra functions to match.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Cc: qemu-s390x@nongnu.org
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

[...]

>                   /* Note that we asserted !parallel above.  */
> @@ -1876,29 +1872,20 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
>       if (cc == 0) {
>           switch (sc) {
>           case 0:
> -            cpu_stb_data_ra(env, a2, svh >> 56, ra);
> +            cpu_stb_mmu(env, a2, svh >> 56, make_memop_idx(MO_8, mem_idx), ra);
>               break;
>           case 1:
> -            cpu_stw_data_ra(env, a2, svh >> 48, ra);
> +            cpu_stw_mmu(env, a2, svh >> 48,
> +                        make_memop_idx(MO_TE | MO_16, mem_idx), ra);

To make these two cases look less special, maybe just define oi1 and oi2 
as well at the top?

LGTM

-- 
Thanks,

David / dhildenb



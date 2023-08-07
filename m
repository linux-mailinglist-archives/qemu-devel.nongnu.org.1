Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC43A772DC5
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 20:22:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qT4r7-0006Jj-NO; Mon, 07 Aug 2023 14:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT4r5-0006JO-16
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 14:21:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qT4r3-00037N-9q
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 14:21:22 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bbc06f830aso32558645ad.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 11:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691432479; x=1692037279;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p4wcFhQ4KN13V5JJyIMz/VC6ikqOe/V4/L3ec4bmILI=;
 b=jPB0QRJllCxzUbtlE9sxZJRdgiyJU6FX30ayFummJS5r816dQP5qlZJOkcOy5ODwnA
 ytKI3PHp+ldyjxwW8tsB0F3R3BtfaHGgt+iktKXwDkqcA/ODdp/bZPKIAjeUOUIQDL9f
 c+WU6gQYXfoJ4c+mZFUkjvQ4D5BDWT9zH1BmJzW398IzDaiPy4SEpy3v3S6fPI73ASOc
 kHyo5vSJytkdLm85H+OkpOo8xgfdifss9gQ08xbK8W8JbARYW0IYia/ughWOpDaqXnL0
 agBLNTKTSp14ZB6HK6mh6ybLdkaLs4oncjGvP/DUprwat3/HbV3yaalBQNqgl43VhTTS
 8egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691432479; x=1692037279;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p4wcFhQ4KN13V5JJyIMz/VC6ikqOe/V4/L3ec4bmILI=;
 b=dumnZFQc7vDQiNFEX+CIrrcSFDjP5mWy/QTdaReciADypGpoR8s6V8/go3HyNe4yE8
 /Tet4PcwB5a2/ayHcsG6Rx6n/a7MJsei/bStjAFt3MUui0L46w31akPKs6VxWjoKilQD
 U9DK54ZOvWK0vm8TWOZVaaTS69j3UmqV3C0elViRelKqxEVyVrltp/n8fwd/wL8TLlg9
 fEup9GZQe3n05A+lm9g0Gacuz0hyahQx6pwr4p9ahblamoJ3PTMBEF8VvC5U1yyjdHcQ
 gfghrIYg3+H8Uu72XP2vtXGFClE8R+oNu/Lht9ZLGVsxwBzTvLOBLrpH+iLTlX8j0rhW
 IO5Q==
X-Gm-Message-State: AOJu0Yw3sNaewvA0nifmseQKsA87GE8FTFJUyC2jDIg+8H4Q9LElL4GY
 C9lzx4jCCrEXtMH8UXHeX4WRpg==
X-Google-Smtp-Source: AGHT+IGSp0HLX88oTSM6vCnhAuAGp21YTf+3E9iAIHH5W4om8Nw/FiPUdoJCm7VZP6Z0WnW+vds/kw==
X-Received: by 2002:a17:902:ce8b:b0:1bc:2fe1:1821 with SMTP id
 f11-20020a170902ce8b00b001bc2fe11821mr9851417plg.17.1691432479619; 
 Mon, 07 Aug 2023 11:21:19 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:e306:567a:e0a1:341?
 ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 b21-20020a170902d31500b001bbd8cf6b57sm7194174plc.230.2023.08.07.11.21.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Aug 2023 11:21:19 -0700 (PDT)
Message-ID: <93412928-2b4b-6541-631e-2d57ccd5f05e@linaro.org>
Date: Mon, 7 Aug 2023 11:21:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC 1/1] tcg: Always pass the full write size to
 notdirty_write()
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20230807141846.786530-1-iii@linux.ibm.com>
 <20230807141846.786530-2-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230807141846.786530-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.809,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/7/23 06:56, Ilya Leoshkevich wrote:
> One of notdirty_write()'s responsibilities is detecting self-modifying
> code. Some functions pass the full size of a write to it, some pass 1.
> When a write to a code section begins before a TB start, but then
> overlaps the TB, the paths that pass 1 don't flush a TB and don't
> return to the translator loop.
> 
> This may be masked, one example being HELPER(vstl). There,
> probe_write_access() ultimately calls notdirty_write() with a size of
> 1 and misses self-modifying code. However, cpu_stq_be_data_ra()
> ultimately calls mmu_watch_or_dirty(), which in turn calls
> notdirty_write() with the full size.
> 
> It's still worth improving this, because there may still be
> user-visible adverse effects in other helpers.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

IIRC there are some uses of probe_access_* that set size == 0.
Should we adjust addr+size to cover the whole page for that case?
That seems to be the intent, anyway.


r~

> ---
>   accel/tcg/cputlb.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index d68fa6867ce..aa3cffbc11a 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1582,7 +1582,7 @@ int probe_access_full(CPUArchState *env, vaddr addr, int size,
>   
>       /* Handle clean RAM pages.  */
>       if (unlikely(flags & TLB_NOTDIRTY)) {
> -        notdirty_write(env_cpu(env), addr, 1, *pfull, retaddr);
> +        notdirty_write(env_cpu(env), addr, size, *pfull, retaddr);
>           flags &= ~TLB_NOTDIRTY;
>       }
>   
> @@ -1605,7 +1605,7 @@ int probe_access_full_mmu(CPUArchState *env, vaddr addr, int size,
>   
>       /* Handle clean RAM pages.  */
>       if (unlikely(flags & TLB_NOTDIRTY)) {
> -        notdirty_write(env_cpu(env), addr, 1, *pfull, 0);
> +        notdirty_write(env_cpu(env), addr, size, *pfull, 0);
>           flags &= ~TLB_NOTDIRTY;
>       }
>   
> @@ -1626,7 +1626,7 @@ int probe_access_flags(CPUArchState *env, vaddr addr, int size,
>   
>       /* Handle clean RAM pages. */
>       if (unlikely(flags & TLB_NOTDIRTY)) {
> -        notdirty_write(env_cpu(env), addr, 1, full, retaddr);
> +        notdirty_write(env_cpu(env), addr, size, full, retaddr);
>           flags &= ~TLB_NOTDIRTY;
>       }
>   
> @@ -1661,7 +1661,7 @@ void *probe_access(CPUArchState *env, vaddr addr, int size,
>   
>           /* Handle clean RAM pages.  */
>           if (flags & TLB_NOTDIRTY) {
> -            notdirty_write(env_cpu(env), addr, 1, full, retaddr);
> +            notdirty_write(env_cpu(env), addr, size, full, retaddr);
>           }
>       }
>   



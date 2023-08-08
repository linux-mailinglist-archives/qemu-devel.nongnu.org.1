Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 164F6773AB4
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 16:23:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTNcN-0000PE-Ps; Tue, 08 Aug 2023 10:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTNcL-0000Od-F9
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:23:25 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTNcJ-0001u7-O5
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:23:25 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bc7e65ea44so7183725ad.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 07:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691504601; x=1692109401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0EPhisG/1kXrzjm6tjTiZRBk7v6dPc8UsSJ7IYfdos4=;
 b=moAL0V2Wp8STs5r3EDZ6HkzhNk30T8rRMJpKuf6msFnPN/sHgj5j8F6LxME0R42xWV
 l7USCUIvy2TUYJg7eW4vwwzqf67n9wO5eNqLiBI7r0WNJ7KSv12ZZkcSfJOYvSNzMQwG
 ERgGTfx8+cG1TzVxkqam0mBq1Z9D+6eybwTUjRg+vhe+M++E//yTzo6ly8/bPOwzq2kl
 KPNaEjVscaiIIW5zK7WpUXRi04hvw3bz2ejko7d/DxFaIsogzZzDL/hGzOwu5bLfDwna
 YMbCAFYf6P4SsnxzXY720rwUPiG1ErlIx+BmVB8bXASn+6reV3pxEq8VXOGfh6VSiAkx
 2pwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691504601; x=1692109401;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0EPhisG/1kXrzjm6tjTiZRBk7v6dPc8UsSJ7IYfdos4=;
 b=gAvY5UPBqAtnze2h5AMKSlt4SDIGvmBzMxpFBsNCvUjyeBaVrmgRe1deRUcco9a0dW
 eHIF3DmUP/6UDBnLNJr7Y+z5bGsg8LVB+2Z3ZF8MQwFhkCWq8bRVoDNCtrRV8o6xai20
 Xjpzs+0dfS1k5ppd1kyTzA2Kw0U77zH0VHKvxIn8CNvEIh4y/WVTO381+3rHFMiZ7XrQ
 dk3qLkEVNlimoqP2U6yZ4i2TDdojoLk0KD4o+gnQtt3rYaT4kG4enXYDidhTTq/2BOmS
 wN2bEoM0gvg0fubywuKHRROw3uPV7n7P7kkpIqf4G1KoWRjNjg93O56AubVaKxPFZb3U
 0c8A==
X-Gm-Message-State: AOJu0YzAaqSqKqaQkaNlOh5kbOSUam9YEhDQXdBEpGUmy8DzJXEUfld2
 j47SFcVPc403QaJzQF8H9a8piQ==
X-Google-Smtp-Source: AGHT+IF8/w3r9Ee9FsSoufp2FdfbqcmwJHc0+ErAoWXIiDPl37zYAzqhXir3sRs0z29sCFlJtx7+ng==
X-Received: by 2002:a17:902:f68e:b0:1bc:7e37:e832 with SMTP id
 l14-20020a170902f68e00b001bc7e37e832mr3166976plg.19.1691504601447; 
 Tue, 08 Aug 2023 07:23:21 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902cec500b001b8a8154f3fsm6512302plg.270.2023.08.08.07.23.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 07:23:20 -0700 (PDT)
Message-ID: <edb568b4-017f-3a75-dd07-7556438779f8@linaro.org>
Date: Tue, 8 Aug 2023 07:23:18 -0700
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
 <93412928-2b4b-6541-631e-2d57ccd5f05e@linaro.org>
 <309ee7ed61a0185c687ae184692198b3c2989970.camel@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <309ee7ed61a0185c687ae184692198b3c2989970.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/8/23 02:59, Ilya Leoshkevich wrote:
> On Mon, 2023-08-07 at 11:21 -0700, Richard Henderson wrote:
>> IIRC there are some uses of probe_access_* that set size == 0.
>> Should we adjust addr+size to cover the whole page for that case?
>> That seems to be the intent, anyway.
> 
> There is a comment that says we shouldn't do watchpoint/smc detection
> in this case:
> 
>      /* Per the interface, size == 0 merely faults the access. */
>      if (size == 0) {
>          return NULL;
>      }
> 
> Come to think of it, qemu-user works this way too: SMC is detected on
> the actual access, not the probe:
> 
>      helper_vstl()
>        cpu_stq_be_data_ra()
>          ...
>             stq_he_p()
>               <signal handler called>
>                 host_signal_handler()
>                   handle_sigsegv_accerr_write()
>                     page_unprotect()
>                       tb_invalidate_phys_page_unwind()
>                     cpu_loop_exit_noexc()
> 
> So all this is probably fine, I now think it's better to leave the code
> as is, especially given that I cannot reproduce the original problem
> anymore.

Ok then.


r~


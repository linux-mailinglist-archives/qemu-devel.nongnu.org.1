Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE237B7431
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 00:40:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qno3f-0003xA-3L; Tue, 03 Oct 2023 18:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qno3b-0003wQ-Vz
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 18:40:00 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qno3a-0006Po-Fb
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 18:39:59 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c5db4925f9so2579715ad.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 15:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696372796; x=1696977596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zGooJ2/JE5KDXZ1GEL3kIwrkriNuX70m749e4iiTq4M=;
 b=MSA6xJoA6HCKUNd36ZhTWfy0Cfj4ttV3nyXcFcRpVZrLGOTZmJZCPTBSgcS/qeLgWI
 /qhICWpmZbOctf1BVT0D7Wygkb2ziXCOvJ54sf7BDsW+lv9MI+hp6Lnh5MONdU8cecYM
 SzDyCjIzeAIov/henr/Q4nq5tGg3zlhbeNCSbaUl403QB7GNxYn7tvgoKAvqtO5M89xP
 Nf8mEv4yvu9vtB65dznzCe3RiREReF2KrFEzPtIJND+tWbpGAlDsatRl43HQUGGZqJHM
 UU8IWpBoZGM7GNzvQ348PSQf1Rbf5NO5yP543gFrjffz1mAiAAFLNdEPpj6LnZUjc6z3
 fYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696372796; x=1696977596;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zGooJ2/JE5KDXZ1GEL3kIwrkriNuX70m749e4iiTq4M=;
 b=GhJZMQzsqhRJbzu2CGGX2+VMsU/3ozHCA3sNZkMiSOBtIXHIJIP45BgRNkWhyFvf1/
 eHE9cc/3L0KQqWLRZdPCJB1c9rvBRPI8EsPkNjOJUB7OKq4UEjd/9wKKC4csyvQpYLN6
 1RK21PuxzNYrZrElElIJLC2mDJ1aetBn7t6XJbWCqApL+6+b0+8b8dGMaktsgzvPsR8m
 ga2qbABmPQMqbESB+1eiXMnrD+uWEikKDyV2jDYYygRSSErNB16qrGv3u9VWfIHCmNsr
 yh5vFDinTT4NGebzdbcOMoHUPwecijOpST2fZXNzroP7V/7gDLz502ReuvK3QB4VXqTq
 SGcw==
X-Gm-Message-State: AOJu0YzaCgDY0sCaZhuIZCYy12cPRVJlREwkdMi+xsWl7BzPmOx0fnNq
 /irVnYyFL04LaKfTucNur1c6KggxouwlXwrbjlk=
X-Google-Smtp-Source: AGHT+IG9zWsCh0l4nz7Vry1lgwISdZ5bUTKclpOzaE0OTCYummIlDgF4cFe4F5eBH0cW9mf6ovIeNQ==
X-Received: by 2002:a17:902:ea05:b0:1c7:7c2c:f828 with SMTP id
 s5-20020a170902ea0500b001c77c2cf828mr914091plg.8.1696372796211; 
 Tue, 03 Oct 2023 15:39:56 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170902ee0200b001c736746d3fsm2127584plb.271.2023.10.03.15.39.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Oct 2023 15:39:55 -0700 (PDT)
Message-ID: <ec38df5b-9533-4ba2-a9d9-05514456b8bf@linaro.org>
Date: Tue, 3 Oct 2023 15:39:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/3] target/m68k: Fix a few semihosting bugs
Content-Language: en-US
To: Keith Packard <keithp@keithp.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>
References: <20230802161914.395443-1-keithp@keithp.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230802161914.395443-1-keithp@keithp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.09,
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

On 8/2/23 09:19, Keith Packard via wrote:
> The first two patches mirror similar patches I recently sent for nios2.
> 
>   1. Use correct parameter for EXIT (d1 instead of d0)
>   2. Fix use of deposit64 in LSEEK (argument order was incorrect)
> 
> The second patch has also been submitted by Peter Maydell, it's
> included here because it was required to get things working.
> 
> The final patch adds semihosting support for non-ColdFire processors
> (which don't support the HALT instruction) by using BKPT #0 instead
> (as per the m68k semihosting docs).
> 
> All of these have been tested using picolibc (patches for m68k support
> there are moving upstream as well).


Queued patch 1 to m68k-next.  Patch 2 has already been committed, and I've just sent a 
replacement for patch 3.


r~


PS: I hadn't noticed the picolibc note here at the time; I'll give that a try later today.


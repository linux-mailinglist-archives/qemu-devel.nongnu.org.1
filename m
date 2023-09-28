Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D387B288C
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 00:47:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlzlI-0001rf-QB; Thu, 28 Sep 2023 18:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlzlG-0001rW-Bp
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 18:45:34 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qlzlE-0001N2-3A
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 18:45:33 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2773af0c5dbso7326691a91.1
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 15:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695941129; x=1696545929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IcC/MsCxVDxwzvhC4rC31SsimmPJ3S29hyuG24mq47w=;
 b=zeZB8wMMv94D0h5wa3gOQl92JBYkyJLuDy4j+eo4ZUfKWsjvTIGvfEmA63o023D35/
 y4yKIu3Q/mV5EfNLuMyNjfSam6Gi4XGKWMDxXZkkGH0hilJKh/U2TRlE1Q4kzSHOJQav
 AP9hDrc+gpCgBQamS0gYRT/VFaqFiZShyK4stf/LXJScx8NBlxMNTQcXk49s1HSMwqsr
 Hjpdc15o3hTXTj61tBkROuawVFeGfF29wg4Z0WMdU0DOvG5LdgBVCV2c67RF8exsWKTQ
 XgDIDlX++soxtlftsgujzu05VmTo+O6A5YJgVZqbP3H5VICtpJF2N/iJWgwbP+i2cVsl
 vIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695941129; x=1696545929;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IcC/MsCxVDxwzvhC4rC31SsimmPJ3S29hyuG24mq47w=;
 b=oCGgdoBMtWWVCmJG52mzMiTk91rLcMyX2ts1L+Lgi14fOqIpUD8DI9nzcl86QfOTqR
 est2f6Rih3imvUUkvYcJqPGviXAQQqf98GuBH38bt2owugWfvysZ6lfX9w9RVi/Lp0vp
 X9oSAORtb1I/dnxAod3IjnEKuhm20xp5CTBT6SDIvImCjm0GAt1pETKkonZoaX2o6wlV
 9Aw2snWRs1ev+G3QEDFEyh+RC2f9EI+BfL5cx5ByB7TZZeGbUoS+RL7V460FESw7EVb2
 hbPhfiBK6ve/F4zKJf4Wq+F5iQkZtqxIFgQBkzRQa6sE91/IRLr4j/mqSWbW/ErbeJBF
 HnUA==
X-Gm-Message-State: AOJu0YzpjD5asuoG4/aU6EAndmDz1s7VA8jUrNXbeeeKUZ/MBomBy2oX
 3QBtOeX9REmtOAeW8k3sb/mPRySVnpR8FE9dzvo=
X-Google-Smtp-Source: AGHT+IG1qY6jLCwNfij5TY0EswHiyOmMG18iJ9JP6znQ0dvHP+w6f67j8TIch9Tn+HA1weYTj8i+cg==
X-Received: by 2002:a17:90a:b101:b0:273:e8c0:f9b with SMTP id
 z1-20020a17090ab10100b00273e8c00f9bmr2374119pjq.15.1695941129168; 
 Thu, 28 Sep 2023 15:45:29 -0700 (PDT)
Received: from [192.168.0.4] (174-21-146-124.tukw.qwest.net. [174.21.146.124])
 by smtp.gmail.com with ESMTPSA id
 gv9-20020a17090b11c900b002749fee7984sm66041pjb.22.2023.09.28.15.45.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 15:45:28 -0700 (PDT)
Message-ID: <ed9a5058-a26a-6e7f-c6c5-0cc68b016632@linaro.org>
Date: Thu, 28 Sep 2023 15:45:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 0/4] tcg: Optimize loads and stores to env
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20230831025729.1194388-1-richard.henderson@linaro.org>
In-Reply-To: <20230831025729.1194388-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

Ping.

r~

On 8/30/23 22:57, Richard Henderson wrote:
> This is aimed at improving gvec generated code, which involves large
> numbers of loads and stores to the env slots of the guest cpu vector
> registers.  The final patch helps eliminate redundant zero-extensions
> that can appear with e.g. avx2 and sve.
> 
>  From the small amount of timing that I have done, there is no change.
> But of course as we all know, x86 is very good with redundant memory.
> And frankly, I haven't found a good test case for measuring.
> What I need is an algorithm with lots of integer vector code that can
> be expanded with gvec.  Most of what I've found is either fp (out of
> line) or too simple (small translation blocks with little scope for
> optimization).
> 
> That said, it appears to be simple enough, and does eliminate some
> redundant operations, even in places that I didn't expect.
> 
> 
> r~
> 
> 
> Richard Henderson (4):
>    tcg: Don't free vector results
>    tcg/optimize: Pipe OptContext into reset_ts
>    tcg: Optimize env memory operations
>    tcg: Eliminate duplicate env store operations
> 
>   tcg/optimize.c    | 226 ++++++++++++++++++++++++++++++++++++++++++++--
>   tcg/tcg-op-gvec.c |  39 ++------
>   2 files changed, 225 insertions(+), 40 deletions(-)
> 



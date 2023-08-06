Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E920771343
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 04:31:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSTWk-0001V4-7m; Sat, 05 Aug 2023 22:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSTWi-0001Uq-9n
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 22:29:52 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSTWg-0003d0-3t
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 22:29:51 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686ea67195dso2444881b3a.2
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 19:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691288987; x=1691893787;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CV6frvHpLqFcWkIVTetfdWuI3N++aPrlUjO2RAavXnk=;
 b=b3PArdf0x3+k6v2V61B/JZ4wx/NzqToSieL3JtfjZJARtnYoeuCC00DJJpb03QA8eU
 bY0VOEcnD7FKxIGkVpN+J9LXvvydSRyI7OSdgRRTGH4/8pkP6BJ4O5yGtLQGX2099mRy
 FS944SAJkYNoJgKHeqwGABcKv3aGpikaXaLzePM99cMiDqs/2bjJBtUvv2PjZhI/UOXI
 taENVO8b4OxgZfM/TJxQG+dCUbhAxNiUsG64UhBow44jMuj30UR7Rm4IQ4pN6Ifu5Dd5
 SYSib2ckN1yicrHixAMtE5OKMle9wNE2FY1UAYSqhrjaf2bpYyBbPIYRjzS7TG5y7GCW
 v+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691288987; x=1691893787;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CV6frvHpLqFcWkIVTetfdWuI3N++aPrlUjO2RAavXnk=;
 b=TFoMzyq2kaNMRAolHy8+9QICdWTMH3df1rjsPkyeFvfcYGf4fExfZWbNSa9VJIvHXG
 sx5kmIRbsmILCtFoRXCQ6lfGkwSmSe94WPNBPGib0z3jbVYEWn+cSDRmj2RtbQ9wcERO
 qUCWOcRCAlv5Fpo11fYENeHHDsZdx16Tl+JOFWOfhRyIR3tPIzS3vAgUf8J+HE7Ulrp7
 sxwE6pzMaVZT0v3/EeNPEDy90Nufk8nD3DLU0xD9GHvDVeCPZAcAeDjz43bLtfxj6ZyQ
 B0ymJIATytyVPow0/yb7YI6Hs5v7g3EKRvkqvVb8Nvxqx4dGV04p/KnwVs3rxPROAELy
 hFNg==
X-Gm-Message-State: AOJu0YzxMSiqTFDWsQt5Xc/rZCwS34tuZS4w2tKlldVK4ek7l+Ovnqvl
 0Pys9peHEfd6Pe38Fmp0Fvq09w==
X-Google-Smtp-Source: AGHT+IGl881PPq3RHi0p5zyb2KNR2CkqAs1cDgJ510/a1g8+skc7cUkTU2BG/rHDppVaZChS7zsFNw==
X-Received: by 2002:a05:6a20:8e19:b0:135:38b5:7e63 with SMTP id
 y25-20020a056a208e1900b0013538b57e63mr6591804pzj.46.1691288987339; 
 Sat, 05 Aug 2023 19:29:47 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:9454:a46f:1c22:a7c6?
 ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 l2-20020a62be02000000b00686f9789064sm3859173pff.12.2023.08.05.19.29.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Aug 2023 19:29:46 -0700 (PDT)
Message-ID: <da2bf153-151a-baf1-7e7b-ab5f8ba5b3cc@linaro.org>
Date: Sat, 5 Aug 2023 19:29:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] linux-user/i386: Properly align signal frame
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20230524054647.1093758-1-richard.henderson@linaro.org>
 <9d06173b-f739-df6b-263f-bb426e2fef97@linaro.org>
 <9311fdff-325b-6591-99e8-7ea0cb027ae6@linaro.org>
 <cca0a698-2ce6-dcfa-129c-4a205287e1ca@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cca0a698-2ce6-dcfa-129c-4a205287e1ca@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 8/5/23 14:56, Michael Tokarev wrote:
> 30.06.2023 20:53, Richard Henderson wrote:
>> Ping 2.
>>
>> On 6/20/23 15:26, Richard Henderson wrote:
>>> Ping.
>>>
>>> On 5/24/23 07:46, Richard Henderson wrote:
>>>> The beginning of the structure, with pretaddr, should be just below
>>>> 16-byte alignment.  Disconnect fpstate from sigframe, just like the
>>>> kernel does.
> 
> Whom we're pinging here? :)
> Ping 3 ;)
> 
> (This is https://gitlab.com/qemu-project/qemu/-/issues/1648 and is a
> -stable material too, it seems)

In the month since, I've discovered that fpstate needs even more work.
This is extremely fiddly stuff, and we need a complete rewrite to match the kernel and the 
required alignments.


r~


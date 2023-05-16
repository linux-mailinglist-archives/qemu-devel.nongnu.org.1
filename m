Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D83B2705898
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:18:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz17u-00012G-7e; Tue, 16 May 2023 16:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz17q-00011j-Vq
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:18:26 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pz17p-00026a-F4
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:18:26 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-24e015fcf3dso65954a91.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684268303; x=1686860303;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hPSpYXYJyTn7q6Bx7De1ARGSCWBjP8AURJuhet86WqU=;
 b=Ah/cWYKOW8sBIMrHvAT50lSyeeBU7rr260NB7VBI8T5AElShdQYmrHiSLAJD5vqkTM
 VJvY5RwqT2Dbdp/YNEEDhN/zAsqykMzbIhomZ0D9Dnw96+Zv+aWC7dzk2AwJEqdexd8e
 Mk6bo0K0G3MALtYyZ7yVosb3/CeXSxLhbjmZIXN3rlrQsdgAvd53OkWCCpS5o0GKkFpC
 ZbHjM7r29USxYrngPvFYAOUxqJwNpJerYLyam+pIlxg1MFGL5WgZQEC/+BmhCQe4KSlB
 wO97xuV/TdsWL/vAylfv2qLTeeXcUgBftxj+kko2hBJM7FWeiJcdkZZnMVZhtMm44Eh4
 mn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684268303; x=1686860303;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hPSpYXYJyTn7q6Bx7De1ARGSCWBjP8AURJuhet86WqU=;
 b=dDTLIAkXxtXNnv+pvV8zFG4X3vJr5B328i21nDsZ9JMLe3pf4o2eTVNKYz3sCbgqMf
 yphewDuML/kf9SkumjaspPA0H1gciFvmKvxUBsJnC5H2eL9h+dY5Ln6wzdCEvOo9m+iJ
 RLFtTqAG83DtujgfMXM/uvhKQMt2627NG02NAzDqboMcSAOfdOj67NDTxCVRWYdSQyHK
 3Ds0Hl/vqaDAJEHTsfaGgM4TI9ZMSz4XkXrEcO07HSWyDfnHqqFHuAC601SGm6Q+Ez3x
 kIYuCAjSd753FsnOFVo7yofJAvKcQ4+EkPLUcnxFt/OAaMaJCzDciFaeEcDdBM/9j704
 OuBQ==
X-Gm-Message-State: AC+VfDzsIn3VKSJFiY70heoMF3WA/PgpJB0stwbfZe0g6bOid8s+6NV9
 0BXh3GmAkVG8NvIpNIBmh37Njg==
X-Google-Smtp-Source: ACHHUZ4+tMZDH7W760dAV5SjYkSW8RV0gkviGJ1aHGoetkvr9Ty4tfoJev2CSRYB/KQ0xOK9reguRw==
X-Received: by 2002:a17:90a:d24f:b0:24e:4a1a:39a4 with SMTP id
 o15-20020a17090ad24f00b0024e4a1a39a4mr39636175pjw.17.1684268303298; 
 Tue, 16 May 2023 13:18:23 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:ec81:440e:33a4:40b9?
 ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 23-20020a17090a0c1700b0024e3d26f644sm7315pjs.3.2023.05.16.13.18.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 13:18:22 -0700 (PDT)
Message-ID: <b0e8d8e2-1896-442d-41fe-33da8b412ccc@linaro.org>
Date: Tue, 16 May 2023 13:18:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] tcg/i386: Set P_REXW in tcg_out_addi_ptr
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-stable <qemu-stable@nongnu.org>
References: <20230512171755.1237329-1-richard.henderson@linaro.org>
 <fa44c412-d40b-cd7e-f861-850991169fb5@msgid.tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <fa44c412-d40b-cd7e-f861-850991169fb5@msgid.tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.666,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/16/23 13:11, Michael Tokarev wrote:
> 12.05.2023 20:17, Richard Henderson wrote:
>> The REXW bit must be set to produce a 64-bit pointer result; the
>> bit is disabled in 32-bit mode, so we can do this unconditionally.
>>
>> Fixes: 7d9e1ee424b0 ("tcg/i386: Adjust assert in tcg_out_addi_ptr")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1592
>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1642
> 
> This looks like stable-8.0 material.

Yes indeed, please.

r~



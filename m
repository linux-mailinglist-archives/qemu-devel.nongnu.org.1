Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 880C275E3DF
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 18:37:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNc56-0006Mx-4J; Sun, 23 Jul 2023 12:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNc4y-0006MI-F7
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:37:08 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNc4w-0004K9-EX
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 12:37:07 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-316eabffaa6so2451356f8f.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 09:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690130225; x=1690735025;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K37PGz9PLk9VxO2QJVRWygC89a+QudXjfq9SIPWYGGQ=;
 b=nLsp5ijlTGM943Lu0DDGyyu1MSPThs3xQRzoqfS0YrHSaCQtZBTF52c+um800X27F1
 ICOkp8KmR683/bkOIRvcpeTGrgHK34h7CSdRD+ZzlXbFNKzd2iJg9b7Eaqu40Jy7kw02
 b5/niWId/YpWqAm4Fo3oXojK+KgLJGH+FU7bzWOitl5irCpxOld/WVRsWwxAi+/fwUCN
 f5dgtXOER0iLvMzKOSEhotq8/PjzUclHVJQcv2rTo6JAMu8eC7VHroz+9a0sdNc+QZdP
 oQ49Fc4Sh+3icUWwljl2meo+s4RlbXr+Dp27DHmyACNSKpESTwwKv3nsMcXcWormfw0K
 iM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690130225; x=1690735025;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K37PGz9PLk9VxO2QJVRWygC89a+QudXjfq9SIPWYGGQ=;
 b=HfAT3iIVJPnj+eZ0ppsy2OEdfNteWyxe/HvB0FxHpMjooq8VEDspkZmwDVnL5hN5Tf
 H6rtGcoCkkyb/fv1xXRkjB7tXZp8FNb+2Qy11OHDowtn9cgpF43Gz3M5heI8zPqgf8uW
 HR0dLNv/J5yfd2v6Ne2GPOsKckwL2DcMKTerPBX8RiIwZSQ6AWANOgDNSyG/l1IUgIop
 bZ+n+pIzGhybgdpF74DXEJWtu6za2AaKiiOQuwZzN07tB5r2aZO508HCD4BaPuJvFVPF
 EcoGMSJCr04sEurmm3nSpglns8pvglo/1IDXSW5KL8iXkytIXDobTnAsiPRs3LXxJUIa
 41/g==
X-Gm-Message-State: ABy/qLa4s8EUDw2FZMMagrsfkSMURTA1uC3IlwC0n5gyBNZUd8RTPXZc
 wwj9oPXhqGn9yHAFAlNIsAE/Cg==
X-Google-Smtp-Source: APBJJlFriPDnbg4OHRBgFByBG+tx/yyykfed+4ESd1QavvUP4cO4tgHfwe/QPLyYBasIKW8JSAhOqg==
X-Received: by 2002:a5d:460b:0:b0:317:5c36:913b with SMTP id
 t11-20020a5d460b000000b003175c36913bmr903053wrq.48.1690130224808; 
 Sun, 23 Jul 2023 09:37:04 -0700 (PDT)
Received: from [172.20.2.0] (179.181-106-213.static.virginmediabusiness.co.uk.
 [213.106.181.179]) by smtp.gmail.com with ESMTPSA id
 e18-20020a5d65d2000000b00314172ba213sm10071864wrw.108.2023.07.23.09.37.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 09:37:04 -0700 (PDT)
Message-ID: <134760e1-8cf0-fc6d-67c8-966966d77f00@linaro.org>
Date: Sun, 23 Jul 2023 17:37:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 06/14] tcg/{i386,s390x}: Add earlyclobber to the
 op_add2's first output
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand
 <david@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230719221310.1968845-1-iii@linux.ibm.com>
 <20230719221310.1968845-7-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230719221310.1968845-7-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 7/19/23 23:11, Ilya Leoshkevich wrote:
> i386 and s390x implementations of op_add2 require an earlyclobber,
> which is currently missing. This breaks VCKSM in s390x guests. E.g., on
> x86_64 the following op:
> 
>      add2_i32 tmp2,tmp3,tmp2,tmp3,tmp3,tmp2   dead: 0 2 3 4 5  pref=none,0xffff
> 
> is translated to:
> 
>      addl     %ebx, %r12d
>      adcl     %r12d, %ebx
> 
> Introduce a new C_N1_O1_I4 constraint, and make sure that earlyclobber
> of aliased outputs is honored.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 82790a870992 ("tcg: Add markup for output requires new register")
> Signed-off-by: Ilya Leoshkevich<iii@linux.ibm.com>
> ---
>   tcg/i386/tcg-target-con-set.h  | 5 ++++-
>   tcg/i386/tcg-target.c.inc      | 2 +-
>   tcg/s390x/tcg-target-con-set.h | 8 +++++---
>   tcg/s390x/tcg-target.c.inc     | 4 ++--
>   tcg/tcg.c                      | 8 +++++++-
>   5 files changed, 19 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


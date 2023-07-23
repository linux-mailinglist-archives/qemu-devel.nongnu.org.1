Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABC175E412
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 19:40:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNd2x-000863-Dy; Sun, 23 Jul 2023 13:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNd2s-00085A-VW
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 13:39:03 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qNd2r-0002mz-8B
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 13:39:02 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fba8e2aa52so33754295e9.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 10:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690133939; x=1690738739;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P5kFkx/PlNQ11zizEsBYeaCwvcarm9zN5uffFSA8z2Y=;
 b=XSoVOdnide3ufZShWaSSMBHxaUlCFy4EQgRps9VN1qpWYtrFqU4o7WIUCbpTIwytjY
 a1lVJDq05l4DdhgHwy3UQJ0pTrIef1FzZAPfmi2rvD4BCQL8dec2nQdZoB1uOeP7NKdo
 a/MCDnKE0T418Mo+16JF7qbdXw8pI3D+0cP/XCZco7jcspAfgNmSrnw9A728/BjZAZvA
 EZMTBHit8qlz3xidnChXTcilazLLyI4st7PAPpy1O9HEqcqhDU0V0AqMULdLasESSND1
 bEPPkzZjNVzdVnDMQQKAfbD4HTCkHzkUp7ZwXRdyc/nmj4niMBMK5IX94yE5wDKK1a7P
 zBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690133939; x=1690738739;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P5kFkx/PlNQ11zizEsBYeaCwvcarm9zN5uffFSA8z2Y=;
 b=OQGhWWIdevJeFnajWAj3T6zlGTOY56T42WkDHMtMzWjW8RGoIxr6FtoZveNux0Kpi7
 t1WFXiRyevVtlGd5jXEzATLbMDs5bZ8IwxME2DCbivEl7LTZUAW+l30RzxJ8Avy9oEc9
 vP7rMvRaLjPQN0S3OUvkF6/YwDyjzLi246jjtDFYSLaqLlyXJPQt3Z8FWhgAxVBg/8Y4
 M79WHYb+VmHjKQFOfwdf5pXoLhfvtyJSPx0Sn5wiRpKNYR6H9+APpymUkkC9BndIp8lR
 cHbB/C5ewOs//1ZJE41u4C9UWMUQ0BSz5HCq1mDCvCi4TF9iqMwARlrg/v3YfEvrwmnu
 Ds4A==
X-Gm-Message-State: ABy/qLYiTJQsQyOLAZujfGC+HtXZjiDv/pvkp139PISC2oWF5nI9BazS
 04KpNebprcW8Bf8D23LqVSCPKg==
X-Google-Smtp-Source: APBJJlHOxR7mLDVAFNRub/hafz2yv7AOxoujFDoqFM2ljzMcMo5tBtPlU+2vI82zMKAKQ8owuJkFTQ==
X-Received: by 2002:a05:600c:b58:b0:3fb:b1fd:4183 with SMTP id
 k24-20020a05600c0b5800b003fbb1fd4183mr5867765wmr.12.1690133938795; 
 Sun, 23 Jul 2023 10:38:58 -0700 (PDT)
Received: from [172.20.2.0] (179.181-106-213.static.virginmediabusiness.co.uk.
 [213.106.181.179]) by smtp.gmail.com with ESMTPSA id
 t7-20020a5d6a47000000b00313f7b077fesm10255665wrw.59.2023.07.23.10.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jul 2023 10:38:58 -0700 (PDT)
Message-ID: <6285fd1f-da31-abda-296a-2f67363c5b78@linaro.org>
Date: Sun, 23 Jul 2023 18:38:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] Wrong signed data type on pageflags_* functions - limit
 to 2GB memory allocation
Content-Language: en-US
To: Luca Bonissi <qemu@bonslack.org>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Paolo Bonzini <pbonzini@redhat.com>
References: <4e1b1c75-8f00-83cc-86c3-0401c8bd0b2a@bonslack.org>
 <327460e2-0ebd-9edb-426b-1df80d16c32a@bonslack.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <327460e2-0ebd-9edb-426b-1df80d16c32a@bonslack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x333.google.com
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

On 7/18/23 15:50, Luca Bonissi wrote:
> On 32bit qemu-user targets, memory allocation failed after about 2GB due to incorrect 
> signed (instead of the correct unsigned) "last" parameter in pageflags_find and 
> pageflags_next functions (file accel/tcg/user-exec.c).
> 
> The parameter, on 32bit targets, will be signed-extent to the 64bit final uint64_t 
> parameters, leading to incorrect comparison on the RBTree (only the first call to mmap on 
> the upper 2GB memory will be successful).
> 
> Following the patch to fix the bug (re-submit to add "signed-off-by"):
> 
> Signed-off-by: Luca Bonissi <qemu@bonslack.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Don't reply to previous patches with a new patch -- tooling doesn't handle it.
I've applied this by hand.


r~


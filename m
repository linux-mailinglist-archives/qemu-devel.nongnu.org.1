Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E4B7081BD
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 14:49:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzd3m-0002X0-5m; Thu, 18 May 2023 08:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzd3k-0002Wm-5f
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:48:44 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzd3i-0007H6-GB
 for qemu-devel@nongnu.org; Thu, 18 May 2023 08:48:43 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-64d2467d63fso275555b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 05:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684414121; x=1687006121;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TxAAOV5Mxi6zSuMZ2qBm6iAvV20ZFGIykV2bQK/9fPk=;
 b=D9vYy8ZIg0g++fkSos8UNd037q+aAvE05Y9ciZmZ/iKFRBF9emAbXICDJ53TDejq8k
 jBG3w4dQeIV0GzrON0SvSqDyvJSbE4t4euhsC51SULREJIS1fy5ln1ogRrCHaogVq27n
 gKEZMW6MZ9IzH1FK1xFV2HzGY+qI7+wXIDmkOD8tBHP5mZ+PZjP8nWCeV5XFoVgl/y1L
 lh8bgAL5x2V5UNfxhKjvbj2yCNkh2PJ+ydQcBb+0jz2yVBkotvBZWREctE8LX3/4/hiH
 CdcbVa7W5ephOC2Rt3yhM7Q8Llx7oy9JVf2fDj0h57rijExK7yl4zV/qHcL5fB2yfJwu
 YC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684414121; x=1687006121;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TxAAOV5Mxi6zSuMZ2qBm6iAvV20ZFGIykV2bQK/9fPk=;
 b=Yj7YQ5Va4wOR0yYMlZLOWDL3Jsgq/DJzWuTPkxffEWgVvNFtOdllArsa4/7DgMESvM
 90DqYZnGofYesupeyJgjLwakY3GOUgAuihzfRwd6sHSiSrIWQvxyNk8orI9tQq5zyo7Q
 9DCV6bGWku/D8Fp7DDyBgVfyqYXM611x8zOk3o+/VTn4D+y9RNmZSJiSJHGCKUoUNQIy
 QgrIM6uJ2toLIGpv+49y5D4eFT/YU7PKR2F1UbCIl0dUgc7FqNfXOwrb/QSNbXh4dbQy
 A2aXwbwznt+uuaseEm34pYLg+jY8zJnhjKl27fWrA3yxdWG4QCuhJzGBwWrvnChPJpCn
 VmBQ==
X-Gm-Message-State: AC+VfDwSn5XqloPRsfvmbi/UBew5Jj6e2JgKrXbiVUYBMdgwGhTvm4tT
 CA4iyRPgwGoMMlS3uQl5oXYtXg==
X-Google-Smtp-Source: ACHHUZ40Ph2gRwm6ixVXHMp6G99DX69lDBzexCzteONXoS7LYvjM4slCRwybKI6HvmzlptSgB+PctQ==
X-Received: by 2002:a05:6a00:1381:b0:643:b653:3aa with SMTP id
 t1-20020a056a00138100b00643b65303aamr4962532pfg.32.1684414121162; 
 Thu, 18 May 2023 05:48:41 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:5dd2:c230:399b:cdc1?
 ([2602:ae:1598:4c01:5dd2:c230:399b:cdc1])
 by smtp.gmail.com with ESMTPSA id
 d9-20020aa78149000000b0063afb08afeesm1279093pfn.67.2023.05.18.05.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 05:48:40 -0700 (PDT)
Message-ID: <34ea78d0-d78c-afbc-5078-17524319b1d8@linaro.org>
Date: Thu, 18 May 2023 05:48:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/9] util/bufferiszero: Use i386 cpuinfo.h
Content-Language: en-US
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
References: <20230518044058.2777467-1-richard.henderson@linaro.org>
 <20230518044058.2777467-6-richard.henderson@linaro.org>
 <87r0redl60.fsf@secure.mitica>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87r0redl60.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
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

On 5/18/23 02:49, Juan Quintela wrote:
> Richard Henderson <richard.henderson@linaro.org> wrote:
>> Use cpuinfo_init() during init_accel(), and the variable cpuinfo
>> during test_buffer_is_zero_next_accel().  Adjust the logic that
>> cycles through the set of accelerators for testing.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Semi related to this.
> 
> For migration, I check every single page to see if it is full of zeros.
> But I can promisse that it is just a page (i.e. 4KiB, 16KiB or 64KiB,
> correct alignation, correct length, ...).
> 
> Will do it make sense to have an special function for that?
> 
> Yes, I have found with perf that bufferiszero() is quite high.  No, I
> haven't try to experiment using a function that is optimized for the
> page size in the architecture.
> 
> What do you think?

The optimized bufferiszero functions are already optimized for their blocklength (64, 128, 
256).  I don't think adding page multiples will do much more.


r~



Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4A774B775
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 21:49:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHrR2-0000A4-3D; Fri, 07 Jul 2023 15:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHrQz-00009d-3h
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 15:48:05 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHrQw-0002UE-Sh
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 15:48:04 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f95bf5c493so3510125e87.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 12:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688759279; x=1691351279;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ml2Mvgqa5mTAztRZY7LJCKxNs3hquZ2+1QWYHjyA5oY=;
 b=DwMLQOfDRgf8uAc5MQXrR8HAS+l7F9SJYJgrkNpVx2A0lXby2l37nU3hpzfX68hlOp
 e1ek3AqmZLiisdOE6oKeyXBADuJ4DpHKkFGCh1cZYWQvRnLxSnlUirAP7qqbrRCEazQD
 TVdUUCDkNd2A+JNqnDUsoFk6Ti4NUEtHzmicx5JJT98qQ7hHKW/IkK+2ecvbdzJ1WDXb
 MGi0uBEf89j2A4iQ5n+icrDuGy2x/q45yPFN04dtWphjgQOMhAIewNdBv8HKtknNG3dH
 mFnE6oCIprkAL2lbVaIcstdyYkt9aCwQKJGlBviKGiaJnCjOV/Su/qncvCYiUjf3gdRC
 kArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688759279; x=1691351279;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ml2Mvgqa5mTAztRZY7LJCKxNs3hquZ2+1QWYHjyA5oY=;
 b=ZB0WPJwR0OZHbE8VNXQbqU0/3FANhF/Ddda7+WXilEzzsvSnoAC41LRa3uvya+5nHq
 p2X8xQa+WSJedsLbu+VRAb/364h0m7OaSRXEyAyEEduW4kAdvAPo9jxxTrymkB+wU6m5
 zJzrH7axiwVS9ubkDQht+0ISTNcGw3NJD5XvIxcgqTefuxCIGuYmUFL2DY5T15VN9kk9
 csmAKaEdm/GIDQAeYVoSuEUYKDn8AgYw9XIxTPdVkGjf3FDiPTdBDJ1EB52XOW3SKW+8
 JoRhM41A63i2gxjEfuUBi3+NBxhP8dY2YBUJIcHgjeJffFqIQUKCueFGRYjAIHHC88Fs
 hFiw==
X-Gm-Message-State: ABy/qLZNuprDHvxUIdUkjSNDBF44zZQoPdMVJq7p6YmO+WIyZGSOU0vW
 Ydwx1oowKh261pKQ/pDQ2M7P/A==
X-Google-Smtp-Source: APBJJlFMFsThYryTaFuMYlSSW4RUVo7TcH+bFbnCkleZKefmPnDQ1/W0HYzelxO9ONaCU/7YKJKUBw==
X-Received: by 2002:a19:6504:0:b0:4fb:8b78:4a93 with SMTP id
 z4-20020a196504000000b004fb8b784a93mr1154385lfb.7.1688759279306; 
 Fri, 07 Jul 2023 12:47:59 -0700 (PDT)
Received: from [192.168.1.5] (host-92-23-208-66.as13285.net. [92.23.208.66])
 by smtp.gmail.com with ESMTPSA id
 k8-20020a5d5248000000b00313f9a0c521sm5202723wrc.107.2023.07.07.12.47.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 12:47:58 -0700 (PDT)
Message-ID: <1147c41d-3bcc-eadf-f625-819caa349e97@linaro.org>
Date: Fri, 7 Jul 2023 20:47:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/4] linux-user: Fix mmap2() syscall on 32-bit targets to
 allow file mapping beyond 4GB
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
References: <20230707131928.89500-1-deller@gmx.de>
 <20230707131928.89500-4-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230707131928.89500-4-deller@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 7/7/23 14:19, Helge Deller wrote:
> The mmap2() syscall allows 32-bit guests to specify the offset into a
> file in page units (instead of bytes, as done by mmap(2)).
> On physical machines this allows 32-bit applications to map such parts
> of large files which are stored beyond the 4GB limit.
> 
> Allow the same behaviour when emulating 32-bit guests with qemu.
> 
> For that switch the mmap2() function to always take an abi_ullong
> (64-bit) offset parameter for target_mmap() and mmap_frag() to avoid an
> arithmetical overflow when shifing a 32-bit offset parameter by
> 12 bits (=PAGE_SHIFT) and thus possibly overflow the abi_ulong (32-bit)
> type.
> 
> Signed-off-by: Helge Deller<deller@gmx.de>
> ---
>   linux-user/mmap.c      | 9 +++++----
>   linux-user/syscall.c   | 2 +-
>   linux-user/user-mmap.h | 2 +-
>   3 files changed, 7 insertions(+), 6 deletions(-)

https://patchew.org/QEMU/20230630132159.376995-1-richard.henderson@linaro.org/20230630132159.376995-12-richard.henderson@linaro.org/

Wherein I use the host off_t (which must be 64-bits).
(I'm pretty sure there's an older similar patch, but I couldn't find it.)


r~


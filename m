Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 428A3781E58
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 16:42:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXjd2-0004o2-KI; Sun, 20 Aug 2023 10:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjd0-0004ns-9x
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:42:06 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjcy-0001NH-5a
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:42:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68a40d85593so89522b3a.2
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 07:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692542522; x=1693147322;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4JN1wqWILJOz/L5FUeRhtHJreGeZ0jcC25x/eT0TgTs=;
 b=RXpKwjEw+MqVe5KmOo02Gs8y/pvq+sGaCA7SL0WcylmYksxEyCoQFUL+irrUpvXtTh
 Lm+34sUHJk146hPOseV2x36jH+74i1huFGG0rVmoYG5B5f+BzCmDodqTTf0zsemU5LmL
 Ay2fH6GNzSkjyZZ7SDLVXyYKe6uh01Nyy3dPzB3CKgTJlPoBHOjFP84osfgEkIZKqnv/
 5M8vfd+Ar8zLNj4x4nzLu9o59oKXXZKYTdo3cq4vtoIfUK72dtdBZIZkijRwu2jR401G
 5Z1xM8H/sTra8mTuU80pt9RriiSn6DMhvzAphxKEdmWgLtAO9oZCg4Bh0Oingx1zDsQz
 PSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692542522; x=1693147322;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4JN1wqWILJOz/L5FUeRhtHJreGeZ0jcC25x/eT0TgTs=;
 b=HBFx+KMP/104kCEh7z1srn91jygQ5crMfRGqVAriRCsj+sV3DIMspTp5BGotfA8urj
 OjXAH3ykvFtvNtwWCRkXeAZ5w3JPKSDpQdC04DTkLfqh4/Mqcxw1P6+l+irw5SuqGAWv
 mfyTKWUQn2HDf6Akq6XTGRe8t+x62spyyh3ZxNv9QQ1QKyPT7C4B+dC0r6aLJJYsp+o8
 c8WlPbhaUqm6d5radNr6euB1drVieVzMAAPZU4y9ccRV3F+hRQZ5Wkv90vWNaDh92kAm
 SxhEJx93iKmaqAoYCjvkyMH3XntsT7t9Q61rTKlZI90V4laGqwHAL55miWdcSdJo1KxM
 K4Cw==
X-Gm-Message-State: AOJu0YxXUKq9JkyE38TLrRoNrZLUnvXfzUWdmP3vdOsmsrrcLp4w/FSe
 1fQyYUGUP6Z/rfAWwCR+yuxWmQ==
X-Google-Smtp-Source: AGHT+IG1/52gVBbnOUl4gn/MdCq896MP+tBrM0u9W5mLXcWzrw34Tq5lX2DAR8F0VJFM2+ZseJ1YKw==
X-Received: by 2002:a05:6a20:914d:b0:13e:23bc:f4cc with SMTP id
 x13-20020a056a20914d00b0013e23bcf4ccmr3194883pzc.37.1692542522639; 
 Sun, 20 Aug 2023 07:42:02 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 jj10-20020a170903048a00b001bf574dd1fesm3094115plb.141.2023.08.20.07.42.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 07:42:02 -0700 (PDT)
Message-ID: <fb8dc083-96e1-1a18-fc89-63c305b56640@linaro.org>
Date: Sun, 20 Aug 2023 07:42:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 15/22] Implement mlock(2), munlock(2), mlockall(2),
 munlockall(2), madvise(2), minherit(2)
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>, Karim Taha <kariem.taha2.7@gmail.com>
Cc: qemu-devel@nongnu.org, Stacey Son <sson@freebsd.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-16-kariem.taha2.7@gmail.com>
 <CANCZdfoTq3oYL007soQTn-4XhtxchqBkWecUk6QiEOcTNMvoFA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CANCZdfoTq3oYL007soQTn-4XhtxchqBkWecUk6QiEOcTNMvoFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 8/19/23 21:37, Warner Losh wrote:
>     +/* madvise(2) */
>     +static inline abi_long do_bsd_madvise(abi_long arg1, abi_long arg2,
>     +        abi_long arg3)
>     +{
>     +    /*
>     +     * A straight passthrough may not be safe because qemu sometimes
>     +     * turns private file-backed mapping into anonymous mappings. This
>     +     * will break MADV_DONTNEED.  This is a hint, so ignoring and returing
>     +     * success is ok.
>     +     */
>     +    return get_errno(0);
> 
> 
> This looks like it was copied from an early linux-user implementation, and
> that seems to have been fixed to no longer cause problems. Can someone
> that knows about the linux-user history here comment?

We now track pages that are "passthrough" and ok for DONTNEED etc.


     case MADV_DONTNEED:
         if (page_check_range(start, len, PAGE_PASSTHROUGH)) {
             ret = get_errno(madvise(g2h_untagged(start), len, advice));
             if ((advice == MADV_DONTNEED) && (ret == 0)) {
                 page_reset_target_data(start, start + len - 1);
             }
         }


It's still not ideal, but it's something.


r~


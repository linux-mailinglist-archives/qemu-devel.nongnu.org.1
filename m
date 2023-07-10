Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F81574D180
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 11:32:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qInFH-0007Jd-Ar; Mon, 10 Jul 2023 05:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qInF0-0006y4-Me
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:31:39 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qInEu-0006Vj-63
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 05:31:31 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3fc0aecf15bso16102915e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 02:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688981486; x=1691573486;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tDJApv6RTCTLmFhn573qKIg6LdBGc4LF8GT917YWUVU=;
 b=jTh06m4gNNF7EU5jIzLum6bNcXBOilVNYZCKfXfUnc8ZcMB7QzYW6+rfSpPGufocaY
 VicOJZe6vJJ7ZPoM7HvGk07a04pxjqS7g57iZslmOLtXiVXn06lz9qH+UKmwZjBtod0/
 93UQoxgPlRoaDQYtOq5WuRGL5VOvJVSOb2AriiT4gXOTwA9D0VYWYOdplLXrc2FHBf25
 eGAnd8ZtmEwJzbyX72gnjKuxUumxQ3JsNgPNt9Zw3WAMbYHLLF9gf+X1Ksb9ZNc6TNPs
 KuDWAbZZtM/V6Ccbj134BAN7RPfxy2zM297AZ2pXNNf8+f8wZVTg6gHJMusxv2OpLi4U
 Rdkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688981486; x=1691573486;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tDJApv6RTCTLmFhn573qKIg6LdBGc4LF8GT917YWUVU=;
 b=CpLWIUdAmQojR4PW2MFHCxdcsKN0UA9GvcV28SRvrVg3j6cg+1NO5Q4d3jk3X5gAtf
 J1lqgf6HF73hQGiVlFkjKaFvZdd0s/AH1aeza6fvpNG+9+nORZi1ekXOCf95H36KalB9
 e8aRP4VfFnLd1jkdrI34RD3Jab/dNcs2fvPyWl/OM4wJQhsXjnRXycnl355eRBjH6Ngh
 9iLgN1aSytGdGKjK7WWj7Jb0O47dizRIwaIH2Km6pfWDiY7Ck6mX6DiCcuqzfwEaQ8Pj
 GdP66Pdku3GQ/KkI+FW0PUjMB8b5E9E6eaFMNUW3NNsHjqi2AS381GffT9KNDbk93L8B
 K42g==
X-Gm-Message-State: ABy/qLYx4eS8AevFqerwp/BZ2yu/v7nBmPy0ONujoZJyGiSyM+lHzeW1
 ZTNyNvglojxvuRBpFLJXuk7/2g==
X-Google-Smtp-Source: APBJJlFqAOr9ykzw/lgbVqJh8WHQE/1wPZts7yqNPMxb1KW5MpgeUNXZGwKyP1I3yeppbJnuuF4pzQ==
X-Received: by 2002:a05:600c:2202:b0:3fb:b67b:7f15 with SMTP id
 z2-20020a05600c220200b003fbb67b7f15mr12192997wml.21.1688981486083; 
 Mon, 10 Jul 2023 02:31:26 -0700 (PDT)
Received: from [192.168.8.133] ([148.252.133.210])
 by smtp.gmail.com with ESMTPSA id
 i6-20020a5d6306000000b00313de682eb3sm11201665wru.65.2023.07.10.02.31.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 02:31:25 -0700 (PDT)
Message-ID: <c179c192-ccd7-b217-be90-841eb735db62@linaro.org>
Date: Mon, 10 Jul 2023 10:31:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: TCG broken on s390x hosts (was: [PULL 11/27] tcg/s390x: Support
 128-bit load/store)
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-s390x <qemu-s390x@nongnu.org>
References: <20230530185949.410208-1-richard.henderson@linaro.org>
 <20230530185949.410208-12-richard.henderson@linaro.org>
 <f783a557-9d30-bdf4-e13f-b3edd405a012@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f783a557-9d30-bdf4-e13f-b3edd405a012@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 7/10/23 09:58, Thomas Huth wrote:
> On 30/05/2023 20.59, Richard Henderson wrote:
>> Use LPQ/STPQ when 16-byte atomicity is required.
>> Note that these instructions require 16-byte alignment.
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/s390x/tcg-target-con-set.h |   2 +
>>   tcg/s390x/tcg-target.h         |   2 +-
>>   tcg/s390x/tcg-target.c.inc     | 107 ++++++++++++++++++++++++++++++++-
>>   3 files changed, 107 insertions(+), 4 deletions(-)
> 
>   Hi Richard!
> 
> I think this patch broke something on s390x hosts. I currently
> cannot run the BootLinuxS390X.test_s390_ccw_virtio_tcg avocado
> test on a s390x host - it times out:
> 
>   make check-venv
>   ./tests/venv/bin/avocado run -t arch:s390x \
>    tests/avocado/boot_linux.py:BootLinuxS390X.test_s390_ccw_virtio_tcg
> 
> ... gets INTERRUPTED after the timeout expired.
> 
> It used to work fine in the past, so I bisected the problem
> and it seems like 4caad79f8d60a5df20ceed1c396724af745c9512
> is the first bad commit. If I revert it on top of the master
> branch, the test works fine again. Could you please have
> a look?
> 

I have a patch already:

https://patchew.org/QEMU/20230707102955.5607-1-richard.henderson@linaro.org/


r~



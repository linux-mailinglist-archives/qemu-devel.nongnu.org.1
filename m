Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2941A713BF3
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 20:56:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3LZI-00044J-4W; Sun, 28 May 2023 14:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3LZF-00043m-3a
 for qemu-devel@nongnu.org; Sun, 28 May 2023 14:56:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3LZD-0001E3-Ib
 for qemu-devel@nongnu.org; Sun, 28 May 2023 14:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685300195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cBJqDwNfppXjYR0E+8dQWI0kLdk8eGCvp8c89kwSF+o=;
 b=bjIOze7yUsVH2r2v/T4ze7/wlBU86qMT/s//rwSNK4WOQtv5MVFsZPkGkGEAz78CEoDxH3
 nCqtxF5GTQkDESWmqUq5t0NbAEAhMUCfrnSekq8+o32+mlPrQyQ6LOEGw3LdDU2c4jB2/D
 dLjjJiaXwrqS0InEqe+ArbivxoqkRyo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-P_06sFqBPGmQ3UyLnXOB-w-1; Sun, 28 May 2023 14:56:32 -0400
X-MC-Unique: P_06sFqBPGmQ3UyLnXOB-w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f603b8eb61so15479455e9.0
 for <qemu-devel@nongnu.org>; Sun, 28 May 2023 11:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685300192; x=1687892192;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cBJqDwNfppXjYR0E+8dQWI0kLdk8eGCvp8c89kwSF+o=;
 b=Qt6iHNI8+Wye8YOXzzDA3Z6BJ9sijaWnJIQL0p2FVKm0Dw/QJ1MG2t586IhZyhCi6E
 ZEHWSRr5d/juxW5SnRHDBb7UhrlfwsHlxDo/Q81pRLKbWhcekC29B1vWSs2g15r6lDh3
 1sIi3T1aYWb3fj0BYLc4Td/fz2N8zo47zXwY8gW6t3B86RsEb4divVstdgjgRuFcuCqY
 VzYHeqP0FChNSb+rvoQdQ/eUBSPn2XKbAdduZopqf1ghDMu1y0xL5IBAgc5MFcP6UuFo
 mVNQV1ZKZP2CaoYFIxwiXjuIQ+7vlYBhX8mayJafPyQPAvoO0wX+mfQEY744FhE7Sy4Z
 EDBQ==
X-Gm-Message-State: AC+VfDxfHDUkSIebg/dEFAGI63AnVVlq5M/BsxTHF2rAzEi3JpsnX0UP
 Qx8ZcakGms/lFihWY8e8YIdXkMYDrlQso2n3YcqlepLWfmLhK/6GRfNU4gafMNBUkLfEEciFNaO
 risSu2NXCcXaWg+4=
X-Received: by 2002:a7b:cd14:0:b0:3f5:fc88:dcb9 with SMTP id
 f20-20020a7bcd14000000b003f5fc88dcb9mr8920081wmj.19.1685300191827; 
 Sun, 28 May 2023 11:56:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6vNom2xlWyzJBAHeDxTZVSrgWp5KxKBG2Q/R0QcnwWcpw4iBvi0ZZ9QW+j1k2AoOLoX8r35Q==
X-Received: by 2002:a7b:cd14:0:b0:3f5:fc88:dcb9 with SMTP id
 f20-20020a7bcd14000000b003f5fc88dcb9mr8920074wmj.19.1685300191623; 
 Sun, 28 May 2023 11:56:31 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451?
 (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de.
 [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
 by smtp.gmail.com with ESMTPSA id
 u18-20020adfed52000000b003079986fd71sm11480557wro.88.2023.05.28.11.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 May 2023 11:56:31 -0700 (PDT)
Message-ID: <3de62daa-1745-d409-beee-c60b4b5c6662@redhat.com>
Date: Sun, 28 May 2023 20:56:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 4/4] tests/tcg/s390x: Test LOCFHR
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230526181240.1425579-1-iii@linux.ibm.com>
 <20230526181240.1425579-5-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230526181240.1425579-5-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.164,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On 26.05.23 20:12, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.target |  1 +
>   tests/tcg/s390x/locfhr.c        | 29 +++++++++++++++++++++++++++++
>   2 files changed, 30 insertions(+)
>   create mode 100644 tests/tcg/s390x/locfhr.c
> 
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
> index c48de439625..3c239fdd082 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -48,6 +48,7 @@ TESTS += $(PGM_SPECIFICATION_TESTS)
>   
>   Z13_TESTS=vistr
>   Z13_TESTS+=lcbb
> +Z13_TESTS+=locfhr
>   $(Z13_TESTS): CFLAGS+=-march=z13 -O2
>   TESTS+=$(Z13_TESTS)
>   
> diff --git a/tests/tcg/s390x/locfhr.c b/tests/tcg/s390x/locfhr.c
> new file mode 100644
> index 00000000000..ab9ff6e4490
> --- /dev/null
> +++ b/tests/tcg/s390x/locfhr.c
> @@ -0,0 +1,29 @@
> +/*
> + * Test the LOCFHR instruction.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <assert.h>
> +#include <stdlib.h>
> +
> +static inline __attribute__((__always_inline__)) long
> +locfhr(long r1, long r2, int m3, int cc)
> +{
> +    cc <<= 28;
> +    asm("spm %[cc]\n"
> +        "locfhr %[r1],%[r2],%[m3]\n"
> +        : [r1] "+r" (r1)
> +        : [cc] "r" (cc), [r2] "r" (r2), [m3] "i" (m3)
> +        : "cc");
> +    return r1;
> +}
> +
> +int main(void)
> +{
> +    assert(locfhr(0x1111111122222222, 0x3333333344444444, 8, 0) ==
> +           0x3333333322222222);
> +    assert(locfhr(0x5555555566666666, 0x7777777788888888, 11, 1) ==
> +           0x5555555566666666);
> +
> +    return EXIT_SUCCESS;
> +}

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb



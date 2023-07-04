Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F17B2746B40
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:56:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGasx-0001mT-9S; Tue, 04 Jul 2023 03:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGaso-0001lt-6s
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGasm-0006bc-MY
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:55:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688457331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WKKm8tNNa7V5MHFdD5nQsJ0SaqJGd5gSb/XPV3Plvu4=;
 b=Ads9V51SakD6YGvtuCPQC5cir/DX7rXFf5C+PTJt85OBDL/ERuyK5opR9BOeMHnW1SIJ9h
 XmrqkfNEHx+tH5A/mUwxpuqLgZbt8juHYWwkvWkvHdU7+RiJaTPg/pvW1VZf6/FbYH8+H0
 KiiB1Q/FOwduOtmfQWsb+oeXzGjs5i0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-ROq5OCW_OZqva4kemOi5XA-1; Tue, 04 Jul 2023 03:55:30 -0400
X-MC-Unique: ROq5OCW_OZqva4kemOi5XA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fb8284465aso37204135e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 00:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688457329; x=1691049329;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WKKm8tNNa7V5MHFdD5nQsJ0SaqJGd5gSb/XPV3Plvu4=;
 b=PAq6r8+QwtcZBoRNF5OKpONjhm4nH5ucfS2WOXAAC0lseoGWTqxDp452kNsPGYorIQ
 KzCbnnPb6LRaECbx3AG/X+1T2ac3Ab1OJunq7t94d3QykI081O5YM+OYsKA5W3d+Cs88
 cSvDkaE5gLJ4Dckk4gb3sNnC91kSZOqdrY34batajTQRzDhOVXNjz2nyYisM8tZKxURI
 GobHM+VAdqgvSsgxqUJSc/15fLS1277gpcCWouiiJH3EMvOrwyY2P7Y6ToQZwJirdr3U
 OVcP+kmyGTsWgYBT/ZhqB8Zmail4b0APtfZIyVaF6juOGZ2LQmVNNyYrSXbB2YlwbmV5
 z61w==
X-Gm-Message-State: ABy/qLaxWDcogql0V27o6BsBbQT5WYqPU7Sjx7u6oHcDofvVBg9RaASi
 hgKd1E+kEHuk2rsnfSoDq8O8YbE5DkXEArsCLw6NL5FC0zGsbTfv+IRedMqSWPgBacoH0w+ifDr
 hrxXQ2wSZaxdx9ww=
X-Received: by 2002:adf:f589:0:b0:313:f3b5:87cc with SMTP id
 f9-20020adff589000000b00313f3b587ccmr11621404wro.43.1688457329344; 
 Tue, 04 Jul 2023 00:55:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGOP9j0WOWJhQnn/WvHH4/gUg3UXWXMjmB1HLIhCSRXsTYVtsU2xbFj6C+65JBlGyp74GwSDA==
X-Received: by 2002:adf:f589:0:b0:313:f3b5:87cc with SMTP id
 f9-20020adff589000000b00313f3b587ccmr11621390wro.43.1688457329039; 
 Tue, 04 Jul 2023 00:55:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2?
 (p200300d82f305a00b30de6bc74c3d6f2.dip0.t-ipconnect.de.
 [2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a5d5705000000b00313f9a0c521sm20083638wrv.107.2023.07.04.00.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 00:55:28 -0700 (PDT)
Message-ID: <11df86b9-3d47-82c7-06bc-27e51ee2efd1@redhat.com>
Date: Tue, 4 Jul 2023 09:55:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 08/12] tests/tcg/s390x: Test EPSW
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-9-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230703155801.179167-9-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 03.07.23 17:50, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.target |  1 +
>   tests/tcg/s390x/epsw.c          | 23 +++++++++++++++++++++++
>   2 files changed, 24 insertions(+)
>   create mode 100644 tests/tcg/s390x/epsw.c
> 
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
> index 85abfbb98c0..2ef22c88d95 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -36,6 +36,7 @@ TESTS+=rxsbg
>   TESTS+=ex-relative-long
>   TESTS+=ex-branch
>   TESTS+=mxdb
> +TESTS+=epsw
>   
>   cdsg: CFLAGS+=-pthread
>   cdsg: LDFLAGS+=-pthread
> diff --git a/tests/tcg/s390x/epsw.c b/tests/tcg/s390x/epsw.c
> new file mode 100644
> index 00000000000..affb1a5e3a1
> --- /dev/null
> +++ b/tests/tcg/s390x/epsw.c
> @@ -0,0 +1,23 @@
> +/*
> + * Test the EPSW instruction.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <assert.h>
> +#include <stdlib.h>
> +
> +int main(void)
> +{
> +    unsigned long r1 = 0x1234567887654321UL, r2 = 0x8765432112345678UL;
> +
> +    asm("cr %[r1],%[r2]\n"  /* cc = 1 */
> +        "epsw %[r1],%[r2]"
> +        : [r1] "+r" (r1), [r2] "+r" (r2) : : "cc");
> +
> +    /* Do not check the R and RI bits. */
> +    r1 &= ~0x40000008UL;
> +    assert(r1 == 0x1234567807051001UL);
> +    assert(r2 == 0x8765432180000000UL);
> +
> +    return EXIT_SUCCESS;
> +}

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



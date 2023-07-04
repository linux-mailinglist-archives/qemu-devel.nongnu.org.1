Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 549DA746B4B
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:57:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGauE-0002YK-4P; Tue, 04 Jul 2023 03:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGauC-0002Xp-24
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGauA-0006qN-Lp
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688457417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B9LyZ6LZh43imgXLmxMbc00p83fNfls9BX4nfYsS96M=;
 b=Soz0J4xHjn+tqmhrGRgJqRmzbvXNIwhhgHiwTCEUVl+A0mGkYzs/Kr03ZNcFm78m1TZ6OF
 cUk6dj6K42OD0SnbXvAX8C6OwSMi2m5bfGIxWLv1tai2UuJFSHrB+jfUr8LXE2RQGN2fy8
 ua9C+ZUBhPO25Gcd7JnHn0m5owi28Ds=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-228-V4c1yiHQOe6j3LwwLjv1Bg-1; Tue, 04 Jul 2023 03:56:56 -0400
X-MC-Unique: V4c1yiHQOe6j3LwwLjv1Bg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b6a0772b97so50983811fa.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 00:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688457415; x=1691049415;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B9LyZ6LZh43imgXLmxMbc00p83fNfls9BX4nfYsS96M=;
 b=JzChWZBHk5Ms+v0yG27TW7vEEHT8g4LENqbVaHXuFSLFDsElWb87XzxIlWZ30eC0uc
 zliTwwjosYrs2VJB+g8KjVvc4+JtIKoiO19qIehE9lYwlB2tHR3CB76fuZCldUFZz6EM
 P1ZAyO/NkzJUS46q3joC28G4Q5PG9nj8amhsF83ecstdXeXn9uaPfsU2SJs3Fve+y3np
 xZ/jknTuBCAwUoG2oXhgey870vmcfHkOv2szcAd+HeJzmNzy8p2G4Sse2VLTYtvpMrwg
 4b25F1INOwamuLDih/4zh5YS0wonSg7IEEGh7W+I7Y0nvPYpvXc8+MJDdplVp/wa8nlS
 XtvQ==
X-Gm-Message-State: ABy/qLaTDJ5pmJDjRrf0Z0oxYATioXgXrBi0aa+sJ8VA5Y3zydLz/fso
 KTcV6M0j0bO6xkmJISerEwq/wZv4amGrlzlw9W8v/x+q3z0pUBZyo9uyg08EVbEGAPhTWI32o6f
 G5W6tn0BNQuLV1dk=
X-Received: by 2002:a2e:9659:0:b0:2b6:c16a:db06 with SMTP id
 z25-20020a2e9659000000b002b6c16adb06mr8099693ljh.39.1688457415144; 
 Tue, 04 Jul 2023 00:56:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH8zFR/4gaQfQNMNfU3GW/xt57SmT22pq4//TIMGQXDjQdutQq5g3ReGBtHF684vD2uBukywA==
X-Received: by 2002:a2e:9659:0:b0:2b6:c16a:db06 with SMTP id
 z25-20020a2e9659000000b002b6c16adb06mr8099677ljh.39.1688457414779; 
 Tue, 04 Jul 2023 00:56:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2?
 (p200300d82f305a00b30de6bc74c3d6f2.dip0.t-ipconnect.de.
 [2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a1cf314000000b003f90b9b2c31sm32541878wmq.28.2023.07.04.00.56.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 00:56:54 -0700 (PDT)
Message-ID: <9b6a6d07-cba5-fb74-9ac2-97d0457a334c@redhat.com>
Date: Tue, 4 Jul 2023 09:56:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 09/12] tests/tcg/s390x: Test LARL with a large offset
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-10-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230703155801.179167-10-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 03.07.23 17:50, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.target |  1 +
>   tests/tcg/s390x/larl.c          | 17 +++++++++++++++++
>   2 files changed, 18 insertions(+)
>   create mode 100644 tests/tcg/s390x/larl.c
> 
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
> index 2ef22c88d95..dbf64c991e9 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -37,6 +37,7 @@ TESTS+=ex-relative-long
>   TESTS+=ex-branch
>   TESTS+=mxdb
>   TESTS+=epsw
> +TESTS+=larl
>   
>   cdsg: CFLAGS+=-pthread
>   cdsg: LDFLAGS+=-pthread
> diff --git a/tests/tcg/s390x/larl.c b/tests/tcg/s390x/larl.c
> new file mode 100644
> index 00000000000..b9ced99a023
> --- /dev/null
> +++ b/tests/tcg/s390x/larl.c
> @@ -0,0 +1,17 @@
> +/*
> + * Test the LARL instruction.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <stdlib.h>
> +
> +int main(void)
> +{
> +    long algfi = (long)main;
> +    long larl;
> +
> +    asm("algfi %[r],0xd0000000" : [r] "+r" (algfi) : : "cc");
> +    asm("larl %[r],main+0xd0000000" : [r] "=r" (larl));

Not sure if worth combining both statements.

> +
> +    return algfi == larl ? EXIT_SUCCESS : EXIT_FAILURE;
> +}

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



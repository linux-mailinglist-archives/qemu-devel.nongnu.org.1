Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC08182A939
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 09:38:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNqZA-00020l-Og; Thu, 11 Jan 2024 03:37:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNqZ8-0001zm-DX
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:37:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rNqZ6-0001Jh-79
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 03:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704962246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yCdu45MX4ChSDI03nGfhPynyvS0MgURWVZiI9dvYaYA=;
 b=Ei0cE4JIeWSokSDWbeVUyYQmmGmcpxL6uzInDp7/xHeLefirdbhCqVSc10O3XQuaGhu0ew
 w67SYbZfG2Ee2T7PfsDHR2qVS3ziytwakaroET8HH/s691cf5cKa74wb0ACQ29lA+yaEkE
 km764jVsLwoX1RgdqN04JdJvajSLx2g=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-JmXw9BBkPxmOi3ZWTsoQPQ-1; Thu, 11 Jan 2024 03:37:25 -0500
X-MC-Unique: JmXw9BBkPxmOi3ZWTsoQPQ-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-5f7942a16c3so69420207b3.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 00:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704962245; x=1705567045;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yCdu45MX4ChSDI03nGfhPynyvS0MgURWVZiI9dvYaYA=;
 b=rD1zFd6elHkWBoBUctWHBTLdXHwoxCTN0wfnhvGSHCf7MRyytFtAEymZhB/Y//GaSG
 X4dpNcpqU9LhwOUc9xpXrNiitAv8qG/QibNULVFLdyXbAcvMk2v7sAtVXy2gTQVisZsJ
 jGvs5yJMG09rQ/EXEScKXhSs2keKO4/EG2gbv/2K549Osspij/y75qzJhH246qHrdkMd
 PyNJ/3PCeczYe6FSHD4kvqjx7qqYFOiw7eblpK5nEzv/Vl051Iru5N3wLjFS38wLnbbP
 bpI55e28Ss8PRSV2T56CkDWWYgwLzqA9kUB1fv3r3jc10BloPUPdp/rX3OmuaqR3MqJ+
 or7A==
X-Gm-Message-State: AOJu0YwBhNBaYoEdEUOyWTafG4TACYMvN4ek7aG3q/LX6jqGVMYFlW6n
 B9mdGKNKqcRKypZ4bvLjuUJAQf5zDGSgwpsIApNuvVItIcXbvnE6xDpvAS+mEz/CXdBiIt0G8AZ
 v5USnTgUTL8oFY5om6XSpmRVvuKeDCIA=
X-Received: by 2002:a25:d310:0:b0:dbf:22ac:953e with SMTP id
 e16-20020a25d310000000b00dbf22ac953emr808458ybf.46.1704962245025; 
 Thu, 11 Jan 2024 00:37:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHzNr8pHJrO4qmmrPz70RsIbJ/BvBxZ9crpPro6xmizgOeJOgkLy3mvqyrVl76iYHCUPmhZA==
X-Received: by 2002:a25:d310:0:b0:dbf:22ac:953e with SMTP id
 e16-20020a25d310000000b00dbf22ac953emr808454ybf.46.1704962244722; 
 Thu, 11 Jan 2024 00:37:24 -0800 (PST)
Received: from [10.33.192.181] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 cg5-20020a05622a408500b00429ab4df47csm263849qtb.17.2024.01.11.00.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jan 2024 00:37:24 -0800 (PST)
Message-ID: <22d8218a-70ee-4ab6-a284-2fbaeceb7052@redhat.com>
Date: Thu, 11 Jan 2024 09:37:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tests/tcg/s390x: Test LOAD ADDRESS EXTENDED
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20240109232319.600102-1-iii@linux.ibm.com>
 <20240109232319.600102-3-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240109232319.600102-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 10/01/2024 00.22, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions. Userspace runs in primary
> mode, so LAE should always set the access register to 0.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.target |  1 +
>   tests/tcg/s390x/lae.c           | 25 +++++++++++++++++++++++++
>   2 files changed, 26 insertions(+)
>   create mode 100644 tests/tcg/s390x/lae.c
> 
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
> index 0e670f3f8b9..30994dcf9c2 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -44,6 +44,7 @@ TESTS+=clgebr
>   TESTS+=clc
>   TESTS+=laalg
>   TESTS+=add-logical-with-carry
> +TESTS+=lae
>   
>   cdsg: CFLAGS+=-pthread
>   cdsg: LDFLAGS+=-pthread
> diff --git a/tests/tcg/s390x/lae.c b/tests/tcg/s390x/lae.c
> new file mode 100644
> index 00000000000..661e95f9978
> --- /dev/null
> +++ b/tests/tcg/s390x/lae.c
> @@ -0,0 +1,25 @@
> +/*
> + * Test the LOAD ADDRESS EXTENDED instruction.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <assert.h>
> +#include <stdlib.h>
> +
> +int main(void)
> +{
> +    unsigned long long ar = -1, b2 = 100000, r, x2 = 500;
> +    int tmp;
> +
> +    asm("ear %[tmp],%[r]\n"
> +        "lae %[r],42(%[x2],%[b2])\n"
> +        "ear %[ar],%[r]\n"
> +        "sar %[r],%[tmp]"
> +        : [tmp] "=&r" (tmp), [r] "=&r" (r), [ar] "+r" (ar)
> +        : [b2] "r" (b2), [x2] "r" (x2)
> +        : "memory");
> +    assert(ar == 0xffffffff00000000ULL);
> +    assert(r == 100542);
> +
> +    return EXIT_SUCCESS;
> +}

I'm sorry, but it fails when building with Clang (version 17):

.../qemu/tests/tcg/s390x/lae.c:14:9: error: invalid operand for instruction
    14 |     asm("ear %[tmp],%[r]\n"
       |         ^
<inline asm>:1:10: note: instantiated into assembly here
     1 |         ear %r2,%r1
       |                 ^
.../qemu/tests/tcg/s390x/lae.c:16:10: error: invalid operand for instruction
    16 |         "ear %[ar],%[r]\n"
       |          ^
<inline asm>:3:9: note: instantiated into assembly here
     3 | ear %r0,%r1
       |         ^
.../qemu/tests/tcg/s390x/lae.c:17:10: error: invalid operand for instruction
    17 |         "sar %[r],%[tmp]"
       |          ^
<inline asm>:4:5: note: instantiated into assembly here
     4 | sar %r1,%r2
       |     ^
3 errors generated.

Any suggestions how to fix it best?

  Thomas



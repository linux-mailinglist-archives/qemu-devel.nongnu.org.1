Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4AE713BEE
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 20:56:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3LYH-00022Q-AM; Sun, 28 May 2023 14:55:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3LYF-00021d-D8
 for qemu-devel@nongnu.org; Sun, 28 May 2023 14:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q3LYC-000107-Sv
 for qemu-devel@nongnu.org; Sun, 28 May 2023 14:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685300132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+Q5B+oGf2jDkaxwQKVLqFe6ATY1EWa2OEv4bI7pXnM=;
 b=Ka646pD8dhn8/wn5OQJC7lOmiddiecWxv2EQYw5JY3hvjm79alUa7jStsV3KR9agBi5UDs
 vqRSLyGAZacKVx27glKxH07AF1jvVoPv8A2Qp4cjChf/3cuY2pveo2LWGoCZ9qonRf2ZS2
 mQjl7Yb7PJBKszq55KIbr26Z9ePpgSk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-NZApowaKNv-9dVNHtg9J8Q-1; Sun, 28 May 2023 14:55:30 -0400
X-MC-Unique: NZApowaKNv-9dVNHtg9J8Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so9186635e9.2
 for <qemu-devel@nongnu.org>; Sun, 28 May 2023 11:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685300129; x=1687892129;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p+Q5B+oGf2jDkaxwQKVLqFe6ATY1EWa2OEv4bI7pXnM=;
 b=IONj9hMfQpZv3+7ptCC59XpXlaltJMV4oJejaepUHS3D4LivNyu3/vtodkPHoRkJFi
 AV6i1bZX8MnMjnljpbbwG9qJSxMqrzdOgzyfQkKLOlEtxqLInLOxtGQlmnqQPRg03+dA
 EO1QpScATbaSesUSoqVmpCiStQHkJRcL0CHN6K9EMSYmstdQ3IxsOi2dJFVbP8X/7DQg
 g1gSYHxqymBLA3UgCGCSUIfKUf2vTOUpnwfYQWxMpVGss521bETBDAoZBf3WPXGKCMyA
 cKa+WG2SBqSImH/SbVlsMdhg11LxofExcKIUQYA/OGdNDXyUFz6G0NIk9JABE8CQZ0eH
 jSPg==
X-Gm-Message-State: AC+VfDxESgSe1VDvc859vs837CSSKDVrmtwn2qRbOHRMVCFGnRbf0jlb
 1JaS9kAv22VUhJ9AdFm/T23cUOS6U7Yo5ZznfdOSrAnnwvrxCSurNpKS95ZrVLvOIN5HrS06wc2
 Q0FM+vhZY1MJtJxM=
X-Received: by 2002:a7b:cbd6:0:b0:3f6:906:1194 with SMTP id
 n22-20020a7bcbd6000000b003f609061194mr7108671wmi.18.1685300129562; 
 Sun, 28 May 2023 11:55:29 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5JzYSDoKewDV1K+bEegUffMEQbc2WUIdhMWUWMQvYAeh56a4BKJmtcudvXQXO+iVdnkZ9MBQ==
X-Received: by 2002:a7b:cbd6:0:b0:3f6:906:1194 with SMTP id
 n22-20020a7bcbd6000000b003f609061194mr7108667wmi.18.1685300129355; 
 Sun, 28 May 2023 11:55:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451?
 (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de.
 [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
 by smtp.gmail.com with ESMTPSA id
 c2-20020adfed82000000b003078a3f3a24sm11493454wro.114.2023.05.28.11.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 May 2023 11:55:29 -0700 (PDT)
Message-ID: <729f5354-36a4-13bd-7472-de133600371c@redhat.com>
Date: Sun, 28 May 2023 20:55:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/4] tests/tcg/s390x: Test LCBB
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230526181240.1425579-1-iii@linux.ibm.com>
 <20230526181240.1425579-3-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230526181240.1425579-3-iii@linux.ibm.com>
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
> Add a test to prevent regressions.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.target |  1 +
>   tests/tcg/s390x/lcbb.c          | 51 +++++++++++++++++++++++++++++++++
>   2 files changed, 52 insertions(+)
>   create mode 100644 tests/tcg/s390x/lcbb.c
> 
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
> index 73f7cb828e3..c48de439625 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -47,6 +47,7 @@ $(PGM_SPECIFICATION_TESTS): LDFLAGS+=pgm-specification-user.o
>   TESTS += $(PGM_SPECIFICATION_TESTS)
>   
>   Z13_TESTS=vistr
> +Z13_TESTS+=lcbb
>   $(Z13_TESTS): CFLAGS+=-march=z13 -O2
>   TESTS+=$(Z13_TESTS)
>   
> diff --git a/tests/tcg/s390x/lcbb.c b/tests/tcg/s390x/lcbb.c
> new file mode 100644
> index 00000000000..8d368e0998d
> --- /dev/null
> +++ b/tests/tcg/s390x/lcbb.c
> @@ -0,0 +1,51 @@
> +/*
> + * Test the LCBB instruction.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <assert.h>
> +#include <stdlib.h>
> +
> +static inline __attribute__((__always_inline__)) void
> +lcbb(long *r1, void *dxb2, int m3, int *cc)
> +{
> +    asm("lcbb %[r1],%[dxb2],%[m3]\n"
> +        "ipm %[cc]"
> +        : [r1] "+r" (*r1), [cc] "=r" (*cc)
> +        : [dxb2] "R" (*(char *)dxb2), [m3] "i" (m3)
> +        : "cc");
> +    *cc = (*cc >> 28) & 3;
> +}
> +
> +static char buf[0x1000] __attribute__((aligned(0x1000)));
> +
> +static inline __attribute__((__always_inline__)) void
> +test_lcbb(void *p, int m3, int exp_r1, int exp_cc)
> +{
> +    long r1 = 0xfedcba9876543210;
> +    int cc;
> +
> +    lcbb(&r1, p, m3, &cc);
> +    assert(r1 == (0xfedcba9800000000 | exp_r1));
> +    assert(cc == exp_cc);
> +}
> +
> +int main(void)
> +{
> +    test_lcbb(&buf[0],    0, 16, 0);
> +    test_lcbb(&buf[63],   0,  1, 3);
> +    test_lcbb(&buf[0],    1, 16, 0);
> +    test_lcbb(&buf[127],  1,  1, 3);
> +    test_lcbb(&buf[0],    2, 16, 0);
> +    test_lcbb(&buf[255],  2,  1, 3);
> +    test_lcbb(&buf[0],    3, 16, 0);
> +    test_lcbb(&buf[511],  3,  1, 3);
> +    test_lcbb(&buf[0],    4, 16, 0);
> +    test_lcbb(&buf[1023], 4,  1, 3);
> +    test_lcbb(&buf[0],    5, 16, 0);
> +    test_lcbb(&buf[2047], 5,  1, 3);
> +    test_lcbb(&buf[0],    6, 16, 0);
> +    test_lcbb(&buf[4095], 6,  1, 3);
> +
> +    return EXIT_SUCCESS;
> +}

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb



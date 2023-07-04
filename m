Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C331F746B54
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 09:59:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGavl-0003IJ-RB; Tue, 04 Jul 2023 03:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGavj-0003I4-F2
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:58:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGavh-00079D-6V
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688457512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h94iyhFBtAUK/uibeEoljnXWEuQIIzjs7F4EFAcNHKY=;
 b=Ac1FGZPlyLe0RdOXrfjdVD9mMyB+Z1mcomuIgtkjdfBe9pUDodI1lzxKBnahOHB4blC3yt
 4msFY6BfeTU1u91rndf6apz4j8nf/nrtYH+qQW4tjXAbojWXCIDKP4XClZaDZgpmuL28TS
 4u8FgRQnOZh0m1LS6FE1B8/8fDhYrnU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-NOK96FD4P3-JvzlOolFLcA-1; Tue, 04 Jul 2023 03:58:31 -0400
X-MC-Unique: NOK96FD4P3-JvzlOolFLcA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3143b277985so801392f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 00:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688457510; x=1691049510;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h94iyhFBtAUK/uibeEoljnXWEuQIIzjs7F4EFAcNHKY=;
 b=kdag6+GNYeLG/76ZVuMdT/SwgNzzLirLj/LXCwM5H+uqkxoEDaGxi/efVAx+9fk/rg
 7t2bDnb3SGFeYX02EFOXBH7SKExkuNS+Pra/hemELtxbFPmu2T59wnDWow6OjJrj8EQ0
 mYjFXPprZ5MgV8Brv5rP9ReCtqK1Ay3NKIewoSW8w3wuNhmAPS+tuTL75cxI3ZKWfaRD
 gAc9rGk57bfGL2odSdqQyaTI7zIb3K0dYd3MD7NwwaGWrx+J3fo/QPnx/MwnRv4DGqfy
 8HWZByALjQsROMYc8VYQn4eJMg8TeqC6ZtqJEhAS+uhFXOSigJqgvTcLNXFUs8aV/9DF
 zh4g==
X-Gm-Message-State: ABy/qLb48pEW0uqiLlkEIMPjV5eI92LAZo20e/en/wmi016d1ztRCQDE
 4MDT9ytn64fnP3MDRwz/pHZzw/ES0AaBzCRl2b+491+Z1QEOcUsxvdncMlS71z5LY17GvkAQt4Y
 Lc45Ji012g6163k4=
X-Received: by 2002:adf:f8c2:0:b0:313:eec6:77a1 with SMTP id
 f2-20020adff8c2000000b00313eec677a1mr11126553wrq.71.1688457509872; 
 Tue, 04 Jul 2023 00:58:29 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFOyk5H2PgziejjBOGmSnXIBCJsnKvEtPkhdpy2M9/bDNoNtWoogXUjrV0M5jXulse82KN9sQ==
X-Received: by 2002:adf:f8c2:0:b0:313:eec6:77a1 with SMTP id
 f2-20020adff8c2000000b00313eec677a1mr11126541wrq.71.1688457509503; 
 Tue, 04 Jul 2023 00:58:29 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2?
 (p200300d82f305a00b30de6bc74c3d6f2.dip0.t-ipconnect.de.
 [2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2])
 by smtp.gmail.com with ESMTPSA id
 cs7-20020a056000088700b0030ada01ca78sm27622886wrb.10.2023.07.04.00.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 00:58:28 -0700 (PDT)
Message-ID: <06ce79b8-e8d9-a457-a4d9-413303f38d8e@redhat.com>
Date: Tue, 4 Jul 2023 09:58:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 11/12] tests/tcg/s390x: Test MDEB and MDEBR
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-12-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230703155801.179167-12-iii@linux.ibm.com>
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
>   tests/tcg/s390x/mdeb.c          | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
>   create mode 100644 tests/tcg/s390x/mdeb.c
> 
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
> index dbf64c991e9..19fbbc6e531 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -38,6 +38,7 @@ TESTS+=ex-branch
>   TESTS+=mxdb
>   TESTS+=epsw
>   TESTS+=larl
> +TESTS+=mdeb
>   
>   cdsg: CFLAGS+=-pthread
>   cdsg: LDFLAGS+=-pthread
> diff --git a/tests/tcg/s390x/mdeb.c b/tests/tcg/s390x/mdeb.c
> new file mode 100644
> index 00000000000..4897d28069f
> --- /dev/null
> +++ b/tests/tcg/s390x/mdeb.c
> @@ -0,0 +1,30 @@
> +/*
> + * Test the MDEB and MDEBR instructions.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <assert.h>
> +#include <stdlib.h>
> +
> +int main(void)
> +{
> +    union {
> +        float f[2];
> +        double d;
> +    } a;
> +    float b;
> +
> +    a.f[0] = 1.2345;
> +    a.f[1] = 999;
> +    b = 6.789;
> +    asm("mdeb %[a],%[b]" : [a] "+f" (a.d) : [b] "R" (b));
> +    assert(a.d > 8.38 && a.d < 8.39);
> +
> +    a.f[0] = 1.2345;
> +    a.f[1] = 999;
> +    b = 6.789;
> +    asm("mdebr %[a],%[b]" : [a] "+f" (a.d) : [b] "f" (b));
> +    assert(a.d > 8.38 && a.d < 8.39);
> +
> +    return EXIT_SUCCESS;
> +}

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



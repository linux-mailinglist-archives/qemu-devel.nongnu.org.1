Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 639A272024A
	for <lists+qemu-devel@lfdr.de>; Fri,  2 Jun 2023 14:41:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q545J-0002HG-9j; Fri, 02 Jun 2023 08:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q545H-0002Gd-EP
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:40:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1q545C-0001rz-Bx
 for qemu-devel@nongnu.org; Fri, 02 Jun 2023 08:40:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685709641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h8GMGA/cKoqZ3QEzhKd2o/gPhWotGjV7+lnwrD771Ec=;
 b=gUNYqnCpyVVA5fyXL9o1iRGYnBuemcwfyFEUC9LjJyAy/3j57Qb7/If3Ck+8c66XCASnPe
 G1BFgcmyaKS+dQ46l5i3GYmC09VE6BX7ErRtlZ04Vgtr39NmV7GBefU10IW0JZbUaiaJNZ
 n4RFwTD24KGqMSOP3olo3D0AHnAB5g8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-P66LGKdINeGl69yRzbn2dA-1; Fri, 02 Jun 2023 08:40:39 -0400
X-MC-Unique: P66LGKdINeGl69yRzbn2dA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30ae42628cfso1039335f8f.3
 for <qemu-devel@nongnu.org>; Fri, 02 Jun 2023 05:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685709638; x=1688301638;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h8GMGA/cKoqZ3QEzhKd2o/gPhWotGjV7+lnwrD771Ec=;
 b=GH1zqsgSgeDFK97t60WOx7HNN70id+xjxm3UCSLOtHuuBm344DOj9Q+UL/gdzvrmOX
 4gYj55yEqDMiKauwGg+rHC3GNYhVvdKTNs7gkwQCjW6DPa3qHc/4qp7D5/PQwQaydWqu
 aOI/WxKHhJR2CiHvVyDcEl76krutbMzMfgMsK4S9p67Y/VJBBka9DimPQQQkgX71hErH
 iPGuWbzkXii6eSkGP3z+Q8obtYSy709KdYN4a8IY6bhqYLAVpRmpgZjMxVieCY3qPK7t
 AKxP52NLD9aFccucATyxTOMWxq1lJSVYj5zPFfXY8+zCCDRXnVuT1/GUz55X0uuk0neK
 koKQ==
X-Gm-Message-State: AC+VfDxyuo+iQaLm/MX0eIa7uI/Q2ZRWtg3Z1G1RBrOLgo1T0e+Cb26q
 Lv9kBhCs/uuGiM65uf3a8u3GTg6mIXbwCj6YTGkZZnW4a/v9r2ZyWpKBo+KopBiNh0GqozlIGEf
 OAwnOBTQwgrkuBGk=
X-Received: by 2002:a5d:66cd:0:b0:309:433b:8414 with SMTP id
 k13-20020a5d66cd000000b00309433b8414mr3709525wrw.54.1685709638013; 
 Fri, 02 Jun 2023 05:40:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4S9RvTlNlpE7m1OceCluLz0VksLJdFbh/LVaSAs3wR64rGukgj4+WdV4vhSnUqknAYnNpiBQ==
X-Received: by 2002:a5d:66cd:0:b0:309:433b:8414 with SMTP id
 k13-20020a5d66cd000000b00309433b8414mr3709509wrw.54.1685709637757; 
 Fri, 02 Jun 2023 05:40:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451?
 (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de.
 [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
 by smtp.gmail.com with ESMTPSA id
 a14-20020adfface000000b0030add836194sm1583794wrs.65.2023.06.02.05.40.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Jun 2023 05:40:37 -0700 (PDT)
Message-ID: <769e04d8-930a-c5da-faf5-94f978a84d10@redhat.com>
Date: Fri, 2 Jun 2023 14:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] tests/tcg/s390x: Test MXDB and MXDBR
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20230601223027.795501-1-iii@linux.ibm.com>
 <20230601223027.795501-3-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230601223027.795501-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.171,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.095, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 02.06.23 00:30, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.target |  1 +
>   tests/tcg/s390x/mxdb.c          | 30 ++++++++++++++++++++++++++++++
>   2 files changed, 31 insertions(+)
>   create mode 100644 tests/tcg/s390x/mxdb.c
> 
> diff --git a/tests/tcg/s390x/Makefile.target b/tests/tcg/s390x/Makefile.target
> index 3c239fdd082..d33960caa0a 100644
> --- a/tests/tcg/s390x/Makefile.target
> +++ b/tests/tcg/s390x/Makefile.target
> @@ -35,6 +35,7 @@ TESTS+=chrl
>   TESTS+=rxsbg
>   TESTS+=ex-relative-long
>   TESTS+=ex-branch
> +TESTS+=mxdb
>   
>   cdsg: CFLAGS+=-pthread
>   cdsg: LDFLAGS+=-pthread
> diff --git a/tests/tcg/s390x/mxdb.c b/tests/tcg/s390x/mxdb.c
> new file mode 100644
> index 00000000000..ae922559d3d
> --- /dev/null
> +++ b/tests/tcg/s390x/mxdb.c
> @@ -0,0 +1,30 @@
> +/*
> + * Test the MXDB and MXDBR instructions.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include <assert.h>
> +#include <stdlib.h>
> +
> +int main(void)
> +{
> +    union {
> +        double d[2];
> +        long double ld;
> +    } a;
> +    double b;
> +
> +    a.d[0] = 1.2345;
> +    a.d[1] = 999;
> +    b = 6.789;
> +    asm("mxdb %[a],%[b]" : [a] "+f" (a.ld) : [b] "R" (b));
> +    assert(a.ld > 8.38 && a.ld < 8.39);
> +
> +    a.d[0] = 1.2345;
> +    a.d[1] = 999;
> +    b = 6.789;
> +    asm("mxdbr %[a],%[b]" : [a] "+f" (a.ld) : [b] "f" (b));
> +    assert(a.ld > 8.38 && a.ld < 8.39);
> +
> +    return EXIT_SUCCESS;
> +}

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb



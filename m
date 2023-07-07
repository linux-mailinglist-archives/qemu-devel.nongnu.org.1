Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F67F74AD32
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 10:37:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHgxp-00058K-Gd; Fri, 07 Jul 2023 04:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qHgxm-00054A-Of
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:37:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qHgxl-00051C-9W
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 04:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688719032;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8mC8dVPadZv8D/BBOECraazMFWChj6MbQm1u/qUDwEU=;
 b=WAXq0Kq2rqbdCKtbSrHf4pwsE1hcU1uH165npn1jsp2UuLzblzjoA2QRg0oHZ2VXQNX99N
 MTGCILBKn+ZvcHlMMlGWEnuACOY+NYrPyaw/TvBD4SEeBUgO8spe/nFDU2JBGEh7o5iotN
 Sb20aGWMUmZxXQM+KAjqBbEjbHY6Uds=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-oC40KHckP_er-qHqSGZJVg-1; Fri, 07 Jul 2023 04:37:11 -0400
X-MC-Unique: oC40KHckP_er-qHqSGZJVg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-403890d5509so19085941cf.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 01:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688719031; x=1691311031;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8mC8dVPadZv8D/BBOECraazMFWChj6MbQm1u/qUDwEU=;
 b=OsFiPzpGcL7SvSFbX/nM5aWPG7l9k9Kczws/ekvm8B5+WBRe62PiJbbS3mr1YA4ih/
 n52pIwv22aKaeuQBPX0Sp0xKAfydirCeBgRHm+5N3dWMTM5n6ZC1ZKiPx0GpHMbg13KQ
 sMkTFFjowOjiLTyPp6fkU21czUYtAW95UtWgZm/SAw39JaubvmL0Yg870m26pqspRuDr
 e44auaBYcH6wDXJkXd2Y9hkHCpJIrtr0iLXH+7jGW5Hn3SnGsK80pUMnl/3A7Q+f2be5
 /2XNfyAwIJWMl16vILCVJ7clryhFDa1RiAM7/eFULDMDjeoZyU1jr32Sa2khJsOphQgZ
 QEsQ==
X-Gm-Message-State: ABy/qLb8uJdad4HF+h2bsV/asMQmJPNbkXAvODS6x7hIhTt9znnuujUv
 u7DgjIf/xl0GCMoymtFSCMOtuYADBcBcQ8ZBbGEXqGwMBK0ZdUTutHxyzaWSIsPOLBWuwtW9AVB
 Mhn6kYoF+hamDBf0=
X-Received: by 2002:ac8:5bc1:0:b0:400:790c:c5db with SMTP id
 b1-20020ac85bc1000000b00400790cc5dbmr5472299qtb.30.1688719030657; 
 Fri, 07 Jul 2023 01:37:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGlfKmhAK5yxdFiGIc5Ica5N544LQ8Pp/IyFTHNdAnT7xqKpk7bfPB/SKczlEviCvMzzbihDg==
X-Received: by 2002:ac8:5bc1:0:b0:400:790c:c5db with SMTP id
 b1-20020ac85bc1000000b00400790cc5dbmr5472275qtb.30.1688719030328; 
 Fri, 07 Jul 2023 01:37:10 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-230.web.vodafone.de.
 [109.43.176.230]) by smtp.gmail.com with ESMTPSA id
 d29-20020ac8615d000000b003ff243b2509sm1537776qtm.71.2023.07.07.01.37.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 01:37:08 -0700 (PDT)
Message-ID: <3f97fd16-a960-f09c-1e51-a8014b4f7b1b@redhat.com>
Date: Fri, 7 Jul 2023 10:37:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] tests/tcg/s390x: Test single-stepping SVC
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Andreas Krebbel <krebbel@linux.ibm.com>
References: <20230510230213.330134-1-iii@linux.ibm.com>
 <20230510230213.330134-3-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230510230213.330134-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 11/05/2023 01.02, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
...
> diff --git a/tests/tcg/s390x/hello-s390x-asm.S b/tests/tcg/s390x/hello-s390x-asm.S
> new file mode 100644
> index 00000000000..2e9faa16047
> --- /dev/null
> +++ b/tests/tcg/s390x/hello-s390x-asm.S
> @@ -0,0 +1,20 @@
> +/*
> + * Hello, World! in assembly.
> + */
> +
> +.globl _start
> +_start:
> +
> +/* puts("Hello, World!"); */
> +lghi %r2,1
> +larl %r3,foo
> +lghi %r4,foo_end-foo

  Hi Ilya!

While testing your other currently pending s390x TCG patches, I noticed that 
this is failing with Clang (v16.0.1):

tests/tcg/s390x/hello-s390x-asm.S:11:10: error: invalid operand for instruction
lghi %r4,foo_end-foo
          ^
make[1]: *** [Makefile:121: hello-s390x-asm] Error 1

Any ideas how to fix this?

  Thomas



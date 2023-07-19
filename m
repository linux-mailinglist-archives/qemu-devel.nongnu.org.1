Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FC9759816
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Jul 2023 16:22:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qM83T-0003zH-FO; Wed, 19 Jul 2023 10:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM83E-0003ym-5K
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qM83C-0000Zv-PO
 for qemu-devel@nongnu.org; Wed, 19 Jul 2023 10:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689776470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wHt1edPcTQtbXdM1uw0pG1e3neVlYrxFCu1QemMaDxU=;
 b=LVMwD3bGCle0tVchtsnq5vNhdQVwTtnKxYv7gN2WwYnboevEh4I99uzt4QB5wFeBG9Rf6y
 CcRB0nR2BnKAE6O8C7GqXEDvinQrSS2AO81taAa/GDf/jOUc1691aLBvOZG65wqlOuZFqX
 MtYztNyMA+Su9tzG8gRpkwvO3VfM77E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-OZEQnKlrM1-QVaX0qiMmdw-1; Wed, 19 Jul 2023 10:21:05 -0400
X-MC-Unique: OZEQnKlrM1-QVaX0qiMmdw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso4002549f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jul 2023 07:21:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689776461; x=1692368461;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wHt1edPcTQtbXdM1uw0pG1e3neVlYrxFCu1QemMaDxU=;
 b=d3aUm1ASqeYrvctixld15Jvasdqj412gJd63OsdTZrbmebCyaxh8fKP1UYOZLyZxee
 7R/L2Qh4wSXq05gZ0ScAeKGB1/Hvb5kKD9I5DtuiqT3Dy8HgmdyIir2TMIhfjIHart+y
 J1cVIz1GvfHKnPHwcpRQ0sh1M/OH5s7wNHbfVW98kQI3XB1s2220uuwJqtXjOELVjdHk
 uRiYzzgoSX/7XUUxFBi2yBeOQedsq942Z100Py0rsT/lECBu65GxBYnsboohamKesQRV
 mTA1GCfP5os+hqvlzkW/bINDhFsd6AaG4BZa2NS0JXt7yON6VrsB0rxrhURPhUQmtwBE
 cuLw==
X-Gm-Message-State: ABy/qLakO8gIwpksjazpZilWNXs/VStLZMU12AUl6ugqW/V4tQa+Byws
 XDhKGDaWWeDL6k6hVYr3pXOEs3oot5NvS7Syb1aVlwnGer0gRoYBI4rF/27DtwUyMrNZyLxjVRc
 1Da4y/t7NZea9YFw=
X-Received: by 2002:a1c:4b10:0:b0:3fb:b248:67c with SMTP id
 y16-20020a1c4b10000000b003fbb248067cmr4831803wma.22.1689776461028; 
 Wed, 19 Jul 2023 07:21:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEErM2mdnAz3RWXMUZ6kIudnQ1ZsN28MQ+FMlBZ2gB8uEIlsVGMl2M3VyBHkkQlRYH45EDL9Q==
X-Received: by 2002:a1c:4b10:0:b0:3fb:b248:67c with SMTP id
 y16-20020a1c4b10000000b003fbb248067cmr4831788wma.22.1689776460738; 
 Wed, 19 Jul 2023 07:21:00 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-60.web.vodafone.de.
 [109.43.177.60]) by smtp.gmail.com with ESMTPSA id
 e16-20020adffc50000000b0031432c2fb95sm5477291wrs.88.2023.07.19.07.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jul 2023 07:21:00 -0700 (PDT)
Message-ID: <49180c28-17ec-7b99-0135-0b37515ffbab@redhat.com>
Date: Wed, 19 Jul 2023 16:20:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 08/14] tests/tcg/s390x: Test CKSM
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
References: <20230719094620.363206-1-iii@linux.ibm.com>
 <20230719094620.363206-9-iii@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230719094620.363206-9-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 19/07/2023 11.44, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.softmmu-target |  1 +
>   tests/tcg/s390x/cksm.S                  | 29 +++++++++++++++++++++++++
>   2 files changed, 30 insertions(+)
>   create mode 100644 tests/tcg/s390x/cksm.S
> 
> diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
> index 242c7b0f83c..e813e318db9 100644
> --- a/tests/tcg/s390x/Makefile.softmmu-target
> +++ b/tests/tcg/s390x/Makefile.softmmu-target
> @@ -16,6 +16,7 @@ LDFLAGS=-nostdlib -static
>   
>   ASM_TESTS =                                                                    \
>       bal                                                                        \
> +    cksm                                                                       \
>       exrl-ssm-early                                                             \
>       sam                                                                        \
>       lpsw                                                                       \
> diff --git a/tests/tcg/s390x/cksm.S b/tests/tcg/s390x/cksm.S
> new file mode 100644
> index 00000000000..a45f3ef6bfd
> --- /dev/null
> +++ b/tests/tcg/s390x/cksm.S
> @@ -0,0 +1,29 @@
> +    .org 0x8e
> +program_interruption_code:
> +    .org 0x1d0                         /* program new PSW */
> +    .quad 0,pgm
> +    .org 0x200                         /* lowcore padding */
> +    .globl _start
> +_start:
> +    lmg %r0,%r1,cksm_args
> +    cksm %r2,%r0
> +    c %r2,cksm_exp
> +    jne failure
> +    cksm %r2,%r15

Clang is smart enough to detect that this is a bad instruction:

$ make check-tcg
   BUILD   s390x-softmmu guest-tests
tests/tcg/s390x/cksm.S:12:14: error: invalid register pair
     cksm %r2,%r15
              ^

I guess you have to manually create the opcode here?

  Thomas



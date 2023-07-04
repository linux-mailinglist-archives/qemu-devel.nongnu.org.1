Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9688D746B5B
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:00:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGawh-0003yz-Og; Tue, 04 Jul 2023 03:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGawf-0003xx-5R
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:59:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qGawd-0007TS-M0
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 03:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688457571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVYLVPRVhSAlHwYKcOELPUeq2hC/b2leqtP3e4l3za8=;
 b=SPDARULnB40fHaItNJ3OEYGQdeC/xSdo9BAiKbyDlE5cQl97XoUiebSvHw6vDj4ylWwa3n
 UBNE0XhaJrPVWvC/m2MREbhbSUbbzxibPpkX7cgPgH71c026Pmlh4YVdleERNyHvi9tbz5
 qKdhIBpW0fp0jLVKc9kv8+jxiyKCOWk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-NebNTA8uM2y02iaFFk5D9Q-1; Tue, 04 Jul 2023 03:59:29 -0400
X-MC-Unique: NebNTA8uM2y02iaFFk5D9Q-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30793c16c78so5755428f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 00:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688457568; x=1691049568;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mVYLVPRVhSAlHwYKcOELPUeq2hC/b2leqtP3e4l3za8=;
 b=Lbf7pbuSK0LRpaGPRvDx+ATuO2t5jI+S/QLgGdTfhLxcM0Cr31Tvmo2a/mX44mMwW+
 rtqpOBLSUlRI2frP2kDNF/Bg6c91SPKMCm8CSyrm/PgP+13c2EkMty+2/eWFjiOKId4H
 MDTk1IJnnPtkItvlnP9lmcSGx1YV0jDGvVxPERogySL3OuTpQYEo1Cu3newuZzLfwHQI
 AMI5Y0UOdiay/HC6nsh3o2nBmLGBV85g6HbjsHMop5n484sRunQN2GLKDTEXXJ7qP9D7
 5MQ2IUROVGAcxGRLStFIFtlwvisaofpj8/27knuWSjUdcJQWI0mrhKJxKtL2LbqTihRS
 q+eA==
X-Gm-Message-State: ABy/qLYlEzHNHg+jED8NGV907SNwVc404GX2tjZogqOuQsIdCi7L9B4t
 ouD0ku9BZo2T5W3DF0NoZCdmqewJmY+gVJ3jyJUtrZdVXX+tCGhp9pNP7sky3B5O9i+x9C3VkrH
 El/YhE86mX6LpAEQ=
X-Received: by 2002:adf:facd:0:b0:311:110d:5573 with SMTP id
 a13-20020adffacd000000b00311110d5573mr13520608wrs.64.1688457568706; 
 Tue, 04 Jul 2023 00:59:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHPKmg1nbDQuMV8TYbC3/uea7wA8oEmlG8B5HLVXTMeOwAx8poIsP2maL9PDDLwBSh+dPeW2Q==
X-Received: by 2002:adf:facd:0:b0:311:110d:5573 with SMTP id
 a13-20020adffacd000000b00311110d5573mr13520594wrs.64.1688457568454; 
 Tue, 04 Jul 2023 00:59:28 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2?
 (p200300d82f305a00b30de6bc74c3d6f2.dip0.t-ipconnect.de.
 [2003:d8:2f30:5a00:b30d:e6bc:74c3:d6f2])
 by smtp.gmail.com with ESMTPSA id
 q18-20020adfcd92000000b003140f47224csm15174200wrj.15.2023.07.04.00.59.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 00:59:28 -0700 (PDT)
Message-ID: <db509312-e744-0b6a-343b-4ace778f6b98@redhat.com>
Date: Tue, 4 Jul 2023 09:59:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 12/12] tests/tcg/s390x: Test MVCRL with a large value in R0
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>, 
 Richard Henderson <richard.henderson@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20230703155801.179167-1-iii@linux.ibm.com>
 <20230703155801.179167-13-iii@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230703155801.179167-13-iii@linux.ibm.com>
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
>   tests/tcg/s390x/mie3-mvcrl.c | 46 ++++++++++++++++++++++++++++--------
>   1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/tcg/s390x/mie3-mvcrl.c b/tests/tcg/s390x/mie3-mvcrl.c
> index 93c7b0a2903..ec78dd1d493 100644
> --- a/tests/tcg/s390x/mie3-mvcrl.c
> +++ b/tests/tcg/s390x/mie3-mvcrl.c
> @@ -1,29 +1,55 @@
> +#include <stdbool.h>
>   #include <stdint.h>
> +#include <stdlib.h>
>   #include <string.h>
>   
> -
> -static inline void mvcrl_8(const char *dst, const char *src)
> +static void mvcrl(const char *dst, const char *src, size_t len)
>   {
> +    register long r0 asm("r0") = len;
> +
>       asm volatile (
> -        "llill %%r0, 8\n"
>           ".insn sse, 0xE50A00000000, 0(%[dst]), 0(%[src])"
> -        : : [dst] "d" (dst), [src] "d" (src)
> -        : "r0", "memory");
> +        : : [dst] "d" (dst), [src] "d" (src), "r" (r0)
> +        : "memory");
>   }
>   
> -
> -int main(int argc, char *argv[])
> +static bool test(void)
>   {
>       const char *alpha = "abcdefghijklmnop";
>   
>       /* array missing 'i' */
> -    char tstr[17] = "abcdefghjklmnop\0" ;
> +    char tstr[17] = "abcdefghjklmnop\0";
>   
>       /* mvcrl reference use: 'open a hole in an array' */
> -    mvcrl_8(tstr + 9, tstr + 8);
> +    mvcrl(tstr + 9, tstr + 8, 8);
>   
>       /* place missing 'i' */
>       tstr[8] = 'i';
>   
> -    return strncmp(alpha, tstr, 16ul);
> +    return strncmp(alpha, tstr, 16ul) == 0;
> +}
> +
> +static bool test_bad_r0(void)
> +{
> +    char src[256];
> +
> +    /*
> +     * PoP says: Bits 32-55 of general register 0 should contain zeros;
> +     * otherwise, the program may not operate compatibly in the future.
> +     *
> +     * Try it anyway in order to check whether this would crash QEMU itself.
> +     */
> +    mvcrl(src, src, (size_t)-1);
> +
> +    return true;
> +}
> +
> +int main(void)
> +{
> +    bool ok = true;
> +
> +    ok &= test();
> +    ok &= test_bad_r0();
> +
> +    return ok ? EXIT_SUCCESS : EXIT_FAILURE;
>   }

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb



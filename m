Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C79E974D710
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 15:09:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIqdi-0003t6-5l; Mon, 10 Jul 2023 09:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIqdf-0003sd-SS
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:09:15 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qIqdd-0005D2-TJ
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:09:15 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3128fcd58f3so4871229f8f.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 06:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688994551; x=1691586551;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TyumS76IKZIbJNpDquj6Cv5ZqIcVAHvU7xhSYVV5p0E=;
 b=xuWhHmdG8fmskFIeIKIKYi9IbSHx9InwPR5ej/ppIrnss/7oNm8ulBkeCJNJm2fA9v
 VNgTtGVuIxTsaLo7HdqzJutVjq+Bm2ijCVRWZwavz/HNNNT59FVUEPxObt99me+XapY9
 2ptm9JYV62JNTy5nD1W6bNdQOr+pD9FiH8CozWJkgo+KhtdEESvzZSc7weQ18MckqG1R
 lTRu+UVcRzKInQDBEFzKH9mRS895g4tUyAQdio17KZBjVaQUsnXo6EM9Li1sW/tu9Hgp
 3fUATV+F9bqz0XbC4effW4nxRDbzgjNPVLKPUb1ConimGSwImvmbI9WB77wmvcVsYueU
 hK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688994551; x=1691586551;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TyumS76IKZIbJNpDquj6Cv5ZqIcVAHvU7xhSYVV5p0E=;
 b=UEVDaeGsA3ufMlW6qHseIWwlR+EIEI1pqZSdgXsdvby62n0hyF0tt6d6eEI4E0Dw/i
 fD0aDkZVtCFCbzrr48WFQa7uTZtMDD/QcSq+GHVWZkrwS2uE+SbIQRRhmWR66MJbvFpD
 Dck94pP7NKOMRUGUh+Hxb4YRjZn9tAJIdD+WsI/bpHWHxD79pZO5/GxEQXemT82qOVbR
 AuU8cOIDL4Ybz71Jgrq9z8UXZ1gvCLcz/ig1xAee7MO2ZV57VHSYlI49QhTlVRFvXxB3
 7BHJTAjKaYB4m3v6urs75K+0+AzswTPu8Lt+6yx4fcij6YP6WB5JQhJwwIQyXmbArxed
 UULQ==
X-Gm-Message-State: ABy/qLZ4lHAIg0tqr1t3K4EkNveltdA1BHNvxRxpdzlH7qKl9Nwfavtn
 70XMagMhIRFiEBHIgqpRI05rEA==
X-Google-Smtp-Source: APBJJlEP4isuTgxBCE9IbfdEE5gnOA+NmvHjVqQjJ/1BoYdV9JP2onTxVS+qfd028TgAwOeDIQgoZw==
X-Received: by 2002:a5d:4608:0:b0:314:3c84:4da2 with SMTP id
 t8-20020a5d4608000000b003143c844da2mr12305132wrq.13.1688994550787; 
 Mon, 10 Jul 2023 06:09:10 -0700 (PDT)
Received: from [192.168.8.133] ([148.252.133.210])
 by smtp.gmail.com with ESMTPSA id
 v12-20020adfe4cc000000b003143cb109d5sm11570292wrm.14.2023.07.10.06.09.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 06:09:10 -0700 (PDT)
Message-ID: <f697c822-8036-d185-cf79-8f71e4dbdee0@linaro.org>
Date: Mon, 10 Jul 2023 14:09:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 13/21] tests/tcg/s390x: Test MVCRL with a large value in R0
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
References: <20230710121543.197250-1-thuth@redhat.com>
 <20230710121543.197250-14-thuth@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230710121543.197250-14-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/10/23 13:15, Thomas Huth wrote:
> From: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Message-Id: <20230704081506.276055-13-iii@linux.ibm.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/tcg/s390x/mie3-mvcrl.c | 46 ++++++++++++++++++++++++++++--------
>   1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/tcg/s390x/mie3-mvcrl.c b/tests/tcg/s390x/mie3-mvcrl.c
> index 93c7b0a290..ec78dd1d49 100644
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

gcc 11 doesn't like this:

https://gitlab.com/qemu-project/qemu/-/jobs/4623964826#L3921

/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/tests/tcg/s390x/mie3-mvcrl.c: In 
function ‘test_bad_r0’:
/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/tests/tcg/s390x/mie3-mvcrl.c:42:5: 
error: ‘src’ may be used uninitialized [-Werror=maybe-uninitialized]
    42 |     mvcrl(src, src, (size_t)-1);
       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/tests/tcg/s390x/mie3-mvcrl.c:6:13: 
note: by argument 1 of type ‘const char *’ to ‘mvcrl’ declared here
     6 | static void mvcrl(const char *dst, const char *src, size_t len)
       |             ^~~~~
/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/tests/tcg/s390x/mie3-mvcrl.c:34:10: 
note: ‘src’ declared here
    34 |     char src[256];
       |          ^~~
/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/tests/tcg/s390x/mie3-mvcrl.c:42:5: 
error: ‘src’ may be used uninitialized [-Werror=maybe-uninitialized]
    42 |     mvcrl(src, src, (size_t)-1);
       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/tests/tcg/s390x/mie3-mvcrl.c:6:13: 
note: by argument 2 of type ‘const char *’ to ‘mvcrl’ declared here
     6 | static void mvcrl(const char *dst, const char *src, size_t len)
       |             ^~~~~
/home/gitlab-runner/builds/E8PpwMky/0/qemu-project/qemu/tests/tcg/s390x/mie3-mvcrl.c:34:10: 
note: ‘src’ declared here
    34 |     char src[256];
       |          ^~~
cc1: all warnings being treated as errors

How it sees any use of the structure, initialized or otherwise, I don't know -- it's all 
hidden within the asm.  However, src[256] = { } is enough to silence the error.


r~


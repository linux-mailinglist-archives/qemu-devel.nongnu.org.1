Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C8374D732
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 15:15:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIqjv-0008Db-KD; Mon, 10 Jul 2023 09:15:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIqjk-00087f-NG
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:15:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIqji-0007Iy-Hc
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 09:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688994929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WNXTifBN84eDgMtS5syEa4mVAqi5lrLNd6ndxUSqLBc=;
 b=YHtjhNf6h9GqckVX/7m3s8Nnl70wJy4aDGPOZmmPn+lzn5vimAoIR5QUwz7dhx9FpEK12s
 QyMJJlC7tYnNcAe3kVR21e4vvDX4bzrKLJy3VCbXwPqPQdYtTOQQzlhy7y4YQT9A6r8Ijd
 6aJR/fOLWZ5+dNQCJhWBtUNrc7DsNIw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-dtpXKeBdOKC1eP-BmdeWEQ-1; Mon, 10 Jul 2023 09:15:27 -0400
X-MC-Unique: dtpXKeBdOKC1eP-BmdeWEQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-63788123d11so40493006d6.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 06:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688994926; x=1691586926;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WNXTifBN84eDgMtS5syEa4mVAqi5lrLNd6ndxUSqLBc=;
 b=BTfcKmLxXcZIVUaeuPDdXULoWUNNytnkWJKjODjd7zKv4RymJzuMUu+Fw0MHNWUIBy
 R6Zx0YjZ2HNF2IL9+xePhApC7g5UbP4UNVpayNI1nK3LHcTHytJLoFQ4lJ6h0HroQwDw
 Uikh7vR6TCuIe/Ckip4d5vLV7hOCrYWKy2KR5Ut1ZkDN3hx+fD9s7DpUIftYzLgVWslm
 Sdr2/YPddBWDolZFkCvfjemAyZqmLcT+g0HMx2HjbJ+gOYp/I/q4pQgtbwpkKxUu96BT
 Xawmcq1vem8I2fHpf5Ipm+2DdaFPHYBHAG4bjf0yH9oyukIOsz1jQTDggsixj9TT/613
 m0oA==
X-Gm-Message-State: ABy/qLa4ZbnYpuOj/Pyn+KTdoFje9Ioao1kDKvFQHVXhPaBcjT1IY8mv
 m1bkq1c/5UIarEDhN7vcpaZ5zle1ZfDmX/r8wq6yJWrad+i61VYeCJpZDRKyTBIk/dXVNfnbLpJ
 2PWj+wG4mMdX1XJg=
X-Received: by 2002:a0c:f484:0:b0:636:afa1:344e with SMTP id
 i4-20020a0cf484000000b00636afa1344emr11325603qvm.31.1688994926657; 
 Mon, 10 Jul 2023 06:15:26 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGtBVxqHGtdmBzPE9h5LTEgjtH88EPMNYJPDflqfToGs5hVnYZAhflLQAma1QBHUOa4UEOarg==
X-Received: by 2002:a0c:f484:0:b0:636:afa1:344e with SMTP id
 i4-20020a0cf484000000b00636afa1344emr11325591qvm.31.1688994926415; 
 Mon, 10 Jul 2023 06:15:26 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-116.web.vodafone.de.
 [109.43.179.116]) by smtp.gmail.com with ESMTPSA id
 v18-20020a0ca792000000b00635fc10afd6sm5590469qva.70.2023.07.10.06.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 06:15:26 -0700 (PDT)
Message-ID: <5ce378b9-d275-f94d-7ee5-84dd024bccdf@redhat.com>
Date: Mon, 10 Jul 2023 15:15:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 13/21] tests/tcg/s390x: Test MVCRL with a large value in R0
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>
References: <20230710121543.197250-1-thuth@redhat.com>
 <20230710121543.197250-14-thuth@redhat.com>
 <f697c822-8036-d185-cf79-8f71e4dbdee0@linaro.org>
 <c9ea1e35ca0b172db14a2b8cd743a823c540a59d.camel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <c9ea1e35ca0b172db14a2b8cd743a823c540a59d.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.101, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 10/07/2023 15.13, Ilya Leoshkevich wrote:
> On Mon, 2023-07-10 at 14:09 +0100, Richard Henderson wrote:
>> On 7/10/23 13:15, Thomas Huth wrote:
>>> From: Ilya Leoshkevich <iii@linux.ibm.com>
>>>
>>> Add a small test to prevent regressions.
>>>
>>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>> Message-Id: <20230704081506.276055-13-iii@linux.ibm.com>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>    tests/tcg/s390x/mie3-mvcrl.c | 46 ++++++++++++++++++++++++++++---
>>> -----
>>>    1 file changed, 36 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/tests/tcg/s390x/mie3-mvcrl.c b/tests/tcg/s390x/mie3-
>>> mvcrl.c
>>> index 93c7b0a290..ec78dd1d49 100644
>>> --- a/tests/tcg/s390x/mie3-mvcrl.c
>>> +++ b/tests/tcg/s390x/mie3-mvcrl.c
>>> @@ -1,29 +1,55 @@
>>> +#include <stdbool.h>
>>>    #include <stdint.h>
>>> +#include <stdlib.h>
>>>    #include <string.h>
>>>    
>>> -
>>> -static inline void mvcrl_8(const char *dst, const char *src)
>>> +static void mvcrl(const char *dst, const char *src, size_t len)
>>>    {
>>> +    register long r0 asm("r0") = len;
>>> +
>>>        asm volatile (
>>> -        "llill %%r0, 8\n"
>>>            ".insn sse, 0xE50A00000000, 0(%[dst]), 0(%[src])"
>>> -        : : [dst] "d" (dst), [src] "d" (src)
>>> -        : "r0", "memory");
>>> +        : : [dst] "d" (dst), [src] "d" (src), "r" (r0)
>>> +        : "memory");
>>>    }
>>>    
>>> -
>>> -int main(int argc, char *argv[])
>>> +static bool test(void)
>>>    {
>>>        const char *alpha = "abcdefghijklmnop";
>>>    
>>>        /* array missing 'i' */
>>> -    char tstr[17] = "abcdefghjklmnop\0" ;
>>> +    char tstr[17] = "abcdefghjklmnop\0";
>>>    
>>>        /* mvcrl reference use: 'open a hole in an array' */
>>> -    mvcrl_8(tstr + 9, tstr + 8);
>>> +    mvcrl(tstr + 9, tstr + 8, 8);
>>>    
>>>        /* place missing 'i' */
>>>        tstr[8] = 'i';
>>>    
>>> -    return strncmp(alpha, tstr, 16ul);
>>> +    return strncmp(alpha, tstr, 16ul) == 0;
>>> +}
>>> +
>>> +static bool test_bad_r0(void)
>>> +{
>>> +    char src[256];
>>> +
>>> +    /*
>>> +     * PoP says: Bits 32-55 of general register 0 should contain
>>> zeros;
>>> +     * otherwise, the program may not operate compatibly in the
>>> future.
>>> +     *
>>> +     * Try it anyway in order to check whether this would crash
>>> QEMU itself.
>>> +     */
>>> +    mvcrl(src, src, (size_t)-1);
>>> +
>>> +    return true;
>>> +}
>>
>> gcc 11 doesn't like this:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/4623964826#L3921
>>
>> /home/gitlab-runner/builds/E8PpwMky/0/qemu-
>> project/qemu/tests/tcg/s390x/mie3-mvcrl.c: In
>> function ‘test_bad_r0’:
>> /home/gitlab-runner/builds/E8PpwMky/0/qemu-
>> project/qemu/tests/tcg/s390x/mie3-mvcrl.c:42:5:
>> error: ‘src’ may be used uninitialized [-Werror=maybe-uninitialized]
>>      42 |     mvcrl(src, src, (size_t)-1);
>>         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> /home/gitlab-runner/builds/E8PpwMky/0/qemu-
>> project/qemu/tests/tcg/s390x/mie3-mvcrl.c:6:13:
>> note: by argument 1 of type ‘const char *’ to ‘mvcrl’ declared here
>>       6 | static void mvcrl(const char *dst, const char *src, size_t
>> len)
>>         |             ^~~~~
>> /home/gitlab-runner/builds/E8PpwMky/0/qemu-
>> project/qemu/tests/tcg/s390x/mie3-mvcrl.c:34:10:
>> note: ‘src’ declared here
>>      34 |     char src[256];
>>         |          ^~~
>> /home/gitlab-runner/builds/E8PpwMky/0/qemu-
>> project/qemu/tests/tcg/s390x/mie3-mvcrl.c:42:5:
>> error: ‘src’ may be used uninitialized [-Werror=maybe-uninitialized]
>>      42 |     mvcrl(src, src, (size_t)-1);
>>         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> /home/gitlab-runner/builds/E8PpwMky/0/qemu-
>> project/qemu/tests/tcg/s390x/mie3-mvcrl.c:6:13:
>> note: by argument 2 of type ‘const char *’ to ‘mvcrl’ declared here
>>       6 | static void mvcrl(const char *dst, const char *src, size_t
>> len)
>>         |             ^~~~~
>> /home/gitlab-runner/builds/E8PpwMky/0/qemu-
>> project/qemu/tests/tcg/s390x/mie3-mvcrl.c:34:10:
>> note: ‘src’ declared here
>>      34 |     char src[256];
>>         |          ^~~
>> cc1: all warnings being treated as errors
>>
>> How it sees any use of the structure, initialized or otherwise, I
>> don't know -- it's all
>> hidden within the asm.  However, src[256] = { } is enough to silence
>> the error.
>>
>>
>> r~
> 
> Thanks for having a look at this. I assume you applied this fixup, and
> I don't need to send a follow-up patch?

No need to respin the patch, I'll fix it up and send a v2 pull request.

  Thomas



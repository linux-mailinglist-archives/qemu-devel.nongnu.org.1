Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B47766EDE
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 15:55:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPNie-0007S5-MP; Fri, 28 Jul 2023 09:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPNib-0007Rr-CU
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:41:21 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPNiZ-00083A-Tl
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:41:21 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bba04b9df3so16515355ad.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 06:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690551678; x=1691156478;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bI8eA/IrdDp/EIcBD/HQyR8ZB4pmx0M5NZvazyQwLbc=;
 b=uzY41kTiHI87ceqZ0rRe2920gVXb4k2w9TFMHJnt6Fu4uQ24bbL41bFAgSQJzYnew+
 AwYpv/TNux74nAOhuJ/GQC/7naAxF1FCeZx7Ul24v93PoPUBXji3ZRRmq6qFUYCw9iaT
 D33jjpfL96ikMeMBaxoa4bPNkcbgl0bsBiOi/X0qVED6wrwV+T7BwsqSr5EW2pIkzKQP
 /CIJrjXm8cKIagHTA1xf2rRPGs/qXK1NZx5RUeEZr7J29v5W8yPkPuoyuWSXBnLn8e3b
 HEvtmC/zo/A2+JTBJoqXArFeoIsHb2MGiWtgsAfd5ciLPkR5S/qrSW/UyqKvH5cmOckH
 /2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690551678; x=1691156478;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bI8eA/IrdDp/EIcBD/HQyR8ZB4pmx0M5NZvazyQwLbc=;
 b=Cj8xS18DYVO7G9eQi5oxMNgcZN7tT17v+0t3/iIhV0qDt4/mEmMjri7G55inQY+BOd
 bryitTxj78pw2c0JqzpWdCOYbA5MazG3ExrUAm6/QHvKglFN5buSODbtg47RPLQghhht
 Yv3WecLVXy+D58gkpFGob0Z2ntsiKRAair1SoZyTvOyLNAYRvEkQnHUH03U45Ld6XFpm
 M088d5MXiJDp7fJSsaqJ2dybA+cQnyRAeKBNux6zVZmFsQps4ZIbIrvku4k2or9QdCbq
 gOAvZzcUDqDzxkHj5cXjTvvtMYhR7LK7rSnYrvmaY1bMAGL3iNvMc3i93nvmj/dyBEmj
 8FNg==
X-Gm-Message-State: ABy/qLY9oET1VhXwOERDKwxdnYdZqIAm9pFxPd+HjQUOPJebXZqYuw/x
 vkOqIXeZG5fbSSxMgNN+5qSu7w==
X-Google-Smtp-Source: APBJJlHvhsxny34nBoo7m98Z24/mR+RNl/4drX8KJw4iSd36OJVkaa2Cl8Wjqv7DlDz+Bnb6thOWUQ==
X-Received: by 2002:a17:903:18f:b0:1b8:10a:d925 with SMTP id
 z15-20020a170903018f00b001b8010ad925mr2089135plg.5.1690551678450; 
 Fri, 28 Jul 2023 06:41:18 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a170902ee8900b001bbd8cf6b57sm3584763pld.230.2023.07.28.06.41.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 06:41:17 -0700 (PDT)
Message-ID: <3f2d28ff-8746-b7fb-d2ee-0d8e08403281@linaro.org>
Date: Fri, 28 Jul 2023 06:41:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] bsd-user: Specify host page alignment if none specified
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>
References: <20230728035456.99066-1-imp@bsdimp.com>
 <10ae7649-7712-9884-0604-645cb12068aa@linaro.org>
In-Reply-To: <10ae7649-7712-9884-0604-645cb12068aa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 7/28/23 06:34, Richard Henderson wrote:
> On 7/27/23 20:54, Warner Losh wrote:
>> We're hitting an assert when we pass in alignment == 0 since that's not
>> a power of two. so pass in the ideal page size.
>>
>> Signed-off-by: Warner Losh <imp@bsdimp.com>
>> ---
>>   bsd-user/mmap.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> r~
> 
>>
>> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
>> index 74ed00b9fe3..e3ce4ab1fc7 100644
>> --- a/bsd-user/mmap.c
>> +++ b/bsd-user/mmap.c
>> @@ -260,7 +260,7 @@ static abi_ulong mmap_find_vma_aligned(abi_ulong start, abi_ulong size,
>>       if (reserved_va) {
>>           return mmap_find_vma_reserved(start, size,
>> -            (alignment != 0 ? 1 << alignment : 0));
>> +            (alignment != 0 ? 1 << alignment : qemu_host_page_size));

Actually, it probably should be MAX(qemu_host_page_size, TARGET_PAGE_SIZE).

Does freebsd currently support any hosts with a page size that is not 4k? It would have 
been true in the past, certainly, but perhaps they've all been deprecated and removed.


r~


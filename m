Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A274572333F
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 00:34:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6IlQ-0005H2-Ej; Mon, 05 Jun 2023 18:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6IlN-0005Gl-Pt
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:33:21 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6IlM-0002jA-49
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 18:33:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f7378a74faso18085415e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 15:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686004398; x=1688596398;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R+EIpdgPErQ0mr256+aQnj0ayvbPI2VmyDy2BwXGhEM=;
 b=QtAsGLOIW/rmgBdFOZ/jxIk0/9qNSa7Y0KW2RK0MKRwi1OyRI9hubYVHoUJnoW16Tg
 8yzGEphnwLtbmjWV5uVQrOeo4xqqOxiObabClGcjpHlE78T5aJKDwqUDm0/51nJb8+5N
 5vS8A3OIRQcCc6DKjy1JZeFflxErjn8AEmPCMCN9SWOfHeI5qG+Xq76g9+yyGxS8mu1J
 YAQP8+uY6wPMQYM4Jz2IJW9LeIqP8Bz7gIfKh0YZP4Rs5msTg6s/mTsqfi5EOi9uR/fT
 6JDAAzrJgPhxbYmJxAtoHlP1mducrDqlkfhw6uRmkv7Gteasl9t9sG0vSZE6EKuu0HvB
 cTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686004398; x=1688596398;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R+EIpdgPErQ0mr256+aQnj0ayvbPI2VmyDy2BwXGhEM=;
 b=NNDQeaBGEF0ik3FxPDQ5qJZAZ6S+iNzRS0c75762w/3McDMXmwRQCRMrv/Ioc+k7nQ
 U5fLOC7ED+qv+7WyGEHaIKO5jUv4QiKl7597PuEGps8mCVu5kFPqyyIxgwSGQIn5YxjQ
 VvrP/duOiNW0RkV8vb/ITOeioriBzOGIb8S30sq8EjudVagTFOjmVL5PYwT7lKbIPRt4
 oH7z+/3kLtYIGHD4UkDJKzwZaH260o/KXTp1X5oc+jmdOU4AE0+2ZY1Cf7YOdMik0CqF
 VFbApW2p2cMZSzeWGCDq63XHmqzfMZpb6IHRmRkGL4weiNSzZgxyYzjHmViSdH7p7mYr
 VRbw==
X-Gm-Message-State: AC+VfDyLo6deROuZJV7kXF7By4I8uiUfuhyyWjgKWApskKzVj+6aXUrx
 A2Sxd0F5/t4n6zV/cCA6R86jk2iuW9Xt1l0l2JM=
X-Google-Smtp-Source: ACHHUZ4P7QaroXu3xTP3hfdQTvR9M7l9GaVxby1WfxAxBO69Ll5mTcVLu+SmHbMxzMwav9XRXh29Gw==
X-Received: by 2002:adf:ff8c:0:b0:30d:d85c:4472 with SMTP id
 j12-20020adfff8c000000b0030dd85c4472mr165477wrr.62.1686004397713; 
 Mon, 05 Jun 2023 15:33:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.187.217.157])
 by smtp.gmail.com with ESMTPSA id
 l7-20020a5d4807000000b003062c0ef959sm10845558wrq.69.2023.06.05.15.33.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 15:33:17 -0700 (PDT)
Message-ID: <b59bde61-4c32-47fc-441d-8196654b7f7c@linaro.org>
Date: Tue, 6 Jun 2023 00:33:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] util/cacheflush: Avoid flushing dcache twice when not
 necessary
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20230605195911.96033-1-philmd@linaro.org>
 <4aee6249-c5b2-5d21-c6e5-e995734ae518@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <4aee6249-c5b2-5d21-c6e5-e995734ae518@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 5/6/23 23:56, BALATON Zoltan wrote:
> On Mon, 5 Jun 2023, Philippe Mathieu-Daudé wrote:
>> <libkern/OSCacheControl.h> describes sys_icache_invalidate() as
>> "equivalent to sys_cache_control(kCacheFunctionPrepareForExecution)",
>> having kCacheFunctionPrepareForExecution defined as:
>>
>>  /* Prepare memory for execution.  This should be called
>>   * after writing machine instructions to memory, before
>>   * executing them.  It syncs the dcache and icache. [...]
>>   */
>>
>> Since the dcache is also sync'd, we can avoid the sys_dcache_flush()
>> call when both rx/rw pointers are equal.
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Based-on: <20230605175647.88395-2-philmd@linaro.org>
>> ---
>> util/cacheflush.c | 9 ++++++++-
>> 1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/util/cacheflush.c b/util/cacheflush.c
>> index de35616718..a08906155a 100644
>> --- a/util/cacheflush.c
>> +++ b/util/cacheflush.c
>> @@ -241,7 +241,14 @@ static void __attribute__((constructor)) 
>> init_cache_info(void)
>>
>> void flush_idcache_range(uintptr_t rx, uintptr_t rw, size_t len)
>> {
>> -    sys_dcache_flush((void *)rw, len);
>> +    if (rx == rw) {
> 
> Isn't it more straight forward to use rx != rw and drop the else branch 
> than having an empty if branch? You can still keep the comment above the 
> if to explain it if needed.

I tried that first but found it was not obvious, so chose this
form because it seemed clearer to me.


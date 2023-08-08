Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D817739F8
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 13:58:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTLLe-0001p9-Hd; Tue, 08 Aug 2023 07:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qTLLQ-0001iV-TS
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:57:50 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qTLLO-0001Sy-3S
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 07:57:48 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-68706b39c4cso3866418b3a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 04:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691495864; x=1692100664;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UbwlImTuQaJJ3lOdexlCLfaF/gkbAhmwW4i+ViBfsgA=;
 b=2+GUlz7rNRcV1F4j/goJP7Z4y0vta3wxJI2qceDIlTUY9uhV6s/c9B1bOLaGSohE3o
 Me5WRnW5gdsTi43U0n55ogskVm4KVkOS2r6JGOzE/DZzF8anaCiyMF/MEmNTHm27CTre
 mtFheyPL0lVXY8QmrtrKNGlMGF39sDVLqkXO8htZpB76EofCKFhpkHD6H2xs7egu1L/o
 YATyJNn5sCpo62uLFwdrg5cFNOVAlPP7KzkfFL5DZzpOaDyXP4vZssFrPrBrttJzBvfY
 79LnMk+qmgZHcjdgqHeg6TvqaJweFZg0lFQaUAQOfrhbmxSb7sd2FfjojWZk3avTzDsB
 mMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691495864; x=1692100664;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UbwlImTuQaJJ3lOdexlCLfaF/gkbAhmwW4i+ViBfsgA=;
 b=XfzbDgY8yOnBtKesyPLQKETzr/ThBxZ+qmUfHx5hmnhF4N+lpOaQw6aJcbW97DeGz9
 CvYLzO7a/gZlOZifHR68jOE2xyhprxcbt7ic7LO53e6T91GTvdEkh8ia9pfS6+uGHRMp
 vNFWw+abILJPCpJ/ynBcV0S9BIT4D4TxV4nbhdTfvH9oUY2KstlLr5qGLpUPERakKpgr
 HI7pbyUKyZlSaujCcOMQ+0Ajnk1VyGMysdKEgp/64kcjoYKVhVfO0kzeAVpjaoKz10SB
 KGzkDYUMZPXg+v1ry6w5202CaL20x/XmUbSxwAIDOndZuLc8oHT9KbHSeZY0f6WngiMo
 hu3g==
X-Gm-Message-State: AOJu0Yyxsvgjy8c9zfoOdsduSc58sJ6HLCbhveNcdBxvsvL7T4hy0Yya
 45cFsSIdT7G35SfjvwndLd1iyw==
X-Google-Smtp-Source: AGHT+IFVmsCogAFWyexBVUz4l5eB3jdN9DvuBidyu3PholXkey0Us9EqxEri0HFSfmZKyybRnnbFaw==
X-Received: by 2002:a05:6a20:7f82:b0:12e:98a3:77b7 with SMTP id
 d2-20020a056a207f8200b0012e98a377b7mr13785598pzj.59.1691495864476; 
 Tue, 08 Aug 2023 04:57:44 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 k18-20020aa78212000000b00682a839d0aesm7976671pfi.112.2023.08.08.04.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 04:57:44 -0700 (PDT)
Message-ID: <9ad42b10-d1ae-4a60-9185-8f43534b818f@daynix.com>
Date: Tue, 8 Aug 2023 20:57:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.1 v10 04/14] linux-user: Use MAP_FIXED_NOREPLACE for
 initial image mmap
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de, 
 qemu-devel@nongnu.org
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-5-richard.henderson@linaro.org>
 <87o7jh98bt.fsf@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87o7jh98bt.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::431;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/08/08 18:43, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> Use this as extra protection for the guest mapping over
>> any qemu host mappings.
>>
>> Tested-by: Helge Deller <deller@gmx.de>
>> Reviewed-by: Helge Deller <deller@gmx.de>
>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   linux-user/elfload.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>> index 36e4026f05..1b4bb2d5af 100644
>> --- a/linux-user/elfload.c
>> +++ b/linux-user/elfload.c
>> @@ -3147,8 +3147,11 @@ static void load_elf_image(const char *image_name, int image_fd,
>>       /*
>>        * Reserve address space for all of this.
>>        *
>> -     * In the case of ET_EXEC, we supply MAP_FIXED so that we get
>> -     * exactly the address range that is required.
>> +     * In the case of ET_EXEC, we supply MAP_FIXED_NOREPLACE so that we get
>> +     * exactly the address range that is required.  Without reserved_va,
>> +     * the guest address space is not isolated.  We have attempted to avoid
>> +     * conflict with the host program itself via probe_guest_base, but using
>> +     * MAP_FIXED_NOREPLACE instead of MAP_FIXED provides an extra check.
>>        *
>>        * Otherwise this is ET_DYN, and we are searching for a location
>>        * that can hold the memory space required.  If the image is
>> @@ -3160,7 +3163,7 @@ static void load_elf_image(const char *image_name, int image_fd,
>>        */
>>       load_addr = target_mmap(loaddr, (size_t)hiaddr - loaddr + 1, PROT_NONE,
>>                               MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
>> -                            (ehdr->e_type == ET_EXEC ? MAP_FIXED : 0),
>> +                            (ehdr->e_type == ET_EXEC ? MAP_FIXED_NOREPLACE : 0),
>>                               -1, 0);
> 
> We should probably also check the result == load_addr for the places
> where MAP_FIXED_NOREPLACE isn't supported as we have this in osdep.h:
> 
>    #ifndef MAP_FIXED_NOREPLACE
>    #define MAP_FIXED_NOREPLACE 0
>    #endif
> 
> See 2667e069e7 (linux-user: don't use MAP_FIXED in pgd_find_hole_fallback)

It assumes target_mmap() emulates MAP_FIXED_NOREPLACE when the host does 
not support it as commit e69e032d1a ("linux-user: Use 
MAP_FIXED_NOREPLACE for do_brk()") already does, but defining 
MAP_FIXED_NOREPLACE zero breaks such emulation. I wrote a fix:
https://patchew.org/QEMU/20230808115242.73025-1-akihiko.odaki@daynix.com/

> 
>>       if (load_addr == -1) {
>>           goto exit_mmap;
> 
> 


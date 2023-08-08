Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E4C773AF1
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:17:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTOSE-0000Z3-IO; Tue, 08 Aug 2023 11:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qTOSC-0000Oy-BR
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:17:00 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qTOS9-000102-2E
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:17:00 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-686ed1d2594so5560983b3a.2
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 08:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691507815; x=1692112615;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=90NI735jDQXiKt0vhfRRh6aDYnJq+9w1ku7mfpcoHLs=;
 b=yOkr9qaN7y7otNakCMCY6VbSOg00q0AdSHQk5er3fQge8FTzVg36gkJNuP4ONeWGBg
 Lt6YaHPLjhaTSWzzBRVOpHUEmYeieR3sNrnPlclUQlgXq2KY71MBs4csgXjufeoyP57l
 +w71kEXp+A4oExyF+8n1jTshyKE9e9mnDq7AEW6GxRel28Pw/Z3+hyzrRzF7phQLNicm
 7qvoXgtsfzhmsHq6ZP0Uwfxj1oN69yK+nJiRT/Tqh+STLiWwSkqje3QvGXeGWhuxhpov
 fANUFhgMXIKsZn4BWLosezZOm5ch4w3hmhEV4RaWoWGEKg5bgE1l67eTUc9uI9FuPMdD
 vzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691507815; x=1692112615;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=90NI735jDQXiKt0vhfRRh6aDYnJq+9w1ku7mfpcoHLs=;
 b=JF3/8Zu6/shIj03OSDPITt3WBL3gqO4gSchkWdoUjLdL78h24S4eZvolDm2M88kKkg
 ceWdbdkIS2qTHzsUovEgpO5Kg5mnq2Xch24zfKFc+mp5m8LkuO20wjb//rkaNfDcIF1u
 I19Cj8pSbnGQoWof/33MSuCJTeZ0EQUC3KQNL/n/XgGZGUST4LJnjB5NpK+3QA7uGB1G
 bC0xY3wBzRwCanBq7DN3cHpJpFfMOrddvZsX9OwoaaCWnmv+6weusNOdkvTIW5e8l6jQ
 KcGhpr8HV9qRpa33HrdczRgRdMvTxtU/U2gHeFWcKyncn0n7K/Nzy+vdvLsMvN13kXyS
 4gxg==
X-Gm-Message-State: AOJu0YyQESPkZMxWmuRi1kZB03oqDgK9C39eAGjZlDFOPSvqxzmRjujH
 GXBX6CdEV+k20HUTG/KlReefaw==
X-Google-Smtp-Source: AGHT+IGxZtJc1iUIA7L0eOdH/lE8qAZz5UGcykx2TYUKBsv4l0ynSN1Ns3LLVDyfXNWqmLCv+MPyrQ==
X-Received: by 2002:a05:6a20:1399:b0:137:53d1:405 with SMTP id
 hn25-20020a056a20139900b0013753d10405mr13172622pzc.26.1691507815288; 
 Tue, 08 Aug 2023 08:16:55 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a62ed06000000b006833bcc95b0sm8232275pfh.115.2023.08.08.08.16.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 08:16:54 -0700 (PDT)
Message-ID: <5e416a73-365e-407d-98fa-3b48be20045d@daynix.com>
Date: Wed, 9 Aug 2023 00:16:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.1] linux-user: Define real MAP_FIXED_NOREPLACE value
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pbonzini@redhat.com, philmd@linaro.org, laurent@vivier.eu, deller@gmx.de,
 qemu-devel@nongnu.org
References: <20230808115242.73025-1-akihiko.odaki@daynix.com>
 <637ce4c6-9ac6-0bb2-aedb-632f79777902@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <637ce4c6-9ac6-0bb2-aedb-632f79777902@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::429;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x429.google.com
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

On 2023/08/08 23:42, Richard Henderson wrote:
> On 8/8/23 04:52, Akihiko Odaki wrote:
>> do_brk() assumes target_mmap() emulates MAP_FIXED_NOREPLACE even when
>> the host does not support it. However, such emulation is not possible
>> if MAP_FIXED_NOREPLACE is defined as zero.
>>
>> Define MAP_FIXED_NOREPLACE with the real value instead of zero if it is
>> not defined.
>>
>> Fixes: e69e032d1a ("linux-user: Use MAP_FIXED_NOREPLACE for do_brk()")
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   include/qemu/osdep.h | 8 ++++++--
>>   linux-user/elfload.c | 1 -
>>   2 files changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
>> index cc61b00ba9..1aac17ec2f 100644
>> --- a/include/qemu/osdep.h
>> +++ b/include/qemu/osdep.h
>> @@ -289,8 +289,12 @@ void QEMU_ERROR("code path is reachable")
>>   #ifndef MAP_ANONYMOUS
>>   #define MAP_ANONYMOUS MAP_ANON
>>   #endif
>> -#ifndef MAP_FIXED_NOREPLACE
>> -#define MAP_FIXED_NOREPLACE 0
>> +#if defined(__linux__) && !defined(MAP_FIXED_NOREPLACE)
>> +#if HOST_ALPHA
> 
> HOST_ALPHA is not a thing.  Also, see
> 
> https://lore.kernel.org/qemu-devel/20230808120303.585509-3-pbonzini@redhat.com/
> 
> where host support for Alpha is completely removed.

I sent v2 with the condition HOST_ALPHA replaced with
MAP_HUGETLB == 0x100000.

While Alpha is no longer supported, and linux-user will not work on 
Alpha, code outside linux-user also refers to osdep.h and the build 
script does not actively block building QEMU on an unsupported host so I 
left the definition for Alpha just in case.

> 
> 
>> +#define MAP_FIXED_NOREPLACE 0x200000
>> +#else
>> +#define MAP_FIXED_NOREPLACE 0x100000
>> +#endif
> 
> Which supported hosts do not define this value?  Can we simply remove 
> the fallback?

glibc didn't have this defined until 2.28. The older releases still 
maintained are 2.26, and 2.27, according to:
https://sourceware.org/glibc/wiki/Release

The page says ALT Linux p9 and Ubuntu 18.04 LTS (Bionic Beaver) has 
glibc 2.27.

> 
> 
> r~


Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFC9773AA5
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 16:10:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTNO5-0007a6-F0; Tue, 08 Aug 2023 10:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qTNO3-0007Zu-1O
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:08:39 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qTNNz-0005Jv-JM
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 10:08:38 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-687087d8ddaso5483704b3a.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 07:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691503714; x=1692108514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qO9x+ZqcJDSGHJaxP7fb+ATlt555kFcOXG2PuHo1E7w=;
 b=wZV7JuZl3MSHKtHk0hwFUh89g606ZaxMDhf2BZXp1hEb/SmxjTQKYV+SIY6HcOTO5l
 9GP7vQlYMS/WXAAi7HDjAkjkAokrWWQeK0HwF4oPBziklBa8zOQ8euRBFczcv1qlpMOV
 B0bOTdNIIqoUTcASlsXHen7b2sEbhHrREn3DS4Sg+YnsFumF5wk5GKdn5mHAgrqAqFsG
 gNzS6kYKvp/Ml+ocYsGE77S/mSZQa/PhNWgR4CyLcQDZnCbcm58kHc2Qc5A1d0ew3QoI
 dqijaVOtKHRPUv3SUCLgINuKyjcLp9Cs3bfcKmYESDInhWjJH+E7XIHeAkEtvbDKUkQv
 fhwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691503714; x=1692108514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qO9x+ZqcJDSGHJaxP7fb+ATlt555kFcOXG2PuHo1E7w=;
 b=OJZQjBjJzy5AihpFEMfhhCaMWgXZmYUkwI3RdAtke1IPy+otfu/oKuYVonOC6aXuSy
 Bery3aoK9vjkgLJ1d7H0/0aPRkCSAP99ehBegfXuF4Ur6L1FJnHAJ3M6FnWTcoRtloUU
 PplEjP6aLo++vuruCWaNzRem7Xt5cEs5IqTsP6UIXPsXqG7bJ3WWxV729Frq75SDXtuk
 pTjIDSjyUdEhkboQlN+y4MZFk+z7VVfgYJj8D7mCK8mQnKRc+5ACEY51otHnl2kKSQT5
 t3PpdmkWWCkcJweAOdJS+e5QP3jeu1O+P8do2A/qZlfhR/gOyZAAOH3S3hjBWdbaA7uN
 3sXg==
X-Gm-Message-State: AOJu0Yxa9Vsqf0htZhdDcTLsoptpCuPek3NRKZT1fsFP3GXjTSceenhC
 NoXkxpQgIRY2WmjI1ZsQc/8Bpw==
X-Google-Smtp-Source: AGHT+IFccbyiD6OZHr09/pyRm5aZVd12vFGooYQFJnlwA2lWNRy/Z+bxlBumrtgJTUd5KYaydOma5g==
X-Received: by 2002:a05:6a00:1583:b0:687:40d8:8869 with SMTP id
 u3-20020a056a00158300b0068740d88869mr16367138pfk.8.1691503714049; 
 Tue, 08 Aug 2023 07:08:34 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 e25-20020a62aa19000000b00686da0e163bsm8397890pff.11.2023.08.08.07.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 07:08:33 -0700 (PDT)
Message-ID: <3add5703-cbc9-436b-b361-8f593f4718ce@daynix.com>
Date: Tue, 8 Aug 2023 23:08:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.1 v10 04/14] linux-user: Use MAP_FIXED_NOREPLACE for
 initial image mmap
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, pbonzini@redhat.com,
 philmd@linaro.org, laurent@vivier.eu, deller@gmx.de, qemu-devel@nongnu.org
References: <20230807163705.9848-1-richard.henderson@linaro.org>
 <20230807163705.9848-5-richard.henderson@linaro.org>
 <87o7jh98bt.fsf@linaro.org> <9ad42b10-d1ae-4a60-9185-8f43534b818f@daynix.com>
 <87pm3x7iem.fsf@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87pm3x7iem.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
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

On 2023/08/08 22:48, Alex Bennée wrote:
> 
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2023/08/08 18:43, Alex Bennée wrote:
>>> Richard Henderson <richard.henderson@linaro.org> writes:
>>>
>>>> Use this as extra protection for the guest mapping over
>>>> any qemu host mappings.
>>>>
>>>> Tested-by: Helge Deller <deller@gmx.de>
>>>> Reviewed-by: Helge Deller <deller@gmx.de>
>>>> Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>    linux-user/elfload.c | 9 ++++++---
>>>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
>>>> index 36e4026f05..1b4bb2d5af 100644
>>>> --- a/linux-user/elfload.c
>>>> +++ b/linux-user/elfload.c
>>>> @@ -3147,8 +3147,11 @@ static void load_elf_image(const char *image_name, int image_fd,
>>>>        /*
>>>>         * Reserve address space for all of this.
>>>>         *
>>>> -     * In the case of ET_EXEC, we supply MAP_FIXED so that we get
>>>> -     * exactly the address range that is required.
>>>> +     * In the case of ET_EXEC, we supply MAP_FIXED_NOREPLACE so that we get
>>>> +     * exactly the address range that is required.  Without reserved_va,
>>>> +     * the guest address space is not isolated.  We have attempted to avoid
>>>> +     * conflict with the host program itself via probe_guest_base, but using
>>>> +     * MAP_FIXED_NOREPLACE instead of MAP_FIXED provides an extra check.
>>>>         *
>>>>         * Otherwise this is ET_DYN, and we are searching for a location
>>>>         * that can hold the memory space required.  If the image is
>>>> @@ -3160,7 +3163,7 @@ static void load_elf_image(const char *image_name, int image_fd,
>>>>         */
>>>>        load_addr = target_mmap(loaddr, (size_t)hiaddr - loaddr + 1, PROT_NONE,
>>>>                                MAP_PRIVATE | MAP_ANON | MAP_NORESERVE |
>>>> -                            (ehdr->e_type == ET_EXEC ? MAP_FIXED : 0),
>>>> +                            (ehdr->e_type == ET_EXEC ? MAP_FIXED_NOREPLACE : 0),
>>>>                                -1, 0);
>>> We should probably also check the result == load_addr for the places
>>> where MAP_FIXED_NOREPLACE isn't supported as we have this in osdep.h:
>>>     #ifndef MAP_FIXED_NOREPLACE
>>>     #define MAP_FIXED_NOREPLACE 0
>>>     #endif
>>> See 2667e069e7 (linux-user: don't use MAP_FIXED in
>>> pgd_find_hole_fallback)
>>
>> It assumes target_mmap() emulates MAP_FIXED_NOREPLACE when the host
>> does not support it as commit e69e032d1a ("linux-user: Use
>> MAP_FIXED_NOREPLACE for do_brk()") already does, but defining
>> MAP_FIXED_NOREPLACE zero breaks such emulation. I wrote a fix:
>> https://patchew.org/QEMU/20230808115242.73025-1-akihiko.odaki@daynix.com/
> 
> Hmm doesn't that push the problem to real mmap() calls to a host system
> that doesn't support MAP_FIXED_NOREPLACE?

That can happen even without that patch if you run QEMU built with a new 
libc on old Linux so we should have prepared for that kind of situation.

The man page also says:
 > Note that older kernels which do not recognize the MAP_FIXED_NOREPLACE
 > flag will typically (upon detecting a collision with a preexisting
 > mapping) fall back to a “non-MAP_FIXED” type of behavior: they will
 > return an address that is different from the requested address.
 > Therefore, backward-compatible software should check the returned
 > address against the requested address.
https://man7.org/linux/man-pages/man2/mmap.2.html

It basically means MAP_FIXED_NOREPLACE has no effect on a host that 
doesn't support it, and the existing code checking the returned address 
should continue to work.

> 
> I wonder if we need an internal flag rather than overloading the host
> flags?


> 
>>
>>>
>>>>        if (load_addr == -1) {
>>>>            goto exit_mmap;
>>>
> 
> 

